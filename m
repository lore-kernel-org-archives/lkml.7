Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A47C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA3920823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbfB1UDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:03:50 -0500
Received: from mailoutvs38.siol.net ([185.57.226.229]:39940 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728140AbfB1UDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:03:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id CD12B522467;
        Thu, 28 Feb 2019 21:03:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zvu3CY22wvHV; Thu, 28 Feb 2019 21:03:45 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 53362521852;
        Thu, 28 Feb 2019 21:03:45 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 00B6552246B;
        Thu, 28 Feb 2019 21:03:42 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: [PATCH 3/3] drm/sun4i: Improve VI scaling for DE2/DE3
Date:   Thu, 28 Feb 2019 21:03:29 +0100
Message-Id: <20190228200329.11128-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228200329.11128-1-jernej.skrabec@siol.net>
References: <20190228200329.11128-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VI planes support coarse scaling which helps to overcome VI scaler
limitations. While exact working of coarse scaling isn't known, it seems
that it just skips programmed amount of rows and columns. This is
especially useful for downscaling very big planes (4K down to 1080p).

Horizontal coarse scaling is currently used to fit one line to VI scaler
buffer.

Vertical coarse scaling is used to assure that VI scaler is actually
capable of processing framebuffer in one frame time.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 54 ++++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h | 11 ++++++
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index 8a0616238467..bb8e026d6405 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -80,6 +80,8 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mix=
er *mixer, int channel,
 	u32 bld_base, ch_base;
 	u32 outsize, insize;
 	u32 hphase, vphase;
+	u32 hn =3D 0, hm =3D 0;
+	u32 vn =3D 0, vm =3D 0;
 	bool subsampled;
=20
 	DRM_DEBUG_DRIVER("Updating VI channel %d overlay %d\n",
@@ -137,12 +139,41 @@ static int sun8i_vi_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
 	subsampled =3D format->hsub > 1 || format->vsub > 1;
=20
 	if (insize !=3D outsize || subsampled || hphase || vphase) {
-		u32 hscale, vscale;
+		unsigned int scanline, required;
+		struct drm_display_mode *mode;
+		u32 hscale, vscale, fps;
+		u64 ability;
=20
 		DRM_DEBUG_DRIVER("HW scaling is enabled\n");
=20
-		hscale =3D state->src_w / state->crtc_w;
-		vscale =3D state->src_h / state->crtc_h;
+		mode =3D &plane->state->crtc->state->mode;
+		fps =3D (mode->clock * 1000) / (mode->vtotal * mode->htotal);
+		ability =3D clk_get_rate(mixer->mod_clk);
+		/* BSP algorithm assumes 80% efficiency of VI scaler unit */
+		ability *=3D 80;
+		do_div(ability, mode->vdisplay * fps * max(src_w, dst_w));
+
+		required =3D src_h * 100 / dst_h;
+
+		if (ability < required) {
+			DRM_DEBUG_DRIVER("Using vertical coarse scaling\n");
+			vm =3D src_h;
+			vn =3D (u32)ability * dst_h / 100;
+			src_h =3D vn;
+		}
+
+		/* it seems that every RGB scaler has buffer for 2048 pixels */
+		scanline =3D subsampled ? mixer->cfg->scanline_yuv : 2048;
+
+		if (src_w > scanline) {
+			DRM_DEBUG_DRIVER("Using horizontal coarse scaling\n");
+			hm =3D src_w;
+			hn =3D scanline;
+			src_w =3D hn;
+		}
+
+		hscale =3D (src_w << 16) / dst_w;
+		vscale =3D (src_h << 16) / dst_h;
=20
 		sun8i_vi_scaler_setup(mixer, channel, src_w, src_h, dst_w,
 				      dst_h, hscale, vscale, hphase, vphase,
@@ -153,6 +184,23 @@ static int sun8i_vi_layer_update_coord(struct sun8i_=
mixer *mixer, int channel,
 		sun8i_vi_scaler_enable(mixer, channel, false);
 	}
=20
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_VI_HDS_Y(ch_base),
+		     SUN8I_MIXER_CHAN_VI_DS_N(hn) |
+		     SUN8I_MIXER_CHAN_VI_DS_M(hm));
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_VI_HDS_UV(ch_base),
+		     SUN8I_MIXER_CHAN_VI_DS_N(hn) |
+		     SUN8I_MIXER_CHAN_VI_DS_M(hm));
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_VI_VDS_Y(ch_base),
+		     SUN8I_MIXER_CHAN_VI_DS_N(vn) |
+		     SUN8I_MIXER_CHAN_VI_DS_M(vm));
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_VI_VDS_UV(ch_base),
+		     SUN8I_MIXER_CHAN_VI_DS_N(vn) |
+		     SUN8I_MIXER_CHAN_VI_DS_M(vm));
+
 	/* Set base coordinates */
 	DRM_DEBUG_DRIVER("Layer destination coordinates X: %d Y: %d\n",
 			 state->dst.x1, state->dst.y1);
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.h
index 8a5e6d01c85d..a223a4839f45 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
@@ -24,6 +24,14 @@
 		((base) + 0x30 * (layer) + 0x18 + 4 * (plane))
 #define SUN8I_MIXER_CHAN_VI_OVL_SIZE(base) \
 		((base) + 0xe8)
+#define SUN8I_MIXER_CHAN_VI_HDS_Y(base) \
+		((base) + 0xf0)
+#define SUN8I_MIXER_CHAN_VI_HDS_UV(base) \
+		((base) + 0xf4)
+#define SUN8I_MIXER_CHAN_VI_VDS_Y(base) \
+		((base) + 0xf8)
+#define SUN8I_MIXER_CHAN_VI_VDS_UV(base) \
+		((base) + 0xfc)
=20
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN		BIT(0)
 /* RGB mode should be set for RGB formats and cleared for YCbCr */
@@ -33,6 +41,9 @@
 #define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
 #define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA(x)	((x) << 24)
=20
+#define SUN8I_MIXER_CHAN_VI_DS_N(x)			((x) << 16)
+#define SUN8I_MIXER_CHAN_VI_DS_M(x)			((x) << 0)
+
 struct sun8i_mixer;
=20
 struct sun8i_vi_layer {
--=20
2.20.1

