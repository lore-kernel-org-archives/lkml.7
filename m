Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D49C31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88DF206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391190AbfFJPXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:23:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43726 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390494AbfFJPXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:23:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 71E802007F9;
        Mon, 10 Jun 2019 17:23:41 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 64A762007F0;
        Mon, 10 Jun 2019 17:23:41 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 07A29205E4;
        Mon, 10 Jun 2019 17:23:40 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: ls1028a: add crypto node
Date:   Mon, 10 Jun 2019 18:23:31 +0300
Message-Id: <20190610152331.10057-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS1028A has a SEC v5.0 compatible security engine.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---

Tested with "arm-smmu.disable_bypass=0" kernel boot parameter,
since ICID (Isolation Context ID, out of which ARM SMMU stream ID
is derived) programming and DT fix-up support hasn't been added yet
in U-boot.

 .../boot/dts/freescale/fsl-ls1028a-qds.dts    |  1 +
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  1 +
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 39 +++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index 4ed18287e077..c9765bb4bd7f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -17,6 +17,7 @@
 	compatible = "fsl,ls1028a-qds", "fsl,ls1028a";
 
 	aliases {
+		crypto = &crypto;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 4a203f7da598..745ec462bfae 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -16,6 +16,7 @@
 	compatible = "fsl,ls1028a-rdb", "fsl,ls1028a";
 
 	aliases {
+		crypto = &crypto;
 		serial0 = &duart0;
 		serial1 = &duart1;
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index bb386dd1d1b1..0048c2610a09 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -388,6 +388,45 @@
 				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		crypto: crypto@8000000 {
+			compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
+			fsl,sec-era = <10>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x00 0x8000000 0x100000>;
+			reg = <0x00 0x8000000 0x0 0x100000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+
+			sec_jr0: jr@10000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	= <0x10000 0x10000>;
+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr1: jr@20000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	= <0x20000 0x10000>;
+				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr2: jr@30000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	= <0x30000 0x10000>;
+				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr3: jr@40000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	= <0x40000 0x10000>;
+				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		cluster1_core0_watchdog: watchdog@c000000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
-- 
2.17.1

