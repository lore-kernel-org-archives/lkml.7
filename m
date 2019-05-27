Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8ACC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455B821530
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc+8u3bQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfE0LMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:12:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40698 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfE0LMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:12:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id t4so8254805wrx.7;
        Mon, 27 May 2019 04:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+25IZfFSYxZxgaCWl9p9Q+lE12LOFoqp9l4bTaMH4g=;
        b=Qc+8u3bQbojGETr2T5Ke42z2V1ZoC7wl0+odYmoS8NICB2sbmCMvXzBQfZ0+sfkabM
         7Xex2p5GDKt1Fp1uCP+0jHkzo3ICPOz5H7J0ZvfHnQwgs7wf/Mfkdg9/r//Shvg288wc
         rYDJcve+fpDSgywMcmv/7TUuqjCtI5i+akb9HCqz6GUpLx7T3/KZvu7HIeT/675VbhPz
         /dvGtrHJ1wLUZgXVnTVkV1VL7TINgARk6TZIGs8urt/b5LixTuKapmdykofpN2j70Yaj
         zplRBFKx77B3yYvZd0vp5glx7XA+JyL0fFKVBUlm/UjvtBH2gQzK6kPArrXY5xYMCdKf
         F05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+25IZfFSYxZxgaCWl9p9Q+lE12LOFoqp9l4bTaMH4g=;
        b=NRcKroB7ND1BCRyYmujW7/qSPBFXjINDxhTSA4xEKNxtkO9wmg07MT8tYqpK1tCgcD
         +6rhbPq3dXY0PoDR7H4he1EA2iWCYMjPmBJJCDZeeo078xXl1q4EeZuv/JkIECMaMi3Q
         EDQYAIJw4IrQPcYeTl2GiEGlrvYR7ESzRZMugia50h69WQzgZqfno9Ze26d9zhD5w/uK
         6VxqaqO4M/pn6lLpyvgQSCWCe3qi6k/lpPqfwH4lK2s3nkWk6yfeyMSiyFOgtsrozuzn
         uOsi8u2BHlh2c/rPV7S9DyKJs3S5Z64oSWoqPTcfG1fnNi+l+7MtoUcp9oOPD0a2a5IK
         K4IA==
X-Gm-Message-State: APjAAAVto43/9aN631MImcR+OTYG6DGEPTII7NraXNd1+nhOTyDux6j6
        n1ahOmuG4Fd1QIHAIsesqqY=
X-Google-Smtp-Source: APXvYqyvJvaTcyjxfF5URhNktk3VYsIZ/+8R7ySPecUC5+bPS5mpAPmplUDvqT2B1quXqVCT4nuOsA==
X-Received: by 2002:adf:ee8b:: with SMTP id b11mr7075172wro.181.1558955524351;
        Mon, 27 May 2019 04:12:04 -0700 (PDT)
Received: from localhost.localdomain (131.ip-164-132-48.eu. [164.132.48.131])
        by smtp.googlemail.com with ESMTPSA id z14sm5693873wrh.86.2019.05.27.04.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 04:12:03 -0700 (PDT)
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Konstantin Porotchkin <kostap@marvell.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: add ESPRESSObin variants
Date:   Mon, 27 May 2019 13:11:56 +0200
Message-Id: <20190527111156.3539-1-tmn505@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds dts for different variants of ESPRESSObin board:

ESPRESSObin with soldered eMMC,

ESPRESSObin V7, compared to prior versions some passive elements changed
and ethernet ports labels positions have been reversed,

ESPRESSObin V7 with soldered eMMC.

Since most of elements are the same, one common dtsi is created and
referenced in each dts of particular variant.

Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>
---
 .../marvell/armada-3720-espressobin-emmc.dts  |  42 ++++
 .../armada-3720-espressobin-v7-emmc.dts       |  59 ++++++
 .../marvell/armada-3720-espressobin-v7.dts    |  36 ++++
 .../dts/marvell/armada-3720-espressobin.dts   | 200 +-----------------
 .../dts/marvell/armada-3720-espressobin.dtsi  | 193 +++++++++++++++++
 5 files changed, 331 insertions(+), 199 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
