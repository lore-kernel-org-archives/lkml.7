Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E367C17461
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050C921928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="HsMOixEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389007AbfKEMw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:52:56 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47190 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388678AbfKEMws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:52:48 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA5CnPFZ027895;
        Tue, 5 Nov 2019 13:52:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=7qTkJgeLvJG9yVLjxR53YS50TdExPF24lYbqfsmrqvk=;
 b=HsMOixEbY1ruOLkQkxxCJ1z3pter8jt/eEfoLcOYQqmjh7Fv3GAyTVc/l1Hn9ukj0tUS
 slRGdrwyy4uWHmWBxf3TvSk4HFbieyaZUV9cXJIsJQ60oVXEbMe2HYE1r3WVRX8QXecX
 WdW9shpbHGw1KVLyIbKRs0Joh3sIATuyIcqVis9gyCqeaA727HWJRe4/EJSjtja46Hct
 6r7fFv5lpPL4sdTv1Ovzmf2pSFad+MdOLPXyRSp7orBkO7EC6ibMGafkIq4Imfek8vqp
 JPTeQf93GdFRa09InEEkwP+TNrwNF8VqdNUx8wRpktlBt3v/k2W55DhXMbfp2hWeit76 9A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w11jn7kg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 13:52:36 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09340100039;
        Tue,  5 Nov 2019 13:52:36 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EC5372BC5E7;
        Tue,  5 Nov 2019 13:52:35 +0100 (CET)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 5 Nov 2019
 13:52:35 +0100
Received: from localhost (10.48.0.192) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 5 Nov 2019 13:52:35 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 2/4] ARM: dts: stm32: add pwm pin muxing for stm32mp157a-dk1
Date:   Tue, 5 Nov 2019 13:52:19 +0100
Message-ID: <1572958341-12404-3-git-send-email-fabrice.gasnier@st.com>
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

Add all PWM pinctrl definitions that can be used on stm32mp157a-dk1 board.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 81 +++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index de5679f..0f42ab1 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -587,6 +587,25 @@
 				};
 			};
 
+			pwm1_pins_a: pwm1-0 {
+				pins {
+					pinmux = <STM32_PINMUX('E', 9, AF1)>, /* TIM1_CH1 */
+						 <STM32_PINMUX('E', 11, AF1)>, /* TIM1_CH2 */
+						 <STM32_PINMUX('E', 14, AF1)>; /* TIM1_CH4 */
+					bias-pull-down;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+			};
+
+			pwm1_sleep_pins_a: pwm1-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('E', 9, ANALOG)>, /* TIM1_CH1 */
+						 <STM32_PINMUX('E', 11, ANALOG)>, /* TIM1_CH2 */
+						 <STM32_PINMUX('E', 14, ANALOG)>; /* TIM1_CH4 */
+				};
+			};
+
 			pwm2_pins_a: pwm2-0 {
 				pins {
 					pinmux = <STM32_PINMUX('A', 3, AF1)>; /* TIM2_CH4 */
@@ -602,6 +621,68 @@
 				};
 			};
 
+			pwm3_pins_a: pwm3-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 7, AF2)>; /* TIM3_CH2 */
+					bias-pull-down;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+			};
+
+			pwm3_sleep_pins_a: pwm3-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 7, ANALOG)>; /* TIM3_CH2 */
+				};
+			};
+
+			pwm4_pins_a: pwm4-0 {
+				pins {
+					pinmux = <STM32_PINMUX('D', 14, AF2)>, /* TIM4_CH3 */
+						 <STM32_PINMUX('D', 15, AF2)>; /* TIM4_CH4 */
+					bias-pull-down;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+			};
+
+			pwm4_sleep_pins_a: pwm4-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('D', 14, ANALOG)>, /* TIM4_CH3 */
+						 <STM32_PINMUX('D', 15, ANALOG)>; /* TIM4_CH4 */
+				};
+			};
+
+			pwm4_pins_b: pwm4-1 {
+				pins {
+					pinmux = <STM32_PINMUX('D', 13, AF2)>; /* TIM4_CH2 */
+					bias-pull-down;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+			};
+
+			pwm4_sleep_pins_b: pwm4-sleep-1 {
+				pins {
+					pinmux = <STM32_PINMUX('D', 13, ANALOG)>; /* TIM4_CH2 */
+				};
+			};
+
+			pwm5_pins_a: pwm5-0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 11, AF2)>; /* TIM5_CH2 */
+					bias-pull-down;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+			};
+
+			pwm5_sleep_pins_a: pwm5-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 11, ANALOG)>; /* TIM5_CH2 */
+				};
+			};
+
 			pwm8_pins_a: pwm8-0 {
 				pins {
 					pinmux = <STM32_PINMUX('I', 2, AF3)>; /* TIM8_CH4 */
-- 
2.7.4

