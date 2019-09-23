Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9502AC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A7420835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439627AbfIWMwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:52:33 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:37312 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437050AbfIWMwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:52:33 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.128])
        by regular1.263xmail.com (Postfix) with ESMTP id 4931FB7E;
        Mon, 23 Sep 2019 20:52:29 +0800 (CST)
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
        Mon, 23 Sep 2019 20:52:28 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <0879891f7949fe71dcd17fbe9529da66>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     hjc@rock-chips.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/36] drm/imx: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:51:48 +0800
Message-Id: <1569243119-183293-5-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569243119-183293-1-git-send-email-hjc@rock-chips.com>
References: <1569243119-183293-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/imx/ipuv3-plane.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3-plane.c
index 28826c0..f7c7036 100644
--- a/drivers/gpu/drm/imx/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3-plane.c
@@ -101,7 +101,7 @@ drm_plane_state_to_eba(struct drm_plane_state *state, int plane)
 	BUG_ON(!cma_obj);
 
 	return cma_obj->paddr + fb->offsets[plane] + fb->pitches[plane] * y +
-	       fb->format->cpp[plane] * x;
+	       fb->format->bpp[plane] / 8 * x;
 }
 
 static inline unsigned long
@@ -120,7 +120,7 @@ drm_plane_state_to_ubo(struct drm_plane_state *state)
 	y /= fb->format->vsub;
 
 	return cma_obj->paddr + fb->offsets[1] + fb->pitches[1] * y +
-	       fb->format->cpp[1] * x - eba;
+	       fb->format->bpp[1] / 8 * x - eba;
 }
 
 static inline unsigned long
@@ -139,7 +139,7 @@ drm_plane_state_to_vbo(struct drm_plane_state *state)
 	y /= fb->format->vsub;
 
 	return cma_obj->paddr + fb->offsets[2] + fb->pitches[2] * y +
-	       fb->format->cpp[2] * x - eba;
+	       fb->format->bpp[2] / 8 * x - eba;
 }
 
 void ipu_plane_put_resources(struct ipu_plane *ipu_plane)
@@ -628,7 +628,7 @@ static void ipu_plane_atomic_update(struct drm_plane *plane,
 	width = drm_rect_width(&state->src) >> 16;
 	height = drm_rect_height(&state->src) >> 16;
 	info = drm_format_info(fb->format->format);
-	ipu_calculate_bursts(width, info->cpp[0], fb->pitches[0],
+	ipu_calculate_bursts(width, info->bpp[0] / 8, fb->pitches[0],
 			     &burstsize, &num_bursts);
 
 	ipu_cpmem_zero(ipu_plane->ipu_ch);
-- 
2.7.4



