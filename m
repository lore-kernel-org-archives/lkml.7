Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AF7C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15802077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDKMl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:41:58 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:58567 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfDKMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:41:58 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id AA1EE3C014A;
        Thu, 11 Apr 2019 14:41:54 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8_B4ZprzpN_c; Thu, 11 Apr 2019 14:41:47 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id D63723C00C6;
        Thu, 11 Apr 2019 14:41:47 +0200 (CEST)
Received: from vmlxhi-095.adit-jv.com (10.72.93.87) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 11 Apr
 2019 14:41:47 +0200
From:   Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
To:     <horms@verge.net.au>
CC:     <magnus.damm@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <tfranzen@de.adit-jv.com>
Subject: [PATCH] arm64: dts: ulcb-kf: Add support for TI WL1837
Date:   Thu, 11 Apr 2019 14:41:03 +0200
Message-ID: <20190411124102.22442-1-spapageorgiou@de.adit-jv.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.93.87]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds description of TI WL1837 and links interfaces
to communicate with the IC, namely the SDIO interface to WLAN.

Signed-off-by: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
---
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 49 ++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 7a09576..27851a7 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -38,6 +38,18 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 	};
+
+	wlan_en: regulator-wlan_en {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio_exp_74 4 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
 
 &can0 {
@@ -88,6 +100,13 @@
 			line-name = "Audio_Out_OFF";
 		};
 
+		sd-wifi-mux {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_HIGH>;
+			output-low;	/* Connect WL1837 */
+			line-name = "SD WiFi mux";
+		};
+
 		hub_pwen {
 			gpio-hog;
 			gpios = <6 GPIO_ACTIVE_HIGH>;
@@ -254,6 +273,12 @@
 		function = "scif1";
 	};
 
+	sdhi3_pins: sdhi3 {
+		groups = "sdhi3_data4", "sdhi3_ctrl";
+		function = "sdhi3";
+		power-source = <3300>;
+	};
+
 	usb0_pins: usb0 {
 		groups = "usb0";
 		function = "usb0";
@@ -273,6 +298,30 @@
 	status = "okay";
 };
 
+&sdhi3 {
+	pinctrl-0 = <&sdhi3_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&wlan_en>;
+	vqmmc-supply = <&wlan_en>;
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+	cap-power-off-card;
+	keep-power-in-suspend;
+	max-frequency = <26000000>;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1837";
+		reg = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
 &usb2_phy0 {
 	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
-- 
2.7.4

