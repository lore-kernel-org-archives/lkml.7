Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09415C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFACF21537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jEs81h1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfENO1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:27:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55691 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfENO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:27:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id x64so3099632wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVVyuMvOECdnykHOg06JMYBC0CP3Jj/vLDrIXkB+hBI=;
        b=jEs81h1ajv0Mq+rqCs5b30885SiDPdTBh3OyhKqv8gKw5qS8VuT6tBfJsEjItE8bdk
         VkeovzQsr+gFHJnI/NTPM2nkLtnTzRqm/QB8by757kG1YvJXF4trV1rBPldpQ6UcVbCz
         n/WI4tdrqWa4VWBwiMIA5hBUZcHXe9K50/XpMDTZGsWhOLxR75d5QQ3vj7FjepEnCzFy
         /DLfdwRT+MXvOGDmeqpDGwrPCqezrTuXJ9n4KYV6nqCs7b7VGcA/6fhX0keVsO3Ie7jf
         8JUFIX6riORBclj/D6TTo+HIQymhklyLbTHzJF/411jb/AolIDp/mLqYQ2clGfZstw+8
         P23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVVyuMvOECdnykHOg06JMYBC0CP3Jj/vLDrIXkB+hBI=;
        b=Vb5e6ZqNILYQkfG9ZkFlgoppIqSkmmX/5KxvHoaTKjr8KLqLynXexsiZFBO4lFAJ7b
         SMazNxF8ynwS2ylBhw9BBO/PHBb/0G8GvsKmmtsQ5PH8CK8LALGkaOUFmJmV/J4f4lju
         KYYWrU2ZI8YuyTYLJbFphi3rtGlpqUc+DC8tUIi2eA7KdNmVfrBBdvTmUFzRK3igfNHF
         B9G9FHEdeU9NSfSVaCzW8nsYiSLGhYarWw8c/Tlr4EtamTLzpublh8stVs0n/GSslfpE
         xS+QXa7ocyDo9rg8n6Y10NSsYCDbb0q8TqwovKlbfUSL48gLT11MBDFwEDq3Oo4kWY6T
         uKBw==
X-Gm-Message-State: APjAAAVD85nE+J+iZiIl3Qv7Bxw50HomoUX36dW9RnDFYQ+JJGpSkJBL
        b8t0eDeMAUy4oJ+iumA5zRRXuw==
X-Google-Smtp-Source: APXvYqxGAyi+CZ3nqvmR/sh1VIPkflen3Zz1B6mLaq7ed4bmv3GwqxMt+X2Q7sRF92Dx4Q75JgBZKw==
X-Received: by 2002:a1c:4145:: with SMTP id o66mr20386116wma.68.1557844022765;
        Tue, 14 May 2019 07:27:02 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h15sm12343642wru.52.2019.05.14.07.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 07:27:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] arm64: dts: meson: g12a: add spdifin
Date:   Tue, 14 May 2019 16:26:48 +0200
Message-Id: <20190514142649.1127-8-jbrunet@baylibre.com>
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

Add the spdif input device node and the pinctrl definition for
this capture interface g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 8dbdcbea5945..d6c6408281e9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -807,6 +807,30 @@
 						};
 					};
 
+					spdif_in_a10_pins: spdif-in-a10 {
+						mux {
+							groups = "spdif_in_a10";
+							function = "spdif_in";
+							bias-disable;
+						};
+					};
+
+					spdif_in_a12_pins: spdif-in-a12 {
+						mux {
+							groups = "spdif_in_a12";
+							function = "spdif_in";
+							bias-disable;
+						};
+					};
+
+					spdif_in_h_pins: spdif-in-h {
+						mux {
+							groups = "spdif_in_h";
+							function = "spdif_in";
+							bias-disable;
+						};
+					};
+
 					spdif_out_h_pins: spdif-out-h {
 						mux {
 							groups = "spdif_out_h";
@@ -1516,6 +1540,19 @@
 					status = "disabled";
 				};
 
+				spdifin: audio-controller@400 {
+					compatible = "amlogic,g12a-spdifin",
+						     "amlogic,axg-spdifin";
+					reg = <0x0 0x400 0x0 0x30>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "SPDIFIN";
+					interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
+						 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
+					clock-names = "pclk", "refclk";
+					status = "disabled";
+				};
+
 				spdifout: audio-controller@480 {
 					compatible = "amlogic,g12a-spdifout",
 						     "amlogic,axg-spdifout";
-- 
2.20.1

