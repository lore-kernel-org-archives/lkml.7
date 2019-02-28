Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C55AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161CC218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbfB1UDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:03:48 -0500
Received: from mailoutvs37.siol.net ([185.57.226.228]:39924 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732935AbfB1UDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:03:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 550B952228D;
        Thu, 28 Feb 2019 21:03:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7l6qKG3iBqMX; Thu, 28 Feb 2019 21:03:43 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id ECC9A522467;
        Thu, 28 Feb 2019 21:03:42 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 98A9052228D;
        Thu, 28 Feb 2019 21:03:40 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: [PATCH 2/3] drm/sun4i: Add VI scaler line size quirk for DE2/DE3
Date:   Thu, 28 Feb 2019 21:03:28 +0100
Message-Id: <20190228200329.11128-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228200329.11128-1-jernej.skrabec@siol.net>
References: <20190228200329.11128-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While all RGB scalers have maximum line size of 2048, some YUV scalers
have maximum line size of 2048 and some have line size of 4096.

Since there is no rule for that, add a quirk.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 9 +++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index 30a2eff55687..a2c4807fc9b7 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -554,6 +554,7 @@ static int sun8i_mixer_remove(struct platform_device =
*pdev)
 static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg =3D {
 	.ccsc		=3D 0,
 	.scaler_mask	=3D 0xf,
+	.scanline_yuv	=3D 2048,
 	.ui_num		=3D 3,
 	.vi_num		=3D 1,
 };
@@ -561,6 +562,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer0=
_cfg =3D {
 static const struct sun8i_mixer_cfg sun8i_a83t_mixer1_cfg =3D {
 	.ccsc		=3D 1,
 	.scaler_mask	=3D 0x3,
+	.scanline_yuv	=3D 2048,
 	.ui_num		=3D 1,
 	.vi_num		=3D 1,
 };
@@ -569,6 +571,7 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0_c=
fg =3D {
 	.ccsc		=3D 0,
 	.mod_rate	=3D 432000000,
 	.scaler_mask	=3D 0xf,
+	.scanline_yuv	=3D 2048,
 	.ui_num		=3D 3,
 	.vi_num		=3D 1,
 };
@@ -577,6 +580,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer0_=
cfg =3D {
 	.ccsc		=3D 0,
 	.mod_rate	=3D 297000000,
 	.scaler_mask	=3D 0xf,
+	.scanline_yuv	=3D 2048,
 	.ui_num		=3D 3,
 	.vi_num		=3D 1,
 };
@@ -585,6 +589,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer1_=
cfg =3D {
 	.ccsc		=3D 1,
 	.mod_rate	=3D 297000000,
 	.scaler_mask	=3D 0x3,
+	.scanline_yuv	=3D 2048,
 	.ui_num		=3D 1,
 	.vi_num		=3D 1,
 };
@@ -593,6 +598,7 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_c=
fg =3D {
 	.vi_num =3D 2,
 	.ui_num =3D 1,
 	.scaler_mask =3D 0x3,
+	.scanline_yuv =3D 2048,
 	.ccsc =3D 0,
 	.mod_rate =3D 150000000,
 };
@@ -601,6 +607,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer0=
_cfg =3D {
 	.ccsc		=3D 0,
 	.mod_rate	=3D 297000000,
 	.scaler_mask	=3D 0xf,
+	.scanline_yuv	=3D 4096,
 	.ui_num		=3D 3,
 	.vi_num		=3D 1,
 };
@@ -609,6 +616,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer1=
_cfg =3D {
 	.ccsc		=3D 1,
 	.mod_rate	=3D 297000000,
 	.scaler_mask	=3D 0x3,
+	.scanline_yuv	=3D 2048,
 	.ui_num		=3D 1,
 	.vi_num		=3D 1,
 };
@@ -618,6 +626,7 @@ static const struct sun8i_mixer_cfg sun50i_h6_mixer0_=
cfg =3D {
 	.is_de3		=3D true,
 	.mod_rate	=3D 600000000,
 	.scaler_mask	=3D 0xf,
+	.scanline_yuv	=3D 4096,
 	.ui_num		=3D 3,
 	.vi_num		=3D 1,
 };
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
index 913d14ce68b0..80e084caa084 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -159,6 +159,7 @@ struct de2_fmt_info {
  * @mod_rate: module clock rate that needs to be set in order to have
  *	a functional block.
  * @is_de3: true, if this is next gen display engine 3.0, false otherwis=
e.
+ * @scaline_yuv: size of a scanline for VI scaler for YUV formats.
  */
 struct sun8i_mixer_cfg {
 	int		vi_num;
@@ -167,6 +168,7 @@ struct sun8i_mixer_cfg {
 	int		ccsc;
 	unsigned long	mod_rate;
 	unsigned int	is_de3 : 1;
+	unsigned int	scanline_yuv;
 };
=20
 struct sun8i_mixer {
--=20
2.20.1

