Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63384C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C988204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McTp+znF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfDPSjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:39:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37038 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730394AbfDPSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so28530891wrm.4;
        Tue, 16 Apr 2019 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ChKopfoupFge33png/zSgg0/Me6vW1jw2fNJBJMBrnc=;
        b=McTp+znFMf77DiIPnjsK1LrQkfN2cwQmcZtUief580NYmDQtHl/viqBJz7yD4miGdy
         VfEmX8sPT2xq00qcjYjn7fgXxzZue621wOyH4iaIp7u1G4kbLsQx7l6Txv+a5UO0Rgy8
         dQO/nI+0ytdlV96XsGpldWxmIEvUBiVXF94m8EG45PbSBb1VB9ZVTMNdt25HyIQAjxCn
         Pd0WzUQn4TQBeX00zPgEJsF87VFts4c8A2Ti+lah7PbC8LbJja05xbgUbbOIdQ2pOpLc
         AMYdamPR8jHyw9dPQ0ZiH9CPDBshkQfAkpGLnnylpzefIQgJuCpXniV6KS292S31ubXI
         bh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ChKopfoupFge33png/zSgg0/Me6vW1jw2fNJBJMBrnc=;
        b=RmXuXPIlACIX02c+e660lUK0Fhc0IM6LuYPVaCHIfoPwsr1w6ewMmxwt8fC8119wha
         ZK+Foe80e5PwBV4hAi/dtPH27+19Ir4/JfUj2Z+jtqaMXbsdZlI9ZtSKdJ0TcRkBoeoI
         rFtAak/OH1q0NI4onCmkIVwEu4ZVBbluBwe8Sa7EaRv72y7464TJKlPTAxv0o6ZRFMEc
         VfRVecuR/pqdbPvkU90dbwc6DoSP+BRsllPuSW2w+aAbwbrdeIqY5zC36qvqpTEraN/g
         o94vhCBYgIeXeOoQedzCkkhKSa+DORo6AueBzXbzHMV8VCEEKsteqn/YL6UEtm/FJ/3/
         AP8A==
X-Gm-Message-State: APjAAAXQKmp7Np7q2qr6LcqB8JdJv1ypmKkG1WaLkyaBz3xBcPgoLxY+
        s4FiTkDzC/kwewzJT/1WIM8=
X-Google-Smtp-Source: APXvYqwPsafk98sVT9BMZZD/IK2w6Yj4L+4ov86IKcyy9N2khLee5IFOC179tRpeueFmqMv3flzBOA==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr55191326wrn.108.1555439935399;
        Tue, 16 Apr 2019 11:38:55 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:54 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/12] drm/amdgpu: add independent DMA-buf import v4
Date:   Tue, 16 Apr 2019 20:38:39 +0200
Message-Id: <20190416183841.1577-11-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416183841.1577-1-christian.koenig@amd.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on the DRM functions just implement our own import
functions. This prepares support for taking care of unpinned DMA-buf.

v2: enable for all exporters, not just amdgpu, fix invalidation
    handling, lock reservation object while setting callback
v3: change to new dma_buf attach interface
v4: split out from unpinned DMA-buf work

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h   |  4 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 42 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   | 34 +++++++++++++++---
 4 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f1815223a1a1..95195c427e85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1254,7 +1254,6 @@ static struct drm_driver kms_driver = {
 	.gem_prime_export = amdgpu_gem_prime_export,
 	.gem_prime_import = amdgpu_gem_prime_import,
 	.gem_prime_res_obj = amdgpu_gem_prime_res_obj,
-	.gem_prime_import_sg_table = amdgpu_gem_prime_import_sg_table,
 	.gem_prime_vmap = amdgpu_gem_prime_vmap,
 	.gem_prime_vunmap = amdgpu_gem_prime_vunmap,
 	.gem_prime_mmap = amdgpu_gem_prime_mmap,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index 0c50d14a9739..01811d8aa8a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -39,10 +39,6 @@ int amdgpu_gem_object_open(struct drm_gem_object *obj,
 void amdgpu_gem_object_close(struct drm_gem_object *obj,
 				struct drm_file *file_priv);
 unsigned long amdgpu_gem_timeout(uint64_t timeout_ns);
-struct drm_gem_object *
-amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
-				 struct dma_buf_attachment *attach,
-				 struct sg_table *sg);
 struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
 					struct drm_gem_object *gobj,
 					int flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
index 8d748f9d0292..56e2a606b9a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
@@ -122,31 +122,28 @@ int amdgpu_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma
 }
 
 /**
- * amdgpu_gem_prime_import_sg_table - &drm_driver.gem_prime_import_sg_table
- * implementation
+ * amdgpu_gem_prime_create_obj - create BO for DMA-buf import
+ *
  * @dev: DRM device
- * @attach: DMA-buf attachment
- * @sg: Scatter/gather table
+ * @dma_buf: DMA-buf
  *
- * Imports shared DMA buffer memory exported by another device.
+ * Creates an empty SG BO for DMA-buf import.
  *
  * Returns:
  * A new GEM BO of the given DRM device, representing the memory
  * described by the given DMA-buf attachment and scatter/gather table.
  */
