Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5371DC31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 12:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3728B20848
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 12:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfGMMEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 08:04:09 -0400
Received: from mailoutvs19.siol.net ([185.57.226.210]:35195 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727834AbfGMMEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 08:04:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 7B3A95214F8;
        Sat, 13 Jul 2019 14:04:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7ZW_RsVKlxwH; Sat, 13 Jul 2019 14:04:03 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id D2660521512;
        Sat, 13 Jul 2019 14:04:03 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 8286A521504;
        Sat, 13 Jul 2019 14:04:01 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 3/3] drm/sun4i: sun8i-csc: Add support for color encoding and range
Date:   Sat, 13 Jul 2019 14:03:46 +0200
Message-Id: <20190713120346.30349-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190713120346.30349-1-jernej.skrabec@siol.net>
References: <20190713120346.30349-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion from YUV to RGB depends on range (limited or full) and
encoding (BT.601 or BT.709). Current code doesn't consider this and
always uses BT.601 encoding and limited range.

Fix this by introducing new CSC matrices, which are selected based on
range and encoding parameters.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_csc.c      | 144 ++++++++++++++++++++-----
 drivers/gpu/drm/sun4i/sun8i_csc.h      |   6 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |   4 +-
 3 files changed, 126 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/su=
n8i_csc.c
index e07b7876d89b..70c792d052fe 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -18,16 +18,59 @@ static const u32 ccsc_base[2][2] =3D {
  * First tree values in each line are multiplication factor and last
  * value is constant, which is added at the end.
  */
-static const u32 yuv2rgb[] =3D {
-	0x000004A8, 0x00000000, 0x00000662, 0xFFFC845A,
-	0x000004A8, 0xFFFFFE6F, 0xFFFFFCBF, 0x00021DF4,
-	0x000004A8, 0x00000813, 0x00000000, 0xFFFBAC4A,
+
+static const u32 yuv2rgb[2][2][12] =3D {
+	[DRM_COLOR_YCBCR_LIMITED_RANGE] =3D {
+		[DRM_COLOR_YCBCR_BT601] =3D {
+			0x000004A8, 0x00000000, 0x00000662, 0xFFFC8451,
+			0x000004A8, 0xFFFFFE6F, 0xFFFFFCC0, 0x00021E4D,
+			0x000004A8, 0x00000811, 0x00000000, 0xFFFBACA9,
+		},
+		[DRM_COLOR_YCBCR_BT709] =3D {
+			0x000004A8, 0x00000000, 0x0000072B, 0xFFFC1F99,
+			0x000004A8, 0xFFFFFF26, 0xFFFFFDDF, 0x00013383,
+			0x000004A8, 0x00000873, 0x00000000, 0xFFFB7BEF,
+		}
+	},
+	[DRM_COLOR_YCBCR_FULL_RANGE] =3D {
+		[DRM_COLOR_YCBCR_BT601] =3D {
+			0x00000400, 0x00000000, 0x0000059B, 0xFFFD322E,
+			0x00000400, 0xFFFFFEA0, 0xFFFFFD25, 0x00021DD5,
+			0x00000400, 0x00000716, 0x00000000, 0xFFFC74BD,
+		},
+		[DRM_COLOR_YCBCR_BT709] =3D {
+			0x00000400, 0x00000000, 0x0000064C, 0xFFFCD9B4,
+			0x00000400, 0xFFFFFF41, 0xFFFFFE21, 0x00014F96,
+			0x00000400, 0x0000076C, 0x00000000, 0xFFFC49EF,
+		}
+	},
 };
=20
-static const u32 yvu2rgb[] =3D {
-	0x000004A8, 0x00000662, 0x00000000, 0xFFFC845A,
-	0x000004A8, 0xFFFFFCBF, 0xFFFFFE6F, 0x00021DF4,
-	0x000004A8, 0x00000000, 0x00000813, 0xFFFBAC4A,
+static const u32 yvu2rgb[2][2][12] =3D {
+	[DRM_COLOR_YCBCR_LIMITED_RANGE] =3D {
+		[DRM_COLOR_YCBCR_BT601] =3D {
+			0x000004A8, 0x00000662, 0x00000000, 0xFFFC8451,
+			0x000004A8, 0xFFFFFCC0, 0xFFFFFE6F, 0x00021E4D,
+			0x000004A8, 0x00000000, 0x00000811, 0xFFFBACA9,
+		},
+		[DRM_COLOR_YCBCR_BT709] =3D {
+			0x000004A8, 0x0000072B, 0x00000000, 0xFFFC1F99,
+			0x000004A8, 0xFFFFFDDF, 0xFFFFFF26, 0x00013383,
+			0x000004A8, 0x00000000, 0x00000873, 0xFFFB7BEF,
+		}
+	},
+	[DRM_COLOR_YCBCR_FULL_RANGE] =3D {
+		[DRM_COLOR_YCBCR_BT601] =3D {
+			0x00000400, 0x0000059B, 0x00000000, 0xFFFD322E,
+			0x00000400, 0xFFFFFD25, 0xFFFFFEA0, 0x00021DD5,
+			0x00000400, 0x00000000, 0x00000716, 0xFFFC74BD,
+		},
+		[DRM_COLOR_YCBCR_BT709] =3D {
+			0x00000400, 0x0000064C, 0x00000000, 0xFFFCD9B4,
+			0x00000400, 0xFFFFFE21, 0xFFFFFF41, 0x00014F96,
+			0x00000400, 0x00000000, 0x0000076C, 0xFFFC49EF,
+		}
+	},
 };
=20
 /*
@@ -53,30 +96,74 @@ static const u32 yvu2rgb[] =3D {
  * c20 c21 c22 [d2 const2]
  */
=20
-static const u32 yuv2rgb_de3[] =3D {
-	0x0002542a, 0x00000000, 0x0003312a, 0xffc00000,
-	0x0002542a, 0xffff376b, 0xfffe5fc3, 0xfe000000,
-	0x0002542a, 0x000408d3, 0x00000000, 0xfe000000,
+static const u32 yuv2rgb_de3[2][2][12] =3D {
+	[DRM_COLOR_YCBCR_LIMITED_RANGE] =3D {
+		[DRM_COLOR_YCBCR_BT601] =3D {
+			0x0002542A, 0x00000000, 0x0003312A, 0xFFC00000,
+			0x0002542A, 0xFFFF376B, 0xFFFE5FC3, 0xFE000000,
+			0x0002542A, 0x000408D2, 0x00000000, 0xFE000000,
+		},
+		[DRM_COLOR_YCBCR_BT709] =3D {
+			0x0002542A, 0x00000000, 0x000395E2, 0xFFC00000,
+			0x0002542A, 0xFFFF92D2, 0xFFFEEF27, 0xFE000000,
+			0x0002542A, 0x0004398C, 0x00000000, 0xFE000000,
+		}
+	},
+	[DRM_COLOR_YCBCR_FULL_RANGE] =3D {
+		[DRM_COLOR_YCBCR_BT601] =3D {
+			0x00020000, 0x00000000, 0x0002CDD2, 0x00000000,
+			0x00020000, 0xFFFF4FCE, 0xFFFE925D, 0xFE000000,
+			0x00020000, 0x00038B43, 0x00000000, 0xFE000000,
+		},
+		[DRM_COLOR_YCBCR_BT709] =3D {
+			0x00020000, 0x00000000, 0x0003264C, 0x00000000,
+			0x00020000, 0xFFFFA018, 0xFFFF1053, 0xFE000000,
+			0x00020000, 0x0003B611, 0x00000000, 0xFE000000,
+		}
+	},
 };
=20
-static const u32 yvu2rgb_de3[] =3D {
-	0x0002542a, 0x0003312a, 0x00000000, 0xffc00000,
-	0x0002542a, 0xfffe5fc3, 0xffff376b, 0xfe000000,
-	0x0002542a, 0x00000000, 0x000408d3, 0xfe000000,
+static const u32 yvu2rgb_de3[2][2][12] =3D {
+	[DRM_COLOR_YCBCR_LIMITED_RANGE] =3D {
+		[DRM_COLOR_YCBCR_BT601] =3D {
+			0x0002542A, 0x0003312A, 0x00000000, 0xFFC00000,
+			0x0002542A, 0xFFFE5FC3, 0xFFFF376B, 0xFE000000,
+			0x0002542A, 0x00000000, 0x000408D2, 0xFE000000,
+		},
+		[DRM_COLOR_YCBCR_BT709] =3D {
+			0x0002542A, 0x000395E2, 0x00000000, 0xFFC00000,
+			0x0002542A, 0xFFFEEF27, 0xFFFF92D2, 0xFE000000,
+			0x0002542A, 0x00000000, 0x0004398C, 0xFE000000,
+		}
+	},
+	[DRM_COLOR_YCBCR_FULL_RANGE] =3D {
+		[DRM_COLOR_YCBCR_BT601] =3D {
+			0x00020000, 0x0002CDD2, 0x00000000, 0x00000000,
+			0x00020000, 0xFFFE925D, 0xFFFF4FCE, 0xFE000000,
+			0x00020000, 0x00000000, 0x00038B43, 0xFE000000,
+		},
+		[DRM_COLOR_YCBCR_BT709] =3D {
+			0x00020000, 0x0003264C, 0x00000000, 0x00000000,
+			0x00020000, 0xFFFF1053, 0xFFFFA018, 0xFE000000,
+			0x00020000, 0x00000000, 0x0003B611, 0xFE000000,
+		}
+	},
 };
=20
 static void sun8i_csc_set_coefficients(struct regmap *map, u32 base,
-				       enum sun8i_csc_mode mode)
+				       enum sun8i_csc_mode mode,
+				       enum drm_color_encoding encoding,
+				       enum drm_color_range range)
 {
 	const u32 *table;
 	u32 base_reg;
=20
 	switch (mode) {
 	case SUN8I_CSC_MODE_YUV2RGB:
-		table =3D yuv2rgb;
+		table =3D yuv2rgb[range][encoding];
 		break;
 	case SUN8I_CSC_MODE_YVU2RGB:
-		table =3D yvu2rgb;
+		table =3D yvu2rgb[range][encoding];
 		break;
 	default:
 		DRM_WARN("Wrong CSC mode specified.\n");
@@ -88,17 +175,19 @@ static void sun8i_csc_set_coefficients(struct regmap=
 *map, u32 base,
 }
=20
 static void sun8i_de3_ccsc_set_coefficients(struct regmap *map, int laye=
r,
-					    enum sun8i_csc_mode mode)
+					    enum sun8i_csc_mode mode,
+					    enum drm_color_encoding encoding,
+					    enum drm_color_range range)
 {
 	const u32 *table;
 	u32 base_reg;
=20
 	switch (mode) {
 	case SUN8I_CSC_MODE_YUV2RGB:
-		table =3D yuv2rgb_de3;
+		table =3D yuv2rgb_de3[range][encoding];
 		break;
 	case SUN8I_CSC_MODE_YVU2RGB:
-		table =3D yvu2rgb_de3;
+		table =3D yvu2rgb_de3[range][encoding];
 		break;
 	default:
 		DRM_WARN("Wrong CSC mode specified.\n");
@@ -137,19 +226,22 @@ static void sun8i_de3_ccsc_enable(struct regmap *ma=
p, int layer, bool enable)
 }
=20
 void sun8i_csc_set_ccsc_coefficients(struct sun8i_mixer *mixer, int laye=
r,
-				     enum sun8i_csc_mode mode)
+				     enum sun8i_csc_mode mode,
+				     enum drm_color_encoding encoding,
+				     enum drm_color_range range)
 {
 	u32 base;
=20
 	if (mixer->cfg->is_de3) {
-		sun8i_de3_ccsc_set_coefficients(mixer->engine.regs,
-						layer, mode);
+		sun8i_de3_ccsc_set_coefficients(mixer->engine.regs, layer,
+						mode, encoding, range);
 		return;
 	}
=20
 	base =3D ccsc_base[mixer->cfg->ccsc][layer];
=20
-	sun8i_csc_set_coefficients(mixer->engine.regs, base, mode);
+	sun8i_csc_set_coefficients(mixer->engine.regs, base,
+				   mode, encoding, range);
 }
=20
 void sun8i_csc_enable_ccsc(struct sun8i_mixer *mixer, int layer, bool en=
able)
diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.h b/drivers/gpu/drm/sun4i/su=
n8i_csc.h
index dce4c444bcd6..f42441b1b14d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.h
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.h
@@ -6,6 +6,8 @@
 #ifndef _SUN8I_CSC_H_
 #define _SUN8I_CSC_H_
=20
+#include <drm/drm_color_mgmt.h>
+
 struct sun8i_mixer;
=20
 /* VI channel CSC units offsets */
@@ -26,7 +28,9 @@ enum sun8i_csc_mode {
 };
=20
 void sun8i_csc_set_ccsc_coefficients(struct sun8i_mixer *mixer, int laye=
r,
-				     enum sun8i_csc_mode mode);
+				     enum sun8i_csc_mode mode,
+				     enum drm_color_encoding encoding,
+				     enum drm_color_range range);
 void sun8i_csc_enable_ccsc(struct sun8i_mixer *mixer, int layer, bool en=
able);
=20
 #endif
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index 240a800217df..011924a75263 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -232,7 +232,9 @@ static int sun8i_vi_layer_update_formats(struct sun8i=
_mixer *mixer, int channel,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK, val);
=20
 	if (fmt_info->csc !=3D SUN8I_CSC_MODE_OFF) {
-		sun8i_csc_set_ccsc_coefficients(mixer, channel, fmt_info->csc);
+		sun8i_csc_set_ccsc_coefficients(mixer, channel, fmt_info->csc,
+						state->color_encoding,
+						state->color_range);
 		sun8i_csc_enable_ccsc(mixer, channel, true);
 	} else {
 		sun8i_csc_enable_ccsc(mixer, channel, false);
--=20
2.22.0

