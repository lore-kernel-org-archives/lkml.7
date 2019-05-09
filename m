Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D178C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD0C21773
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEIHFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 03:05:12 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50476 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfEIHFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 03:05:12 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 85F3B200136;
        Thu,  9 May 2019 09:05:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C7F8C2000FC;
        Thu,  9 May 2019 09:05:06 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BFA68402F2;
        Thu,  9 May 2019 15:04:59 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuanhua Han <chuanhua.han@nxp.com>,
        Zhang Ying-22455 <ying.zhang22455@nxp.com>
Subject: [PATCH] arm64: dts: ls1028a: fix watchdog device node
Date:   Thu,  9 May 2019 15:06:57 +0800
Message-Id: <20190509070657.18281-1-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ls1028a platform uses sp805 watchdog, and use 1/16 platform clock as
timer clock, this patch fix device tree node.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index b04581249f0b..1510b1858246 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -285,13 +285,18 @@
 			#interrupt-cells = <2>;
 		};
 
-		wdog0: watchdog@23c0000 {
-			compatible = "fsl,ls1028a-wdt", "fsl,imx21-wdt";
-			reg = <0x0 0x23c0000 0x0 0x10000>;
-			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
-			big-endian;
-			status = "disabled";
+		cluster1_core0_watchdog: wdt@c000000 {
+			compatible = "arm,sp805", "arm,primecell";
+			reg = <0x0 0xc000000 0x0 0x1000>;
+			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
+			clock-names = "apb_pclk", "wdog_clk";
+		};
+
+		cluster1_core1_watchdog: wdt@c010000 {
+			compatible = "arm,sp805", "arm,primecell";
+			reg = <0x0 0xc010000 0x0 0x1000>;
+			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
+			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		sata: sata@3200000 {
-- 
2.17.1

