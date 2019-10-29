Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C289CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCE6208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfJ2L1u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:27:50 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:49802 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfJ2L1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:27:49 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 7F92467A7C4;
        Tue, 29 Oct 2019 12:27:45 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 29 Oct
 2019 12:27:45 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Tue, 29 Oct 2019 12:27:45 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/11] ARM: dts: imx6ul-kontron-n6310: Move common SoM
 nodes to a separate file
Thread-Topic: [PATCH v2 01/11] ARM: dts: imx6ul-kontron-n6310: Move common SoM
 nodes to a separate file
Thread-Index: AQHVjkviVL8xtBJ4o0ODmbX8FuWD1w==
Date:   Tue, 29 Oct 2019 11:27:44 +0000
Message-ID: <20191029112655.15058-2-frieder.schrempf@kontron.de>
References: <20191029112655.15058-1-frieder.schrempf@kontron.de>
In-Reply-To: <20191029112655.15058-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 7F92467A7C4.A009E
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The Kontron N6311 and N6411 SoMs are very similar to N6310. In
preparation to add support for them, we move the common nodes to a
separate file imx6ul-kontron-n6x1x-som-common.dtsi.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../boot/dts/imx6ul-kontron-n6310-som.dtsi    |  95 +---------------
 .../dts/imx6ul-kontron-n6x1x-som-common.dtsi  | 103 ++++++++++++++++++
 2 files changed, 104 insertions(+), 94 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi

diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
index a896b2348dd2..47d3ce5d255f 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
@@ -6,7 +6,7 @@
  */
 
 #include "imx6ul.dtsi"
-#include <dt-bindings/gpio/gpio.h>
+#include "imx6ul-kontron-n6x1x-som-common.dtsi"
 
 / {
 	model = "Kontron N6310 SOM";
@@ -18,49 +18,7 @@
 	};
 };
 
-&ecspi2 {
-	cs-gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi2>;
-	status = "okay";
-
-	spi-flash@0 {
-		compatible = "mxicy,mx25v8035f", "jedec,spi-nor";
-		spi-max-frequency = <50000000>;
-		reg = <0>;
-	};
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy1>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy1: ethernet-phy@1 {
-			reg = <1>;
-			micrel,led-mode = <0>;
-			clocks = <&clks IMX6UL_CLK_ENET_REF>;
-			clock-names = "rmii-ref";
-		};
-	};
-};
-
-&fec2 {
-	phy-mode = "rmii";
-	status = "disabled";
-};
-
 &qspi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_qspi>;
-	status = "okay";
-
 	spi-flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -81,54 +39,3 @@
 		};
 	};
 };
-
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_reset_out>;
-
-	pinctrl_ecspi2: ecspi2grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_DATA03__ECSPI2_MISO      0x100b1
-			MX6UL_PAD_CSI_DATA02__ECSPI2_MOSI      0x100b1
-			MX6UL_PAD_CSI_DATA00__ECSPI2_SCLK      0x100b1
-			MX6UL_PAD_CSI_DATA01__GPIO4_IO22       0x100b1
-		>;
-	};
-
-	pinctrl_enet1: enet1grp {
-		fsl,pins = <
-			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN      0x1b0b0
-			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER      0x1b0b0
-			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00 0x1b0b0
-			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01 0x1b0b0
-			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN      0x1b0b0
-			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00 0x1b0b0
-			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01 0x1b0b0
-			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1  0x4001b009
-		>;
-	};
-
-	pinctrl_enet1_mdio: enet1mdiogrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO07__ENET1_MDC         0x1b0b0
-			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO        0x1b0b0
-		>;
-	};
-
-	pinctrl_qspi: qspigrp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_WP_B__QSPI_A_SCLK        0x70a1
-			MX6UL_PAD_NAND_READY_B__QSPI_A_DATA00   0x70a1
-			MX6UL_PAD_NAND_CE0_B__QSPI_A_DATA01     0x70a1
-			MX6UL_PAD_NAND_CE1_B__QSPI_A_DATA02     0x70a1
-			MX6UL_PAD_NAND_CLE__QSPI_A_DATA03       0x70a1
-			MX6UL_PAD_NAND_DQS__QSPI_A_SS0_B        0x70a1
-		>;
-	};
-
-	pinctrl_reset_out: rstoutgrp {
-		fsl,pins = <
-			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x1b0b0
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
new file mode 100644
index 000000000000..a843e028bcde
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 exceet electronics GmbH
+ * Copyright (C) 2018 Kontron Electronics GmbH
+ * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+&ecspi2 {
+	cs-gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	status = "okay";
+
+	spi-flash@0 {
+		compatible = "mxicy,mx25v8035f", "jedec,spi-nor";
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			micrel,led-mode = <0>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
+		};
+	};
+};
+
+&fec2 {
+	phy-mode = "rmii";
+	status = "disabled";
+};
+
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_reset_out>;
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_DATA03__ECSPI2_MISO      0x100b1
+			MX6UL_PAD_CSI_DATA02__ECSPI2_MOSI      0x100b1
+			MX6UL_PAD_CSI_DATA00__ECSPI2_SCLK      0x100b1
+			MX6UL_PAD_CSI_DATA01__GPIO4_IO22       0x100b1
+		>;
+	};
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN      0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER      0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00 0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01 0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN      0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00 0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01 0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1  0x4001b009
+		>;
+	};
+
+	pinctrl_enet1_mdio: enet1mdiogrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO07__ENET1_MDC         0x1b0b0
+			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO        0x1b0b0
+		>;
+	};
+
+	pinctrl_qspi: qspigrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_WP_B__QSPI_A_SCLK        0x70a1
+			MX6UL_PAD_NAND_READY_B__QSPI_A_DATA00   0x70a1
+			MX6UL_PAD_NAND_CE0_B__QSPI_A_DATA01     0x70a1
+			MX6UL_PAD_NAND_CE1_B__QSPI_A_DATA02     0x70a1
+			MX6UL_PAD_NAND_CLE__QSPI_A_DATA03       0x70a1
+			MX6UL_PAD_NAND_DQS__QSPI_A_SS0_B        0x70a1
+		>;
+	};
+
+	pinctrl_reset_out: rstoutgrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x1b0b0
+		>;
+	};
+};
-- 
2.17.1
