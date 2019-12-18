Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC6E218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2zkbpb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLRM4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:56:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41701 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726723AbfLRM4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576673812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=CoQOXHcnzjdvQ1sg/dnquWWmolferEO6c22b28RsYfo=;
        b=C2zkbpb3XxwgmRje/O38VWFcnXQVFMBURVWpe7/BLVtq581nmc1eKM5C81JJhQwLU84yaT
        wB2EYO3oABJKvODJTL1nF1TGOgtBKukJx09G8NWTQj5nTjLzWPol6lB034lr241ZN2Pl34
        haohDlh2YTIThLK5i11Bb/U+Sk/HBck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-dOrR9avBP-GDz32p6ByXCQ-1; Wed, 18 Dec 2019 07:56:51 -0500
X-MC-Unique: dOrR9avBP-GDz32p6ByXCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD860800D41;
        Wed, 18 Dec 2019 12:56:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com [10.36.117.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F4485D9E5;
        Wed, 18 Dec 2019 12:56:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8E9671FCED; Wed, 18 Dec 2019 13:56:45 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/3] drm/udl: simplify gem object mapping.
Date:   Wed, 18 Dec 2019 13:56:45 +0100
Message-Id: <20191218125645.9211-4-kraxel@redhat.com>
In-Reply-To: <20191218125645.9211-1-kraxel@redhat.com>
References: <20191218125645.9211-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With shmem helpers allowing to update pgprot caching flags via
drm_gem_shmem_object.map_cached we can just use that and ditch
our own implementations of mmap() and vmap().

We also don't need a special case for imported objects, any map
requests are handled by the exporter not udl.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/udl/udl_gem.c | 62 ++---------------------------------
 1 file changed, 3 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_gem.c b/drivers/gpu/drm/udl/udl_gem.c
index b6e26f98aa0a..7e3a88b25b6b 100644
--- a/drivers/gpu/drm/udl/udl_gem.c
+++ b/drivers/gpu/drm/udl/udl_gem.c
@@ -17,72 +17,15 @@
  * GEM object funcs
  */
 
-static int udl_gem_object_mmap(struct drm_gem_object *obj,
-			       struct vm_area_struct *vma)
-{
-	int ret;
-
-	ret = drm_gem_shmem_mmap(obj, vma);
-	if (ret)
-		return ret;
-
-	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-	if (obj->import_attach)
-		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
-
-	return 0;
-}
-
-static void *udl_gem_object_vmap(struct drm_gem_object *obj)
-{
-	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
-	int ret;
-
-	ret = mutex_lock_interruptible(&shmem->vmap_lock);
-	if (ret)
-		return ERR_PTR(ret);
-
-	if (shmem->vmap_use_count++ > 0)
-		goto out;
-
-	ret = drm_gem_shmem_get_pages(shmem);
-	if (ret)
-		goto err_zero_use;
-
-	if (obj->import_attach)
-		shmem->vaddr = dma_buf_vmap(obj->import_attach->dmabuf);
-	else
-		shmem->vaddr = vmap(shmem->pages, obj->size >> PAGE_SHIFT,
-				    VM_MAP, PAGE_KERNEL);
-
-	if (!shmem->vaddr) {
-		DRM_DEBUG_KMS("Failed to vmap pages\n");
-		ret = -ENOMEM;
-		goto err_put_pages;
-	}
-
-out:
-	mutex_unlock(&shmem->vmap_lock);
-	return shmem->vaddr;
-
-err_put_pages:
-	drm_gem_shmem_put_pages(shmem);
-err_zero_use:
-	shmem->vmap_use_count = 0;
-	mutex_unlock(&shmem->vmap_lock);
-	return ERR_PTR(ret);
-}
-
 static const struct drm_gem_object_funcs udl_gem_object_funcs = {
 	.free = drm_gem_shmem_free_object,
 	.print_info = drm_gem_shmem_print_info,
 	.pin = drm_gem_shmem_pin,
 	.unpin = drm_gem_shmem_unpin,
 	.get_sg_table = drm_gem_shmem_get_sg_table,
-	.vmap = udl_gem_object_vmap,
+	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
-	.mmap = udl_gem_object_mmap,
+	.mmap = drm_gem_shmem_mmap,
 };
 
 /*
@@ -101,6 +44,7 @@ struct drm_gem_object *udl_driver_gem_create_object(struct drm_device *dev,
 
 	obj = &shmem->base;
 	obj->funcs = &udl_gem_object_funcs;
+	shmem->map_cached = true;
 
 	return obj;
 }
-- 
2.18.1

