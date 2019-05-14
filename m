Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AB2C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE6921473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hoXJ+nK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfENO1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:27:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43684 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfENO1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:27:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so19450425wro.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Wh5aMQ4F/bP0rvTCc7Ak9+RHCVx6Dozll392sEPsfQ=;
        b=hoXJ+nK2lN8v/fVuoSDRsSP9X7D7ccCtD9GeraOWqvUdWAY+PP2hF8mgYifUkcWJkJ
         A3SRNJZs2ohyxY5YQqZ7ehMClvYojld6W8mi9DDPHGVRuDXbO5mw2F8SbMMmGhktesoI
         PKvzb5uYq7UUmvsLV3VluPtZsiZty74dQgs4YOIssP3T2R2SZPr+wFr2yS3IeNGOGc0+
         p6uGuFEQq6IG264WIk/rRMhwnj0M+MeBX5Go2DMy2UeGjltc4zJuw6TBCQ/a3L5JDkNz
         s4zC1V7l+D4IhNNM3IhQLWyNHWtI7DkikDp7Y0y9AkFLSZrRVDLjVdeYK8md7NpbYEgt
         M4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Wh5aMQ4F/bP0rvTCc7Ak9+RHCVx6Dozll392sEPsfQ=;
        b=HwBkj43dbWnPBOTNsM3M4L+T1/QRwmvJ+ZtyClr7dxqJY4hiyVC90QiaAnBMCb/fRP
         x5362pJDQJ50O4/UIYsDFYI5QjN9PaabDew8yFbAoFQXlMxQxUe5juT3v3cZ/9eKkgyd
         n5xLpwgPqnwNKbV64B57Rp0l1eDeXoFuPNBOeWdY0fF5+WBza/deqGGouiHeO+g1iF43
         VBIUz+ZkMsfnoPvgaqEqz6HBQZPN0gFOQXRE2tFexJQI0E4r+MryzYe7KivMAUMqwCJT
         MrqwjSlSOXDytFLqPS/OTfLciohqT1azSjSSigIdt13G4oCzu3Y44VtK9LRzkgOIES9h
         mwng==
X-Gm-Message-State: APjAAAXZExC7tP6+VXH/d2mHIvLSsYOmPtAeMYERlKYZIbd0BLphu3ON
        JHv6FabHBuXXmx7YsvAw/WbYWg==
X-Google-Smtp-Source: APXvYqyY1krpO0emuUR+p8nuZY9Ra8UaKZhh2UNOCbDEgluRVL+XBYCJ31ff7IDL0yBhDpxg77IvpA==
X-Received: by 2002:adf:f74a:: with SMTP id z10mr270724wrp.291.1557844018518;
        Tue, 14 May 2019 07:26:58 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h15sm12343642wru.52.2019.05.14.07.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 07:26:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] arm64: dts: meson: g12a: add audio fifos
Date:   Tue, 14 May 2019 16:26:44 +0200
Message-Id: <20190514142649.1127-4-jbrunet@baylibre.com>
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

Add the playback and capture memory interfaces of the g12a SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 73 +++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 2d5bccad4035..935a84b9f836 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/g12a-aoclkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 
 / {
@@ -709,6 +710,78 @@
 					resets = <&reset RESET_AUDIO>;
 				};
 
+				toddr_a: audio-controller@100 {
+					compatible = "amlogic,g12a-toddr",
+						     "amlogic,axg-toddr";
+					reg = <0x0 0x100 0x0 0x1c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "TODDR_A";
+					interrupts = <GIC_SPI 148 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_TODDR_A>;
+					resets = <&arb AXG_ARB_TODDR_A>;
+					status = "disabled";
+				};
+
+				toddr_b: audio-controller@140 {
+					compatible = "amlogic,g12a-toddr",
+						     "amlogic,axg-toddr";
+					reg = <0x0 0x140 0x0 0x1c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "TODDR_B";
+					interrupts = <GIC_SPI 149 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_TODDR_B>;
+					resets = <&arb AXG_ARB_TODDR_B>;
+					status = "disabled";
+				};
+
+				toddr_c: audio-controller@180 {
+					compatible = "amlogic,g12a-toddr",
+						     "amlogic,axg-toddr";
+					reg = <0x0 0x180 0x0 0x1c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "TODDR_C";
+					interrupts = <GIC_SPI 150 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_TODDR_C>;
+					resets = <&arb AXG_ARB_TODDR_C>;
+					status = "disabled";
+				};
+
+				frddr_a: audio-controller@1c0 {
+					compatible = "amlogic,g12a-frddr",
+						     "amlogic,axg-frddr";
+					reg = <0x0 0x1c0 0x0 0x1c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "FRDDR_A";
+					interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+					resets = <&arb AXG_ARB_FRDDR_A>;
+					status = "disabled";
+				};
+
+				frddr_b: audio-controller@200 {
+					compatible = "amlogic,g12a-frddr",
+						     "amlogic,axg-frddr";
+					reg = <0x0 0x200 0x0 0x1c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "FRDDR_B";
+					interrupts = <GIC_SPI 153 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_FRDDR_B>;
+					resets = <&arb AXG_ARB_FRDDR_B>;
+					status = "disabled";
+				};
+
+				frddr_c: audio-controller@240 {
+					compatible = "amlogic,g12a-frddr",
+						     "amlogic,axg-frddr";
+					reg = <0x0 0x240 0x0 0x1c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "FRDDR_C";
+					interrupts = <GIC_SPI 154 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_FRDDR_C>;
+					resets = <&arb AXG_ARB_FRDDR_C>;
+					status = "disabled";
+				};
+
 				arb: reset-controller@280 {
 					status = "disabled";
 					compatible = "amlogic,meson-axg-audio-arb";
-- 
2.20.1

