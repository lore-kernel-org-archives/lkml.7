Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B3AC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435532178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="FzlOCB2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfKFJL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:11:56 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11864 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731661AbfKFJLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:11:55 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA697TEA001166;
        Wed, 6 Nov 2019 10:11:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=6dLCtaMBamBNYfBTbNBOvLe+o/LoagmMWJ8a+g2XQw4=;
 b=FzlOCB2NYCcVU+LUdHmYruc8DzkiME7mRQdw6zTBwgBS+EvQV9GWETXAtQJNnRsKUQdB
 D5YAoyCis3E8NJ5063mK+myP3PGJFqy88Pd4MxfcnWiffIZ8I/whnKU6x4ymyB9chnpT
 VNJk6M+LA+FEWCjZCtCRZXdy+/PduNaXWaY1OCSB4LuGXzHTG6G/YQXDIhOyeFE/XOzv
 uoKfknBRwoWF/JXXEah/L0gvWMOy2UeSepCvFLvyCSgESYMgBumOJ6ytlAI3lGBPtptb
 SUCuHOT1MGa+c/gI/l8t7DQ48wvdERQgvwG0IQc7fQiYKe5roPEoAuPR6uxuEl7be+c5 AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w1054vf0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 10:11:37 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 251C8100039;
        Wed,  6 Nov 2019 10:11:33 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0CAFE2AB0E3;
        Wed,  6 Nov 2019 10:11:33 +0100 (CET)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 6 Nov 2019
 10:11:32 +0100
Received: from localhost (10.48.0.192) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 6 Nov 2019 10:11:31 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH] ARM: dts: stm32: add timers counter support on stm32mp157c
Date:   Wed, 6 Nov 2019 10:11:24 +0100
Message-ID: <1573031484-18701-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-05,2019-11-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add counter support on stm32mp157c that provides quadrature encoder on
timers 1, 2, 3, 4, 5 and 8.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index e0f3d4c6..a4ca23c 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -148,6 +148,11 @@
 				reg = <1>;
 				status = "disabled";
 			};
+
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
 		};
 
 		timers3: timer@40001000 {
@@ -177,6 +182,11 @@
 				reg = <2>;
 				status = "disabled";
 			};
+
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
 		};
 
 		timers4: timer@40002000 {
@@ -204,6 +214,11 @@
 				reg = <3>;
 				status = "disabled";
 			};
+
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
 		};
 
 		timers5: timer@40003000 {
@@ -233,6 +248,11 @@
 				reg = <4>;
 				status = "disabled";
 			};
+
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
 		};
 
 		timers6: timer@40004000 {
@@ -589,6 +609,11 @@
 				reg = <0>;
 				status = "disabled";
 			};
+
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
 		};
 
 		timers8: timer@44001000 {
@@ -620,6 +645,11 @@
 				reg = <7>;
 				status = "disabled";
 			};
+
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
 		};
 
 		usart6: serial@44003000 {
-- 
2.7.4