new file mode 100644
index 000000000000..bd9ed9dc9c3e
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for Globalscale Marvell ESPRESSOBin Board with eMMC
+ * Copyright (C) 2018 Marvell
+ *
+ * Romain Perier <romain.perier@free-electrons.com>
+ * Konstantin Porotchkin <kostap@marvell.com>
+ *
+ */
+/*
+ * Schematic available at http://espressobin.net/wp-content/uploads/2017/08/ESPRESSObin_V5_Schematics.pdf
+ */
+
+#include "armada-3720-espressobin.dtsi"
+
+/ {
+	model = "Globalscale Marvell ESPRESSOBin Board (eMMC)";
+	compatible = "globalscale,espressobin-emmc", "globalscale,espressobin",
+		     "marvell,armada3720", "marvell,armada3710";
+};
+
+/* U11 */
+&sdhci0 {
+	non-removable;
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	marvell,xenon-emmc;
+	marvell,xenon-tun-count = <9>;
+	marvell,pad-type = "fixed-1-8v";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc_pins>;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	mmccard: mmccard@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
new file mode 100644
index 000000000000..6e876a6d9532
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for Globalscale Marvell ESPRESSOBin Board V7 with eMMC
+ * Copyright (C) 2018 Marvell
+ *
+ * Romain Perier <romain.perier@free-electrons.com>
+ * Konstantin Porotchkin <kostap@marvell.com>
+ *
+ */
+/*
+ * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
+ */
+
+#include "armada-3720-espressobin.dtsi"
+
+/ {
+	model = "Globalscale Marvell ESPRESSOBin Board V7 (eMMC)";
+	compatible = "globalscale,espressobin-v7-emmc", "globalscale,espressobin-v7",
+		     "globalscale,espressobin", "marvell,armada3720",
+		     "marvell,armada3710";
+};
+
+&switch0 {
+	ports {
+		port@1 {
+			reg = <1>;
+			label = "lan1";
+			phy-handle = <&switch0phy0>;
+		};
+
+		port@3 {
+			reg = <3>;
+			label = "wan";
+			phy-handle = <&switch0phy2>;
+		};
+	};
+};
+
+/* U11 */
+&sdhci0 {
+	non-removable;
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	marvell,xenon-emmc;
+	marvell,xenon-tun-count = <9>;
+	marvell,pad-type = "fixed-1-8v";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc_pins>;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	mmccard: mmccard@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
new file mode 100644
index 000000000000..0f8405d085fd
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for Globalscale Marvell ESPRESSOBin Board V7
+ * Copyright (C) 2018 Marvell
+ *
+ * Romain Perier <romain.perier@free-electrons.com>
+ * Konstantin Porotchkin <kostap@marvell.com>
+ *
+ */
+/*
+ * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
+ */
+
+#include "armada-3720-espressobin.dtsi"
+
+/ {
+	model = "Globalscale Marvell ESPRESSOBin Board V7";
+	compatible = "globalscale,espressobin-v7", "globalscale,espressobin",
+		     "marvell,armada3720", "marvell,armada3710";
+};
+
+&switch0 {
+	ports {
+		port@1 {
+			reg = <1>;
+			label = "lan1";
+			phy-handle = <&switch0phy0>;
+		};
+
+		port@3 {
+			reg = <3>;
+			label = "wan";
+			phy-handle = <&switch0phy2>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 6be019e1888e..1542d836c090 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -12,207 +12,9 @@
 
 /dts-v1/;
 
-#include <dt-bindings/gpio/gpio.h>
-#include "armada-372x.dtsi"
+#include "armada-3720-espressobin.dtsi"
 
 / {
 	model = "Globalscale Marvell ESPRESSOBin Board";
 	compatible = "globalscale,espressobin", "marvell,armada3720", "marvell,armada3710";
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
-	};
-
-	vcc_sd_reg1: regulator {
-		compatible = "regulator-gpio";
-		regulator-name = "vcc_sd1";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-
-		gpios = <&gpionb 4 GPIO_ACTIVE_HIGH>;
-		gpios-states = <0>;
-		states = <1800000 0x1
-			  3300000 0x0>;
-		enable-active-high;
-	};
-};
-
-/* J9 */
-&pcie0 {
-	status = "okay";
-	phys = <&comphy1 0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
-};
-
-/* J6 */
-&sata {
-	status = "okay";
-	phys = <&comphy2 0>;
-	phy-names = "sata-phy";
-};
-
-/* J1 */
-&sdhci1 {
-	wp-inverted;
-	bus-width = <4>;
-	cd-gpios = <&gpionb 3 GPIO_ACTIVE_LOW>;
-	marvell,pad-type = "sd";
-	vqmmc-supply = <&vcc_sd_reg1>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdio_pins>;
-	status = "okay";
-};
-
-/* U11 */
-&sdhci0 {
-	non-removable;
-	bus-width = <8>;
-	mmc-ddr-1_8v;
-	mmc-hs400-1_8v;
-	marvell,xenon-emmc;
-	marvell,xenon-tun-count = <9>;
-	marvell,pad-type = "fixed-1-8v";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc_pins>;
-/*
- * This eMMC is not populated on all boards, so disable it by
- * default and let the bootloader enable it, if it is present
- */
-	status = "disabled";
-};
-
-&spi0 {
-	status = "okay";
-
-	flash@0 {
-		reg = <0>;
-		compatible = "winbond,w25q32dw", "jedec,spi-flash";
-		spi-max-frequency = <104000000>;
-		m25p,fast-read;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				label = "uboot";
-				reg = <0 0x180000>;
-			};
-
-			partition@180000 {
-				label = "ubootenv";
-				reg = <0x180000 0x10000>;
-			};
-		};
-	};
-};
-
-/* Exported on the micro USB connector J5 through an FTDI */
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins>;
-	status = "okay";
-};
-
-/*
- * Connector J17 and J18 expose a number of different features. Some pins are
- * multiplexed. This is the case for instance for the following features:
- * - UART1 (pin 24 = RX, pin 26 = TX). See armada-3720-db.dts for an example of
- *   how to enable it. Beware that the signals are 1.8V TTL.
- * - I2C
- * - SPI
- * - MMC
- */
-
-/* J7 */
-&usb3 {
-	status = "okay";
-};
-
-/* J8 */
-&usb2 {
-	status = "okay";
-};
-
-&mdio {
-	switch0: switch0@1 {
-		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <1>;
-
-		dsa,member = <0 0>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				label = "cpu";
-				ethernet = <&eth0>;
-				phy-mode = "rgmii-id";
-				fixed-link {
-					speed = <1000>;
-					full-duplex;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-				label = "wan";
-				phy-handle = <&switch0phy0>;
-			};
-
-			port@2 {
-				reg = <2>;
-				label = "lan0";
-				phy-handle = <&switch0phy1>;
-			};
-
-			port@3 {
-				reg = <3>;
-				label = "lan1";
-				phy-handle = <&switch0phy2>;
-			};
-
-		};
-
-		mdio {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			switch0phy0: switch0phy0@11 {
-				reg = <0x11>;
-			};
-			switch0phy1: switch0phy1@12 {
-				reg = <0x12>;
-			};
-			switch0phy2: switch0phy2@13 {
-				reg = <0x13>;
-			};
-		};
-	};
-};
-
-&eth0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins>, <&smi_pins>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-
-	fixed-link {
-		speed = <1000>;
-		full-duplex;
-	};
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
new file mode 100644
index 000000000000..4a114db76bf9
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for Globalscale Marvell ESPRESSOBin Board
+ * Copyright (C) 2016 Marvell
+ *
+ * Romain Perier <romain.perier@free-electrons.com>
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "armada-372x.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
+	};
+
+	vcc_sd_reg1: regulator {
+		compatible = "regulator-gpio";
+		regulator-name = "vcc_sd1";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+
+		gpios = <&gpionb 4 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+		enable-active-high;
+	};
+};
+
+/* J9 */
+&pcie0 {
+	status = "okay";
+	phys = <&comphy1 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
+};
+
+/* J6 */
+&sata {
+	status = "okay";
+	phys = <&comphy2 0>;
+	phy-names = "sata-phy";
+};
+
+/* J1 */
+&sdhci1 {
+	wp-inverted;
+	bus-width = <4>;
+	cd-gpios = <&gpionb 3 GPIO_ACTIVE_LOW>;
+	marvell,pad-type = "sd";
+	vqmmc-supply = <&vcc_sd_reg1>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio_pins>;
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+
+	flash@0 {
+		reg = <0>;
+		compatible = "winbond,w25q32dw", "jedec,spi-flash";
+		spi-max-frequency = <104000000>;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "uboot";
+				reg = <0 0x180000>;
+			};
+
+			partition@180000 {
+				label = "ubootenv";
+				reg = <0x180000 0x10000>;
+			};
+		};
+	};
+};
+
+/* Exported on the micro USB connector J5 through an FTDI */
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+/*
+ * Connector J17 and J18 expose a number of different features. Some pins are
+ * multiplexed. This is the case for instance for the following features:
+ * - UART1 (pin 24 = RX, pin 26 = TX). See armada-3720-db.dts for an example of
+ *   how to enable it. Beware that the signals are 1.8V TTL.
+ * - I2C
+ * - SPI
+ * - MMC
+ */
+
+/* J7 */
+&usb3 {
+	status = "okay";
+};
+
+/* J8 */
+&usb2 {
+	status = "okay";
+};
+
+&mdio {
+	switch0: switch0@1 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1>;
+
+		dsa,member = <0 0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				label = "cpu";
+				ethernet = <&eth0>;
+				phy-mode = "rgmii-id";
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				label = "wan";
+				phy-handle = <&switch0phy0>;
+			};
+
+			port@2 {
+				reg = <2>;
+				label = "lan0";
+				phy-handle = <&switch0phy1>;
+			};
+
+			port@3 {
+				reg = <3>;
+				label = "lan1";
+				phy-handle = <&switch0phy2>;
+			};
+
+		};
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch0phy0: switch0phy0@11 {
+				reg = <0x11>;
+			};
+			switch0phy1: switch0phy1@12 {
+				reg = <0x12>;
+			};
+			switch0phy2: switch0phy2@13 {
+				reg = <0x13>;
+			};
+		};
+	};
+};
+
+&eth0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>, <&smi_pins>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
-- 
2.21.0

