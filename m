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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26D0C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F03A20684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QluqJN9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfDPSjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:39:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55404 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbfDPSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so267602wmf.5;
        Tue, 16 Apr 2019 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2kz4iL48ggREZgJu9fJF84QZP8ay01slRK2DuJYqCzo=;
        b=QluqJN9rPiA69wXBQfNIrfiSj62w9FR+WwGgF/RbrGbuH+6FFB2o2EYnf6vnpuWj29
         1Z1g07sqGukWknW59uQXRSSg/4VDD+oazvLvyUoI/4Ei+wvS+y4qmJYVGkygm6p3g5A2
         fSdJmOfYXVK4mQCrEeHuorE7ylSa5iJXU4AwWQ84HJduUzWnXARErrobu61PhGQJ8ncL
         bazvXVkRlbLAnkbz0IpDNUxkJrHoFq+W85uNGmA/0V47rAOcJJov7/XZPmwDZF3ipsGO
         7icPlVWOz4zor2c3P1iVYx/0pnQl8Rvgp7dp47WcGilIMFJCzE218Ac0qqdQev9Tru8M
         2C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2kz4iL48ggREZgJu9fJF84QZP8ay01slRK2DuJYqCzo=;
        b=ioIRD0XelvDfuzwc8H15joBZUPx/cp/qD+dN4inIofRojCsBFVWZPT7q7WDSLNzE5k
         DFlQ82o4/+6whNJ1Pa7azyaXsQarYNzi1Vaa7RD+9aoJaHIKhI1/1yXb4gl/wcSERVeq
         ezzLSZO2jaR/mi0rw5VtwGy0CjZ4SkOd9nslDsmZQ70lD/FoT2TxOg3R9VPXnb6LsEv/
         Yz8A+VtoTH3ewcvHb97oXZci89A7alcThBDSs5XbelLprIRbINqhHkrgszKP9fw5jBMj
         KmQE8a2bhn3jjKGIeGUPiU5i94aJBIb5TI9CFa/7buOi+OfPrgAu63g32okS30pzh54B
         lUSQ==
X-Gm-Message-State: APjAAAU2V385+lak5VpPOEOtho1M6qTW8RWCaGgsXd/XlXXUpF8yCw5R
        1KKOzpfZO2zZlR+xNlkTVeaU/nx5
X-Google-Smtp-Source: APXvYqy9gAvpKbrTVc2VTzj6BbELq/K4Eb9EBEKGzOVCjUKIlgBvoIaWLeZBexCqUqHSns2N/5D1iw==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr26761084wmj.44.1555439934628;
        Tue, 16 Apr 2019 11:38:54 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:54 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/12] drm/amdgpu: add independent DMA-buf export v3
Date:   Tue, 16 Apr 2019 20:38:38 +0200
Message-Id: <20190416183841.1577-10-christian.koenig@amd.com>
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

The caching of SGT's is actually quite harmful and should probably removed
altogether when all drivers are audited.

Start by providing a separate DMA-buf export implementation in amdgpu. This is
also a prerequisite of unpinned DMA-buf handling.

