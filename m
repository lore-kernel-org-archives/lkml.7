Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FE6C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52D021881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfIQJYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:24:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfIQJYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBB78308A968;
        Tue, 17 Sep 2019 09:24:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F5575C21A;
        Tue, 17 Sep 2019 09:24:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D20919D34; Tue, 17 Sep 2019 11:24:05 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 06/11] drm/ttm: factor out ttm_bo_mmap_vma_setup
Date:   Tue, 17 Sep 2019 11:23:59 +0200
Message-Id: <20190917092404.9982-7-kraxel@redhat.com>
In-Reply-To: <20190917092404.9982-1-kraxel@redhat.com>
References: <20190917092404.9982-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 17 Sep 2019 09:24:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out ttm vma setup to a new function.  Reduces
code duplication a bit and allows to implement
&drm_gem_object_funcs.mmap in gem ttm helpers.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/ttm/ttm_bo_api.h    |  8 ++++++
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 47 ++++++++++++++++++---------------
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 43c4929a2171..88c652f49602 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -734,6 +734,14 @@ int ttm_fbdev_mmap(struct vm_area_struct *vma, struct ttm_buffer_object *bo);
 int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
 		struct ttm_bo_device *bdev);
 
+/**
+ * ttm_bo_mmap_vma_setup - initialize vma for ttm bo mmap
+ *
+ * @bo: The buffer object.
+ * @vma: vma as input from the mmap method.
+ */
+void ttm_bo_mmap_vma_setup(struct ttm_buffer_object *bo, struct vm_area_struct *vma);
+
 void *ttm_kmap_atomic_prot(struct page *page, pgprot_t prot);
 
 void ttm_kunmap_atomic_prot(void *addr, pgprot_t prot);
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 4aa007edffb0..7c0e85c10e0e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -426,6 +426,29 @@ static struct ttm_buffer_object *ttm_bo_vm_lookup(struct ttm_bo_device *bdev,
 	return bo;
 }
 
+void ttm_bo_mmap_vma_setup(struct ttm_buffer_object *bo, struct vm_area_struct *vma)
+{
+	vma->vm_ops = &ttm_bo_vm_ops;
+
+	/*
+	 * Note: We're transferring the bo reference to
+	 * vma->vm_private_data here.
+	 */
+
+	vma->vm_private_data = bo;
+
+	/*
+	 * We'd like to use VM_PFNMAP on shared mappings, where
+	 * (vma->vm_flags & VM_SHARED) != 0, for performance reasons,
+	 * but for some reason VM_PFNMAP + x86 PAT + write-combine is very
+	 * bad for performance. Until that has been sorted out, use
+	 * VM_MIXEDMAP on all mappings. See freedesktop.org bug #75719
+	 */
+	vma->vm_flags |= VM_MIXEDMAP;
+	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
+}
+EXPORT_SYMBOL(ttm_bo_mmap_vma_setup);
+
 int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
 		struct ttm_bo_device *bdev)
 {
@@ -449,24 +472,7 @@ int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
 	if (unlikely(ret != 0))
 		goto out_unref;
 
-	vma->vm_ops = &ttm_bo_vm_ops;
-
-	/*
-	 * Note: We're transferring the bo reference to
-	 * vma->vm_private_data here.
-	 */
-
-	vma->vm_private_data = bo;
-
-	/*
-	 * We'd like to use VM_PFNMAP on shared mappings, where
-	 * (vma->vm_flags & VM_SHARED) != 0, for performance reasons,
-	 * but for some reason VM_PFNMAP + x86 PAT + write-combine is very
-	 * bad for performance. Until that has been sorted out, use
-	 * VM_MIXEDMAP on all mappings. See freedesktop.org bug #75719
-	 */
-	vma->vm_flags |= VM_MIXEDMAP;
-	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
+	ttm_bo_mmap_vma_setup(bo, vma);
 	return 0;
 out_unref:
 	ttm_bo_put(bo);
@@ -481,10 +487,7 @@ int ttm_fbdev_mmap(struct vm_area_struct *vma, struct ttm_buffer_object *bo)
 
 	ttm_bo_get(bo);
 
-	vma->vm_ops = &ttm_bo_vm_ops;
-	vma->vm_private_data = bo;
-	vma->vm_flags |= VM_MIXEDMAP;
-	vma->vm_flags |= VM_IO | VM_DONTEXPAND;
+	ttm_bo_mmap_vma_setup(bo, vma);
 	return 0;
 }
 EXPORT_SYMBOL(ttm_fbdev_mmap);
-- 
2.18.1

