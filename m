Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60A4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9776820748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="UKIGdyeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfL2Q2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 11:28:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34850 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfL2Q2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 11:28:43 -0500
Received: by mail-lf1-f68.google.com with SMTP id 15so23835034lfr.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 08:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YDi4HdMysGRM8s0IhMdcvep0qFVY46yMMK0CNGUMKC4=;
        b=UKIGdyeGYAMK/Yl5SzaPlADo8nmQRdXOHKigATiaPmqmnMg2PThphSIIfMmi/R4Lyr
         hRiDdU4DacewK7feLahMi980IXzXGJW3QWc3jaCXPgfiKDWHUKmuBySCkeLU4os0K5UM
         OaLZkzMBRlkf7P2o63kvyoCaYOs+Ae1jcw79YuYd1cZfv06jDp9a0uT+hUWqfYaDtk3U
         O/ZNVyD7EvIYXlC4ssXOfLKvj506q3GX8M7ppIRn6zuBdxGQR8SicA2KB5eIrIvgICBL
         mP5mKmPJrfS6Zu3H3fBcldhxoEOAEQjMDl7ILW25b6ulE0+TxwjPWOxKU6JZFV5uWBSR
         fPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YDi4HdMysGRM8s0IhMdcvep0qFVY46yMMK0CNGUMKC4=;
        b=GG7PmADPgjhgpe1PoqilsgjrDDIrCW5m1x8hW3IRVpXiwnwFx04yhZxwsSVCkYqjg2
         fdS/mVEjS6izRNtZf/4VvTCK2RrJ5Dtx6GKcT1b0QWfFUHbK5PpIdO/hWpDpauhjYhXj
         1ds1uBvVoAgsLzQrsPngfN61pIDCXPMP81cJfuPU82ugvFDyupHRI7xC6syB5vnjrgSu
         nYLRLcu0UZEoAewGjh4tRH0Ptv/IaP61b53nFrnCfdu2pnHwjujrkLVtgrRRfLYOjnWC
         Hty/oe0x7Eqy21l8Iv++EKgTJNs1SmhN6plO4/8u4SeZhNDm6tAgi+SetUVeQdr1BY0t
         UQcA==
X-Gm-Message-State: APjAAAX8tKk/rn+ALfPxTFabpBcW0ezfg0QHbOckMz+GtIeKqZ58TLlK
        kFiWS4cz3m+zPedbQv/2C9S5i6U25ik=
X-Google-Smtp-Source: APXvYqw2JVEohx/4FZnWa4O+A2iv0zaqqfekLuiGeRhn/2Fb2KJWFsoWzV4lFS9OEk0gP6Gebbnllw==
X-Received: by 2002:a19:c648:: with SMTP id w69mr35074878lff.44.1577636917897;
        Sun, 29 Dec 2019 08:28:37 -0800 (PST)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id u13sm17284858lfq.19.2019.12.29.08.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 08:28:37 -0800 (PST)
From:   roman.stratiienko@globallogic.com
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH v2 1/4] drm/sun4i: Reimplement plane z position setting logic
Date:   Sun, 29 Dec 2019 18:28:25 +0200
Message-Id: <20191229162828.3326-1-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

To set blending channel order register software needs to know state and
position of each channel, which impossible at plane commit stage.

Move this procedure to atomic_flush stage, where all necessary information
is available.

