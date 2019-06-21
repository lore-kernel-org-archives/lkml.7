Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91A8C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C277C208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="CZYcXET/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfFUOvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:51:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29904 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726402AbfFUOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:51:01 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LEag9T027335;
        Fri, 21 Jun 2019 16:50:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=ZZpvRfgXUheBHfuAk2fJFbyjGOPB1yCbsnahTGNt+E8=;
 b=CZYcXET/fKOXQ/igv3GuZrPwANSoLrSM4aXr/Toe1J/RrsWodBqs1BelovZQ4o3IARt8
 dK7krBSNZmkd72wIy+I2rIOSTfe/M7jRbYwSSNr/IVxHDJdsgSCO6vtZEe1pNbu79+Q7
 ZJDeBwXJ9+D64PW1UjzWPUOU830hXC7VG8Uwt+TYarAqCUhDnGVgd1YggEI36tZLhAo3
 Rxcq4iMcXsHXxKGlWNDR9S78kDiuPDMjl84IRaHtr2p/XVLJL/bGp0cz3AAMUWIk0bUa
 nWrhnTq7HptxZ8XLflvm55GeZAY2nZRu12Hz/d/AzZbWRmZ8HEdQNaYhXZgfyBgL5Men +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t781v81ue-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Jun 2019 16:50:45 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2144C34;
        Fri, 21 Jun 2019 14:50:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0226B2BDE;
        Fri, 21 Jun 2019 14:50:45 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 21 Jun 2019 16:50:44
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <linux@armlinux.org.uk>,
        <olof@lixom.net>, <arnd@arndb.de>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH 1/4] ARM: dts: stm32: add FMC2 NAND controller support on stm32mp157c
Date:   Fri, 21 Jun 2019 16:49:47 +0200
Message-ID: <1561128590-14621-2-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561128590-14621-1-git-send-email-christophe.kerello@st.com>
References: <1561128590-14621-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FMC2 NAND controller support used by stm32mp157c SOC.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 0c4e6eb..f2bda28 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -1239,6 +1239,25 @@
 			dma-requests = <48>;
 		};
 
+		fmc: nand-controller@58002000 {
+			compatible = "st,stm32mp15-fmc2";
+			reg = <0x58002000 0x1000>,
+			      <0x80000000 0x1000>,
+			      <0x88010000 0x1000>,
+			      <0x88020000 0x1000>,
+			      <0x81000000 0x1000>,
+			      <0x89010000 0x1000>,
+			      <0x89020000 0x1000>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&mdma1 20 0x10 0x12000A02 0x0 0x0>,
+			       <&mdma1 20 0x10 0x12000A08 0x0 0x0>,
+			       <&mdma1 21 0x10 0x12000A0A 0x0 0x0>;
+			dma-names = "tx", "rx", "ecc";
+			clocks = <&rcc FMC_K>;
+			resets = <&rcc FMC_R>;
+			status = "disabled";
+		};
+
 		qspi: spi@58003000 {
 			compatible = "st,stm32f469-qspi";
 			reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
-- 
1.9.1

