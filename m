Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1DEC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC510206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0XRWLaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbfGPVpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:45:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45380 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfGPVpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:45:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so10061286pgp.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4drR0FDgR1qKvDPf6ArOgp5GWnRtGoeeH0ezG721TC0=;
        b=d0XRWLafSldOVujZRpCkAu9+YwaiUggcPzRRQGuqpuKlW6jllCs6aNRjoFTQhxg4W6
         z7ImjRNh5QmIhLrvG3LhZo0PIw8SLsbPLLxFxaZOy4h7hkmlvhGkc1vtL4Gsa4mkCHz1
         zJ+OWNjBPEuKNabEYJEFz46fx9LgdzRJWPcElIRSmJJG5lufLlzetP7GPCAmZHS6V2xl
         2mxK1+ye+N5ayG7/d9N0ag+WZAL7AAonPq26ki8Ch07dIWP/z73zocHpTVI4WSb32Wj/
         4Wly/viUTLx9SnnoMfTR1xsYZJ0YcZ3G/B7jx6HPwUu0T3GhkwGGo8T1bQV9zgTEmpzR
         PxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4drR0FDgR1qKvDPf6ArOgp5GWnRtGoeeH0ezG721TC0=;
        b=GkLdWQ+9PlYWKwIUMSKBuGyX4ndPaGsZLjiO6yh11XdlPXiBhTvG+VtG1CJ7NE4igk
         4Wsoa0rd9ArwtUpJq4HeBu12EB3YkjghHD4q9fEz9D0x7Ht76Au/Pn/ikDni7josRik7
         obxRoHZoT9IuDmybm3EZZg/8H1EtEJU7LpApvHB8UoENRg+nzfskgr76GkMiQ79nF39c
         LwjdILSoP0FCZPxHso24R7h+HfI3wPegF/kcFKELqjMgjkH7Q6jdoB7LiD5GbREvB4uM
         y6M2PLwlsIuPzVRT9C7kgpNngoGGEHpNJmdWR8Rv/yP6MblHrIZvUZM4wjssX+AI586e
         6dzw==
X-Gm-Message-State: APjAAAUAEzGNvrKn6JhP7VYel+uuhB/yqkCcEuvecSIiChn6gZ4XO1eZ
        D0NR7Ieqb6HMj+plbpHtfcs1pXIKtVg=
X-Google-Smtp-Source: APXvYqxiDio1TWrmNR0NEynX+8QmbTFyvAzkbSoW72UZvLkMfedCjFiKOzRrZlV77GO0V2OJitoyeQ==
X-Received: by 2002:a17:90a:5887:: with SMTP id j7mr39000839pji.136.1563313499680;
        Tue, 16 Jul 2019 14:44:59 -0700 (PDT)
Received: from localhost ([100.118.89.203])
        by smtp.gmail.com with ESMTPSA id 135sm20978687pfb.137.2019.07.16.14.44.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 14:44:59 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Emil Velikov <emil.velikov@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        Eric Biggers <ebiggers@google.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] drm/vgem: use normal cached mmap'ings
Date:   Tue, 16 Jul 2019 14:37:42 -0700
Message-Id: <20190716213746.4670-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190716213746.4670-1-robdclark@gmail.com>
References: <20190716213746.4670-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Since there is no real device associated with VGEM, it is impossible to
end up with appropriate dev->dma_ops, meaning that we have no way to
invalidate the shmem pages allocated by VGEM.  So, at least on platforms
without drm_cflush_pages(), we end up with corruption when cache lines
from previous usage of VGEM bo pages get evicted to memory.

The only sane option is to use cached mappings.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
v3: rebased on drm-tip

 drivers/gpu/drm/vgem/vgem_drv.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index e7d12e93b1f0..84262e2bd7f7 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -259,9 +259,6 @@ static int vgem_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	/* Keep the WC mmaping set by drm_gem_mmap() but our pages
-	 * are ordinary and not special.
-	 */
 	vma->vm_flags = flags | VM_DONTEXPAND | VM_DONTDUMP;
 	return 0;
 }
@@ -310,17 +307,17 @@ static void vgem_unpin_pages(struct drm_vgem_gem_object *bo)
 static int vgem_prime_pin(struct drm_gem_object *obj, struct device *dev)
 {
 	struct drm_vgem_gem_object *bo = to_vgem_bo(obj);
-	long n_pages = obj->size >> PAGE_SHIFT;
+	long i, n_pages = obj->size >> PAGE_SHIFT;
 	struct page **pages;
 
 	pages = vgem_pin_pages(bo);
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
 
-	/* Flush the object from the CPU cache so that importers can rely
-	 * on coherent indirect access via the exported dma-address.
-	 */
-	drm_clflush_pages(pages, n_pages);
+	for (i = 0; i < n_pages; i++) {
+		dma_sync_single_for_device(dev, page_to_phys(pages[i]),
+					   PAGE_SIZE, DMA_BIDIRECTIONAL);
+	}
 
 	return 0;
 }
@@ -328,6 +325,13 @@ static int vgem_prime_pin(struct drm_gem_object *obj, struct device *dev)
 static void vgem_prime_unpin(struct drm_gem_object *obj, struct device *dev)
 {
 	struct drm_vgem_gem_object *bo = to_vgem_bo(obj);
+	long i, n_pages = obj->size >> PAGE_SHIFT;
+	struct page **pages = bo->pages;
+
+	for (i = 0; i < n_pages; i++) {
+		dma_sync_single_for_cpu(dev, page_to_phys(pages[i]),
+					PAGE_SIZE, DMA_BIDIRECTIONAL);
+	}
 
 	vgem_unpin_pages(bo);
 }
@@ -382,7 +386,7 @@ static void *vgem_prime_vmap(struct drm_gem_object *obj)
 	if (IS_ERR(pages))
 		return NULL;
 
-	return vmap(pages, n_pages, 0, pgprot_writecombine(PAGE_KERNEL));
+	return vmap(pages, n_pages, 0, PAGE_KERNEL);
 }
 
 static void vgem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
@@ -411,7 +415,7 @@ static int vgem_prime_mmap(struct drm_gem_object *obj,
 	fput(vma->vm_file);
 	vma->vm_file = get_file(obj->filp);
 	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
-	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 
 	return 0;
 }
-- 
2.21.0