Fixes: f88c5ee77496 ("drm/sun4i: Implement zpos for DE2")
Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
v2:
- Use SUN8I_MIXER_MAX_LAYERS macro
- Use plane_cnt instead of hard-coded number
- Put initialization of channel_zpos into for loop
- Add 'Fixes' line to the commit message
- Minor clean-ups
- Comments added
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 52 +++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  5 +++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 42 +++------------------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 39 +++----------------
 4 files changed, 66 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 8b803eb903b8..d306ad5dc093 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -259,8 +259,54 @@ const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
 
 static void sun8i_mixer_commit(struct sunxi_engine *engine)
 {
-	DRM_DEBUG_DRIVER("Committing changes\n");
+	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
+	u32 base = sun8i_blender_base(mixer);
+	int i, j = 0;
+	int channel_by_zpos[SUN8I_MIXER_MAX_LAYERS];
+	u32 route = 0, pipe_ctl = 0;
+	int plane_cnt = mixer->cfg->vi_num + mixer->cfg->ui_num;
+
+	DRM_DEBUG_DRIVER("Update blender routing\n");
+	/* Assume that values in mixer->channel_zpos[] are unique except -1 */
+
+	for (i = 0; i < plane_cnt; i++)
+		channel_by_zpos[i] = -1;
 
+	/* Sort by zpos */
+	for (i = 0; i < plane_cnt; i++)	{
+		int zpos = mixer->channel_zpos[i];
+
+		if (zpos >= 0 && zpos < plane_cnt)
+			channel_by_zpos[zpos] = i;
+	}
+
+	/* Route enabled blending channels first */
+	for (i = 0; i < plane_cnt; i++)	{
+		int ch = channel_by_zpos[i];
+
+		if (ch >= 0) {
+			pipe_ctl |= SUN8I_MIXER_BLEND_PIPE_CTL_EN(j);
+			route |= ch << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(j);
+			j++;
+		}
+	}
+
+	/* Set remaining routing fields to match disabled channel indices */
+	for (i = 0; i < SUN8I_MIXER_MAX_LAYERS && j < SUN8I_MIXER_MAX_LAYERS;
+	     i++) {
+		if (mixer->channel_zpos[i] < 0) {
+			route |= i << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(j);
+			j++;
+		}
+	}
+
+	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(base),
+			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, pipe_ctl);
+
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_BLEND_ROUTE(base), route);
+
+	DRM_DEBUG_DRIVER("Committing changes\n");
 	regmap_write(engine->regs, SUN8I_MIXER_GLOBAL_DBUFF,
 		     SUN8I_MIXER_GLOBAL_DBUFF_ENABLE);
 }
@@ -485,10 +531,12 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 		     SUN8I_MIXER_BLEND_COLOR_BLACK);
 
 	plane_cnt = mixer->cfg->vi_num + mixer->cfg->ui_num;
-	for (i = 0; i < plane_cnt; i++)
+	for (i = 0; i < plane_cnt; i++) {
+		mixer->channel_zpos[i] = -1;
 		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_BLEND_MODE(base, i),
 			     SUN8I_MIXER_BLEND_MODE_DEF);
+	}
 
 	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(base),
 			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index c6cc94057faf..b193d9d1db66 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -13,6 +13,8 @@
 #include "sun8i_csc.h"
 #include "sunxi_engine.h"
 
+#define SUN8I_MIXER_MAX_LAYERS			5
+
 #define SUN8I_MIXER_SIZE(w, h)			(((h) - 1) << 16 | ((w) - 1))
 #define SUN8I_MIXER_COORD(x, y)			((y) << 16 | (x))
 
@@ -176,6 +178,9 @@ struct sun8i_mixer {
 
 	struct clk			*bus_clk;
 	struct clk			*mod_clk;
+
+	/* -1 means that layer is disabled */
+	int channel_zpos[SUN8I_MIXER_MAX_LAYERS];
 };
 
 static inline struct sun8i_mixer *
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index c87fd842918e..ee7c13d8710f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -24,12 +24,10 @@
 #include "sun8i_ui_scaler.h"
 
 static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel,
