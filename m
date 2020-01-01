Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB559C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 23:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1742084D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 23:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeEcRA5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgAAXsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 18:48:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53379 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgAAXsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 18:48:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so4318721wmc.3;
        Wed, 01 Jan 2020 15:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gUYrBkQ+daKM7r2bwts74eJuugw8V4ZwGOg11zcLs/U=;
        b=qeEcRA5OPa/zJkwVQpmOklcXkuNLL+AgdR+rJbbT//fqKNUWzFQeG2QlnnKDY8SULl
         gsNsynAKJZy15hMCtx4KdsNh58Jy0ALS0NMoIUp1nT1gz523qXeQzVBMwbCIEuwIPFqM
         ySlo31a26x+uyUIiGL9tmk/Y0fYd72JeVNwrvCFPl/xPb65RCEzFAwADUNYP8qLVk5iN
         vR1wO30R7suVEocjbvJcOdw5Iwq0eGBOZueaxtBkaqNEaXUJhN2/XVpbbjynorD02MYY
         LsCBoWL0SqQYlO5OSnXorE4mYxOmCo5B2PUu6Mbh7IBjJEI7EqglKZPM/k5lOXyeXwlU
         XacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gUYrBkQ+daKM7r2bwts74eJuugw8V4ZwGOg11zcLs/U=;
        b=mjB0fbsipCk8u/D5sUjSA0C/UXcyZ6iEAs8oakuKDOSgB3EcK/u6xz+p5pO2UpWCmP
         dIyzUR+DzmFjPWazDhOqDMHMPFHXuGf9H8gxgkO3cBswvF4RkTMp2clcCESITn1I718L
         3YzFLCRRP3E/Q4n06rFhr32Zx3bgoEnk6TqvUYabC9el+hakAwE6NXPjembaDv1tMYdr
         2RRrYL9xZUmCGfc+xE21hyFrxnjNvMnPEHrTOlQUxJNqNuFebmz3ILL0lBAF8In7G3Nc
         O+vm7bnLu7EMOsuU84Gl8vu+/F11gQJFSfIKTmH9qaI8PnNunrI1QohwyBysWUS6Tzx/
         KBAw==
X-Gm-Message-State: APjAAAWyOcobMxdXlPnGEK0T7PiepTs7vZdw+J1uOsvwH0pKqBsHrk0J
        ngeucje8HjdD0+JDrGvNH+c=
X-Google-Smtp-Source: APXvYqxaUT/FES2O2EvpE609nWlQnVrgiRgJyKSrfcvt8bZ3qEWm4B1r9DWbvafKOXbBmY7svMnKgQ==
X-Received: by 2002:a05:600c:218b:: with SMTP id e11mr10461702wme.121.1577922480213;
        Wed, 01 Jan 2020 15:48:00 -0800 (PST)
Received: from ?IPv6:2a01:cb19:16b:9900:21b2:eaec:d723:ee6e? ([2a01:cb19:16b:9900:21b2:eaec:d723:ee6e])
        by smtp.gmail.com with ESMTPSA id u18sm53632781wrt.26.2020.01.01.15.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2020 15:47:59 -0800 (PST)
From:   Joris Offouga <offougajoris@gmail.com>
Subject: Re: [PATCH V3] ARM: dts: imx7d-pico: Add LCD support
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
References: <20191029101742.9100-1-offougajoris@gmail.com>
 <20191030082718.oj4nq5li6mohf4tg@pengutronix.de>
Message-ID: <44787478-271d-4083-501d-2e5a52effd9e@gmail.com>
Date:   Thu, 2 Jan 2020 00:47:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191030082718.oj4nq5li6mohf4tg@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Sorry for the delay,

