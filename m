Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F7BC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FD420707
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qOQ0/KwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfLFKCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:02:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53000 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfLFKCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:02:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so7157070wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVP64aNEXco02OHTkt7bZRMGOvdx+kqfsDL3TbCTiEY=;
        b=qOQ0/KwSe8SQj9eDBwb0dHbpe3vs+p+ZRGNbIZrgEnY6fkH538EdaopLqI5VfaCOJC
         5qLgVYQRK4ezc9VMMQW0bnCCU92gjP/Y2LF5xRMRp2ljJF3sjuzPIxtJmXWGj9tUS03m
         BsOl3CbubPfDg0bCOuhKE0Gx9y5Jpv5cKbmL9q2q6zi29ZFabDdJaMgKZKZda1ncB+eS
         g3Uhu59IbdDy2flI4lReoO0hHc9DLYH8UbKNEjUl0+IWXqtR6BrYkUAK1MZ2r7qQ5raQ
         Iq0kLWJezo53dZtbb67TsNid3EYnASqu0SNkc5Poo6lezodqfJXHNLwGaPNzyomDjJnT
         avuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVP64aNEXco02OHTkt7bZRMGOvdx+kqfsDL3TbCTiEY=;
        b=tCX9q1i7ztHiuXd3eYRbDePvko4fnlS9EjlkGbDtyQ2GCUAMSES84Ar/0KkfWxP/cE
         GdfAPkFXuHAALiorhIKiG4ogDkOTRLS/Iwwv3jKFFtoFjCCQi/4azRs20EmGYiUNBgbl
         ZtdGy3gQBsXL/Jhrd5sdsE+mI5RwODVNb4ghVynAsAYD5DI+4yUzVuxUL0EDpwjV5l1G
         wkOMqH/I9i5IL6mwUgLJAcuYK0G0JJccdkRV0G/DPp5IuIO/DadeOLys0aJRaGAj6/y2
         INtjRcoooLz2zJfHaMP0QUTuQZJ+TwZDGJ00Q/o6ewmhYluxBJv7HKfDPZRLyI+p/dgd
         O1cw==
X-Gm-Message-State: APjAAAVy8o2ETotdcXTI/g9ldrakG2rm+8BHRnVqbk/YW85Wn56556Fo
        GwMdJvwtCmKn9EDk/F3dcJ+gUA==
X-Google-Smtp-Source: APXvYqziTbUnQdLhUSN53b55X6JKRfb32crbitsGAIlEYxVm2pABvXMFyjLT+sSh6s4RrFE/vn+s1g==
X-Received: by 2002:a1c:e91a:: with SMTP id q26mr9726645wmc.59.1575626548602;
        Fri, 06 Dec 2019 02:02:28 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d14sm16372314wru.9.2019.12.06.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 02:02:27 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: meson: add libretech-pc boards support
Date:   Fri,  6 Dec 2019 11:02:18 +0100
Message-Id: <20191206100218.480348-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206100218.480348-1-jbrunet@baylibre.com>
References: <20191206100218.480348-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the the amlogic libretech-pc platform, aka tartiflette.
There is 2 variants of the platform, one with the s905d, the other with
the s912.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../dts/amlogic/meson-gx-libretech-pc.dtsi    | 362 ++++++++++++++++++
 .../amlogic/meson-gxl-s905d-libretech-pc.dts  |  16 +
 .../amlogic/meson-gxm-s912-libretech-pc.dts   |  63 +++
 4 files changed, 443 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-libretech-pc.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 63400538d39f..6071a4081eb2 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -29,11 +29,13 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-libretech-pc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-libretech-pc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
