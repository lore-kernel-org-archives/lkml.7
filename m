Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6C3C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1910422DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdXTC5jG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfHUDLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:11:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44952 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHUDLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:11:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so497529plr.11;
        Tue, 20 Aug 2019 20:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=G1nCXC76Y9r1PcPPOKzrGIXejyI4Br6vCxf/JF13SUc=;
        b=BdXTC5jG4VY3o0fafmPYbfsWwNGPdGmN9na1gtIhXyF6b7/bwudsncmj/8nZqItNA4
         avx3G/BGDKzMnIGHE2hDPsRy1PtcYKOPJRVxPl4CPp5ho3mXg1+qwHSwyzlLnKFbeEvX
         oRmjskC47D/mLuwZmd9uIs/SAsS0Vdp9I3m4M5zKOEN1us2baju1qxYzmStq/xzYb8RJ
         gqYUBrNXTB/9R/0CS8Xyo5eH/zqzsBb0ED0jKFfuIZ7sTaNQhbURE/QKuNmOTmV7uJQ3
         2leMML6ZS+0UlvHl/a65ZqGj8JQ1TVIJkyuSz4AybsrLGHdC0lDgwRC/xJNYJv/J7kHs
         YCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=G1nCXC76Y9r1PcPPOKzrGIXejyI4Br6vCxf/JF13SUc=;
        b=EizuFqTD2fzM/6L/5LifMAWRDcpJM8wvG6GQOSn5vHbBmd50Y/skUU0cArGsQqWODv
         e/GXKiCRnCIOr2PvxEIVPRU5ATwjexLknCsnHbqd0kJ1oFTqAhxFNs2IAiiH0t1QdScj
         vE/1z0EiGV+ULnvhcV7fXkphf/00lMOKFPzBWZjoiUsvpLn0bRz8CbpUlQ+zjFet20xw
         iIcATRcOsT8sSTV6eT9uAFHyZM80MFo2N5S6TZBDNiQx8W2sKsJEK6E48puCkMYBS+Zx
         yNWIDNMSCCUmnpDFN+Hclbr0lQce2B4nB24Rx0TxcCIqN1eue+4yuxZFPrm8eSf1tSXb
         bJyA==
X-Gm-Message-State: APjAAAW3OhsWVSuu2fSgC5J0CPeCu0P3Sfk8+bB1OV4VZ9owKDCYbnjZ
        Mp+gBbkEZaI6KjQErAb4H2Q=
X-Google-Smtp-Source: APXvYqy7eWPBVFweNo/cjownlohtsfCfUu3BqcrOaYaqSP+oshYjVS/K7Q8dQsMcqmatl6seBPeexA==
X-Received: by 2002:a17:902:1a7:: with SMTP id b36mr30833779plb.115.1566357103884;
        Tue, 20 Aug 2019 20:11:43 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id j15sm21540009pfe.3.2019.08.20.20.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 20:11:43 -0700 (PDT)
From:   Kever Yang <kever.yang@rock-chips.com>
To:     heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: rockchip: remove rk3288 fennec board support
Date:   Wed, 21 Aug 2019 11:11:23 +0800
Message-Id: <20190821031124.17806-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is no one using this board, remove it.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2:
- update document at the same time

 arch/arm/boot/dts/Makefile          |   1 -
 arch/arm/boot/dts/rk3288-fennec.dts | 347 ----------------------------
 2 files changed, 348 deletions(-)
 delete mode 100644 arch/arm/boot/dts/rk3288-fennec.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9159fa2cea90..1437ff8fe727 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -907,7 +907,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3229-evb.dtb \
 	rk3288-evb-act8846.dtb \
 	rk3288-evb-rk808.dtb \
-	rk3288-fennec.dtb \
 	rk3288-firefly-beta.dtb \
 	rk3288-firefly.dtb \
 	rk3288-firefly-reload.dtb \