Le 30/10/2019 à 09:27, Marco Felsch a écrit :
> Hi Joris,
>
> On 19-10-29 11:17, Joris Offouga wrote:
>> From: Fabio Estevam<festevam@gmail.com>
>>
>> Add support for the VXT VL050-8048NT-C01 panel connected through
>> the 24 bit parallel LCDIF interface.
>>
>> Signed-off-by: Fabio Estevam<festevam@gmail.com>
>> Signed-off-by: Otavio Salvador<otavio@ossystems.com.br>
>> Signed-off-by: Joris Offouga<offougajoris@gmail.com>
>> ---
>>   Changes v2 -> v3
>> 	rename pintcrl_backlight to pinctrl_pwm4
>> 	sort the nodes alphabetical
>>
>>   Changes v1 -> v2
>>   	change "From:" Joris Offouga to Fabio Estevam
>> 	set Joris Offouga signed-off to the last one
>>
>>   arch/arm/boot/dts/imx7d-pico.dtsi | 82 +++++++++++++++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
>> index 6f50ebf31a0a..9c7c2c45e6aa 100644
>> --- a/arch/arm/boot/dts/imx7d-pico.dtsi
>> +++ b/arch/arm/boot/dts/imx7d-pico.dtsi
>> @@ -7,12 +7,40 @@
>>   #include "imx7d.dtsi"
>>   
>>   / {
>> +        backlight: backlight {
>> +                compatible = "pwm-backlight";
>> +                pwms = <&pwm4 0 50000 0>;
>                                           ^
>                                     still not needed

This is necessary, because it's not provide, we have this warning :

   DTC     arch/arm/boot/dts/imx7d-pico-pi.dtb
arch/arm/boot/dts/imx7d-pico.dtsi:12.17-40: Warning (pwms_property): 
/backlight:pwms: property size (12) too small for cell size 3

>> +                brightness-levels = <0 36 72 108 144 180 216 255>;
>> +                default-brightness-level = <6>;
>> +        };
>> +
>>   	/* Will be filled by the bootloader */
>>   	memory@80000000 {
>>   		device_type = "memory";
>>   		reg = <0x80000000 0>;
>>   	};
>>   
>> +        panel {
>> +                compatible = "vxt,vl050-8048nt-c01";
>> +                backlight = <&backlight>;
>> +                power-supply = <&reg_lcd_3v3>;
>> +
>> +                port {
>> +                        panel_in: endpoint {
>> +                                remote-endpoint = <&display_out>;
>> +                        };
>> +                };
>> +        };
>> +
>> +	reg_lcd_3v3: regulator-lcd-3v3 {
>> +                compatible = "regulator-fixed";
>> +                regulator-name = "lcd-3v3";
>> +                regulator-min-microvolt = <3300000>;
>> +                regulator-max-microvolt = <3300000>;
>> +                gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> Where happens the muxing for this gpio?

I add it for V4

Thanks

>
>> +                enable-active-high;
>> +        };
>> +
>>   	reg_wlreg_on: regulator-wlreg_on {
>>   		compatible = "regulator-fixed";
>>   		pinctrl-names = "default";
>> @@ -230,6 +258,18 @@
>>   	};
>>   };
>>   
>> +&lcdif {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_lcdif>;
>> +	status = "okay";
>> +
>> +	port {
>> +		display_out: endpoint {
>> +			remote-endpoint = <&panel_in>;
>> +		};
>> +	};
>> +};
>> +
>>   &sai1 {
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&pinctrl_sai1>;
>> @@ -260,6 +300,8 @@
>>   };
>>   
>>   &pwm4 { /* Backlight */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pwm4>;
>>   	status = "okay";
>>   };
>>   
>> @@ -413,6 +455,40 @@
>>   		>;
>>   	};
>>   
>> +	pinctrl_lcdif: lcdifgrp {
>> +		fsl,pins = <
>> +			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
>> +			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
>> +			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
>> +			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
>> +			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
>> +			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
>> +			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
>> +			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
>> +			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
>> +			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
>> +			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
>> +			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
>> +			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
>> +			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
>> +			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
>> +			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
>> +			MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
>> +			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
>> +			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
>> +			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
>> +			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
>> +			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
>> +			MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
>> +			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
>> +			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
>> +			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x78
>> +			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x78
>> +			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x78
>> +			MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14
>> +		>;
>> +	};
>> +
>>   	pinctrl_pwm1: pwm1 {
>>   		fsl,pins = <
>>   			MX7D_PAD_GPIO1_IO08__PWM1_OUT   0x7f
>> @@ -431,6 +507,12 @@
>>   		>;
>>   	};
>>   
>> +	pinctrl_pwm4: pwm4grp{
>> +		fsl,pins = <
>> +			MX7D_PAD_GPIO1_IO11__PWM4_OUT	0x0
>                                                           ^
>                                           Is this muxing value valid?

I fix for V4

Regards,

Joris

>
> Regards,
>    Marco
>
>> +		>;
>> +	};
>> +
>>   	pinctrl_reg_wlreg_on: regregongrp {
>>   		fsl,pins = <
>>   			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x59
>> -- 
>> 2.17.1
>>
>>
>>
