Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8556EC10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FA9217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553910076;
	bh=lP2QcxScV6zoM7l+Br6BXGxYapT2k8YMhNYzFadyJDw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sios7M7rfgKuaQ073/xF7NQ2B89XqRqzDwaklgGjJDu2TUyyEpJjKTFsf4b9Dh5eV
	 TvTp8wVfiOJcpXWkQDysfqZ8TDigg/fubAJdp5YkPYRyvXDiIXela+GHmWOvSUSy9o
	 UCN6+ifSR+NtKHXDStLM4oDgnvwyJOh13cRASmCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfC3B3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730494AbfC3B25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:28:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C2A0217F5;
        Sat, 30 Mar 2019 01:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909336;
        bh=lP2QcxScV6zoM7l+Br6BXGxYapT2k8YMhNYzFadyJDw=;
        h=From:To:Cc:Subject:Date:From;
        b=ct3kpuKNFqmojvk7DVQWSszNS1A9t3kn0ipSidL3XLPn9HSNau+7OI0GLstoLWnaz
         9WGyVxvAbORsvxG+KHC1ivKqMqSDrCJxQ0C2+PyT4zEkaIuRk3WT0F4UpFb9nnruyO
         JJMv4nFG/GMoaLOCgQ/UbK5Cm5ZprqG8XJMWNdu8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 01/57] drm/cirrus: Use drm_framebuffer_put to avoid kernel oops in clean-up
Date:   Fri, 29 Mar 2019 21:27:54 -0400
Message-Id: <20190330012854.32212-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit abf7b30d7f61d981bfcca65d1e8331b27021b475 ]

In the Cirrus driver, the regular clean-up code also performs the clean-up
of a failed initialization. If the fbdev's framebuffer was not initialized,
the clean-up will fail within drm_framebuffer_unregister_private. Booting
with cirrus.bpp=16 triggers this bug.

The framebuffer is currently stored directly within struct cirrus_fbdev. To
fix the bug, we turn it into a pointer that is only set for initialized
framebuffers. The fbdev's clean-up code skips uninitialized framebuffers.

The memory for struct drm_framebuffer is allocated dynamically. This requires
additional error handling within cirrusfb_create. The framebuffer clean-up is
now performed by drm_framebuffer_put, which also frees the data strcuture's
memory.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1101822
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: http://patchwork.freedesktop.org/patch/msgid/20180720112743.27159-1-tzimmermann@suse.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/cirrus/cirrus_drv.h   |  2 +-
 drivers/gpu/drm/cirrus/cirrus_fbdev.c | 48 +++++++++++++++------------
 drivers/gpu/drm/cirrus/cirrus_mode.c  |  2 +-
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.h b/drivers/gpu/drm/cirrus/cirrus_drv.h
index ce9db7aab225..a29f87e98d9d 100644
--- a/drivers/gpu/drm/cirrus/cirrus_drv.h
+++ b/drivers/gpu/drm/cirrus/cirrus_drv.h
@@ -146,7 +146,7 @@ struct cirrus_device {
 
 struct cirrus_fbdev {
 	struct drm_fb_helper helper;
-	struct drm_framebuffer gfb;
+	struct drm_framebuffer *gfb;
 	void *sysram;
 	int size;
 	int x1, y1, x2, y2; /* dirty rect */
diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
index b643ac92801c..82cc82e0bd80 100644
--- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
+++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
@@ -22,14 +22,14 @@ static void cirrus_dirty_update(struct cirrus_fbdev *afbdev,
 	struct drm_gem_object *obj;
 	struct cirrus_bo *bo;
 	int src_offset, dst_offset;
-	int bpp = afbdev->gfb.format->cpp[0];
+	int bpp = afbdev->gfb->format->cpp[0];
 	int ret = -EBUSY;
 	bool unmap = false;
 	bool store_for_later = false;
 	int x2, y2;
 	unsigned long flags;
 
-	obj = afbdev->gfb.obj[0];
+	obj = afbdev->gfb->obj[0];
 	bo = gem_to_cirrus_bo(obj);
 
 	/*
@@ -82,7 +82,7 @@ static void cirrus_dirty_update(struct cirrus_fbdev *afbdev,
 	}
 	for (i = y; i < y + height; i++) {
 		/* assume equal stride for now */
-		src_offset = dst_offset = i * afbdev->gfb.pitches[0] + (x * bpp);
+		src_offset = dst_offset = i * afbdev->gfb->pitches[0] + (x * bpp);
 		memcpy_toio(bo->kmap.virtual + src_offset, afbdev->sysram + src_offset, width * bpp);
 
 	}
@@ -192,23 +192,26 @@ static int cirrusfb_create(struct drm_fb_helper *helper,
 		return -ENOMEM;
 
 	info = drm_fb_helper_alloc_fbi(helper);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
+	if (IS_ERR(info)) {
+		ret = PTR_ERR(info);
+		goto err_vfree;
+	}
 
 	info->par = gfbdev;
 
-	ret = cirrus_framebuffer_init(cdev->dev, &gfbdev->gfb, &mode_cmd, gobj);
+	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
+	if (!fb) {
+		ret = -ENOMEM;
+		goto err_drm_gem_object_put_unlocked;
+	}
+
+	ret = cirrus_framebuffer_init(cdev->dev, fb, &mode_cmd, gobj);
 	if (ret)
-		return ret;
+		goto err_kfree;
 
 	gfbdev->sysram = sysram;
 	gfbdev->size = size;
-
-	fb = &gfbdev->gfb;
-	if (!fb) {
-		DRM_INFO("fb is NULL\n");
-		return -EINVAL;
-	}
+	gfbdev->gfb = fb;
 
 	/* setup helper */
 	gfbdev->helper.fb = fb;
@@ -241,24 +244,27 @@ static int cirrusfb_create(struct drm_fb_helper *helper,
 	DRM_INFO("   pitch is %d\n", fb->pitches[0]);
 
 	return 0;
+
+err_kfree:
+	kfree(fb);
+err_drm_gem_object_put_unlocked:
+	drm_gem_object_put_unlocked(gobj);
+err_vfree:
+	vfree(sysram);
+	return ret;
 }
 
 static int cirrus_fbdev_destroy(struct drm_device *dev,
 				struct cirrus_fbdev *gfbdev)
 {
-	struct drm_framebuffer *gfb = &gfbdev->gfb;
+	struct drm_framebuffer *gfb = gfbdev->gfb;
 
 	drm_fb_helper_unregister_fbi(&gfbdev->helper);
 
-	if (gfb->obj[0]) {
-		drm_gem_object_put_unlocked(gfb->obj[0]);
-		gfb->obj[0] = NULL;
-	}
-
 	vfree(gfbdev->sysram);
 	drm_fb_helper_fini(&gfbdev->helper);
-	drm_framebuffer_unregister_private(gfb);
-	drm_framebuffer_cleanup(gfb);
+	if (gfb)
+		drm_framebuffer_put(gfb);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index 336bfda40125..90a4e641d3fb 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -127,7 +127,7 @@ static int cirrus_crtc_do_set_base(struct drm_crtc *crtc,
 		return ret;
 	}
 
-	if (&cdev->mode_info.gfbdev->gfb == crtc->primary->fb) {
+	if (cdev->mode_info.gfbdev->gfb == crtc->primary->fb) {
 		/* if pushing console in kmap it */
 		ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages, &bo->kmap);
 		if (ret)
-- 
2.19.1

