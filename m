Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C14C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F7A20872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389382AbfIJMVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:21:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53454 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388902AbfIJMVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:21:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 93FAD200090;
        Tue, 10 Sep 2019 14:21:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 521212004BF;
        Tue, 10 Sep 2019 14:21:04 +0200 (CEST)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1F134402A5;
        Tue, 10 Sep 2019 20:20:59 +0800 (SGT)
From:   Ashish Kumar <Ashish.Kumar@nxp.com>
To:     devicetree@vger.kernel.org, robh@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH] arm64: dts: ls1028a: Add FlexSPI support for NXP LS1028
Date:   Tue, 10 Sep 2019 17:50:51 +0530
Message-Id: <1568118055-9740-1-git-send-email-Ashish.Kumar@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fspi node property for LS1028A SoC for FlexSPI driver.
Property added for FlexSPI controller and for the connected
slave device for the LS1028ARDB and LS1028AQDS target.
RDB and QDS is having one SPI-NOR flash device, mt35xu02g
connected at CS0.
This flash device "mt35xu02g" is tested for octal read

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 15 +++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 15 +++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 13 +++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index 5e14e5a..5d46993 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -103,6 +103,21 @@
 	status = "okay";
 };
 
+&fspi {
+	status = "okay";
+	flash0: mt35xu02g@0 {
+		compatible = "micron,mt35xu02g", "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+		/* The following setting enables 1-1-8 (CMD-ADDR-DATA) mode */
+		spi-rx-bus-width = <8>; /* 8 SPI Rx lines */
+		spi-tx-bus-width = <1>; /* 1 SPI Tx line */
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 1a69221..f33cb2e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -96,6 +96,21 @@
 	status = "okay";
 };
 
+&fspi {
+	status = "okay";
+	flash0: mt35xu02g@0 {
+		compatible = "micron,mt35xu02g", "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+		/* The following setting enables 1-1-8 (CMD-ADDR-DATA) mode */
+		spi-rx-bus-width = <8>; /* 8 SPI Rx lines */
+		spi-tx-bus-width = <1>; /* 1 SPI Tx line */
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index b139b29..4aa1825 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -174,6 +174,19 @@
 			clocks = <&sysclk>;
 		};
 
+		fspi: spi@20c0000 {
+			compatible = "nxp,lx2160a-fspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x20c0000 0x0 0x10000>,
+			      <0x0 0x20000000 0x0 0x10000000>;
+			reg-names = "fspi_base", "fspi_mmap";
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "fspi_en", "fspi";
+			status = "disabled";
+		};
+
 		i2c0: i2c@2000000 {
 			compatible = "fsl,vf610-i2c";
 			#address-cells = <1>;
-- 
2.7.4

