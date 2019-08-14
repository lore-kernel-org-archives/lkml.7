Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D30C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A70214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX0HGQPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfHNWSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:18:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40903 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfHNWSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:18:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so231893pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Luu+LaQt2anixYnOfUg7rdINVkRka0dN47+gECXOXbI=;
        b=eX0HGQPYETy+KNpsGqasuDKK3q+HfL4o6FdC6Yvav9nP2L6uBhAMQGsPW6Nqyi8uSG
         Oyfu1z0DBoiSZ3bgb18vjrr5DZ0cdB0Z7v8pBQL1PdcWbK4IYv4Tnsn228GohEYYkXgT
         z9iR8JojMCynoOMifgFt0hNe9NjY45Te0sazxK+fPGWjaioNAr/+5gYYctPzYAhp35Gj
         eS1dayOQkAjBlc6jK/SEHdhz2Rm3Vdc/BQncLJynR4e368GTBn1sO7oVVabIgc5rVX3J
         5gOf5boAoTW1Q4bxXw92RQFPsVrfjcl6CxFXwwlgdlNgV8qc6WfFI97oGoJ9qYNJ4c8y
         bFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Luu+LaQt2anixYnOfUg7rdINVkRka0dN47+gECXOXbI=;
        b=OdO4zF836CrxJieuwVMWZMEeIjD60wDIDI1dszks9lqAeN/EhfvDOddtI7B5JYe4Ka
         zQ5mdycAIlr4odGFkQGH8Pvz6joYF+JELvIF5zYmdgdI7DWaYDA9iAGlIIM1D/Vnwoid
         dvcQHATRdzkybupshG544LMNmDBT3QoUa6wiwGYJIRaJoNJjdJqUHAtFFMxzv+WBmKMp
         JW/SbSCKjpzWRk+MGpkZ29clYyE+eJzBb2yJd91q8zFwFBalLm4Sy8xh4Ub5OZ7KL59z
         jQT/Kx9E5JA2dzKbb2MDsXB6yJateKx3UQxWKhrIlrwSyD2ZQZZIEhgoI8GKXiO0Fcmp
         psRg==
X-Gm-Message-State: APjAAAUQ5+DT9T1RexvZgQi5FvcBMUQoMxdA+XE6TXdL9q/c2jlYKtzd
        xnQ+x/gxNTkOOOqszoQ3gho=
X-Google-Smtp-Source: APXvYqzcbmoJoz247Kr2OpTmi7d2677yTSNM0zbuLxuLxdmQFn1Hz6OE1f0migwpgXGA6IA/LGnHiw==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr1431650plq.135.1565821103875;
        Wed, 14 Aug 2019 15:18:23 -0700 (PDT)
Received: from localhost ([100.118.89.196])
        by smtp.gmail.com with ESMTPSA id e3sm10650pjr.9.2019.08.14.15.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 15:18:23 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sean Paul <sean@poorly.run>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] drm/vgem: fix cache synchronization on arm/arm64 (take two)
Date:   Wed, 14 Aug 2019 15:00:01 -0700
Message-Id: <20190814220011.26934-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814220011.26934-1-robdclark@gmail.com>
References: <20190814220011.26934-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

drm_cflush_pages() is no-op on arm/arm64.  But instead we can use
arch_sync API.

Fixes failures with vgem_test.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 145 +++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 11a8f99ba18c..4493abdba134 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -34,6 +34,7 @@
 #include <linux/ramfs.h>
 #include <linux/shmem_fs.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-noncoherent.h>
 #include "vgem_drv.h"
 
 #define DRIVER_NAME	"vgem"
@@ -47,10 +48,16 @@ static struct vgem_device {
 	struct platform_device *platform;
 } *vgem_device;
 
+static void sync_and_unpin(struct drm_vgem_gem_object *bo);
+static struct page **pin_and_sync(struct drm_vgem_gem_object *bo);
+
 static void vgem_gem_free_object(struct drm_gem_object *obj)
 {
 	struct drm_vgem_gem_object *vgem_obj = to_vgem_bo(obj);
 
+	if (!obj->import_attach)
+		sync_and_unpin(vgem_obj);
+
 	kvfree(vgem_obj->pages);
 	mutex_destroy(&vgem_obj->pages_lock);
 
@@ -78,40 +85,15 @@ static vm_fault_t vgem_gem_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 
 	mutex_lock(&obj->pages_lock);
+	if (!obj->pages)
+		pin_and_sync(obj);
 	if (obj->pages) {
 		get_page(obj->pages[page_offset]);
 		vmf->page = obj->pages[page_offset];
 		ret = 0;
 	}
 	mutex_unlock(&obj->pages_lock);
-	if (ret) {
-		struct page *page;
-
-		page = shmem_read_mapping_page(
-					file_inode(obj->base.filp)->i_mapping,
-					page_offset);
-		if (!IS_ERR(page)) {
-			vmf->page = page;
-			ret = 0;
-		} else switch (PTR_ERR(page)) {
-			case -ENOSPC:
-			case -ENOMEM:
-				ret = VM_FAULT_OOM;
-				break;
-			case -EBUSY:
-				ret = VM_FAULT_RETRY;
-				break;
-			case -EFAULT:
-			case -EINVAL:
-				ret = VM_FAULT_SIGBUS;
-				break;
-			default:
-				WARN_ON(PTR_ERR(page));
-				ret = VM_FAULT_SIGBUS;
-				break;
-		}
 
-	}
 	return ret;
 }
 
