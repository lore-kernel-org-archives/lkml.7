Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C5FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0931A2158A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Ku0Tjv6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfK2SG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 13:06:26 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3528 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727009AbfK2SGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 13:06:23 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATI273l023387;
        Fri, 29 Nov 2019 19:06:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=CqTqqQisL0mVfRLeJ/Q6yUnUr6jBevycXIRNZu4CnYo=;
 b=Ku0Tjv6NuowssSIMuEa0R+OxoNmOPdAKQ/DAD0cEWcja4ORZ6myw+tFS1n0oPtVZhCZx
 Sda+Pfx6FcxYPWVQOKhshJlu9dhPG6u097Bm7B5GKMmc7+AuOcSCddB3N7t6JTj8mgpt
 jEmgiFTTqQfb1PKAYNbtaPIkodzVmMcr60qwbg2Dg7CxLZsCfI0qNaLZc18q0V5pUDYB
 q/cFqtGHRPntGyNh2NWLvtG2tAAWFTi78QswRhNUsgrkR6dikwqI8xe6/py2KYGpNT21
 nV7bq4SkqynTQ0Y31nZzzgCtzXtHuO5Z4H7L5Os7SUTEbnfGbGOkzpcn4sw7xVTY6EJ3 mA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2whcxjgr6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 19:06:07 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4AFD910002A;
        Fri, 29 Nov 2019 19:06:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3F5EE222D1F;
        Fri, 29 Nov 2019 19:06:07 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 29 Nov 2019 19:06:06
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/6] ARM: dts: stm32: Manage security diversity for STM32M15x SOCs
Date:   Fri, 29 Nov 2019 19:06:00 +0100
Message-ID: <20191129180602.28470-5-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191129180602.28470-1-alexandre.torgue@st.com>
References: <20191129180602.28470-1-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_06:2019-11-29,2019-11-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit creates a new file to manage security diversity on STM32MP15x
SOCs. On STM32MP15xY, "Y" gives information:
 -Y = A means no cryp IP and no secure boot.
 -Y = C means cryp IP + secure boot.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 9a0b55be134d..072fc7025987 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1255,15 +1255,6 @@
 			status = "disabled";
 		};
 
-		cryp1: cryp@54001000 {
-			compatible = "st,stm32mp1-cryp";
-			reg = <0x54001000 0x400>;
-			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc CRYP1>;
-			resets = <&rcc CRYP1_R>;
-			status = "disabled";
-		};
-
 		hash1: hash@54002000 {
 			compatible = "st,stm32f756-hash";
 			reg = <0x54002000 0x400>;
diff --git a/arch/arm/boot/dts/stm32mp15xc.dtsi b/arch/arm/boot/dts/stm32mp15xc.dtsi
new file mode 100644
index 000000000000..b06a55a2fa18
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp15xc.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@st.com> for STMicroelectronics.
+ */
+
+/ {
+	soc {
+		cryp1: cryp@54001000 {
+			compatible = "st,stm32mp1-cryp";
+			reg = <0x54001000 0x400>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc CRYP1>;
+			resets = <&rcc CRYP1_R>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.17.1

