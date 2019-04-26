Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EBBC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C1D206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+gsWbVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfDZMNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:13:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40687 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDZMNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:13:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so1546405pgl.7;
        Fri, 26 Apr 2019 05:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wD0OjhU7ka4LGT9gkwOuIYoWKFPBcZLGIcvMIyWAXLo=;
        b=k+gsWbVp/E1AMuZ+h9liMTRaJRwfBKbWmAITq2nYGiG9+yr0YJoNv2mc7N06OJRrHp
         NdOLhN0eGjjlvn7Ge4tNWkmVZVRMnODt198NvhKEeWXuAzkvQAJAFlDMtlDMXvcPoqmG
         x5CcjjNsc+oYo7k3/BzNfvjECZKzj2n8SyElNOygXRBoFgEoejSf37XWc4gtie5HmVI4
         zdj+aHILVUx64Ie3CJyfV+5kCLsH9rt8yEpTSiHhhj9apuOp71uURFB7WIR+JGaVM00e
         YfMkaIzZjSW+krkB92hI5JLmKHeILnGleupwomKNH6rGL7Xp2E0ygHg3xwWOnzFwJgt6
         CMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wD0OjhU7ka4LGT9gkwOuIYoWKFPBcZLGIcvMIyWAXLo=;
        b=Mn4r7r2oFxCvfDy1RrfNizTe2TqtXrd8fSnnfl6thrxqH9Ff3rNziyDIJ8zgCLFuFz
         nZCMxQjEVabP1ax9heVXn8l8pjDYt83pjlFPeQOdDW1xgAHJ4MX0sSK8HxHoDQObu/If
         DRHWYOLEbCcK4E2tqbvABG+8tq21OhEC+9QCFr2G5piyV0vHPjHoyKVtfjVF8FghHwyP
         4+YKNxs5oJRB01V0/Es0yenHKRNIxCC2fNldFL0lyt9ul7Asr/bnegPs94RvSXq4v8H7
         nPDWJZWsq0lm8TJPbso5CZ7Cx3wEOMp+R5iUJPx+eSji883QwtfaUJRcGZ7n28K7pdiG
         niag==
X-Gm-Message-State: APjAAAXyFXeTf8NX+FEV9MdwsiNCQou8fq/wXdKRWhZcIatosraHp4Vz
        AChUZ9sSNMVVEmzlXgXEJbDjalCu
X-Google-Smtp-Source: APXvYqzLATIcdHO4qbeKRPCfRJD/mNg05oyIqQRG7PTgHVQsANj62I4vHgFcArCl1z+NpoVT5saMgw==
X-Received: by 2002:a63:f115:: with SMTP id f21mr42885893pgi.65.1556280799877;
        Fri, 26 Apr 2019 05:13:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l184sm51343460pfc.98.2019.04.26.05.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 05:13:18 -0700 (PDT)
Subject: Re: [PATCH] usbnet: ipheth: Simplify device detection
To:     Simon Horman <horms@verge.net.au>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1556128704-10831-1-git-send-email-linux@roeck-us.net>
 <20190426112703.lrceujboxox6no3y@verge.net.au>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <339d6eb5-0534-a455-735f-2abf28d5f509@roeck-us.net>
Date:   Fri, 26 Apr 2019 05:13:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426112703.lrceujboxox6no3y@verge.net.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/19 4:27 AM, Simon Horman wrote:
> On Wed, Apr 24, 2019 at 10:58:24AM -0700, Guenter Roeck wrote:
>> All Apple products use the same protocol for tethering over USB.
>> To simplify the code and make it future proof, use
>> USB_VENDOR_AND_INTERFACE_INFO() instead of
>> USB_DEVICE_AND_INTERFACE_INFO() to automatically detect and support
>> all existing and future Apple products using the same interface.
> 
> What if future Apple products behave differently?
> 

Sure, Apple may decide to use the same device/class/subclass/protocol
identifier for a different protocol. That is unlikely but possible.

If the associated risk is considered higher than the benefit of supporting
new devices announcing the same protocol with a different product id,
please feel free to ignore (or nack) this patch.

Thanks,
Guenter

