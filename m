Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9968C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8473120818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xc1xRNuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGQGLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:11:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39897 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfGQGLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:11:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so6304513pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 23:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RbXsDOZtHwZ08bPRDrLEB86RltE7V0AqNmUN9K9esMo=;
        b=xc1xRNuTmLWP+xE8Z4chh1rj2crfMCPSeR4OVVdivGE56KFhCejb0m6EWtbbImD7sd
         YjwDywkW58TFUH47eNllJkv21IKYuRVRbyUmG53pcTsQAXMxAfb6qcticJ149KP58PHG
         a5PY2Z5AX4DbJzEg2Mki9J1JPjFlCl5FGkhWnjC/m7V0Uxu1y+bej00zpkyrezTHngv8
         5Lu6dnmqFOrEu/w/OTE1NmNQ+vZFc/6jaJovHJTQiAr39BtSg5uqs1WnNXlpxRhia8dc
         PzHIaGGGsWF2GiWq1v+muDw0d989Ex8jrTXANXXVdxwNtqsaJbhSQkUxnJrX7p4oPuN3
         3s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RbXsDOZtHwZ08bPRDrLEB86RltE7V0AqNmUN9K9esMo=;
        b=h6GslcuBuWov29h8FSo3RwiuNsR5u9+AFXoY/Gt6rdpkCy8bXn0ckgGxLEQM5lF/Xl
         wb63s/6KpWbv5+N1wi+G4zpea5zT4ncrxpZ8OKJNAgCnbpMTCd8chHdy1t5hGV49oOCx
         X9ylnkXwu9TungAMM1y//TVYGS/u6ow+Fn8CL4e7t+JKZ0rSz/5dOQUwbByt2+1AyVZE
         cH29yaaNgMQeewjo6ggaai6iDRY0YQLnUjKItbh1iSYBMIz7XHdkq1XuwN4nMpc9QVTw
         Md8OAm8qasGajiTK8HGuQnGds/CPl4DabLsz4G23X4ywcIFca2dxLY7GIhhvXJLJDm5Y
         lKuA==
X-Gm-Message-State: APjAAAXRUr0ghpnmbibKyELR60Pd7ykNvuiIM4ScryfMZpgH/T6f9ma+
        evIYiegCjPO+1Pz60tPP4sYu
X-Google-Smtp-Source: APXvYqyqMxFEIwtjWXr8/mzqg8O0We8uIfXn1IRKysycAylkQmf2mavIqLqR8pjSWGMdj25tZ1bXAA==
X-Received: by 2002:a17:90a:bc42:: with SMTP id t2mr41770260pjv.121.1563343874706;
        Tue, 16 Jul 2019 23:11:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7301:59e6:f493:40df:9c8a:5041])
        by smtp.gmail.com with ESMTPSA id r27sm25993313pgn.25.2019.07.16.23.11.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 23:11:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Darshak.Patel@einfochips.com,
        kinjan.patel@einfochips.com, prajose.john@einfochips.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] arm64: dts: freescale: Add support for i.MX8QXP AI_ML board
Date:   Wed, 17 Jul 2019 11:40:39 +0530
Message-Id: <20190717061039.9271-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717061039.9271-1-manivannan.sadhasivam@linaro.org>
References: <20190717061039.9271-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for i.MX8QXP AI_ML board from Einfochips. This board is one
of the Consumer Edition boards of the 96Boards family based on i.MX8QXP
SoC from NXP/Freescale.

The initial support includes following peripherals which are tested and
known to be working:

1. Debug serial via UART2
2. uSD
3. WiFi
4. Ethernet

More information about this board can be found in Arrow website:
https://www.arrow.com/en/products/imx8-ai-ml/arrow-development-tools

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8qxp-ai_ml.dts      | 249 ++++++++++++++++++
 2 files changed, 250 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0bd122f60549..bd8460549d1a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -24,4 +24,5 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts b/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
