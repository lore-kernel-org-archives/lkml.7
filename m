Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C242C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E52E2070C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437827AbfITIpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:45:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40858 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404774AbfITIpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:45:31 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D764200479;
        Fri, 20 Sep 2019 10:45:29 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DCFBF20007B;
        Fri, 20 Sep 2019 10:45:24 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6B24C40309;
        Fri, 20 Sep 2019 16:45:19 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-devel@linux.nxdi.nxp.com, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Wen He <wen.he_1@nxp.com>
Subject: [v2 1/2] arm64: dts: ls1028a: Update the clock providers for the Mali DP500
Date:   Fri, 20 Sep 2019 16:34:18 +0800
Message-Id: <20190920083419.5092-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to maximise performance of the LCD Controller's 64-bit AXI
bus, for any give speed bin of the device, the AXI master interface
clock(ACLK) clock can be up to CPU_frequency/2, which is already
capable of optimal performance. In general, ACLK is always expected
to be equal to CPU_frequency/2. APB slave interface clock(PCLK) and
Main processing clock(PCLK) both are tied to the same clock as ACLK.

This change followed the LS1028A Architecture Specification Manual.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
change in v2:
        - add details commit description for this change. 
        - v1: Link: https://lore.kernel.org/patchwork/patch/1119145/

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 72b9a75976a1..51fa8f57fdac 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -86,20 +86,6 @@
 		clocks = <&osc_27m>;
 	};
 
-	aclk: clock-axi {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <650000000>;
-		clock-output-names= "aclk";
-	};
-
-	pclk: clock-apb {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <650000000>;
-		clock-output-names= "pclk";
-	};
-
 	reboot {
 		compatible ="syscon-reboot";
 		regmap = <&dcfg>;
@@ -679,7 +665,8 @@
 		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 223 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "DE", "SE";
-		clocks = <&dpclk 0>, <&aclk>, <&aclk>, <&pclk>;
+		clocks = <&dpclk 0>, <&clockgen 2 2>, <&clockgen 2 2>,
+			 <&clockgen 2 2>;
 		clock-names = "pxlclk", "mclk", "aclk", "pclk";
 		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
 		arm,malidp-arqos-value = <0xd000d000>;
-- 
2.17.1

