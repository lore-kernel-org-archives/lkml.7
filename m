Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F60C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F52C20684
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HHYoHbnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfLRPq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:46:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50235 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfLRPqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:46:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so2343992wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 07:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HYTni/YaBkgYSQUn7nXBaoqEYGtf4zrlvskOsHha/TE=;
        b=HHYoHbnhUWLFFtVMUKXFDrSEywXbuf608rVEp57miIwEjlpxnsvNbm1u8VukondcRV
         9flKq3octdI14JuIpljxK99P8A6DckOYeaNUjPPleS+9+uaanNayErhrj30E+X2BnvQV
         /liqc6+Ayuz45jEXIcrRRX40LKqfDEtzL7VL3/qr91f5UsWU7pA5ck0tVzdRX0LZuuOE
         REf+UqGMpTVgTmvX3dsYnq1Uc4Ey5uvP7cGQrUFknZM/tKGsNGU8TvTt7wsX759bp77Z
         EDjl2ocu9PjPbSP2reodNoZ6Ju/FSLjVQlFV7ZeC8AW1GAp63Km+K0Qu58aL+MQpXjnC
         XD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYTni/YaBkgYSQUn7nXBaoqEYGtf4zrlvskOsHha/TE=;
        b=BodJnVF/VjPD3vMzXIjEe4yaV+cZr8YcFNb45luEy2kSGvDM0TaS+BGXLbJOd5xc0z
         PH6reivEZvDBJGZ6IZKmxpx5j13kA9FsNm9R/0SI6bf6XkfmO0LWRQITbBXNM3453nZx
         syljrvV5k1kcwMUiF58sTsPwLmwxdbvlUW3Trkb+vdVECilEs2nkVCXMSer5tsABqA4l
         SCGm1HlD+FXWznTbtK2eEyGYmsMzHgywOHdXVIY1NHV4+IQUwJWE5dp6j0cVl1el32cF
         gVxfnPc4BDEv+1rBRrfdxgLT/j0ebVriYTdPacu3vhhUJ2BTNs4NQt20GESSEyzfOEBB
         xN/w==
X-Gm-Message-State: APjAAAVw0SuG1xLnD8hrlh0VvoaUtm6Mz8soqpg35ffJ3a2h2rv0XvR6
        L/LfC7p6SjewbIaCEbEYkCTBmg==
X-Google-Smtp-Source: APXvYqxa+ljjpYhoTTPolZyT1O82GeyIErtwIxBIE6ffnaCrj6aZtlCicLWADM3U6oPJnQUwthrdUQ==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr3800521wme.133.1576684005160;
        Wed, 18 Dec 2019 07:46:45 -0800 (PST)
Received: from bender.baylibre.local (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id x1sm2891492wru.50.2019.12.18.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 07:46:44 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/10] drm/meson: venc: make drm_display_mode const
Date:   Wed, 18 Dec 2019 16:46:32 +0100
Message-Id: <20191218154637.17509-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191218154637.17509-1-narmstrong@baylibre.com>
References: <20191218154637.17509-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before switching to bridge funcs, make sure drm_display_mode is passed
as const to the venc functions.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 2 +-
 drivers/gpu/drm/meson/meson_venc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 4efd7864d5bf..a9ab78970bfe 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -946,7 +946,7 @@ bool meson_venc_hdmi_venc_repeat(int vic)
 EXPORT_SYMBOL_GPL(meson_venc_hdmi_venc_repeat);
 
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
-			      struct drm_display_mode *mode)
+			      const struct drm_display_mode *mode)
 {
 	union meson_hdmi_venc_mode *vmode = NULL;
 	union meson_hdmi_venc_mode vmode_dmt;
diff --git a/drivers/gpu/drm/meson/meson_venc.h b/drivers/gpu/drm/meson/meson_venc.h
index 576768bdd08d..1abdcbdf51c0 100644
--- a/drivers/gpu/drm/meson/meson_venc.h
+++ b/drivers/gpu/drm/meson/meson_venc.h
@@ -60,7 +60,7 @@ extern struct meson_cvbs_enci_mode meson_cvbs_enci_ntsc;
 void meson_venci_cvbs_mode_set(struct meson_drm *priv,
 			       struct meson_cvbs_enci_mode *mode);
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
-			      struct drm_display_mode *mode);
+			      const struct drm_display_mode *mode);
 unsigned int meson_venci_get_field(struct meson_drm *priv);
 
 void meson_venc_enable_vsync(struct meson_drm *priv);
-- 
2.22.0

