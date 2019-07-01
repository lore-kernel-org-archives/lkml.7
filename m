Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CD4C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C17B204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JItaK0E6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfGALnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:43:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52192 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfGALnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:43:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so15491308wma.1;
        Mon, 01 Jul 2019 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JYJgRH2Ze3yPGTUxWuKTviYfPr0ALPnjZTt1sDtuFy4=;
        b=JItaK0E6rA9Aws8ukFmmmWXC0Mu/kH8+FEoa/9+2Onn6mLdNDLPaqTQMz+c6oIuLtY
         ATrVfupa8nzwfaAPyL1HrbNea4cb6JoYTctexEofyr/9iFpwGNU4/RFYcV72TA6XfbAC
         A9EclClpdBKKaNTfFkB73zAgkg06YUr0t7V8EigvnFa9huLlwiSmQyzl62RIYVNGezYI
         ve+LoUYa6zqD/jwV+u3yAlvk+CvBjCCXp/+T+gN8zCs+Y0tbw7KkQ8Bd8ETdfN1Vtpro
         UgVjTD6XNmwJ3nUvKn0EFr43hRDRAuaxdpajnRRpZSRJEgaUnYX3yv4la4k/WfKybrx+
         PPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JYJgRH2Ze3yPGTUxWuKTviYfPr0ALPnjZTt1sDtuFy4=;
        b=Km1xHrTZiT/6wt3WsWdZzZGUsdnbLIRJfa/198xtIrKen9/HHoNXlEoahXs68WxEnm
         zw4Dr4sLOoj1+VQZI//yrJy3JEACuu6+u3MK9VOiSRxR9GFrHZqazekwYGoRuDgMAeXC
         TwWd6WrX1wjkTuo2kCcjwsmtlSeKZeMGLOB6AaC4OEokJTmFsf6qI6qRT5DFGqdZwMFR
         +mEnUh1N7yRuN9XmVlqpmvk/76ij2gw1Uecqr8SmtG97L+IKS9jQrA0iAFK4un3e5DBf
         +DfNxJB7TKN6wXqO4q5rOKZdwhZZ6o/PQj5rBJIkrjxAiE1Gbp57iPKkIxBuH/FWjvlP
         G+vg==
X-Gm-Message-State: APjAAAXV8HRRjcHSBQxkX9EsuK1Uv6VpMz7QvqceNrY6nDcKlAoBPfph
        +7E24IXp4rVSHtAk8BGERNs=
X-Google-Smtp-Source: APXvYqx253YFB556MIWU5JxxVYLmmy4RDyDUqXIbzIzQ7Wilnvan3p0A7bhNoHAVzb+4iPpdaPom3A==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr16499081wme.12.1561981419987;
        Mon, 01 Jul 2019 04:43:39 -0700 (PDT)
Received: from localhost ([193.47.161.132])
        by smtp.gmail.com with ESMTPSA id r12sm10881261wrt.95.2019.07.01.04.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jul 2019 04:43:39 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver.graute@kococonnector.com>
