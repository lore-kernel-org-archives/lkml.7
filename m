Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E79C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AF72176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="SU9FfFX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfLROtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:49:10 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46703 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbfLROtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:49:01 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIEmKDI016029;
        Wed, 18 Dec 2019 15:48:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=ZJaz6YDY6+PS/DfjYewnZZEfTHRT8KLeDP4ytvQdXsQ=;
 b=SU9FfFX9TZdCI5iEtTG3LeTmjpelldFlpZ9/bQZq8HG3AtEeoBcuiIDD5Tb03vuW3/tM
 nD9liWcBGwIBWENKjC77n0zbSipUoVO0S2YEoQwEzCRdQRNNhwBObS8ppJt4fdOF0+zu
 J4kO1MZ7l/HKczvI//huB3aZn0fB05CUUsrJI8fgrNiZxQFnk6ZpEYMLQnPnGdoF0iyD
 TI7DzfeKWoVGPGRLBJSQJYjPG+dvsdJzneuPDlqEPXwSFrxd7w+EfUY1ru10C/vZr4Kr
 7MxhPOZ9/Q/W2VAFE6cp8uJO8pdrs8SBHDoKH/Iy+Ji1QIrW0wcPJi2GNCvECJQ5uYQi JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvpd1mv26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 15:48:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D796100038;
        Wed, 18 Dec 2019 15:48:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 925AE207547;
        Wed, 18 Dec 2019 15:48:47 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 18 Dec 2019 15:48:47
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 2/3] ARM: dts: stm32: fix dma controller node name on stm32f743
Date:   Wed, 18 Dec 2019 15:48:43 +0100
Message-ID: <20191218144844.7481-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20191218144844.7481-1-benjamin.gaignard@st.com>
References: <20191218144844.7481-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify dma controller nodes name to fit with the standard naming.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index c065266ee377..05eb02e6d083 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -231,7 +231,7 @@
 			status = "disabled";
 		};
 
-		dma1: dma@40020000 {
+		dma1: dma-controller@40020000 {
 			compatible = "st,stm32-dma";
 			reg = <0x40020000 0x400>;
 			interrupts = <11>,
@@ -249,7 +249,7 @@
 			status = "disabled";
 		};
 
-		dma2: dma@40020400 {
+		dma2: dma-controller@40020400 {
 			compatible = "st,stm32-dma";
 			reg = <0x40020400 0x400>;
 			interrupts = <56>,
@@ -329,7 +329,7 @@
 			status = "disabled";
 		};
 
-		mdma1: dma@52000000 {
+		mdma1: dma-controller@52000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x52000000 0x1000>;
 			interrupts = <122>;
-- 
2.15.0

