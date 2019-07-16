Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ECCC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A6C2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE+P9H/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbfGPRvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:51:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39012 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfGPRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:51:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so10497785pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UiLaRqQi+KN5P/cP6egPb78oRpeEozQB/t5Ad8Uztd4=;
        b=hE+P9H/tFUK8qpoBOYsg1V+ORebpPk0bjpfOrC11X3dwjJrq2UGU4kOsytw14cbTLr
         wOCN+LCKewt/JS2Z7zT+JsuLCfkk4iUXQE8zLGFD5oXwY1X2j/uwAXBu3t6Q4Bnvn1Wx
         vFmYwvPOkVkNb6SrLMRO9kIvJjMAHedXhrxRwMH2aOEKlBKWbDH52oySlExA8sO0L5qN
         Z3Y5nlT3eMF64tjLSabZV4HyjvDWAdJhcAkwUJkcqINqNFuuzyiWRzNwT8mlUVt6FN25
         WCb2Gw3g9txNOZzeaUw2/X1747vo9vF+zVUp2X9B2xpJwRDDKucIlInL8yT74rg4dCQj
         Rqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UiLaRqQi+KN5P/cP6egPb78oRpeEozQB/t5Ad8Uztd4=;
        b=D2N0xyuaxgn3UXsB8OtarC5kaC7rtk72bBEkG+BW3k2NMCvs204gjqKMoW/nUzWMct
         R9HIWfXUYslSaC0TcgNG2ob2HsowxT8CV2vhc/ttFuXBllJo9exs23LSLPacToBsircv
         pXXIXTCa/OyCJAA/btnNgy/Xc0YSWfUTJ6Ejhni30yAzCn9I7+m/ECc6CD2Ai5iI2wei
         uSdCrkxIMRqGJyiJamFfOw1Jwt03cBLh4AfdHbWMzSqTxJbzf17Xk26TThujxeS7Ke0N
         Ritxbqh2YEFq/mn+SCvlZ+QU36KNjTOry6gleHpmLEfNgwsqF7qtHLMN3dca+5lQ7ghQ
         huCw==
X-Gm-Message-State: APjAAAWM9jE+s1GU14o00azdQx86JPvU4H0Sizyp1V0iPC6HQfjGa310
        sFiDX2VlS1+I1B0k8wKpHLE=
X-Google-Smtp-Source: APXvYqzFKslRA486uFuMA8KNQnLtCFo8RE9hfK9nYj7zlrGlay5yFSTuwTPyyWNjseq42zgOr7Agbw==
X-Received: by 2002:a17:902:b20c:: with SMTP id t12mr37712885plr.285.1563299497373;
        Tue, 16 Jul 2019 10:51:37 -0700 (PDT)
Received: from localhost ([100.118.89.203])
        by smtp.gmail.com with ESMTPSA id g8sm2243238pgk.1.2019.07.16.10.51.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 10:51:36 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Emil Velikov <emil.velikov@collabora.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Imre Deak <imre.deak@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/vgem: use normal cached mmap'ings
Date:   Tue, 16 Jul 2019 10:43:23 -0700
Message-Id: <20190716174331.7371-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190716174331.7371-1-robdclark@gmail.com>
References: <20190716174331.7371-1-robdclark@gmail.com>
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
 drivers/gpu/drm/vgem/vgem_drv.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index a179e962b79e..b6071a466b92 100644
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