To:     aisheng.dong@nxp.com
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Sriram Dash <sriram.dash@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 2/2] arm64: dts: add basic DTS for imx8qm-rom7720-a1 board
Date:   Mon,  1 Jul 2019 13:42:46 +0200
Message-Id: <20190701114253.1538-3-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701114253.1538-1-oliver.graute@kococonnector.com>
References: <20190701114253.1538-1-oliver.graute@kococonnector.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic dts support for a Advantech iMX8QM Qseven Board

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8qm-rom7720-a1.dts  | 221 ++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index b8e5e3bd72c5..b013715c5be1 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -23,3 +23,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qm-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qm-rom7720-a1.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts b/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts
new file mode 100644
index 000000000000..229853f4097b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/dts-v1/;
+
+#include "imx8qm.dtsi"
+
+/ {
+	model = "Advantech iMX8QM Qseven series";
+	compatible = "fsl,imx8qm";
+
+	board {
+		compatible = "proc-board";
+		board-type = "ROM-7720_A1";
+		board-cpu  = "iMX8QM";
+	};
+
+	chosen {
+		bootargs = "console=ttyLP0,115200 earlycon=lpuart32,0x5a060000,115200";
+		stdout-path = &dma_lpuart0;
+	};
+
+	cpus {
+		/delete-node/ cpu-map;
+		/delete-node/ cpu@100;
+		/delete-node/ cpu@101;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x40000000>;
+	};
+
+	reg_usdhc2_vmmc: usdhc2_vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "sw-3p3-sd1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 7 GPIO_ACTIVE_HIGH>;
+		off-on-delay = <3000>;
+		enable-active-high;
+	};
+};
+
+&dma_lpuart0 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart0>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-txid";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	fsl,rgmii_rxc_dly;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <4>;
+			at803x,eee-disabled;
+			at803x,vddio-1p8v;
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	bus-width = <4>;
+	cd-gpios = <&gpio5 22 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio5 21 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_hog_1: hoggrp-1 {
+		fsl,pins = <
+			IMX8QM_USB_SS3_TC0_LSIO_GPIO4_IO03	  0x06000048
+		>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB_PAD	0x000014a0
+			IMX8QM_ENET0_MDC_CONN_ENET0_MDC			0x06000020
+			IMX8QM_ENET0_MDIO_CONN_ENET0_MDIO		0x06000020
+			IMX8QM_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x00000060
+			IMX8QM_ENET0_RGMII_TXC_CONN_ENET0_RGMII_TXC	0x00000060
+			IMX8QM_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0	0x00000060
+			IMX8QM_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1	0x00000060
+			IMX8QM_ENET0_RGMII_TXD2_CONN_ENET0_RGMII_TXD2	0x00000060
+			IMX8QM_ENET0_RGMII_TXD3_CONN_ENET0_RGMII_TXD3	0x00000060
+			IMX8QM_ENET0_RGMII_RXC_CONN_ENET0_RGMII_RXC	0x00000060
+			IMX8QM_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL	0x00000060
+			IMX8QM_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0	0x00000060
+			IMX8QM_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1	0x00000060
+			IMX8QM_ENET0_RGMII_RXD2_CONN_ENET0_RGMII_RXD2	0x00000060
+			IMX8QM_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3	0x00000060
+		>;
+	};
+
+	pinctrl_lpuart0: lpuart0grp {
+		fsl,pins = <
+			IMX8QM_UART0_RX_DMA_UART0_RX		0x06000020
+			IMX8QM_UART0_TX_DMA_UART0_TX		0x06000020
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK		0x06000041
+			IMX8QM_EMMC0_CMD_CONN_EMMC0_CMD		0x00000021
+			IMX8QM_EMMC0_DATA0_CONN_EMMC0_DATA0	0x00000021
+			IMX8QM_EMMC0_DATA1_CONN_EMMC0_DATA1	0x00000021
+			IMX8QM_EMMC0_DATA2_CONN_EMMC0_DATA2	0x00000021
+			IMX8QM_EMMC0_DATA3_CONN_EMMC0_DATA3	0x00000021
+			IMX8QM_EMMC0_DATA4_CONN_EMMC0_DATA4	0x00000021
+			IMX8QM_EMMC0_DATA5_CONN_EMMC0_DATA5	0x00000021
+			IMX8QM_EMMC0_DATA6_CONN_EMMC0_DATA6	0x00000021
+			IMX8QM_EMMC0_DATA7_CONN_EMMC0_DATA7	0x00000021
+			IMX8QM_EMMC0_STROBE_CONN_EMMC0_STROBE	0x00000041
+			IMX8QM_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x00000021
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK		0x06000040
+			IMX8QM_EMMC0_CMD_CONN_EMMC0_CMD		0x00000020
+			IMX8QM_EMMC0_DATA0_CONN_EMMC0_DATA0	0x00000020
+			IMX8QM_EMMC0_DATA1_CONN_EMMC0_DATA1	0x00000020
+			IMX8QM_EMMC0_DATA2_CONN_EMMC0_DATA2	0x00000020
+			IMX8QM_EMMC0_DATA3_CONN_EMMC0_DATA3	0x00000020
+			IMX8QM_EMMC0_DATA4_CONN_EMMC0_DATA4	0x00000020
+			IMX8QM_EMMC0_DATA5_CONN_EMMC0_DATA5	0x00000020
+			IMX8QM_EMMC0_DATA6_CONN_EMMC0_DATA6	0x00000020
+			IMX8QM_EMMC0_DATA7_CONN_EMMC0_DATA7	0x00000020
+			IMX8QM_EMMC0_STROBE_CONN_EMMC0_STROBE	0x00000040
+			IMX8QM_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x00000020
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK		0x06000040
+				IMX8QM_EMMC0_CMD_CONN_EMMC0_CMD		0x00000020
+			IMX8QM_EMMC0_DATA0_CONN_EMMC0_DATA0	0x00000020
+			IMX8QM_EMMC0_DATA1_CONN_EMMC0_DATA1	0x00000020
+			IMX8QM_EMMC0_DATA2_CONN_EMMC0_DATA2	0x00000020
+			IMX8QM_EMMC0_DATA3_CONN_EMMC0_DATA3	0x00000020
+			IMX8QM_EMMC0_DATA4_CONN_EMMC0_DATA4	0x00000020
+			IMX8QM_EMMC0_DATA5_CONN_EMMC0_DATA5	0x00000020
+			IMX8QM_EMMC0_DATA6_CONN_EMMC0_DATA6	0x00000020
+			IMX8QM_EMMC0_DATA7_CONN_EMMC0_DATA7	0x00000020
+			IMX8QM_EMMC0_STROBE_CONN_EMMC0_STROBE	0x00000040
+			IMX8QM_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x00000020
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+		fsl,pins = <
+			IMX8QM_USDHC1_DATA6_LSIO_GPIO5_IO21	0x00000021
+			IMX8QM_USDHC1_DATA7_LSIO_GPIO5_IO22	0x00000021
+			IMX8QM_USDHC1_RESET_B_LSIO_GPIO4_IO07	0x00000021
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX8QM_USDHC1_CLK_CONN_USDHC1_CLK	0x06000041
+			IMX8QM_USDHC1_CMD_CONN_USDHC1_CMD	0x00000021
+			IMX8QM_USDHC1_DATA0_CONN_USDHC1_DATA0	0x00000021
+			IMX8QM_USDHC1_DATA1_CONN_USDHC1_DATA1	0x00000021
+			IMX8QM_USDHC1_DATA2_CONN_USDHC1_DATA2	0x00000021
+			IMX8QM_USDHC1_DATA3_CONN_USDHC1_DATA3	0x00000021
+			IMX8QM_USDHC1_VSELECT_CONN_USDHC1_VSELECT	0x00000021
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins = <
+			IMX8QM_USDHC1_CLK_CONN_USDHC1_CLK	0x06000040
+			IMX8QM_USDHC1_CMD_CONN_USDHC1_CMD	0x00000020
+			IMX8QM_USDHC1_DATA0_CONN_USDHC1_DATA0	0x00000020
+			IMX8QM_USDHC1_DATA1_CONN_USDHC1_DATA1	0x00000020
+			IMX8QM_USDHC1_DATA2_CONN_USDHC1_DATA2	0x00000020
+			IMX8QM_USDHC1_DATA3_CONN_USDHC1_DATA3	0x00000020
+			IMX8QM_USDHC1_VSELECT_CONN_USDHC1_VSELECT	0x00000020
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins = <
+			IMX8QM_USDHC1_CLK_CONN_USDHC1_CLK	0x06000040
+			IMX8QM_USDHC1_CMD_CONN_USDHC1_CMD	0x00000020
+			IMX8QM_USDHC1_DATA0_CONN_USDHC1_DATA0	0x00000020
+			IMX8QM_USDHC1_DATA1_CONN_USDHC1_DATA1	0x00000020
+			IMX8QM_USDHC1_DATA2_CONN_USDHC1_DATA2	0x00000020
+			IMX8QM_USDHC1_DATA3_CONN_USDHC1_DATA3	0x00000020
+			IMX8QM_USDHC1_VSELECT_CONN_USDHC1_VSELECT	0x00000020
+		>;
+	};
+};
-- 
2.17.1

