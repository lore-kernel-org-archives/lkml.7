Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F46FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8DA218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uF77i034"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfDEMVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:21:43 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:44078 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfDEMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:21:38 -0400
Received: by mail-wr1-f44.google.com with SMTP id y7so7714673wrn.11;
        Fri, 05 Apr 2019 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XG/xD8cCb57d8Grf1gBDmOid0T4JaSgSEN6VF3o2rmo=;
        b=uF77i034qWJ9/yD+wU+04MYgEAKoctpfuDkTmSzZhguD8CaKja9aNcfClSWPIIWsNx
         Xdh2FN3SueSrgsnS+82jmlV1aMNKjiy0gmR2kHpsJDy9JM1eIx8k5SS9jIF+RDWBHfac
         VSolaFwDSlG0cV8B5qDs3ff6nbesqPaUI5wOLZ1yEerzm445giR0zw9/lSbydq9HaiZM
         b86HiPWX9g2Wg+Zt+/5ndJ5Y0BS5gR7p5lgKuIiVO7HIBVWDv1yaS4FT5sdZbHCpm7q6
         6Ao6SVWf8/S/1Hoes1luk4+cBdQJD7Q+Q9ctQo5f44UUI6F6PRSm6hgXFkuekOFOMC4w
         th2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XG/xD8cCb57d8Grf1gBDmOid0T4JaSgSEN6VF3o2rmo=;
        b=qHU0IpTylbttm67ELmifnhpolV4pAW+XjvF746GIN7+htYXmYXop/npzC5PmEAcCNW
         JsEQYuqVUWdsSnIbB/PAXf2sRRy7Ekru27nYI1T+nx0nI6NgfvTzLl8iHfaWIsqOHpJr
         e8OTVSH6NcXm6f/VZmRZ6CxF4yUu5QxNpy5Y+FBumuq0q4AlM7ney8F0XzeZCYUo9e67
         IZ6YOquN71fdqIT32ppLUQ0fygOjGKJWhPAYvMjjwTn+FRYNUjDla4nyms8j0+gwmwfa
         qXWend/DvgTDN/AWO7pC9WHex8ZvPi0/9rO0DDCVQfvpH1eQK0mqlBzyscTnZoPa+TtP
         0SCg==
X-Gm-Message-State: APjAAAXNiThYfEEx0pE2znXI0BnOlTIWHcUEDupupdi3cKAAoTC8qlA5
        seECmStBjxKc8czBAYitsZM=
X-Google-Smtp-Source: APXvYqxe6UcHGNotdnOYkm+9XqtUu7vO8ifgxVF1N12ougBPjSZaS7n9GFtIXFiw9asXrF6DQpsN7g==
X-Received: by 2002:adf:f64d:: with SMTP id x13mr8535659wrp.298.1554466895699;
        Fri, 05 Apr 2019 05:21:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id d14sm34454123wro.79.2019.04.05.05.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 05:21:34 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 5/5] ARM: dts: sun50i: h6: Introduce Beelink GS1 board
Date:   Fri,  5 Apr 2019 14:24:46 +0200
Message-Id: <20190405122446.2101-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405122446.2101-1-peron.clem@gmail.com>
References: <20190405122446.2101-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink GS1 is an Allwinner H6 based TV box,
which support:
- Allwinner H6 Quad-core 64-bit ARM Cortex-A53
- GPU Mali-T720
- 2GB LPDDR3 RAM
- AXP805 PMIC
- 1Gbps GMAC via RTL8211E
- FN-Link 6222B-SRB Wifi/BT
- 1x USB 2.0 Host and 1x USB 3.0 Host
- HDMI port
- S/PDIF Tx
- IR receiver
- 5V/2A DC power supply

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---

Thanks to Jagan and Icenowy, most of this devicetree is taken from their works on
the OrangePi One Plus and Pine H64.

Changes in v2 (Thanks to Maxime Ripard):
 - move MMC pinctrl to SOC dtsi
 - add board to Sunxi YAML file
 - add PIO/R_PIO regulators
 - remove always_on from SDIO regulators


 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   | 256 ++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 11563d3f7c65..9ab9b266881d 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -136,6 +136,11 @@ properties:
           - const: lemaker,bananapro
           - const: allwinner,sun7i-a20
 
+      - description: Beelink GS1
+        items:
+          - const: azw,beelink-gs1
+          - const: allwinner,sun50i-h6
+
       - description: Beelink X2
         items:
           - const: roofull,beelink-x2
diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index e4dce2f6fa3a..2dd806a3d5c9 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-beelink-gs1.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
new file mode 100644
index 000000000000..d820a138522b
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2019 Clément Péron <peron.clem@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-h6.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Beelink GS1";
+	compatible = "azw,beelink-gs1", "allwinner,sun50i-h6";
+
+	aliases {
+		ethernet0 = &emac;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		power {
+			label = "beelink:white:power";
+			gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+			default-state = "on";
+		};
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the DC jack */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_aldo2>;
+	allwinner,rx-delay-ps = <0>;
+	allwinner,tx-delay-ps = <0>;
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_cldo1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_cldo1>;
+	vqmmc-supply = <&reg_bldo2>;
+	non-removable;
+	cap-mmc-hw-reset;
+	bus-width = <8>;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pd-supply = <&reg_cldo1>;
+	vcc-pg-supply = <&reg_aldo1>;
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp805: pmic@36 {
+		compatible = "x-powers,axp805", "x-powers,axp806";
+		reg = <0x36>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		x-powers,self-working-mode;
+		vina-supply = <&reg_vcc5v>;
+		vinb-supply = <&reg_vcc5v>;
+		vinc-supply = <&reg_vcc5v>;
+		vind-supply = <&reg_vcc5v>;
+		vine-supply = <&reg_vcc5v>;
+		aldoin-supply = <&reg_vcc5v>;
+		bldoin-supply = <&reg_vcc5v>;
+		cldoin-supply = <&reg_vcc5v>;
+
+		regulators {
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-pl";
+			};
+
+			reg_aldo2: aldo2 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-ac200";
+				regulator-enable-ramp-delay = <100000>;
+			};
+
+			reg_aldo3: aldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc25-dram";
+			};
+
+			reg_bldo1: bldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-bias-pll";
+			};
+
+			reg_bldo2: bldo2 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-efuse-pcie-hdmi-io";
+			};
+
+			reg_bldo3: bldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-dcxoio";
+			};
+
+			bldo4 {
+				/* unused */
+			};
+
+			reg_cldo1: cldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-3v3";
+			};
+
+			reg_cldo2: cldo2 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-wifi-1";
+			};
+
+			reg_cldo3: cldo3 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-wifi-2";
+			};
+
+			reg_dcdca: dcdca {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1080000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdcc: dcdcc {
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1080000>;
+				regulator-name = "vdd-gpu";
+			};
+
+			reg_dcdcd: dcdcd {
+				regulator-always-on;
+				regulator-min-microvolt = <960000>;
+				regulator-max-microvolt = <960000>;
+				regulator-name = "vdd-sys";
+			};
+
+			reg_dcdce: dcdce {
+				regulator-always-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "vcc-dram";
+			};
+
+			sw {
+				/* unused */
+			};
+		};
+	};
+};
+
+&r_pio {
+	vcc-pl-supply = <&reg_aldo1>;
+	vcc-pm-supply = <&reg_aldo1>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+&usb2otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb2phy {
+	usb0_vbus-supply = <&reg_vcc5v>;
+	status = "okay";
+};
-- 
2.17.1

