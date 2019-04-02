Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A31C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5402075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyM4kBr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDBUkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:40:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40927 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfDBUkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:40:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id a28so10012868lfo.7;
        Tue, 02 Apr 2019 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CUvUPaB1TqcMlTmiXFY2mYB2BUNNdirl0/3glzxB0Lo=;
        b=pyM4kBr6HK8P0CDzLAyVsNg+ADtDAsi8m62cEN7fzDba0JOgHHrtD2klpWAhw9Bueq
         um5IcQ5VPvygZALhHbMNc7b+fX7OFdxmE5TgPpFo0eL7HRGMMTaFxp1Cvpw7mTPzyAeW
         yPYBhpMSEH5CC8BpxrJdeRN89ZUg2A6uBxLS1U/iXCBvmRbw9v125Dp5hHWpYjMAZVo/
         JgiKzCk++Nq6nIFk0Xd4uxNbhJ6r2NW+C8dO97CkanD4lY+dWR+PNP3epGraHiHX4ohZ
         7CGY6/7BUzO7RurwjsVfQ4g5syzDMJTYvQ5wDFv2VjWn1dCRmPlmv49SM4naKt4CrhCu
         sviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CUvUPaB1TqcMlTmiXFY2mYB2BUNNdirl0/3glzxB0Lo=;
        b=KrsTehJIngF/gQ5PJgGvDuwu9lipITGtENI97hhPHXvE6yT/sCYsJ/mKaviiT2y7ab
         ltNON/mKpeEDHdqzK0KZ4iPqlpgmZe8SEGCT6sSJ29oL1P7sz2naTA6kG023tagWVLlG
         TkCrfq4O5VYWtS2SqDvBlD1tqsh55dDCYjvC4urKd2psccKTf2f2ndFAUDyOfCM334GX
         PwDYHA9D/izG1/XjxzFaq+2Xr1PW9P3FMzL3+O7BUEb5/iEnjG2Y5KhyDUi7YXzeXFZq
         R6rgFARRTKwBICxc4xmAPS9IdlxllSC1CoP4ZykLBpR5NENVLlBtyeOhSV6+43fBQlP5
         6hEw==
X-Gm-Message-State: APjAAAX2aiXVN5pCrWWTmzfEjF48KyngZYNqqxdu+MdNibfW+MomgQ/W
        mtMWZB/E4WQZgmdLpCq6NETk24Vl
X-Google-Smtp-Source: APXvYqzc8MH58ADU+imYOmfHpH2CfI4ZqQqD5gpj5pI7MllkUqHrXVw09srX/qsq5pqP09iRskvk7g==
X-Received: by 2002:a19:9145:: with SMTP id y5mr39575604lfj.35.1554237615103;
        Tue, 02 Apr 2019 13:40:15 -0700 (PDT)
Received: from [192.168.1.19] (ckb186.neoplus.adsl.tpnet.pl. [83.31.77.186])
        by smtp.gmail.com with ESMTPSA id t14sm2914383lji.33.2019.04.02.13.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 13:40:14 -0700 (PDT)
Subject: Re: [RFC PATCH 2/5] dt: bindings: Add multicolor class dt bindings
 documention
To:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     robh+dt@kernel.org, marek.behun@nic.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190401173400.14238-1-dmurphy@ti.com>
 <20190401173400.14238-3-dmurphy@ti.com> <20190401212921.GB14681@amd>
 <f8655180-0c3a-7292-3a49-57d997473992@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <660390a5-0c3a-cfcf-119d-817f86d1659d@gmail.com>
