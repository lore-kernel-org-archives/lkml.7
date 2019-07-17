Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E232C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128EE2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIN+OtWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfGQPtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:49:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34588 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfGQPtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:49:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so5139693pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hb8N+mCFumP5UIT7Eh4a1labnAOOM9xbh6gKdDBYW5Q=;
        b=AIN+OtWZpALMA/6mVYgUvkuUZDCOq3PhN2fC8pFp3/k5xeMRxBM7ZiCfb1iF8cWQFc
         1U/w1+DXHTA3ZzHg4IhWB1R96yhb6w6KHxbWkEVSgI3geYcKYqkZa9Ahe91uEAJZOg6j
         73mLHvsm5bjqKIUm1zR0m+Id04TBdM36xskAD6TsV+ppbvwM1p1gmwzfarY2vDujtJCG
         nuOhY9f0HFecxpHt+HH9BHKEet6mgdTXHtrMIBRblbW0BHrw4OfPqkccDgwT+R34OU1j
         oMSXwgihNPlxGFsy5zBltFBhYyqTeZZIuGXpkt+yVhkOodjoo877cN95oHzS37zvRTz/
         uFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hb8N+mCFumP5UIT7Eh4a1labnAOOM9xbh6gKdDBYW5Q=;
        b=uGsrbmwmZ8MpJjuxWJB0xmTNpSo2QHHxRssX7NuCr+JsJNmna3pQhk+1ss5cNmMyBC
         gULxGDgtofVqyyO1zowGxDpvltgpX3gBn2BjYdYKYM2W5tkXkvVto+crkxdIcvquIESX
         /4QGkUmiMGttramBphQnq6hPQKQOKJcZmXcoFgD3woR7YsaYfnJYqJiEwNOqvL4zowWV
         BrVJHXBU8HICMGuHF34LXbxB+euEYwFVtZ6j6Mc02T6ZEivFycL/+7Aaj7waAwByA4zN
         C+8hixOX9fwhxidgd4T4KKO3IRiHvCd2iip8P/iE+yzo3wzG0CopIQdz7KZAWG3e04bO
         oqcg==
X-Gm-Message-State: APjAAAWZYmoZ5b4+bc8VgUndLTkGmTtjmENUDvyOcQqlVk85kgOEyo7B
        3JR3lCzhfsgEaOjncm7CojzmHuEDog==
X-Google-Smtp-Source: APXvYqzGPfjSUgzu9EJS+jesGmyy7H6akD6VHPTEE1Z+a/z2iyglKTLJV3n/RgHTasYigT82Ospqmg==
X-Received: by 2002:a63:460c:: with SMTP id t12mr41690337pga.69.1563378578573;
        Wed, 17 Jul 2019 08:49:38 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:7301:59e6:f493:40df:9c8a:5041])
        by smtp.gmail.com with ESMTPSA id r9sm34291161pjq.3.2019.07.17.08.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 08:49:37 -0700 (PDT)
Date:   Wed, 17 Jul 2019 21:19:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Elon Zhang <zhangzj@rock-chips.com>
Cc:     heiko@sntech.de, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/1] arm64: dts: rockchip: Add support for TB-96AI
 board
Message-ID: <20190717154929.GB13269@Mani-XPS-13-9360>
References: <20190711021209.32529-1-zhangzj@rock-chips.com>
 <20190717154752.GA13269@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717154752.GA13269@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 09:17:52PM +0530, Manivannan Sadhasivam wrote:
> Hi Elon,
> 
> Thanks for the patch. Overall, this patch needs a bit of cleanup. There
> are many nodes added which are not available in mainline.
> 
> Please see comments inline.
> 
> On Thu, Jul 11, 2019 at 10:12:09AM +0800, Elon Zhang wrote:
> > Add devicetree support for RK3399Pro TB-96AI board, one of
> > the 96Boards family.
> > 
> > The TB-96AI board is a 96Boards Compute SOM design, launched
> > by Linaro, Rockchip and Beiqicloud.
> > 
> > More information can be obtained from the following websites:
> > 1.https://www.96boards.org/product/tb-96ai/
> > 2.http://t.rock-chips.com/
> > 3.http://www.beiqicloud.com/
> > 
> > This patch add basic node for the board and support booting up
> > to Fedora.
> > 
> > Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index 5f2687acbf94..3d6c8d4363b5 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -27,3 +27,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-tb-96ai.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-tb-96ai.dts b/arch/arm64/boot/dts/rockchip/rk3399pro-tb-96ai.dts
> > new file mode 100644
> > index 000000000000..1935df99065d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-tb-96ai.dts
> > @@ -0,0 +1,629 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd.
> > + */
> > +
> > +/dts-v1/;
> > +#include "rk3399pro.dtsi"
> > +#include "rk3399-opp.dtsi"
> > +
> > +/ {
> > +	compatible = "rockchip,rk3399pro-tb-96ai", "rockchip,rk3399pro";
> > +
> 
> I think the manufacturer of this board is, Xiamen Beiqi Technology Co. Ltd.
> So, the compatible should be:
> 
> compatible = "beiqui,rk3399pro-tb-96ai", "rockchip,rk3399pro";

s/beiqui/beiqi

> 
> And there should a separate patch to add the vendor prefix. You can refer
> below patch:
> 
> https://lkml.org/lkml/2019/7/17/39
> 
> > +	chosen {
> > +		stdout-path = "serial2:1500000n8";
> > +	};
> > +
> > +	xin32k: xin32k {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <32768>;
> > +		clock-output-names = "xin32k";
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	vcc_phy: vcc-phy-regulator {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc_phy";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +	};
> > +
> > +	vcc5v0_sys: vccsys {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc5v0_sys";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +	};
> > +
> > +	vdd_log: vdd_log {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vdd_log";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <900000>;
> > +		regulator-max-microvolt = <900000>;
> > +	};
> > +
> > +	leds: gpio-leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 =<&leds_gpio>;
> 
> Leave a space after =
> 
> > +
> > +		led@1 {
> > +			gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
> > +			label = "system_work_led1";
> > +			retain-state-suspended;
> > +		};
> > +
> 
> We are using a standard LED formats for all 96Boards. Please see,
> rk3399-rock960.dts for reference. Since there is only user leds
> (apart from power leds), just define those as per the format.
> 
> > +		led@2 {
> > +			gpios = <&gpio2 4 GPIO_ACTIVE_HIGH>;
> > +			label = "system_work_led2";
> > +			retain-state-suspended;
> > +		};
> > +
> > +		led@3 {
> > +			gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
> > +			label = "system_work_led3";
> > +			retain-state-suspended;
> > +		};
> > +	};
> > +};
> > +
> > +&cpu_l0 {
> > +	cpu-supply = <&vdd_cpu_l>;
> > +};
> > +
> > +&cpu_l1 {
> > +	cpu-supply = <&vdd_cpu_l>;
> > +};
> > +
> > +&cpu_l2 {
> > +	cpu-supply = <&vdd_cpu_l>;
> > +};
> > +
> > +&cpu_l3 {
> > +	cpu-supply = <&vdd_cpu_l>;
> > +};
> > +
> > +&cpu_b0 {
> > +	cpu-supply = <&vdd_cpu_b>;
> > +};
> > +
> > +&cpu_b1 {
> > +	cpu-supply = <&vdd_cpu_b>;
> > +};
> > +
> > +&emmc_phy {
> > +	status = "okay";
> > +};
> > +
> > +&i2c0 {
> > +	status = "okay";
> > +	i2c-scl-rising-time-ns = <180>;
> > +	i2c-scl-falling-time-ns = <30>;
> > +	clock-frequency = <400000>;
> > +
> > +	rk809: pmic@20 {
> > +		compatible = "rockchip,rk809";
> 
> It looks like this driver is not present in mainline yet. I can see
> some old patches in lkml archive but not sure about the status of those.
> So, please remove this node and use dummy regulators where applicable.
> 
> > +		reg = <0x20>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <RK_PC2 IRQ_TYPE_LEVEL_LOW>;
> > +		pinctrl-names = "default", "pmic-sleep",
> > +				"pmic-power-off", "pmic-reset";
> > +		pinctrl-0 = <&pmic_int_l>;
> > +		pinctrl-1 = <&soc_slppin_slp>, <&rk809_slppin_slp>;
> > +		pinctrl-2 = <&soc_slppin_gpio>, <&rk809_slppin_pwrdn>;
> > +		pinctrl-3 = <&soc_slppin_gpio>,<&rk809_slppin_null>;
> > +		rockchip,system-power-controller;
> > +		pmic-reset-func = <1>;
> > +		wakeup-source;
> > +		#clock-cells = <1>;
> > +		clock-output-names = "rk808-clkout1", "rk808-clkout2";
> > +
> > +		vcc1-supply = <&vcc5v0_sys>;
> > +		vcc2-supply = <&vcc5v0_sys>;
> > +		vcc3-supply = <&vcc5v0_sys>;
> > +		vcc4-supply = <&vcc5v0_sys>;
> > +		vcc5-supply = <&vcc_buck5>;
> > +		vcc6-supply = <&vcc_buck5>;
> > +		vcc7-supply = <&vcc3v3_sys>;
> > +		vcc8-supply = <&vcc3v3_sys>;
> > +		vcc9-supply = <&vcc5v0_sys>;
> > +
> > +		pwrkey {
> > +			status = "okay";
> > +		};
> > +
> > +		rtc {
> > +			status = "okay";
> > +		};
> > +
> > +		pinctrl_rk8xx: pinctrl_rk8xx {
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +
> > +			rk809_slppin_null: rk809_slppin_null {
> > +				pins = "gpio_slp";
> > +				function = "pin_fun0";
> > +			};
> > +
> > +			rk809_slppin_slp: rk809_slppin_slp {
> > +				pins = "gpio_slp";
> > +				function = "pin_fun1";
> > +			};
> > +
> > +			rk809_slppin_pwrdn: rk809_slppin_pwrdn {
> > +				pins = "gpio_slp";
> > +				function = "pin_fun2";
> > +			};
> > +
> > +			rk809_slppin_rst: rk809_slppin_rst {
> > +				pins = "gpio_slp";
> > +				function = "pin_fun3";
> > +			};
> > +		};
> > +
> > +		regulators {
> > +			vdd_center: DCDC_REG1 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <750000>;
> > +				regulator-max-microvolt = <1350000>;
> > +				regulator-initial-mode = <0x2>;
> > +				regulator-name = "vdd_center";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <900000>;
> > +				};
> > +			};
> > +
> > +			vdd_cpu_l: DCDC_REG2 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <750000>;
> > +				regulator-max-microvolt = <1350000>;
> > +				regulator-ramp-delay = <6001>;
> > +				regulator-initial-mode = <0x2>;
> > +				regulator-name = "vdd_cpu_l";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc_ddr: DCDC_REG3 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-name = "vcc_ddr";
> > +				regulator-initial-mode = <0x2>;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc3v3_sys: DCDC_REG4 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-initial-mode = <0x2>;
> > +				regulator-name = "vcc3v3_sys";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <3300000>;
> > +				};
> > +			};
> > +
> > +			vcc_buck5: DCDC_REG5 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <2200000>;
> > +				regulator-max-microvolt = <2200000>;
> > +				regulator-name = "vcc_buck5";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <2200000>;
> > +				};
> > +			};
> > +
> > +			vcca_0v9: LDO_REG1 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <900000>;
> > +				regulator-max-microvolt = <900000>;
> > +				regulator-name = "vcca_0v9";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc_1v8: LDO_REG2 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +
> > +				regulator-name = "vcc_1v8";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <1800000>;
> > +				};
> > +			};
> > +
> > +			vcc0v9_soc: LDO_REG3 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <900000>;
> > +				regulator-max-microvolt = <900000>;
> > +
> > +				regulator-name = "vcc0v9_soc";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <900000>;
> > +				};
> > +			};
> > +
> > +			vcca_1v8: LDO_REG4 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +
> > +				regulator-name = "vcca_1v8";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdd1v5_dvp: LDO_REG5 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1500000>;
> > +				regulator-max-microvolt = <1500000>;
> > +
> > +				regulator-name = "vdd1v5_dvp";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc_1v5: LDO_REG6 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1500000>;
> > +				regulator-max-microvolt = <1500000>;
> > +
> > +				regulator-name = "vcc_1v5";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc_3v0: LDO_REG7 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <3000000>;
> > +				regulator-max-microvolt = <3000000>;
> > +
> > +				regulator-name = "vcc_3v0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vccio_sd: LDO_REG8 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <3300000>;
> > +
> > +				regulator-name = "vccio_sd";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <3300000>;
> > +				};
> > +			};
> > +
> > +			vcc_sd: LDO_REG9 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +
> > +				regulator-name = "vcc_sd";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <3300000>;
> > +				};
> > +			};
> > +
> > +			vcc5v0_usb: SWITCH_REG1 {
> > +				regulator-min-microvolt = <5000000>;
> > +				regulator-max-microvolt = <5000000>;
> > +
> > +				regulator-name = "vcc5v0_usb";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vccio_3v3: SWITCH_REG2 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +
> > +				regulator-name = "vccio_3v3";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	vdd_cpu_b: tcs452x@1c {
> > +		compatible = "tcs,tcs452x";
> 
> Again, there is no driver for this.
> 
> > +		reg = <0x1c>;
> > +		vin-supply = <&vcc5v0_sys>;
> > +		regulator-compatible = "fan53555-reg";
> > +		pinctrl-0 = <&vsel1_gpio>;
> > +		vsel-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> > +		regulator-name = "vdd_cpu_b";
> > +		regulator-min-microvolt = <712500>;
> > +		regulator-max-microvolt = <1500000>;
> > +		regulator-ramp-delay = <2300>;
> > +		fcs,suspend-voltage-selector = <1>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-initial-state = <3>;
> > +		regulator-state-mem {
> > +			regulator-off-in-suspend;
> > +		};
> > +	};
> > +
> > +	vdd_gpu: tcs452x@10 {
> > +		compatible = "tcs,tcs452x";
> 
> ditto.
> 
> > +		status = "okay";
> > +		reg = <0x10>;
> > +		vin-supply = <&vcc5v0_sys>;
> > +		regulator-compatible = "fan53555-reg";
> > +		pinctrl-0 = <&vsel2_gpio>;
> > +		vsel-gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
> > +		regulator-name = "vdd_gpu";
> > +		regulator-min-microvolt = <735000>;
> > +		regulator-max-microvolt = <1400000>;
> > +		regulator-ramp-delay = <2300>;
> > +		fcs,suspend-voltage-selector = <1>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-state-mem {
> > +			regulator-off-in-suspend;
> > +		};
> > +	};
> > +
> > +};
> > +
> > +&i2c8 {
> > +	status = "okay";
> > +	i2c-scl-rising-time-ns = <345>;
> > +	i2c-scl-falling-time-ns = <11>;
> > +	clock-frequency = <100000>;
> > +
> > +	fusb0: fusb30x@22 {
> > +		compatible = "fairchild,fusb302";
> 
> ditto, please remove.
> 
> > +		reg = <0x22>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&fusb0_int>;
> > +		int-n-gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
> > +		vbus-5v-gpios = <&gpio0 RK_PA1 GPIO_ACTIVE_LOW>;
> > +		status = "okay";
> > +	};
> > +
> > +};
> > +
> > +&io_domains {
> > +	status = "okay";
> > +	bt656-supply = <&vcca_1v8>; /* APIO2_VDD */
> > +	audio-supply = <&vcca_1v8>; /* APIO5_VDD */
> > +	sdmmc-supply = <&vccio_sd>; /* SDMMC0_VDD */
> > +	gpio1830-supply = <&vcc_1v8>; /* APIO4_VDD */
> > +};
> > +
> > +&pinctrl {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&npu_ref_clk>;
> > +
> > +	fusb30x {
> > +		fusb0_int: fusb0-int {
> > +			rockchip,pins =
> > +				<1 RK_PA2 0 &pcfg_pull_up>;
> > +		};
> > +	};
> 
> not needed.
> 
> > +
> > +	gpio-leds {
> > +		leds_gpio: leds-gpio {
> > +			rockchip,pins =
> > +				<2 5 RK_FUNC_GPIO &pcfg_pull_up>,
> > +				<2 4 RK_FUNC_GPIO &pcfg_pull_up>,
> > +				<2 3 RK_FUNC_GPIO &pcfg_pull_up>;
> 
> I don't think we need pull-up here.
> 
> > +		};
> > +	};
> > +
> > +	npu_clk {
> > +		npu_ref_clk: npu-ref-clk {
> > +			rockchip,pins =
> > +				<0 RK_PA2 1 &pcfg_pull_none>;
> > +		};
> > +	};
> > +
> > +	pmic {
> > +		pmic_int_l: pmic-int-l {
> > +			rockchip,pins =
> > +				<1 RK_PC2 0 &pcfg_pull_up>;
> > +		};
> > +
> > +		soc_slppin_gpio: soc-slppin-gpio {
> > +			rockchip,pins =
> > +				<1 RK_PA5 0 &pcfg_output_low>;
> > +		};
> > +
> > +		soc_slppin_slp: soc-slppin-slp {
> > +			rockchip,pins =
> > +				<1 RK_PA5 1 &pcfg_pull_down>;
> > +		};
> > +
> > +		vsel1_gpio: vsel1-gpio {
> > +			rockchip,pins =
> > +				<1 RK_PC1 0 &pcfg_pull_down>;
> > +		};
> > +
> > +		vsel2_gpio: vsel2-gpio {
> > +			rockchip,pins =
> > +				<1 RK_PB6 0 &pcfg_pull_down>;
> > +		};
> > +	};
> 
> not needed.
> 
> > +
> > +	usb3 {
> > +		usb3_host_en: usb3-host-en {
> > +			rockchip,pins =
> > +				<2 RK_PA2 RK_FUNC_GPIO &pcfg_output_high>;
> > +		};
> > +	};
> > +};
> > +
> > +&pmu_io_domains {
> > +	status = "okay";
> > +	pmu1830-supply = <&vcc_1v8>;
> > +};
> > +
> > +&pwm0 {
> > +	status = "okay";
> > +};
> > +
> > +&pwm2 {
> > +	status = "okay";
> > +};
> > +
> > +&saradc {
> > +	status = "okay";
> > +	vref-supply = <&vcc_1v8>;
> > +};
> > +
> > +&sdhci {
> > +	bus-width = <8>;
> > +	mmc-hs400-1_8v;
> > +	supports-emmc;
> 
> there is no such property, so please remove. Since this controller is
> used for emmc, you can use "no-sd" and "no-sdio" properties if needed.
> 
> > +	non-removable;
> > +	keep-power-in-suspend;
> > +	mmc-hs400-enhanced-strobe;
> > +	status = "okay";
> > +};
> > +
> > +&sdmmc {
> > +	clock-frequency = <150000000>;
> > +	clock-freq-min-max = <400000 150000000>;
> > +	supports-sd;
> 
> Same as above, property not available. Use, "no-sdio" and "no-emmc" if
> needed.
> 
> > +	bus-width = <4>;
> > +	cap-mmc-highspeed;
> > +	cap-sd-highspeed;
> > +	disable-wp;
> > +	num-slots = <1>;
> 
> not needed.
> 
> > +	vqmmc-supply = <&vccio_sd>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> > +	status = "okay";
> > +};
> > +
> > +&tcphy0 {
> > +	extcon = <&fusb0>;
> > +	status = "okay";
> > +};
> > +
> > +&tcphy1 {
> > +	status = "okay";
> > +};
> > +
> > +&tsadc {
> > +	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
> > +	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
> 
> Any clue about shutdown temperature? Not necessary now but good to have.
> 
> Thanks,
> Mani
> > +	status = "okay";
> > +};
> > +
> > +&u2phy0 {
> > +	status = "okay";
> > +	extcon = <&fusb0>;
> > +
> > +	u2phy0_otg: otg-port {
> > +		status = "okay";
> > +	};
> > +
> > +	u2phy0_host: host-port {
> > +		phy-supply = <&vcc5v0_usb>;
> > +		status = "okay";
> > +	};
> > +};
> > +
> > +&u2phy1 {
> > +	status = "okay";
> > +
> > +	u2phy1_otg: otg-port {
> > +		status = "okay";
> > +	};
> > +
> > +	u2phy1_host: host-port {
> > +		phy-supply = <&vcc5v0_usb>;
> > +		status = "okay";
> > +	};
> > +};
> > +
> > +&uart0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart0_xfer &uart0_cts>;
> > +	status = "okay";
> > +};
> > +
> > +&uart2 {
> > +	status = "okay";
> > +};
> > +
> > +&uart4 {
> > +	status = "okay";
> > +};
> > +
> > +&usb_host0_ehci {
> > +	status = "okay";
> > +};
> > +
> > +&usb_host1_ehci {
> > +	status = "okay";
> > +};
> > +
> > +&usb_host0_ohci {
> > +	status = "okay";
> > +};
> > +
> > +&usb_host1_ohci {
> > +	status = "okay";
> > +};
> > +
> > +&usbdrd3_0 {
> > +	extcon = <&fusb0>;
> > +	status = "okay";
> > +};
> > +
> > +&usbdrd3_1 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&usb3_host_en>;
> > +};
> > +
> > +&usbdrd_dwc3_0 {
> > +	status = "okay";
> > +};
> > +
> > +&usbdrd_dwc3_1 {
> > +	snps,dis-u3-autosuspend-quirk;
> > +	status = "okay";
> > +};
> > +
> > -- 
> > 2.17.1
> > 
> > 
> > 