new file mode 100644
index 000000000000..dcd36e57d916
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 Einfochips
+ * Copyright 2019 Linaro Ltd.
+ */
+
+/dts-v1/;
+
+#include "imx8qxp.dtsi"
+
+/ {
+	model = "Einfochips i.MX8QXP AI_ML";
+	compatible = "einfochips,imx8qxp-ai_ml", "fsl,imx8qxp";
+
+	aliases {
+		serial1 = &adma_lpuart1;
+		serial2 = &adma_lpuart2;
+		serial3 = &adma_lpuart3;
+	};
+
+	chosen {
+		stdout-path = &adma_lpuart2;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x80000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		user_led1 {
+			label = "green:user1";
+			gpios = <&lsio_gpio4 16 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "green:user2";
+			gpios = <&lsio_gpio0 6 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+		};
+
+		user_led3 {
+			label = "green:user3";
+			gpios = <&lsio_gpio0 7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc1";
+			default-state = "off";
+		};
+
+		user_led4 {
+			label = "green:user4";
+			gpios = <&lsio_gpio4 21 GPIO_ACTIVE_HIGH>;
+			panic-indicator;
+			linux,default-trigger = "none";
+		};
+
+		wlan_active_led {
+			label = "yellow:wlan";
+			gpios = <&lsio_gpio4 17 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt_active_led {
+			label = "blue:bt";
+			gpios = <&lsio_gpio4 18 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi_reg_on>;
+		reset-gpios = <&lsio_gpio3 24 GPIO_ACTIVE_LOW>;
+	};
+};
+
+/* BT */
+&adma_lpuart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart0>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+/* LS-I2C0 */
+&adma_lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart1>;
+	status = "okay";
+};
+
+/* Debug */
+&adma_lpuart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart2>;
+	status = "okay";
+};
+
+/* PCI-E */
+&adma_lpuart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart3>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+	};
+};
+
+/* WiFi */
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <4>;
+	no-sd;
+	non-removable;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+/* SD */
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <4>;
+	cd-gpios = <&lsio_gpio4 22 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			IMX8QXP_ENET0_MDC_CONN_ENET0_MDC			0x06000020
+			IMX8QXP_ENET0_MDIO_CONN_ENET0_MDIO			0x06000020
+			IMX8QXP_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x06000020
+			IMX8QXP_ENET0_RGMII_TXC_CONN_ENET0_RGMII_TXC		0x06000020
+			IMX8QXP_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0		0x06000020
+			IMX8QXP_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1		0x06000020
+			IMX8QXP_ENET0_RGMII_TXD2_CONN_ENET0_RGMII_TXD2		0x06000020
+			IMX8QXP_ENET0_RGMII_TXD3_CONN_ENET0_RGMII_TXD3		0x06000020
+			IMX8QXP_ENET0_RGMII_RXC_CONN_ENET0_RGMII_RXC		0x06000020
+			IMX8QXP_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL	0x06000020
+			IMX8QXP_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0		0x06000020
+			IMX8QXP_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1		0x06000020
+			IMX8QXP_ENET0_RGMII_RXD2_CONN_ENET0_RGMII_RXD2		0x06000020
+			IMX8QXP_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x06000020
+		>;
+	};
+
+	pinctrl_leds: ledsgrp{
+		fsl,pins = <
+			IMX8QXP_ESAI0_TX2_RX3_LSIO_GPIO0_IO06			0x00000021
+			IMX8QXP_ESAI0_TX3_RX2_LSIO_GPIO0_IO07			0x00000021
+			IMX8QXP_EMMC0_DATA7_LSIO_GPIO4_IO16			0x00000021
+			IMX8QXP_USDHC1_WP_LSIO_GPIO4_IO21			0x00000021
+			IMX8QXP_EMMC0_STROBE_LSIO_GPIO4_IO17			0x00000021
+			IMX8QXP_EMMC0_RESET_B_LSIO_GPIO4_IO18			0x00000021
+		>;
+	};
+
+	pinctrl_lpuart0: lpuart0grp {
+		fsl,pins = <
+			IMX8QXP_UART0_RX_ADMA_UART0_RX				0X06000020
+			IMX8QXP_UART0_TX_ADMA_UART0_TX				0X06000020
+			IMX8QXP_FLEXCAN0_TX_ADMA_UART0_CTS_B 			0x06000020
+			IMX8QXP_FLEXCAN0_RX_ADMA_UART0_RTS_B			0x06000020
+		>;
+	};
+
+	pinctrl_lpuart1: lpuart1grp {
+		fsl,pins = <
+			IMX8QXP_UART1_RX_ADMA_UART1_RX				0X06000020
+			IMX8QXP_UART1_TX_ADMA_UART1_TX				0X06000020
+		>;
+	};
+
+	pinctrl_lpuart2: lpuart2grp {
+		fsl,pins = <
+			IMX8QXP_UART2_RX_ADMA_UART2_RX				0X06000020
+			IMX8QXP_UART2_TX_ADMA_UART2_TX				0X06000020
+		>;
+	};
+
+	pinctrl_lpuart3: lpuart3grp {
+		fsl,pins = <
+			IMX8QXP_FLEXCAN2_RX_ADMA_UART3_RX			0X06000020
+			IMX8QXP_FLEXCAN2_TX_ADMA_UART3_TX			0X06000020
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK			0x06000041
+			IMX8QXP_EMMC0_CMD_CONN_EMMC0_CMD			0x00000021
+			IMX8QXP_EMMC0_DATA0_CONN_EMMC0_DATA0			0x00000021
+			IMX8QXP_EMMC0_DATA1_CONN_EMMC0_DATA1			0x00000021
+			IMX8QXP_EMMC0_DATA2_CONN_EMMC0_DATA2			0x00000021
+			IMX8QXP_EMMC0_DATA3_CONN_EMMC0_DATA3			0x00000021
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX8QXP_USDHC1_CLK_CONN_USDHC1_CLK			0x06000041
+			IMX8QXP_USDHC1_CMD_CONN_USDHC1_CMD			0x00000021
+			IMX8QXP_USDHC1_DATA0_CONN_USDHC1_DATA0			0x00000021
+			IMX8QXP_USDHC1_DATA1_CONN_USDHC1_DATA1			0x00000021
+			IMX8QXP_USDHC1_DATA2_CONN_USDHC1_DATA2			0x00000021
+			IMX8QXP_USDHC1_DATA3_CONN_USDHC1_DATA3			0x00000021
+			IMX8QXP_USDHC1_VSELECT_CONN_USDHC1_VSELECT		0x00000021
+			IMX8QXP_USDHC1_CD_B_LSIO_GPIO4_IO22			0x00000021
+		>;
+	};
+
+	pinctrl_wifi_reg_on: wifiregongrp {
+		fsl,pins = <
+			IMX8QXP_QSPI0B_SS1_B_LSIO_GPIO3_IO24			0x00000021
+		>;
+	};
+};
-- 
2.17.1

