Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4264CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FC62147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OVd3mubC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfENLP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:15:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39659 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfENLPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:15:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so2369455wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7vP7ano274I5qllq8uR+bb2yaN49Q2MfmDUFqT17hQ=;
        b=OVd3mubCMUTqHvkWZ1yO5YL6jSiUiT0CiIuHO+TVYnWoTSXS3T+ZvIqfBjrfg4+C0i
         L0IbguyctOYwSwIQvOv3QqGnZPaqyRB11hXneqhEkPSsZ6BwXF41Tor0duUYpBymFnF1
         VDdB1fram1a+h23hONf5xImxteD61e4zE9ixjCZyzQz/3QMiWPEAmFqGavKHTBv63t6j
         fr63qMUzn+hROUR5ACPsRB2mapvHZNNIPsE29eWWPmwVEAHykG762g/bxkK97VMENjb9
         5uV/ZhzR2pshQwm4DKJ2Cvc1ShKD1xUH4Kg323TNcnW7viXQ9gyDJeE4NXD2pwk/pLgb
         sdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7vP7ano274I5qllq8uR+bb2yaN49Q2MfmDUFqT17hQ=;
        b=Cp+VYTUjO7q7Std5h5eYH4hLySg+cIAcXj07lW26zj2mEjWmmR8GqV+hC/KviiooBk
         HVFQHjh1ItistQi/niYTX+fTkwRAxLIqG/IVdAE87JmiM2O24XK3/c/26XWeC3YPFjqj
         dwHq+r+UzKE+o0e4a3ErDDKAJyYjhvMcqqrYzklPHeYHcyo8MeOHnSeFRUU+Kii9idJA
         fwmwOzm86CUMkltcnkiVlT1Ur0f8XUodTOwuo0M4xdtI3qVqoAQWmR1vHpB9UfgykB/n
         1wN7BAxCg+VqvUaGPfxyan++f1PrhJR/T9IIUx5yzpDVUtZOHCjnsyGcPuPwVX/CdYhc
         uYsw==
X-Gm-Message-State: APjAAAUaCUu/xP8meX0XKSZxK+nat+5ZXQmukiqzvsYJyS/cFcgFrkVZ
        WAm0DjjNfUyESeOwpqYGm9uy+Q==
X-Google-Smtp-Source: APXvYqzLV2B5k5JA2BgrDhqWVYRsgPWNEuwYFiZF6d+rNSDWWoh8bflZCjj+KvkRcJp6N1peF/vPAg==
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr7531000wmj.127.1557832520316;
        Tue, 14 May 2019 04:15:20 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c130sm7289922wmf.47.2019.05.14.04.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 04:15:19 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] arm64: dts: meson: g12a: add audio fifos
Date:   Tue, 14 May 2019 13:15:05 +0200
Message-Id: <20190514111510.23299-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514111510.23299-1-jbrunet@baylibre.com>
References: <20190514111510.23299-1-jbrunet@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 67 +++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 2d5bccad4035..299df8131a0c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/g12a-aoclkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 
 / {
@@ -709,6 +710,72 @@
 					resets = <&reset RESET_AUDIO>;
 				};
 
+				toddr_a: audio-controller@100 {
+					compatible = "amlogic,g12a-toddr";
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
+					compatible = "amlogic,g12a-toddr";
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
+					compatible = "amlogic,g12a-toddr";
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
+					compatible = "amlogic,g12a-frddr";
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
+					compatible = "amlogic,g12a-frddr";
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
+					compatible = "amlogic,g12a-frddr";
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

