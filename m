Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4230C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44FF21537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KOEh79CI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfENO1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:27:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35286 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfENO1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:27:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so3061816wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aD54kzlCgobh7qHLUEe+WoDY1KdxgWPEqEa9mzFDans=;
        b=KOEh79CIy13+6cKp1UGamcLZMvfjs68/Yk2B3MUVDuSF4J4W3UwhXzcIk5pA7PwLta
         b24QAdDTg1Y4tYwh9Ht2/XjNoEFD+G1fZIzvdJAnRp8okGbJJGLHjHgo9XyAOEsJ5+Gx
         n6WrHP0Ni0p5oQqcTMvr5F5Sm33GLpfv8vDAIDeuorCso9+gXWHs821EUQ7SxdjHYTSl
         5NPyWms9E/OEzMfPdQBqMS0xoYp74VZlAIYFSkCaX6Qioag/i+xN7wOPabdXg4qNmaxb
         AD+kMw6MnNVh3kUwAb55Mla2TUyAWTutP4F27nmu9pXmUdcT4w55ron8S8wHtbKSwReq
         ZnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aD54kzlCgobh7qHLUEe+WoDY1KdxgWPEqEa9mzFDans=;
        b=hXuPoeuoDR2NMjE7Zj2gsvuWyuDSb0MTbmvmN0YW43NJA1ywM3GtmYoehHKEvabO4f
         yj+YOEmTntgMTlM5/xGuo8fB6us7aQB7xNoLTvNh67E0UJKsrAXAI/njlyKxRzJzP9iC
         +ktK20DUuoxw5GqfYHJILEMmcAIsM1FggJlUcX0fbmsK+O/LNEqHGGP7ALv1c/dlnMBu
         9WcB8nINY/1fO5eiH0fbsfIiwYKoaBagjp88UZA6T3RA+PqpP8E7j5oLcXheBtsMgCMl
         xcm+Jw7zWwWcJzjVkX184Q/oTTFqAokGDzDBzkgdcGdSjiYXykt8ivev9XunEtVMXm8l
         A/pQ==
X-Gm-Message-State: APjAAAUYHec8t+qG/VAoC1Vndb/iHK8gQKyOBoxwBbhdKfXhY1A6xzlk
        y7vngvDlnw1+6AXBMHYrAcJPbqeJro8=
X-Google-Smtp-Source: APXvYqwK4fpNYfx0XX/6As+wbLsTZqCzYY6hOAul3bZH9nHtsvj5eaCsZ4zN30GUtxJIqXcp+mER9A==
X-Received: by 2002:a1c:a711:: with SMTP id q17mr18801730wme.146.1557844020875;
        Tue, 14 May 2019 07:27:00 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h15sm12343642wru.52.2019.05.14.07.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 07:26:59 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] arm64: dts: meson: g12a: add spdifouts
Date:   Tue, 14 May 2019 16:26:46 +0200
Message-Id: <20190514142649.1127-6-jbrunet@baylibre.com>
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

Add the devices nodes and pinctrl definitions for the spdif outputs of
the g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 60 +++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 40a82ddda79f..f25a7c7ed995 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -643,6 +643,33 @@
 						};
 					};
 
+					spdif_out_h_pins: spdif-out-h {
+						mux {
+							groups = "spdif_out_h";
+							function = "spdif_out";
+							drive-strength-microamp = <500>;
+							bias-disable;
+						};
+					};
+
+					spdif_out_a11_pins: spdif-out-a11 {
+						mux {
+							groups = "spdif_out_a11";
+							function = "spdif_out";
+							drive-strength-microamp = <500>;
+							bias-disable;
+						};
+					};
+
+					spdif_out_a13_pins: spdif-out-a13 {
+						mux {
+							groups = "spdif_out_a13";
+							function = "spdif_out";
+							drive-strength-microamp = <500>;
+							bias-disable;
+						};
+					};
+
 					tdm_a_din0_pins: tdm-a-din0 {
 						mux {
 							groups = "tdm_a_din0";
@@ -1312,6 +1339,18 @@
 					status = "disabled";
 				};
 
+				spdifout: audio-controller@480 {
+					compatible = "amlogic,g12a-spdifout",
+						     "amlogic,axg-spdifout";
+					reg = <0x0 0x480 0x0 0x50>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "SPDIFOUT";
+					clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+						 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+					clock-names = "pclk", "mclk";
+					status = "disabled";
+				};
+
 				tdmout_a: audio-controller@500 {
 					compatible = "amlogic,g12a-tdmout";
 					reg = <0x0 0x500 0x0 0x40>;
@@ -1353,6 +1392,18 @@
 						      "lrclk", "lrclk_sel";
 					status = "disabled";
 				};
+
+				spdifout_b: audio-controller@680 {
+					compatible = "amlogic,g12a-spdifout",
+						     "amlogic,axg-spdifout";
+					reg = <0x0 0x680 0x0 0x50>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "SPDIFOUT_B";
+					clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
+						 <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
+					clock-names = "pclk", "mclk";
+					status = "disabled";
+				};
 			};
 
 			usb3_pcie_phy: phy@46000 {
@@ -1506,6 +1557,15 @@
 						};
 					};
 
+					spdif_ao_out_pins: spdif-ao-out {
+						mux {
+							groups = "spdif_ao_out";
+							function = "spdif_ao_out";
+							drive-strength-microamp = <500>;
+							bias-disable;
+						};
+					};
+
 					tdm_ao_b_din1_pins: tdm-ao-b-din1 {
 						mux {
 							groups = "tdm_ao_b_din1";
-- 
2.20.1

