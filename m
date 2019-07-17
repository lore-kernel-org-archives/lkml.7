Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C255C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D63217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL7DFjZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfGQVPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:15:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36450 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfGQVPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:15:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so11461883pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30Ka5qQYcLpafISMDmxQq3ADaqOMQoYykPXBu8tolwk=;
        b=GL7DFjZW8fz/+M4S71u08px6iKy3+8EGU7r38xP03tUPiXDnOwAR/UQhk4ZNlZGqUO
         hFzR/Xfh/cZ3Uw5hiaC8VYL3YEnNDwfdeL9muEgBXsqa7su5JiwhFIO9BC4TcAODt5kd
         YcgcRmc5Kg6u6oQZ5dbFLm2/pENxcuFTdnyUPLPzgxuhRJ58h6/N1RHwxHMRW7XQto9C
         dn0Is7BurkbgpmNoZyV4cVlVHXfwTWTqE5rrvMqicKWYPvwLmEStIK39FoAhAHyazuL0
         oPU6b+nfl4OLUqACeLG5eJNZHyJHPd2HvX45raG/TwLB600QLdsDiYqTlDwZQA/SmT31
         e1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30Ka5qQYcLpafISMDmxQq3ADaqOMQoYykPXBu8tolwk=;
        b=RdM2n0ARxj3LvJIiTAOfboa/meC3cDtywDSpaS0oFhodn/xDBXvhFwaQUE7CgVsrOW
         gkrR74o9xAgLjt/w8JAoX84xSpbKSznax/tR+sRyJrCxN1qj/Lr5SM2kAD9dMbJ6IJZO
         7rBHb2xZkIlIVnFi1PsXQmr4qshA//pPmN4Cr7HQVt5Peg9APR/Ri+Z+FuQUV9aNRijN
         eeS2mmKczGzk0XyibSKgG3etPZk6RYevqLnRPQwROqOkbUMrmg2mdlj93A/Bh7gLx0rL
         s2qLyrdd1InFI9NpjNGjUPrxgt9WOQ5R3ckkNM6ziU6tP+oyuibybb7Y/VUe7VjEz/W8
         k3gg==
X-Gm-Message-State: APjAAAX9/HBoUkfU/Ma0iGrenCbC1PfB+I5CPm2RkBWHSgZ7XQ5VsE0h
        zcVa4KlwFdMYBj6q3Pd7nNg=
X-Google-Smtp-Source: APXvYqzvVHu0z61NYCfx/Z7/0Unr/M+mVczgYtuX73olu0+h6Mk/UtlFNUrdcFF1mew/GiF6NVRlzA==
X-Received: by 2002:a17:90a:3270:: with SMTP id k103mr44816131pjb.54.1563398145618;
        Wed, 17 Jul 2019 14:15:45 -0700 (PDT)
Received: from localhost ([2620:15c:f:fd00:4c3b:936:8dc5:a2ad])
        by smtp.gmail.com with ESMTPSA id m11sm15819014pgl.8.2019.07.17.14.15.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 14:15:45 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Emil Velikov <emil.velikov@collabora.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Eric Anholt <eric@anholt.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Imre Deak <imre.deak@intel.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vgem: fix cache synchronization on arm/arm64
Date:   Wed, 17 Jul 2019 14:15:37 -0700
Message-Id: <20190717211542.30482-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

drm_cflush_pages() is no-op on arm/arm64.  But instead we can use
dma_sync API.

Fixes failures w/ vgem_test.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
An alternative approach to the series[1] I sent yesterday

On the plus side, it keeps the WC buffers and avoids any drm core
changes.  On the minus side, I don't think it will work (at least
on arm64) prior to v5.0[2], so the fix can't be backported very
far.

[1] https://patchwork.freedesktop.org/series/63771/
[2] depends on 356da6d0cde3323236977fce54c1f9612a742036

 drivers/gpu/drm/vgem/vgem_drv.c | 130 ++++++++++++++++++++------------
 1 file changed, 83 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 76d95b5e289c..6c9b5e20b3d4 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -47,10 +47,16 @@ static struct vgem_device {
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
 
@@ -78,40 +84,15 @@ static vm_fault_t vgem_gem_fault(struct vm_fault *vmf)
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
 
@@ -277,32 +258,93 @@ static const struct file_operations vgem_driver_fops = {
 	.release	= drm_release,
 };
 
-static struct page **vgem_pin_pages(struct drm_vgem_gem_object *bo)
+/* Called under pages_lock, except in free path (where it can't race): */
+static void sync_and_unpin(struct drm_vgem_gem_object *bo)
 {
-	mutex_lock(&bo->pages_lock);
-	if (bo->pages_pin_count++ == 0) {
-		struct page **pages;
+	struct drm_device *dev = bo->base.dev;
+
+	if (bo->table) {
+		dma_sync_sg_for_cpu(dev->dev, bo->table->sgl,
+				bo->table->nents, DMA_BIDIRECTIONAL);
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
+	struct drm_device *dev = bo->base.dev;
+	int npages = bo->base.size >> PAGE_SHIFT;
+	struct page **pages;
+	struct sg_table *sgt;
+
+	WARN_ON(!mutex_is_locked(&bo->pages_lock));
+
+	pages = drm_gem_get_pages(&bo->base);
+	if (IS_ERR(pages)) {
+		bo->pages_pin_count--;
+		mutex_unlock(&bo->pages_lock);
+		return pages;
+	}
 
-		pages = drm_gem_get_pages(&bo->base);
-		if (IS_ERR(pages)) {
-			bo->pages_pin_count--;
-			mutex_unlock(&bo->pages_lock);
-			return pages;
-		}
+	sgt = drm_prime_pages_to_sg(pages, npages);
+	if (IS_ERR(sgt)) {
+		dev_err(dev->dev,
+			"failed to allocate sgt: %ld\n",
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
+	dma_sync_sg_for_device(dev->dev, sgt->sgl,
+			sgt->nents, DMA_BIDIRECTIONAL);
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
 
-		bo->pages = pages;
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
@@ -310,18 +352,12 @@ static void vgem_unpin_pages(struct drm_vgem_gem_object *bo)
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

