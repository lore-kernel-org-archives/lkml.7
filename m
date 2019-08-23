Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F76C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0FC21726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392367AbfHWKH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:07:59 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37122 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392179AbfHWKH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:07:56 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AE322200712;
        Fri, 23 Aug 2019 12:07:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 14EA72006EC;
        Fri, 23 Aug 2019 12:07:50 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 19CF640319;
        Fri, 23 Aug 2019 18:07:44 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: [2/3] arm64: dts: lx2160a: add ftm_alarm0 DT node
Date:   Fri, 23 Aug 2019 17:57:39 +0800
Message-Id: <20190823095740.12280-2-biwen.li@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190823095740.12280-1-biwen.li@nxp.com>
References: <20190823095740.12280-1-biwen.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds ftm_alarm0 DT node for Soc LX2160A
FlexTimer1 module is used to wakeup the system in deep sleep

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 5c7d1e3704cb..39d497df769e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -15,6 +15,10 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		rtc1 = &ftm_alarm0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -769,6 +773,20 @@
 			timeout-sec = <30>;
 		};
 
+		rcpm: rcpm@1e34040 {
+			compatible = "fsl,lx2160a-rcpm", "fsl,qoriq-rcpm-2.1+";
+			reg = <0x0 0x1e34040 0x0 0x1c>;
+			#fsl,rcpm-wakeup-cells = <7>;
+			little-endian;
+		};
+
+		ftm_alarm0: timer@2800000 {
+			compatible = "fsl,lx2160a-ftm-alarm";
+			reg = <0x0 0x2800000 0x0 0x10000>;
+			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
+			interrupts = <0 44 4>;
+		};
+
 		usb0: usb@3100000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
-- 
2.17.1

