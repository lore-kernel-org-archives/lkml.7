Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D59AC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69A52070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="gBaQjqqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfK0Ic3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:32:29 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:39050 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfK0IcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:32:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 3DA5C4883B;
        Wed, 27 Nov 2019 09:32:12 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=gBaQjqqE;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5H8rmA5EwagJ; Wed, 27 Nov 2019 09:32:05 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 1A66B48839;
        Wed, 27 Nov 2019 09:32:02 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id BB2F9360476;
        Wed, 27 Nov 2019 09:32:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1574843522; bh=+xgHCNrVgI6W/xl5HoP5w6ow7rdJ2HhRm71nzkY7qFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBaQjqqE1bRU7Q1tPmmxefaaHgtcJ7N1AnaH7ZrQkJxvicnCDS1FZHMNkMapOTRUL
         SRy91pperNq9wo1HISErEmE6hnNTb47K6X8FcF3cJhWMEKrRpP9E5z4w0n/SmpGUB6
         elhz5Rc0w73iWImaHaQS82Uy0oN16Sr54hX7J6UU=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-graphics-maintainer@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC PATCH 4/7] drm/ttm: Support huge pagefaults
Date:   Wed, 27 Nov 2019 09:31:17 +0100
Message-Id: <20191127083120.34611-5-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191127083120.34611-1-thomas_os@shipmail.org>
References: <20191127083120.34611-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Support huge (PMD-size and PUD-size) page-table entries by providing a
huge_fault() callback.
We still support private mappings and write-notify by splitting the huge
page-table entries on write-access.

Note that for huge page-faults to occur, either the kernel needs to be
compiled with trans-huge-pages always enabled, or the kernel needs to be
compiled with trans-huge-pages enabled using madvise, and the user-space
app needs to call madvise() to enable trans-huge pages on a per-mapping
basis.

Furthermore huge page-faults will not occur unless buffer objects and
user-space addresses are aligned on huge page size boundaries.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 139 +++++++++++++++++++++++++++++++-
 include/drm/ttm/ttm_bo_api.h    |   3 +-
 2 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 2098f8d4dfc5..8d6089880e39 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -150,6 +150,84 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(ttm_bo_vm_reserve);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/**
+ * ttm_bo_vm_insert_huge - Insert a pfn for PUD or PMD faults
+ * @vmf: Fault data
+ * @bo: The buffer object
+ * @page_offset: Page offset from bo start
+ * @fault_page_size: The size of the fault in pages.
+ * @pgprot: The page protections.
+ * Does additional checking whether it's possible to insert a PUD or PMD
+ * pfn and performs the insertion.
+ *
+ * Return: VM_FAULT_NOPAGE on successful insertion, VM_FAULT_FALLBACK if
+ * a huge fault was not possible, and a VM_FAULT_ERROR code otherwise.
+ */
+static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
+					struct ttm_buffer_object *bo,
+					pgoff_t page_offset,
+					pgoff_t fault_page_size,
+					pgprot_t pgprot)
+{
+	pgoff_t i;
+	vm_fault_t ret;
+	unsigned long pfn;
+	pfn_t pfnt;
+	struct ttm_tt *ttm = bo->ttm;
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+
+
+	/* Fault should not cross bo boundary */
+	page_offset &= ~(fault_page_size - 1);
+	if (page_offset + fault_page_size > bo->num_pages)
+		goto out_fallback;
+
+	if (bo->mem.bus.is_iomem)
+		pfn = ttm_bo_io_mem_pfn(bo, page_offset);
+	else
+		pfn = page_to_pfn(ttm->pages[page_offset]);
+
+	/* pfn must be fault_page_size aligned. */
+	if ((pfn & (fault_page_size - 1)) != 0)
+		goto out_fallback;
+
+	/* IO memory is OK now, TT memory must be contigous. */
+	if (!bo->mem.bus.is_iomem)
+		for (i = 1; i < fault_page_size; ++i) {
+			if (page_to_pfn(ttm->pages[page_offset + i]) != pfn + i)
+				goto out_fallback;
+		}
+
+	pfnt = __pfn_to_pfn_t(pfn, PFN_DEV);
+	if (fault_page_size == (HPAGE_PMD_SIZE >> PAGE_SHIFT))
+		ret = vmf_insert_pfn_pmd_prot(vmf, pfnt, pgprot, write);
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	else if (fault_page_size == (HPAGE_PUD_SIZE >> PAGE_SHIFT))
+		ret = vmf_insert_pfn_pud_prot(vmf, pfnt, pgprot, write);
+#endif
+	else
+		WARN_ON_ONCE(ret = VM_FAULT_FALLBACK);
+
+	if (ret != VM_FAULT_NOPAGE)
+		goto out_fallback;
+
+	return VM_FAULT_NOPAGE;
+out_fallback:
+	count_vm_event(THP_FAULT_FALLBACK);
+	return VM_FAULT_FALLBACK;
+}
+#else
+static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
+					struct ttm_buffer_object *bo,
+					pgoff_t page_offset,
+					pgoff_t fault_page_size,
+					pgprot_t pgprot)
+{
+	return VM_FAULT_NOPAGE;
+}
+#endif
+
 /**
  * ttm_bo_vm_fault_reserved - TTM fault helper
  * @vmf: The struct vm_fault given as argument to the fault callback
@@ -170,7 +248,8 @@ EXPORT_SYMBOL(ttm_bo_vm_reserve);
  */
 vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 				    pgprot_t prot,
