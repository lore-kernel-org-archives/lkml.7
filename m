Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD388C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE386206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="kJZtcreK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfKFKK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:10:27 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53797 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729169AbfKFKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:10:27 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6A7AGH003297;
        Wed, 6 Nov 2019 11:09:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=1npB15BkmfpmC8uST3T7d6AtcAiZs2SOxTaIZjMSkes=;
 b=kJZtcreKZPgNJzoK+KSUO2WMy68uSuCCWSZwqE+Juhuuc62HIC7nawPiEAcaf48CFzMj
 Cu8v2nmJdL8zybrh2/GZ7VjnVM7+6dbuQCAgOp0hLtV3yZkAIGk8vla2ForVug07qkvx
 Rme91YYRYs0TY0WmTqoJ/tI8h93DpmE6PC8zQZizAOEeNpfUJrNir3Nrv09LIZZOBQGt
 t9XK4r18jU4y08YChLbFpxxU7sOaJK1Lj0kASsiK78JDyDNro9HEfO31M2Hgi79SN/gC
 lYBCjqOWyjYWWl49wNDqtZwSZS9C7pHoA4C2kvpLc67cUW7tR6gkJzuxquwGDIBKyaAr UQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w10f1mpv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 11:09:45 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 86F1910002A;
        Wed,  6 Nov 2019 11:09:45 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 789EB2AD337;
        Wed,  6 Nov 2019 11:09:45 +0100 (CET)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 6 Nov 2019
 11:09:45 +0100
Received: from localhost (10.48.1.131) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 6 Nov 2019 11:09:44 +0100
From:   Yann Gautier <yann.gautier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yann Gautier <yann.gautier@st.com>,
        "Ludovic Barre" <ludovic.barre@st.com>
Subject: [PATCH 4/4] ARM: dts: stm32: add sdmmc3 node for STM32MP1 boards
Date:   Wed, 6 Nov 2019 11:09:38 +0100
Message-ID: <20191106100938.11368-5-yann.gautier@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106100938.11368-1-yann.gautier@st.com>
References: <20191106100938.11368-1-yann.gautier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.1.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On STM32MP1 EVAL and DISCOVERY boards, the SDMMC3 internal peripheral
can be used through the GPIO extension connector. The sdmmc3 node is then
added in the boards DT files, and the required pins are also added.
The node status is disabled as there is no device connected by default.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Yann Gautier <yann.gautier@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 54 +++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157a-dk1.dts     | 12 +++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     | 12 +++++
 3 files changed, 78 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index a907d93f8916..d31a4661f7b5 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -926,6 +926,60 @@
 				};
 			};
 
+			sdmmc3_b4_pins_a: sdmmc3-b4-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('F', 0, AF9)>, /* SDMMC3_D0 */
+						 <STM32_PINMUX('F', 4, AF9)>, /* SDMMC3_D1 */
+						 <STM32_PINMUX('F', 5, AF9)>, /* SDMMC3_D2 */
+						 <STM32_PINMUX('D', 7, AF10)>, /* SDMMC3_D3 */
+						 <STM32_PINMUX('F', 1, AF9)>; /* SDMMC3_CMD */
+					slew-rate = <1>;
+					drive-push-pull;
+					bias-pull-up;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('G', 15, AF10)>; /* SDMMC3_CK */
+					slew-rate = <2>;
+					drive-push-pull;
+					bias-pull-up;
+				};
+			};
+
+			sdmmc3_b4_od_pins_a: sdmmc3-b4-od-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('F', 0, AF9)>, /* SDMMC3_D0 */
+						 <STM32_PINMUX('F', 4, AF9)>, /* SDMMC3_D1 */
+						 <STM32_PINMUX('F', 5, AF9)>, /* SDMMC3_D2 */
+						 <STM32_PINMUX('D', 7, AF10)>; /* SDMMC3_D3 */
+					slew-rate = <1>;
+					drive-push-pull;
+					bias-pull-up;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('G', 15, AF10)>; /* SDMMC3_CK */
+					slew-rate = <2>;
+					drive-push-pull;
+					bias-pull-up;
+				};
+				pins3 {
+					pinmux = <STM32_PINMUX('F', 1, AF9)>; /* SDMMC2_CMD */
+					slew-rate = <1>;
+					drive-open-drain;
+					bias-pull-up;
+				};
+			};
+
+			sdmmc3_b4_sleep_pins_a: sdmmc3-b4-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('F', 0, ANALOG)>, /* SDMMC3_D0 */
+						 <STM32_PINMUX('F', 4, ANALOG)>, /* SDMMC3_D1 */
+						 <STM32_PINMUX('F', 5, ANALOG)>, /* SDMMC3_D2 */
+						 <STM32_PINMUX('D', 7, ANALOG)>, /* SDMMC3_D3 */
+						 <STM32_PINMUX('G', 15, ANALOG)>, /* SDMMC3_CK */
+						 <STM32_PINMUX('F', 1, ANALOG)>; /* SDMMC3_CMD */
+				};
+			};
+
 			spdifrx_pins_a: spdifrx-0 {
 				pins {
 					pinmux = <STM32_PINMUX('G', 12, AF8)>; /* SPDIF_IN1 */
diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 0615d1c8a6fc..b86c32e6a829 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -444,6 +444,18 @@
 	status = "okay";
 };
 
+&sdmmc3 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc3_b4_pins_a>;
+	pinctrl-1 = <&sdmmc3_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc3_b4_sleep_pins_a>;
+	broken-cd;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3>;
+	status = "disabled";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins_a>;
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 89d29b50c3f4..d047901c51ea 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -293,6 +293,18 @@
 	};
 };
 
+&sdmmc3 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc3_b4_pins_a>;
+	pinctrl-1 = <&sdmmc3_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc3_b4_sleep_pins_a>;
+	broken-cd;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3>;
+	status = "disabled";
+};
+
 &spi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi1_pins_a>;
-- 
2.17.1

