Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76939C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542512189D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbfHHNo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58587 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733254AbfHHNoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:44:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FC1E30DD076;
        Thu,  8 Aug 2019 13:44:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B46AF1001284;
        Thu,  8 Aug 2019 13:44:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 05EEE9D34; Thu,  8 Aug 2019 15:44:20 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 10/17] drm/vram: switch vram helper to drm_gem_object_funcs->mmap codepath
Date:   Thu,  8 Aug 2019 15:44:10 +0200
Message-Id: <20190808134417.10610-11-kraxel@redhat.com>
In-Reply-To: <20190808134417.10610-1-kraxel@redhat.com>
References: <20190808134417.10610-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 08 Aug 2019 13:44:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... using the new drm_gem_ttm_mmap() helper function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_vram_mm_helper.h      |  9 +--------
 drivers/gpu/drm/drm_gem_vram_helper.c |  4 +++-
 drivers/gpu/drm/drm_vram_mm_helper.c  | 27 ---------------------------
 3 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/include/drm/drm_vram_mm_helper.h b/include/drm/drm_vram_mm_helper.h
index 2aacfb1ccfae..ff328bdaa638 100644
--- a/include/drm/drm_vram_mm_helper.h
+++ b/include/drm/drm_vram_mm_helper.h
@@ -77,13 +77,6 @@ struct drm_vram_mm *drm_vram_helper_alloc_mm(
 	const struct drm_vram_mm_funcs *funcs);
 void drm_vram_helper_release_mm(struct drm_device *dev);
 
-/*
- * Helpers for &struct file_operations
- */
-
-int drm_vram_mm_file_operations_mmap(
-	struct file *filp, struct vm_area_struct *vma);
-
 /**
  * define DRM_VRAM_MM_FILE_OPERATIONS - default callback functions for \
 	&struct file_operations
@@ -97,7 +90,7 @@ int drm_vram_mm_file_operations_mmap(
 	.poll		= drm_poll, \
 	.unlocked_ioctl = drm_ioctl, \
 	.compat_ioctl	= drm_compat_ioctl, \
-	.mmap		= drm_vram_mm_file_operations_mmap, \
+	.mmap		= drm_gem_mmap, \
 	.open		= drm_open, \
 	.release	= drm_release \
 
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index b78865055990..ed1625f6a296 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_gem_vram_helper.h>
 #include <drm/drm_device.h>
 #include <drm/drm_mode.h>
@@ -585,5 +586,6 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs = {
 	.pin	= drm_gem_vram_object_pin,
 	.unpin	= drm_gem_vram_object_unpin,
 	.vmap	= drm_gem_vram_object_vmap,
-	.vunmap	= drm_gem_vram_object_vunmap
+	.vunmap	= drm_gem_vram_object_vunmap,
+	.mmap   = drm_gem_ttm_mmap,
 };
diff --git a/drivers/gpu/drm/drm_vram_mm_helper.c b/drivers/gpu/drm/drm_vram_mm_helper.c
index a693f9ce356c..8f6e26b3da69 100644
--- a/drivers/gpu/drm/drm_vram_mm_helper.c
+++ b/drivers/gpu/drm/drm_vram_mm_helper.c
@@ -268,30 +268,3 @@ void drm_vram_helper_release_mm(struct drm_device *dev)
 	dev->vram_mm = NULL;
 }
 EXPORT_SYMBOL(drm_vram_helper_release_mm);
-
-/*
- * Helpers for &struct file_operations
- */
-
-/**
- * drm_vram_mm_file_operations_mmap() - \
-	Implements &struct file_operations.mmap()
- * @filp:	the mapping's file structure
- * @vma:	the mapping's memory area
- *
- * Returns:
- * 0 on success, or
- * a negative error code otherwise.
- */
-int drm_vram_mm_file_operations_mmap(
-	struct file *filp, struct vm_area_struct *vma)
-{
-	struct drm_file *file_priv = filp->private_data;
-	struct drm_device *dev = file_priv->minor->dev;
-
-	if (WARN_ONCE(!dev->vram_mm, "VRAM MM not initialized"))
-		return -EINVAL;
-
-	return drm_vram_mm_mmap(filp, vma, dev->vram_mm);
-}
-EXPORT_SYMBOL(drm_vram_mm_file_operations_mmap);
-- 
2.18.1

