Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EE3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB862171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbfB1O0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:26:22 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11019 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732934AbfB1O0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:26:15 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SEOQL2017442;
        Thu, 28 Feb 2019 15:26:05 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtv6d5xef-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 15:26:05 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1319A31;
        Thu, 28 Feb 2019 14:26:03 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC37C5996;
        Thu, 28 Feb 2019 14:26:02 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 28 Feb
 2019 15:26:02 +0100
Received: from localhost (10.201.23.19) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 28 Feb 2019 15:26:02
 +0100
From:   Hugues Fruchet <hugues.fruchet@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 4/4] ARM: dts: stm32: enable OV5640 camera on stm32mp157c-ev1 board
Date:   Thu, 28 Feb 2019 15:25:45 +0100
Message-ID: <1551363945-19497-5-git-send-email-hugues.fruchet@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551363945-19497-1-git-send-email-hugues.fruchet@st.com>
References: <1551363945-19497-1-git-send-email-hugues.fruchet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.19]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable OV5640 camera sensor driver of MB1379A extension
board connected on CN7 connector of stm32mp157c-ev1 board:
bus-width is set to 8, data-shift is set to 2 (lines 9:2 are used),
hsync-active is set to 0 for horizontal synchro line active low,
vsync-active is set to 0 for vertical synchro line active low and
pclk-sample is set to 1 for pixel clock polarity sampling data
on rising edge of the pixel clock signal.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 009f9d6..8fb1688 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -65,6 +65,14 @@
 		default-on;
 		status = "okay";
 	};
+
+	clocks {
+		clk_ext_camera: clk-ext-camera {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+	};
 };
 
 &cec {
@@ -73,6 +81,23 @@
 	status = "okay";
 };
 
+&dcmi {
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&dcmi_pins_a>;
+	pinctrl-1 = <&dcmi_sleep_pins_a>;
+
+	port {
+		dcmi_0: endpoint {
+			remote-endpoint = <&ov5640_0>;
+			bus-width = <8>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			pclk-sample = <1>;
+		};
+	};
+};
+
 &dsi {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -138,6 +163,31 @@
 	i2c-scl-falling-time-ns = <20>;
 	status = "okay";
 
+	ov5640: camera@3c {
+		compatible = "ovti,ov5640";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ov5640_pins>;
+		reg = <0x3c>;
+		clocks = <&clk_ext_camera>;
+		clock-names = "xclk";
+		DOVDD-supply = <&v2v8>;
+		powerdown-gpios = <&stmfx_pinctrl 18 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&stmfx_pinctrl 19 GPIO_ACTIVE_LOW>;
+		rotation = <180>;
+		status = "okay";
+
+		port {
+			ov5640_0: endpoint {
+				remote-endpoint = <&dcmi_0>;
+				bus-width = <8>;
+				data-shift = <2>; /* lines 9:2 are used */
+				hsync-active = <0>;
+				vsync-active = <0>;
+				pclk-sample = <1>;
+			};
+		};
+	};
+
 	stmfx: stmfx@42 {
 		compatible = "st,stmfx-0300";
 		reg = <0x42>;
@@ -157,6 +207,12 @@
 				drive-push-pull;
 				bias-pull-down;
 			};
+
+			ov5640_pins: camera {
+				pins = "agpio2", "agpio3"; /* stmfx pins 18 & 19 */
+				drive-push-pull;
+				output-low;
+			};
 		};
 	};
 };
-- 
2.7.4

