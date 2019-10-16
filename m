Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43E9FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF62520854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfJPLwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:52:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391183AbfJPLwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:52:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F0CCC010931;
        Wed, 16 Oct 2019 11:52:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1034160C57;
        Wed, 16 Oct 2019 11:52:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C1A4E31E94; Wed, 16 Oct 2019 13:52:04 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 06/11] drm/ttm: factor out ttm_bo_mmap_vma_setup
Date:   Wed, 16 Oct 2019 13:51:58 +0200
Message-Id: <20191016115203.20095-7-kraxel@redhat.com>
In-Reply-To: <20191016115203.20095-1-kraxel@redhat.com>
References: <20191016115203.20095-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 16 Oct 2019 11:52:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out ttm vma setup to a new function.
Reduces code duplication a bit.

v2: don't change vm_flags (moved to separate patch).
v4: make ttm_bo_mmap_vma_setup static.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 46 +++++++++++++++++----------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 4aa007edffb0..53345c0854d5 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -426,6 +426,28 @@ static struct ttm_buffer_object *ttm_bo_vm_lookup(struct ttm_bo_device *bdev,
 	return bo;
 }
 
+static void ttm_bo_mmap_vma_setup(struct ttm_buffer_object *bo, struct vm_area_struct *vma)
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
+
 int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
 		struct ttm_bo_device *bdev)
 {
@@ -449,24 +471,7 @@ int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
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
@@ -481,10 +486,7 @@ int ttm_fbdev_mmap(struct vm_area_struct *vma, struct ttm_buffer_object *bo)
 
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

