Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C027EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C31F20863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfIIJBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:01:06 -0400
Received: from inva020.nxp.com ([92.121.34.13]:32804 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfIIJBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:01:05 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DC9E31A026E;
        Mon,  9 Sep 2019 11:01:03 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E22451A000C;
        Mon,  9 Sep 2019 11:00:58 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 82D10402CF;
        Mon,  9 Sep 2019 17:00:52 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v1] usb: dwc3: enable otg mode for dwc3 usb ip on layerscape
Date:   Mon,  9 Sep 2019 17:02:44 +0800
Message-Id: <20190909090244.42543-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

layerscape otg function should be supported HNP SRP and ADP protocol
accroing to rm doc, but dwc3 code not realize it and use id pin to
detect who is host or device(0 is host 1 is device) this patch is to
enable OTG mode on ls1028ardb ls1088ardb and ls1046ardb in dts

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 7975519b4f56..5810d0400dbc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -320,7 +320,7 @@
 			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
-			dr_mode = "host";
+			dr_mode = "otg";
 			snps,dis_rxdet_inp3_quirk;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index b0ef08b090dd..ecce6151b9b0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -582,7 +582,7 @@
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3000000 0x0 0x10000>;
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-			dr_mode = "host";
+			dr_mode = "otg";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index dacd8cf03a7f..4b5413f7c90c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -385,7 +385,7 @@
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
-			dr_mode = "host";
+			dr_mode = "otg";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			status = "disabled";
-- 
2.17.1

