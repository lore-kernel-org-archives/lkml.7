Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD027C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C93218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="G5vXA9W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfL1U2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:28:43 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39284 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfL1U2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:28:42 -0500
Received: by mail-pj1-f66.google.com with SMTP id t101so6451823pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 12:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Yk+zLVsSDRHOg6D2iiMvRkTjejM32fOXnmZsURk2P4=;
        b=G5vXA9W8+N+c30YAoRsRVjmw7eyC3MnRCXaPm2xC2VrA9nuAWTaRKeP668iDDXlsQp
         9mCYnODGdPsm+TyobDSKsg463csJ1Ml3lvs+znsULMBUqvBMAeuF/9icWD4NxofqwLVs
         vt/NJ6KS3OHxgddv7DS1NbtcAqsu7U9JNxtPzSds+BzPXlCAq63f86WvfEUJ+316Ru5o
         IMcsmF4QkxidZhDJFqXfHPvYHKW79LAPDkON7RFFeyQOo5K3RqxLR5Qf8PCkYDwhxpDX
         L9bJQPjRKuo4eQJ+VQAW/LyP3ueIowuIt3sDR1mRIVQ5EdSrIknI5zioZC1TmqDTELYI
         u3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Yk+zLVsSDRHOg6D2iiMvRkTjejM32fOXnmZsURk2P4=;
        b=nWI7Mr1W118V2ZSsaGlvCGhpp0Nm8ZU0QYXBwGvGcsd9KM/3+3jSR58XmpPqDOSMYs
         iZAhAxUo2uMlHDAEjgnWwbLvbhXxQ6NloL9epuj2G9p/QKOnV24P0u4HcABfZIfXkcdV
         huZjp7E/8J9bb2Ax/XrjD0M5k+kICuIgrebjFzYxaIL15FRaiElgkBGXDh1ovEBA3B9p
         5K4TVobdP88PP7MHP1EE7SOlOZCwjWCyQKR6cHO+6/fpMBw9jv4GmET63ocKl+3wv/vb
         NziZ2LX2iFa7u0m/+701y805Jj+0w0+ZnX9DHX89tdbKCtunrQXF9h2/nCQunjzcFm2W
         EDnA==
X-Gm-Message-State: APjAAAUw7HkWqGlcKPym84/0FmO/rfB+su+kK2dIaPmhq9pHqX0uNRQj
        3Yv93O7AGMFluLIJD58Pf3PcIo9GiRY=
X-Google-Smtp-Source: APXvYqyruVeTsvVTDvongSk9hM3D2C2stILqnJN+fK1KyPNtx6Eg5fFFl8JDoutL2C1UUwygnykJIg==
X-Received: by 2002:a17:90a:25cb:: with SMTP id k69mr35247333pje.121.1577564921974;
        Sat, 28 Dec 2019 12:28:41 -0800 (PST)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id i68sm46771169pfe.173.2019.12.28.12.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:28:41 -0800 (PST)
From:   roman.stratiienko@globallogic.com
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [RFC 2/4] drm/sun4i: Use CRTC size instead of PRIMARY plane size as mixer frame.
Date:   Sat, 28 Dec 2019 22:28:16 +0200
Message-Id: <20191228202818.69908-3-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191228202818.69908-1-roman.stratiienko@globallogic.com>
References: <20191228202818.69908-1-roman.stratiienko@globallogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

According to DRM documentation the only difference between PRIMARY
and OVERLAY plane is that each CRTC must have PRIMARY plane and
OVERLAY are optional.

Allow PRIMARY plane to have dimension different from full-screen.

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c     |  4 +++
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 35 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 30 ----------------------
 drivers/gpu/drm/sun4i/sunxi_engine.h   |  8 ++++++
 4 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 3a153648b369..156ea8f19d7d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -139,8 +139,12 @@ static void sun4i_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
 	struct drm_encoder *encoder = sun4i_crtc_get_encoder(crtc);
 	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
+	struct sunxi_engine *engine = scrtc->engine;
 
 	sun4i_tcon_mode_set(scrtc->tcon, encoder, mode);
+
+	if (engine->ops->mode_set)
+		engine->ops->mode_set(engine, mode);
 }
 
 static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index eea4813602b7..bb9a665fd053 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -257,6 +257,40 @@ const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
 	return NULL;
 }
 
+static void sun8i_mode_set(struct sunxi_engine *engine,
+			   struct drm_display_mode *mode)
+{
+	u32 dst_w = mode->crtc_hdisplay;
+	u32 dst_h = mode->crtc_vdisplay;
+	u32 outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
+	bool interlaced = false;
+	u32 val;
+	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
+	u32 bld_base = sun8i_blender_base(mixer);
+
+	DRM_DEBUG_DRIVER("Mode change, updating global size W: %u H: %u\n",
+			 dst_w, dst_h);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_GLOBAL_SIZE,
+		     outsize);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), outsize);
+
+	interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE;
+
+	if (interlaced)
+		val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
+	else
+		val = 0;
+
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
+			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
+			   val);
+	DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
+			 interlaced ? "on" : "off");
+}
+
 static void sun8i_atomic_begin(struct sunxi_engine *engine,
 			       struct drm_crtc_state *old_state)
 {
@@ -325,6 +359,7 @@ static const struct sunxi_engine_ops sun8i_engine_ops = {
 	.commit		= sun8i_mixer_commit,
 	.layers_init	= sun8i_layers_init,
 	.atomic_begin	= sun8i_atomic_begin,
+	.mode_set	= sun8i_mode_set,
 };
 
 static struct regmap_config sun8i_mixer_regmap_config = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index c87fd842918e..893076716070 100644
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
diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
index 548710a936d5..9783c112d512 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -108,6 +108,14 @@ struct sunxi_engine_ops {
 	 * This function is optional.
 	 */
 	void (*vblank_quirk)(struct sunxi_engine *engine);
+
+	/**
+	 * @mode_set:
+	 *
+	 * This function is optional.
+	 */
+	void (*mode_set)(struct sunxi_engine *engine,
+			 struct drm_display_mode *mode);
 };
 
 /**
-- 
2.17.1

