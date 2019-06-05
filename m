Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D14C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D479220866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TVdJqRZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfFEONF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:13:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38652 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFEOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:12:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so19629791wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJV2EelmzwU1/yznyPFkc/fxpPopz48+1zy1DsarmDE=;
        b=TVdJqRZFfU5s0FX3DJNaUJBa2wh3dlpycCNSUJUcDpNztvmmX7eFg6a+jgjhjp3qbp
         gQHVEwCL4w4ZnmBCCNQOzLmQ0xRkyb0gjzO6PQfC1KWeuZVPLOTTJfFXgbJfkEgqNm0L
         WMPL2OgOFvdi39tuwXV61CrYn9Fl1MBkA6pFoEdnUXyk/pPydlqd/rJ+lc8ByEjTKuY3
         u2dE2rGaX0W+8/+nrwyyqMzgBV2jkkmvxPC6u82FSHu8rvUtIBZnlJDfCYmtP3A9B2H+
         FfqafncdaU4zneDGniLi5/V3HygLwRsR2wVPzsZBfwlD/LS/QOi259lfN7GnIZt5I0fq
         KxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJV2EelmzwU1/yznyPFkc/fxpPopz48+1zy1DsarmDE=;
        b=ViZVvYweVarq9MVcDSSQsdg79M9deT2ytFAoeskUAtu1chq+5c6FfN8lUMd7nOJoz3
         +mYaRJXxfTzArpLoDKGyyYVarHUeWd/Ullw+igwTbbqCbRlfCD5yPD32ANalFwFt45vl
         SLTcidrMQXMKoI8HnkaRs/SynU76K/qffK7FqgdPc1fg0aYvpqPM1sb39+8tdTTxEd2I
         Hu9nGVozK2LtrgZsmKV6UGd8SBckPc5w7ToiQ1BH8IEf9NHRkyDPy+P1wjROfJrcCZw7
         e2aoQqQ7UWLz3YKbRx5ftqMQXgzBObiDBUwA0rCnhWHv488/zLJpw+oqwpHeL7nwbvr2
         fx4w==
X-Gm-Message-State: APjAAAUEvQhMv402hCTO3Pz8U4FhwyWnJALGwVdRsNZmgVmoOUqpysmy
        dbQ0cP8o8Ni/mex9AJjGmrGB6xCBrpWYcg==
X-Google-Smtp-Source: APXvYqyfg6omR+ZPIC7qJMVZoiXxGQOWD9YskUpPvpHHMZWtFQOlsNcFXDkrbb+rAuRH69aSGBrBgA==
X-Received: by 2002:adf:a38d:: with SMTP id l13mr19424196wrb.187.1559743977659;
        Wed, 05 Jun 2019 07:12:57 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s8sm36292546wra.55.2019.06.05.07.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 07:12:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] drm/meson: fix G12A primary plane disabling
Date:   Wed,  5 Jun 2019 16:12:53 +0200
Message-Id: <20190605141253.24165-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605141253.24165-1-narmstrong@baylibre.com>
References: <20190605141253.24165-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The G12A Primary plane was disabled by writing in the OSD1 configuration
registers, but this caused the plane blender to stall instead of continuing
blended only the overlay plane.

Fix this by disabling the OSD1 plane in the blender registers, and also
enabling it back using the same register.

Fixes: 490f50c109d1 ("drm/meson: Add G12A support for OSD1 Plane")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c  | 2 ++
 drivers/gpu/drm/meson/meson_plane.c | 4 ++--
 drivers/gpu/drm/meson/meson_viu.c   | 3 +--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 50a9a96720b9..aa8ea107524e 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -252,6 +252,8 @@ static void meson_g12a_crtc_enable_osd1(struct meson_drm *priv)
 	writel_relaxed(priv->viu.osb_blend1_size,
 		       priv->io_base +
 		       _REG(VIU_OSD_BLEND_BLEND1_SIZE));
+	writel_bits_relaxed(3 << 8, 3 << 8,
+			    priv->io_base + _REG(OSD1_BLEND_SRC_CTRL));
 }
 
 static void meson_crtc_enable_vd1(struct meson_drm *priv)
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index b788280895c6..d90427b93a51 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -318,8 +318,8 @@ static void meson_plane_atomic_disable(struct drm_plane *plane,
 
 	/* Disable OSD1 */
 	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
-		writel_bits_relaxed(BIT(0) | BIT(21), 0,
-			priv->io_base + _REG(VIU_OSD1_CTRL_STAT));
+		writel_bits_relaxed(3 << 8, 0,
+				    priv->io_base + _REG(OSD1_BLEND_SRC_CTRL));
 	else
 		writel_bits_relaxed(VPP_OSD1_POSTBLEND, 0,
 				    priv->io_base + _REG(VPP_MISC));
diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
index 462c7cb3e1bd..4b2b3024d371 100644
--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -405,8 +405,7 @@ void meson_viu_init(struct meson_drm *priv)
 				0 << 16 |
 				1,
 				priv->io_base + _REG(VIU_OSD_BLEND_CTRL));
-		writel_relaxed(3 << 8 |
-				1 << 20,
+		writel_relaxed(1 << 20,
 				priv->io_base + _REG(OSD1_BLEND_SRC_CTRL));
 		writel_relaxed(1 << 20,
 				priv->io_base + _REG(OSD2_BLEND_SRC_CTRL));
-- 
2.21.0

