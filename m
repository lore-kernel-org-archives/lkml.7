Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C31C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544462173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="KQ0BZ/ZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfKFKJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:09:57 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7290 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731327AbfKFKJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:09:56 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6A7AGF003297;
        Wed, 6 Nov 2019 11:09:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=jhrwb4GJ5N7MbgDVj22lmG3ajS2c9NSSIBuynieXO2c=;
 b=KQ0BZ/ZCvaCkJSt/+B0t7jshJafF1s9X0DDwNfbBE9xkusjVXNDJUAGf6FzRACmH9yPo
 ybTP0uMxB1352UKH6jC2yVUmjx1Y+wEQj7UrxMtX66MkqFNEhzlnYbvVe6/rn52c1OPX
 a6ZeYoZNjZOvFIED5tVMBAYmVdZeIs4tmq+GyrVDgZIko17VjnZ74pql//SHPyZEWke5
 FzmPbVg2Jsvr9HGZ/KH0CHSeeNCXNx/icrypZNiFSo+Ii/5umLmaTTQZNf6lfJjEJVFd
 8HDYMaYRJWkPEx0iPap69N7yfw/+OcBIYXdQ64uFmS5XS/1+74/Knq1P/dHkD7HcOQi8 qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w10f1mpux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 11:09:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B25D9100034;
        Wed,  6 Nov 2019 11:09:43 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A61C72AD337;
        Wed,  6 Nov 2019 11:09:43 +0100 (CET)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 6 Nov 2019
 11:09:43 +0100
Received: from localhost (10.48.1.131) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 6 Nov 2019 11:09:42 +0100
From:   Yann Gautier <yann.gautier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yann Gautier <yann.gautier@st.com>,
        "Ludovic Barre" <ludovic.barre@st.com>
Subject: [PATCH 2/4] ARM: dts: stm32: add sdmmc2 & 3 nodes for STM32MP157 SoC
Date:   Wed, 6 Nov 2019 11:09:36 +0100
Message-ID: <20191106100938.11368-3-yann.gautier@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106100938.11368-1-yann.gautier@st.com>
References: <20191106100938.11368-1-yann.gautier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.1.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32MP157 SoC series includes 3 instances of the SDMMC peripheral.
The sdmmc2 and sdmmc3 nodes are added in STM32MP157 SoC DT file.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Yann Gautier <yann.gautier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 33 +++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 9b11654a0a39..fa71aac0b0c5 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -1030,6 +1030,21 @@
 			};
 		};
 
+		sdmmc3: sdmmc@48004000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			arm,primecell-periphid = <0x10153180>;
+			reg = <0x48004000 0x400>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cmd_irq";
+			clocks = <&rcc SDMMC3_K>;
+			clock-names = "apb_pclk";
+			resets = <&rcc SDMMC3_R>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			max-frequency = <120000000>;
+			status = "disabled";
+		};
+
 		usbotg_hs: usb-otg@49000000 {
 			compatible = "snps,dwc2";
 			reg = <0x49000000 0x10000>;
@@ -1295,13 +1310,29 @@
 			arm,primecell-periphid = <0x10153180>;
 			reg = <0x58005000 0x1000>;
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names	= "cmd_irq";
+			interrupt-names = "cmd_irq";
 			clocks = <&rcc SDMMC1_K>;
 			clock-names = "apb_pclk";
 			resets = <&rcc SDMMC1_R>;
 			cap-sd-highspeed;
 			cap-mmc-highspeed;
 			max-frequency = <120000000>;
+			status = "disabled";
+		};
+
+		sdmmc2: sdmmc@58007000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			arm,primecell-periphid = <0x10153180>;
+			reg = <0x58007000 0x1000>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cmd_irq";
+			clocks = <&rcc SDMMC2_K>;
+			clock-names = "apb_pclk";
+			resets = <&rcc SDMMC2_R>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			max-frequency = <120000000>;
+			status = "disabled";
 		};
 
 		crc1: crc@58009000 {
-- 
2.17.1

