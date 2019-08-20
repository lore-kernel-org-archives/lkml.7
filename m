Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07E7C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A34722CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfHTN5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:57:06 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39932 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfHTN5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:57:06 -0400
Received: from c-73-71-116-68.hsd1.ca.comcast.net ([73.71.116.68] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i04d7-0004zU-JN; Tue, 20 Aug 2019 15:56:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: remove rk3288 fennec board support
Date:   Tue, 20 Aug 2019 15:56:54 +0200
Message-ID: <3270378.xvmEzLMrnJ@phil>
In-Reply-To: <20190820100353.17728-1-kever.yang@rock-chips.com>
References: <20190820100353.17728-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kever,

Am Dienstag, 20. August 2019, 12:03:52 CEST schrieb Kever Yang:
> Since there is no one using this board, remove it.

so just to elaborate a bit, I guess this board was internal to Rockchip,
never went to the market and therefore is obsolete without any users,
right?

Also we should remove the binding  from
	Documentation/devicetree/bindings/arm/rockchip.yaml as well


Heiko


> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
>  arch/arm/boot/dts/rk3288-fennec.dts | 347 ----------------------------
>  1 file changed, 347 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/rk3288-fennec.dts
> 
> diff --git a/arch/arm/boot/dts/rk3288-fennec.dts b/arch/arm/boot/dts/rk3288-fennec.dts
> deleted file mode 100644
> index 4847cf902a15..000000000000
> --- a/arch/arm/boot/dts/rk3288-fennec.dts
> +++ /dev/null
> @@ -1,347 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -
> -/dts-v1/;
> -
> -#include "rk3288.dtsi"
> -
> -/ {
> -	model = "Rockchip RK3288 Fennec Board";
> -	compatible = "rockchip,rk3288-fennec", "rockchip,rk3288";
> -
> -	memory@0 {
> -		reg = <0x0 0x0 0x0 0x80000000>;
> -		device_type = "memory";
> -	};
> -
> -	ext_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <125000000>;
> -		clock-output-names = "ext_gmac";
> -	};
> -
> -	vcc_sys: vsys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_sys";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -};
> -
> -&cpu0 {
> -	cpu0-supply = <&vdd_cpu>;
> -};
> -
> -&emmc {
> -	bus-width = <8>;
> -	cap-mmc-highspeed;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
> -	status = "okay";
> -};
> -
> -&gmac {
> -	assigned-clocks = <&cru SCLK_MAC>;
> -	assigned-clock-parents = <&ext_gmac>;
> -	clock_in_out = "input";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>, <&phy_rst>, <&phy_pmeb>, <&phy_int>;
> -	phy-supply = <&vcc_lan>;
> -	phy-mode = "rgmii";
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 1000000>;
> -	snps,reset-gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_LOW>;
> -	tx_delay = <0x30>;
> -	rx_delay = <0x10>;
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&hdmi {
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	status = "okay";
> -	clock-frequency = <400000>;
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA4 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int &global_pwroff>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -
> -		vcc1-supply = <&vcc_sys>;
> -		vcc2-supply = <&vcc_sys>;
> -		vcc3-supply = <&vcc_sys>;
> -		vcc4-supply = <&vcc_sys>;
> -		vcc6-supply = <&vcc_sys>;
> -		vcc7-supply = <&vcc_sys>;
> -		vcc8-supply = <&vcc_io>;
> -		vcc9-supply = <&vcc_io>;
> -		vcc10-supply = <&vcc_io>;
> -		vcc11-supply = <&vcc_io>;
> -		vcc12-supply = <&vcc_io>;
> -		vddio-supply = <&vcc_io>;
> -
> -		regulators {
> -			vdd_cpu: DCDC_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-name = "vdd_arm";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_gpu: DCDC_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <1250000>;
> -				regulator-name = "vdd_gpu";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1000000>;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vcc_ddr";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_io: DCDC_REG4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc_io";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vccio_pmu: LDO_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vccio_pmu";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vcca_33: LDO_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcca_33";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_10: LDO_REG3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1000000>;
> -				regulator-max-microvolt = <1000000>;
> -				regulator-name = "vdd_10";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1000000>;
> -				};
> -			};
> -
> -			vcc_wl: LDO_REG4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_wl";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vccio_sd: LDO_REG5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vccio_sd";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vdd10_lcd: LDO_REG6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1000000>;
> -				regulator-max-microvolt = <1000000>;
> -				regulator-name = "vdd10_lcd";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1000000>;
> -				};
> -			};
> -
> -			vcc_18: LDO_REG7 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_18";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc18_lcd: LDO_REG8 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc18_lcd";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc_sd: SWITCH_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vcc_sd";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_lan: SWITCH_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vcc_lan";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&pinctrl {
> -	pcfg_output_high: pcfg-output-high {
> -		output-high;
> -	};
> -
> -	pcfg_output_low: pcfg-output-low {
> -		output-low;
> -	};
> -
> -	pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
> -		drive-strength = <8>;
> -	};
> -
> -	pcfg_pull_up_drv_8ma: pcfg-pull-up-drv-8ma {
> -		bias-pull-up;
> -		drive-strength = <8>;
> -	};
> -
> -	gmac {
> -		phy_int: phy-int {
> -			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		phy_pmeb: phy-pmeb {
> -			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		phy_rst: phy-rst {
> -			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_output_high>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int: pmic-int {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	usbphy {
> -		host_drv: host-drv {
> -			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usbphy {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&host_drv>;
> -	vbus_drv-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1 {
> -	status = "okay";
> -};
> -
> -&usb_otg {
> -	status = "okay";
> -};
> -
> -&usb_hsic {
> -	status = "okay";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> 