-struct drm_gem_object *
-amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
-				 struct dma_buf_attachment *attach,
-				 struct sg_table *sg)
+static struct drm_gem_object *
+amdgpu_gem_prime_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 {
-	struct reservation_object *resv = attach->dmabuf->resv;
+	struct reservation_object *resv = dma_buf->resv;
 	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_bo *bo;
 	struct amdgpu_bo_param bp;
 	int ret;
 
 	memset(&bp, 0, sizeof(bp));
-	bp.size = attach->dmabuf->size;
+	bp.size = dma_buf->size;
 	bp.byte_align = PAGE_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_CPU;
 	bp.flags = 0;
@@ -157,11 +154,9 @@ amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
 	if (ret)
 		goto error;
 
-	bo->tbo.sg = sg;
-	bo->tbo.ttm->sg = sg;
 	bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
 	bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
-	if (attach->dmabuf->ops != &amdgpu_dmabuf_ops)
+	if (dma_buf->ops != &amdgpu_dmabuf_ops)
 		bo->prime_shared_count = 1;
 
 	ww_mutex_unlock(&resv->lock);
@@ -417,6 +412,11 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
 struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 					    struct dma_buf *dma_buf)
 {
+	struct dma_buf_attach_info attach_info = {
+		.dev = dev->dev,
+		.dmabuf = dma_buf,
+	};
+	struct dma_buf_attachment *attach;
 	struct drm_gem_object *obj;
 
 	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
@@ -431,5 +431,17 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 		}
 	}
 
-	return drm_gem_prime_import(dev, dma_buf);
+	obj = amdgpu_gem_prime_create_obj(dev, dma_buf);
+	if (IS_ERR(obj))
+		return obj;
+
+	attach = dma_buf_attach(&attach_info);
+	if (IS_ERR(attach)) {
+		drm_gem_object_put(obj);
+		return ERR_CAST(attach);
+	}
+
+	get_dma_buf(dma_buf);
+	obj->import_attach = attach;
+	return obj;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c14198737dcd..afccca5b1f5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -44,6 +44,7 @@
 #include <linux/debugfs.h>
 #include <linux/iommu.h>
 #include <linux/hmm.h>
+#include <linux/dma-buf.h>
 #include "amdgpu.h"
 #include "amdgpu_object.h"
 #include "amdgpu_trace.h"
@@ -706,6 +707,7 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
  */
 struct amdgpu_ttm_tt {
 	struct ttm_dma_tt	ttm;
+	struct drm_gem_object	*gobj;
 	u64			offset;
 	uint64_t		userptr;
 	struct task_struct	*usertask;
@@ -1179,6 +1181,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
 		return NULL;
 	}
 	gtt->ttm.ttm.func = &amdgpu_backend_func;
+	gtt->gobj = &ttm_to_amdgpu_bo(bo)->gem_base;
 
 	/* allocate space for the uninitialized page entries */
 	if (ttm_sg_tt_init(&gtt->ttm, bo, page_flags)) {
@@ -1199,7 +1202,6 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *ttm,
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(ttm->bdev);
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
-	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
 
 	/* user pages are bound by amdgpu_ttm_tt_pin_userptr() */
 	if (gtt && gtt->userptr) {
@@ -1212,7 +1214,20 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *ttm,
 		return 0;
 	}
 
-	if (slave && ttm->sg) {
+	if (ttm->page_flags & TTM_PAGE_FLAG_SG) {
+		if (!ttm->sg) {
+			struct dma_buf_attachment *attach;
+			struct sg_table *sgt;
+
+			attach = gtt->gobj->import_attach;
+			sgt = dma_buf_map_attachment_locked(attach,
+							    DMA_BIDIRECTIONAL);
+			if (IS_ERR(sgt))
+				return PTR_ERR(sgt);
+
+			ttm->sg = sgt;
+		}
+
 		drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
 						 gtt->ttm.dma_address,
 						 ttm->num_pages);
@@ -1239,9 +1254,8 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *ttm,
  */
 static void amdgpu_ttm_tt_unpopulate(struct ttm_tt *ttm)
 {
-	struct amdgpu_device *adev;
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
-	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
+	struct amdgpu_device *adev;
 
 	if (gtt && gtt->userptr) {
 		amdgpu_ttm_tt_set_user_pages(ttm, NULL);
@@ -1250,7 +1264,17 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_tt *ttm)
 		return;
 	}
 
-	if (slave)
+	if (ttm->sg && gtt->gobj->import_attach) {
+		struct dma_buf_attachment *attach;
+
+		attach = gtt->gobj->import_attach;
+		dma_buf_unmap_attachment_locked(attach, ttm->sg,
+						DMA_BIDIRECTIONAL);
+		ttm->sg = NULL;
+		return;
+	}
+
+	if (ttm->page_flags & TTM_PAGE_FLAG_SG)
 		return;
 
 	adev = amdgpu_ttm_adev(ttm->bdev);
-- 
2.17.1

