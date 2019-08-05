Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1575C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF0820856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfHEKYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:24:02 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54060 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbfHEKYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:24:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D2D11A00F6;
        Mon,  5 Aug 2019 12:23:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7250E1A00F5;
        Mon,  5 Aug 2019 12:23:52 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1B366402B5;
        Mon,  5 Aug 2019 18:23:44 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        yangbo.lu@nxp.com, Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: [PATCH v4] arm64: dts: ls1028a: Add esdhc node in dts
Date:   Mon,  5 Aug 2019 18:26:41 +0800
Message-Id: <20190805102641.3732-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Kumar <Ashish.Kumar@nxp.com>

This patch is to add esdhc node and enable SD UHS-I,
eMMC HS200 for ls1028ardb/ls1028aqds board.

Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v4:
		put esdhc 'status' at end of property list.
		sort the nodes in unit-address
		Use IRQ_TYPE_LEVEL_HIGH represent 0x4 in "interrupts = <0 28 0x4>"

 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |  8 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 13 +++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 27 +++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index de6ef39..5e14e5a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -95,6 +95,14 @@
 	status = "okay";
 };
 
+&esdhc {
+	status = "okay";
+};
+
+&esdhc1 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 9fb9113..12c9cd3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -83,6 +83,19 @@
 	};
 };
 
+&esdhc {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+	status = "okay";
+	};
+
+&esdhc1 {
+	mmc-hs200-1_8v;
+	status = "okay";
+	};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 7975519..f299075 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -245,6 +245,33 @@
 			status = "disabled";
 		};
 
+		esdhc: mmc@2140000 {
+			compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
+			reg = <0x0 0x2140000 0x0 0x10000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <0>; /* fixed up by bootloader */
+			clocks = <&clockgen 2 1>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			little-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		esdhc1: mmc@2150000 {
+			compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
+			reg = <0x0 0x2150000 0x0 0x10000>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <0>; /* fixed up by bootloader */
+			clocks = <&clockgen 2 1>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			broken-cd;
+			little-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		duart0: serial@21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0500 0x0 0x100>;
-- 
2.9.5

