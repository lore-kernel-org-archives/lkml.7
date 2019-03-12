Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41E7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F14A2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg7rCZhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCLQnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:43:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39097 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:43:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id m13so2601573lfb.6;
        Tue, 12 Mar 2019 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hdGIBZsttxOeRsXlmv4SNGWTE8a1xa6k3veGaZntxBQ=;
        b=fg7rCZhKTMrmpuJ+9wGeBUP9cVtSqj9N0H+92YywiE5FuQGRHJOSHLgXq/imsfkiEW
         8sbkqcfcmdAHJ7iFQ3K3hZxFz9mCGyBOWrnv9TLGJAIa6Kym3fUxJ2ahP2MNiMUKDf6r
         i8yMjysf7kMRTBaiZ6svuF3X2tqJYoje9g8ncXek8TJMtlTqzyHXgb35iamKwFYtdI9b
         MoUDh6s4GsF1gjfghCE/H8aLOv0Dm6prk8yP8pJNik+leYJpePYvdDPTbSESBqzffUsV
         UXBLaaqs601llwxG1MuvdAYqMAb/xz/ahYfVJE+KrR9d9HdF0Ca5UTrgrPOJJiXg35Jd
         xJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hdGIBZsttxOeRsXlmv4SNGWTE8a1xa6k3veGaZntxBQ=;
        b=Gru22Ybczp+SNabEM/RQjkuILeZUl4cHpfWNXin7pYkFLEmpLPE4tI0fFVOgoHdnag
         ifVLLLjGH+0WrQjLwNbL6xysl+9nlyeWo0Y5d+zogSdEbnyuAAwV/L/B8FJEl8ZDqciG
         3qx+kBfaFjTO17CCe0aOEs03xcIc23I97d0F1fUudj39GESJ7I4PvLTZ+zROm21PzRNI
         H27dAKfIlYHaNNTuRFOhHONPae+HNBr8+TH/MoQEawVmWuuyeUYjyubK1DeUT5y4gHXB
         EQW3fucxy6Va3zzFVmh+6DVL6z8W1vfytKXQcPy9snADxH/RY5Cpgmfc7Bv6HmtQU8kL
         FxUA==
X-Gm-Message-State: APjAAAXPDxovdcd/4upsKZfHsGFALhLdYzwm/QHdElF5xHZAIdLEDlxf
        /xDga7SfKgwMHujqgr6nuxM=
X-Google-Smtp-Source: APXvYqxr7kpt7kxJaYDE4MFsr8qfurjUEE/uTcWtJCdF1tC4g1TZl/11Ecn3Hl8+BW6k/U0tYUBK3A==
X-Received: by 2002:ac2:424e:: with SMTP id m14mr21123024lfl.4.1552408996454;
        Tue, 12 Mar 2019 09:43:16 -0700 (PDT)
Received: from [192.168.1.18] (chp67.neoplus.adsl.tpnet.pl. [83.31.13.67])
        by smtp.gmail.com with ESMTPSA id j5sm1450980ljg.47.2019.03.12.09.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 09:43:15 -0700 (PDT)
Subject: Re: [PATCH 05/25] dt-bindings: leds: Add function and color
 properties
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
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
 <796a13a7-fb8c-9b5b-6bd5-dfb7458731fe@gmail.com>
Message-ID: <232b6154-cccd-c1f9-80c3-438098f3ab08@gmail.com>
Date:   Tue, 12 Mar 2019 17:43:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <796a13a7-fb8c-9b5b-6bd5-dfb7458731fe@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/19 6:24 PM, Jacek Anaszewski wrote:
> Dan,
> 
> On 3/11/19 1:26 PM, Dan Murphy wrote:
>> On 3/10/19 1:28 PM, Jacek Anaszewski wrote:
>>> Introduce dedicated properties for conveying information about
>>> LED function and color. Mark old "label" property as deprecated.
>>>
>>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>> Cc: Baolin Wang <baolin.wang@linaro.org>
>>> Cc: Daniel Mack <daniel@zonque.org>
>>> Cc: Dan Murphy <dmurphy@ti.com>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>>> Cc: Simon Shields <simon@lineageos.org>
>>> ---
>>>   Documentation/devicetree/bindings/leds/common.txt | 55 
>>> +++++++++++++++++++----
>>>   1 file changed, 47 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/common.txt 
>>> b/Documentation/devicetree/bindings/leds/common.txt
>>> index aa1399814a2a..3402b0e1cec9 100644
>>> --- a/Documentation/devicetree/bindings/leds/common.txt
>>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>>> @@ -10,14 +10,23 @@ can influence the way of the LED device 
>>> initialization, the LED components
>>>   have to be tightly coupled with the LED device binding. They are 
>>> represented
>>>   by child nodes of the parent LED device binding.
>>> +
>>>   Optional properties for child nodes:
>>>   - led-sources : List of device current outputs the LED is connected 
>>> to. The
>>>           outputs are identified by the numbers that must be defined
>>>           in the LED device binding documentation.
>>> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed 
>>> definitions
>>> +        from the header include/dt-bindings/leds/common.h.
>>> +        If there is no matching LED_FUNCTION available, add a new one.
>>> +- color : Color of the LED. Use one of the LED_COLOR_NAME_* prefixed 
>>> definitions
>>> +        from the header include/dt-bindings/leds/common.h.
>>> +        If there is no matching LED_COLOR_NAME available, add a new 
>>> one.
>>> +
>>
>> I am assuming multi color can re-use this property as well?
> 
> I intended it to be a string, but indeed it would be better if we will
> make it an integer to be consistent with the discussed LED multi color
> design.

