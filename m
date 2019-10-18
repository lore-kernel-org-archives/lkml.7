Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718AACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D52F222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Noahe+cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439945AbfJRQay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:30:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33168 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439782AbfJRQao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:30:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so3110748pls.0;
        Fri, 18 Oct 2019 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ioUxflPJk241Sd8uCqW+4LLu7go7mYYjazg2y5D+euI=;
        b=Noahe+cw+oe1BNvUPmv9cmXuYAKMcdh3TkhmHpUDgLyEFiBRsD2jru5PXvGJv6MqXD
         /XE4wG0iZksfhB3BVRXjItDttPFMoTynMQEr4YV3TzLLTmoj2anNAaQxKvmiwQtaGAYW
         ebL2vANtuNHEEWUB7RMeOcu/IHGCk56GOas1WYXY1J1qi9OmkvE1W1CQ2hLaOSqbZ7wC
         jfGIXBjPUYCaCteWsopRhzZPIPrQjFGm7/5E1yJI1WYUzlxKDM7ItznQIpyo3BYb58Tu
         HuaAgYGftDjRcrkxwaBmPCVYz/uxrugxf8eOXf9Ex0kEZJRbcZNZT4JMpBNXeqqjElUq
         jc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ioUxflPJk241Sd8uCqW+4LLu7go7mYYjazg2y5D+euI=;
        b=oTri8ugRFfZtAXpTDYUBFarwfklJqHb3yEH8lM1VBhkeoNp476+naOrf+2H68QcpB/
         lqArz4xVfsmN0bS8HEhk301pdqkR9KALbfjkHEwhlzLhPKib47BjJvovvyIY7K1+Y902
         RaM1ni64zks/SWaJZ0MC2GybBg8VhJRiGRYxUwm1VRV0RvYJHzGOV07zRqiwwHJbkegm
         0SSjUHE076etyChn2IUnm1RwfsOSD0PUS2qf+5OYPzDiVGSToLImAa8QHb8yCJbbq1in
         yzqcj18ukkPmhqunEonphZ4V/79gZSJu21/eDD1V7jU5XbLWizxn5wIkIlV8CQJyjNZH
         URkQ==
X-Gm-Message-State: APjAAAVOF9cDbA0QTkRdBUBF1UY1AEb/ICH7p+ps6DkNLEliEwu39knI
        aktZ8t64/LKTlwVKdByG2BM=
X-Google-Smtp-Source: APXvYqz9AgnO5wJDvm1Pg6p/ZgeOIqLXWnWPY63JzbbCx7GJI5f+EhGIc58hMebd7OYELWuIV0XCUg==
X-Received: by 2002:a17:902:9682:: with SMTP id n2mr10572124plp.52.1571416243179;
        Fri, 18 Oct 2019 09:30:43 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id u3sm6401575pfn.134.2019.10.18.09.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 09:30:42 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: khadas-vim3: move audio nodes to common dtsi
Date:   Fri, 18 Oct 2019 20:29:45 +0400
Message-Id: <1571416185-6449-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move VIM3 audio nodes to meson-khadas-vim3.dtsi to enable audio for all
boards in the VIM3 family including VIM3L.

This change depends on [1] being merged/applied first.

[1] https://patchwork.kernel.org/patch/11198535/

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi   | 89 ----------------------
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 88 +++++++++++++++++++++
 2 files changed, 88 insertions(+), 89 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index 69019d0..190e934 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -5,8 +5,6 @@
  * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
  */
 
-#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
-
 / {
 	vddcpu_a: regulator-vddcpu-a {
 		/*
@@ -45,69 +43,6 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
-
-	sound {
-		compatible = "amlogic,axg-sound-card";
-		model = "G12A-KHADAS-VIM3";
-		audio-aux-devs = <&tdmout_b>;
-		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
-				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
-				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
-				"TDM_B Playback", "TDMOUT_B OUT";
-
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-		status = "okay";
-
-		dai-link-0 {
-			sound-dai = <&frddr_a>;
-		};
-
-		dai-link-1 {
-			sound-dai = <&frddr_b>;
-		};
-
-		dai-link-2 {
-			sound-dai = <&frddr_c>;
-		};
-
-		/* 8ch hdmi interface */
-		dai-link-3 {
-			sound-dai = <&tdmif_b>;
-			dai-format = "i2s";
-			dai-tdm-slot-tx-mask-0 = <1 1>;
-			dai-tdm-slot-tx-mask-1 = <1 1>;
-			dai-tdm-slot-tx-mask-2 = <1 1>;
-			dai-tdm-slot-tx-mask-3 = <1 1>;
-			mclk-fs = <256>;
-
-			codec {
-				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
-			};
-		};
-
-		/* hdmi glue */
-		dai-link-4 {
-			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
-
-			codec {
-				sound-dai = <&hdmi_tx>;
-			};
-		};
-	};
-};
-
-&arb {
-	status = "okay";
-};
-
-&clkc_audio {
-	status = "okay";
 };
 
 &cpu0 {
@@ -152,18 +87,6 @@
 	clock-latency = <50000>;
 };
 
-&frddr_a {
-        status = "okay";
-};
-
-&frddr_b {
-	status = "okay";
-};
-
-&frddr_c {
-	status = "okay";
-};
-
 &pwm_ab {
 	pinctrl-0 = <&pwm_a_e_pins>;
 	pinctrl-names = "default";
@@ -179,15 +102,3 @@
 	clock-names = "clkin1";
 	status = "okay";
 };
-
-&tdmif_b {
-	status = "okay";
-};
-
-&tdmout_b {
-	status = "okay";
-};
-
-&tohdmitx {
-	status = "okay";
-};
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 90815fa..3f5c373 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
 	model = "Khadas VIM3";
@@ -76,6 +77,61 @@
 		clock-names = "ext_clock";
 	};
 
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "G12A-KHADAS-VIM3";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-4 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+
 	dc_in: regulator-dc_in {
 		compatible = "regulator-fixed";
 		regulator-name = "DC_IN";
@@ -171,6 +227,14 @@
 	};
 };
 
+&arb {
+	status = "okay";
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
 &cec_AO {
 	pinctrl-0 = <&cec_ao_a_h_pins>;
 	pinctrl-names = "default";
@@ -206,6 +270,18 @@
         amlogic,tx-delay-ns = <2>;
 };
 
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
@@ -328,6 +404,18 @@
 	vqmmc-supply = <&emmc_1v8>;
 };
 
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
+
 &uart_A {
 	status = "okay";
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
-- 
2.7.4

