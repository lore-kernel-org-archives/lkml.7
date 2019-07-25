Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95323C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622E922C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BSc9E3yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390741AbfGYQ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:27:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35578 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390672AbfGYQ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:26:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so23615397plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80tYmqL3jsBkPxlNOR2hEGSylp1Ty1hHpS2HOV6h4L4=;
        b=BSc9E3yw8hMxmGPupKffzvPgXMBidX+DoggMrjJLEhD3et8Z0noPluiB2SQ8kXOPIn
         rulTwLWVtdPeTRYEnzHsTUOBxD3bo41hIgcICFJlKZxC0kFtHi4pg1p53Fgj+zW4HcCw
         hVrWlSG/J7D4DF4AkYFGoS4/udMR6y6BW7MTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80tYmqL3jsBkPxlNOR2hEGSylp1Ty1hHpS2HOV6h4L4=;
        b=rEtIqmg4Il47m5ZdRNtMgs0U7eqGwuTS5hTBg6cyaLWIXYRV6bQBVc21KVJddhkIUB
         dmHZcDLpNtbK0i9Mhf/94oePFQKrMghAoLNXT8edXExsMGtpg6QcwulALTXO38oIFxeU
         8Stzo1qEaHrEbaTwpxuVcSIK++GdD0lTsdQ1JqcF0+6/orNqhlKnOfRdMoO6iEZTpELs
         VQcIWRGUehkAkjoT6hv+VIOd1O4WLT+Kwd/BKUj1APxmpey3/vslK38cukwNH6NJ9pTW
         M6rNQirppL+OzmiyzdOglMLZ6kqypZGvgl86cjt4X+VaqeZcWJD+lHXh/GfVNvrc1zXK
         BZNg==
X-Gm-Message-State: APjAAAUgbFRefIUOoQIHLxrvklfDffvTzy+r+rjQppx/+eb9EDnk80ON
        4v643Id6kQYIcZDabsDIxK9dYQ==
X-Google-Smtp-Source: APXvYqyinXUcCESrzCe4P2zNIO4kXjVoFJAci/FGWEiiLX6iqEUvhXiHsqA55CKQHer8T+G79bHTMA==
X-Received: by 2002:a17:902:f095:: with SMTP id go21mr93535115plb.58.1564072014094;
        Thu, 25 Jul 2019 09:26:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p187sm77749670pfg.89.2019.07.25.09.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:26:53 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 4/5] ARM: dts: rockchip: add veyron-fievel board
Date:   Thu, 25 Jul 2019 09:26:41 -0700
Message-Id: <20190725162642.250709-5-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190725162642.250709-1-mka@chromium.org>
References: <20190725162642.250709-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also known as AOpen Chromebox Mini.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- patch added to the series
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/rk3288-veyron-fievel.dts | 299 +++++++++++++++++++++
 2 files changed, 300 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-fievel.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9159fa2cea90..9fd1e075c624 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -919,6 +919,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3288-tinker.dtb \
 	rk3288-tinker-s.dtb \
 	rk3288-veyron-brain.dtb \
+	rk3288-veyron-fievel.dtb \
 	rk3288-veyron-jaq.dtb \
 	rk3288-veyron-jerry.dtb \
 	rk3288-veyron-mickey.dtb \