Date:   Tue, 2 Apr 2019 22:40:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f8655180-0c3a-7292-3a49-57d997473992@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 1:40 PM, Dan Murphy wrote:
> Pavel
> 
> On 4/1/19 4:29 PM, Pavel Machek wrote:
>> Hi!
>>
>>
>>>   .../bindings/leds/leds-class-multicolor.txt   | 140 ++++++++++++++++++
>>>   1 file changed, 140 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt b/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
>>> new file mode 100644
>>> index 000000000000..4b1a26104c79
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
>>> @@ -0,0 +1,140 @@
>>> +* Multicolor LED properties
>>> +
>>> +Multicolor LEDs can consist of a RGB, RGBW or a RGBA LED clusters.  These devices
>>> +can be grouped together and also provide a modeling mechanism so that the
>>> +cluster LEDs can vary in hue and intensity to produce a wide range of colors.
>>> +
>>> +The nodes and properties defined in this document are unique to the multicolor
>>> +LED class.  Common LED nodes and properties are inherited from the common.txt
>>> +within this documentation directory.
>>> +
>>> +Required LED Child properties:
>>> +	- color : This is the color ID of the LED.  Definitions can be found
>>> +		  in include/linux/leds/common.txt
>>> +
>>> +Optional LED Child properties:
>>> +	- available-brightness-models : This is the phandle to the brightness-model
>>> +					node(s) that this LED cluster can support.
>>> +
>>> +Required Brightness model properties
>>> +	- led-brightness-model : This flag alerts the device driver and class
>>> +				 code that this node is a brightness model node
>>> +				 and to process the properties differently.
>>> +
>>> +Required Brightness model child properties
>>> +	- model_name : This is the name of the model presented to the user.  This
>>> +		       should be a color that the LED cluster can produce for
>>> +		       the device it is attached to.
>>> +	- layout : This is the LED layout for the levels.  This layout will
>>> +		   determine the color order of the levels.  The layout and
>>> +		   level-x properties array should be the same size.
>>> +	- level-x : These are the values for the LEDs to produce the color that
>>> +		    is defined.  These values are placed in the array according
>>> +		    to the layout property.
>>
>>> +led-controller@30 {
>>> +	#address-cells = <1>;
>>> +	#size-cells = <0>;
>>> +	compatible = "ti,lp5024";
>>> +	reg = <0x29>;
>>> +
>>> +	lp5024_model_yellow: brightness-models {
>>> +		led-brightness-model;
>>> +		model@0 {
>>> +			model_name = "yellow";
>>> +			layout = <LED_COLOR_ID_RED
>>> +				  LED_COLOR_ID_GREEN
>>> +				  LED_COLOR_ID_BLUE>;
>>> +			level-1 = <255 227 40>;
>>> +			level-2 = <255 240 136>;
>>> +			level-3 = <255 247 196>;
>>> +		};
>>> +	};
>>
>> I don't think this works. RGB LED can show millions of colors. Do you
>> propose to have millions of entries in dts?
>> 									Pavel
>>
> 
> I have had off line conversations with Jacek about this brightness model node.
> 
> Your concern was actually one of my concerns as well.  Not only millions of entries but also having a huge
> DT binary.
> 
> We wanted to RFC this to get feedback.  And this is why I have not added any support for this in the framework code.

We all know that nobody sane is going to add millions of color entries.
It is just a holistic solution to the problem, without the need to worry
about different colors being produced by different LED elements, either
due to their inherent properties, due to different parameters of LED
controllers and board designs, or due to aging. Of course the last
case will be possible to fix only by update of DTB blob.

Regarding the possible size of DTB blob, I made some calculations and
even compiled sample dts. Here is my reasoning from one of the replies
to Dan during our private discussion:

-------------------------------------------------------------------------

Brightness models will be reusable between modules. There could be
arbitrary number of brightness models, limited only by maximum dtb blob
size.

In uboot it can be configured with "setenv fdt_high". For the dtbs
appended to zImage for ARM the limit is 2MB AFAIK. Brightness models
will be what consumes the most of memory with this proposed DT design.

Let's calculate.

4 bytes for single brightness value (we allow for values > 255).

I think quite exaggerated exemplary quantities:

number of colors in the mcled_dev: 10
number of levels per model: 256
number of models: 100

bytes required = 4 * 10 * 256 * 100 = 1024000, i.e. less than 1MB

And average mainline dtbs usually don't exceed 100kB, so I think
we are safe. I've even just tried it out by adding such 10 models
of 255 levels * 10 values * 4-byte to versatile-pb.dts and I got dtb
size ~150kB.

But to be sure it would be good to get early ack from DT guys.

-------------------------------------------------------------------------

And now is this moment - we'd like to hear the feedback from DT guys.

-- 
Best regards,
Jacek Anaszewski