>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Tested with various iPads and iPhones up to X. iPhone 6 and later
>> up to and including X all use product ID 0x12a8, so this patch is
>> not strictly required, but it does simplify the code.
>>
>>   drivers/net/usb/ipheth.c | 58 +++---------------------------------------------
>>   1 file changed, 3 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
>> index 3d8a70d3ea9b..a01a71a7e48d 100644
>> --- a/drivers/net/usb/ipheth.c
>> +++ b/drivers/net/usb/ipheth.c
>> @@ -54,17 +54,6 @@
>>   #include <linux/workqueue.h>
>>   
>>   #define USB_VENDOR_APPLE        0x05ac
>> -#define USB_PRODUCT_IPHONE      0x1290
>> -#define USB_PRODUCT_IPHONE_3G   0x1292
>> -#define USB_PRODUCT_IPHONE_3GS  0x1294
>> -#define USB_PRODUCT_IPHONE_4	0x1297
>> -#define USB_PRODUCT_IPAD 0x129a
>> -#define USB_PRODUCT_IPAD_2	0x12a2
>> -#define USB_PRODUCT_IPAD_3	0x12a6
>> -#define USB_PRODUCT_IPAD_MINI    0x12ab
>> -#define USB_PRODUCT_IPHONE_4_VZW 0x129c
>> -#define USB_PRODUCT_IPHONE_4S	0x12a0
>> -#define USB_PRODUCT_IPHONE_5	0x12a8
>>   
>>   #define IPHETH_USBINTF_CLASS    255
>>   #define IPHETH_USBINTF_SUBCLASS 253
>> @@ -88,50 +77,9 @@
>>   #define IPHETH_CARRIER_ON       0x04
>>   
>>   static const struct usb_device_id ipheth_table[] = {
>> -	{ USB_DEVICE_AND_INTERFACE_INFO(
>> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE,
>> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
>> -		IPHETH_USBINTF_PROTO) },
>> -	{ USB_DEVICE_AND_INTERFACE_INFO(
>> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_3G,
>> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
>> -		IPHETH_USBINTF_PROTO) },
>> -	{ USB_DEVICE_AND_INTERFACE_INFO(
>> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_3GS,
>> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
>> -		IPHETH_USBINTF_PROTO) },
>> -	{ USB_DEVICE_AND_INTERFACE_INFO(
>> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_4,
>> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
>> -		IPHETH_USBINTF_PROTO) },
>> -	{ USB_DEVICE_AND_INTERFACE_INFO(
>> -		USB_VENDOR_APPLE, USB_PRODUCT_IPAD,
>> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
>> -		IPHETH_USBINTF_PROTO) },
>> -	{ USB_DEVICE_AND_INTERFACE_INFO(
>> -		USB_VENDOR_APPLE, USB_PRODUCT_IPAD_2,
>> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
>> -		IPHETH_USBINTF_PROTO) },
>> -	{ USB_DEVICE_AND_INTERFACE_INFO(
>> -		USB_VENDOR_APPLE, USB_PRODUCT_IPAD_3,
>> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
>> -		IPHETH_USBINTF_PROTO) },
>> -	{ USB_DEVICE_AND_INTERFACE_INFO(
>> -		USB_VENDOR_APPLE, USB_PRODUCT_IPAD_MINI,
>> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
>> -		IPHETH_USBINTF_PROTO) },
>> -	{ USB_DEVICE_AND_INTERFACE_INFO(
>> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_4_VZW,
>> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
>> -		IPHETH_USBINTF_PROTO) },
>> -	{ USB_DEVICE_AND_INTERFACE_INFO(
>> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_4S,
>> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
>> -		IPHETH_USBINTF_PROTO) },
>> -	{ USB_DEVICE_AND_INTERFACE_INFO(
>> -		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_5,
>> -		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
>> -		IPHETH_USBINTF_PROTO) },
>> +	{ USB_VENDOR_AND_INTERFACE_INFO(USB_VENDOR_APPLE, IPHETH_USBINTF_CLASS,
>> +					IPHETH_USBINTF_SUBCLASS,
>> +					IPHETH_USBINTF_PROTO) },
>>   	{ }
>>   };
>>   MODULE_DEVICE_TABLE(usb, ipheth_table);
>> -- 
>> 2.7.4
>>
> 

