Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8401FC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606162082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfEFJLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:11:38 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39348 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfEFJLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:11:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8796620000F;
        Mon,  6 May 2019 11:11:34 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C344200169;
        Mon,  6 May 2019 11:11:29 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 45C64402A6;
        Mon,  6 May 2019 17:11:23 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Ma <peng.ma@nxp.com>
Subject: [PATCH 2/4] arm64: dts: fsl: ls1028a: Add eDMA node
Date:   Mon,  6 May 2019 09:03:42 +0000
Message-Id: <20190506090344.37784-2-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190506090344.37784-1-peng.ma@nxp.com>
References: <20190506090344.37784-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the eDMA device tree nodes for LS1028A devices

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 8116fb3..71b87cb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -235,6 +235,21 @@
 			status = "disabled";
 		};
 
+		edma0: edma@22c0000 {
+			#dma-cells = <2>;
+			compatible = "fsl,vf610-edma";
+			reg = <0x0 0x22c0000 0x0 0x10000>,
+			      <0x0 0x22d0000 0x0 0x10000>,
+			      <0x0 0x22e0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma-tx", "edma-err";
+			dma-channels = <32>;
+			clock-names = "dmamux0", "dmamux1";
+			clocks = <&clockgen 4 1>,
+				 <&clockgen 4 1>;
+		};
+
 		gpio1: gpio@2300000 {
 			compatible = "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-- 
1.7.1

