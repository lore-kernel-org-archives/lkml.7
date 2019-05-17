Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DABC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 05:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921CE2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 05:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfEQFOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 01:14:42 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33026 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfEQFOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 01:14:42 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EA1A91A000F;
        Fri, 17 May 2019 07:14:39 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 954871A01E6;
        Fri, 17 May 2019 07:14:36 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1D482402AE;
        Fri, 17 May 2019 13:14:32 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v4] arm64: dts: ls1028a: Add USB dt nodes
Date:   Fri, 17 May 2019 13:16:24 +0800
Message-Id: <20190517051624.4930-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds USB dt nodes for LS1028A.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v4:
  - Move nodes to follow rule of unit-address in the address.
  - Use macro to replace 'interrupts' values.

Changes in v3:
  - Add space between label and node name.
  - Add spcae with properties and '='.
  - Add SoC specific compatible.

Changes in v2:
  - Rename node from usb3@... to usb@... to meet DTSpec

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 8dd3501..e4ed17f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -294,6 +294,26 @@
 			status = "disabled";
 		};
 
+		usb0: usb@3100000 {
+			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+			reg = <0x0 0x3100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			snps,dis_rxdet_inp3_quirk;
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+		};
+
+		usb1: usb@3110000 {
+			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+			reg = <0x0 0x3110000 0x0 0x10000>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			snps,dis_rxdet_inp3_quirk;
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+		};
+
 		sata: sata@3200000 {
 			compatible = "fsl,ls1028a-ahci";
 			reg = <0x0 0x3200000 0x0 0x10000>,
-- 
1.7.1

