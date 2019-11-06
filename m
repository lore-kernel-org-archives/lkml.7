Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E72C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE85F2173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="IpWAjo40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbfKFKKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:10:01 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29218 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731379AbfKFKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:09:57 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6A7GcI003655;
        Wed, 6 Nov 2019 11:09:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=FIClY/e3QBNSiXrpeU79siTfTUG1jsOVOKrMfL3AkC4=;
 b=IpWAjo40QpMibeGzZ54Bj1H3AIG115RFdC7woJSdPzo/uNlUdJ9eLeodBedT8O4/opPK
 bK7QIvR3bGFmkl93ezFWnG5RxW/eI9UWpUXmCL9loOt2KHJ+fW63qRB5iVM+EeJMKx1/
 GzekkeVgaHihxUI6S6TFQ0q/HFqJ1MtV4qsBb/p1Sz/kwmrRUkNQuInuq0a6mv/a2uAB
 bX3qUbXHFpo5iWYVb7BJFVT+CBs5Uu9WZ9MEbiRMcKGZ6W98IMSzxNMGXYF6P73/BXkN
 MU434r8BvyQhs/pLAGbqbiP5nswZ4/NAdingYzK8u1u3Qf88Hbo1oO/mv42z+GXmEbsh xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w1054vs44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 11:09:45 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 905B0100038;
        Wed,  6 Nov 2019 11:09:44 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7EB812AD337;
        Wed,  6 Nov 2019 11:09:44 +0100 (CET)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 6 Nov 2019
 11:09:44 +0100
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
Subject: [PATCH 3/4] ARM: dts: stm32: enable sdmmc2 node for stm32mp157c-ed1 board
Date:   Wed, 6 Nov 2019 11:09:37 +0100
Message-ID: <20191106100938.11368-4-yann.gautier@st.com>
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

On STM32MP157C-ED1, the eMMC is connected on instance 2 of SDMMC
peripheral. The sdmmc2 node is then added in the board DT file, as well as
the pins nodes in the pinctrl file.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Yann Gautier <yann.gautier@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 118 ++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts     |  16 +++
 2 files changed, 134 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 2904bc8c6a41..a907d93f8916 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -808,6 +808,124 @@
 				};
 			};
 
+			sdmmc2_b4_pins_a: sdmmc2-b4-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+						 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC2_D1 */
+						 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
+						 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC2_D3 */
+						 <STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
+					slew-rate = <1>;
+					drive-push-pull;
+					bias-pull-up;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('E', 3, AF9)>; /* SDMMC2_CK */
+					slew-rate = <2>;
+					drive-push-pull;
+					bias-pull-up;
+				};
+			};
+
+			sdmmc2_b4_od_pins_a: sdmmc2-b4-od-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+						 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC2_D1 */
+						 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
+						 <STM32_PINMUX('B', 4, AF9)>; /* SDMMC2_D3 */
+					slew-rate = <1>;
+					drive-push-pull;
+					bias-pull-up;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('E', 3, AF9)>; /* SDMMC2_CK */
+					slew-rate = <2>;
+					drive-push-pull;
+					bias-pull-up;
+				};
+				pins3 {
+					pinmux = <STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
+					slew-rate = <1>;
+					drive-open-drain;
+					bias-pull-up;
+				};
+			};
+
+			sdmmc2_b4_sleep_pins_a: sdmmc2-b4-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC2_D0 */
+						 <STM32_PINMUX('B', 15, ANALOG)>, /* SDMMC2_D1 */
+						 <STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC2_D2 */
+						 <STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC2_D3 */
+						 <STM32_PINMUX('E', 3, ANALOG)>, /* SDMMC2_CK */
+						 <STM32_PINMUX('G', 6, ANALOG)>; /* SDMMC2_CMD */
+				};
+			};
+
+			sdmmc2_b4_pins_b: sdmmc2-b4-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+						 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC2_D1 */
+						 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
+						 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC2_D3 */
+						 <STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
+					slew-rate = <1>;
+					drive-push-pull;
+					bias-disable;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('E', 3, AF9)>; /* SDMMC2_CK */
+					slew-rate = <2>;
+					drive-push-pull;
+					bias-disable;
+				};
+			};
+
+			sdmmc2_b4_od_pins_b: sdmmc2-b4-od-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+						 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC2_D1 */
+						 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
+						 <STM32_PINMUX('B', 4, AF9)>; /* SDMMC2_D3 */
+					slew-rate = <1>;
+					drive-push-pull;
+					bias-disable;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('E', 3, AF9)>; /* SDMMC2_CK */
+					slew-rate = <2>;
+					drive-push-pull;
+					bias-disable;
+				};
+				pins3 {
+					pinmux = <STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
+					slew-rate = <1>;
+					drive-open-drain;
+					bias-disable;
+				};
+			};
+
+			sdmmc2_d47_pins_a: sdmmc2-d47-0 {
+				pins {
+					pinmux = <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
+						 <STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
+						 <STM32_PINMUX('E', 5, AF9)>, /* SDMMC2_D6 */
+						 <STM32_PINMUX('D', 3, AF9)>; /* SDMMC2_D7 */
+					slew-rate = <1>;
+					drive-push-pull;
+					bias-pull-up;
+				};
+			};
+
+			sdmmc2_d47_sleep_pins_a: sdmmc2-d47-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
+						 <STM32_PINMUX('A', 9, ANALOG)>, /* SDMMC2_D5 */
+						 <STM32_PINMUX('E', 5, ANALOG)>, /* SDMMC2_D6 */
+						 <STM32_PINMUX('D', 3, ANALOG)>; /* SDMMC2_D7 */
+				};
+			};
+
 			spdifrx_pins_a: spdifrx-0 {
 				pins {
 					pinmux = <STM32_PINMUX('G', 12, AF8)>; /* SPDIF_IN1 */
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 1d426ea8bdaf..b40a6b9a7aa6 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -302,6 +302,22 @@
 	status = "okay";
 };
 
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	st,neg-edge;
+	bus-width = <8>;
+	vmmc-supply = <&v3v3>;
+	vqmmc-supply = <&v3v3>;
+	mmc-ddr-3_3v;
+	status = "okay";
+};
+
 &timers6 {
 	status = "okay";
 	/* spare dmas for other usage */
-- 
2.17.1

