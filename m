Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192C520811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMLxTlCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfC1UBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:01:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39149 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfC1UBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:01:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so141993wmk.4;
        Thu, 28 Mar 2019 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QbG0n7qd4CrOU2u1jLyR3Yv5vGuKKfhuZSxNp/RnuyY=;
        b=XMLxTlCtrT4uENUptZ94GzDdzkhhtrafdqmaDd8QBUu3TY2+FDhsAALGd196XnDSLQ
         /gGUgv6nbVumKXxAVf0v3BiiyOy/3vrU6sf0x+GxdbxLv6cqBw98z6WXRQOPW0fV0ups
         46UIoU3bSX1RiuXunyyFl9NgLXtag8z9ISpCMf6G0h419voyXomXtIF0Q37IyllBXqOv
         V4x+oyk61jkm322kYxCE2tWxWKIyIKldvpC3yOrrtWTEoNdNFWWUmb/JGD1TAHsw9kE7
         vMPsqXaSLIXUpCv7sH5DI2HTxBoUlXvbieTFoFsK6TnaZtKiv5Lez+DtnvwvH7MNjPnW
         9tYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QbG0n7qd4CrOU2u1jLyR3Yv5vGuKKfhuZSxNp/RnuyY=;
        b=MqcoKhz5uMXobydU9arMqX9whTYTkY22Kttv+gD0vtzS+keRso5miNkhUjxXLto69l
         NRdp7rGHLZYU/hOgTfluZd6A+7stgPi+VnXCUI+eTd/Rz8Etdf8i/QDwkIf/Q77hUbeS
         Lx6xudxuOEKSVmmXZx61hiNJ5QpJxZcjT7QUhvU9TzDdAccrEdsxToRYVL8ZHzlYiwm8
         KMCn/6o13Qg7RKssRahGUkt2mQY8Vsl9gqX1gv/ICnJGSRqwsuUK6eEOLHtFENoZrx7n
         foysghqkugjO+4eo8pHYJWLZQufektDi3tXcjfcW/svoMBd4m6KKGseK3ZbGnzsPAsUe
         MoCg==
X-Gm-Message-State: APjAAAV3BCIRWQIQXOCkbquy995dHJQAe1+B/IJHSNAdhucDUPuRtKxe
        ZX6AXB7dZ8OYJPVBRIY9Uw7zXUiE
X-Google-Smtp-Source: APXvYqwcaAjBhvCCwisfKysJ0+UqhPEC/aHIcovz7fPMAD+01ssTs3airGDMFetHIMkp2acHWYIv4g==
X-Received: by 2002:a1c:ce:: with SMTP id 197mr1093912wma.105.1553803292180;
        Thu, 28 Mar 2019 13:01:32 -0700 (PDT)
Received: from [192.168.1.19] (blb244.neoplus.adsl.tpnet.pl. [83.28.195.244])
        by smtp.gmail.com with ESMTPSA id u8sm13589wrt.69.2019.03.28.13.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 13:01:31 -0700 (PDT)
Subject: Re: [PATCH 03/25] dt-bindings: leds: Add LED_FUNCTION definitions
To:     Rob Herring <robh@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-4-jacek.anaszewski@gmail.com>
 <20190328000357.GA3399@bogus>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <f916ae77-1807-1e06-7dc3-8b956e1c4c39@gmail.com>
Date:   Thu, 28 Mar 2019 21:01:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328000357.GA3399@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review.

On 3/28/19 1:03 AM, Rob Herring wrote:
> On Sun, Mar 10, 2019 at 07:28:14PM +0100, Jacek Anaszewski wrote:
>> Add common LED function definitions for use in Device Tree.
>> The function names were extracted from existing dts files
>> after eliminating oddities.
> 
> I'd like this to be suggestions of what to use rather than what's
> already out there. So my comments are in that context.
> 
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linaro.org>
>> Cc: Daniel Mack <daniel@zonque.org>
>> Cc: Dan Murphy <dmurphy@ti.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Simon Shields <simon@lineageos.org>
>> ---
>>   include/dt-bindings/leds/common.h | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
>> index e171d0a6beb2..ffcd46317307 100644
>> --- a/include/dt-bindings/leds/common.h
>> +++ b/include/dt-bindings/leds/common.h
>> @@ -19,4 +19,42 @@
>>   #define LEDS_BOOST_ADAPTIVE	1
>>   #define LEDS_BOOST_FIXED	2
>>   
>> +/* Standard LED functions */
>> +#define LED_FUNCTION_ACTIVITY "activity"
> 
> of what?

We have activity trigger, which provides instant feedback
on the cpu activity.

This would nicely map to that.

>> +#define LED_FUNCTION_ADSL "adsl"
> 
> wan?

Good point.

>> +#define LED_FUNCTION_ALARM "alarm"
>> +#define LED_FUNCTION_BACKLIGHT "backlight"
>> +#define LED_FUNCTION_BLUETOOTH "bluetooth"
>> +#define LED_FUNCTION_BOOT "boot"
> 
> What about boot?

Is lit when bootloader code is executed?
Turned off just before starting the kernel.

>> +#define LED_FUNCTION_CHRG "chrg"
>> +#define LED_FUNCTION_DEBUG "debug"
>> +#define LED_FUNCTION_DISK "disk"
>> +#define LED_FUNCTION_DISK_READ "disk-read"
>> +#define LED_FUNCTION_DISK_WRITE "disk-write"
>> +#define LED_FUNCTION_FAULT "fault"
>> +#define LED_FUNCTION_FLASH "flash"
>> +#define LED_FUNCTION_HDDERR "hdderr"
> 
> disk-err for consistency?

Ack.

>> +#define LED_FUNCTION_HEARTBEAT "heartbeat"
>> +#define LED_FUNCTION_INDICATOR "indicator"
>> +#define LED_FUNCTION_INFO "info"
> 
> of what?

Right, doesn't make sense alone.

>> +#define LED_FUNCTION_INTERNET "internet"
> 
> Same as wan?

OK, to be removed.

>> +#define LED_FUNCTION_LAN "lan"
>> +#define LED_FUNCTION_MMC "mmc"
> 
> Same as disk?

Not sure. The possibility to have separate LEDs for different types of
mass storage devices could be useful.

>> +#define LED_FUNCTION_NAND "nand"
>> +#define LED_FUNCTION_ON "on"
>> +#define LED_FUNCTION_PROGRAMMING "programming"
>> +#define LED_FUNCTION_PWR "pwr"
>> +#define LED_FUNCTION_RX "rx"
>> +#define LED_FUNCTION_SD "sd"
> 
>> +#define LED_FUNCTION_SLEEP "sleep"
>> +#define LED_FUNCTION_STANDBY "standby"
> 
> Same things?

Ack. Standby feels more technical so I'd remove "sleep".

>> +#define LED_FUNCTION_STATUS "status"
>> +#define LED_FUNCTION_TORCH "torch"
>> +#define LED_FUNCTION_TV "tv"
>> +#define LED_FUNCTION_TX "tx"
>> +#define LED_FUNCTION_USB "usb"
>> +#define LED_FUNCTION_WAN "wan"
>> +#define LED_FUNCTION_WLAN "wlan"
>> +#define LED_FUNCTION_WPS "wps"
>> +
>>   #endif /* __DT_BINDINGS_LEDS_H */
>> -- 
>> 2.11.0
>>
> 

-- 
Best regards,
Jacek Anaszewski
