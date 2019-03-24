Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF600C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 07:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8FF2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 07:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfCXHlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 03:41:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31111 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728237AbfCXHlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 03:41:36 -0400
X-UUID: 9890f421fcbe4b4580a62dc84bb114f7-20190324
X-UUID: 9890f421fcbe4b4580a62dc84bb114f7-20190324
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1543023755; Sun, 24 Mar 2019 15:41:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 24 Mar 2019 15:41:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 24 Mar 2019 15:41:21 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <weiyi.lu@mediatek.com>,
        <yong.wu@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: Add m4u and smi-larbs nodes for mt8183
Date:   Sun, 24 Mar 2019 15:41:15 +0800
Message-ID: <1553413275-10724-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for M4U, smi-common, and smi-larbs.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
This one is based on MTK IOMMU v6[1] and basical nodes of clocks and powers.

[1] https://patchwork.kernel.org/patch/10816827/
[2] https://patchwork.kernel.org/patch/10858941/
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 85 ++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 75c4881..1138da2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/memory/mt8183-larb-port.h>
 #include <dt-bindings/power/mt8183-power.h>
 
 / {
@@ -269,6 +270,15 @@
 			clock-names = "spi", "wrap";
 		};
 
+		iommu: iommu@10205000 {
+			compatible = "mediatek,mt8183-m4u";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,larbs = <&larb0 &larb1 &larb2 &larb3
+					  &larb4 &larb5 &larb6>;
+			#iommu-cells = <1>;
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt8183-uart",
 				     "mediatek,mt6577-uart";
@@ -317,9 +327,25 @@
 			#clock-cells = <1>;
 		};
 
+		larb0: larb@14017000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x14017000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_SMI_LARB0>,
+				 <&mmsys CLK_MM_SMI_LARB0>;
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
+			clock-names = "apb", "smi";
+		};
+
 		smi_common: smi@14019000 {
 			compatible = "mediatek,mt8183-smi-common", "syscon";
 			reg = <0 0x14019000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_GALS_COMM0>,
+				 <&mmsys CLK_MM_GALS_COMM1>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
 		};
 
 		imgsys: syscon@15020000 {
@@ -328,18 +354,57 @@
 			#clock-cells = <1>;
 		};
 
+		larb5: larb@15021000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x15021000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&imgsys CLK_IMG_LARB5>, <&imgsys CLK_IMG_LARB5>,
+				 <&mmsys CLK_MM_GALS_IMG2MM>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_ISP>;
+		};
+
+		larb2: larb@1502f000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x1502f000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&imgsys CLK_IMG_LARB2>, <&imgsys CLK_IMG_LARB2>,
+				 <&mmsys CLK_MM_GALS_IPU2MM>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_ISP>;
+		};
+
 		vdecsys: syscon@16000000 {
 			compatible = "mediatek,mt8183-vdecsys", "syscon";
 			reg = <0 0x16000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb1: larb@16010000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x16010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vdecsys CLK_VDEC_VDEC>, <&vdecsys CLK_VDEC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_VDEC>;
+		};
+
 		vencsys: syscon@17000000 {
 			compatible = "mediatek,mt8183-vencsys", "syscon";
 			reg = <0 0x17000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb4: larb@17010000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x17010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vencsys CLK_VENC_LARB>,
+				 <&vencsys CLK_VENC_LARB>;
+			clock-names = "apb", "smi";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_VENC>;
+		};
+
 		ipu_conn: syscon@19000000 {
 			compatible = "mediatek,mt8183-ipu_conn", "syscon";
 			reg = <0 0x19000000 0 0x1000>;
@@ -369,5 +434,25 @@
 			reg = <0 0x1a000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		larb6: larb@1a001000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x1a001000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&camsys CLK_CAM_LARB6>, <&camsys CLK_CAM_LARB6>,
+				 <&mmsys CLK_MM_GALS_CAM2MM>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_CAM>;
+		};
+
+		larb3: larb@1a002000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x1a002000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&camsys CLK_CAM_LARB3>, <&camsys CLK_CAM_LARB3>,
+				 <&mmsys CLK_MM_GALS_IPU12MM>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_CAM>;
+		};
 	};
 };
-- 
1.9.1

