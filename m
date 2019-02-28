Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39B8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA52F218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbfB1KVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:21:31 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12134 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732285AbfB1KVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:21:30 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SADefN026455;
        Thu, 28 Feb 2019 11:20:27 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtv6d4sqa-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 11:20:27 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 67E7531;
        Thu, 28 Feb 2019 10:20:08 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4F4BE4E52;
        Thu, 28 Feb 2019 10:20:08 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 28 Feb 2019 11:20:07
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>, <lionel.debieve@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/6] ARM: dts: stm32: Add romem and temperature calibration on stm32f429
Date:   Thu, 28 Feb 2019 11:19:56 +0100
Message-ID: <1551349196-8956-7-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551349196-8956-1-git-send-email-fabrice.gasnier@st.com>
References: <1551349196-8956-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add & enable stm32 factory-programmed memory. Describe temperature sensor
calibration cells.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 8d6f028..8055c98 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -78,6 +78,19 @@
 	};
 
 	soc {
+		romem: nvmem@1fff7800 {
+			compatible = "st,stm32f4-otp";
+			reg = <0x1fff7800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ts_cal1: calib@22c {
+				reg = <0x22c 0x2>;
+			};
+			ts_cal2: calib@22e {
+				reg = <0x22e 0x2>;
+			};
+		};
+
 		timer2: timer@40000000 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000000 0x400>;
-- 
2.7.4

