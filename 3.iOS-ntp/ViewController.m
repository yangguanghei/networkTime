//
//  ViewController.m
//  3.iOS-ntp
//
//  Created by apple on 2020/7/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ViewController.h"

#import <ios-ntp.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSDate * date = [[NetworkClock sharedNetworkClock] networkTime];
//    NSUInteger timestamp = [NSString stringWithFormat:@"%f", [date timeIntervalSince1970] * 1000].integerValue;
//       NSLog(@"timestamp:%lu", timestamp);
//    double offset = [[NetworkClock sharedNetworkClock] networkOffset];
//    NSLog(@"offset:%lf", offset);
    
    NSDate * date = [self getInternetDate];
    NSUInteger timestamp = [NSString stringWithFormat:@"%f", [date timeIntervalSince1970] * 1000].integerValue;
    NSLog(@"%lu", timestamp);
}

- (NSDate *)getInternetDate{
//     NSString *urlString = @"http://m.baidu.com";
    NSString *urlString = @"http://www.baidu.com";
     urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
     [request setURL:[NSURL URLWithString: urlString]];
     [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
     [request setTimeoutInterval: 2];
     [request setHTTPShouldHandleCookies:FALSE];
     [request setHTTPMethod:@"GET"];
      NSHTTPURLResponse *response;
     [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
 
     NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
     date = [date substringFromIndex:5];
     date = [date substringToIndex:[date length]-4];
     NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
     dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
     [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
//    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
     NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:0];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: netDate];
    NSDate *localeDate = [netDate  dateByAddingTimeInterval: interval];
    return localeDate;
}

@end
