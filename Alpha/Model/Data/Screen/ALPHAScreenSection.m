//
//  ALPHAScreenSection.m
//  Alpha
//
//  Created by Dal Rupnik on 20/05/15.
//  Copyright (c) 2015 Unified Sense. All rights reserved.
//

#import "ALPHAScreenSection.h"
#import "ALPHAScreenItem.h"

@implementation ALPHAScreenSection

+ (instancetype)screenSectionWithDictionary:(NSDictionary *)dictionary
{
    ALPHAScreenSection* section = [[ALPHAScreenSection alloc] init];
    
    NSNumber* style = nil;
    
    for (NSString* key in dictionary)
    {
        if ([key isEqualToString:@"items"])
        {
            NSMutableArray* items = [NSMutableArray array];
            
            for (id item in dictionary[key])
            {
                ALPHAScreenItem* displayItem = nil;
                
                if ([item isKindOfClass:[ALPHAScreenItem class]])
                {
                    displayItem = item;
                }
                else if ([item isKindOfClass:[NSDictionary class]])
                {
                    displayItem = [[ALPHAScreenItem alloc] init];
                
                    for (NSString* keyItem in item)
                    {
                        displayItem.title = keyItem;
                        displayItem.detail = [item[keyItem] description];
                    }
                }
                else
                {
                    displayItem = [[ALPHAScreenItem alloc] init];
                    displayItem.title = NSStringFromClass([item class]);
                    displayItem.detail = [item description];
                    displayItem.model = item;
                }
                
                if (displayItem)
                {
                    [items addObject:displayItem];
                }
            }
            
            section.items = items;
        }
        else if ([key isEqualToString:@"style"])
        {
            style = dictionary[key];
        }
        else
        {
            // Sets title and identifier
            [section setValue:dictionary[key] forKey:key];
        }
    }
    
    //
    // Handle styles
    //
    
    if (style)
    {
        UITableViewCellStyle cellStyle = (UITableViewCellStyle)style.integerValue;
        
        for (ALPHAScreenItem* item in section.items)
        {
            item.style = cellStyle;
        }
    }
    
    return section;
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    return [self initWithIdentifier:identifier title:nil];
}

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title
{
    self = [super init];
    
    if (self)
    {
        self.identifier = identifier;
        self.title = title;
    }
    
    return self;
}

@end