Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57B6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A639E21473
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E8jD+2dg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfD2Hwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:52:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55250 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfD2Hwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:52:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so949353wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+GdzCUbXbc9TnjbK+IzgC3Rn7LJK/U+L3O1XBIq//I=;
        b=E8jD+2dgpZNlzi2mli6iSqHgtX8ej4k2fD+p50X7E9LOuOgNBJ8gjAiK/IBRlJ+3OM
         /ezhla4lzKCiT7PZUIbPtAXYRSXzCpZOCkroWKcKrh8BWQv4R5GbvbhvcB1fx7/d8FSy
         G4CAF6FAJedyge2rIG6AwicnNEPM8G73yQvzHGrBoS+jwiRcXIKSh6VbwpVAZ0l4VTNI
         wok7bVcf5eQrVfmQTxDMGjxS30rWsNi12GwMpYTMAgbocRh2CqzeZWkF+rgUFVyywy24
         Im77RGr1kKsu0YTlS+T2nujXKe01K7Q05lij2Nt6vydzWaZfM69r7GVKjGUj5UymDHbh
         +GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+GdzCUbXbc9TnjbK+IzgC3Rn7LJK/U+L3O1XBIq//I=;
        b=EUWXQIsiz4Ti0IkSH8OfjocEX4TQv/53F6wYhBoH43i5RXJLfvFszQNZjhtWnu4O9I
         NtKgor6rFVPoKYw2M7WgDuNtpdLJfAmlcGuGLZ1MrblK+qykxT3AihoFL5PRTZAAoXaJ
         Pgf1eeWSRM5/Vez9JFtZge9tjD5/AcTyY5sdUT7K/AhNSideTp4ZfXzwlnxD9HkjOmZj
         CelLrFaYpBKusO81cjTn3TIesorp2hUU10Rv+i83DmQrcFKKith4WQMfJZcJaYIhKxE2
         USEeza9DCpgoMAli+7bYAa4SQjuWfXtXmngqhkSKFGF1ZnoebSOkSQILcUOYnR8RPXVM
         93aw==
X-Gm-Message-State: APjAAAXzbNWhr6H5jbS5+ebabhWG+NNUGdRqbBhK5nIYOfu5EQZ9reCn
        NUwthe4Uox66pHxPkMr2cJqipA==
X-Google-Smtp-Source: APXvYqyrm9gcWdptLmdNHOe30KFoldLfiJoNxGhNez9U3SHQHqIDbxiDVW0eb3kiP7omvUckOLprWA==
X-Received: by 2002:a1c:495:: with SMTP id 143mr8270669wme.109.1556524360393;
        Mon, 29 Apr 2019 00:52:40 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q4sm5118457wrg.24.2019.04.29.00.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Apr 2019 00:52:39 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: Add support for XBGR8888 & ABGR8888 formats
Date:   Mon, 29 Apr 2019 09:52:38 +0200
Message-Id: <20190429075238.7884-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing XBGR8888 & ABGR8888 formats variants from the primary plane.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_plane.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index bf8f1fab63aa..b8f6b08a89a6 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -165,6 +165,13 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 		priv->viu.osd1_blk0_cfg[0] |= OSD_BLK_MODE_32 |
 					      OSD_COLOR_MATRIX_32_ARGB;
 		break;
+	case DRM_FORMAT_XBGR8888:
+		/* For XRGB, replace the pixel's alpha by 0xFF */
+		writel_bits_relaxed(OSD_REPLACE_EN, OSD_REPLACE_EN,
+				    priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
+		priv->viu.osd1_blk0_cfg[0] |= OSD_BLK_MODE_32 |
+					      OSD_COLOR_MATRIX_32_ABGR;
+		break;
 	case DRM_FORMAT_ARGB8888:
 		/* For ARGB, use the pixel's alpha */
 		writel_bits_relaxed(OSD_REPLACE_EN, 0,
@@ -172,6 +179,13 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 		priv->viu.osd1_blk0_cfg[0] |= OSD_BLK_MODE_32 |
 					      OSD_COLOR_MATRIX_32_ARGB;
 		break;
+	case DRM_FORMAT_ABGR8888:
+		/* For ARGB, use the pixel's alpha */
+		writel_bits_relaxed(OSD_REPLACE_EN, 0,
+				    priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
+		priv->viu.osd1_blk0_cfg[0] |= OSD_BLK_MODE_32 |
+					      OSD_COLOR_MATRIX_32_ABGR;
+		break;
 	case DRM_FORMAT_RGB888:
 		priv->viu.osd1_blk0_cfg[0] |= OSD_BLK_MODE_24 |
 					      OSD_COLOR_MATRIX_24_RGB;
@@ -356,7 +370,9 @@ static const struct drm_plane_funcs meson_plane_funcs = {
 
 static const uint32_t supported_drm_formats[] = {
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_RGB888,
 	DRM_FORMAT_RGB565,
 };
-- 
2.21.0

