Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF5EC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4137B206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="A5sQdGUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfDYOK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:10:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41996 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbfDYOK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:10:58 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PE8JQh019874;
        Thu, 25 Apr 2019 16:10:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=dDpqPDbrPzmoYfdsmGFzWSflEmY+WQxZ5cj2P4ClC/I=;
 b=A5sQdGUIL/TN4XpkC60343er1H3XV0XO1XeKQ5s1MAlr1brUyzXxXfoHgKSoQlwHav80
 kFsicvV0lgS4ouDHqRgGY+Or7hZWCP+UFOVrEC2xkJXGjcCGzM9uBGrXMyX0fhNVtWRI
 LUnmmqumDyMSdVNJY9kmEmSSxKeKb4UD87Qvhs+JhTGdwXiY1bm0afWmX9Ky2cnDIvbi
 bKGToU3/8yb4GVrsYfzrNTstxj+r4PmGfNAPfIofITHBnl+hwqRhUGpdcp5h31TIRtBe
 zuIigXU0VdSMzRq9zQBHgQ2cGhvFsz1HwxF44NT1O04Fwgmof3dGkgbt29FvEnkHOmYC Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytaddg6h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 16:10:48 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B6A8B66;
        Thu, 25 Apr 2019 14:10:47 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9808627EA;
        Thu, 25 Apr 2019 14:10:47 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr
 2019 16:10:47 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr 2019 16:10:47
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [Linux-stm32][PATCH 3/4] ARM: dts: stm32: add i2s support on stm32mp157c
Date:   Thu, 25 Apr 2019 16:10:39 +0200
Message-ID: <1556201440-5540-4-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556201440-5540-1-git-send-email-olivier.moysan@st.com>
References: <1556201440-5540-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support of STM32 I2S on stm32mp157c.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 9ae40240f635..ec2d6475caa2 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -365,6 +365,17 @@
 			status = "disabled";
 		};
 
+		i2s2: audio-controller@4000b000 {
+			compatible = "st,stm32h7-i2s";
+			#sound-dai-cells = <0>;
+			reg = <0x4000b000 0x400>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dmamux1 39 0x400 0x01>,
+			       <&dmamux1 40 0x400 0x01>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		spi3: spi@4000c000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -379,6 +390,17 @@
 			status = "disabled";
 		};
 
+		i2s3: audio-controller@4000c000 {
+			compatible = "st,stm32h7-i2s";
+			#sound-dai-cells = <0>;
+			reg = <0x4000c000 0x400>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dmamux1 61 0x400 0x01>,
+			       <&dmamux1 62 0x400 0x01>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		spdifrx: audio-controller@4000d000 {
 			compatible = "st,stm32h7-spdifrx";
 			#sound-dai-cells = <0>;
@@ -607,6 +629,17 @@
 			status = "disabled";
 		};
 
+		i2s1: audio-controller@44004000 {
+			compatible = "st,stm32h7-i2s";
+			#sound-dai-cells = <0>;
+			reg = <0x44004000 0x400>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dmamux1 37 0x400 0x01>,
+			       <&dmamux1 38 0x400 0x01>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		spi4: spi@44005000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4

