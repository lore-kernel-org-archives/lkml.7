Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D453C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105522064A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lTcEEzKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfDDPGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:06:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47027 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbfDDPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:06:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so4173476wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BcWiVHjADXs9333o0RehsMpjl7l4ahHH0tx1c2n3mW4=;
        b=lTcEEzKmrE8cj5ZxRQZP//j2PGX2cGu5emOUuZ0Ru5dhYbFUXAhctxuZU+IkjH+mo8
         dHM0zjEFA7BhQvrCa0+mBDQy/+S98dZkzGwpEMDEXNFbAU7a53HUIU31q5kMy9mOp9DL
         eQLYtsn1PGhuFMGkGagkaVwyQrPkTIhKJZAP9+fjX8cSx7HEsTG5LpibId1pXlTHft/C
         nj9Dd1J0IxswMBPv83iCjW6DF369DzI1LFXUmFUDrv9BvpdNBU3HXS5xcUOKd69f1p3C
         7k/y+vg96LVVv7lDkYyibXpfKAksGBGzVitQ24a6nGnVWJUQM3QiI40ZqnJhZgcXj5Td
         ph9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BcWiVHjADXs9333o0RehsMpjl7l4ahHH0tx1c2n3mW4=;
        b=RqUyToSplGcY5Hckr67tbcAwj9iMlBoOKU3B1JKjbVcf1KqvkMIwcZ+w4p1iqXxTt7
         e8UiZoO3dDCAk+VUBGSDwjt4wWFlaTNUtCHRBC6YPEARaGyDQwM4mwWNX3OFtDTEJea9
         IiV52P1sa6xk3VSsh2MxTCdJGPFACat3ntk9CD39otdNMyOLwhYvpI8n5fdzUX7ZamV2
         arsNMXZuHwTBVWzwv2Vq0nQZN12/dI9lZNKCzob6YPBzq1xVW9CdDyuSUzHPJgQYHy9C
         wXR/8YbPJt8OunxpUfD0lg5ucOUNpsZ2FqLqEvDjhUrkqURaAchiHRzseIz46i9va5dO
         1KxQ==
X-Gm-Message-State: APjAAAUupoKnepsN8JkArg9bBZEIreQbngXCrNmbkAfKfokQYUcfHFL5
        lCLFVWFR1i2qtdhzoj0/kO6wZg==
X-Google-Smtp-Source: APXvYqzj8f/n7a3U5nkYJHzkeuMGWbPFg6dFM6dkU9YWAV5KSzKaeOBzMCq8AplL2YJm7xe1KDuxlw==
X-Received: by 2002:adf:f607:: with SMTP id t7mr4778551wrp.191.1554390361757;
        Thu, 04 Apr 2019 08:06:01 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id z23sm9880981wma.0.2019.04.04.08.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 08:05:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: meson: Add minimal support for Odroid-N2
Date:   Thu,  4 Apr 2019 17:05:18 +0200
Message-Id: <20190404150518.30337-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404150518.30337-1-narmstrong@baylibre.com>
References: <20190404150518.30337-1-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 178 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  82 ++++++++
 3 files changed, 261 insertions(+)
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
index 000000000000..9dd6e05cfd0e
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -0,0 +1,178 @@
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
+	status = "okay";
+	hdmi-phandle = <&hdmi_tx>;
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

