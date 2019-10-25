Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857FECA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDAF20578
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffDG9qpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfJYVQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:16:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33797 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfJYVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:16:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id v3so5112114wmh.1;
        Fri, 25 Oct 2019 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZL5zRfFC3dYPUpHwPSEB17QL55+F21PLLO0tPnKdBwo=;
        b=ffDG9qpYubuilFLwk9vO5X2GqWlVJLkA7Px1sWhBkHmpsIi7Hcht1FIUJHbt4xddVs
         QNJrMSnVhuUqviMMxHWHDwnwk/3rkFoa5Yy0f3nZshswkzuoBJ2lo4g8QmpVx2OH4XT7
         jXBb0bTcnEqiMkrlSU0e8rvP7xPqn/n67E/S8b6k2F5uiI+U+eE+cECgRknJurrX5vVQ
         IgPbUQ/4G0n3YvJGlB/hU3h5dzglZKptcwKWMDAsnT73/oBHx1uJMLpQ+OHN2RdGhTCf
         V8t4fLSD1xF+DxjDW9oHUP7rrBlMJ3gX0EP34W5Zwwc8RjgOwONAkreQh08/ozxrqran
         qhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZL5zRfFC3dYPUpHwPSEB17QL55+F21PLLO0tPnKdBwo=;
        b=BlFTVzcZ/ISowe7HwP0L+Pb6sqPvKqNu/UJjcet0ycUP7M1eufFK7+fnSz3sztyXB2
         q5PptphvEWaSjAYVnJWpe+2srZgbSPoUbjcFdJ6N3SCg9ediy4piL5rHG7Jp3G201N06
         h7ds+yVnTeONfjXuKkJqeDlho7FN4mxVAKwWLkZWGB9sZFosrKUpR9EnI6b0XjP2hkTu
         U7WQGSYFSNzMgJ2a6sH6GfsC6fqZg9FDtoAhH4T2paFlE8tpHpiulPo5tX0MpngDB5C4
         UyjsRKLteuUXhjuCp5lzfSZzksTXMjtzzKHOxhp7B4j7OAVVxaZXJubkC2sv/n3JWnnd
         UyMQ==
X-Gm-Message-State: APjAAAVK7FemK/yFnKlwPj41oRUqgXen1yQl/Ld/O/oYdj6+nsZKgMR5
        SjmusCFwL+ZXD/EzQfyqM2M=
X-Google-Smtp-Source: APXvYqxl+AhNwCwJFrXHUATCOW4JXuKiUSZq6V3qPnaFbRFlF0eGaR7qQH1hlGaA2gMQUjJL6Zf+uA==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr5155966wmj.126.1572038209759;
        Fri, 25 Oct 2019 14:16:49 -0700 (PDT)
Received: from ?IPv6:2a01:cb19:16b:9900:1a4:6efa:66cf:f9c7? ([2a01:cb19:16b:9900:1a4:6efa:66cf:f9c7])
        by smtp.gmail.com with ESMTPSA id o18sm4601598wrm.11.2019.10.25.14.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 14:16:49 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: imx7d-pico: Add LCD support
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
References: <20191025082247.3371-1-offougajoris@gmail.com>
 <20191025184544.7gwwbsrketjtwrwi@pengutronix.de>
From:   Joris Offouga <offougajoris@gmail.com>
Message-ID: <5a73d00e-397a-f4ed-2bfa-bb26324685ba@gmail.com>
Date:   Fri, 25 Oct 2019 23:16:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025184544.7gwwbsrketjtwrwi@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Le 25/10/2019 à 20:45, Marco Felsch a écrit :
> Hi Joris,
>
> On 19-10-25 10:22, Joris Offouga wrote:
>> Add support for the VXT VL050-8048NT-C01 panel connected through
>> the 24 bit parallel LCDIF interface.
>>
>> Signed-off-by: Joris Offouga <offougajoris@gmail.com>
>> Signed-off-by: Fabio Estevam <festevam@gmail.com>
>> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
>> ---
>>   arch/arm/boot/dts/imx7d-pico.dtsi | 84 +++++++++++++++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
>> index 6f50ebf31a0a..9042b1e6f1db 100644
>> --- a/arch/arm/boot/dts/imx7d-pico.dtsi
>> +++ b/arch/arm/boot/dts/imx7d-pico.dtsi
>> @@ -69,6 +69,37 @@
>>   		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
>>   		clock-names = "ext_clock";
>>   	};
>> +
>> +	backlight: backlight {
>> +		compatible = "pwm-backlight";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_backlight>;
>> +		pwms = <&pwm4 0 50000 0>;
>                                        ^
>       If not inverted please drop the this flag.
> Also you need to add
>
> &pwm4 {
> 	status = "okay";
> };
This  node is already provide but i agree with you i move pinctrl in 
pwm4 node and rename the muxing
>
> And so you can do the pwm pinctrl within that node, see below.
>
>> +		brightness-levels = <0 36 72 108 144 180 216 255>;
>> +		default-brightness-level = <6>;
>> +		status = "okay";
> status can be dropped too.
>
>> +	};
>> +
>> +	reg_lcd_3v3: regulator-lcd-3v3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "lcd-3v3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> Missing the muxing?
No this pin is already drive
>
>> +		enable-active-high;
>> +	};
>> +
>> +	panel {
>> +		compatible = "vxt,vl050-8048nt-c01";
>> +		backlight = <&backlight>;
>> +		power-supply = <&reg_lcd_3v3>;
>> +
>> +		port {
>> +			panel_in: endpoint {
>> +				remote-endpoint = <&display_out>;
>> +			};
>> +		};
>> +	};
> Please sort the nodes alphabetical.

okay thanks for your review

otherwise Fabio made me notice that I should leave his From however with 
the changes made I should put mine?

Best regards,

Joris

>
>>   };
>>   
>>   &clks {
>> @@ -230,6 +261,18 @@
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
>> @@ -349,6 +392,13 @@
>>   };
>>   
>>   &iomuxc {
>> +
>> +	pinctrl_backlight: backlight {
>                                      ^
>                          please add 'grp'
>> +		fsl,pins = <
>> +			MX7D_PAD_GPIO1_IO11__PWM4_OUT		0x0
>> +		>;
>> +	};
> IMHO the muxing is part of the pwm4 node. So rename it to
> 'pinctrl_pwm4: pwm4grp'.
>
> Regards,
>    Marco
>
>> +
>>   	pinctrl_ecspi3: ecspi3grp {
>>   		fsl,pins = <
>>   			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0x2
>> @@ -413,6 +463,40 @@
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
>> -- 
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
