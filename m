Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885ECC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC2320896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="H1Rp4asA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391024AbfFKObZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:31:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55643 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389253AbfFKObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:31:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so3198189wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I+b0ODQnts8tdntKoRjN83DkfLZxsjTT5tP4ANFK0k4=;
        b=H1Rp4asAc/hZnrIK3cSDkXVRv+QZjJckPEeF2q/uTMemu80KOX67ebHjCifYvVvnHK
         qlpRK/E+rZUqmXitAbYXycopEbSc1T02FYsVbUdbaCJeqXKwM1IGM8EaWjmVe6eGuBDC
         xooTOTX4XsptGZOm9gumVueKn7ZlQ44b2Q9Lemy51VObASpSRRyaP76mHUBSDzjvYVtl
         6l/XuxLLT1FfuXmrWk6UEIcFg5MeCHSJjE/AcvtvhPdyDdsL5YbiNO9PLJCmv526UZIZ
         2DtX3zCDbQAhrA5gD8F+xvVHvWv9iynL4BmgoEId1oJZispnKUNwCoFd+uFFavMjuqE5
         LnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I+b0ODQnts8tdntKoRjN83DkfLZxsjTT5tP4ANFK0k4=;
        b=Z8HPn1HU5bZN/lWxzsFLmbmOKksSKqqNlnhZaLjhwrui6HONoKRAhkCex+g9Jls88j
         rhnbG1JwcisWA3ONl40R6vdbZx3NQX8fqDRa4wlalRDzJzLvb6knmVcfUbPAzZaHnrGw
         xCJKLH8aY5p0vCQEKnMVwjay3N33ncbT1JkcXvKzHD7Ssqq91Mg6tWy5AVvjAU3dAzrr
         XA28OEXzVqCNhFEJ0cJw1KoyTgc023KwKOVP21CLiOf06CKvoZ5nHeccup9vjmCOmJb8
         hzlvPfIEUeThVAeIGAy3Vwdzu1j4hQWt5piQOvsxjmaF4nVEp8n2PJs2lNMisa68dib6
         VbcA==
X-Gm-Message-State: APjAAAXjwAGc53G+eoLxqiGBRU95XECEORYSQOWi3QscgdSU+WTmkvXm
        jtX2yoexjxaDAN/TGhcJr5Ym9yuF85BEjg==
X-Google-Smtp-Source: APXvYqx5tAOnKxTMOzMeeFvPPj0lnS6ngD12iizSOqlCEd/5eXH8GUPWfzhko832DOcAeL8z5bH+xg==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr17212929wmc.98.1560263482948;
        Tue, 11 Jun 2019 07:31:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w14sm13427258wrk.44.2019.06.11.07.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 07:31:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-g12b-odroid-n2: add sound card
Date:   Tue, 11 Jun 2019 16:31:20 +0200
Message-Id: <20190611143120.25074-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the sound card on the Hardkernel Odroid-N2, enabling HDMI output
using the TDM interface B, being aligned on other boards sound cards.

The internal DAC connected to the audio jack will be added later on, when
driver support is added.

Tested by running:
tinymix set "FRDDR_A SRC 1 EN Switch" 1
tinymix set "FRDDR_A SINK 1 SEL" "OUT 1"
tinymix set "FRDDR_B SRC 1 EN Switch" 1
tinymix set "FRDDR_B SINK 1 SEL" "OUT 1"
tinymix set "FRDDR_C SRC 1 EN Switch" 1
tinymix set "FRDDR_C SINK 1 SEL" "OUT 1"
tinymix set "TOHDMITX I2S SRC" "I2S B"
tinymix set "TOHDMITX Switch" 1

then:
tinymix set "TDMOUT_B SRC SEL" "IN 0"
speaker-test -Dhw:0,0 -c2

then:
tinymix set "TDMOUT_B SRC SEL" "IN 1"
speaker-test -Dhw:0,1 -c2

then:
tinymix set "TDMOUT_B SRC SEL" "IN 2"
speaker-test -Dhw:0,2 -c2

testing HDMI audio output from the all 3 ASoC playback interfaces.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 4146cd84989c..c3e0735e6d9f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -9,6 +9,7 @@
 #include "meson-g12b.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
 	compatible = "hardkernel,odroid-n2", "amlogic,g12b";
@@ -165,6 +166,65 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "G12A-ODROIDN2";
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
+};
+
+&arb {
+	status = "okay";
 };
 
 &cec_AO {
@@ -181,6 +241,10 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc_audio {
+	status = "okay";
+};
+
 &ext_mdio {
 	external_phy: ethernet-phy@0 {
 		/* Realtek RTL8211F (0x001cc916) */	
@@ -198,6 +262,18 @@
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
 &gpio {
 	/*
 	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
@@ -269,6 +345,18 @@
 	vqmmc-supply = <&flash_1v8>;
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
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.21.0

