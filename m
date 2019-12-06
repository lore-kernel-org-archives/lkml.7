Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078F3C2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06BA24677
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="YNxp0bMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfLFIYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:24:46 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:48289 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfLFIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:24:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 57AB63F474;
        Fri,  6 Dec 2019 09:24:40 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=YNxp0bMD;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IHDq2TaP34MI; Fri,  6 Dec 2019 09:24:39 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 16DE53F382;
        Fri,  6 Dec 2019 09:24:35 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 86C6A362490;
        Fri,  6 Dec 2019 09:24:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575620675; bh=vA5oKiItYexHVRFCoWyqWGI1NLy1VoQTOtL/JY2WRl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNxp0bMDU/Lr7mefqdqa8DtUlgkkzDHvunM29Ji2gxqHnrBZ1Hn5ujRM6AuYsRudo
         O0WK5l8vU/18HpWB/XsKYr1WbuYGEFi+vhZZa6iBOXC4+QmjPPpVk/Uzxn/9xTgmlf
         1zuYLOIDnOcvqr1nP/QIWvXiMz6vc7ckz4y79Leg=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v3 2/2] mm, drm/ttm: Fix vm page protection handling
Date:   Fri,  6 Dec 2019 09:24:26 +0100
Message-Id: <20191206082426.2958-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191206082426.2958-1-thomas_os@shipmail.org>
References: <20191206082426.2958-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

TTM graphics buffer objects may, transparently to user-space,  move
between IO and system memory. When that happens, all PTEs pointing to the
old location are zapped before the move and then faulted in again if
needed. When that happens, the page protection caching mode- and
encryption bits may change and be different from those of
struct vm_area_struct::vm_page_prot.

We were using an ugly hack to set the page protection correctly.
Fix that and instead export and use vmf_insert_mixed_prot() or use
vmf_insert_pfn_prot().
Also get the default page protection from
struct vm_area_struct::vm_page_prot rather than using vm_get_page_prot().
This way we catch modifications done by the vm system for drivers that
want write-notification.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 28 +++++++++++++++++++++-------
 mm/memory.c                     |  1 +
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index e6495ca2630b..35d0a0e7aacc 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -173,7 +173,6 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 				    pgoff_t num_prefault)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct vm_area_struct cvma = *vma;
 	struct ttm_buffer_object *bo = vma->vm_private_data;
 	struct ttm_bo_device *bdev = bo->bdev;
 	unsigned long page_offset;
@@ -244,7 +243,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		goto out_io_unlock;
 	}
 
-	cvma.vm_page_prot = ttm_io_prot(bo->mem.placement, prot);
+	prot = ttm_io_prot(bo->mem.placement, prot);
 	if (!bo->mem.bus.is_iomem) {
 		struct ttm_operation_ctx ctx = {
 			.interruptible = false,
@@ -260,7 +259,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		}
 	} else {
 		/* Iomem should not be marked encrypted */
-		cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
+		prot = pgprot_decrypted(prot);
 	}
 
 	/*
@@ -283,11 +282,26 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 			pfn = page_to_pfn(page);
 		}
 
+		/*
+		 * Note that the value of @prot at this point may differ from
+		 * the value of @vma->vm_page_prot in the caching- and
+		 * encryption bits. This is because the exact location of the
+		 * data may not be known at mmap() time and may also change
+		 * at arbitrary times while the data is mmap'ed.
+		 * This is ok as long as @vma->vm_page_prot is not used by
+		 * the core vm to set caching- and encryption bits.
+		 * This is ensured by core vm using pte_modify() to modify
+		 * page table entry protection bits (that function preserves
+		 * old caching- and encryption bits), and the @fault
+		 * callback being the only function that creates new
+		 * page table entries.
+		 */
 		if (vma->vm_flags & VM_MIXEDMAP)
-			ret = vmf_insert_mixed(&cvma, address,
-					__pfn_to_pfn_t(pfn, PFN_DEV));
+			ret = vmf_insert_mixed_prot(vma, address,
+						    __pfn_to_pfn_t(pfn, PFN_DEV),
+						    prot);
 		else
-			ret = vmf_insert_pfn(&cvma, address, pfn);
+			ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
 
 		/* Never error on prefaulted PTEs */
 		if (unlikely((ret & VM_FAULT_ERROR))) {
@@ -319,7 +333,7 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 	if (ret)
 		return ret;
 
-	prot = vm_get_page_prot(vma->vm_flags);
+	prot = vma->vm_page_prot;
 	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT);
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
 		return ret;
diff --git a/mm/memory.c b/mm/memory.c
index b9e7f1d56b1c..4c26c27afb0a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1769,6 +1769,7 @@ vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned long addr,
 {
 	return __vm_insert_mixed(vma, addr, pfn, pgprot, false);
 }
+EXPORT_SYMBOL(vmf_insert_mixed_prot);
 
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 		pfn_t pfn)
-- 
2.21.0

