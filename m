Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C06C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1D62087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbfCAIsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:48:22 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21752 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733100AbfCAIsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:48:18 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x218lESf021269;
        Fri, 1 Mar 2019 09:48:07 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtv6dajft-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 01 Mar 2019 09:48:07 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D1CE34;
        Fri,  1 Mar 2019 08:48:03 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 011072B18;
        Fri,  1 Mar 2019 08:48:02 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 1 Mar 2019
 09:48:02 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 1 Mar 2019
 09:48:02 +0100
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH  3/7] ARM: dts: stm32: add sdmmc1 support on stm32h743i eval board
Date:   Fri, 1 Mar 2019 09:47:44 +0100
Message-ID: <1551430068-9456-4-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551430068-9456-1-git-send-email-ludovic.Barre@st.com>
References: <1551430068-9456-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds sdmmc1 support on stm32h743i eval board.
This board has an external driver to control signal direction polarity.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 68 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts    | 23 ++++++++++-
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
index 24be8e6..98051a8 100644
--- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
@@ -173,6 +173,74 @@
 				};
 			};
 
+			sdmmc1_b4_pins_a: sdmmc1-b4-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
+						 <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1_CK */
+						 <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
+					slew-rate = <3>;
+					drive-push-pull;
+					bias-disable;
+				};
+			};
+
+			sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
+						 <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
+					slew-rate = <3>;
+					drive-push-pull;
+					bias-disable;
+				};
+				pins2{
+					pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
+					slew-rate = <3>;
+					drive-open-drain;
+					bias-disable;
+				};
+			};
+
+			sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
+						 <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
+						 <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1_D2 */
+						 <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1_D3 */
+						 <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1_CK */
+						 <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1_CMD */
+				};
+			};
+
+			sdmmc1_dir_pins_a: sdmmc1-dir-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
+						 <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
+						 <STM32_PINMUX('B', 9, AF7)>; /* SDMMC1_CDIR */
+					slew-rate = <3>;
+					drive-push-pull;
+					bias-pull-up;
+				};
+				pins2{
+					pinmux = <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
+					bias-pull-up;
+				};
+			};
+
+			sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC1_D0DIR */
+						 <STM32_PINMUX('C', 7, ANALOG)>, /* SDMMC1_D123DIR */
+						 <STM32_PINMUX('B', 9, ANALOG)>, /* SDMMC1_CDIR */
+						 <STM32_PINMUX('B', 8, ANALOG)>; /* SDMMC1_CKIN */
+				};
+			};
+
 			usart1_pins: usart1@0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
index 3f8e0c4..eb5e0d4 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -69,13 +69,20 @@
 		regulator-always-on;
 	};
 
+	v2v9_sd: regulator-v2v9_sd {
+		compatible = "regulator-fixed";
+		regulator-name = "v2v9_sd";
+		regulator-min-microvolt = <2900000>;
+		regulator-max-microvolt = <2900000>;
+		regulator-always-on;
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
 		clocks = <&rcc USB1ULPI_CK>;
 		clock-names = "main_clk";
 	};
-
 };
 
 &adc_12 {
@@ -104,6 +111,20 @@
 	status = "okay";
 };
 
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_dir_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a &sdmmc1_dir_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a &sdmmc1_dir_sleep_pins_a>;
+	broken-cd;
+	st,sig-dir;
+	st,neg-edge;
+	st,use-ckin;
+	bus-width = <4>;
+	vmmc-supply = <&v2v9_sd>;
+	status = "okay";
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins>;
 	pinctrl-names = "default";
-- 
2.7.4

