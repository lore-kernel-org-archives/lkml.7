Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0840FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66912063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7dSfP+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfCKRYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:24:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33050 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfCKRYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:24:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id z7so4830424lji.0;
        Mon, 11 Mar 2019 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x83RWi4ZpQ1x9oWEF02AnQcjZeY5go3IA4Wy5RTf5Cw=;
        b=B7dSfP+GXBuEr9QUL1IDFCjSVpI+Xlh6jQkXQHIp0U3dJ1TbPzXqyeZW15C99i0Sv9
         8HPZrp1s5xhC6n7MHsk7+/kG8fcB9gtXFCfOxb6VmXfCzMLAiDEMQNVZMb0o4/X8l9J0
         yhOThP1+QC6/W29gZNVRWxm3xCPKzxd/DSsLqA1KtHRVND4WLgZahiJshTLloejbZLN2
         cgIIrxWguy8SJylVH0Ygyq0X1Tmut3fOX9sUSq3eabBaTDzWSDlggyf1jt+gG7IfUnLg
         sWEP031YOTX6Th1FifeVUF1t3X61lGW6iuD/rfpfGkUFl6kkjWv4kSQi5e9YIE3GdhhX
         w+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x83RWi4ZpQ1x9oWEF02AnQcjZeY5go3IA4Wy5RTf5Cw=;
        b=dW32CP7kDDzbvkzyqj56jL3tkUOa+CbtfbHPRESFdz/YDLW0S4f1mzKmJerwnH8uxc
         SteneDf0ryy4Duv7uXH+BCzHvcBpn224pUYF5cqV5g9m+YW08LguC3JvmD515trYigSv
         e3m6StFW8wLeXp4x5zD38xQYmONMbS3EaCMNvkCjYSkWZA8P0t1IfRio0mWCRIEamVAm
         qyOnNZgXHULNgtqd5Kiq6g8wMwQCUnbeSkFJ2VaZzPpZOzrRAxJFPzWcXk9c4IRZOSzX
         Ce1t1BlIVUNp2G3wizvfqd2ttYXJGQ71JW8HvhgKut4AKoB37icdEDCmVpovf9f/MPvM
         dXiQ==
X-Gm-Message-State: APjAAAUBjs3ozDzhMG5c5rhIorNH/eW/8r7Gm8JvqWcGy0DxO3YduX5b
        8eN+ICY8JnDK8EoVVK9MqQg=
X-Google-Smtp-Source: APXvYqyap1TNGzqk2D/8qpVS87SyydFI9wZFBwbCm4jLwWpK19LvFiiu3XYfWooRw4cAy1J08ZrDxQ==
X-Received: by 2002:a2e:9086:: with SMTP id l6mr140894ljg.190.1552325052814;
        Mon, 11 Mar 2019 10:24:12 -0700 (PDT)
Received: from [192.168.1.18] (cka136.neoplus.adsl.tpnet.pl. [83.31.76.136])
        by smtp.gmail.com with ESMTPSA id d5sm1178622lfi.95.2019.03.11.10.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 10:24:12 -0700 (PDT)
Subject: Re: [PATCH 05/25] dt-bindings: leds: Add function and color
 properties
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
 <20190310182836.20841-6-jacek.anaszewski@gmail.com>
 <98c1a41e-77bb-5ffd-b5b3-772a28c0f0a6@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <796a13a7-fb8c-9b5b-6bd5-dfb7458731fe@gmail.com>
