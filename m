Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B23C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E022089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="CK+1gUTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfFUOvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:51:07 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41256 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726402AbfFUOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:51:06 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LEaSHX008663;
        Fri, 21 Jun 2019 16:50:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=xJzSb0vLMvQQqcR+GwMSOIjeQUxGRSb+qqQ5nd442G0=;
 b=CK+1gUTMPz86IMV3Nb4kmBzUGcCz3eFXE1s5vL9etIIOaYl+NQKaAl7iLUbWpOKpsYEH
 rZE21C0UsUd1xYKaOcJJGb+lVptDChGU9ZXuZ6lwRefDpqiyBaarLbR9zRLocJc//ZCs
 g7FL6mmfd0sqQHFRSrR9w0RLPt3VYtb11jQlCAI7tRI6Pjzs5e3X19uL2LcO3ZN23jyz
 rxMw3TjCK7Hol5RGHvphC01dZHvjPRI10s5TEa1HHk2jIshU9cKOWp3ECcptJqJRObTN
 xtLfbz8Pk+Fjqh+AvkB0n0BBc9tGIsAVF1tJHqk8CN8himEY9y5mJwLjN9OakAtmnwXP 6Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t781388p1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Jun 2019 16:50:53 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4DE434;
        Fri, 21 Jun 2019 14:50:52 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E79B2BDF;
        Fri, 21 Jun 2019 14:50:52 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 21 Jun 2019 16:50:52
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
Subject: [PATCH 2/4] ARM: dts: stm32: add FMC2 NAND controller pins muxing on stm32mp157c-ev1
Date:   Fri, 21 Jun 2019 16:49:48 +0200
Message-ID: <1561128590-14621-3-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561128590-14621-1-git-send-email-christophe.kerello@st.com>
References: <1561128590-14621-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FMC2 NAND controller pins muxing used on stm32mp157c-ev1.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index df64701..c4f2b23 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -276,6 +276,50 @@
 				};
 			};
 
+			fmc_pins_a: fmc-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('D', 4, AF12)>, /* FMC_NOE */
+						 <STM32_PINMUX('D', 5, AF12)>, /* FMC_NWE */
+						 <STM32_PINMUX('D', 11, AF12)>, /* FMC_A16_FMC_CLE */
+						 <STM32_PINMUX('D', 12, AF12)>, /* FMC_A17_FMC_ALE */
+						 <STM32_PINMUX('D', 14, AF12)>, /* FMC_D0 */
+						 <STM32_PINMUX('D', 15, AF12)>, /* FMC_D1 */
+						 <STM32_PINMUX('D', 0, AF12)>, /* FMC_D2 */
+						 <STM32_PINMUX('D', 1, AF12)>, /* FMC_D3 */
+						 <STM32_PINMUX('E', 7, AF12)>, /* FMC_D4 */
+						 <STM32_PINMUX('E', 8, AF12)>, /* FMC_D5 */
+						 <STM32_PINMUX('E', 9, AF12)>, /* FMC_D6 */
+						 <STM32_PINMUX('E', 10, AF12)>, /* FMC_D7 */
+						 <STM32_PINMUX('G', 9, AF12)>; /* FMC_NE2_FMC_NCE */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <1>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('D', 6, AF12)>; /* FMC_NWAIT */
+					bias-pull-up;
+				};
+			};
+
+			fmc_sleep_pins_a: fmc-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('D', 4, ANALOG)>, /* FMC_NOE */
+						 <STM32_PINMUX('D', 5, ANALOG)>, /* FMC_NWE */
+						 <STM32_PINMUX('D', 11, ANALOG)>, /* FMC_A16_FMC_CLE */
+						 <STM32_PINMUX('D', 12, ANALOG)>, /* FMC_A17_FMC_ALE */
+						 <STM32_PINMUX('D', 14, ANALOG)>, /* FMC_D0 */
+						 <STM32_PINMUX('D', 15, ANALOG)>, /* FMC_D1 */
+						 <STM32_PINMUX('D', 0, ANALOG)>, /* FMC_D2 */
+						 <STM32_PINMUX('D', 1, ANALOG)>, /* FMC_D3 */
+						 <STM32_PINMUX('E', 7, ANALOG)>, /* FMC_D4 */
+						 <STM32_PINMUX('E', 8, ANALOG)>, /* FMC_D5 */
+						 <STM32_PINMUX('E', 9, ANALOG)>, /* FMC_D6 */
+						 <STM32_PINMUX('E', 10, ANALOG)>, /* FMC_D7 */
+						 <STM32_PINMUX('D', 6, ANALOG)>, /* FMC_NWAIT */
+						 <STM32_PINMUX('G', 9, ANALOG)>; /* FMC_NE2_FMC_NCE */
+				};
+			};
+
 			i2c1_pins_a: i2c1-0 {
 				pins {
 					pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
-- 
1.9.1

