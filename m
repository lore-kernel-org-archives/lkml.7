Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD865C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBB621743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="q7pBc2fZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfEUPUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:20:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40008 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfEUPT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:19:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id f10so3673812wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wlENQi5GzydZIvw71fQFWYo0j7VTDet/N8dSCmvPST0=;
        b=q7pBc2fZu9mRgbnNSdRSh9dLDuq848zgLHO+aSFrNQudzN8l3I37NCWZI5Q0Z9rq+6
         NgEmkUGw+o8uT3F0ynvX2WMDxFq1otip2M7GffzsCE0XzjFVPze90QrH+fIzA49094GS
         9v9pWYlz2h9DVRrrbfOB9wVEfjHp7flwM/SJnMMRp8LiAr5Wvmk88pTI/iT7vVoAWV4c
         C+227N9cci7V4dIDfa4kWZYSVqWOu+wJyP67wv1C3ZFruMKbG3KAiJsrOTdVcHw/xbuM
         v9wfsU1smDXF8eNzHohN6km7ao6wRrnL7UyanCeo3RtN0Q5YazFMAgGQPs3XWcLdFg3r
         NprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlENQi5GzydZIvw71fQFWYo0j7VTDet/N8dSCmvPST0=;
        b=WDKGRVGS0d24cwbApSHR1g6rNFVYwHfxh2xgjFZwEcBtiednSWIwZDWhzhaVe28U7a
         pueAa319D+TGm4UFkwAfkV56IYdjLya5sCKg8/0KOGyQqVKNC5OUwX0pm7+ZvBTa0gBC
         AavZzBwM7oVR4MpfUenDQOGMbB6kCjzQ3K6gHBWan6p7nJZObh1caOdTBw1Y/btLKJlw
         YDJ5ElRCSLtQnXA/E+IYgGBm8Od93tMMMpOz++unK4RTK3rBNgpnaO50+sUUT8PkRXXx
         Gl51hKsiKnydQXafTp3x6ZgNpxRz8gqgfyg1Y4RKbBbKytm9CDyBteroo0h4IU5n1aYO
         qssA==
X-Gm-Message-State: APjAAAUJr4cNZxrFi68MROB1byflG1NL2Z+rCZ/Y8jeJXk1Wd/NfgA/f
        u3YIeyt2JM+GVZFDUtPBSWF/hg==
X-Google-Smtp-Source: APXvYqy9TvhQWlhqLSn/qFXa2+2Jtr9pXOxp/ZxW7CiJZ/5GWhho6gCXwVP69FPzs9kbDglzF4Q8mQ==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr48354992wrn.109.1558451997746;
        Tue, 21 May 2019 08:19:57 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p17sm3945677wrq.95.2019.05.21.08.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 08:19:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: meson: Add minimal support for Odroid-N2
Date:   Tue, 21 May 2019 17:19:52 +0200
Message-Id: <20190521151952.2779-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521151952.2779-1-narmstrong@baylibre.com>
References: <20190521151952.2779-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic support for :
- Amlogic G12B, which is very similar to G12A
- The HardKernel Odroid-N2 based on the S922X SoC

The Amlogic G12B SoC is very similar with the G12A SoC, sharing
most of the features and architecture, but with these differences :
- The first CPU cluster only has 2xCortex-A53 instead of 4
- G12B has a second cluster of 4xCortex-A73
- Both cluster can achieve 2GHz instead of 1,8GHz for G12A
- CPU Clock architecture is difference, thus needing a different
  compatible to handle this slight difference
- Supports a MIPI CSI input
- Embeds a Mali-G52 instead of a Mali-G31, but integration is the same

Actual support is done in the same way as for the GXM support, including
the G12A dtsi and redefining the CPU clusters.
Unlike GXM, the first cluster is different, thus needing to remove
the last 2 cpu nodes of the first cluster.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Martin,

I added MMC, SDCard and Network support, so I removed your Reviewed-by.

Neil

 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 286 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  82 +++++
 3 files changed, 369 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index e129c03ced14..07b861fe5fa5 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
new file mode 100644
index 000000000000..904a47b8a4e7
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
+
+/ {
+	compatible = "hardkernel,odroid-n2", "amlogic,g12b";
+	model = "Hardkernel ODROID-N2";
+
+	aliases {
+		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		blue {
+			label = "n2:blue";
+			gpios = <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	tflash_vdd: regulator-tflash_vdd {
+		compatible = "regulator-fixed";
+
+		regulator-name = "TFLASH_VDD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio_ao GPIOAO_8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	tf_io: gpio-regulator-tf_io {
+		compatible = "regulator-gpio";
+
+		regulator-name = "TF_IO";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+
+		states = <3300000 0
+			  1800000 1>;
+	};
+
+	flash_1v8: regulator-flash_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "FLASH_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	main_12v: regulator-main_12v {
+		compatible = "regulator-fixed";
+		regulator-name = "12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+	};
+
+	vcc_5v: regulator-vcc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	vcc_1v8: regulator-vcc_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+		/* FIXME: actually controlled by VDDCPU_B_EN */
+	};
+
+	hub_5v: regulator-hub_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "HUB_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_5v>;
+
+		gpio = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb_pwr_en: regulator-usb_pwr_en {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_PWR_EN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&hub_5v>;
+
+		gpio = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vddao_1v8: regulator-vddao_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&main_12v>;
+		regulator-always-on;
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
+};
+
+&cec_AO {
+	pinctrl-0 = <&cec_ao_a_h_pins>;
+	pinctrl-names = "default";
+	status = "disabled";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cecb_AO {
+	pinctrl-0 = <&cec_ao_b_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */	
+		reg = <0>;
+		max-speed = <1000>;
+		eee-broken-1000t;
+	};
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&external_phy>;
+	amlogic,tx-delay-ns = <2>;
+};
+
+&gpio {
+	/*
+	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
+	 * to be turned high in order to be detected by the USB Controller
+	 * This signal should be handled by a USB specific power sequence
+	 * in order to reset the Hub when USB bus is powered down.
+	 */
+	usb-hub {
+		gpio-hog;
+		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "usb-hub-reset";
+	};
+};
+
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+	hdmi-supply = <&vcc_5v>;
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_c_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <50000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&tflash_vdd>;
+	vqmmc-supply = <&tf_io>;
+
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
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
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&flash_1v8>;
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb2_phy0 {
+	phy-supply = <&usb_pwr_en>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&vcc_5v>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
new file mode 100644
index 000000000000..0359539ba884
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12a.dtsi"
+
+/ {
+	compatible = "amlogic,g12b";
+
+	cpus {
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu100>;
+				};
+
+				core1 {
+					cpu = <&cpu101>;
+				};
+
+				core2 {
+					cpu = <&cpu102>;
+				};
+
+				core3 {
+					cpu = <&cpu103>;
+				};
+			};
+		};
+
+		/delete-node/ cpu@2;
+		/delete-node/ cpu@3;
+
+		cpu100: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73", "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu101: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73", "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu102: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73", "arm,armv8";
+			reg = <0x0 0x102>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu103: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73", "arm,armv8";
+			reg = <0x0 0x103>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+	};
+};
+
+&clkc {
+	compatible = "amlogic,g12b-clkc";
+};
-- 
2.21.0

