Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDEEC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD8620679
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdaLSgQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfHEL2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:28:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46239 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHEL2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:28:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so36333666plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X8OgyeZPRfLVWzgNJrfW04YCeG8Qe213kRsaltgIAwk=;
        b=VdaLSgQdBUvAaMWrv9tcV/265pLUJuD2c/bUvKwzb6Fc2Nqrs4bC/Fa/E5vqMIhvxs
         pH5J07sh8BwjvIyt9ViGr4Xd/XT9K6x29AYDQihUuAPcO8ZMwC0SLYr86ArGGjPGyl1O
         yZmh2BRZTHqHLikS5ONqKlEonEMH7WxdO/b7dbi+IDQMzMHyDUOnQr/kmy4DC83itVCu
         x9QL7yvWhnc0Gkfjr/MiwRUqMPIPerMzCm/goufiezZc/vG9KdTk235yvgyg3abmsfPY
         h8CoPZ7g5R7plAuKKUcO5l0zz/x/AhacuRtcxtUEFM+GMafdPtG7+KUSfyhsk1egwDrq
         HJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X8OgyeZPRfLVWzgNJrfW04YCeG8Qe213kRsaltgIAwk=;
        b=EEawDQCbq6EP5bIpL0cqrbPCP6soVF5vQXCo+3bdr9Hn39DNbx2cBmmnizX55+oxWj
         V+YtaDCsyStURNaT2Cn4I1v3/+hJvuT1mwURjDPt+iuw7Wuh/VoEU+s80aZ/6BLvjlDU
         OCi4TF1UsbwORU5q0RdxXz2ZjFFFI8OA8VerXaH5q6rBzSdZ3pSjnsYjtDVB1SSJyu3r
         iis9gNa1QNuNi4XzOx+U2Unw+io1o+yxecyv7HThWGw1rk5C1bt7ZR7ohRNRCBYzp/zk
         Iy6CBM2H+X9DRm7mxECEn+0Gh9JllqKdkQiQskUS6/p05ddy33ODvpCoHFvcFghqpB2Y
         GgDA==
X-Gm-Message-State: APjAAAXboJAwmOqM8ufF4rPY8uI9S/tVD16piDEcg7uNJheAILKA93yy
        ilioVnv8XkhLhunnNukfjDH7
X-Google-Smtp-Source: APXvYqya3NNdgv6elOVUbXjvPYb57oFutzyp42rGG/203fJ2/IXrUJz48EBxl38u9T8O9K6PME9FmQ==
X-Received: by 2002:a17:902:7043:: with SMTP id h3mr117881740plt.10.1565004498777;
        Mon, 05 Aug 2019 04:28:18 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id b37sm33933329pjc.15.2019.08.05.04.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 04:28:18 -0700 (PDT)
Date:   Mon, 5 Aug 2019 16:58:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Elon Zhang <zhangzj@rock-chips.com>
Cc:     heiko@sntech.de, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: rockchip: Add support for TB-96AI
 board
Message-ID: <20190805112810.GA19736@mani>
References: <20190805015755.26017-1-zhangzj@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805015755.26017-1-zhangzj@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elon,

Thanks for the v2. Still the DT needs to be cleaned up a bit. I have tested this
patch on TB96-AI SOM/Carrier board and found that the USB ports are not working
at all! Do we need to change any switch settings?

Comments are inline.

