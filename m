Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841DCC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E46217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="iU7lx468"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfKTOl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:41:28 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59325 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728407AbfKTOl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:41:27 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKEcCTV026254;
        Wed, 20 Nov 2019 15:41:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=CqTqqQisL0mVfRLeJ/Q6yUnUr6jBevycXIRNZu4CnYo=;
 b=iU7lx468m/bCnR+8OKR5BO86s7Th4b7LjdY7mOtNVl0IhinVpFrQAPbIPi0u5ofGzxD1
 UF8yk15V9LQ1yQbZuz9ffqG6SuHKWbvDTb0t1UmUd5fHZXf0Cpg5JC55Mgqor2RKlLxJ
 a0xTWnkYzBfuxAhsWbwPCiw+nsyXO/KmcuK7T7B0dQn18X+rryJM8GBHuOpReiS3CXHI
 sR1sLthUrRYAwyFGSzII3W2SXX/l14BnW+JxK3so8zmdF1+BbApZFENV0UnUlqYcpnjL
 RZHa/MjcUWHXlzva6G+OZbMPMyfLAuXNHyK5V9ZmW0B3b9UuRh75IJOXSea5TlAkfW93 Mg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wa9use7vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Nov 2019 15:41:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 47F89100038;
        Wed, 20 Nov 2019 15:41:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3BAA32BE24C;
        Wed, 20 Nov 2019 15:41:14 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Nov 2019 15:41:13
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
Subject: [PATCH 4/6] ARM: dts: stm32: Manage security diversity for STM32M15x SOCs
Date:   Wed, 20 Nov 2019 15:41:07 +0100
Message-ID: <20191120144109.25321-5-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120144109.25321-1-alexandre.torgue@st.com>
References: <20191120144109.25321-1-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_04:2019-11-15,2019-11-20 signatures=0
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

