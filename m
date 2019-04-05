Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60461C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A27E206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe2QO1yQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDEUId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:08:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38914 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfDEUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:08:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so6305237ljg.6;
        Fri, 05 Apr 2019 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EQOd1o7JUYVzmS4wkZr3W43/aO7808xRjP9b1QMGKjY=;
        b=pe2QO1yQPdCdvurbjgiK/hAvebK++kThMV1YzwCx2IJv2VaFD4ECHqqgCeVGfg+RBy
         n79s65d+0HvpiMMApiMTu3mcK5694BIiFcgwiCdgq5krClPPUhxDQY2KSEKRMXZl8syb
         HBX5G2itH0TEWnBjUmZtW2vBpyx+DhG5yLRqSGdr5jftIXH6eoxFX7+9K0d74h/pTZ5Z
         jVOT9GhXqxYpOuS2kC3t8hU69kePqWBUi55XA3dVNmuKL5fluc8rDbEpqFW8FhoRXp55
         Q0/EelkvjGjOV3s2R5aM6TWZI5y3HANb6wGHpB3GlGKrzxhz0KZdUe4DAQUDgM7CRG29
         fIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EQOd1o7JUYVzmS4wkZr3W43/aO7808xRjP9b1QMGKjY=;
        b=PuHGVbh5T0r72mkeKUOP7Ox72Rbq5pu/yqfT+AnZGB5SDRaaYHBYOgxtMgHdIS/3pU
         WAUYfROZZs8hNV9cbvNFB2Z5tqLacv+yN+9ata4Tn7MSKd+k0UVRJ+pBGGqcp6u/K6Bv
         VWFAhzNBnhHee4d1T9nscaUBr4uzVkKvOouybdtV1J3iZUsOyHFAGuBkRf0vHarQIU51
         PLNBgfRa8wIKRvtcZZ1TUvWpKc9sYhhB93SwkyQqaSNk9XFjI08Lgg1/wsBsZhyNjHK/
         wZ+/c2kjKVhp1QTJrxbWzZ+oC2NTA6dFgava90ywgB9hVy4lqxu7gD+vDYXgrFUjLJM3
         rYTQ==
X-Gm-Message-State: APjAAAXuzX3GrtE1GsTRfNx7mXBCVRunXzMW05lBwQJ+XPywxYlGjiBp
        OF9Pwg+AiNDvKggRntfsApc=
X-Google-Smtp-Source: APXvYqzY0/QvRAbst4ilGGGUBbwKBgldkwbkn0+GYx8/acz+eWRkwYTZVqfHJ/qFmpGPiXv1zXF7cA==
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr7974088lji.94.1554494910154;
        Fri, 05 Apr 2019 13:08:30 -0700 (PDT)
Received: from [192.168.1.19] (bga218.neoplus.adsl.tpnet.pl. [83.28.64.218])
        by smtp.gmail.com with ESMTPSA id f25sm4061290lfk.69.2019.04.05.13.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 13:08:29 -0700 (PDT)
Subject: Re: [PATCH v3 05/25] leds: core: Add support for composing LED class
 device names
To:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
 <20190331175501.23471-6-jacek.anaszewski@gmail.com>
 <eda766d7-3974-0e1f-3025-59c0aa840b14@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <d7cc2c82-db99-c9a0-dc09-474b6a213865@gmail.com>
Date:   Fri, 5 Apr 2019 22:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <eda766d7-3974-0e1f-3025-59c0aa840b14@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the review.

