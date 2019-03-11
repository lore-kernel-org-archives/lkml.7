Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD705C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9622063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VINdJjca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfCKRWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:22:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46026 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:22:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id o7so6022675wrp.12;
        Mon, 11 Mar 2019 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3mAlpmirNnXcZcWzDnM5E4wH7BKrBluVsbQIwuEkfpg=;
        b=VINdJjcaIADC9SQPgxKTQlHMFWypu25FWtwwaqHO8GSiStDIVX8tF7VvDK9fHMQsFq
         tnYajwFmUlDV21sd3XKHggfJs9veCVW7M9CptXWJPJMOcp9LMOkfOKl9sj1ywjrm+UP3
         RAZZCgJowxzEhbuODlMDIKwvpr0ypiTDOD1psn2Trg5FpYaWdH4DIjs6E6Hn/udiVGLu
         LwyZlWsF1zcHpChpUSKyOdobHY7Ks3UZsjhOjFnQYYkg1QCD2YmMi91FQ1B+RRvgjsdU
         6tHKX+NL6y/Y1Fh77qxqL2wuUgJpazhgffgoD4fclbPYyq/HTCPmstvFYjzXx/pgP81H
         B6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3mAlpmirNnXcZcWzDnM5E4wH7BKrBluVsbQIwuEkfpg=;
        b=qbzmMETt2Mkwa+PAe3bZCti8xJn/7AQJ7sYF4N7BtAQw9fatLbieu+IHPU4IS0Z4Vr
         Qo+hmdYSy/l1EW0e7exmuthXhhtIrGju5jkPLCST+4LJctgJHXAg4AaFVa+Ie68ePzqu
         1PYfTVqWOKrWa8+7ZArLhw42sN1O/JrGBRGZMU9QtPYt1ZfuVFdHEmSxEO5NLq8I+0Y6
         4y1lZr+/DG6PQEE5wSAvBUeoAj6uM8GWwScC/Vy5zXD/ZLgzqrVfFM0BGZyRQvvyV0Z/
         UZH7DdHonh1jVHhhADt/uKNPZMO3WV0vJzmr9QNt+8ohgJVhaZZY83msbQm4FU5pLT6v
         WeWQ==
X-Gm-Message-State: APjAAAUM1Mzz/sMbId4r9iDxwilNgTCNKbXQYeVxgBX73TnZuzykIaVj
        hUcIiiHobttGMaaMIA883UnCSPqV
X-Google-Smtp-Source: APXvYqwhTjb0tvzE4gg5X/Wu3lcAszXEnfCqqR3XfJx4XVWoU+sgXDsj1Cjp5YacQGK9JshQQ//xpw==
X-Received: by 2002:adf:9103:: with SMTP id j3mr20623310wrj.236.1552324965939;
        Mon, 11 Mar 2019 10:22:45 -0700 (PDT)
Received: from [192.168.1.18] (cka136.neoplus.adsl.tpnet.pl. [83.31.76.136])
        by smtp.gmail.com with ESMTPSA id l3sm7081680wrt.62.2019.03.11.10.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 10:22:45 -0700 (PDT)
Subject: Re: [PATCH 03/25] dt-bindings: leds: Add LED_FUNCTION definitions
To:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-4-jacek.anaszewski@gmail.com>
 <ac860282-af12-8a1f-5d85-2f587856d669@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9b02a7fd-3cec-f935-23e0-7c3b1263dbc4@gmail.com>
Date:   Mon, 11 Mar 2019 18:22:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <ac860282-af12-8a1f-5d85-2f587856d669@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for the review.

On 3/11/19 1:22 PM, Dan Murphy wrote:
> Jacek
> 
> On 3/10/19 1:28 PM, Jacek Anaszewski wrote:
>> Add common LED function definitions for use in Device Tree.
>> The function names were extracted from existing dts files
>> after eliminating oddities.
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
>> +#define LED_FUNCTION_ADSL "adsl"
>> +#define LED_FUNCTION_ALARM "alarm"
>> +#define LED_FUNCTION_BACKLIGHT "backlight"
>> +#define LED_FUNCTION_BLUETOOTH "bluetooth"
>> +#define LED_FUNCTION_BOOT "boot"
>> +#define LED_FUNCTION_CHRG "chrg"
> 
> Why not spell out charge?

It was in one of existing dts files.
I have no issue with that, will change it to "charge".

> 
>> +#define LED_FUNCTION_DEBUG "debug"
>> +#define LED_FUNCTION_DISK "disk"
>> +#define LED_FUNCTION_DISK_READ "disk-read"
>> +#define LED_FUNCTION_DISK_WRITE "disk-write"
>> +#define LED_FUNCTION_FAULT "fault"
>> +#define LED_FUNCTION_FLASH "flash"
>> +#define LED_FUNCTION_HDDERR "hdderr"
>> +#define LED_FUNCTION_HEARTBEAT "heartbeat"
>> +#define LED_FUNCTION_INDICATOR "indicator"
>> +#define LED_FUNCTION_INFO "info"
>> +#define LED_FUNCTION_INTERNET "internet"
> 
> LEDs function can be for keyboards and keypads.
> 
> Keypad for hand held devices
> 
> #define LED_FUNCTION_KEYBOARD "keyboard"
> #define LED_FUNCTION_KEYPAD "keypad"

Ack.

> 
>> +#define LED_FUNCTION_LAN "lan"
>> +#define LED_FUNCTION_MMC "mmc"
>> +#define LED_FUNCTION_NAND "nand"
>> +#define LED_FUNCTION_ON "on"
>> +#define LED_FUNCTION_PROGRAMMING "programming"
>> +#define LED_FUNCTION_PWR "pwr"
> 
> Same comment as above on chrg

Ack.

>> +#define LED_FUNCTION_RX "rx"
>> +#define LED_FUNCTION_SD "sd"
>> +#define LED_FUNCTION_SLEEP "sleep"
>> +#define LED_FUNCTION_STANDBY "standby"
>> +#define LED_FUNCTION_STATUS "status"
>> +#define LED_FUNCTION_TORCH "torch"
>> +#define LED_FUNCTION_TV "tv"
>> +#define LED_FUNCTION_TX "tx"
>> +#define LED_FUNCTION_USB "usb"
>> +#define LED_FUNCTION_WAN "wan"
>> +#define LED_FUNCTION_WLAN "wlan"
>> +#define LED_FUNCTION_WPS "wps"
>> +
> 
> Dan
> 
>>   #endif /* __DT_BINDINGS_LEDS_H */
>>
> 
> 

-- 
Best regards,
Jacek Anaszewski
