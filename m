Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA210C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8468B2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfDPFou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 01:44:50 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:32045 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726016AbfDPFot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 01:44:49 -0400
X-UUID: 3986324081134e30af02bbc9d2f7b4dd-20190416
X-UUID: 3986324081134e30af02bbc9d2f7b4dd-20190416
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1418019611; Tue, 16 Apr 2019 13:44:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 13:44:36 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 13:44:22 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Jumin Li <jumin.li@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: mt8183: add usb node
Date:   Tue, 16 Apr 2019 13:44:04 +0800
Message-ID: <47a4d808c5f90f229b8bd132493138023c02ee01.1555392560.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jumin Li <jumin.li@mediatek.com>

Add USB DTS node to the mt8183 and mt8183-evb.

Signed-off-by: Jumin Li <jumin.li@mediatek.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
this patch is based on v5.1-rc1 and these patches:
https://patchwork.kernel.org/patch/10856987/
https://patchwork.kernel.org/patch/10839021/
https://patchwork.kernel.org/patch/10879015/
https://patchwork.kernel.org/patch/10878999/
https://patchwork.kernel.org/patch/10858941/
https://patchwork.kernel.org/patch/10846685/
https://patchwork.kernel.org/patch/10893519/
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 21 +++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 52 +++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 465cdabafd7c..8f88fd7457a1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -6,6 +6,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "mt8183.dtsi"
 #include "mt6358.dtsi"
 
@@ -25,6 +26,16 @@
 	chosen {
 		stdout-path = "serial0:921600n8";
 	};
+
+	usb_p0_vbus: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&pio 42 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
 };
 
 &mmc0 {
@@ -175,6 +186,16 @@
 	};
 };
 
+&ssusb {
+	vusb33-supply = <&mt6358_vusb_reg>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb_host {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index b36e37fcdfe3..c6970e688869 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt8183-power.h>
 #include "mt8183-pinfunc.h"
 / {
@@ -323,6 +324,33 @@
 			status = "disabled";
 		};
 
+		ssusb: usb@11201000 {
+			compatible ="mediatek,mt8183-mtu3", "mediatek,mtu3";
+			reg = <0 0x11201000 0 0x2e00>,
+			      <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
+			phys = <&u2port0 PHY_TYPE_USB2>;
+			clocks = <&infracfg CLK_INFRA_UNIPRO_SCK>,
+				 <&infracfg CLK_INFRA_USB>;
+			clock-names = "sys_ck", "ref_ck";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			usb_host: xhci@11200000 {
+				compatible = "mediatek,mtk-xhci";
+				reg = <0 0x11200000 0 0x1000>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
+				clocks = <&infracfg CLK_INFRA_UNIPRO_SCK>,
+					 <&infracfg CLK_INFRA_USB>;
+				clock-names = "sys_ck", "ref_ck";
+				status = "disabled";
+			};
+		};
+
 		audiosys: syscon@11220000 {
 			compatible = "mediatek,mt8183-audiosys", "syscon";
 			reg = <0 0x11220000 0 0x1000>;
@@ -353,6 +381,30 @@
 			status = "disabled";
 		};
 
+		u3phy: usb-phy@11f40000 {
+			compatible = "mediatek,generic-tphy-v2";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "okay";
+
+			u2port0: usb-phy@11f40000 {
+				reg = <0 0x11f40000 0 0x700>;
+				clocks = <&clk26m>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+				status = "okay";
+			};
+
+			u3port0: usb-phy@11f40700 {
+				reg = <0 0x11f40700 0 0x900>;
+				clocks = <&clk26m>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+				status = "okay";
+			};
+		};
+
 		mfgcfg: syscon@13000000 {
 			compatible = "mediatek,mt8183-mfgcfg", "syscon";
 			reg = <0 0x13000000 0 0x1000>;
-- 
2.21.0

