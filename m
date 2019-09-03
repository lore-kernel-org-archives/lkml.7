Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8CAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CDD215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="W0qsxh85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfICNPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:15:33 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:52312 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbfICNP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:15:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id BA0503F4A9;
        Tue,  3 Sep 2019 15:15:21 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=W0qsxh85;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9cMfPuv21WsU; Tue,  3 Sep 2019 15:15:20 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 14BFB3F364;
        Tue,  3 Sep 2019 15:15:18 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id B7E8C3602AF;
        Tue,  3 Sep 2019 15:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567516517; bh=0YXw3Yun+eSUH41y8FVOhBIlEn3SQu6i/7a617fkyRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0qsxh85MEstfDWUa0xW3lIkk4uQqS5VeGgXE/ygSP3krzxk9pwdVHGwa94fxn1xU
         /cjB3QTUxIrfdRlJ1VLpMDVBwZr55xWb5E9iXdoIzGETdg+etqNd5oQDDKw37322G4
         tAM1SRw4QtLWbzrIZOiXbhB8veMe7w5AZaxRdNwA=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2 3/4] drm/ttm, drm/vmwgfx: Correctly support support AMD memory encryption
Date:   Tue,  3 Sep 2019 15:15:03 +0200
Message-Id: <20190903131504.18935-4-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903131504.18935-1-thomas_os@shipmail.org>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

With TTM pages allocated out of the DMA pool, use the
force_dma_unencrypted function to be able to set up the correct
page-protection. Previously it was unconditionally set to encrypted,
which only works with SME encryption on devices with a large enough DMA
mask.