v2: fix unintended recursion, remove debugging leftovers
v3: split out from unpinned DMA-buf work
v4: rebase on top of new no_sgt_cache flag

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h   |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 94 ++++++++++-------------
 3 files changed, 40 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 13a68f62bcc8..f1815223a1a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1254,7 +1254,6 @@ static struct drm_driver kms_driver = {
 	.gem_prime_export = amdgpu_gem_prime_export,
 	.gem_prime_import = amdgpu_gem_prime_import,
 	.gem_prime_res_obj = amdgpu_gem_prime_res_obj,
-	.gem_prime_get_sg_table = amdgpu_gem_prime_get_sg_table,
 	.gem_prime_import_sg_table = amdgpu_gem_prime_import_sg_table,
 	.gem_prime_vmap = amdgpu_gem_prime_vmap,
 	.gem_prime_vunmap = amdgpu_gem_prime_vunmap,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index f1ddfc50bcc7..0c50d14a9739 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -39,7 +39,6 @@ int amdgpu_gem_object_open(struct drm_gem_object *obj,
 void amdgpu_gem_object_close(struct drm_gem_object *obj,
 				struct drm_file *file_priv);
 unsigned long amdgpu_gem_timeout(uint64_t timeout_ns);
-struct sg_table *amdgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
 struct drm_gem_object *
 amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
 				 struct dma_buf_attachment *attach,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
index a38e0fb4a6fe..8d748f9d0292 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
@@ -40,22 +40,6 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 
-/**
- * amdgpu_gem_prime_get_sg_table - &drm_driver.gem_prime_get_sg_table
- * implementation
- * @obj: GEM buffer object (BO)
- *
- * Returns:
- * A scatter/gather table for the pinned pages of the BO's memory.
- */
-struct sg_table *amdgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
-{
-	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
-	int npages = bo->tbo.num_pages;
-
-	return drm_prime_pages_to_sg(bo->tbo.ttm->pages, npages);
-}
-
 /**
  * amdgpu_gem_prime_vmap - &dma_buf_ops.vmap implementation
  * @obj: GEM BO
@@ -231,34 +215,29 @@ __reservation_object_make_exclusive(struct reservation_object *obj)
 }
 
 /**
- * amdgpu_gem_map_attach - &dma_buf_ops.attach implementation
- * @dma_buf: Shared DMA buffer
+ * amdgpu_gem_map_dma_buf - &dma_buf_ops.map_dma_buf implementation
  * @attach: DMA-buf attachment
+ * @dir: DMA direction
  *
  * Makes sure that the shared DMA buffer can be accessed by the target device.
  * For now, simply pins it to the GTT domain, where it should be accessible by
  * all DMA devices.
  *
  * Returns:
- * 0 on success or a negative error code on failure.
+ * sg_table filled with the DMA addresses to use or ERR_PRT with negative error
+ * code.
  */
-static int amdgpu_gem_map_attach(struct dma_buf *dma_buf,
-				 struct dma_buf_attachment *attach)
+static struct sg_table *
+amdgpu_gem_map_dma_buf(struct dma_buf_attachment *attach,
+		       enum dma_data_direction dir)
 {
+	struct dma_buf *dma_buf = attach->dmabuf;
 	struct drm_gem_object *obj = dma_buf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct sg_table *sgt;
 	long r;
 
-	r = drm_gem_map_attach(dma_buf, attach);
-	if (r)
-		return r;
-
-	r = amdgpu_bo_reserve(bo, false);
-	if (unlikely(r != 0))
-		goto error_detach;
-
-
 	if (attach->dev->driver != adev->dev->driver) {
 		/*
 		 * We only create shared fences for internal use, but importers
@@ -270,53 +249,61 @@ static int amdgpu_gem_map_attach(struct dma_buf *dma_buf,
 		 */
 		r = __reservation_object_make_exclusive(bo->tbo.resv);
 		if (r)
-			goto error_unreserve;
+			return ERR_PTR(r);
 	}
 
 	/* pin buffer into GTT */
 	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
 	if (r)
-		goto error_unreserve;
+		return ERR_PTR(r);
+
+	sgt = drm_prime_pages_to_sg(bo->tbo.ttm->pages, bo->tbo.num_pages);
+	if (IS_ERR(sgt))
+		return sgt;
+
+	if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
+			      DMA_ATTR_SKIP_CPU_SYNC))
+		goto error_free;
 
 	if (attach->dev->driver != adev->dev->driver)
 		bo->prime_shared_count++;
 
-error_unreserve:
-	amdgpu_bo_unreserve(bo);
+	return sgt;
 
-error_detach:
-	if (r)
-		drm_gem_map_detach(dma_buf, attach);
-	return r;
+error_free:
+	sg_free_table(sgt);
+	kfree(sgt);
+	return ERR_PTR(-ENOMEM);
 }
 
 /**
- * amdgpu_gem_map_detach - &dma_buf_ops.detach implementation
- * @dma_buf: Shared DMA buffer
+ * amdgpu_gem_unmap_dma_buf - &dma_buf_ops.unmap_dma_buf implementation
  * @attach: DMA-buf attachment
+ * @sgt: sg_table to unmap
+ * @dir: DMA direction
  *
  * This is called when a shared DMA buffer no longer needs to be accessible by
  * another device. For now, simply unpins the buffer from GTT.
  */
-static void amdgpu_gem_map_detach(struct dma_buf *dma_buf,
-				  struct dma_buf_attachment *attach)
+static void amdgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
+				     struct sg_table *sgt,
+				     enum dma_data_direction dir)
 {
+	struct dma_buf *dma_buf = attach->dmabuf;
 	struct drm_gem_object *obj = dma_buf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	int ret = 0;
-
-	ret = amdgpu_bo_reserve(bo, true);
-	if (unlikely(ret != 0))
-		goto error;
 
 	amdgpu_bo_unpin(bo);
+
 	if (attach->dev->driver != adev->dev->driver && bo->prime_shared_count)
 		bo->prime_shared_count--;
-	amdgpu_bo_unreserve(bo);
 
-error:
-	drm_gem_map_detach(dma_buf, attach);
+	if (sgt) {
+		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
+		sg_free_table(sgt);
+		kfree(sgt);
+	}
 }
 
 /**
@@ -374,10 +361,9 @@ static int amdgpu_gem_begin_cpu_access(struct dma_buf *dma_buf,
 }
 
 const struct dma_buf_ops amdgpu_dmabuf_ops = {
-	.attach = amdgpu_gem_map_attach,
-	.detach = amdgpu_gem_map_detach,
-	.map_dma_buf = drm_gem_map_dma_buf,
-	.unmap_dma_buf = drm_gem_unmap_dma_buf,
+	.dynamic_sgt_mapping = true,
+	.map_dma_buf = amdgpu_gem_map_dma_buf,
+	.unmap_dma_buf = amdgpu_gem_unmap_dma_buf,
 	.release = drm_gem_dmabuf_release,
 	.begin_cpu_access = amdgpu_gem_begin_cpu_access,
 	.mmap = drm_gem_dmabuf_mmap,
-- 
2.17.1

