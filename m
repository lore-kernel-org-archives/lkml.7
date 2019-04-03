Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAB8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B632133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/CMtYSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDCUKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:10:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43315 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCUKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:10:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id g7so45011lfh.10;
        Wed, 03 Apr 2019 13:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V1IAsjISbqL+vZHlyqqnqd5BG5CEJD8B2rib1pDTBBY=;
        b=N/CMtYSX+14nCqry8BN2+Cc7pP0REfv69GKnxBtZwJ0tqFtrthD6017NZPxYxQf22P
         yd/J2S+a8UG8/sj+wXCkVG25ja+vmF5BEoBimb0fD+4uP0y3Urhzi+Lx17X+gPtP6RfK
         EStQm7DqWRGPFt44ZJQvY+QjWL2dWR8un+MYiPNXVdd7M1FRKE1pgAMxMHPej49T8a7q
         u58q4ds22WThGHagpJb9KrY6+2x30qRv4/tkml/q1Ua1FcLvfB4cy2lGPGDv1amPwB1k
         R1VtHITeIHHO8lGMCgmhEESXQKT/z7AVcWbIXFwaKIR87Zte3JjJ0uzQayQ6dNtUERuQ
         y9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V1IAsjISbqL+vZHlyqqnqd5BG5CEJD8B2rib1pDTBBY=;
        b=f5Ru2JRwEFigoN4bbp8E6nl4VnikgZ5FaAqarkvRe6pBqFD/NPMdW0mXNzWRovP+pJ
         jjGV3EosmhtcH7gKCNxwDxxD09WX59c+zOMOVTuRsGhKGILoOD3Tv2ouO23E0qxA/BZi
         SEPSZ6hOReraBJdvc5QbB0b6Lyty3Yqm2upC4NEh2enyBEq1MPc7DzWOyPnoRf8XaPN8
         KkF6yVEnuRJBAzIa0blvmK+6phKYZrIbi2Z/8e0R/M8jYU1QBHOj7HfLbGkl7DsI0b2X
         h1aF8aRNV1LRo4BqF/m2EvgwqytNDf4Cs9dd974oBbBqQevUSwMv3bj/FHVl40NW/rAF
         5fBw==
X-Gm-Message-State: APjAAAV4dIF8Ek/7WAoNJQqfchlnX3KQusz0eY/Hj1Vrla65Fo9n6rzp
        uILQlAVwCIwoQm5czXwJ5O3Aszg6
X-Google-Smtp-Source: APXvYqxVptbQP9r6EGmmqa4fgN9NZ1M2Zr9cOit6p2MyWVWZlijhf6489Vzya/BnE4CAjcc/2EdDhQ==
X-Received: by 2002:a05:6512:1ca:: with SMTP id f10mr933770lfp.136.1554322248898;
        Wed, 03 Apr 2019 13:10:48 -0700 (PDT)
Received: from [192.168.1.19] (bkr161.neoplus.adsl.tpnet.pl. [83.28.185.161])
        by smtp.gmail.com with ESMTPSA id z15sm3438472ljz.55.2019.04.03.13.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 13:10:48 -0700 (PDT)
Subject: Re: [PATCH 3/5] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-4-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <4e38128a-fa8f-aa94-284f-2c5a4906e17d@gmail.com>
Date:   Wed, 3 Apr 2019 22:10:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190325142403.30447-4-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the patch.

You need Lee Jones on CC for this series.

One more comment below.

On 3/25/19 3:24 PM, Dan Murphy wrote:
> The LM3697 is a single function LED driver. The single function LED
> driver needs to reside in the LED directory as a dedicated LED driver
> and not as a MFD device.  The device does have common brightness and ramp
> features and those can be accomodated by a TI LMU framework.
> 
> The LM3697 dt binding needs to be moved from the ti-lmu.txt and a dedicated
> LED dt binding needs to be added.  The new LM3697 LED dt binding will then
> reside in the Documentation/devicetree/bindings/leds directory and follow the
> current LED and general bindings guidelines.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   .../devicetree/bindings/leds/leds-lm3697.txt  | 77 +++++++++++++++++++
>   .../devicetree/bindings/mfd/ti-lmu.txt        | 26 +------
>   2 files changed, 78 insertions(+), 25 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> new file mode 100644
> index 000000000000..a780f11acd38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> @@ -0,0 +1,77 @@
> +* Texas Instruments - LM3697 Highly Efficient White LED Driver
> +
> +The LM3697 11-bit LED driver provides high-
> +performance backlight dimming for 1, 2, or 3 series
> +LED strings while delivering up to 90% efficiency.
> +
> +This device is suitable for display and keypad Lighting
> +
> +Required properties:
> +	- compatible:
> +		"ti,lm3697"
> +	- reg :  I2C slave address
> +	- #address-cells : 1
> +	- #size-cells : 0
> +
> +Optional properties:
> +	- enable-gpios : GPIO pin to enable/disable the device
> +	- vled-supply : LED supply
> +
> +Required child properties:
> +	- reg : 0 - LED is Controlled by bank A
> +		1 - LED is Controlled by bank B
> +	- led-sources : Indicates which HVLED string is associated to which
> +			control bank.  This is a zero based property so
> +			HVLED1 = 0, HVLED2 = 1, HVLED3 = 2.
> +			Additional information is contained
> +			in Documentation/devicetree/bindings/leds/common.txt
> +
> +Optional child properties:
> +	- max_brightness - This determines whether to use 8 bit brightness mode
> +			   or 11 bit brightness mode.  If this value is not
> +			   set the device is defaulted to the preferred 8bit
> +			   brightness mode per 7.3.4.1 of the data sheet.
> +			   The values are 255 (8bit) or 2047 (11bit).

We should use led-max-microamp for that, if possible.

-- 
Best regards,
Jacek Anaszewski
