Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F6C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE30721473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PIwE79co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfENO11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:27:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42915 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfENO1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:27:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so19450940wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UiaVyfOL73xkXYf2uJjieahrgB1t1Do944eA1pOwmA=;
        b=PIwE79cod1lccflCI19QyYhFpzoS2dui0oJV9kti+3tHtL5N+nJhczAQfM1xVqcnFK
         tM97KfWK28/CO9CdADKqNMfk5Qek+bgl8UB4JI4Jl20/wwHiTrxNnBBpkxejCA06kX4A
         QbIlwqquaa5t156HH+Sa/3jDOPHdCQa+XxebBmj6cejCZ/NS4v6wHVdxKBV4//h4UHhw
         WwybeNuoAnex38cjreKRy57iFjBehXeNbH6BsVVqAYwkxd+PXJuEsy8sfAJLZCq/09/2
         WOJGIqdVMn1YepcIM0sfUcaL2Y6dPKcH/EoeMT76jIvkfaGkJSNCpKRfNzCS7OA46//V
         ul1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UiaVyfOL73xkXYf2uJjieahrgB1t1Do944eA1pOwmA=;
        b=E0oL2IcjPpnMP8DI4wkuBcCrG5DJbGxTYzIKGBoHlkKIlz+9hEIa5OcQecbHnZTyRj
         WJq0RHw5UFK8mov4qo1ZiT3sGN7CygDWYjp00+VwV7Q3ex6XCgtBWQzc8DM8TeUuv2v+
         NNAvUdAJMjcjAvCqtNgkxOTEk4b04GHLAUSRoWNIgwprMxmDbxn6vjqKdLDKcZFFW/18
         hY6mlkGUUC5Kq5i8IMPP+9ahatR82FOHgdgFxkqJ0dTYKHCEA29jiFPWNrNBMUxkioTe
         jB/c72n66PYW7o7jaR3v+kCjLbh2aulWGNHnmXEWoHxxvE0YckwmeEvPpBT6Rw+yp5zy
         MXFA==
X-Gm-Message-State: APjAAAWJQkRArRZDYywtkUESbpglLIdBWqs3g9axGZD/bNiZul8EnAPD
        cebBdUcAUFXYX451ywQRgpQnzQ==
X-Google-Smtp-Source: APXvYqw5fO7c8RNHMpxo+PX9iqfcPie/9aLysADsb/eHUy3PI2oKG/eECkpIwCqdyTsmZfreK7En4Q==
X-Received: by 2002:a5d:53c3:: with SMTP id a3mr2557545wrw.60.1557844021823;
        Tue, 14 May 2019 07:27:01 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h15sm12343642wru.52.2019.05.14.07.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 07:27:01 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] arm64: dts: meson: g12a: add pdm
Date:   Tue, 14 May 2019 16:26:47 +0200
Message-Id: <20190514142649.1127-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514142649.1127-1-jbrunet@baylibre.com>
References: <20190514142649.1127-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pdm device node and the pinctrl definition for this capture
interface g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 177 ++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index f25a7c7ed995..8dbdcbea5945 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -497,6 +497,170 @@
 						};
 					};
 
+					pdm_din0_a_pins: pdm-din0-a {
+						mux {
+							groups = "pdm_din0_a";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din0_c_pins: pdm-din0-c {
+						mux {
+							groups = "pdm_din0_c";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din0_x_pins: pdm-din0-x {
+						mux {
+							groups = "pdm_din0_x";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din0_z_pins: pdm-din0-z {
+						mux {
+							groups = "pdm_din0_z";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din1_a_pins: pdm-din1-a {
+						mux {
+							groups = "pdm_din1_a";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din1_c_pins: pdm-din1-c {
+						mux {
+							groups = "pdm_din1_c";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din1_x_pins: pdm-din1-x {
+						mux {
+							groups = "pdm_din1_x";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din1_z_pins: pdm-din1-z {
+						mux {
+							groups = "pdm_din1_z";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din2_a_pins: pdm-din2-a {
+						mux {
+							groups = "pdm_din2_a";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din2_c_pins: pdm-din2-c {
+						mux {
+							groups = "pdm_din2_c";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din2_x_pins: pdm-din2-x {
+						mux {
+							groups = "pdm_din2_x";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din2_z_pins: pdm-din2-z {
+						mux {
+							groups = "pdm_din2_z";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din3_a_pins: pdm-din3-a {
+						mux {
+							groups = "pdm_din3_a";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din3_c_pins: pdm-din3-c {
+						mux {
+							groups = "pdm_din3_c";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din3_x_pins: pdm-din3-x {
+						mux {
+							groups = "pdm_din3_x";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din3_z_pins: pdm-din3-z {
+						mux {
+							groups = "pdm_din3_z";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_dclk_a_pins: pdm-dclk-a {
+						mux {
+							groups = "pdm_dclk_a";
+							function = "pdm";
+							bias-disable;
+							drive-strength-microamp = <500>;
+						};
+					};
+
+					pdm_dclk_c_pins: pdm-dclk-c {
+						mux {
+							groups = "pdm_dclk_c";
+							function = "pdm";
+							bias-disable;
+							drive-strength-microamp = <500>;
+						};
+					};
+
+					pdm_dclk_x_pins: pdm-dclk-x {
+						mux {
+							groups = "pdm_dclk_x";
+							function = "pdm";
+							bias-disable;
+							drive-strength-microamp = <500>;
+						};
+					};
+
+					pdm_dclk_z_pins: pdm-dclk-z {
+						mux {
+							groups = "pdm_dclk_z";
+							function = "pdm";
+							bias-disable;
+							drive-strength-microamp = <500>;
+						};
+					};
+
 					pwm_a_pins: pwm-a {
 						mux {
 							groups = "pwm_a";
@@ -1164,6 +1328,19 @@
 				};
 			};
 
+			pdm: audio-controller@40000 {
+				compatible = "amlogic,g12a-pdm",
+					     "amlogic,axg-pdm";
+				reg = <0x0 0x40000 0x0 0x34>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "PDM";
+				clocks = <&clkc_audio AUD_CLKID_PDM>,
+					 <&clkc_audio AUD_CLKID_PDM_DCLK>,
+					 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
+				clock-names = "pclk", "dclk", "sysclk";
+				status = "disabled";
+			};
+
 			audio: bus@42000 {
 				compatible = "simple-bus";
 				reg = <0x0 0x42000 0x0 0x2000>;
-- 
2.20.1

