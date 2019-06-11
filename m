Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA72AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E05A2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WKdhki1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390953AbfFKPBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:01:05 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44030 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390815AbfFKPBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:01:05 -0400
Received: by mail-wr1-f51.google.com with SMTP id p13so3323705wru.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 08:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LS1+C4j2F7W6ilf2eBKpP0ZKig6OXeQOhXQaBYt1hck=;
        b=WKdhki1juLhcCa5wpk1ESoCclWVrErpi/0yvDFp476eFD/E5kmbiOROhhMtzTfmJ1u
         8uKiywQOCn4E8zh6Lp+1nErgGvALF2F3JwxMQjpT/md1xDCdGAdfbngCEVL8Bwl7uMcQ
         lPmeDsIrz1wepOdKs5sxPwXE2kDw9tEQrdSmq54QyIX4L8AxUrde1HxyhpQxt2bqx8t9
         85zi7idAVgMj8LMMZl/O6PX3sPVRx/qDKjJ6NRgUwdSEtiFX/Xtwa6c9MF9LYW30qnyJ
         a1exKEPE75R+a+g1VqymEY99BQNWijLhuB4+Xm6wT18j/Q4o+KUWErRIyxY8tk0K8ymV
         pzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LS1+C4j2F7W6ilf2eBKpP0ZKig6OXeQOhXQaBYt1hck=;
        b=rGHqq6kudnPGPor8uveNqStAWIU7TeYbRYbHMM9zQZ16bHIvnSbDe6hKRfKj4Z0nbv
         v0triatlzXbYcah28wPNvC6Ahp85sWTPEu5oedlIInbSVCA1M2K0EsPkptVTMzgwZAxg
         SPM1CxNcYaP/Og1earm1aGbpYsH2I+iJL/NATduTnexqSH5zrYunpkpJl/zKPtMqKEhE
         RVZZQd97NU+EWIu3gjsMwP4tfO26AioxE9yBOHf6K87rzj7hmrKtQXt+CkKL5J4NuDDe
         oCoXelXekhEqpc9BGgveWSPrtImayU6k7S48G6fhxk01uI7El593ggY4g/qAH83Qyd2R
         WsQg==
X-Gm-Message-State: APjAAAV2zCsWCm4DcjYWMPfoHAuBbj4CX8E1e0fkr6jeCb/DTmTr1F6p
        +QK3X24wV3zFpjQAqTq5luz/cg==
X-Google-Smtp-Source: APXvYqyErh566p9vxT/Qrd+SE/n9noin+Y3QQR9MYAqHTGhePIe+WMxEJJ1KiXbXUe0FbidyCKBISQ==
X-Received: by 2002:adf:b643:: with SMTP id i3mr22720790wre.284.1560265263059;
        Tue, 11 Jun 2019 08:01:03 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p3sm17395635wrd.47.2019.06.11.08.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 08:01:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-g12a-x96-max: add sound card
Date:   Tue, 11 Jun 2019 17:01:01 +0200
Message-Id: <20190611150101.30413-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the sound card on the X96 Max, enabling HDMI output using the
TDM interface B, being aligned on other boards sound cards.
SPDI/F support is also enabled to the physical toslink port and to HDMI.

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
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 98bc56e650a0..d37868d21114 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -8,6 +8,7 @@
 #include "meson-g12a.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
 	compatible = "amediatech,x96-max", "amlogic,u200", "amlogic,g12a";
@@ -17,6 +18,14 @@
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
 	};
+
+	spdif_dit: audio-codec-1 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -123,6 +132,86 @@
 		regulator-always-on;
 	};
 
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "G12A-X96-MAX";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT",
+				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
+				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
+				"SPDIFOUT IN 2", "FRDDR_C OUT 3";
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
+		/* spdif hdmi or toslink interface */
+		dai-link-4 {
+			sound-dai = <&spdifout>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+
+			codec-1 {
+				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_A>;
+			};
+		};
+
+		/* spdif hdmi interface */
+		dai-link-5 {
+			sound-dai = <&spdifout_b>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-6 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+
 	wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
@@ -131,6 +220,10 @@
 	};
 };
 
+&arb {
+	status = "okay";
+};
+
 &cec_AO {
 	pinctrl-0 = <&cec_ao_a_h_pins>;
 	pinctrl-names = "default";
@@ -145,12 +238,28 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc_audio {
+	status = "okay";
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
 	};
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
@@ -287,3 +396,25 @@
 	vmmc-supply = <&vcc_3v3>;
 	vqmmc-supply = <&flash_1v8>;
 };
+
+&spdifout {
+	pinctrl-0 = <&spdif_out_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&spdifout_b {
+	status = "okay";
+};
+
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
-- 
2.21.0