Date:   Mon, 11 Mar 2019 18:24:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <98c1a41e-77bb-5ffd-b5b3-772a28c0f0a6@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 3/11/19 1:26 PM, Dan Murphy wrote:
> On 3/10/19 1:28 PM, Jacek Anaszewski wrote:
>> Introduce dedicated properties for conveying information about
>> LED function and color. Mark old "label" property as deprecated.
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
>>   Documentation/devicetree/bindings/leds/common.txt | 55 +++++++++++++++++++----
>>   1 file changed, 47 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
>> index aa1399814a2a..3402b0e1cec9 100644
>> --- a/Documentation/devicetree/bindings/leds/common.txt
>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>> @@ -10,14 +10,23 @@ can influence the way of the LED device initialization, the LED components
>>   have to be tightly coupled with the LED device binding. They are represented
>>   by child nodes of the parent LED device binding.
>>   
>> +
>>   Optional properties for child nodes:
>>   - led-sources : List of device current outputs the LED is connected to. The
>>   		outputs are identified by the numbers that must be defined
>>   		in the LED device binding documentation.
>> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
>> +	    from the header include/dt-bindings/leds/common.h.
>> +	    If there is no matching LED_FUNCTION available, add a new one.
>> +- color : Color of the LED. Use one of the LED_COLOR_NAME_* prefixed definitions
>> +	    from the header include/dt-bindings/leds/common.h.
>> +	    If there is no matching LED_COLOR_NAME available, add a new one.
>> +
> 
> I am assuming multi color can re-use this property as well?

I intended it to be a string, but indeed it would be better if we will
make it an integer to be consistent with the discussed LED multi color
design.


>>   - label : The label for this LED. If omitted, the label is taken from the node
>>   	  name (excluding the unit address). It has to uniquely identify
>>   	  a device, i.e. no other LED class device can be assigned the same
>> -	  label.
>> +	  label. This property is deprecated - use 'function' and 'color'
>> +	  properties instead.
>>   
>>   - default-state : The initial state of the LED. Valid values are "on", "off",
>>     and "keep". If the LED is already on or off and the default-state property is
>> @@ -87,29 +96,59 @@ Required properties for trigger source:
>>   
>>   * Examples
>>   
>> -gpio-leds {
>> +#include <dt-bindings/leds/common.h>
>> +
>> +led-controller@0 {
>>   	compatible = "gpio-leds";
>>   
>> -	system-status {
>> -		label = "Status";
>> +	led0 {
>> +		function = LED_FUNCTION_STATUS;
> 
> Missing color for example unless there is a reason to omit it for GPIO LEDs

It is on purpose - to show that it is an optional property for
monochrome LEDs.

> 
> Also missing reg here

Also on purpose. leds-gpio bindings don't require reg here.
And when reg is absent the unit address in the node name should
be omitted as Rob stated in one of recent reviews.

>>   		linux,default-trigger = "heartbeat";
>>   		gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
>>   	};
>>   
>> -	usb {
>> +	led1 {
>> +		function = LED_FUNCTION_USB;
> 
> Same as above
> Also missing reg here
>>   		gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
>>   		trigger-sources = <&ohci_port1>, <&ehci_port1>;
>>   	};
>>   };
>>   
>> -max77693-led {
>> +led-controller@0 {
>>   	compatible = "maxim,max77693-led";
>>   
>> -	camera-flash {
>> -		label = "Flash";
>> +	led {
>> +		function = LED_FUNCTION_FLASH;
>> +		color = LED_COLOR_NAME_WHITE;
>>   		led-sources = <0>, <1>;
>>   		led-max-microamp = <50000>;
>>   		flash-max-microamp = <320000>;
>>   		flash-max-timeout-us = <500000>;
>>   	};
>>   };
>> +
>> +led-controller@30 {
>> +        compatible = "panasonic,an30259a";
>> +        reg = <0x30>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        led@1 {
>> +                reg = <1>;
>> +                linux,default-trigger = "heartbeat";
>> +                function = LED_FUNCTION_INDICATOR;
>> +                color = LED_COLOR_NAME_RED;
>> +        };
>> +
>> +        led@2 {
>> +                reg = <2>;
>> +                function = LED_FUNCTION_INDICATOR;
>> +                color = LED_COLOR_NAME_GREEN;
>> +        };
>> +
>> +        led@3 {
>> +                reg = <3>;
>> +                function = LED_FUNCTION_INDICATOR;
>> +                color = LED_COLOR_NAME_BLUE;
>> +        };
>> +};
>>
> 
> 

-- 
Best regards,
Jacek Anaszewski
