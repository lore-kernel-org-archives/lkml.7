Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6752AC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D01279F1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpcLZNtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfFCPyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:54:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37781 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbfFCPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:54:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id h1so12648492wro.4;
        Mon, 03 Jun 2019 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0zKx35JS5zDMZj/xr7RSXIs88Xc/ONr10+AAkHp/7/4=;
        b=tpcLZNtKMEYeQSJEsQt279ld1LQAuKADyD7SfARmACN4YqxGd0v5OiRBtbAneQtXYL
         LZFtNMXLRvO8e3OVMbCmzok7I2Hd/2BRxXPVtVCGpTRh4hqNQyuaFSn+s9h3ui8FD5W1
         SAxHwjx5MnmwBoHIbE4QOTWrl4q/jTVXileqrI98QaMJsjEURis+s8ibZRX/52CJZuCl
         2OpxGF69wM17yImvjh4SnT3SMjorTS7HabZMq/Dnd1k6y0h0mONqrMvAohj3ARlT9v4r
         lXS9zMcv9UMrT/wo5mihvUnNr9FofgjVOPTlgzG1fGR3+evZ+35b7iq6wAKuWHjeyixz
         FHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0zKx35JS5zDMZj/xr7RSXIs88Xc/ONr10+AAkHp/7/4=;
        b=cbV5RrLki2JeWbnU97fqNSZSyWA7TfikmzpPR5Fomma52ZSt2f6wkeDJ/zQEPdV3cH
         FOQY+3c8J7MoHwYJovY0XSpitz+pbd17iFmc4j6IL2+3cxdVA7Gzuqh708eiLqcONZwj
         bKQwlbyhs91xxzTx3JSGK3ZWa+gZsf73Q0s7LbNuCZqzU8z0IBpgiOEVtaJGL4C0XJmR
         qLrPy0JTYVRUjq13H1UL5cDuJkvfQjf8WuzDe8u170ir2q60q8CA3uy1eDGKTR9/qMXE
         VNjnQ/6dqFRjylwkPQarazYGaVT7uLAhBILmpOsx2cRZzASoqlx022V7zyDegMdMvwg9
         EoqQ==
X-Gm-Message-State: APjAAAX3HBTE12u/29E327kZnCrjzfxGBvtf1zxVBSkbRW5Pb7fnokNO
        HTEvxNK7bV+s1Rts15R74jY=
X-Google-Smtp-Source: APXvYqxWzvR+hTMAKm7t8aJRIJw0yo5NM9QWBl6GuHKabjC2Mt/hUJ3UdANULWv26ZTRqSBHh1ValA==
X-Received: by 2002:adf:c654:: with SMTP id u20mr3367325wrg.271.1559577257310;
        Mon, 03 Jun 2019 08:54:17 -0700 (PDT)
Received: from localhost.localdomain (131.ip-164-132-48.eu. [164.132.48.131])
        by smtp.googlemail.com with ESMTPSA id l190sm14187767wml.25.2019.06.03.08.54.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 08:54:16 -0700 (PDT)
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Konstantin Porotchkin <kostap@marvell.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: marvell: add ESPRESSObin variants
Date:   Mon,  3 Jun 2019 17:53:54 +0200
Message-Id: <20190603155354.3902-1-tmn505@gmail.com>
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
v1 -> v2 rebase on top of:
mvebu/dt64 + "arm64: dts: armada-3720-espressobin: correct spi node"

 .../marvell/armada-3720-espressobin-emmc.dts  |  42 ++++
 .../armada-3720-espressobin-v7-emmc.dts       |  59 ++++++
 .../marvell/armada-3720-espressobin-v7.dts    |  36 ++++
 .../dts/marvell/armada-3720-espressobin.dts   | 184 +-----------------
 .../dts/marvell/armada-3720-espressobin.dtsi  | 177 +++++++++++++++++
 5 files changed, 315 insertions(+), 183 deletions(-)
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
index fbcf03f86c96..1542d836c090 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -12,191 +12,9 @@
 
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
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <104000000>;
-		m25p,fast-read;
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
index 000000000000..53b8ac55a7f3
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -0,0 +1,177 @@
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
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <104000000>;
+		m25p,fast-read;
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

