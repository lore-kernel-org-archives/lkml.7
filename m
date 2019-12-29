Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88A0C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9FF21744
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="dDkneKR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfL2Q2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 11:28:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34330 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfL2Q2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 11:28:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id z22so26412538ljg.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 08:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4GjLcnLAOH5ADEEQuRyqeGZSux8fXFgp4Xzc2adgfqk=;
        b=dDkneKR9lD+kK9916qjmFQsqFAkZxxEvuLdXWG97PK+WZAm62WGyeOEBaygYAVGhib
         G17nJGDBamUEtVd5ZS3Ll+K29JBdgCHvD7aXJEqo8yfkYI0FP6zTpxXfkmCk+qg3BbWG
         Np+BB104nvD89NAIXYC6UduUV24oDcATfpE5ew2IMeXokd5lnf44y51X0TxQEDit4bSr
         MBKP10P62BX7BGUhOr1XxzI/h44j87Lh6/W9PecmVfMKPdp03glsE4VTM4+j0J3+d+Ns
         p47qHMz4MkYe7KcNfdLqBj8t9T92Hw4h7tg1MQJgG2KD11EpzsHYIWDCFvzGkTStKEx+
         +T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4GjLcnLAOH5ADEEQuRyqeGZSux8fXFgp4Xzc2adgfqk=;
        b=kHoUorCgzREFX7oOmqztthQ3UWNRcXBXcCqhNr8HAYl20bAVac++NLtCQ/PA+ZnkST
         7UhEr5KN7R5g+HDAOBbGgVXpBJtRg1for/+TZP2gHPjm0MLED/W0CRs81xcwdauBgyc5
         LYpPq3xcPqxT/Pn5WIsWxJpfz2hBv6eFjBKDwms0bghYpkpnLQEz7RT35zBFRsJCLpHy
         /BXrnYq63i9qhr24WaWoBGy7BcV03cG9bzYUvMdwDGY4tguaRJnlGUgU8LMQQYkMgyiH
         EKTcd/PBU9KUQD4mGgewRJNSpbjOXFl1f4lUXJEx1WqC9ppeeDAj2tmfgi1Yy5HmJlaD
         t7QA==
X-Gm-Message-State: APjAAAVJrG4QCobk0HUGHwwHLMDWtPu8iaZQJsJJB6lRuW5ViFH1VdRY
        8jjDbxUNjGC7K1dpYlxHfT/Z7A==
X-Google-Smtp-Source: APXvYqy3z1gRmQcjg3s055j6HK2dZEP8CF7dp5jiKbBb4zEmLwkxo3QWKDr/PFQU4NVxKH3sIMDGzg==
X-Received: by 2002:a05:651c:214:: with SMTP id y20mr33720931ljn.139.1577636920137;
        Sun, 29 Dec 2019 08:28:40 -0800 (PST)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id u13sm17284858lfq.19.2019.12.29.08.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 08:28:39 -0800 (PST)
From:   roman.stratiienko@globallogic.com
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH v2 3/4] drm/sun4i: Use CRTC size instead of PRIMARY plane size as mixer frame.
Date:   Sun, 29 Dec 2019 18:28:27 +0200
Message-Id: <20191229162828.3326-3-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191229162828.3326-1-roman.stratiienko@globallogic.com>
References: <20191229162828.3326-1-roman.stratiienko@globallogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

According to DRM documentation the only difference between PRIMARY
and OVERLAY plane is that each CRTC must have PRIMARY plane and
OVERLAY are optional.

Allow PRIMARY plane to have dimension different from full-screen.

Fixes: 90212fffa4fc ("drm/sun4i: Use values calculated by atomic check")
Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
v2:
- Split commit in 2 parts
- Add Fixes line to the commit message
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 35 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 30 ----------------------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index d306ad5dc093..5d90a95ff855 100644
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
 static void sun8i_mixer_commit(struct sunxi_engine *engine)
 {
 	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
@@ -356,6 +390,7 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 static const struct sunxi_engine_ops sun8i_engine_ops = {
 	.commit		= sun8i_mixer_commit,
 	.layers_init	= sun8i_layers_init,
+	.mode_set	= sun8i_mode_set,
 };
 
 static struct regmap_config sun8i_mixer_regmap_config = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index ee7c13d8710f..23c2f4b68c89 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -72,36 +72,6 @@ static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
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

