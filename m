Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA49C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257E621928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="O59bKtIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbfKEMwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:52:49 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23620 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388581AbfKEMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:52:47 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA5Cq6Gb024537;
        Tue, 5 Nov 2019 13:52:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=clWmFbgtH5kIExt6BYDWdMXSbKq1vqi70ItRquBcd0w=;
 b=O59bKtIuxJnrklY5sc+fpWiImpUJDRelWT24Pp6GxVY3p/xsPHeqO1VbqUHykMM8DJ9/
 J5jjTm4aaTQ/BNr7C93DHPIbIE8p2VF/AXXTLMhXP6Uxc/iGDLdyoqfxE85oibcOn+Jw
 3pPawXDE0zvZMwuWPXpOgrJ2GQpUSLWA9vMLpjEuLIMwjmoECn/wxG/kNlRT6WLv/L6y
 8RbgZNgh/mXhpIIZTVmhYz9FwXpqbnWH3FqRCzi99R7WgG0C9e06QypgBaUUfdtyZiB8
 ztXww1tmg90jfQFmYMA1zFASPTg3cTDfDlH7PH3P5har6M/BOl/FuXtJ7ieR4Ee+wtMO Ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w0ytcr0bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 13:52:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D2A8010002A;
        Tue,  5 Nov 2019 13:52:34 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C6E3F2BC5E5;
        Tue,  5 Nov 2019 13:52:34 +0100 (CET)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 5 Nov 2019
 13:52:34 +0100
Received: from localhost (10.48.0.192) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 5 Nov 2019 13:52:34 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 1/4] ARM: dts: stm32: add pwm sleep pin muxing for stm32mp157c-ed1
Date:   Tue, 5 Nov 2019 13:52:18 +0100
Message-ID: <1572958341-12404-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572958341-12404-1-git-send-email-fabrice.gasnier@st.com>
References: <1572958341-12404-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_04:2019-11-05,2019-11-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PWM pinctrl definitions used in low-power (sleep) mode on
stm32mp157c-ed1.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 1e45b75..de5679f 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -596,6 +596,12 @@
 				};
 			};
 
+			pwm2_sleep_pins_a: pwm2-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('A', 3, ANALOG)>; /* TIM2_CH4 */
+				};
+			};
+
 			pwm8_pins_a: pwm8-0 {
 				pins {
 					pinmux = <STM32_PINMUX('I', 2, AF3)>; /* TIM8_CH4 */
@@ -605,6 +611,12 @@
 				};
 			};
 
+			pwm8_sleep_pins_a: pwm8-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('I', 2, ANALOG)>; /* TIM8_CH4 */
+				};
+			};
+
 			pwm12_pins_a: pwm12-0 {
 				pins {
 					pinmux = <STM32_PINMUX('H', 6, AF2)>; /* TIM12_CH1 */
@@ -614,6 +626,12 @@
 				};
 			};
 
+			pwm12_sleep_pins_a: pwm12-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 6, ANALOG)>; /* TIM12_CH1 */
+				};
+			};
+
 			qspi_clk_pins_a: qspi-clk-0 {
 				pins {
 					pinmux = <STM32_PINMUX('F', 10, AF9)>; /* QSPI_CLK */
-- 
2.7.4

