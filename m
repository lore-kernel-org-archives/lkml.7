Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BFDC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B5E2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="YCSngOhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfDYOLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:11:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59520 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfDYOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:11:17 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PE8M6I005046;
        Thu, 25 Apr 2019 16:11:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=sYb61MXK9YcNgLWzbWly1c2g4rk/LVY8fN1Msh9FUEM=;
 b=YCSngOhZlXi6CTAMQ61T1yK+i9aKcQnivGVLvA+5LbfGYEtSPipHxigCHvxvhp8o7Gau
 qVBt1DDWQkS8B1ClD899kLp3Y2zDQm5ZGdomQHwDArO1lRljbeo8Rki8uplUhP1cj7C4
 b2O+lz2ObgM+A0asSzX3tq7ZYJ1fyPUoIPK2TROUurhZgVyGuP8fgPNWtF7yAQ9ARkwb
 g7ROkT0We6mT6QLmik+Iyp56Ql1pqbh13IVbgjbLGVZjaZyoreN9aNPhxxikxyM+lva2
 UoKzLPFo4zuTaKd1o0oidtLAWb3wF0HbLFwXXTnMKwTlrJaiE/gBkHz8wAk6lW/9IDuG Ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxm5h6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 16:11:01 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8670C58;
        Thu, 25 Apr 2019 14:10:45 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 701DE27E9;
        Thu, 25 Apr 2019 14:10:45 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 25 Apr
 2019 16:10:45 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr 2019 16:10:44
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [Linux-stm32][PATCH 1/4] ARM: dts: stm32: add sai support on stm32mp157c
Date:   Thu, 25 Apr 2019 16:10:37 +0200
Message-ID: <1556201440-5540-2-git-send-email-olivier.moysan@st.com>
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

This patch adds support of STM32 SAI on stm32mp157c.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 125 +++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 2afeee65c3ea..9ae40240f635 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -708,6 +708,100 @@
 			status = "disabled";
 		};
 
+		sai1: sai@4400a000 {
+			compatible = "st,stm32h7-sai";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4400a000 0x400>;
+			reg = <0x4400a000 0x4>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rcc SAI1_R>;
+			status = "disabled";
+
+			sai1a: audio-controller@4400a004 {
+				#sound-dai-cells = <0>;
+
+				compatible = "st,stm32-sai-sub-a";
+				reg = <0x4 0x1c>;
+				clocks = <&rcc SAI1_K>;
+				clock-names = "sai_ck";
+				dmas = <&dmamux1 87 0x400 0x01>;
+				status = "disabled";
+			};
+
+			sai1b: audio-controller@4400a024 {
+				#sound-dai-cells = <0>;
+				compatible = "st,stm32-sai-sub-b";
+				reg = <0x24 0x1c>;
+				clocks = <&rcc SAI1_K>;
+				clock-names = "sai_ck";
+				dmas = <&dmamux1 88 0x400 0x01>;
+				status = "disabled";
+			};
+		};
+
+		sai2: sai@4400b000 {
+			compatible = "st,stm32h7-sai";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4400b000 0x400>;
+			reg = <0x4400b000 0x4>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rcc SAI2_R>;
+			status = "disabled";
+
+			sai2a: audio-controller@4400b004 {
+				#sound-dai-cells = <0>;
+				compatible = "st,stm32-sai-sub-a";
+				reg = <0x4 0x1c>;
+				clocks = <&rcc SAI2_K>;
+				clock-names = "sai_ck";
+				dmas = <&dmamux1 89 0x400 0x01>;
+				status = "disabled";
+			};
+
+			sai2b: audio-controller@4400b024 {
+				#sound-dai-cells = <0>;
+				compatible = "st,stm32-sai-sub-b";
+				reg = <0x24 0x1c>;
+				clocks = <&rcc SAI2_K>;
+				clock-names = "sai_ck";
+				dmas = <&dmamux1 90 0x400 0x01>;
+				status = "disabled";
+			};
+		};
+
+		sai3: sai@4400c000 {
+			compatible = "st,stm32h7-sai";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4400c000 0x400>;
+			reg = <0x4400c000 0x4>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rcc SAI3_R>;
+			status = "disabled";
+
+			sai3a: audio-controller@4400c004 {
+				#sound-dai-cells = <0>;
+				compatible = "st,stm32-sai-sub-a";
+				reg = <0x04 0x1c>;
+				clocks = <&rcc SAI3_K>;
+				clock-names = "sai_ck";
+				dmas = <&dmamux1 113 0x400 0x01>;
+				status = "disabled";
+			};
+
+			sai3b: audio-controller@4400c024 {
+				#sound-dai-cells = <0>;
+				compatible = "st,stm32-sai-sub-b";
+				reg = <0x24 0x1c>;
+				clocks = <&rcc SAI3_K>;
+				clock-names = "sai_ck";
+				dmas = <&dmamux1 114 0x400 0x01>;
+				status = "disabled";
+			};
+		};
+
 		dfsdm: dfsdm@4400d000 {
 			compatible = "st,stm32mp1-dfsdm";
 			reg = <0x4400d000 0x800>;
@@ -1020,6 +1114,37 @@
 			status = "disabled";
 		};
 
+		sai4: sai@50027000 {
+			compatible = "st,stm32h7-sai";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x50027000 0x400>;
+			reg = <0x50027000 0x4>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rcc SAI4_R>;
+			status = "disabled";
+
+			sai4a: audio-controller@50027004 {
+				#sound-dai-cells = <0>;
+				compatible = "st,stm32-sai-sub-a";
+				reg = <0x04 0x1c>;
+				clocks = <&rcc SAI4_K>;
+				clock-names = "sai_ck";
+				dmas = <&dmamux1 99 0x400 0x01>;
+				status = "disabled";
+			};
+
+			sai4b: audio-controller@50027024 {
+				#sound-dai-cells = <0>;
+				compatible = "st,stm32-sai-sub-b";
+				reg = <0x24 0x1c>;
+				clocks = <&rcc SAI4_K>;
+				clock-names = "sai_ck";
+				dmas = <&dmamux1 100 0x400 0x01>;
+				status = "disabled";
+			};
+		};
+
 		dts: thermal@50028000 {
 			compatible = "st,stm32-thermal";
 			reg = <0x50028000 0x100>;
-- 
2.7.4

