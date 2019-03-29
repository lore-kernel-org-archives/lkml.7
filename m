Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FCBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4E120811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfC2Kso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:48:44 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47586 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728711AbfC2Kso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:48:44 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TAgUJf012971;
        Fri, 29 Mar 2019 11:48:32 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rhg9w0np1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 29 Mar 2019 11:48:32 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C602D31;
        Fri, 29 Mar 2019 10:48:31 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9AE4027A2;
        Fri, 29 Mar 2019 10:48:31 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 29 Mar
 2019 11:48:31 +0100
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Fri, 29 Mar 2019 11:48:31
 +0100
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH] ARM: dts: stm32: add I2C sleep pins muxing on stm32mp157
Date:   Fri, 29 Mar 2019 11:48:20 +0100
Message-ID: <1553856500-31009-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C sleep pins muxing for low power mode.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 9104896..b04899f 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -213,6 +213,13 @@
 				};
 			};
 
+			i2c1_pins_sleep_a: i2c1-1 {
+				pins {
+					pinmux = <STM32_PINMUX('D', 12, ANALOG)>, /* I2C1_SCL */
+						 <STM32_PINMUX('F', 15, ANALOG)>; /* I2C1_SDA */
+				};
+			};
+
 			i2c2_pins_a: i2c2-0 {
 				pins {
 					pinmux = <STM32_PINMUX('H', 4, AF4)>, /* I2C2_SCL */
@@ -223,6 +230,13 @@
 				};
 			};
 
+			i2c2_pins_sleep_a: i2c2-1 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 4, ANALOG)>, /* I2C2_SCL */
+						 <STM32_PINMUX('H', 5, ANALOG)>; /* I2C2_SDA */
+				};
+			};
+
 			i2c5_pins_a: i2c5-0 {
 				pins {
 					pinmux = <STM32_PINMUX('A', 11, AF4)>, /* I2C5_SCL */
@@ -233,6 +247,14 @@
 				};
 			};
 
+			i2c5_pins_sleep_a: i2c5-1 {
+				pins {
+					pinmux = <STM32_PINMUX('A', 11, ANALOG)>, /* I2C5_SCL */
+						 <STM32_PINMUX('A', 12, ANALOG)>; /* I2C5_SDA */
+
+				};
+			};
+
 			m_can1_pins_a: m-can1-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('H', 13, AF9)>; /* CAN1_TX */
@@ -439,6 +461,13 @@
 				};
 			};
 
+			i2c4_pins_sleep_a: i2c4-1 {
+				pins {
+					pinmux = <STM32_PINMUX('Z', 4, ANALOG)>, /* I2C4_SCL */
+						 <STM32_PINMUX('Z', 5, ANALOG)>; /* I2C4_SDA */
+				};
+			};
+
 			spi1_pins_a: spi1-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('Z', 0, AF5)>, /* SPI1_SCK */
-- 
2.7.4