On Mon, Aug 05, 2019 at 09:57:55AM +0800, Elon Zhang wrote:
> Add devicetree support for RK3399Pro TB-96AI board, one of
> the 96Boards family.
> 
> The TB-96AI board is a 96Boards Compute SOM design, launched
> by Linaro, Rockchip and Beiqicloud.
> 
> More information can be obtained from the following websites:
> 1.https://www.96boards.org/product/tb-96ai/
> 2.http://t.rock-chips.com/
> 3.http://www.beiqicloud.com/
> 
> This patch add basic node for the board and support booting up
> to Fedora.
> 
> Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
> ---
> changes since v1:
> - remove needless node
> - using a standard LED formats for 96Boards
> 
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3399pro-tb-96ai.dts   | 560 ++++++++++++++++++
>  2 files changed, 561 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro-tb-96ai.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 5f2687acbf94..3d6c8d4363b5 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -27,3 +27,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-tb-96ai.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-tb-96ai.dts b/arch/arm64/boot/dts/rockchip/rk3399pro-tb-96ai.dts
> new file mode 100644
> index 000000000000..767b37b854ba
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-tb-96ai.dts
> @@ -0,0 +1,560 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd.
> + */
> +
> +/dts-v1/;
> +#include "rk3399pro.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	compatible = "beiqi,rk3399pro-tb-96ai", "rockchip,rk3399pro";
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	xin32k: xin32k {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		clock-output-names = "xin32k";
> +		#clock-cells = <0>;
> +	};
> +
> +	vcc5v0_sys: vccsys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	leds {

Still the LEDs are not defined as per the format I shared before...

> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&work_led1>,<&work_led2>,<&work_led3>;
> +
> +		work_led1 {
> +			gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
> +			label = "system_work_led1";
> +			retain-state-suspended;
> +		};
> +
> +		work_led2 {
> +			gpios = <&gpio2 4 GPIO_ACTIVE_HIGH>;
> +			label = "system_work_led2";
> +			retain-state-suspended;
> +		};
> +
> +		work_led3 {
> +			gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
> +			label = "system_work_led3";
> +			retain-state-suspended;
> +		};
> +	};
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_b>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_b>;
> +};
> +
> +&emmc_phy {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	i2c-scl-rising-time-ns = <180>;
> +	i2c-scl-falling-time-ns = <30>;
> +	clock-frequency = <400000>;
> +
> +	rk809: pmic@20 {
> +		compatible = "rockchip,rk809";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <RK_PC2 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default", "pmic-sleep",
> +				"pmic-power-off", "pmic-reset";

Does these pinctrl configs useful other than default?

> +		pinctrl-0 = <&pmic_int_l>;
> +		pinctrl-1 = <&soc_slppin_slp>, <&rk809_slppin_slp>;
> +		pinctrl-2 = <&soc_slppin_gpio>, <&rk809_slppin_pwrdn>;
> +		pinctrl-3 = <&soc_slppin_gpio>,<&rk809_slppin_null>;
> +		rockchip,system-power-controller;
> +		pmic-reset-func = <1>;
> +		wakeup-source;
> +		#clock-cells = <1>;
> +		clock-output-names = "rk808-clkout1", "rk808-clkout2";
> +
> +		vcc1-supply = <&vcc5v0_sys>;
> +		vcc2-supply = <&vcc5v0_sys>;
> +		vcc3-supply = <&vcc5v0_sys>;
> +		vcc4-supply = <&vcc5v0_sys>;
> +		vcc5-supply = <&vcc_buck5>;
> +		vcc6-supply = <&vcc_buck5>;
> +		vcc7-supply = <&vcc3v3_sys>;
> +		vcc8-supply = <&vcc3v3_sys>;
> +		vcc9-supply = <&vcc5v0_sys>;
> +
> +		pwrkey {
> +			status = "okay";

No compatible needed?

> +		};
> +
> +		rtc {
> +			status = "okay";

No compatible needed?

> +		};
> +
> +		pinctrl_rk8xx: pinctrl_rk8xx {

Mainline MFD driver has no pinctrl support for RK809.

> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			rk809_slppin_null: rk809_slppin_null {
> +				pins = "gpio_slp";
> +				function = "pin_fun0";
> +			};
> +
> +			rk809_slppin_slp: rk809_slppin_slp {
> +				pins = "gpio_slp";
> +				function = "pin_fun1";
> +			};
> +
> +			rk809_slppin_pwrdn: rk809_slppin_pwrdn {
> +				pins = "gpio_slp";
> +				function = "pin_fun2";
> +			};
> +
> +			rk809_slppin_rst: rk809_slppin_rst {
> +				pins = "gpio_slp";
> +				function = "pin_fun3";
> +			};
> +		};
> +
> +		regulators {
> +			vdd_center: DCDC_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vdd_center";

Please match the regulator names with schematic.

> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <900000>;
> +				};
> +			};
> +
> +			vdd_cpu_l: DCDC_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vdd_cpu_l";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vcc_ddr";
> +				regulator-initial-mode = <0x2>;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_sys: DCDC_REG4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vcc3v3_sys";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcc_buck5: DCDC_REG5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <2200000>;
> +				regulator-max-microvolt = <2200000>;
> +				regulator-name = "vcc_buck5";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <2200000>;
> +				};
> +			};
> +
> +			vcca_0v9: LDO_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-name = "vcca_0v9";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8: LDO_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-name = "vcc_1v8";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcc0v9_soc: LDO_REG3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-name = "vcc0v9_soc";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <900000>;
> +				};
> +			};
> +
> +			vcca_1v8: LDO_REG4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-name = "vcca_1v8";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd1v5_dvp: LDO_REG5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +
> +				regulator-name = "vdd1v5_dvp";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v5: LDO_REG6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +
> +				regulator-name = "vcc_1v5";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v0: LDO_REG7 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +
> +				regulator-name = "vcc_3v0";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG8 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-name = "vccio_sd";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcc_sd: LDO_REG9 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-name = "vcc_sd";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcc5v0_usb: SWITCH_REG1 {
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5000000>;
> +
> +				regulator-name = "vcc5v0_usb";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_3v3: SWITCH_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-name = "vccio_3v3";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +
> +	vdd_cpu_b: regulator@1c {
> +		compatible = "fcs,fan53555";
> +		reg = <0x1c>;
> +		vin-supply = <&vcc5v0_sys>;
> +		pinctrl-0 = <&vsel1_gpio>;
> +		vsel-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vdd_cpu_b";
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-ramp-delay = <2300>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-initial-state = <3>;
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vdd_gpu: regulator@10 {
> +		compatible = "fcs,fan53555";
> +		status = "okay";
> +		reg = <0x10>;
> +		vin-supply = <&vcc5v0_sys>;
> +		pinctrl-0 = <&vsel2_gpio>;
> +		vsel-gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vdd_gpu";
> +		regulator-min-microvolt = <735000>;
> +		regulator-max-microvolt = <1400000>;
> +		regulator-ramp-delay = <2300>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +	i2c-scl-rising-time-ns = <345>;
> +	i2c-scl-falling-time-ns = <11>;
> +	clock-frequency = <100000>;
> +};
> +
> +&io_domains {
> +	status = "okay";
> +	bt656-supply = <&vcca_1v8>; /* APIO2_VDD */
> +	audio-supply = <&vcca_1v8>; /* APIO5_VDD */
> +	sdmmc-supply = <&vccio_sd>; /* SDMMC0_VDD */
> +	gpio1830-supply = <&vcc_1v8>; /* APIO4_VDD */
> +};
> +
> +&pinctrl {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&npu_ref_clk>;
> +
> +	leds {
> +		work_led1: work_led1 {
> +			rockchip,pins =
> +				<2 5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		work_led2: work_led2 {
> +			rockchip,pins =
> +				<2 4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		work_led3: work_led3 {
> +			rockchip,pins =
> +				<2 3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	npu_clk {
> +		npu_ref_clk: npu-ref-clk {
> +			rockchip,pins =
> +				<0 RK_PA2 1 &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int_l: pmic-int-l {
> +			rockchip,pins =
> +				<1 RK_PC2 0 &pcfg_pull_up>;
> +		};
> +
> +		soc_slppin_gpio: soc-slppin-gpio {
> +			rockchip,pins =
> +				<1 RK_PA5 0 &pcfg_output_low>;
> +		};
> +
> +		soc_slppin_slp: soc-slppin-slp {
> +			rockchip,pins =
> +				<1 RK_PA5 1 &pcfg_pull_down>;
> +		};
> +
> +		vsel1_gpio: vsel1-gpio {
> +			rockchip,pins =
> +				<1 RK_PC1 0 &pcfg_pull_down>;
> +		};
> +
> +		vsel2_gpio: vsel2-gpio {
> +			rockchip,pins =
> +				<1 RK_PB6 0 &pcfg_pull_down>;
> +		};
> +	};
> +
> +	usb3 {
> +		usb3_host_en: usb3-host-en {
> +			rockchip,pins =
> +				<2 RK_PA2 RK_FUNC_GPIO &pcfg_output_high>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	status = "okay";
> +	pmu1830-supply = <&vcc_1v8>;
> +};
> +
> +&pwm0 {
> +	status = "okay";
> +};
> +
> +&pwm2 {
> +	status = "okay";
> +};
> +
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vcc_1v8>;
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	mmc-hs400-1_8v;
> +	non-removable;
> +	keep-power-in-suspend;
> +	mmc-hs400-enhanced-strobe;
> +	status = "okay";
> +};
> +
> +&tcphy1 {

No tcphy0? I can see this used in schematics.

> +	status = "okay";
> +};
> +
> +&tsadc {
> +	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
> +	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
> +	status = "okay";
> +};
> +
> +&u2phy1 {

No u2phy0?

> +	status = "okay";
> +
> +	u2phy1_otg: otg-port {
> +		status = "okay";
> +	};
> +
> +	u2phy1_host: host-port {
> +		phy-supply = <&vcc5v0_usb>;
> +		status = "okay";
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_xfer &uart0_cts>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
> +
> +&usbdrd3_1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb3_host_en>;
> +};
> +
> +&usbdrd_dwc3_0 {

No usbdrd3_0?

Thanks,
Mani

> +	status = "okay";
> +};
> +
> +&usbdrd_dwc3_1 {
> +	snps,dis-u3-autosuspend-quirk;
> +	status = "okay";
> +};
> +
> -- 
> 2.17.1
> 
> 
> 