Tested with vmwgfx and sev-es. Screen garbage without this patch and normal
functionality with it.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c        | 17 +++++++++++++----
 drivers/gpu/drm/ttm/ttm_bo_vm.c          | 21 ++++++++++-----------
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |  4 ++++
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c     |  6 ++++--
 include/drm/ttm/ttm_bo_driver.h          |  8 +++++---
 include/drm/ttm/ttm_tt.h                 |  1 +
 6 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index fe81c565e7ef..d5ad8f03b63f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -419,11 +419,13 @@ int ttm_bo_move_memcpy(struct ttm_buffer_object *bo,
 		page = i * dir + add;
 		if (old_iomap == NULL) {
 			pgprot_t prot = ttm_io_prot(old_mem->placement,
+						    ttm->page_flags,
 						    PAGE_KERNEL);
 			ret = ttm_copy_ttm_io_page(ttm, new_iomap, page,
 						   prot);
 		} else if (new_iomap == NULL) {
 			pgprot_t prot = ttm_io_prot(new_mem->placement,
+						    ttm->page_flags,
 						    PAGE_KERNEL);
 			ret = ttm_copy_io_ttm_page(ttm, old_iomap, page,
 						   prot);
@@ -526,11 +528,11 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	return 0;
 }
 
-pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
+pgprot_t ttm_io_prot(u32 caching_flags, u32 tt_page_flags, pgprot_t tmp)
 {
 	/* Cached mappings need no adjustment */
 	if (caching_flags & TTM_PL_FLAG_CACHED)
-		return tmp;
+		goto check_encryption;
 
 #if defined(__i386__) || defined(__x86_64__)
 	if (caching_flags & TTM_PL_FLAG_WC)
@@ -548,6 +550,11 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
 #if defined(__sparc__)
 	tmp = pgprot_noncached(tmp);
 #endif
+
+check_encryption:
+	if (tt_page_flags & TTM_PAGE_FLAG_DECRYPTED)
+		tmp = pgprot_decrypted(tmp);
+
 	return tmp;
 }
 EXPORT_SYMBOL(ttm_io_prot);
@@ -594,7 +601,8 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 	if (ret)
 		return ret;
 
-	if (num_pages == 1 && (mem->placement & TTM_PL_FLAG_CACHED)) {
+	if (num_pages == 1 && (mem->placement & TTM_PL_FLAG_CACHED) &&
+	    !(ttm->page_flags & TTM_PAGE_FLAG_DECRYPTED)) {
 		/*
 		 * We're mapping a single page, and the desired
 		 * page protection is consistent with the bo.
@@ -608,7 +616,8 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 		 * We need to use vmap to get the desired page protection
 		 * or to make the buffer object look contiguous.
 		 */
-		prot = ttm_io_prot(mem->placement, PAGE_KERNEL);
+		prot = ttm_io_prot(mem->placement, ttm->page_flags,
+				   PAGE_KERNEL);
 		map->bo_kmap_type = ttm_bo_map_vmap;
 		map->virtual = vmap(ttm->pages + start_page, num_pages,
 				    0, prot);
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 76eedb963693..194d8d618d23 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -226,12 +226,7 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 	 * by mmap_sem in write mode.
 	 */
 	cvma = *vma;
-	cvma.vm_page_prot = vm_get_page_prot(cvma.vm_flags);
-
-	if (bo->mem.bus.is_iomem) {
-		cvma.vm_page_prot = ttm_io_prot(bo->mem.placement,
-						cvma.vm_page_prot);
-	} else {
+	if (!bo->mem.bus.is_iomem) {
 		struct ttm_operation_ctx ctx = {
 			.interruptible = false,
 			.no_wait_gpu = false,
@@ -240,14 +235,18 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 		};
 
 		ttm = bo->ttm;
-		cvma.vm_page_prot = ttm_io_prot(bo->mem.placement,
-						cvma.vm_page_prot);
-
-		/* Allocate all page at once, most common usage */
-		if (ttm_tt_populate(ttm, &ctx)) {
+		if (ttm_tt_populate(bo->ttm, &ctx)) {
 			ret = VM_FAULT_OOM;
 			goto out_io_unlock;
 		}
+		cvma.vm_page_prot = ttm_io_prot(bo->mem.placement,
+						ttm->page_flags,
+						cvma.vm_page_prot);
+	} else {
+		/* Iomem should not be marked encrypted */
+		cvma.vm_page_prot = ttm_io_prot(bo->mem.placement,
+						TTM_PAGE_FLAG_DECRYPTED,
+						cvma.vm_page_prot);
 	}
 
 	/*
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
index 7d78e6deac89..9b15df8ecd49 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
@@ -48,6 +48,7 @@
 #include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/kthread.h>
+#include <linux/dma-direct.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_page_alloc.h>
 #include <drm/ttm/ttm_set_memory.h>
@@ -984,6 +985,9 @@ int ttm_dma_populate(struct ttm_dma_tt *ttm_dma, struct device *dev,
 	}
 
 	ttm->state = tt_unbound;
+	if (force_dma_unencrypted(dev))
+		ttm->page_flags |= TTM_PAGE_FLAG_DECRYPTED;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ttm_dma_populate);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index bb46ca0c458f..d3ced89a37e9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -483,8 +483,10 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
 	d.src_pages = src->ttm->pages;
 	d.dst_num_pages = dst->num_pages;
 	d.src_num_pages = src->num_pages;
-	d.dst_prot = ttm_io_prot(dst->mem.placement, PAGE_KERNEL);
-	d.src_prot = ttm_io_prot(src->mem.placement, PAGE_KERNEL);
+	d.dst_prot = ttm_io_prot(dst->mem.placement, dst->ttm->page_flags,
+				 PAGE_KERNEL);
+	d.src_prot = ttm_io_prot(src->mem.placement, src->ttm->page_flags,
+				 PAGE_KERNEL);
 	d.diff = diff;
 
 	for (j = 0; j < h; ++j) {
diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index 6f536caea368..68ead1bd3042 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -893,13 +893,15 @@ int ttm_bo_pipeline_gutting(struct ttm_buffer_object *bo);
 /**
  * ttm_io_prot
  *
- * @c_state: Caching state.
+ * @caching_flags: The caching flags of the map.
+ * @tt_page_flags: The tt_page_flags of the map, TTM_PAGE_FLAG_*
  * @tmp: Page protection flag for a normal, cached mapping.
  *
  * Utility function that returns the pgprot_t that should be used for
- * setting up a PTE with the caching model indicated by @c_state.
+ * setting up a PTE with the caching model indicated by @caching_flags,
+ * and encryption state indicated by @tt_page_flags,
  */
-pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp);
+pgprot_t ttm_io_prot(u32 caching_flags, u32 tt_page_flags, pgprot_t tmp);
 
 extern const struct ttm_mem_type_manager_func ttm_bo_manager_func;
 
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index c0e928abf592..45cc26355513 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -41,6 +41,7 @@ struct ttm_operation_ctx;
 #define TTM_PAGE_FLAG_DMA32           (1 << 7)
 #define TTM_PAGE_FLAG_SG              (1 << 8)
 #define TTM_PAGE_FLAG_NO_RETRY	      (1 << 9)
+#define TTM_PAGE_FLAG_DECRYPTED       (1 << 10)
 
 enum ttm_caching_state {
 	tt_uncached,
-- 
2.20.1

