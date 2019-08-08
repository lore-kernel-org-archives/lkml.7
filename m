Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32778C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDD4217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbfHHIsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:48:37 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60904 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731682AbfHHIsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:48:33 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D5FBC20018D;
        Thu,  8 Aug 2019 10:48:32 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C605B200154;
        Thu,  8 Aug 2019 10:48:29 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0DFBB402E6;
        Thu,  8 Aug 2019 16:48:25 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biwen Li <biwen.li@nxp.com>
Subject: [v3,3/3] arm: dts: ls1021a: add ftm_alarm0 DT node
Date:   Thu,  8 Aug 2019 16:38:39 +0800
Message-Id: <20190808083839.28594-3-biwen.li@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190808083839.28594-1-biwen.li@nxp.com>
References: <20190808083839.28594-1-biwen.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch add ftm_alarm0 DT node
	- add rcpm node
	- add ftm_alarm0 node
	- aliases ftm_alarm0 as rtc1

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v3:
	- None

Change in v2:
	- delete reg-name property
	- correct fsl,rcpm-wakeup property

 arch/arm/boot/dts/ls1021a.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 464df4290ffc..30bd6bc1f49a 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -66,6 +66,7 @@
 		serial4 = &lpuart4;
 		serial5 = &lpuart5;
 		sysclk = &sysclk;
+		rtc1 = &ftm_alarm0;
 	};
 
 	cpus {
@@ -985,5 +986,18 @@
 			big-endian;
 		};
 
+		rcpm: rcpm@1ee2140 {
+			compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
+			reg = <0x0 0x1ee2140 0x0 0x8>;
+			#fsl,rcpm-wakeup-cells = <2>;
+		};
+
+		ftm_alarm0: timer0@29d0000 {
+			compatible = "fsl,ls1021a-ftm-alarm";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			fsl,rcpm-wakeup = <&rcpm 0x0 0x20000000>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
+		};
 	};
 };
-- 
2.17.1

