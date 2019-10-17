Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6BDFA3738
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4051E2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436564AbfJQN0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:26:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfJQN0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:26:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6755FC04AC50;
        Thu, 17 Oct 2019 13:26:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A9CE1001B23;
        Thu, 17 Oct 2019 13:26:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 91CDC9AD6; Thu, 17 Oct 2019 15:26:38 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] drm/qxl: switch qxl to &drm_gem_object_funcs.mmap
Date:   Thu, 17 Oct 2019 15:26:35 +0200
Message-Id: <20191017132638.9693-3-kraxel@redhat.com>
In-Reply-To: <20191017132638.9693-1-kraxel@redhat.com>
References: <20191017132638.9693-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 17 Oct 2019 13:26:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the new drm_gem_ttm_mmap() helper function.
Use generic drm_gem_mmap() and remove qxl_mmap().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h    |  1 -
 drivers/gpu/drm/qxl/qxl_drv.c    |  2 +-
 drivers/gpu/drm/qxl/qxl_object.c |  1 +
 drivers/gpu/drm/qxl/qxl_ttm.c    | 16 ----------------
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index d4051409ce64..a5cb3864d686 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -355,7 +355,6 @@ int qxl_mode_dumb_mmap(struct drm_file *filp,
 /* qxl ttm */
 int qxl_ttm_init(struct qxl_device *qdev);
 void qxl_ttm_fini(struct qxl_device *qdev);
-int qxl_mmap(struct file *filp, struct vm_area_struct *vma);
 
 /* qxl image */
 
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 483b4c57554a..65464630ac98 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -157,7 +157,7 @@ static const struct file_operations qxl_fops = {
 	.unlocked_ioctl = drm_ioctl,
 	.poll = drm_poll,
 	.read = drm_read,
-	.mmap = qxl_mmap,
+	.mmap = drm_gem_mmap,
 };
 
 static int qxl_drm_freeze(struct drm_device *dev)
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index c013c516f561..927ab917b834 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -86,6 +86,7 @@ static const struct drm_gem_object_funcs qxl_object_funcs = {
 	.get_sg_table = qxl_gem_prime_get_sg_table,
 	.vmap = qxl_gem_prime_vmap,
 	.vunmap = qxl_gem_prime_vunmap,
+	.mmap = drm_gem_ttm_mmap,
 	.print_info = drm_gem_ttm_print_info,
 };
 
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index dba925589e17..629ac8e77a21 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -48,22 +48,6 @@ static struct qxl_device *qxl_get_qdev(struct ttm_bo_device *bdev)
 	return qdev;
 }
 
-int qxl_mmap(struct file *filp, struct vm_area_struct *vma)
-{
-	struct drm_file *file_priv = filp->private_data;
-	struct qxl_device *qdev = file_priv->minor->dev->dev_private;
-
-	if (qdev == NULL) {
-		DRM_ERROR(
-		 "filp->private_data->minor->dev->dev_private == NULL\n");
-		return -EINVAL;
-	}
-	DRM_DEBUG_DRIVER("filp->private_data = 0x%p, vma->vm_pgoff = %lx\n",
-		  filp->private_data, vma->vm_pgoff);
-
-	return ttm_bo_mmap(filp, vma, &qdev->mman.bdev);
-}
-
 static int qxl_invalidate_caches(struct ttm_bo_device *bdev, uint32_t flags)
 {
 	return 0;
-- 
2.18.1