On 4/5/19 1:45 PM, Dan Murphy wrote:
> Jacek
> 
> On 3/31/19 12:54 PM, Jacek Anaszewski wrote:
>> Add generic support for composing LED class device name basing on
>> fwnode_handle data. The function composes device name according to
>> either a new <color:function> pattern or the legacy
>> <devicename:color:function> pattern. The decision on using the
>> particular pattern is made basing on whether fwnode contains new
>> "function" and "color" properties, or the legacy "label" proeprty.
>>
>> Backward compatibility with in-driver hard-coded LED class device
>> names is assured thanks to the default_label and led_hw_name properties
>> of newly introduced struct led_init_data.
>>
>> In case none of the aforementioned properties was found, then, for OF
>> nodes, the node name is adopted for LED class device name.
>>
>> At the occassion of amending the Documentation/leds/leds-class.txt
>> unify spelling: colour -> color.
>>
>> Alongside these changes added is a new tool - tools/leds/get_led_device_info.sh.
>> The tool allows retrieving details of a LED class device's parent device,
>> which proves that getting rid of a devicename section from LED name pattern
>> is justified since this information is already available in sysfs.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linaro.org>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Dan Murphy <dmurphy@ti.com>
>> Cc: Daniel Mack <daniel@zonque.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Simon Shields <simon@lineageos.org>
>> ---
>>   Documentation/leds/leds-class.txt | 27 +++++++++--
>>   drivers/leds/led-class.c          | 29 ++++++++++--
>>   drivers/leds/led-core.c           | 96 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/leds.h              | 43 ++++++++++++++++++
>>   tools/leds/get_led_device_info.sh | 81 +++++++++++++++++++++++++++++++++
>>   5 files changed, 270 insertions(+), 6 deletions(-)
>>   create mode 100755 tools/leds/get_led_device_info.sh
>>
>> diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/leds-class.txt
>> index 8b39cc6b03ee..11e19c3c2e4d 100644
>> --- a/Documentation/leds/leds-class.txt
>> +++ b/Documentation/leds/leds-class.txt
>> @@ -43,14 +43,35 @@ LED Device Naming
>>   
>>   Is currently of the form:
>>   
>> -"devicename:colour:function"
>> -
>> -There have been calls for LED properties such as colour to be exported as
>> +"color:function"
>> +
>> +There might be still LED class drivers around using "devicename:color:function"
>> +naming pattern, but the "devicename" section is now deprecated since it used
>> +to convey information that was already available in the sysfs, like product
>> +name. There is a tool (tools/leds/get_led_device_info.sh) available for
>> +retrieving that information per a LED class device.
>> +
>> +Associations with other devices, like network ones, should be defined
>> +via LED trigger mechanism. This approach is applied by some of wireless
>> +network drivers that create triggers dynamically and incorporate phy
>> +name into the trigger name. On the other hand input subsystem offers LED - input
>> +bridge (drivers/input/input-leds.c) for exposing keyboard LEDs as LED class
>> +devices. The get_led_device_info.sh script has support for retrieving related
>> +input device node name. Should it support discovery of associations between
>> +LEDs and other subsystems, please don't hesitate to submit a relevant patch.
>> +
>> +There have been calls for LED properties such as color to be exported as
>>   individual led class attributes. As a solution which doesn't incur as much
>>   overhead, I suggest these become part of the device name. The naming scheme
>>   above leaves scope for further attributes should they be needed. If sections
>>   of the name don't apply, just leave that section blank.
>>   
>> +Please also keep in mind that LED subsystem has a protection against LED name
>> +conflict. It adds numerical suffix (e.g. "_1", "_2", "_3" etc.) to the requested
>> +LED class device name in case it is already in use. In order to prevent LED core
>> +from assigning these suffixes in an arbitrary order the led-enumerator fwnode
>> +property can be used for differentiation of LEDs that share common function
>> +and/or color. In this case enumerators will be prepended with "-" character.
>>   
>>   Brightness setting API
>>   ======================
>> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
>> index 2f09156b0c63..bfd46a9bba63 100644
>> --- a/drivers/leds/led-class.c
>> +++ b/drivers/leds/led-class.c
>> @@ -26,6 +26,18 @@
>>   
>>   static struct class *leds_class;
>>   
>> +const char *led_colors[LED_COLOR_ID_COUNT] = {
>> +	[LED_COLOR_ID_WHITE] = "white",
>> +	[LED_COLOR_ID_RED] = "red",
>> +	[LED_COLOR_ID_GREEN] = "green",
>> +	[LED_COLOR_ID_BLUE] = "blue",
>> +	[LED_COLOR_ID_AMBER] = "amber",
>> +	[LED_COLOR_ID_VIOLET] = "violet",
>> +	[LED_COLOR_ID_YELLOW] = "yellow",
>> +	[LED_COLOR_ID_IR] = "ir",
>> +};
>> +EXPORT_SYMBOL_GPL(led_colors);
>> +
> 
> Why is this exported when it is only used here?
> 
> I can re-use this array for the multi color framework so I don't oppose it being exported.

I did that specifically for that purpose :-)

> Reviewed-by: Dan Murphy <dmurphy@ti.com>

Thanks!

-- 
Best regards,
Jacek Anaszewski
