Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8745EC76194
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507CA22C97
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RLKAZgjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfGZA5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:57:08 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11762 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfGZA5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:57:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3a4fdc0000>; Thu, 25 Jul 2019 17:57:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 17:57:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 25 Jul 2019 17:57:02 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 00:57:00 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jul 2019 00:57:00 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d3a4fdb0003>; Thu, 25 Jul 2019 17:56:59 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/7] mm/hmm: a few more C style and comment clean ups
Date:   Thu, 25 Jul 2019 17:56:45 -0700
Message-ID: <20190726005650.2566-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726005650.2566-1-rcampbell@nvidia.com>
References: <20190726005650.2566-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564102620; bh=VqpSzYOwtgE4pudzmhAYqixR/5l+/0deY5VPhceduHU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=RLKAZgjMCVM5+WePfidI0tls0zB8FdOzcWvS7XIv6zYBkht1s5ZCZZdcsrMNWS+7x
         4dqXVJDdDuqtpVUW1nlvNgEHR8a5xoherwFLBNneBx22XscZ7MovvWr2MgM885CcyJ
         S/OXldZM6BH7Z8bd1bhJqH1xIkKjB/qI2Y3Mf5xFu1C/iWWqFSAJHFddg/WDMTQY0k
         VKQEdSPSjvz72QQc10TOhMECYbKbvAjnDh/Geufbo18NOWf0Ep/Yl6uEz4Cz0kscv5
         PZ55TStFzJZJtxhGPOTLCHyYDoiEzjrE/EYAC2Q+ejsNgKKmz+NjSzyNomVXHPeADy
         OhUpiDUNazCzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few more comments and minor programming style clean ups.
There should be no functional changes.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 4040b4427635..362944b0fbca 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -32,7 +32,7 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops=
;
  * hmm_get_or_create - register HMM against an mm (HMM internal)
  *
  * @mm: mm struct to attach to
- * Returns: returns an HMM object, either by referencing the existing
+ * Return: an HMM object, either by referencing the existing
  *          (per-process) object, or by creating a new one.
  *
  * This is not intended to be used directly by device drivers. If mm alrea=
dy
@@ -325,8 +325,8 @@ static int hmm_pfns_bad(unsigned long addr,
 }
=20
 /*
- * hmm_vma_walk_hole() - handle a range lacking valid pmd or pte(s)
- * @start: range virtual start address (inclusive)
+ * hmm_vma_walk_hole_() - handle a range lacking valid pmd or pte(s)
+ * @addr: range virtual start address (inclusive)
  * @end: range virtual end address (exclusive)
  * @fault: should we fault or not ?
  * @write_fault: write fault ?
@@ -376,9 +376,9 @@ static inline void hmm_pte_need_fault(const struct hmm_=
vma_walk *hmm_vma_walk,
 	/*
 	 * So we not only consider the individual per page request we also
 	 * consider the default flags requested for the range. The API can
-	 * be use in 2 fashions. The first one where the HMM user coalesce
-	 * multiple page fault into one request and set flags per pfns for
-	 * of those faults. The second one where the HMM user want to pre-
+	 * be used 2 ways. The first one where the HMM user coalesces
+	 * multiple page faults into one request and sets flags per pfn for
+	 * those faults. The second one where the HMM user wants to pre-
 	 * fault a range with specific flags. For the latter one it is a
 	 * waste to have the user pre-fill the pfn arrays with a default
 	 * flags value.
@@ -388,7 +388,7 @@ static inline void hmm_pte_need_fault(const struct hmm_=
vma_walk *hmm_vma_walk,
 	/* We aren't ask to do anything ... */
 	if (!(pfns & range->flags[HMM_PFN_VALID]))
 		return;
