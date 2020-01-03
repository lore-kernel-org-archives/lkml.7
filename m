Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE881C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 21:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B7D2253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 21:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="aYNfW9hm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgACVTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 16:19:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35743 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgACVTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 16:19:16 -0500
Received: by mail-lf1-f68.google.com with SMTP id 15so32704031lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 13:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=opKYnKPgrfgs6DL2jExuYki2MokOaTmbOuEyaIwELRw=;
        b=aYNfW9hmDHZtNaeHoqyCpMR9J53zbj/6VaqU8qE1fnAmxk9ZcUmlrHWFJk80Vnl5FR
         5nZD/XcJ95W2QmrkrzYB/FT5pPQHiSPqx1HQJLDomXNwTuY5m3lO2N4NWfdJQTIwRKjv
         f0saAQwGAJMk/1sEIFBe9osBAhyFLoXnvB0cFPIXHY2Htu/GWH6w5L1VXhdRTDv7qKAJ
         zJYKgGH16l8ftjV3S3hixleYtHoi4scbWlEEoaR8Yua1Ied3pLddJTa57bnAd7b3pjWR
         anEcG93NxLMjGnrPdYOFmV4iEFD084Xvaw95Fyxiqh+s+ErAFKwkYs1KEl7Rq5ro5dK7
         PF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=opKYnKPgrfgs6DL2jExuYki2MokOaTmbOuEyaIwELRw=;
        b=rV1iPcNJLeJVBohTFzzfxq5ourORJIz2YM9wM3jPhReTi12SJycflIk2E80I72my7G
         pPFWLIcVUIs4Ehq1BhP2a12dcSy7E2gzx7elgJdl6K38ZlpdDA4Hl/SMoCutkXZrJyzj
         ZHGEc78pzm7I0XrXqClde95AviPnXF32ak6M9gtgXJWNtlWpLJtU2fIswYhq6Up1FBxo
         b8d5DOS0Egmc7sdK4f+R3MO58XZzKm08NYjjBWmmSOU6kPadZtyOXmWWPk9WpwCYNWhz
         /ICPUZLTV63MstzYK0YOxvUP/6H8RVpzznKJedEqybenp1NmbL2TpWLic5XEYvFcik/0
         dLmw==
X-Gm-Message-State: APjAAAWpX0OUSkPAJ/hkIsT9T8oD9XC95PJp4hLKhaVNqQVEYmhvtE35
        0N4cayS+LF8mJ8l9c4aah91T4w==
X-Google-Smtp-Source: APXvYqxpCPH5IJYHJHFcUVveZAYcdzswXwFCrVzCLM6GERC5X7e3+Vbzg+lGUWc0YgZoCV3CLUePYQ==
X-Received: by 2002:ac2:4212:: with SMTP id y18mr50378966lfh.2.1578086354024;
        Fri, 03 Jan 2020 13:19:14 -0800 (PST)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id e9sm18107683ljp.75.2020.01.03.13.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 13:19:13 -0800 (PST)
From:   roman.stratiienko@globallogic.com
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH v3 2/2] drm/sun4i: Add alpha property for sun8i and sun50i VI layer
Date:   Fri,  3 Jan 2020 23:19:01 +0200
Message-Id: <20200103211901.44201-2-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103211901.44201-1-roman.stratiienko@globallogic.com>
References: <20200103211901.44201-1-roman.stratiienko@globallogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

DE3.0 VI layers supports plane-global alpha channel.
DE2.0 FCC block have GLOBAL_ALPHA register that can be used as alpha source
for blender.

Add alpha property to the DRM plane and connect it to the
corresponding registers in the mixer.

Do not add alpha property for systems with DE2.0 and more than 1 VI planes.

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
v2: Initial version by mistake
v3:
- Skip adding & applying alpha property if VI count > 1
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 48 +++++++++++++++++++++-----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h | 11 ++++++
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 42d445d23773..e61aec7d6d07 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -65,6 +65,36 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
 	}
 }
 
+static void sun8i_vi_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
+					int overlay, struct drm_plane *plane)
+{
+	u32 mask, val, ch_base;
+
+	ch_base = sun8i_channel_base(mixer, channel);
+
+	if (mixer->cfg->is_de3) {
+		mask = SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK |
+		       SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_MASK;
+		val = SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA
+			(plane->state->alpha >> 8);
+
+		val |= (plane->state->alpha == DRM_BLEND_ALPHA_OPAQUE) ?
+			SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_PIXEL :
+			SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_COMBINED;
+
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base,
+								  overlay),
+				   mask, val);
+	} else if (mixer->cfg->vi_num == 1) {
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_FCC_GLOBAL_ALPHA_REG,
+				   SUN8I_MIXER_FCC_GLOBAL_ALPHA_MASK,
+				   SUN8I_MIXER_FCC_GLOBAL_ALPHA
+					(plane->state->alpha >> 8));
+	}
+}
+
 static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 				       int overlay, struct drm_plane *plane,
 				       unsigned int zpos)
@@ -248,14 +278,6 @@ static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE, val);
 
-	/* It seems that YUV formats use global alpha setting. */
-	if (mixer->cfg->is_de3)
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base,
-								  overlay),
-				   SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK,
-				   SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA(0xff));
-
 	return 0;
 }
 
@@ -373,6 +395,8 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 
 	sun8i_vi_layer_update_coord(mixer, layer->channel,
 				    layer->overlay, plane, zpos);
+	sun8i_vi_layer_update_alpha(mixer, layer->channel,
+				    layer->overlay, plane);
 	sun8i_vi_layer_update_formats(mixer, layer->channel,
 				      layer->overlay, plane);
 	sun8i_vi_layer_update_buffer(mixer, layer->channel,
@@ -464,6 +488,14 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 
 	plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
 
+	if (mixer->cfg->vi_num == 1 || mixer->cfg->is_de3) {
+		ret = drm_plane_create_alpha_property(&layer->plane);
+		if (ret) {
+			dev_err(drm->dev, "Couldn't add alpha property\n");
+			return ERR_PTR(ret);
+		}
+	}
+
 	ret = drm_plane_create_zpos_property(&layer->plane, index,
 					     0, plane_cnt - 1);
 	if (ret) {
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
index eaa6076f5dbc..48c399e1c86d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
@@ -29,14 +29,25 @@
 #define SUN8I_MIXER_CHAN_VI_VDS_UV(base) \
 		((base) + 0xfc)
 
+#define SUN8I_MIXER_FCC_GLOBAL_ALPHA_REG \
+		(0xAA000 + 0x90)
+
+#define SUN8I_MIXER_FCC_GLOBAL_ALPHA(x)			((x) << 24)
+#define SUN8I_MIXER_FCC_GLOBAL_ALPHA_MASK		GENMASK(31, 24)
+
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN		BIT(0)
 /* RGB mode should be set for RGB formats and cleared for YCbCr */
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE		BIT(15)
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET	8
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
+#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
 #define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
 #define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA(x)	((x) << 24)
 
+#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_PIXEL	((0) << 1)
+#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_LAYER	((1) << 1)
+#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_COMBINED	((2) << 1)
+
 #define SUN8I_MIXER_CHAN_VI_DS_N(x)			((x) << 16)
 #define SUN8I_MIXER_CHAN_VI_DS_M(x)			((x) << 0)
 
-- 
2.17.1