@@ -277,32 +259,107 @@ static const struct file_operations vgem_driver_fops = {
 	.release	= drm_release,
 };
 
-static struct page **vgem_pin_pages(struct drm_vgem_gem_object *bo)
+/* Called under pages_lock, except in free path (where it can't race): */
+static void sync_and_unpin(struct drm_vgem_gem_object *bo)
 {
-	mutex_lock(&bo->pages_lock);
-	if (bo->pages_pin_count++ == 0) {
-		struct page **pages;
-
-		pages = drm_gem_get_pages(&bo->base);
-		if (IS_ERR(pages)) {
-			bo->pages_pin_count--;
-			mutex_unlock(&bo->pages_lock);
-			return pages;
+	struct device *dev = bo->base.dev->dev;
+
+	if (bo->table) {
+		struct scatterlist *sg;
+		int i;
+
+		for_each_sg(bo->table->sgl, sg, bo->table->nents, i) {
+			arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length,
+					      DMA_BIDIRECTIONAL);
 		}
 
-		bo->pages = pages;
+		sg_free_table(bo->table);
+		kfree(bo->table);
+		bo->table = NULL;
+	}
+
+	if (bo->pages) {
+		drm_gem_put_pages(&bo->base, bo->pages, true, true);
+		bo->pages = NULL;
+	}
+}
+
+static struct page **pin_and_sync(struct drm_vgem_gem_object *bo)
+{
+	struct device *dev = bo->base.dev->dev;
+	int npages = bo->base.size >> PAGE_SHIFT;
+	struct page **pages;
+	struct sg_table *sgt;
+	struct scatterlist *sg;
+	int i;
+
+	WARN_ON(!mutex_is_locked(&bo->pages_lock));
+
+	pages = drm_gem_get_pages(&bo->base);
+	if (IS_ERR(pages)) {
+		bo->pages_pin_count--;
+		mutex_unlock(&bo->pages_lock);
+		return pages;
+	}
+
+	sgt = drm_prime_pages_to_sg(pages, npages);
+	if (IS_ERR(sgt)) {
+		dev_err(dev, "failed to allocate sgt: %ld\n",
+			PTR_ERR(bo->table));
+		drm_gem_put_pages(&bo->base, pages, false, false);
+		mutex_unlock(&bo->pages_lock);
+		return ERR_CAST(bo->table);
+	}
+
+	/*
+	 * Flush the object from the CPU cache so that importers
+	 * can rely on coherent indirect access via the exported
+	 * dma-address.
+	 */
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length,
+					 DMA_BIDIRECTIONAL);
+	}
+
+#if defined(CONFIG_X86)
+	/* x86 doesn't have arch_sync_dma_*() */
+	drm_clflush_pages(pages, npages);
+#endif
+
+	bo->pages = pages;
+	bo->table = sgt;
+
+	return pages;
+}
+
+static struct page **vgem_pin_pages(struct drm_vgem_gem_object *bo)
+{
+	struct page **pages;
+
+	mutex_lock(&bo->pages_lock);
+	if (bo->pages_pin_count++ == 0 && !bo->pages) {
+		pages = pin_and_sync(bo);
+	} else {
+		WARN_ON(!bo->pages);
+		pages = bo->pages;
 	}
 	mutex_unlock(&bo->pages_lock);
 
-	return bo->pages;
+	return pages;
 }
 
 static void vgem_unpin_pages(struct drm_vgem_gem_object *bo)
 {
+	/*
+	 * We shouldn't hit this for imported bo's.. in the import
+	 * case we don't own the scatter-table
+	 */
+	WARN_ON(bo->base.import_attach);
+
 	mutex_lock(&bo->pages_lock);
 	if (--bo->pages_pin_count == 0) {
-		drm_gem_put_pages(&bo->base, bo->pages, true, true);
-		bo->pages = NULL;
+		WARN_ON(!bo->table);
+		sync_and_unpin(bo);
 	}
 	mutex_unlock(&bo->pages_lock);
 }
@@ -310,18 +367,12 @@ static void vgem_unpin_pages(struct drm_vgem_gem_object *bo)
 static int vgem_prime_pin(struct drm_gem_object *obj)
 {
 	struct drm_vgem_gem_object *bo = to_vgem_bo(obj);
-	long n_pages = obj->size >> PAGE_SHIFT;
 	struct page **pages;
 
 	pages = vgem_pin_pages(bo);
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
 
-	/* Flush the object from the CPU cache so that importers can rely
-	 * on coherent indirect access via the exported dma-address.
-	 */
-	drm_clflush_pages(pages, n_pages);
-
 	return 0;
 }
 
-- 
2.21.0