diff --git a/arch/arm/boot/dts/rk3288-veyron-fievel.dts b/arch/arm/boot/dts/rk3288-veyron-fievel.dts
new file mode 100644
index 000000000000..a9716fc3f50a
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-veyron-fievel.dts
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Veyron Fievel Rev 0+ board device tree source
+ *
+ * Copyright 2016 Google, Inc
+ */
+
+/dts-v1/;
+#include "rk3288-veyron.dtsi"
+#include "rk3288-veyron-analog-audio.dtsi"
+
+/ {
+	model = "Google Fievel";
+	compatible = "google,veyron-fievel-rev8", "google,veyron-fievel-rev7",
+		     "google,veyron-fievel-rev6", "google,veyron-fievel-rev5",
+		     "google,veyron-fievel-rev4", "google,veyron-fievel-rev3",
+		     "google,veyron-fievel-rev2", "google,veyron-fievel-rev1",
+		     "google,veyron-fievel-rev0", "google,veyron-fievel",
+		     "google,veyron", "rockchip,rk3288";
+
+	/delete-node/ bt-activity;
+
+	ext_gmac: external-gmac-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+		clock-output-names = "ext_gmac";
+	};
+
+	/*
+	 * vcc33_pmuio and vcc33_io is sourced directly from vcc33_sys,
+	 * enabled by vcc_18
+	 */
+	vcc33_io: vcc33-io {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "vcc33_io";
+	};
+
+	vcc5_host1: vcc5-host1-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio5 RK_PC1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hub_usb1_pwr_en>;
+		regulator-name = "vcc5_host1";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc5_host2: vcc5-host2-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio5 RK_PC2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hub_usb2_pwr_en>;
+		regulator-name = "vcc5_host2";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc5v_otg: vcc5v-otg-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_otg_pwr_en>;
+		regulator-name = "vcc5_otg";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&gmac {
+	status = "okay";
+
+	assigned-clocks = <&cru SCLK_MAC>;
+	assigned-clock-parents = <&ext_gmac>;
+	clock_in_out = "input";
+	phy-handle = <&ethphy>;
+	phy-mode = "rgmii";
+	phy-supply = <&vcc33_lan>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>, <&phy_rst>, <&phy_pmeb>, <&phy_int>;
+	resets = <&cru SRST_MAC>;
+	reset-names = "stmmaceth";
+	rx_delay = <0x10>;
+	tx_delay = <0x30>;
+
+	/* Reset for the RTL8211 PHY which requires a 10-ms reset pulse (low)
+	 * with a 30ms settling time. */
+	snps,reset-gpio = <&gpio4 RK_PB0 0>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 30000>;
+	wakeup-source;
+
+	mdio0 {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@1 {
+			reg = <1>;
+		};
+	};
+};
+
+&rk808 {
+	dvs-gpios = <&gpio7 RK_PB4 GPIO_ACTIVE_HIGH>,
+		    <&gpio7 RK_PB7 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
+
+	vcc6-supply = <&vcc33_sys>;
+	vcc10-supply = <&vcc33_sys>;
+	vcc11-supply = <&vcc_5v>;
+	vcc12-supply = <&vcc33_sys>;
+
+	regulators {
+		/delete-node/ LDO_REG1;
+
+		/* According to the schematic, vcc18_lcdt is for
+		 * HDMI_AVDD_1V8
+		 */
+		vcc18_lcdt: LDO_REG2 {
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-name = "vdd18_lcdt";
+			regulator-state-mem {
+				regulator-on-in-suspend;
+				regulator-suspend-microvolt = <1800000>;
+			};
+		};
+
+		/* This is not a pwren anymore, but the real power supply,
+		 * vdd10_lcd for HDMI_AVDD_1V0
+		 */
+		vdd10_lcd: LDO_REG7 {
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-name = "vdd10_lcd";
+			regulator-state-mem {
+				regulator-on-in-suspend;
+				regulator-suspend-microvolt = <1000000>;
+			};
+
+		};
+
+		/* for usb camera */
+		vcc33_ccd: LDO_REG8 {
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-name = "vcc33_ccd";
+			regulator-state-mem {
+				regulator-on-in-suspend;
+				regulator-suspend-microvolt = <3300000>;
+			};
+		};
+
+		vcc33_lan: SWITCH_REG2 {
+			regulator-name = "vcc33_lan";
+		};
+	};
+};
+
+&sdio0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	btmrvl: btmrvl@2 {
+		compatible = "marvell,sd8897-bt";
+		reg = <2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PD7 IRQ_TYPE_LEVEL_LOW>;
+		marvell,wakeup-pin = /bits/ 16 <13>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake>;
+	};
+};
+
+&vcc50_hdmi {
+	enable-active-high;
+	gpio = <&gpio5 RK_PC3 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&vcc50_hdmi_en>;
+};
+
+&vcc_5v {
+	enable-active-high;
+	gpio = <&gpio7 RK_PC5 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&drv_5v>;
+};
+
+&pinctrl {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+
+		/* Wake only */
+		&bt_dev_wake_awake
+		&pwr_led1_on
+
+		/* For usb bc1.2 */
+		&usb_otg_ilim_sel
+		&usb_usb_ilim_sel
+	>;
+
+	pinctrl-1 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+
+		/* Sleep only */
+		&bt_dev_wake_sleep
+		&pwr_led1_blink
+	>;
+
+	buck-5v {
+		drv_5v: drv-5v {
+			rockchip,pins = <7 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	gmac {
+		phy_rst: phy-rst {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+
+		phy_pmeb: phy-pmeb {
+			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		phy_int: phy-int {
+			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	hdmi {
+		vcc50_hdmi_en: vcc50-hdmi-en {
+			rockchip,pins = <5 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		pwr_led1_on: pwr-led1-on {
+			rockchip,pins = <7 RK_PA3 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+
+		pwr_led1_blink: pwr-led1-blink {
+			rockchip,pins = <7 RK_PA3 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+	};
+
+	pmic {
+		dvs_1: dvs-1 {
+			rockchip,pins = <7 RK_PB4 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		dvs_2: dvs-2 {
+			rockchip,pins = <7 RK_PB7 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	usb-bc12 {
+		usb_otg_ilim_sel: usb-otg-ilim-sel {
+			rockchip,pins = <6 RK_PC1 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+
+		usb_usb_ilim_sel: usb-usb-ilim-sel {
+			rockchip,pins = <5 RK_PB7 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+	};
+
+	usb-host {
+		hub_usb1_pwr_en: hub_usb1_pwr_en {
+			rockchip,pins = <5 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		hub_usb2_pwr_en: hub_usb2_pwr_en {
+			rockchip,pins = <5 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		usb_otg_pwr_en: usb_otg_pwr_en {
+			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
-- 
2.22.0.709.g102302147b-goog