-	/* If this is device memory than only fault if explicitly requested */
+	/* If this is device memory then only fault if explicitly requested */
 	if ((cpu_flags & range->flags[HMM_PFN_DEVICE_PRIVATE])) {
 		/* Do we fault on device memory ? */
 		if (pfns & range->flags[HMM_PFN_DEVICE_PRIVATE]) {
@@ -502,7 +502,7 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 	hmm_vma_walk->last =3D end;
 	return 0;
 #else
-	/* If THP is not enabled then we should never reach that code ! */
+	/* If THP is not enabled then we should never reach this code ! */
 	return -EINVAL;
 #endif
 }
@@ -522,7 +522,6 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, uns=
igned long addr,
 {
 	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
 	struct hmm_range *range =3D hmm_vma_walk->range;
-	struct vm_area_struct *vma =3D walk->vma;
 	bool fault, write_fault;
 	uint64_t cpu_flags;
 	pte_t pte =3D *ptep;
@@ -571,8 +570,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, uns=
igned long addr,
 			if (fault || write_fault) {
 				pte_unmap(ptep);
 				hmm_vma_walk->last =3D addr;
-				migration_entry_wait(vma->vm_mm,
-						     pmdp, addr);
+				migration_entry_wait(walk->mm, pmdp, addr);
 				return -EBUSY;
 			}
 			return 0;
@@ -620,13 +618,11 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 {
 	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
 	struct hmm_range *range =3D hmm_vma_walk->range;
-	struct vm_area_struct *vma =3D walk->vma;
 	uint64_t *pfns =3D range->pfns;
 	unsigned long addr =3D start, i;
 	pte_t *ptep;
 	pmd_t pmd;
=20
-
 again:
 	pmd =3D READ_ONCE(*pmdp);
 	if (pmd_none(pmd))
@@ -648,7 +644,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 				     0, &fault, &write_fault);
 		if (fault || write_fault) {
 			hmm_vma_walk->last =3D addr;
-			pmd_migration_entry_wait(vma->vm_mm, pmdp);
+			pmd_migration_entry_wait(walk->mm, pmdp);
 			return -EBUSY;
 		}
 		return 0;
@@ -657,11 +653,11 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
=20
 	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
 		/*
-		 * No need to take pmd_lock here, even if some other threads
+		 * No need to take pmd_lock here, even if some other thread
 		 * is splitting the huge pmd we will get that event through
 		 * mmu_notifier callback.
 		 *
-		 * So just read pmd value and check again its a transparent
+		 * So just read pmd value and check again it's a transparent
 		 * huge or device mapping one and compute corresponding pfn
 		 * values.
 		 */
@@ -675,7 +671,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	}
=20
 	/*
-	 * We have handled all the valid case above ie either none, migration,
+	 * We have handled all the valid cases above ie either none, migration,
 	 * huge or transparent huge. At this point either it is a valid pmd
 	 * entry pointing to pte directory or it is a bad pmd that will not
 	 * recover.
@@ -795,10 +791,10 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, uns=
igned long hmask,
 	pte_t entry;
 	int ret =3D 0;
=20
-	size =3D 1UL << huge_page_shift(h);
+	size =3D huge_page_size(h);
 	mask =3D size - 1;
 	if (range->page_shift !=3D PAGE_SHIFT) {
-		/* Make sure we are looking at full page. */
+		/* Make sure we are looking at a full page. */
 		if (start & mask)
 			return -EINVAL;
 		if (end < (start + size))
@@ -809,8 +805,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsig=
ned long hmask,
 		size =3D PAGE_SIZE;
 	}
=20
-
-	ptl =3D huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
+	ptl =3D huge_pte_lock(hstate_vma(vma), walk->mm, pte);
 	entry =3D huge_ptep_get(pte);
=20
 	i =3D (start - range->start) >> range->page_shift;
@@ -859,7 +854,7 @@ static void hmm_pfns_clear(struct hmm_range *range,
  * @start: start virtual address (inclusive)
  * @end: end virtual address (exclusive)
  * @page_shift: expect page shift for the range
- * Returns 0 on success, -EFAULT if the address space is no longer valid
+ * Return: 0 on success, -EFAULT if the address space is no longer valid
  *
  * Track updates to the CPU page table see include/linux/hmm.h
  */
--=20
2.20.1