-				    pgoff_t num_prefault)
+				    pgoff_t num_prefault,
+				    pgoff_t fault_page_size)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ttm_buffer_object *bo = vma->vm_private_data;
@@ -262,6 +341,13 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		prot = pgprot_decrypted(prot);
 	}
 
+	/* We don't prefault on huge faults. Yet. */
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && fault_page_size != 1) {
+		ret = ttm_bo_vm_insert_huge(vmf, bo, page_offset,
+					    fault_page_size, prot);
+		goto out_io_unlock;
+	}
+
 	/*
 	 * Speculatively prefault a number of pages. Only error on
 	 * first page.
@@ -320,7 +406,7 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 		return ret;
 
 	prot = vma->vm_page_prot;
-	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT);
+	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT, 1);
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
 		return ret;
 
@@ -330,6 +416,50 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 }
 EXPORT_SYMBOL(ttm_bo_vm_fault);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static vm_fault_t ttm_bo_vm_huge_fault(struct vm_fault *vmf,
+				       enum page_entry_size pe_size)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	pgprot_t prot;
+	struct ttm_buffer_object *bo = vma->vm_private_data;
+	vm_fault_t ret;
+	pgoff_t fault_page_size = 0;
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+
+	switch (pe_size) {
+	case PE_SIZE_PMD:
+		fault_page_size = HPAGE_PMD_SIZE >> PAGE_SHIFT;
+		break;
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	case PE_SIZE_PUD:
+		fault_page_size = HPAGE_PUD_SIZE >> PAGE_SHIFT;
+		break;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		return VM_FAULT_FALLBACK;
+	}
+
+	/* Fallback on write dirty-tracking or COW */
+	if (write && !(pgprot_val(vmf->vma->vm_page_prot) & _PAGE_RW))
+		return VM_FAULT_FALLBACK;
+
+	ret = ttm_bo_vm_reserve(bo, vmf);
+	if (ret)
+		return ret;
+
+	prot = vm_get_page_prot(vma->vm_flags);
+	ret = ttm_bo_vm_fault_reserved(vmf, prot, 1, fault_page_size);
+	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		return ret;
+
+	dma_resv_unlock(bo->base.resv);
+
+	return ret;
+}
+#endif
+
 void ttm_bo_vm_open(struct vm_area_struct *vma)
 {
 	struct ttm_buffer_object *bo = vma->vm_private_data;
@@ -431,7 +561,10 @@ static const struct vm_operations_struct ttm_bo_vm_ops = {
 	.fault = ttm_bo_vm_fault,
 	.open = ttm_bo_vm_open,
 	.close = ttm_bo_vm_close,
-	.access = ttm_bo_vm_access
+	.access = ttm_bo_vm_access,
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	.huge_fault = ttm_bo_vm_huge_fault,
+#endif
 };
 
 static struct ttm_buffer_object *ttm_bo_vm_lookup(struct ttm_bo_device *bdev,
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 66ca49db9633..4fc90d53aa15 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -732,7 +732,8 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
 
 vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 				    pgprot_t prot,
-				    pgoff_t num_prefault);
+				    pgoff_t num_prefault,
+				    pgoff_t fault_page_size);
 
 vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf);
 
-- 
2.21.0

