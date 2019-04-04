Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749C2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4020320651
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTzj9X/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfDDUMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:12:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39123 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfDDUMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:12:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id l7so3228995ljg.6;
        Thu, 04 Apr 2019 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iStgFTZUzsIN3Bkb5Af22Ii7OkATb3tLdzI2Uoy5wPY=;
        b=hTzj9X/yUJLb2j0qyflc5WioiaN0SMoYjUwBv2nLbNlRVW79yU7GRqjZ1IdVLJheAE
         gVN5Z8rGc2KllFrCVRXD5XOzLikShhr6yXBrS9uIqdTrruD9GcpHmC8IIaz3GHH5acKO
         vkmwrarLegiEIphWV7pRPwdnPCKP+dsn8zBsSv7/xHRpsXEbhs+mU6idaHlLpDC6zzVl
         3dgNRijYnkxcB9tIeSDMkTq+z3e1TACHYVusrzls7P6/0ji8CoSANWwpNeWrhtBliyJl
         cWlHd0FmJC9zfPBIoZ80JP0lNCNDPfW7dNpf5FJ0Y3UmVNx2fh9tcEWzZARD6FKWOq92
         MWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iStgFTZUzsIN3Bkb5Af22Ii7OkATb3tLdzI2Uoy5wPY=;
        b=VLCvCLIxlYJ1hH6b9RkvhqERPn9ZOxzVws4/SapZ4eURZoHLxSTzAvrHgJuNGbcXb6
         P3xMty56XYprmtPkYOyjfiY3bWZ61P5WWOyzHnV3V7swi0FzEWyIKcCNPTLkiNHBf6Tn
         w7mKzhNSdczMcDC7Bo0RoAE7JMMMsvKdeve5qg5xk3Tno02fNKXCXErw3GxkW65xp0zJ
         r4HHXw6W9laFeX5iZoXg+taMa5AgJtLtnRDr05WnwX5ZtD+WvtxR2YDYQfc8SZs/fa4w
         eXZmiGC5brS0VDP3qvE/PB22nUvu3Dutvji/OiAfhpu+TAOXr9YejhO4+szL7tLhpijG
         I5Ew==
X-Gm-Message-State: APjAAAWzPhfRTEAilKWCUKdQ/DDf36A5R8gY51GzLV7hdIL/hcXYieyV
        fCs7H0nGZ5sWA1nKAF3lzUR6yAds
X-Google-Smtp-Source: APXvYqzfWkdhFMTUuB81TFdQt++DXmrxWvs1G71AjCRseM5dgMD+FER5bfiXHipFEcALm1tJHnBDmg==
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr4531737lje.138.1554408726352;
        Thu, 04 Apr 2019 13:12:06 -0700 (PDT)
Received: from [192.168.1.19] (dkj99.neoplus.adsl.tpnet.pl. [83.24.13.99])
        by smtp.gmail.com with ESMTPSA id z13sm4125644ljk.41.2019.04.04.13.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 13:12:05 -0700 (PDT)
Subject: Re: [PATCH 2/4] ARM: dts: omap4-droid4: Update backlight dt
 properties
To:     Dan Murphy <dmurphy@ti.com>, tony@atomide.com
Cc:     robh+dt@kernel.org, pavel@ucw.cz, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-2-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <f9d80ad1-d80c-bf77-5e0b-1e02a1b74200@gmail.com>
Date:   Thu, 4 Apr 2019 22:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190321142838.22985-2-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

On 3/21/19 3:28 PM, Dan Murphy wrote:
> Update the properties for the lm3532 device node for droid4.
> With this change the backlight LED string and the keypad
> LED strings will be controlled separately.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v5 - No change - https://lore.kernel.org/patchwork/patch/1050409/
> 
> v4 - No change - https://lore.kernel.org/patchwork/patch/1050125/
> v3 - updated keypad label on v1 comment - https://lore.kernel.org/patchwork/patch/1049023/
> v2 - Fixed ramp-up and ramp-down properties, removed hard coded property values,
> I did not change the label as it is undecided what it could be - https://lore.kernel.org/patchwork/patch/1048806/
> 
>   arch/arm/boot/dts/omap4-droid4-xt894.dts | 26 ++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> index e21ec929f096..aea206f04f76 100644
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -383,20 +383,30 @@
>   };
>   
>   &i2c1 {
> -	lm3532@38 {
> +	led-controller@38 {
>   		compatible = "ti,lm3532";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>   		reg = <0x38>;
>   
>   		enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
>   
> -		lcd_backlight: backlight {
> -			compatible = "ti,lm3532-backlight";
> +		ramp-up-us = <1024>;
> +		ramp-down-us = <8193>;
>   
> -			lcd {
> -				led-sources = <0 1 2>;
> -				ramp-up-msec = <1>;
> -				ramp-down-msec = <0>;
> -			};

Since I'll be creating integration branch for this series,
and it would be good to have this patch in it too, then
I can do the amendments by myself:

> +		lcd_backlight: led@0 {
> +			reg = <0>;
> +			led-sources = <2>;
> +			ti,led-mode = <0>;
> +			label = "backlight";

s/backlight/:backlight/

> +			linux,default-trigger = "backlight";
> +		};
> +
> +		led@1 {
> +			reg = <1>;
> +			led-sources = <1>;
> +			ti,led-mode = <0>;
> +			label = "platform::kbd_backlight";

s/platform::kbd_backlight/:kbd_backlight/

and then send you a pull request.

Would you be OK with that?

>   		};
>   	};
>   };
> 

-- 
Best regards,
Jacek Anaszewski
