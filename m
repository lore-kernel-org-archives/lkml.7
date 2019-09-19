Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0231C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9948C20665
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="JbDMEkS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390364AbfISMh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:37:26 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:40841 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388184AbfISMh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:37:26 -0400
Received: by mail-pl1-f180.google.com with SMTP id d22so1560683pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 05:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6LDBRrb741uRZQWWifLKcAE5mlP2qAYLvuSILAF6V7s=;
        b=JbDMEkS/D3wwcWoQzSid2paeiT7H5GTfzuQxa+OukdL4cxsoRD3SSUdxSYCsZ1AHLv
         sUc7gFRS3TwYzmvqgZkQdcf45VCETLiaIstVnhnFuHP9qwPlqfjGklM4Svy8Mi00sPQs
         z9fnIZnPEVnslSuZl32kDfoacPNBDkYuB+UOAYXq8NBSa5uviz83DoG0fyLVu46qaNvl
         OWwjpsyOyBw444XJcpsg7drg70rehkqCVL8q/1kSmZKIOTVZKhLqmS156wMbD1OfcrUv
         KbtqDI+vo14DiROG3r6BotFD4Ri6HOUUwMZtwFMphRIcRjulDwggdumT0EmA1EKzaAX1
         SBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6LDBRrb741uRZQWWifLKcAE5mlP2qAYLvuSILAF6V7s=;
        b=uKJI5o1s8Rlc0A0JENkc55j+nKAosI/eGJdq6F9a9kX07rEa1Bh5hg5Urzp8UQpBdV
         I/6WRskuf/qFFjCgwQ0/KTS7PDqLrTJQYFgY7hqrEqQnBy/aw8SofLVQNitcHpk3ZJl7
         ce9c9JJeHc5Qf8/McwogtUfq+98XZK2PRWMD4Xo4+jBnEcpQVcUz7DLH3nlI0Qvpw3iF
         2SnVoA/6ewRGF5JiDijHhroEZqaeCQnl5zNg0GuKVjnAl4ms440ymsCUkoyY24bIFeOj
         fB7tjfUWkknsaQNCtWC2rHWMQV1Uq3SAT8XQk8DfKdVC6wr60gQFxiH8UZXFgmVEkPAW
         j5Kg==
X-Gm-Message-State: APjAAAV/wAp6VZqo4u7g3z+h/vYEVMcstc8b8CpzDfLcXypdauAtyBws
        FMP3cVXvTilXg3+hu7S5RuUTCHPSWFw=
X-Google-Smtp-Source: APXvYqzAvtQfrx/ahz3Jk+jKLkiNFz6Js60/zOlIiGdj5VyBrqbcy2rX4o0FBuNX09e8cEO1TeD64A==
X-Received: by 2002:a17:902:9888:: with SMTP id s8mr8762684plp.25.1568896644871;
        Thu, 19 Sep 2019 05:37:24 -0700 (PDT)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id 2sm11029800pfa.43.2019.09.19.05.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 05:37:24 -0700 (PDT)
From:   roman.stratiienko@globallogic.com
To:     linux-kernel@vger.kernel.org, mripard@kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH] drm/sun4i: Use vi plane as primary
Date:   Thu, 19 Sep 2019 15:37:03 +0300
Message-Id: <20190919123703.8545-1-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

DE2.0 blender does not take into the account alpha channel of vi layer.
Thus makes overlaying of this layer totally opaque.
Using vi layer as bottom solves this issue.

Tested on Android.

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 33 -----------------------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 36 +++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index dd2a1c851939..25183badc85f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -99,36 +99,6 @@ static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	insize = SUN8I_MIXER_SIZE(src_w, src_h);
 	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
 
-	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
-		bool interlaced = false;
-		u32 val;
-
-		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
-				 dst_w, dst_h);
-		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_GLOBAL_SIZE,
-			     outsize);
-		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), outsize);
-
-		if (state->crtc)
-			interlaced = state->crtc->state->adjusted_mode.flags
-				& DRM_MODE_FLAG_INTERLACE;
-
-		if (interlaced)
-			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
-		else
-			val = 0;
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
-				   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
-				   val);
-
-		DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
-				 interlaced ? "on" : "off");
-	}
-
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
 			 state->src.x1 >> 16, state->src.y1 >> 16);
@@ -349,9 +319,6 @@ struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 	if (!layer)
 		return ERR_PTR(-ENOMEM);
 
-	if (index == 0)
-		type = DRM_PLANE_TYPE_PRIMARY;
-
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun8i_ui_layer_funcs,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 07c27e6a4b77..49c4074e164f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -116,6 +116,36 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	insize = SUN8I_MIXER_SIZE(src_w, src_h);
 	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
 
+	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
+		bool interlaced = false;
+		u32 val;
+
+		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
+				 dst_w, dst_h);
+		regmap_write(mixer->engine.regs,
+			     SUN8I_MIXER_GLOBAL_SIZE,
+			     outsize);
+		regmap_write(mixer->engine.regs,
+			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), outsize);
+
+		if (state->crtc)
+			interlaced = state->crtc->state->adjusted_mode.flags
+				& DRM_MODE_FLAG_INTERLACE;
+
+		if (interlaced)
+			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
+		else
+			val = 0;
+
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
+				   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
+				   val);
+
+		DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
+				 interlaced ? "on" : "off");
+	}
+
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
 			 (state->src.x1 >> 16) & ~(format->hsub - 1),
@@ -445,6 +475,7 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 					       struct sun8i_mixer *mixer,
 					       int index)
 {
+	enum drm_plane_type type = DRM_PLANE_TYPE_OVERLAY;
 	struct sun8i_vi_layer *layer;
 	unsigned int plane_cnt;
 	int ret;
@@ -453,12 +484,15 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 	if (!layer)
 		return ERR_PTR(-ENOMEM);
 
+	if (index == 0)
+		type = DRM_PLANE_TYPE_PRIMARY;
+
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun8i_vi_layer_funcs,
 				       sun8i_vi_layer_formats,
 				       ARRAY_SIZE(sun8i_vi_layer_formats),
-				       NULL, DRM_PLANE_TYPE_OVERLAY, NULL);
+				       NULL, type, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
 		return ERR_PTR(ret);
-- 
2.17.1

