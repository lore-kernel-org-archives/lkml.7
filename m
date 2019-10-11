Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657EDECE596
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE08214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ma4zfIu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfJKOFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:05:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12310 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728111AbfJKOFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:05:19 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BE2svF011220;
        Fri, 11 Oct 2019 16:05:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=sJG8MaYnwfDRxmyqoTNYkAIqphDRMJYtb+/EZI6/TlQ=;
 b=ma4zfIu/TY1NvwjA55v4vUCZ1gwW9nqMc1odc63KfAWPWtY8zvrj0TJSuAUmy98qskFm
 2ihg9Kz1nnUZGqN1SmDO/qhlnTNOvnRAeQzxswifAJtazf/c/cy4p8/3d/Tf6KIFcGhe
 gIwLoHN4An6FLlfvDQ+rQzqlutwTnODiDW/KMTUegWpD6ebmch+Og4IQvWScn6/em4XJ
 6KUEcbDpICECBFIlSVdVLqTsu0MmaWlf52jKWjYIe+y1NrV44lQx4UlAewHklf34HW7/
 gaPhjhj/f4x2fGa7LpbPzzF1E7/TAFVX12L/ARvsNZ844Vo7mX2fjgGdcrm5X8NBFwaa RQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vegahk216-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 16:05:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9FACE10002A;
        Fri, 11 Oct 2019 16:05:08 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9433222251F;
        Fri, 11 Oct 2019 16:05:08 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 11 Oct 2019 16:05:07
 +0200
From:   Pascal Paillet <p.paillet@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <p.paillet@st.com>
Subject: [PATCH 3/4] ARM: dts: stm32: Fix active discharge usage on stm32mp157
Date:   Fri, 11 Oct 2019 16:04:44 +0200
Message-ID: <20191011140445.32288-4-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011140445.32288-1-p.paillet@st.com>
References: <20191011140445.32288-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_08:2019-10-10,2019-10-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Active discharge is a uint32 not a boolean.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 arch/arm/boot/dts/stm32mp157a-avenger96.dts | 4 ++--
 arch/arm/boot/dts/stm32mp157a-dk1.dts       | 2 +-
 arch/arm/boot/dts/stm32mp157c-ed1.dts       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157a-avenger96.dts b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
index 5f35b0146017..d1cc42a92d3f 100644
--- a/arch/arm/boot/dts/stm32mp157a-avenger96.dts
+++ b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
@@ -252,14 +252,14 @@
 				regulator-name = "vbus_otg";
 				interrupts = <IT_OCP_OTG 0>;
 				interrupt-parent = <&pmic>;
-				regulator-active-discharge;
+				regulator-active-discharge = <1>;
 			};
 
 			vbus_sw: pwr_sw2 {
 				regulator-name = "vbus_sw";
 				interrupts = <IT_OCP_SWOUT 0>;
 				interrupt-parent = <&pmic>;
-				regulator-active-discharge;
+				regulator-active-discharge = <1>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index efeefb3d25b0..0e80f8da28d4 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -351,7 +351,7 @@
 			 vbus_sw: pwr_sw2 {
 				regulator-name = "vbus_sw";
 				interrupts = <IT_OCP_SWOUT 0>;
-				regulator-active-discharge;
+				regulator-active-discharge = <1>;
 			 };
 		};
 
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 15afa8f1a36f..108612b523de 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -225,7 +225,7 @@
 			 vbus_sw: pwr_sw2 {
 				regulator-name = "vbus_sw";
 				interrupts = <IT_OCP_SWOUT 0>;
-				regulator-active-discharge;
+				regulator-active-discharge = <1>;
 			 };
 		};
 
-- 
2.17.1

