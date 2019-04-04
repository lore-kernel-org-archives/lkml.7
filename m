Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0827C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A84206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3BjtqdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfDDSjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:39:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35131 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbfDDSjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:39:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so4618003wmd.0;
        Thu, 04 Apr 2019 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P5P12ANE4sDRXYoTf6PdW9oRqSC168FG/dgvfP/oEbI=;
        b=n3BjtqdUWw8f9nzAn4Zi0jhsUxTDibaQGxwyB2tsJWfjKf4o2tx8E+U9Z4hurxqNj5
         u7mm2+aPbF8ublACc0yOq0WcCaY0y5/ECzVBr5y5qP8BNJVaPa4DGzDvc1yZsKDlKmdj
         AEE1UM/YVCt42bmCC+47q6k5D4m7BModX/P67da3AG7ObSGJYq6r3ZtzmJNsV7but8aR
         gPW1LUcgHJV9alZd3zS+qeUTmejxLDFg3NXSvlKZg9duLvA8i0/Pv0RoSrISZGMSe1WY
         DbcELqsQ62yCm1sn24ON7c00QnExaouGPyC1kbyId4+ZiHZ9N6ohUZnIMd3t/BxWwtSK
         MYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P5P12ANE4sDRXYoTf6PdW9oRqSC168FG/dgvfP/oEbI=;
        b=E55yVm9O4kkLVKAw9Tuf59NUTBkEtJD6+1cgEHBRVqlKlHBSqInucoDFFufm1ANW0G
         Waa+rMm467HYXqczZKYloCCH6j7k7ZfHv7TSGG/D4d8fgG1YwK9kS/vGegDrlz9Ut4L2
         JGIB1XeJXoYxd5zNZA8cPMc6ZdWBrf0W73Dq63+VPezHG8YRRJde3IRtT8G4rx/o7bho
         +VdnlQysu65V+IwnRi992+NWBPzBoOo/xATp62PNZDBcwNb5/Mdbtvcyn41VOTfo9AGP
         mnI0J1N63YEEAdGwyC0ZnY6iW3IcGqWSqeJXbzgvgwbT0SQomM7772c7AMg6L71YMbF8
         2b9A==
X-Gm-Message-State: APjAAAXN9KbB2nCLRnA1FDYrax2+uG8naK/TDFM9f7eZz58pcc5V9O3e
        iHpslZ3X7o5CTLf84o7zsS0y2PTj
X-Google-Smtp-Source: APXvYqzRH/InLQrylGGUK3H5aK+ZbGMkmvCvC75M0KsdEMAEAv9RwY7m/GMHfO4BWQzaGmOb89SKzA==
X-Received: by 2002:a1c:9c14:: with SMTP id f20mr5058984wme.16.1554403184934;
        Thu, 04 Apr 2019 11:39:44 -0700 (PDT)
Received: from [192.168.1.19] (dkj99.neoplus.adsl.tpnet.pl. [83.24.13.99])
        by smtp.gmail.com with ESMTPSA id w18sm30187529wru.24.2019.04.04.11.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 11:39:44 -0700 (PDT)
Subject: Re: [PATCH 3/5] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-4-dmurphy@ti.com>
 <4e38128a-fa8f-aa94-284f-2c5a4906e17d@gmail.com>
 <83e31761-714d-db83-8c35-cf45243cb50b@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <4983e0b6-ae2b-9d15-0408-fdb23869711a@gmail.com>
Date:   Thu, 4 Apr 2019 20:39:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <83e31761-714d-db83-8c35-cf45243cb50b@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 4/3/19 10:23 PM, Dan Murphy wrote:
> Jacek
> 
> On 4/3/19 3:10 PM, Jacek Anaszewski wrote:
>> Hi Dan,
>>
>> Thank you for the patch.
>>
>> You need Lee Jones on CC for this series.
>>
> 
> Yes I saw I missed Lee.
> 
>> One more comment below.
>>
>> On 3/25/19 3:24 PM, Dan Murphy wrote:
>>> The LM3697 is a single function LED driver. The single function LED
>>> driver needs to reside in the LED directory as a dedicated LED driver
>>> and not as a MFD device.  The device does have common brightness and ramp
>>> features and those can be accomodated by a TI LMU framework.
>>>
>>> The LM3697 dt binding needs to be moved from the ti-lmu.txt and a dedicated
>>> LED dt binding needs to be added.  The new LM3697 LED dt binding will then
>>> reside in the Documentation/devicetree/bindings/leds directory and follow the
>>> current LED and general bindings guidelines.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>    .../devicetree/bindings/leds/leds-lm3697.txt  | 77 +++++++++++++++++++
>>>    .../devicetree/bindings/mfd/ti-lmu.txt        | 26 +------
>>>    2 files changed, 78 insertions(+), 25 deletions(-)
>>>    create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>> new file mode 100644
>>> index 000000000000..a780f11acd38
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>> @@ -0,0 +1,77 @@
>>> +* Texas Instruments - LM3697 Highly Efficient White LED Driver
>>> +
>>> +The LM3697 11-bit LED driver provides high-
>>> +performance backlight dimming for 1, 2, or 3 series
>>> +LED strings while delivering up to 90% efficiency.
>>> +
>>> +This device is suitable for display and keypad Lighting
>>> +
>>> +Required properties:
>>> +    - compatible:
>>> +        "ti,lm3697"
>>> +    - reg :  I2C slave address
>>> +    - #address-cells : 1
>>> +    - #size-cells : 0
>>> +
>>> +Optional properties:
>>> +    - enable-gpios : GPIO pin to enable/disable the device
>>> +    - vled-supply : LED supply
>>> +
>>> +Required child properties:
>>> +    - reg : 0 - LED is Controlled by bank A
>>> +        1 - LED is Controlled by bank B
>>> +    - led-sources : Indicates which HVLED string is associated to which
>>> +            control bank.  This is a zero based property so
>>> +            HVLED1 = 0, HVLED2 = 1, HVLED3 = 2.
>>> +            Additional information is contained
>>> +            in Documentation/devicetree/bindings/leds/common.txt
>>> +
>>> +Optional child properties:
>>> +    - max_brightness - This determines whether to use 8 bit brightness mode
>>> +               or 11 bit brightness mode.  If this value is not
>>> +               set the device is defaulted to the preferred 8bit
>>> +               brightness mode per 7.3.4.1 of the data sheet.
>>> +               The values are 255 (8bit) or 2047 (11bit).
>>
>> We should use led-max-microamp for that, if possible.
>>
> 
> Actually I was thinking this property could move to common.txt
> LM3697 would use it and it is also defined in leds-pwm.txt leds-netxbig.txt

It was considered back in 2014 when I was working on LED flash
class framework. It was then assessed inappropriate for describing
physical property of a device. It needs to be kept in mind that
it was in the context of flash LEDs, where currents are much
higher than for common LEDs. Since then we have been always using
led-max-microamp.

With max-brightness in Device Tree there is also another problem -
we don't know what it really means - greater allowed current or
greater resolution.

Why not allow for maximum available brightness resolution for ti-lmu
always when the amperage is not an issue?


> But I could rename it to led-max-microamp and figure out an algo to convert to max brightness
> 
> Dan
> 

-- 
Best regards,
Jacek Anaszewski