-				  int overlay, bool enable, unsigned int zpos,
-				  unsigned int old_zpos)
+				  int overlay, bool enable, unsigned int zpos)
 {
-	u32 val, bld_base, ch_base;
+	u32 val, ch_base;
 
-	bld_base = sun8i_blender_base(mixer);
 	ch_base = sun8i_channel_base(mixer, channel);
 
 	DRM_DEBUG_DRIVER("%sabling channel %d overlay %d\n",
@@ -44,32 +42,7 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
 
-	if (!enable || zpos != old_zpos) {
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
-				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
-				   0);
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
-				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
-				   0);
-	}
-
-	if (enable) {
-		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
-				   val, val);
-
-		val = channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
-				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
-				   val);
-	}
+	mixer->channel_zpos[channel] = enable ? zpos : -1;
 }
 
 static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
@@ -265,11 +238,9 @@ static void sun8i_ui_layer_atomic_disable(struct drm_plane *plane,
 					  struct drm_plane_state *old_state)
 {
 	struct sun8i_ui_layer *layer = plane_to_sun8i_ui_layer(plane);
-	unsigned int old_zpos = old_state->normalized_zpos;
 	struct sun8i_mixer *mixer = layer->mixer;
 
-	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false, 0,
-			      old_zpos);
+	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
 }
 
 static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
@@ -277,12 +248,11 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 {
 	struct sun8i_ui_layer *layer = plane_to_sun8i_ui_layer(plane);
 	unsigned int zpos = plane->state->normalized_zpos;
-	unsigned int old_zpos = old_state->normalized_zpos;
 	struct sun8i_mixer *mixer = layer->mixer;
 
 	if (!plane->state->visible) {
 		sun8i_ui_layer_enable(mixer, layer->channel,
-				      layer->overlay, false, 0, old_zpos);
+				      layer->overlay, false, 0);
 		return;
 	}
 
@@ -293,7 +263,7 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 	sun8i_ui_layer_update_buffer(mixer, layer->channel,
 				     layer->overlay, plane);
 	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
-			      true, zpos, old_zpos);
+			      true, zpos);
 }
 
 static struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 42d445d23773..97cbc98bf781 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -17,8 +17,7 @@
 #include "sun8i_vi_scaler.h"
 
 static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
-				  int overlay, bool enable, unsigned int zpos,
-				  unsigned int old_zpos)
+				  int overlay, bool enable, unsigned int zpos)
 {
 	u32 val, bld_base, ch_base;
 
@@ -37,32 +36,7 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
 
-	if (!enable || zpos != old_zpos) {
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
-				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
-				   0);
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
-				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
-				   0);
-	}
-
-	if (enable) {
-		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
-				   val, val);
-
-		val = channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
-				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
-				   val);
-	}
+	mixer->channel_zpos[channel] = enable ? zpos : -1;
 }
 
 static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
@@ -350,11 +324,9 @@ static void sun8i_vi_layer_atomic_disable(struct drm_plane *plane,
 					  struct drm_plane_state *old_state)
 {
 	struct sun8i_vi_layer *layer = plane_to_sun8i_vi_layer(plane);
-	unsigned int old_zpos = old_state->normalized_zpos;
 	struct sun8i_mixer *mixer = layer->mixer;
 
-	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false, 0,
-			      old_zpos);
+	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
 }
 
 static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
@@ -362,12 +334,11 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 {
 	struct sun8i_vi_layer *layer = plane_to_sun8i_vi_layer(plane);
 	unsigned int zpos = plane->state->normalized_zpos;
-	unsigned int old_zpos = old_state->normalized_zpos;
 	struct sun8i_mixer *mixer = layer->mixer;
 
 	if (!plane->state->visible) {
 		sun8i_vi_layer_enable(mixer, layer->channel,
-				      layer->overlay, false, 0, old_zpos);
+				      layer->overlay, false, 0);
 		return;
 	}
 
@@ -378,7 +349,7 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 	sun8i_vi_layer_update_buffer(mixer, layer->channel,
 				     layer->overlay, plane);
 	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
-			      true, zpos, old_zpos);
+			      true, zpos);
 }
 
 static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs = {
-- 
2.17.1

