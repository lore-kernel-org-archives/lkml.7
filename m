Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE9CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0200220651
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="be56z4Pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDIHYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:24:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:14770 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbfDIHYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:24:37 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x397M6tr024154;
        Tue, 9 Apr 2019 09:24:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=jUKe/OmUiifvXJm9ZqC3Jzcpam9I5s409PVofKAxVvo=;
 b=be56z4Pz+xFawyGHuPFL47qEq/t8Na8HnbTS4NDwW7c0USWOvpVxMggoyzQcrOUidu+y
 qqhzXSqzsKFEgphOG98tNhdS5JpAwvgtc8trCSCVuWL8qNG6JnCDvOanwEGQhJpFHLpF
 qrOe43krKXUYVbpYM7KVTfDecaoPUcp8Nhi5q8TI+KISavsVdHeSmZxmN8Bgy9u3d6H+
 rXUuCaskSWQjSBQylLAXeHoLVDcvEKADtsKE1Yy1Mv9W8HJyO6D5dUHuBhEZbeES5Sm1
 YfjYbY0iN/P76hTa8OeYkI6F4/8GUGHiWrIM9wW4KtLUeoJOPEgQCGT5iZji8y+zagQf Wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprcny3t3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Apr 2019 09:24:23 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C4CC838;
        Tue,  9 Apr 2019 07:24:22 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 897592502;
        Tue,  9 Apr 2019 07:24:22 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 9 Apr 2019
 09:24:22 +0200
Received: from localhost (10.201.20.5) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 9 Apr 2019 09:24:22 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v5 3/9] dt-bindings: pinctrl: document the STMFX pinctrl bindings
Date:   Tue, 9 Apr 2019 09:24:05 +0200
Message-ID: <1554794651-6874-4-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554794651-6874-1-git-send-email-amelie.delaunay@st.com>
References: <1554794651-6874-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of device tree bindings for the
STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
new file mode 100644
index 0000000..c1b4c18
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
@@ -0,0 +1,116 @@
+STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander bindings
+
+ST Multi-Function eXpander (STMFX) offers up to 24 GPIOs expansion.
+Please refer to ../mfd/stmfx.txt for STMFX Core bindings.
+
+Required properties:
+- compatible: should be "st,stmfx-0300-pinctrl".
+- #gpio-cells: should be <2>, the first cell is the GPIO number and the second
+  cell is the gpio flags in accordance with <dt-bindings/gpio/gpio.h>.
+- gpio-controller: marks the device as a GPIO controller.
+- #interrupt-cells: should be <2>, the first cell is the GPIO number and the
+  second cell is the interrupt flags in accordance with
+  <dt-bindings/interrupt-controller/irq.h>.
+- interrupt-controller: marks the device as an interrupt controller.
+- gpio-ranges: specifies the mapping between gpio controller and pin
+  controller pins. Check "Concerning gpio-ranges property" below.
+Please refer to ../gpio/gpio.txt.
+
+Please refer to pinctrl-bindings.txt for pin configuration.
+
+Required properties for pin configuration sub-nodes:
+- pins: list of pins to which the configuration applies.
+
+Optional properties for pin configuration sub-nodes (pinconf-generic ones):
+- bias-disable: disable any bias on the pin.
+- bias-pull-up: the pin will be pulled up.
+- bias-pull-pin-default: use the pin-default pull state.
+- bias-pull-down: the pin will be pulled down.
+- drive-open-drain: the pin will be driven with open drain.
+- drive-push-pull: the pin will be driven actively high and low.
+- output-high: the pin will be configured as an output driving high level.
+- output-low: the pin will be configured as an output driving low level.
+
+Note that STMFX pins[15:0] are called "gpio[15:0]", and STMFX pins[23:16] are
+called "agpio[7:0]". Example, to refer to pin 18 of STMFX, use "agpio2".
+
+Concerning gpio-ranges property:
+- if all STMFX pins[24:0] are available (no other STMFX function in use), you
+  should use gpio-ranges = <&stmfx_pinctrl 0 0 24>;
+- if agpio[3:0] are not available (STMFX Touchscreen function in use), you
+  should use gpio-ranges = <&stmfx_pinctrl 0 0 16>, <&stmfx_pinctrl 20 20 4>;
+- if agpio[7:4] are not available (STMFX IDD function in use), you
+  should use gpio-ranges = <&stmfx_pinctrl 0 0 20>;
+
+
+Example:
+
+	stmfx: stmfx@42 {
+		...
+
+		stmfx_pinctrl: stmfx-pin-controller {
+			compatible = "st,stmfx-0300-pinctrl";
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			gpio-ranges = <&stmfx_pinctrl 0 0 24>;
+
+			joystick_pins: joystick {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3", "gpio4";
+				drive-push-pull;
+				bias-pull-up;
+			};
+		};
+	};
+
+Example of STMFX GPIO consumers:
+
+	joystick {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&joystick_pins>;
+		pinctrl-names = "default";
+		button-0 {
+			label = "JoySel";
+			linux,code = <KEY_ENTER>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+		};
+		button-1 {
+			label = "JoyDown";
+			linux,code = <KEY_DOWN>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <1 IRQ_TYPE_EDGE_RISING>;
+		};
+		button-2 {
+			label = "JoyLeft";
+			linux,code = <KEY_LEFT>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <2 IRQ_TYPE_EDGE_RISING>;
+		};
+		button-3 {
+			label = "JoyRight";
+			linux,code = <KEY_RIGHT>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+		};
+		button-4 {
+			label = "JoyUp";
+			linux,code = <KEY_UP>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		orange {
+			gpios = <&stmfx_pinctrl 17 1>;
+		};
+
+		blue {
+			gpios = <&stmfx_pinctrl 19 1>;
+		};
+	}
-- 
2.7.4

