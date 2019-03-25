Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D19C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEF82084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ND+Gvnaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfCYOTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:19:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50653 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbfCYOSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:18:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so9194277wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mq/UIbvc1VH7PugMYnYCEBeubA/5Z+FgxVasF/ac/OU=;
        b=ND+GvnaqVVGlVr0XaByEEGP6PJvVtB9/A70ah1Rmg8gqdoNtvw/DvF0tUPIiLX11Ey
         /YGgmN8dUSpBGNtNY1M1sZZtzbv5SFaT5ENjKgi8H60rc5tcvYsq96i9JbfAJk6MFV3h
         P2gqQEmJ1y87kW4B98Ryf+eC4xJU/KilukOFVNOzDNgvST5Rm+2p5yrBaGwStmSnQGll
         pRvGH3V06GxfR21rju0CB2mg67pF9T6dPNTGl8Z8e/z1BkgsaHZp+BueuxW1bDQReBvA
         +oXrPAylPxnW+ZnHtnTE0AsFtL0KoZV1D3goUbThGir8nS/u8uL5NPntYqOFl10ly2Wj
         JCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mq/UIbvc1VH7PugMYnYCEBeubA/5Z+FgxVasF/ac/OU=;
        b=MYSC8hNC5tf2/pNqHgnB/B9Heg6eEAwjnFjBbvdnsGBGVR00G/6Km+XdGdjzECN4h9
         u5mxxhe/R97SimVR/2wYFySR/XR2IOoeXc7jhi5i/4Cl2F1oRFM52G9U8zkkin+paP0+
         T+fFZl/1hXobXjVLP5xPJZOSR2H1k2FNNu0ewMZf6dit9awqW2E3rxc8+JP0yYIAgpgS
         5/u5qhrjzVEe3Od5HnbZJqUU2TUSi+5WfAECRWgDOqGOr3spzRj0kZiq7Id4/bwC7IlY
         M3E4/PZonWFwgkmpfuKwBAtOazSOV388vfTUEcjq5WP/VBgfuKPrfi/chp7TPLX+g0In
         s79A==
X-Gm-Message-State: APjAAAXkV9WrPDkq9G0l9Zk++K2oxKW5Y3jrXHFRyRGDTek4Jjmur34N
        y7JwRVRN7NvWgit2O1wJXFu8KOyVZDKDdQ==
X-Google-Smtp-Source: APXvYqzCAegsJLzwZTFBlTsOhiLLdBsaUVSPYOKUkSGj6Z5TjxTPmk2wc7VuF19lL/gpqI0cM7qeMw==
X-Received: by 2002:a1c:415:: with SMTP id 21mr12357938wme.109.1553523517400;
        Mon, 25 Mar 2019 07:18:37 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 132sm26976794wmd.30.2019.03.25.07.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:18:36 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] drm/meson: Add G12A support for CVBS Encoer
Date:   Mon, 25 Mar 2019 15:18:21 +0100
Message-Id: <20190325141824.21259-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325141824.21259-1-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson G12A SoCs uses the exact same CVBS encoder except a simple
CVBS DAC register offset and settings delta.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_venc.c      | 11 +++++++++--
 drivers/gpu/drm/meson/meson_venc_cvbs.c | 25 ++++++++++++++++++-------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 66d73a932d19..6faca7313339 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -73,7 +73,9 @@
 /* HHI Registers */
 #define HHI_GCLK_MPEG2		0x148 /* 0x52 offset in data sheet */
 #define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
+#define HHI_VDAC_CNTL0_G12A	0x2EC /* 0xbd offset in data sheet */
 #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
+#define HHI_VDAC_CNTL1_G12A	0x2F0 /* 0xbe offset in data sheet */
 #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 offset in data sheet */
 
 struct meson_cvbs_enci_mode meson_cvbs_enci_pal = {
@@ -1675,8 +1677,13 @@ void meson_venc_disable_vsync(struct meson_drm *priv)
 void meson_venc_init(struct meson_drm *priv)
 {
 	/* Disable CVBS VDAC */
-	regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0);
-	regmap_write(priv->hhi, HHI_VDAC_CNTL1, 8);
+	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
+		regmap_write(priv->hhi, HHI_VDAC_CNTL0_G12A, 0);
+		regmap_write(priv->hhi, HHI_VDAC_CNTL1_G12A, 8);
+	} else {
+		regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0);
+		regmap_write(priv->hhi, HHI_VDAC_CNTL1, 8);
+	}
 
 	/* Power Down Dacs */
 	writel_relaxed(0xff, priv->io_base + _REG(VENC_VDAC_SETTING));
diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meson/meson_venc_cvbs.c
index d622d817b6df..2c5341c881c4 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
@@ -37,7 +37,9 @@
 
 /* HHI VDAC Registers */
 #define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
+#define HHI_VDAC_CNTL0_G12A	0x2EC /* 0xbd offset in data sheet */
 #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
+#define HHI_VDAC_CNTL1_G12A	0x2F0 /* 0xbe offset in data sheet */
 
 struct meson_venc_cvbs {
 	struct drm_encoder	encoder;
@@ -166,8 +168,13 @@ static void meson_venc_cvbs_encoder_disable(struct drm_encoder *encoder)
 	struct meson_drm *priv = meson_venc_cvbs->priv;
 
 	/* Disable CVBS VDAC */
-	regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0);
-	regmap_write(priv->hhi, HHI_VDAC_CNTL1, 8);
+	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
+		regmap_write(priv->hhi, HHI_VDAC_CNTL0_G12A, 0);
+		regmap_write(priv->hhi, HHI_VDAC_CNTL1_G12A, 0);
+	} else {
+		regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0);
+		regmap_write(priv->hhi, HHI_VDAC_CNTL1, 8);
+	}
 }
 
 static void meson_venc_cvbs_encoder_enable(struct drm_encoder *encoder)
@@ -179,13 +186,17 @@ static void meson_venc_cvbs_encoder_enable(struct drm_encoder *encoder)
 	/* VDAC0 source is not from ATV */
 	writel_bits_relaxed(BIT(5), 0, priv->io_base + _REG(VENC_VDAC_DACSEL0));
 
-	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
+	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
 		regmap_write(priv->hhi, HHI_VDAC_CNTL0, 1);
-	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
-		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
+		regmap_write(priv->hhi, HHI_VDAC_CNTL1, 0);
+	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
+		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
 		regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0xf0001);
-
-	regmap_write(priv->hhi, HHI_VDAC_CNTL1, 0);
+		regmap_write(priv->hhi, HHI_VDAC_CNTL1, 0);
+	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
+		regmap_write(priv->hhi, HHI_VDAC_CNTL0_G12A, 0x906001);
+		regmap_write(priv->hhi, HHI_VDAC_CNTL1_G12A, 0);
+	}
 }
 
 static void meson_venc_cvbs_encoder_mode_set(struct drm_encoder *encoder,
-- 
2.21.0