diff --git a/arch/arm/boot/dts/rk3288-fennec.dts b/arch/arm/boot/dts/rk3288-fennec.dts
deleted file mode 100644
index 4847cf902a15..000000000000
--- a/arch/arm/boot/dts/rk3288-fennec.dts
+++ /dev/null
@@ -1,347 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-
-/dts-v1/;
-
-#include "rk3288.dtsi"
-
-/ {
-	model = "Rockchip RK3288 Fennec Board";
-	compatible = "rockchip,rk3288-fennec", "rockchip,rk3288";
-
-	memory@0 {
-		reg = <0x0 0x0 0x0 0x80000000>;
-		device_type = "memory";
-	};
-
-	ext_gmac: external-gmac-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <125000000>;
-		clock-output-names = "ext_gmac";
-	};
-
-	vcc_sys: vsys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-};
-
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-};
-
-&emmc {
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	non-removable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
-	status = "okay";
-};
-
-&gmac {
-	assigned-clocks = <&cru SCLK_MAC>;
-	assigned-clock-parents = <&ext_gmac>;
-	clock_in_out = "input";
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins>, <&phy_rst>, <&phy_pmeb>, <&phy_int>;
-	phy-supply = <&vcc_lan>;
-	phy-mode = "rgmii";
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
-	snps,reset-gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_LOW>;
-	tx_delay = <0x30>;
-	rx_delay = <0x10>;
-	status = "okay";
-};
-
-&gpu {
-	mali-supply = <&vdd_gpu>;
-	status = "okay";
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	rk808: pmic@1b {
-		compatible = "rockchip,rk808";
-		reg = <0x1b>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA4 IRQ_TYPE_LEVEL_LOW>;
-		#clock-cells = <1>;
-		clock-output-names = "xin32k", "rk808-clkout2";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int &global_pwroff>;
-		rockchip,system-power-controller;
-		wakeup-source;
-
-		vcc1-supply = <&vcc_sys>;
-		vcc2-supply = <&vcc_sys>;
-		vcc3-supply = <&vcc_sys>;
-		vcc4-supply = <&vcc_sys>;
-		vcc6-supply = <&vcc_sys>;
-		vcc7-supply = <&vcc_sys>;
-		vcc8-supply = <&vcc_io>;
-		vcc9-supply = <&vcc_io>;
-		vcc10-supply = <&vcc_io>;
-		vcc11-supply = <&vcc_io>;
-		vcc12-supply = <&vcc_io>;
-		vddio-supply = <&vcc_io>;
-
-		regulators {
-			vdd_cpu: DCDC_REG1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-name = "vdd_arm";
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_gpu: DCDC_REG2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1250000>;
-				regulator-name = "vdd_gpu";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc_ddr: DCDC_REG3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vcc_ddr";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_io: DCDC_REG4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc_io";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vccio_pmu: LDO_REG1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vccio_pmu";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcca_33: LDO_REG2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcca_33";
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_10: LDO_REG3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-name = "vdd_10";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc_wl: LDO_REG4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc_wl";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vccio_sd: LDO_REG5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vccio_sd";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vdd10_lcd: LDO_REG6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-name = "vdd10_lcd";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc_18: LDO_REG7 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc_18";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcc18_lcd: LDO_REG8 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc18_lcd";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcc_sd: SWITCH_REG1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vcc_sd";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_lan: SWITCH_REG2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vcc_lan";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-		};
-	};
-};
-
-&pinctrl {
-	pcfg_output_high: pcfg-output-high {
-		output-high;
-	};
-
-	pcfg_output_low: pcfg-output-low {
-		output-low;
-	};
-
-	pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
-		drive-strength = <8>;
-	};
-
-	pcfg_pull_up_drv_8ma: pcfg-pull-up-drv-8ma {
-		bias-pull-up;
-		drive-strength = <8>;
-	};
-
-	gmac {
-		phy_int: phy-int {
-			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		phy_pmeb: phy-pmeb {
-			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		phy_rst: phy-rst {
-			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_output_high>;
-		};
-	};
-
-	pmic {
-		pmic_int: pmic-int {
-			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	usbphy {
-		host_drv: host-drv {
-			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&host_drv>;
-	vbus_drv-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&usb_host0_ehci {
-	status = "okay";
-};
-
-&usb_host1 {
-	status = "okay";
-};
-
-&usb_otg {
-	status = "okay";
-};
-
-&usb_hsic {
-	status = "okay";
-};
-
-&vopb {
-	status = "okay";
-};
-
-&vopb_mmu {
-	status = "okay";
-};
-
-&vopl {
-	status = "okay";
-};
-
-&vopl_mmu {
-	status = "okay";
-};
-- 
2.17.1

