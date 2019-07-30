Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17B5C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF67920665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfG3JQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:16:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36270 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfG3JQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:16:09 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A55320061B;
        Tue, 30 Jul 2019 11:16:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C242B20062A;
        Tue, 30 Jul 2019 11:16:03 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EEC0C402F3;
        Tue, 30 Jul 2019 17:15:58 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biwen Li <biwen.li@nxp.com>
Subject: [PATCH 1/3] arm64: dts: ls1028a: Add ftm_alarm0 DT node
Date:   Tue, 30 Jul 2019 17:06:32 +0800
Message-Id: <20190730090634.25070-1-biwen.li@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds ftm_alarm0 DT node for LS1028ARDB board
FlexTimer1 module is used to wakeup the system

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 7975519b4f56..3c66d1e1d196 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -17,6 +17,10 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		rtc1 = &ftm_alarm0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -543,6 +547,19 @@
 				little-endian;
 			};
 		};
+
+		rcpm: rcpm@1e34040 {
+			compatible = "fsl,ls1028a-rcpm", "fsl,qoriq-rcpm-2.1+";
+			reg = <0x0 0x1e34040 0x0 0x1c>;
+			#fsl,rcpm-wakeup-cells = <7>;
+		};
+
+		ftm_alarm0: timer@2800000 {
+			compatible = "fsl,ls1028a-ftm-alarm";
+			reg = <0x0 0x2800000 0x0 0x10000>;
+			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	malidp0: display@f080000 {
-- 
2.17.1

