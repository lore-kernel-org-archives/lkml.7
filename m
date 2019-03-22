Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4B6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7031F21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfCVWQm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:16:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35556 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbfCVWQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:16:41 -0400
Received: from p5b12791e.dip0.t-ipconnect.de ([91.18.121.30] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h7SSs-0002SH-0b; Fri, 22 Mar 2019 23:16:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: Add device tree for rk3288-veyron-mighty
Date:   Fri, 22 Mar 2019 23:16:36 +0100
Message-ID: <25900873.Y1cXTD7Cd1@phil>
In-Reply-To: <20190322194310.61365-2-dianders@chromium.org>
References: <20190322194310.61365-1-dianders@chromium.org> <20190322194310.61365-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 22. März 2019, 20:43:10 CET schrieb Douglas Anderson:
> Mighty is basically the same Chromebook as Jaq but it has a full-sized
> SD slot and some different (slightly more rugged) plastics around it.
> Like Jaq, Mighty may show up with various different brandings but all
> of them have the same board inside.
> 
> In the downstream kernel Mighty and Jaq share a "dtsi" and Mighty just
> adds the SD write protect (needed for a full-sized SD slot).  It seems
> cleaner for upstream just to add a separate dts file, though.

looking at other dts files in the mainline kernel [0] it also seems
possible to just include another ".dts" without it needing to have
a specific dtsi. So if it's really only the write-protect that is different
we might want to go that way.

Heiko


[0] exmaples from grepping for _.dts"_ which shows all boards doing that:
arm-realview-eb-11mp-bbrevd.dts
dove-cubox-es.dts
imx6dl-tx6u-80xx-mb7.dts
versatile-pb.dts
... and quite a bit more


> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm/boot/dts/Makefile                 |   1 +
>  arch/arm/boot/dts/rk3288-veyron-mighty.dts | 182 +++++++++++++++++++++
>  2 files changed, 183 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3288-veyron-mighty.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f4f5aeaf3298..48282ebfb3da 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -909,6 +909,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>  	rk3288-veyron-jaq.dtb \
>  	rk3288-veyron-jerry.dtb \
>  	rk3288-veyron-mickey.dtb \
> +	rk3288-veyron-mighty.dtb \
>  	rk3288-veyron-minnie.dtb \
>  	rk3288-veyron-pinky.dtb \
>  	rk3288-veyron-speedy.dtb \
> diff --git a/arch/arm/boot/dts/rk3288-veyron-mighty.dts b/arch/arm/boot/dts/rk3288-veyron-mighty.dts
> new file mode 100644
> index 000000000000..59c23be3d46f
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3288-veyron-mighty.dts
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Veyron Mighty Rev 1+ board device tree source
> + *
> + * Copyright 2015 Google, Inc
> + */
> +
> +/dts-v1/;
> +
> +#include "rk3288-veyron-chromebook.dtsi"
> +#include "cros-ec-sbs.dtsi"
> +
> +/ {
> +	model = "Google Mighty";
> +	compatible = "google,veyron-mighty-rev5", "google,veyron-mighty-rev4",
> +		     "google,veyron-mighty-rev3", "google,veyron-mighty-rev2",
> +		     "google,veyron-mighty-rev1", "google,veyron-mighty",
> +		     "google,veyron", "rockchip,rk3288";
> +
> +	panel_regulator: panel-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio7 RK_PB6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lcd_enable_h>;
> +		regulator-name = "panel_regulator";
> +		startup-delay-us = <100000>;
> +		vin-supply = <&vcc33_sys>;
> +	};
> +
> +	vcc18_lcd: vcc18-lcd {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&avdd_1v8_disp_en>;
> +		regulator-name = "vcc18_lcd";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc18_wl>;
> +	};
> +
> +	backlight_regulator: backlight-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bl_pwr_en>;
> +		regulator-name = "backlight_regulator";
> +		vin-supply = <&vcc33_sys>;
> +		startup-delay-us = <15000>;
> +	};
> +};
> +
> +&backlight {
> +	/* Mighty panel PWM must be >= 3%, so start non-zero brightness at 8 */
> +	brightness-levels = <
> +		  0
> +		  8   9  10  11  12  13  14  15
> +		 16  17  18  19  20  21  22  23
> +		 24  25  26  27  28  29  30  31
> +		 32  33  34  35  36  37  38  39
> +		 40  41  42  43  44  45  46  47
> +		 48  49  50  51  52  53  54  55
> +		 56  57  58  59  60  61  62  63
> +		 64  65  66  67  68  69  70  71
> +		 72  73  74  75  76  77  78  79
> +		 80  81  82  83  84  85  86  87
> +		 88  89  90  91  92  93  94  95
> +		 96  97  98  99 100 101 102 103
> +		104 105 106 107 108 109 110 111
> +		112 113 114 115 116 117 118 119
> +		120 121 122 123 124 125 126 127
> +		128 129 130 131 132 133 134 135
> +		136 137 138 139 140 141 142 143
> +		144 145 146 147 148 149 150 151
> +		152 153 154 155 156 157 158 159
> +		160 161 162 163 164 165 166 167
> +		168 169 170 171 172 173 174 175
> +		176 177 178 179 180 181 182 183
> +		184 185 186 187 188 189 190 191
> +		192 193 194 195 196 197 198 199
> +		200 201 202 203 204 205 206 207
> +		208 209 210 211 212 213 214 215
> +		216 217 218 219 220 221 222 223
> +		224 225 226 227 228 229 230 231
> +		232 233 234 235 236 237 238 239
> +		240 241 242 243 244 245 246 247
> +		248 249 250 251 252 253 254 255>;
> +	power-supply = <&backlight_regulator>;
> +};
> +
> +&panel {
> +	power-supply = <&panel_regulator>;
> +};
> +
> +&rk808 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
> +	dvs-gpios = <&gpio7 RK_PB4 GPIO_ACTIVE_HIGH>,
> +		    <&gpio7 RK_PB7 GPIO_ACTIVE_HIGH>;
> +
> +	regulators {
> +		mic_vcc: LDO_REG2 {
> +			regulator-name = "mic_vcc";
> +			regulator-always-on;
> +			regulator-boot-on;
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +	};
> +};
> +
> +&sdmmc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
> +			&sdmmc_wp_gpio &sdmmc_bus4>;
> +	wp-gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&vcc_5v {
> +	enable-active-high;
> +	gpio = <&gpio7 RK_PC5 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&drv_5v>;
> +};
> +
> +&vcc50_hdmi {
> +	enable-active-high;
> +	gpio = <&gpio5 RK_PC3 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&vcc50_hdmi_en>;
> +};
> +
> +&pinctrl {
> +	backlight {
> +		bl_pwr_en: bl_pwr_en {
> +			rockchip,pins = <2 12 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	buck-5v {
> +		drv_5v: drv-5v {
> +			rockchip,pins = <7 21 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	hdmi {
> +		vcc50_hdmi_en: vcc50-hdmi-en {
> +			rockchip,pins = <5 19 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	lcd {
> +		lcd_enable_h: lcd-en {
> +			rockchip,pins = <7 14 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		avdd_1v8_disp_en: avdd-1v8-disp-en {
> +			rockchip,pins = <2 13 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		dvs_1: dvs-1 {
> +			rockchip,pins = <7 12 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		dvs_2: dvs-2 {
> +			rockchip,pins = <7 15 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +
> +	sdmmc {
> +		sdmmc_wp_gpio: sdmmc-wp-gpio {
> +			rockchip,pins = <7 10 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +};
> 