Going further, I wonder if it would make sense to make function also
an integer. This way we could enforce use of LED functions known
to kernel.

Additionally, if we introduced a property like function-enum-val
(better name suggestions are welcome), then we could easily solve the
problem of string concatenation limitation in dtc compiler mentioned
in the cover letter, since the concatenation would be done in the LED core.

>>>   - label : The label for this LED. If omitted, the label is taken 
>>> from the node
>>>         name (excluding the unit address). It has to uniquely identify
>>>         a device, i.e. no other LED class device can be assigned the 
>>> same
>>> -      label.
>>> +      label. This property is deprecated - use 'function' and 'color'
>>> +      properties instead.
>>>   - default-state : The initial state of the LED. Valid values are 
>>> "on", "off",
>>>     and "keep". If the LED is already on or off and the default-state 
>>> property is
>>> @@ -87,29 +96,59 @@ Required properties for trigger source:
>>>   * Examples
>>> -gpio-leds {
>>> +#include <dt-bindings/leds/common.h>
>>> +
>>> +led-controller@0 {
>>>       compatible = "gpio-leds";
>>> -    system-status {
>>> -        label = "Status";
>>> +    led0 {
>>> +        function = LED_FUNCTION_STATUS;
>>
>> Missing color for example unless there is a reason to omit it for GPIO 
>> LEDs
> 
> It is on purpose - to show that it is an optional property for
> monochrome LEDs.
> 
>>
>> Also missing reg here
> 
> Also on purpose. leds-gpio bindings don't require reg here.
> And when reg is absent the unit address in the node name should
> be omitted as Rob stated in one of recent reviews.
> 
>>>           linux,default-trigger = "heartbeat";
>>>           gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
>>>       };
>>> -    usb {
>>> +    led1 {
>>> +        function = LED_FUNCTION_USB;
>>
>> Same as above
>> Also missing reg here
>>>           gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
>>>           trigger-sources = <&ohci_port1>, <&ehci_port1>;
>>>       };
>>>   };
>>> -max77693-led {
>>> +led-controller@0 {
>>>       compatible = "maxim,max77693-led";
>>> -    camera-flash {
>>> -        label = "Flash";
>>> +    led {
>>> +        function = LED_FUNCTION_FLASH;
>>> +        color = LED_COLOR_NAME_WHITE;
>>>           led-sources = <0>, <1>;
>>>           led-max-microamp = <50000>;
>>>           flash-max-microamp = <320000>;
>>>           flash-max-timeout-us = <500000>;
>>>       };
>>>   };
>>> +
>>> +led-controller@30 {
>>> +        compatible = "panasonic,an30259a";
>>> +        reg = <0x30>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        led@1 {
>>> +                reg = <1>;
>>> +                linux,default-trigger = "heartbeat";
>>> +                function = LED_FUNCTION_INDICATOR;
>>> +                color = LED_COLOR_NAME_RED;
>>> +        };
>>> +
>>> +        led@2 {
>>> +                reg = <2>;
>>> +                function = LED_FUNCTION_INDICATOR;
>>> +                color = LED_COLOR_NAME_GREEN;
>>> +        };
>>> +
>>> +        led@3 {
>>> +                reg = <3>;
>>> +                function = LED_FUNCTION_INDICATOR;
>>> +                color = LED_COLOR_NAME_BLUE;
>>> +        };
>>> +};
>>>
>>
>>
> 

-- 
Best regards,
Jacek Anaszewski
