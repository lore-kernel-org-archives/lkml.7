Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E2EC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E602063F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="inHqWyGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfFXOs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:48:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55995 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFXOs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:48:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so13085423wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:references:reply-to:message-id:mime-version;
        bh=UMt++cTsArBAGUmiE11DFVbCwedH1LpEG4/Q9DpDY64=;
        b=inHqWyGqlHHjwmM2IYsNCD/MsgyfdYTrLzk+3/14SUcRm7zno7MrYbR3aodsqIjAn3
         IeuF0sDxXIiFH99RSnrhLSJe/NgB8CVlgY7gE8fhn+Sdnc5ZoFpJWgCqEPojyRBHfWH6
         +cu1hhckzF2ixsR/9rpc6ZwofJ8qPmd+EycT4nCJCQjK7uD5oCUtN9+q3vZhmTWNVcTh
         5sb0i1J7SUEPdcGuHnd9hAKpzyeI5Jl1IchELIP3wKdzMnpglQEH/bBIo/WUdiqfZHrU
         CdgVzc940BoUrjYeqZ2hOu+BnMJozAB5zRPpiYZyiLjaoSKeCSsAPKEqqsSPiiiSH+NE
         J9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:reply-to
         :message-id:mime-version;
        bh=UMt++cTsArBAGUmiE11DFVbCwedH1LpEG4/Q9DpDY64=;
        b=S0jMWRsb9A8K8kQ74iWX3mIMXTnogEksH6EuAfk3pBfki+cf7qMURCW50r9bTqk+69
         txnzX2x0MWduYGoWfwRKPopkhc2FXQpYi4YXG0OsdFt20J46SBWM2OzoZ+7BJ1NXf/Wm
         h9zIfoAe6KkufSKud3J5X07MLb0AUpAvXzwD4AYvHF54eDMdS9sr63cwfycouwiE0+3C
         23yLVZEQtlpbIK8zUi+vR1L6O5ml9ifAsfnDXzUikzmLbtVu9hSuiWvN9yYJ9fhuFMZg
         MJWgxIKkiWOdE47kEep3zzvjbJRQmNyJaX0tcjQ6SJA5BJFNxQM+4L1BgJQr93I8hVzw
         /cKA==
X-Gm-Message-State: APjAAAX6IB9lvgthXw9M/VFf2gOMgUKq6TqnwrgT/AfWRF85KgXbYUX6
        5QcARhDJbOQkZzFMhzUIVizt/Q==
X-Google-Smtp-Source: APXvYqx9J4gCSkHAg6MGMhOs0tRsAwYKg+4C5RM0USs3GmYYacCeQw4lM9p7rPy7v6pHwAFHGyek9Q==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr15433655wmk.99.1561387707268;
        Mon, 24 Jun 2019 07:48:27 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y18sm3311422wmi.23.2019.06.24.07.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:48:26 -0700 (PDT)
From:   Julien Masson <jmasson@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Julien Masson <jmasson@baylibre.com>
Subject: [PATCH 2/9] drm: meson: crtc: use proper macros instead of magic
 constants
Date:   Mon, 24 Jun 2019 16:48:12 +0200
References: <86zhm782g5.fsf@baylibre.com>
Reply-To: <86zhm782g5.fsf@baylibre.com>
Message-ID: <86wohb82fa.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add new macros which describe couple bits field of the
following registers:
- VD1_BLEND_SRC_CTRL
- VPP_SC_MISC

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c      | 17 +++++++++++------
 drivers/gpu/drm/meson/meson_registers.h | 16 ++++++++++++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index aa8ea107524e..6f7d6d258615 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -267,11 +267,11 @@ static void meson_crtc_enable_vd1(struct meson_drm *priv)
 
 static void meson_g12a_crtc_enable_vd1(struct meson_drm *priv)
 {
-	writel_relaxed(((1 << 16) | /* post bld premult*/
-			(1 << 8) | /* post src */
-			(1 << 4) | /* pre bld premult*/
-			(1 << 0)),
-			priv->io_base + _REG(VD1_BLEND_SRC_CTRL));
+	writel_relaxed(VD_BLEND_PREBLD_SRC_VD1 |
+		       VD_BLEND_PREBLD_PREMULT_EN |
+		       VD_BLEND_POSTBLD_SRC_VD1 |
+		       VD_BLEND_POSTBLD_PREMULT_EN,
+		       priv->io_base + _REG(VD1_BLEND_SRC_CTRL));
 }
 
 void meson_crtc_irq(struct meson_drm *priv)
