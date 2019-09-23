Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2297C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C338720578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439741AbfIWM4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:56:22 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:45492 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437548AbfIWM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:56:20 -0400
Received: from localhost (unknown [192.168.167.227])
        by lucky1.263xmail.com (Postfix) with ESMTP id 0560F5CA40;
        Mon, 23 Sep 2019 20:48:18 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P14169T140710336407296S1569242883858959_;
        Mon, 23 Sep 2019 20:48:17 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <6dc34a8606be9c4da5e7b4229724bf36>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>
Cc:     nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/36] drm/nouveau: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:47:37 +0800
Message-Id: <1569242880-182878-3-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569242880-182878-1-git-send-email-hjc@rock-chips.com>
References: <1569242880-182878-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c     | 7 ++++---
 drivers/gpu/drm/nouveau/dispnv50/base507c.c | 4 ++--
 drivers/gpu/drm/nouveau/dispnv50/ovly507e.c | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index f22f010..59d2f07 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -874,11 +874,12 @@ nv04_crtc_do_mode_set_base(struct drm_crtc *crtc,
 
 	/* Update the framebuffer location. */
 	regp->fb_start = nv_crtc->fb.offset & ~3;
-	regp->fb_start += (y * drm_fb->pitches[0]) + (x * drm_fb->format->cpp[0]);
+	regp->fb_start += (y * drm_fb->pitches[0]) +
+				(x * drm_fb->format->bpp[0] / 8);
 	nv_set_crtc_base(dev, nv_crtc->index, regp->fb_start);
 
 	/* Update the arbitration parameters. */
-	nouveau_calc_arb(dev, crtc->mode.clock, drm_fb->format->cpp[0] * 8,
+	nouveau_calc_arb(dev, crtc->mode.clock, drm_fb->format->bpp[0],
 			 &arb_burst, &arb_lwm);
 
 	regp->CRTC[NV_CIO_CRE_FF_INDEX] = arb_burst;
@@ -1238,7 +1239,7 @@ nv04_crtc_page_flip(struct drm_crtc *crtc, struct drm_framebuffer *fb,
 
 	/* Initialize a page flip struct */
 	*s = (struct nv04_page_flip_state)
-		{ { }, event, crtc, fb->format->cpp[0] * 8, fb->pitches[0],
+		{ { }, event, crtc, fb->format->bpp[0], fb->pitches[0],
 		  new_bo->bo.offset };
 
 	/* Keep vblanks on during flip, for the target crtc of this flip */
diff --git a/drivers/gpu/drm/nouveau/dispnv50/base507c.c b/drivers/gpu/drm/nouveau/dispnv50/base507c.c
index d5e295c..59883bd0 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/base507c.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/base507c.c
@@ -190,12 +190,12 @@ base507c_acquire(struct nv50_wndw *wndw, struct nv50_wndw_atom *asyw,
 		return ret;
 
 	if (!wndw->func->ilut) {
-		if ((asyh->base.cpp != 1) ^ (fb->format->cpp[0] != 1))
+		if (asyh->base.cpp != 1 ^ fb->format->bpp[0] != 8)
 			asyh->state.color_mgmt_changed = true;
 	}
 
 	asyh->base.depth = fb->format->depth;
-	asyh->base.cpp = fb->format->cpp[0];
+	asyh->base.cpp = fb->format->bpp[0] / 8;
 	asyh->base.x = asyw->state.src.x1 >> 16;
 	asyh->base.y = asyw->state.src.y1 >> 16;
 	asyh->base.w = asyw->state.fb->width;
diff --git a/drivers/gpu/drm/nouveau/dispnv50/ovly507e.c b/drivers/gpu/drm/nouveau/dispnv50/ovly507e.c
index cc41766..c6c2e0b 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/ovly507e.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/ovly507e.c
@@ -135,7 +135,7 @@ ovly507e_acquire(struct nv50_wndw *wndw, struct nv50_wndw_atom *asyw,
 	if (ret)
 		return ret;
 
-	asyh->ovly.cpp = fb->format->cpp[0];
+	asyh->ovly.cpp = fb->format->bpp[0] / 8;
 	return 0;
 }
 
-- 
2.7.4



