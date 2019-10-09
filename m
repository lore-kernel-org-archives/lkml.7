Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8099ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC1A20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfJIHKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:10:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:63511 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbfJIHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:10:35 -0400
X-UUID: 1fa98d635c94487bab89cacdd5ac999f-20191009
X-UUID: 1fa98d635c94487bab89cacdd5ac999f-20191009
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1725052915; Wed, 09 Oct 2019 15:10:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 15:10:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 15:10:24 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yt.shen@mediatek.com>,
        <biao.huang@mediatek.com>, <jianguo.zhang@mediatek.com>
Subject: [v2,PATCH] arm64: dts: mt2712: add ethernet device node
Date:   Wed, 9 Oct 2019 15:10:22 +0800
Message-ID: <20191009071022.4972-2-biao.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191009071022.4972-1-biao.huang@mediatek.com>
References: <20191009071022.4972-1-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 99EC05613A77FD75F169F1C8A4B61185A46644F74C47718850173345332FD7992000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add device node for mt2712 ethernet.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 74 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 65 ++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index 1353dad2f53c..fd6ab6cc5fe7 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -107,7 +107,81 @@
 	proc-supply = <&cpus_fixed_vproc1>;
 };
 
+&eth {
+	phy-mode ="rgmii-rxid";
+	phy-handle = <&ethernet_phy0>;
+	mediatek,tx-delay-ps = <1530>;
+	snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default>;
+	pinctrl-1 = <&eth_sleep>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ethernet_phy0: ethernet-phy@5 {
+			compatible = "ethernet-phy-id0243.0d90";
+			reg = <0x5>;
+		};
+	};
+};
+
 &pio {
+	eth_default: eth_default {
+		tx_pins {
+			pinmux = <MT2712_PIN_71_GBE_TXD3__FUNC_GBE_TXD3>,
+				 <MT2712_PIN_72_GBE_TXD2__FUNC_GBE_TXD2>,
+				 <MT2712_PIN_73_GBE_TXD1__FUNC_GBE_TXD1>,
+				 <MT2712_PIN_74_GBE_TXD0__FUNC_GBE_TXD0>,
+				 <MT2712_PIN_75_GBE_TXC__FUNC_GBE_TXC>,
+				 <MT2712_PIN_76_GBE_TXEN__FUNC_GBE_TXEN>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+		rx_pins {
+			pinmux = <MT2712_PIN_78_GBE_RXD3__FUNC_GBE_RXD3>,
+				 <MT2712_PIN_79_GBE_RXD2__FUNC_GBE_RXD2>,
+				 <MT2712_PIN_80_GBE_RXD1__FUNC_GBE_RXD1>,
+				 <MT2712_PIN_81_GBE_RXD0__FUNC_GBE_RXD0>,
+				 <MT2712_PIN_82_GBE_RXDV__FUNC_GBE_RXDV>,
+				 <MT2712_PIN_84_GBE_RXC__FUNC_GBE_RXC>;
+			input-enable;
+		};
+		mdio_pins {
+			pinmux = <MT2712_PIN_85_GBE_MDC__FUNC_GBE_MDC>,
+				 <MT2712_PIN_86_GBE_MDIO__FUNC_GBE_MDIO>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			input-enable;
+		};
+	};
+
+	eth_sleep: eth_sleep {
+		tx_pins {
+			pinmux = <MT2712_PIN_71_GBE_TXD3__FUNC_GPIO71>,
+				 <MT2712_PIN_72_GBE_TXD2__FUNC_GPIO72>,
+				 <MT2712_PIN_73_GBE_TXD1__FUNC_GPIO73>,
+				 <MT2712_PIN_74_GBE_TXD0__FUNC_GPIO74>,
+				 <MT2712_PIN_75_GBE_TXC__FUNC_GPIO75>,
+				 <MT2712_PIN_76_GBE_TXEN__FUNC_GPIO76>;
+		};
+		rx_pins {
+			pinmux = <MT2712_PIN_78_GBE_RXD3__FUNC_GPIO78>,
+				 <MT2712_PIN_79_GBE_RXD2__FUNC_GPIO79>,
+				 <MT2712_PIN_80_GBE_RXD1__FUNC_GPIO80>,
+				 <MT2712_PIN_81_GBE_RXD0__FUNC_GPIO81>,
+				 <MT2712_PIN_82_GBE_RXDV__FUNC_GPIO82>,
+				 <MT2712_PIN_84_GBE_RXC__FUNC_GPIO84>;
+			input-disable;
+		};
+		mdio_pins {
+			pinmux = <MT2712_PIN_85_GBE_MDC__FUNC_GPIO85>,
+				 <MT2712_PIN_86_GBE_MDIO__FUNC_GPIO86>;
+			input-disable;
+			bias-disable;
+		};
+	};
+
 	usb0_id_pins_float: usb0_iddig {
 		pins_iddig {
 			pinmux = <MT2712_PIN_12_IDDIG_P0__FUNC_IDDIG_A>;
diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 43307bad3f0d..b2edec20c8da 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -632,6 +632,71 @@
 		status = "disabled";
 	};
 
+	stmmac_axi_setup: stmmac-axi-config {
+		snps,wr_osr_lmt = <0x7>;
+		snps,rd_osr_lmt = <0x7>;
+		snps,blen = <0 0 0 0 16 8 4>;
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <1>;
+		snps,rx-sched-sp;
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,priority = <0x0>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <3>;
+		snps,tx-sched-wrr;
+		queue0 {
+			snps,weight = <0x10>;
+			snps,dcb-algorithm;
+			snps,priority = <0x0>;
+		};
+		queue1 {
+			snps,weight = <0x11>;
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+		queue2 {
+			snps,weight = <0x12>;
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+	};
+
+	eth: ethernet@1101c000 {
+		compatible = "mediatek,mt2712-gmac";
+		reg = <0 0x1101c000 0 0x1300>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "macirq";
+		mac-address = [00 55 7b b5 7d f7];
+		clock-names = "axi",
+			      "apb",
+			      "mac_main",
+			      "ptp_ref";
+		clocks = <&pericfg CLK_PERI_GMAC>,
+			 <&pericfg CLK_PERI_GMAC_PCLK>,
+			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
+			 <&topckgen CLK_TOP_ETHER_50M_SEL>;
+		assigned-clocks = <&topckgen CLK_TOP_ETHER_125M_SEL>,
+				  <&topckgen CLK_TOP_ETHER_50M_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_ETHERPLL_125M>,
+					 <&topckgen CLK_TOP_APLL1_D3>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_AUDIO>;
+		mediatek,pericfg = <&pericfg>;
+		snps,axi-config = <&stmmac_axi_setup>;
+		snps,mtl-rx-config = <&mtl_rx_setup>;
+		snps,mtl-tx-config = <&mtl_tx_setup>;
+		snps,txpbl = <1>;
+		snps,rxpbl = <1>;
+		clk_csr = <0>;
+		status = "disabled";
+	};
+
 	mmc0: mmc@11230000 {
 		compatible = "mediatek,mt2712-mmc";
 		reg = <0 0x11230000 0 0x1000>;
-- 
2.18.0

