Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3778C2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 20:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62672192A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 20:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="TkDoA/GO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgAAUsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 15:48:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39287 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgAAUsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 15:48:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so21125109pfs.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 12:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2SofJSOHMh3xU8jt0Vq5SjDaM8NbyGjoDZ2alxMEzaI=;
        b=TkDoA/GOpLilfkhY45zdpROfXwaqSswl3PEiMomaAj61KJ2mPl7mZP4eoYd0D8cMbV
         koWhIsX4GgD9sXow8D3YnpagmMS9S3Zggr2taw+a4O2OxeMviQfz92w1IbqTFFy9EE07
         Xd6LHQKPaDyGI8HHEIlc40SYq797WDKBfXQvtomfv8Zof7+6cTpfDNVexoPuhCYJkTU5
         N6yOxF99DsuKns+Xry28KLYRYsFK/Nu5vcbb5xzuwo/UWaij5skCatk8MqZ8dDP/Zhox
         C0EmJSNdXTEcicCBbKTUWajjMGx9QTZpHpGaJFAmh6JCz2z9mAZJVXD3GcuZf+auztZD
         Xa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2SofJSOHMh3xU8jt0Vq5SjDaM8NbyGjoDZ2alxMEzaI=;
        b=Ryz8rU6LAZlFG4rVzQKtlfZO8XfpBlVb3pW5q5hVvaPqR7RG1NkmK6N/ItW8xLNrJ5
         Z+Cv0RPsQ+nHH3ssTo3nnPfLGaZCJnsWkt5E8OpxhuR7lqRFGnbKPxXs8VycdM8/dg0b
         UdlyU6z3WbyyqYG6PpQw+hrME08wNR/KgZtRJO61YCbEKNi2CSk9KpIlwWF8wS/MgDxU
         VV5SgNTYNy/QQ2+xnl2m3Ilw6dfen4xnBbQOOwcAJ4NYF0NV61WYXmMaXY20ZYV041WH
         H8cCJiLzOfJzsVrg0XMxcirYOnq3AKwazqQqhm1hJzUdNQYAEYwZvqnV5lPkqUNAHvL5
         J98Q==
X-Gm-Message-State: APjAAAX2u3LmNqZUeDOLY4ouYSCk2ju5/tYetTImGRDOQks+BK04NSqS
        vBIBBWHesRW8mt+cqb19KqxcLA==
X-Google-Smtp-Source: APXvYqwJxFrNQkwzAgXpkMn+jkAYit5FqFL/OM2wFthBwFkvOSC8RerPz0lZCpFgIYnOSkfBWmsWGQ==
X-Received: by 2002:a63:2355:: with SMTP id u21mr84065943pgm.179.1577911692958;
        Wed, 01 Jan 2020 12:48:12 -0800 (PST)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id z22sm53774752pfr.83.2020.01.01.12.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 12:48:12 -0800 (PST)
From:   roman.stratiienko@globallogic.com
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH v3 2/2] drm/sun4i: Use CRTC size instead of PRIMARY plane size as mixer frame.
Date:   Wed,  1 Jan 2020 22:47:50 +0200
Message-Id: <20200101204750.50541-2-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101204750.50541-1-roman.stratiienko@globallogic.com>
References: <20200101204750.50541-1-roman.stratiienko@globallogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

According to DRM documentation the only difference between PRIMARY
and OVERLAY plane is that each CRTC must have PRIMARY plane and
OVERLAY are optional.

Allow PRIMARY plane to have dimension different from full-screen.

Fixes: 5bb5f5dafa1a ("drm/sun4i: Reorganize UI layer code in DE2")
Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
v2:
- Split commit in 2 parts
- Add Fixes line to the commit message

v3:
- Address review comments of v2 + removed 3 local varibles
- Change 'Fixes' line

Since I've put more changes from my side, please review/sign again.
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 28 ++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 30 --------------------------
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 8b803eb903b8..658cf442c121 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -257,6 +257,33 @@ const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
 	return NULL;
 }
 
+static void sun8i_mode_set(struct sunxi_engine *engine,
+			   struct drm_display_mode *mode)
+{
+	u32 size = SUN8I_MIXER_SIZE(mode->crtc_hdisplay, mode->crtc_vdisplay);
+	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
+	u32 bld_base = sun8i_blender_base(mixer);
+	u32 val;
+
+	DRM_DEBUG_DRIVER("Mode change, updating global size W: %u H: %u\n",
+			 mode->crtc_hdisplay, mode->crtc_vdisplay);
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_SIZE, size);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), size);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
+	else
+		val = 0;
+
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
+			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
+			   val);
+	DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
+			 val ? "on" : "off");
+}
+
 static void sun8i_mixer_commit(struct sunxi_engine *engine)
 {
 	DRM_DEBUG_DRIVER("Committing changes\n");
@@ -310,6 +337,7 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 static const struct sunxi_engine_ops sun8i_engine_ops = {
 	.commit		= sun8i_mixer_commit,
 	.layers_init	= sun8i_layers_init,
+	.mode_set	= sun8i_mode_set,
 };
 
 static struct regmap_config sun8i_mixer_regmap_config = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 4343ea9f8cf8..f01ac55191f1 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -120,36 +120,6 @@ static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
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
-- 
2.17.1

