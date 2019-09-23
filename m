Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD07C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EE720867
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502095AbfIWM4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:56:08 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:52370 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439723AbfIWM4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:56:06 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Sep 2019 08:56:04 EDT
Received: from localhost (unknown [192.168.167.227])
        by lucky1.263xmail.com (Postfix) with ESMTP id 109A842F3B;
        Mon, 23 Sep 2019 20:48:19 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P14169T140710336407296S1569242883858959_;
        Mon, 23 Sep 2019 20:48:19 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c5aed142c552fbfd0a9d05c825523723>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     hjc@rock-chips.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/36] drm/tegra: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:47:38 +0800
Message-Id: <1569242880-182878-4-git-send-email-hjc@rock-chips.com>
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
 drivers/gpu/drm/tegra/dc.c  | 2 +-
 drivers/gpu/drm/tegra/drm.c | 2 +-
 drivers/gpu/drm/tegra/fb.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index fbf57bc..850aef2 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -705,7 +705,7 @@ static void tegra_plane_atomic_update(struct drm_plane *plane,
 	window.dst.y = plane->state->dst.y1;
 	window.dst.w = drm_rect_width(&plane->state->dst);
 	window.dst.h = drm_rect_height(&plane->state->dst);
-	window.bits_per_pixel = fb->format->cpp[0] * 8;
+	window.bits_per_pixel = fb->format->bpp[0];
 	window.bottom_up = tegra_fb_is_bottom_up(fb) || state->bottom_up;
 
 	/* copy from state */
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 6fb7d74..ec6c5a2 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -973,7 +973,7 @@ static int tegra_debugfs_framebuffers(struct seq_file *s, void *data)
 		seq_printf(s, "%3d: user size: %d x %d, depth %d, %d bpp, refcount %d\n",
 			   fb->base.id, fb->width, fb->height,
 			   fb->format->depth,
-			   fb->format->cpp[0] * 8,
+			   fb->format->bpp[0],
 			   drm_framebuffer_read_refcount(fb));
 	}
 
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index e34325c..d5f5e1a 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -148,7 +148,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 			goto unreference;
 		}
 
-		bpp = info->cpp[i];
+		bpp = info->bpp[i] / 8;
 
 		size = (height - 1) * cmd->pitches[i] +
 		       width * bpp + cmd->offsets[i];
-- 
2.7.4



