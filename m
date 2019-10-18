Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260E9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A9621D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsGuiiyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633249AbfJRKGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:06:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44521 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfJRKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:06:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id e10so3085373pgd.11;
        Fri, 18 Oct 2019 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0eiHvls0Nus4fxRx6FaGv3bpIKyYEdO98HSCYTKm7Gw=;
        b=nsGuiiycXx2WSdCzMwM7OGdczvN4PM5MqGuNK5KbBK+mP6CsDDjlfBKO8iOB7zaLQW
         jGoS/VU1QmMNOP59S1QiR2CTOneuCyCtsYTCKHNVT5sBT3J44P+GmLqQ3T1hLMbz2qHR
         CKSQquvIQQZTIYmJx1WEhCU3YJYbZwdsJUHSFRQX3/T5relvq932rSmQB4A1aBGZvWxk
         Ef2bVxtZC+5hgrsqvB53rI9BxWYsFCVTF3BHt98UG+ith0nm1zYvqDP29WwAvasRpRII
         GAQ3CsfXbpDqiodJLTpnL98azqjUuCnqUhjMGCJc8J3Aq6bnSgStIauiU9Uxh6tiQaqU
         f/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0eiHvls0Nus4fxRx6FaGv3bpIKyYEdO98HSCYTKm7Gw=;
        b=aG4JH/qT0sIVGtCvkjFDJsE9KoLJrOsL3iNT3iu7ywj9qPWOIKZcFLOZOyzqwwpkoE
         39YxQuz45x2UNfY1IQ0PGPMXGg8KznIc2SlO8C1/a+oiJCgOF+2B5KtCkUqlb14UOqUW
         ilzaY6vbgQtIVnOVkZwwusCgAognb+ofVKwBXmi+jUpLv2tMvf+biZ4ziCmbpCtSsy0y
         v1cT96hSXb+ivMreNxmyreOmM+OwsA2JspmjKAlChy24dR79vn+KKtv0kugolC4NzAXq
         gVExJWw6H7QweiVAklYc8D+fYj2z6cSbe06zO/jv3sENo+5GYB7XXjodpB6i3FIj7seH
         fhRw==
X-Gm-Message-State: APjAAAWbNdSE2BdznyDYFEEPFKUm0/ncRypJLAdmgPt6RFjTfbGaB4YC
        tpPMXv3jRgDkCPyomEes+vg=
X-Google-Smtp-Source: APXvYqx70UPWeYUMTbnQAuBkpbFgsYi5YR99nRWGb7ZPCImvo6SlfmyLcPJ5O9X29TjUttG7WWpTOQ==
X-Received: by 2002:aa7:9d89:: with SMTP id f9mr5918915pfq.25.1571393210682;
        Fri, 18 Oct 2019 03:06:50 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id a11sm5361901pfo.165.2019.10.18.03.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 03:06:49 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: khadas-vim3l: enable audio
Date:   Fri, 18 Oct 2019 14:05:52 +0400
Message-Id: <1571393152-3698-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and enable the audio nodes on the VIM3L. This is based on the recent
submission for the SEI610 device [1] and the existing VIM3 dts.

[1] https://patchwork.kernel.org/patch/11180785/

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts    | 147 +++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index dbbf29a..d07f0cf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -8,6 +8,7 @@
 
 #include "meson-sm1.dtsi"
 #include "meson-khadas-vim3.dtsi"
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
 	compatible = "khadas,vim3l", "amlogic,sm1";
@@ -31,6 +32,86 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "SM1-KHADAS-VIM3L";
+		audio-aux-devs = <&tdmout_a>, <&tdmout_b>,
+				 <&tdmin_a>, <&tdmin_b>;
+		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
+				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
+				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
+				"TDM_A Playback", "TDMOUT_A OUT",
+				"TDMOUT_B IN 0", "FRDDR_A OUT 1",
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
+		dai-link-3 {
+			sound-dai = <&toddr_a>;
+		};
+
+		dai-link-4 {
+			sound-dai = <&toddr_b>;
+		};
+
+		dai-link-5 {
+			sound-dai = <&toddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-6 {
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
+		dai-link-7 {
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
+};
+
+&clkc_audio {
+	status = "okay";
 };
 
 &cpu0 {
@@ -61,6 +142,24 @@
 	clock-latency = <50000>;
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
+&pdm {
+	pinctrl-0 = <&pdm_din0_z_pins>, <&pdm_dclk_z_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &pwm_AO_cd {
 	pinctrl-0 = <&pwm_ao_d_e_pins>;
 	pinctrl-names = "default";
@@ -93,3 +192,51 @@
 	phy-names = "usb2-phy0", "usb2-phy1";
 };
  */
+
+&tdmif_a {
+	pinctrl-0 = <&tdm_a_dout0_pins>, <&tdm_a_fs_pins>, <&tdm_a_sclk_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	assigned-clocks = <&clkc_audio AUD_CLKID_TDM_SCLK_PAD0>,
+			  <&clkc_audio AUD_CLKID_TDM_LRCLK_PAD0>;
+	assigned-clock-parents = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
+				 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
+	assigned-clock-rates = <0>, <0>;
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmin_a {
+	status = "okay";
+};
+
+&tdmin_b {
+	status = "okay";
+};
+
+&tdmout_a {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&toddr_a {
+	status = "okay";
+};
+
+&toddr_b {
+	status = "okay";
+};
+
+&toddr_c {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
-- 
2.7.4