@@ -489,7 +489,12 @@ void meson_crtc_irq(struct meson_drm *priv)
 		writel_relaxed(priv->viu.vd1_range_map_cr,
 				priv->io_base + meson_crtc->viu_offset +
 				_REG(VD1_IF0_RANGE_MAP_CR));
-		writel_relaxed(0x78404,
+		writel_relaxed(VPP_VSC_BANK_LENGTH(4) |
+			       VPP_HSC_BANK_LENGTH(4) |
+			       VPP_SC_VD_EN_ENABLE |
+			       VPP_SC_TOP_EN_ENABLE |
+			       VPP_SC_HSC_EN_ENABLE |
+			       VPP_SC_VSC_EN_ENABLE,
 				priv->io_base + _REG(VPP_SC_MISC));
 		writel_relaxed(priv->viu.vpp_pic_in_height,
 				priv->io_base + _REG(VPP_PIC_IN_HEIGHT));
diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index c7dfbd7454e5..55f5fe21ff5e 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -370,6 +370,12 @@
 #define VPP_HSC_REGION4_PHASE_SLOPE 0x1d17
 #define VPP_HSC_PHASE_CTRL 0x1d18
 #define VPP_SC_MISC 0x1d19
+#define		VPP_SC_VD_EN_ENABLE             BIT(15)
+#define		VPP_SC_TOP_EN_ENABLE            BIT(16)
+#define		VPP_SC_HSC_EN_ENABLE            BIT(17)
+#define		VPP_SC_VSC_EN_ENABLE            BIT(18)
+#define		VPP_VSC_BANK_LENGTH(length)     (length & 0x7)
+#define		VPP_HSC_BANK_LENGTH(length)     ((length & 0x7) << 8)
 #define VPP_PREBLEND_VD1_H_START_END 0x1d1a
 #define VPP_PREBLEND_VD1_V_START_END 0x1d1b
 #define VPP_POSTBLEND_VD1_H_START_END 0x1d1c
@@ -1638,6 +1644,16 @@
 #define VPP_SLEEP_CTRL 0x1dfa
 #define VD1_BLEND_SRC_CTRL 0x1dfb
 #define VD2_BLEND_SRC_CTRL 0x1dfc
+#define		VD_BLEND_PREBLD_SRC_VD1         (1 << 0)
+#define		VD_BLEND_PREBLD_SRC_VD2         (2 << 0)
+#define		VD_BLEND_PREBLD_SRC_OSD1        (3 << 0)
+#define		VD_BLEND_PREBLD_SRC_OSD2        (4 << 0)
+#define		VD_BLEND_PREBLD_PREMULT_EN      BIT(4)
+#define		VD_BLEND_POSTBLD_SRC_VD1        (1 << 8)
+#define		VD_BLEND_POSTBLD_SRC_VD2        (2 << 8)
+#define		VD_BLEND_POSTBLD_SRC_OSD1       (3 << 8)
+#define		VD_BLEND_POSTBLD_SRC_OSD2       (4 << 8)
+#define		VD_BLEND_POSTBLD_PREMULT_EN     BIT(16)
 #define OSD1_BLEND_SRC_CTRL 0x1dfd
 #define OSD2_BLEND_SRC_CTRL 0x1dfe
 
-- 
2.17.1

