Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FC2C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B237D20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439603AbfIWMwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:52:18 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:59112 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437050AbfIWMwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:52:17 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.128])
        by regular1.263xmail.com (Postfix) with ESMTP id F0E4C3D0;
        Mon, 23 Sep 2019 20:52:06 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P15436T140160991741696S1569243121384240_;
        Mon, 23 Sep 2019 20:52:02 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <72d6911f116111fd1e7e8d64ada32099>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, linux-kernel@vger.kernel.org
Subject: [PATCH 21/36] drm/vc4: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:51:44 +0800
Message-Id: <1569243119-183293-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 5e5f908..ad2b0ec 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -531,7 +531,7 @@ static void vc4_plane_calc_load(struct drm_plane_state *state)
 					     vc4_state->crtc_h);
 		vc4_state->membus_load += vc4_state->src_w[i] *
 					  vc4_state->src_h[i] * vscale_factor *
-					  fb->format->cpp[i];
+					  fb->format->bpp[i] / 8;
 		vc4_state->hvs_load += vc4_state->crtc_h * vc4_state->crtc_w;
 	}
 
@@ -646,7 +646,7 @@ static int vc4_plane_mode_set(struct drm_plane *plane,
 
 			vc4_state->offsets[i] += vc4_state->src_x /
 						 (i ? h_subsample : 1) *
-						 fb->format->cpp[i];
+						 fb->format->bpp[i] / 8;
 		}
 
 		break;
@@ -654,7 +654,7 @@ static int vc4_plane_mode_set(struct drm_plane *plane,
 	case DRM_FORMAT_MOD_BROADCOM_VC4_T_TILED: {
 		u32 tile_size_shift = 12; /* T tiles are 4kb */
 		/* Whole-tile offsets, mostly for setting the pitch. */
-		u32 tile_w_shift = fb->format->cpp[0] == 2 ? 6 : 5;
+		u32 tile_w_shift = fb->format->bpp[0] == 16 ? 6 : 5;
 		u32 tile_h_shift = 5; /* 16 and 32bpp are 32 pixels high */
 		u32 tile_w_mask = (1 << tile_w_shift) - 1;
 		/* The height mask on 32-bit-per-pixel tiles is 63, i.e. twice
@@ -749,7 +749,7 @@ static int vc4_plane_mode_set(struct drm_plane *plane,
 			return -EINVAL;
 		}
 
-		pix_per_tile = tile_w / fb->format->cpp[0];
+		pix_per_tile = tile_w / (fb->format->bpp[0] / 8);
 		tile = vc4_state->src_x / pix_per_tile;
 		x_off = vc4_state->src_x % pix_per_tile;
 
@@ -763,7 +763,7 @@ static int vc4_plane_mode_set(struct drm_plane *plane,
 						 tile_w;
 			vc4_state->offsets[i] += x_off /
 						 (i ? h_subsample : 1) *
-						 fb->format->cpp[i];
+						 fb->format->bpp[i] / 8;
 		}
 
 		pitch0 = VC4_SET_FIELD(param, SCALER_TILE_HEIGHT);
-- 
2.7.4



