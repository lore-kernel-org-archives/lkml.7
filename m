Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DDBFA3737
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803AD2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436546AbfJQN0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:26:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394624AbfJQN0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:26:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BD3589ACA;
        Thu, 17 Oct 2019 13:26:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76FEC1001B11;
        Thu, 17 Oct 2019 13:26:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 61A5E9D72; Thu, 17 Oct 2019 15:26:38 +0200 (CEST)
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
Subject: [PATCH 1/5] drm/qxl: drop qxl_ttm_fault
Date:   Thu, 17 Oct 2019 15:26:34 +0200
Message-Id: <20191017132638.9693-2-kraxel@redhat.com>
In-Reply-To: <20191017132638.9693-1-kraxel@redhat.com>
References: <20191017132638.9693-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 17 Oct 2019 13:26:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure what this hook is supposed to do.  vmf->vma->vm_private_data
should never be NULL, so the extra check in qxl_ttm_fault should have no
effect.

Drop it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index cbc6c2ba8630..dba925589e17 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -48,24 +48,8 @@ static struct qxl_device *qxl_get_qdev(struct ttm_bo_device *bdev)
 	return qdev;
 }
 
-static struct vm_operations_struct qxl_ttm_vm_ops;
-static const struct vm_operations_struct *ttm_vm_ops;
-
-static vm_fault_t qxl_ttm_fault(struct vm_fault *vmf)
-{
-	struct ttm_buffer_object *bo;
-	vm_fault_t ret;
-
-	bo = (struct ttm_buffer_object *)vmf->vma->vm_private_data;
-	if (bo == NULL)
-		return VM_FAULT_NOPAGE;
-	ret = ttm_vm_ops->fault(vmf);
-	return ret;
-}
-
 int qxl_mmap(struct file *filp, struct vm_area_struct *vma)
 {
-	int r;
 	struct drm_file *file_priv = filp->private_data;
 	struct qxl_device *qdev = file_priv->minor->dev->dev_private;
 
@@ -77,16 +61,7 @@ int qxl_mmap(struct file *filp, struct vm_area_struct *vma)
 	DRM_DEBUG_DRIVER("filp->private_data = 0x%p, vma->vm_pgoff = %lx\n",
 		  filp->private_data, vma->vm_pgoff);
 
-	r = ttm_bo_mmap(filp, vma, &qdev->mman.bdev);
-	if (unlikely(r != 0))
-		return r;
-	if (unlikely(ttm_vm_ops == NULL)) {
-		ttm_vm_ops = vma->vm_ops;
-		qxl_ttm_vm_ops = *ttm_vm_ops;
-		qxl_ttm_vm_ops.fault = &qxl_ttm_fault;
-	}
-	vma->vm_ops = &qxl_ttm_vm_ops;
-	return 0;
+	return ttm_bo_mmap(filp, vma, &qdev->mman.bdev);
 }
 
 static int qxl_invalidate_caches(struct ttm_bo_device *bdev, uint32_t flags)
-- 
2.18.1

