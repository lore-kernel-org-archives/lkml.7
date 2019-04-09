Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3849C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C7120883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="1Uq9Q9KT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDIHYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:24:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22062 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbfDIHYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:24:40 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x397LVjk029928;
        Tue, 9 Apr 2019 09:24:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=o2/M4BkHcczbpi1K8XhA/zyjm57DMdnDjEszttkz4dQ=;
 b=1Uq9Q9KTSsE15YJwwspOK8puUfKmi9CrV5cBR0pWmTbkXfRCxeaVw7bYY5P1vaeatViL
 PebcZ1UTSJGKV7DG+PwvpBgZV/f3U7JpCC/lWO4pNVIv+rpbZJOXtel4HeDZCTaVzaFs
 roQXPblb0ybCpNHyqKk/ktJk9cfVrabNImqJXHdUTFBzBYENuXvcHhuqg+62xH/Z6Jv1
 2gkWHJ7PhzdJXURFY5vYZSmFMXwgoJnWHmREDao44NS3NT1VkUcBEb9QXUOaB5+SNDBt
 a3jkRO/cMWr/M8AP3U8wEDorHT5F/H/tgH1mIuyDJe9T1bfdSi8/j/0J/FxAXtFdgMzC qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprkdf1d9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Apr 2019 09:24:27 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B96CC34;
        Tue,  9 Apr 2019 07:24:26 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96E002502;
        Tue,  9 Apr 2019 07:24:26 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 9 Apr 2019
 09:24:26 +0200
Received: from localhost (10.201.20.5) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 9 Apr 2019 09:24:25 +0200
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
Subject: [PATCH v5 6/9] ARM: dts: stm32: add joystick support on stm32746g-eval
Date:   Tue, 9 Apr 2019 09:24:08 +0200
Message-ID: <1554794651-6874-7-git-send-email-amelie.delaunay@st.com>
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

The joystick (B3) on stm32746g-eval uses gpios on STMFX gpio expander.
These gpios need a pin configuration (push-pull and bias-pull-up),
described under stmfx_pinctrl node.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index 58e0457..21e8912 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -87,6 +87,43 @@
 		};
 	};
 
+	joystick {
+		compatible = "gpio-keys";
+		#size-cells = <0>;
+		pinctrl-0 = <&joystick_pins>;
+		pinctrl-names = "default";
+		button-0 {
+			label = "JoySel";
+			linux,code = <KEY_ENTER>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		};
+		button-1 {
+			label = "JoyDown";
+			linux,code = <KEY_DOWN>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		};
+		button-2 {
+			label = "JoyLeft";
+			linux,code = <KEY_LEFT>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+		};
+		button-3 {
+			label = "JoyRight";
+			linux,code = <KEY_RIGHT>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+		};
+		button-4 {
+			label = "JoyUp";
+			linux,code = <KEY_UP>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+		};
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
@@ -130,6 +167,12 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			gpio-ranges = <&stmfx_pinctrl 0 0 24>;
+
+			joystick_pins: joystick {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3", "gpio4";
+				drive-push-pull;
+				bias-pull-up;
+			};
 		};
 	};
 };
-- 
2.7.4

