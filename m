Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BA2C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A9921874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390047AbfHHNpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:45:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733259AbfHHNoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:44:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A80FC315C01C;
        Thu,  8 Aug 2019 13:44:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CB3660BE1;
        Thu,  8 Aug 2019 13:44:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E77EE9CAC; Thu,  8 Aug 2019 15:44:20 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 15/17] drm/qxl: switch qxl to drm_gem_object_funcs->mmap codepath
Date:   Thu,  8 Aug 2019 15:44:15 +0200
Message-Id: <20190808134417.10610-16-kraxel@redhat.com>
In-Reply-To: <20190808134417.10610-1-kraxel@redhat.com>
References: <20190808134417.10610-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 08 Aug 2019 13:44:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... using the use drm_gem_ttm_mmap() helper function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h    |  1 -
 drivers/gpu/drm/qxl/qxl_drv.c    |  2 +-
 drivers/gpu/drm/qxl/qxl_object.c |  1 +
 drivers/gpu/drm/qxl/qxl_ttm.c    | 16 ----------------
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 82efbe76062a..dc36479a54f2 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -352,7 +352,6 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 /* qxl ttm */
 int qxl_ttm_init(struct qxl_device *qdev);
 void qxl_ttm_fini(struct qxl_device *qdev);
-int qxl_mmap(struct file *filp, struct vm_area_struct *vma);
 
 /* qxl image */
 
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 38467478c7b2..2fb1641c817e 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -139,7 +139,7 @@ static const struct file_operations qxl_fops = {
 	.unlocked_ioctl = drm_ioctl,
 	.poll = drm_poll,
 	.read = drm_read,
-	.mmap = qxl_mmap,
+	.mmap = drm_gem_mmap,
 };
 
 static int qxl_drm_freeze(struct drm_device *dev)
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 29aab7b14513..5c503829c580 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -86,6 +86,7 @@ static const struct drm_gem_object_funcs qxl_object_funcs = {
 	.get_sg_table = qxl_gem_prime_get_sg_table,
 	.vmap = qxl_gem_prime_vmap,
 	.vunmap = qxl_gem_prime_vunmap,
+	.mmap = drm_gem_ttm_mmap,
 };
 
 int qxl_bo_create(struct qxl_device *qdev,
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 41edbde0e37e..dbaed0e67c21 100644
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

