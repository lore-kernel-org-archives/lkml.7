Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45FDC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38AD20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406040AbfIWMwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:52:06 -0400
Received: from regular1.263xmail.com ([211.150.70.204]:39616 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404621AbfIWMwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:52:05 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 3783D27E;
        Mon, 23 Sep 2019 20:43:58 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3051T140289744058112S1569242621440080_;
        Mon, 23 Sep 2019 20:43:58 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8b85543686f2ae6693688f21f9fae196>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, linux-kernel@vger.kernel.org
Subject: [PATCH 09/36] dm/vmwgfx: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:41:13 +0800
Message-Id: <1569242500-182337-10-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569242500-182337-7-git-send-email-hjc@rock-chips.com>
References: <1569242500-182337-7-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c   | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
index 972e8fd..c516c40 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -91,7 +91,7 @@ static int vmw_fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	default:
 		DRM_ERROR("Bad depth %u, bpp %u.\n",
 			  par->set_fb->format->depth,
-			  par->set_fb->format->cpp[0] * 8);
+			  par->set_fb->format->bpp[0]);
 		return 1;
 	}
 
@@ -211,7 +211,7 @@ static void vmw_fb_dirty_flush(struct work_struct *work)
 	 * Handle panning when copying from vmalloc to framebuffer.
 	 * Clip dirty area to framebuffer.
 	 */
-	cpp = cur_fb->format->cpp[0];
+	cpp = cur_fb->format->bpp[0] / 8;
 	max_x = par->fb_x + cur_fb->width;
 	max_y = par->fb_y + cur_fb->height;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index 25e6343..e9b4b44 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -98,7 +98,7 @@ static int vmw_ldu_commit_list(struct vmw_private *dev_priv)
 		fb = entry->base.crtc.primary->state->fb;
 
 		return vmw_kms_write_svga(dev_priv, w, h, fb->pitches[0],
-					  fb->format->cpp[0] * 8,
+					  fb->format->bpp[0],
 					  fb->format->depth);
 	}
 
@@ -107,7 +107,7 @@ static int vmw_ldu_commit_list(struct vmw_private *dev_priv)
 		fb = entry->base.crtc.primary->state->fb;
 
 		vmw_kms_write_svga(dev_priv, fb->width, fb->height, fb->pitches[0],
-				   fb->format->cpp[0] * 8, fb->format->depth);
+				   fb->format->bpp[0], fb->format->depth);
 	}
 
 	/* Make sure we always show something. */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index 9a2a383..79a79e2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -487,7 +487,7 @@ static uint32_t vmw_sou_bo_define_gmrfb(struct vmw_du_update_plane *update,
 
 	gmr->header = SVGA_CMD_DEFINE_GMRFB;
 
-	gmr->body.format.bitsPerPixel = update->vfb->base.format->cpp[0] * 8;
+	gmr->body.format.bitsPerPixel = update->vfb->base.format->bpp[0];
 	gmr->body.format.colorDepth = depth;
 	gmr->body.format.reserved = 0;
 	gmr->body.bytesPerLine = update->vfb->base.pitches[0];
@@ -997,7 +997,7 @@ static int do_bo_define_gmrfb(struct vmw_private *dev_priv,
 		return -ENOMEM;
 
 	cmd->header = SVGA_CMD_DEFINE_GMRFB;
-	cmd->body.format.bitsPerPixel = framebuffer->base.format->cpp[0] * 8;
+	cmd->body.format.bitsPerPixel = framebuffer->base.format->bpp[0];
 	cmd->body.format.colorDepth = depth;
 	cmd->body.format.reserved = 0;
 	cmd->body.bytesPerLine = framebuffer->base.pitches[0];
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index f803bb5..52f0003 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1074,7 +1074,7 @@ vmw_stdu_primary_plane_prepare_fb(struct drm_plane *plane,
 		 */
 		if (new_content_type == SEPARATE_BO) {
 
-			switch (new_fb->format->cpp[0]*8) {
+			switch (new_fb->format->bpp[0]) {
 			case 32:
 				content_srf.format = SVGA3D_X8R8G8B8;
 				break;
-- 
2.7.4



