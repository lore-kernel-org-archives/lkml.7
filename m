Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B60C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B907E22CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BWvA+DXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfHTMQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:16:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44552 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfHTMQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:16:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so12137612wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnR9ChYVU8O+i3bYKzGbLSAIGaOskKWlzWch3oWoNOg=;
        b=BWvA+DXF2PFrqpA6tZJHFq7nR9yfwe/0u9Ij/N5eFgiYjUv8D9Z4es148NNh9LSZPZ
         B+0oBFL9yPknk0aBg8SbPO+hamtpxAOoinXsPf43PXdAnNwYE00TUQxDLSU7YVlmYldB
         mfR4VpD25/jAr3z+/KN5ulB+vopEZfDxqu+YcO3tkbRfATOgxfBgIWnLsP/rwubTQ396
         Q4JdEH/IMl/MVSOQi/Ne4Kcf+Zl4WxJBMQHc3mYFim8uly4RwHBfVUDtv6Ajp0864Bex
         IrvL2jFem8UOsUmfb8FCBf8oLFgGRFPkq5YVslI4prFHyGDMLjIbr1pH8bH8Ft62MZ6s
         WSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnR9ChYVU8O+i3bYKzGbLSAIGaOskKWlzWch3oWoNOg=;
        b=RS+A0+iA8+Fllxk0/eTatoJv4SSxwJoKB2olVx5VDxDVY4A8PFx/WrwX0gCw699/PR
         LVceaqBTmsJ9UszC3WWdpmmYV53CxpTcLwOj4Xa/XcvMDKEzVTnWGuexnhapkKIoXZbR
         9XGKQggkslxVO80l8Z9TEIjMalS0/JzS3GvXhNkWQLcwiWAD5J0CEmEO5RUCma/rb30D
         Nc4o3SxaMOAXvrli1TZf5zUq2R76zmZ7FdH1I0JCnvHWGScyZTfzd8ojYobtAfbNjC4T
         DC6WDfZ6rEe77MwtKTORnEp5TBR/lSrvkrt6NnC7E35BjhGpG/Sxjo5gnrtmhEMK4S6q
         Di5Q==
X-Gm-Message-State: APjAAAWwHbrBntKxDwOl8Rjj9iBfmaJ1O+qSuB/lbW9Id3DEUxWgLHkR
        RJBADoxMg7I+jlsvjwJv95RIRQ==
X-Google-Smtp-Source: APXvYqwHGjcYBEoTrPSJsH8MuNivQ+r9SE1SUyAlPciAw2hwxMjvVeiIhgl387dz61rK7Jk/uvgQKQ==
X-Received: by 2002:adf:9043:: with SMTP id h61mr26994971wrh.247.1566303358128;
        Tue, 20 Aug 2019 05:15:58 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h23sm15300765wml.43.2019.08.20.05.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 05:15:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: meson: g12a: add reset to tdm formatters
Date:   Tue, 20 Aug 2019 14:15:51 +0200
Message-Id: <20190820121551.18398-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820121551.18398-1-jbrunet@baylibre.com>
References: <20190820121551.18398-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset to the TDM formatters of the g12a. This helps
with channel mapping when a playback/capture uses more than 1 lane.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 8eb92edb7a66..c8b9b9754598 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
+#include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 
 / {
@@ -1586,6 +1587,7 @@
 						     "amlogic,axg-tdmin";
 					reg = <0x0 0x300 0x0 0x40>;
 					sound-name-prefix = "TDMIN_A";
+					resets = <&clkc_audio AUD_RESET_TDMIN_A>;
 					clocks = <&clkc_audio AUD_CLKID_TDMIN_A>,
 						 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK_SEL>,
@@ -1601,6 +1603,7 @@
 						     "amlogic,axg-tdmin";
 					reg = <0x0 0x340 0x0 0x40>;
 					sound-name-prefix = "TDMIN_B";
+					resets = <&clkc_audio AUD_RESET_TDMIN_B>;
 					clocks = <&clkc_audio AUD_CLKID_TDMIN_B>,
 						 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK_SEL>,
@@ -1616,6 +1619,7 @@
 						     "amlogic,axg-tdmin";
 					reg = <0x0 0x380 0x0 0x40>;
 					sound-name-prefix = "TDMIN_C";
+					resets = <&clkc_audio AUD_RESET_TDMIN_C>;
 					clocks = <&clkc_audio AUD_CLKID_TDMIN_C>,
 						 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK_SEL>,
@@ -1631,6 +1635,7 @@
 						     "amlogic,axg-tdmin";
 					reg = <0x0 0x3c0 0x0 0x40>;
 					sound-name-prefix = "TDMIN_LB";
+					resets = <&clkc_audio AUD_RESET_TDMIN_LB>;
 					clocks = <&clkc_audio AUD_CLKID_TDMIN_LB>,
 						 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK_SEL>,
@@ -1670,6 +1675,7 @@
 					compatible = "amlogic,g12a-tdmout";
 					reg = <0x0 0x500 0x0 0x40>;
 					sound-name-prefix = "TDMOUT_A";
+					resets = <&clkc_audio AUD_RESET_TDMOUT_A>;
 					clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
 						 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
@@ -1684,6 +1690,7 @@
 					compatible = "amlogic,g12a-tdmout";
 					reg = <0x0 0x540 0x0 0x40>;
 					sound-name-prefix = "TDMOUT_B";
+					resets = <&clkc_audio AUD_RESET_TDMOUT_B>;
 					clocks = <&clkc_audio AUD_CLKID_TDMOUT_B>,
 						 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK_SEL>,
@@ -1698,6 +1705,7 @@
 					compatible = "amlogic,g12a-tdmout";
 					reg = <0x0 0x580 0x0 0x40>;
 					sound-name-prefix = "TDMOUT_C";
+					resets = <&clkc_audio AUD_RESET_TDMOUT_C>;
 					clocks = <&clkc_audio AUD_CLKID_TDMOUT_C>,
 						 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK_SEL>,
-- 
2.21.0

