Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E87CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F354720811
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfCWCeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 22:34:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727733AbfCWCeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 22:34:13 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 48DE9347B86C9A526FA9;
        Sat, 23 Mar 2019 10:34:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Mar 2019 10:34:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/vmwgfx: Remove set but not used variable 'fb_offset, fb_depth'
Date:   Sat, 23 Mar 2019 02:46:06 +0000
Message-ID: <20190323024606.163683-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/vmwgfx/vmwgfx_fb.c: In function 'vmw_fb_init':
drivers/gpu/drm/vmwgfx/vmwgfx_fb.c:645:29: warning:
 variable 'fb_offset' set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/vmwgfx/vmwgfx_fb.c:645:19: warning:
 variable 'fb_depth' set but not used [-Wunused-but-set-variable]

They're not used any more, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
index 2a9112515f46..86efb91f5034 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -642,12 +642,11 @@ int vmw_fb_init(struct vmw_private *vmw_priv)
 	struct vmw_fb_par *par;
 	struct fb_info *info;
 	unsigned fb_width, fb_height;
-	unsigned fb_bpp, fb_depth, fb_offset, fb_pitch, fb_size;
+	unsigned fb_bpp, fb_pitch, fb_size;
 	struct drm_display_mode *init_mode;
 	int ret;
 
 	fb_bpp = 32;
-	fb_depth = 24;
 
 	/* XXX As shouldn't these be as well. */
 	fb_width = min(vmw_priv->fb_max_width, (unsigned)2048);
@@ -655,7 +654,6 @@ int vmw_fb_init(struct vmw_private *vmw_priv)
 
 	fb_pitch = fb_width * fb_bpp / 8;
 	fb_size = fb_pitch * fb_height;
-	fb_offset = vmw_read(vmw_priv, SVGA_REG_FB_OFFSET);
 
 	info = framebuffer_alloc(sizeof(*par), device);
 	if (!info)