new file mode 100644
index 000000000000..cf0a02b0e0a2
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 BayLibre SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+/* Libretech Amlogic GX PC form factor - AKA: Tartiflette */
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	adc_keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+
+		button-onoff {
+			label = "On/Off";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <1300000>;
+		};
+	};
+
+	aliases {
+		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
+		spi0 = &spifc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	cvbs-connector {
+		compatible = "composite-video-connector";
+		status = "disabled";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+
+		power-button {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	ao_5v: regulator-ao_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "AO_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_in>;
+		regulator-always-on;
+	};
+
+	dc_in: regulator-dc_in {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_IN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		green {
+			label = "librecomputer:green:disk";
+			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "disk-activity";
+		};
+
+		blue {
+			label = "librecomputer:blue:cpu";
+			gpios = <&gpio GPIODV_28 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			panic-indicator;
+		};
+	};
+
+	vcc_card: regulator-vcc_card {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_CARD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddio_ao3v3>;
+
+		gpio = <&gpio GPIODV_4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vcc5v: regulator-vcc5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&ao_5v>;
+
+		gpio = <&gpio GPIOH_3 GPIO_OPEN_DRAIN>;
+	};
+
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&ao_5v>;
+		regulator-always-on;
+	};
+
+	vddio_ao3v3: regulator-vddio_ao3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ao_5v>;
+		regulator-always-on;
+	};
+
+	vddio_boot: regulator-vddio_boot {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddio_ao3v3>;
+		regulator-always-on;
+	};
+
+	vddio_card: regulator-vddio-card {
+		compatible = "regulator-gpio";
+		regulator-name = "VDDIO_CARD";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio GPIODV_5 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+
+		states = <3300000 0>,
+			 <1800000 1>;
+
+		regulator-settling-time-up-us = <200>;
+		regulator-settling-time-down-us = <50000>;
+	};
+};
+
+&cec_AO {
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+	status = "okay";
+};
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&external_phy>;
+	amlogic,tx-delay-ns = <2>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
+
+&external_mdio {
+	external_phy: ethernet-phy@0 {
+		reg = <0>;
+		max-speed = <1000>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <30000>;
+		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&pinctrl_periphs {
+	/*
+	 * Make sure the reset pin of the usb HUB is driven high to take
+	 * it out of reset.
+	 */
+	usb1_rst_pins: usb1_rst_irq {
+		mux {
+			groups = "GPIODV_3";
+			function = "gpio_periphs";
+			bias-disable;
+			output-high;
+		};
+	};
+};
+
+&hdmi_tx {
+	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
+	pinctrl-names = "default";
+	hdmi-supply = <&vcc5v>;
+	status = "okay";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+&ir {
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&i2c_C {
+	pinctrl-0 = <&i2c_c_dv18_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	rtc: rtc@51 {
+		reg = <0x51>;
+		compatible = "nxp,pcf8563";
+		#clock-cells = <0>;
+		clock-output-names = "rtc_clkout";
+	};
+};
+
+&pwm_AO_ab {
+	pinctrl-0 = <&pwm_ao_a_3_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+	status = "okay";
+};
+
+&pwm_ab {
+	pinctrl-0 = <&pwm_b_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+	status = "okay";
+};
+
+&pwm_ef {
+	pinctrl-0 = <&pwm_e_pins>, <&pwm_f_clk_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vddio_ao18>;
+	status = "okay";
+};
+
+/* SD card */
+&sd_emmc_b {
+	pinctrl-0 = <&sdcard_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-ddr50;
+	max-frequency = <200000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vcc_card>;
+	vqmmc-supply = <&vddio_card>;
+
+	status = "okay";
+};
+
+/* eMMC */
+&sd_emmc_c {
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vddio_ao3v3>;
+	vqmmc-supply = <&vddio_boot>;
+
+	status = "okay";
+};
+
+&spifc {
+	pinctrl-0 = <&nor_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	gd25lq128: spi-flash@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0>;
+		spi-max-frequency = <12000000>;
+	};
+};
+
+&uart_AO {
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb2_phy0 {
+	pinctrl-0 = <&usb1_rst_pins>;
+	pinctrl-names = "default";
+	phy-supply = <&vcc5v>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&vcc5v>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-libretech-pc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-libretech-pc.dts
new file mode 100644
index 000000000000..100a1cfeea15
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-libretech-pc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 BayLibre SAS. All rights reserved.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxl-s905d.dtsi"
+#include "meson-gx-libretech-pc.dtsi"
+
+/ {
+	compatible = "libretech,aml-s905d-pc", "amlogic,s905d",
+		     "amlogic,meson-gxl";
+	model = "Libre Computer AML-S905D-PC";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dts
new file mode 100644
index 000000000000..fa2d2b25861c
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dts
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 BayLibre SAS. All rights reserved.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxm.dtsi"
+#include "meson-gx-libretech-pc.dtsi"
+
+/ {
+	compatible = "libretech,aml-s912-pc", "amlogic,s912",
+		     "amlogic,meson-gxm";
+	model = "Libre Computer AML-S912-PC";
+
+	typec2_vbus: regulator-typec2_vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "TYPEC2_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v>;
+
+		gpio = <&gpio GPIODV_1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&pinctrl_periphs {
+	/*
+	 * Make sure the irq pin of the TYPE C controller is not driven
+	 * by the SoC.
+	 */
+	fusb302_irq_pins: fusb302_irq {
+		mux {
+			groups = "GPIODV_0";
+			function = "gpio_periphs";
+			bias-pull-up;
+			output-disable;
+		};
+	};
+};
+
+&i2c_C {
+	fusb302@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+
+		pinctrl-0 = <&fusb302_irq_pins>;
+		pinctrl-names = "default";
+
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <59 IRQ_TYPE_LEVEL_LOW>;
+
+		vbus-supply = <&typec2_vbus>;
+
+		status = "okay";
+	};
+};
+
+&usb2_phy2 {
+	phy-supply = <&typec2_vbus>;
+};
-- 
2.23.0

