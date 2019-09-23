Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E5C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A9520820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439734AbfIWM4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:56:06 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:48462 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437481AbfIWM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:56:05 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Sep 2019 08:56:02 EDT
Received: from localhost (unknown [192.168.167.227])
        by lucky1.263xmail.com (Postfix) with ESMTP id 1CBF866344;
        Mon, 23 Sep 2019 20:48:05 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P14169T140710336407296S1569242883858959_;
        Mon, 23 Sep 2019 20:48:04 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <dcbf38747a55e5c1495e51f206d0b1dd>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, linux-kernel@vger.kernel.org
Subject: [PATCH 11/36] drm/armada: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:47:35 +0800
Message-Id: <1569242880-182878-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/armada/armada_fbdev.c | 2 +-
 drivers/gpu/drm/armada/armada_plane.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index 090cc0d..a2e4344 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -88,7 +88,7 @@ static int armada_fbdev_create(struct drm_fb_helper *fbh,
 	drm_fb_helper_fill_info(info, fbh, sizes);
 
 	DRM_DEBUG_KMS("allocated %dx%d %dbpp fb: 0x%08llx\n",
-		dfb->fb.width, dfb->fb.height, dfb->fb.format->cpp[0] * 8,
+		dfb->fb.width, dfb->fb.height, dfb->fb.format->bpp[0],
 		(unsigned long long)obj->phys_addr);
 
 	return 0;
diff --git a/drivers/gpu/drm/armada/armada_plane.c b/drivers/gpu/drm/armada/armada_plane.c
index e7cc2b3..fa400ac 100644
--- a/drivers/gpu/drm/armada/armada_plane.c
+++ b/drivers/gpu/drm/armada/armada_plane.c
@@ -46,13 +46,13 @@ void armada_drm_plane_calc(struct drm_plane_state *state, u32 addrs[2][3],
 	int i;
 
 	DRM_DEBUG_KMS("pitch %u x %d y %d bpp %d\n",
-		      fb->pitches[0], x, y, format->cpp[0] * 8);
+		      fb->pitches[0], x, y, format->bpp[0]);
 
 	if (num_planes > 3)
 		num_planes = 3;
 
 	addrs[0][0] = addr + fb->offsets[0] + y * fb->pitches[0] +
-		      x * format->cpp[0];
+		      x * format->bpp[0] / 8;
 	pitches[0] = fb->pitches[0];
 
 	y /= format->vsub;
@@ -60,7 +60,7 @@ void armada_drm_plane_calc(struct drm_plane_state *state, u32 addrs[2][3],
 
 	for (i = 1; i < num_planes; i++) {
 		addrs[0][i] = addr + fb->offsets[i] + y * fb->pitches[i] +
-			      x * format->cpp[i];
+			      x * format->bpp[i] / 8;
 		pitches[i] = fb->pitches[i];
 	}
 	for (; i < 3; i++) {
-- 
2.7.4



