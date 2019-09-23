Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BA5C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C755720820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501998AbfIWMth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:49:37 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:41492 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbfIWMtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:49:36 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.175])
        by regular1.263xmail.com (Postfix) with ESMTP id 51CD1340;
        Mon, 23 Sep 2019 20:49:33 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P28975T139999806740224S1569242970112868_;
        Mon, 23 Sep 2019 20:49:32 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b51224ed549f04fece0cf705ffb16e26>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Shawn Guo <shawnguo@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, linux-kernel@vger.kernel.org
Subject: [PATCH 17/36] drm/zte: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:49:09 +0800
Message-Id: <1569242968-183093-2-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569242968-183093-1-git-send-email-hjc@rock-chips.com>
References: <1569242968-183093-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/zte/zx_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/zte/zx_plane.c b/drivers/gpu/drm/zte/zx_plane.c
index 086c50f..c265dd3 100644
--- a/drivers/gpu/drm/zte/zx_plane.c
+++ b/drivers/gpu/drm/zte/zx_plane.c
@@ -218,7 +218,7 @@ static void zx_vl_plane_atomic_update(struct drm_plane *plane,
 		cma_obj = drm_fb_cma_get_gem_obj(fb, i);
 		paddr = cma_obj->paddr + fb->offsets[i];
 		paddr += src_y * fb->pitches[i];
-		paddr += src_x * fb->format->cpp[i];
+		paddr += src_x * fb->format->bpp[i] / 8;
 		zx_writel(paddr_reg, paddr);
 		paddr_reg += 4;
 	}
@@ -379,7 +379,7 @@ static void zx_gl_plane_atomic_update(struct drm_plane *plane,
 	dst_w = plane->state->crtc_w;
 	dst_h = plane->state->crtc_h;
 
-	bpp = fb->format->cpp[0];
+	bpp = fb->format->bpp[0] / 8;
 
 	cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
 	paddr = cma_obj->paddr + fb->offsets[0];
-- 
2.7.4



