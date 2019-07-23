Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB74C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FE5206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PmsQaM0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfGWXab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 19:30:31 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11788 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfGWXa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 19:30:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3798990000>; Tue, 23 Jul 2019 16:30:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Jul 2019 16:30:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Jul 2019 16:30:25 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jul
 2019 23:30:25 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jul
 2019 23:30:22 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Jul 2019 23:30:22 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d37988e0002>; Tue, 23 Jul 2019 16:30:22 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] mm/hmm: make full use of walk_page_range()
Date:   Tue, 23 Jul 2019 16:30:16 -0700
Message-ID: <20190723233016.26403-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723233016.26403-1-rcampbell@nvidia.com>
References: <20190723233016.26403-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563924633; bh=hfYQ/qkPLZjADPYtK9Vb0H/HyTmNQ/JXBO+v+y3qqYE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=PmsQaM0NskBkOCohdJNR6vE+X7fr8YGHD0BPSKxxNAJnBiGfOZ1OFbMAFpmkyrDbQ
         6OIHTMYlKoxkmxvcrLuprnPuX+OrTtZO6EwF/To/OZV1rV3wuHcNktrWn7lQAoX0kK
         TDT/0oErWbbFW/yVSuvuDm7kbleyInsG3qcmOec9w2f8zmKcm4bEptqYbUp6Susg2x
         lVcD9xVRYZwVTqTDuoEaanbD0JS4BuzLOFaC1tilqfNCm3HXySfjyhl36wy27Xx+7R
         FtJjCAaQuNRlp0l7xWfGkzCpOQ+e0/71SddSGIEJOH8IA2PlsTQKSRco/RfdzeNzd7
         s0QTQ7eJSd3jg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hmm_range_snapshot() and hmm_range_fault() both call find_vma() and
walk_page_range() in a loop. This is unnecessary duplication since
walk_page_range() calls find_vma() in a loop already.
Simplify hmm_range_snapshot() and hmm_range_fault() by defining a
walk_test() callback function to filter unhandled vmas.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 197 ++++++++++++++++++++-----------------------------------
 1 file changed, 70 insertions(+), 127 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 8271f110c243..218557451070 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -839,13 +839,40 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, uns=
igned long hmask,
 #endif
 }
=20
-static void hmm_pfns_clear(struct hmm_range *range,
-			   uint64_t *pfns,
-			   unsigned long addr,
-			   unsigned long end)
+static int hmm_vma_walk_test(unsigned long start,
+			     unsigned long end,
+			     struct mm_walk *walk)
 {
-	for (; addr < end; addr +=3D PAGE_SIZE, pfns++)
-		*pfns =3D range->values[HMM_PFN_NONE];
+	const unsigned long device_vma =3D VM_IO | VM_PFNMAP | VM_MIXEDMAP;
+	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
+	struct hmm_range *range =3D hmm_vma_walk->range;
+	struct vm_area_struct *vma =3D walk->vma;
+
+	/* If range is no longer valid, force retry. */
+	if (!range->valid)
+		return -EBUSY;
+
+	if (vma->vm_flags & device_vma)
+		return -EFAULT;
+
+	if (is_vm_hugetlb_page(vma)) {
+		if (huge_page_shift(hstate_vma(vma)) !=3D range->page_shift &&
+		    range->page_shift !=3D PAGE_SHIFT)
+			return -EINVAL;
+	} else {
+		if (range->page_shift !=3D PAGE_SHIFT)
+			return -EINVAL;
+	}
+
+	/*
+	 * If vma does not allow read access, then assume that it does not
+	 * allow write access, either. HMM does not support architectures
+	 * that allow write without read.
+	 */
+	if (!(vma->vm_flags & VM_READ))
+		return -EPERM;
+
+	return 0;
 }
=20
 /*
@@ -949,65 +976,28 @@ EXPORT_SYMBOL(hmm_range_unregister);
  */
 long hmm_range_snapshot(struct hmm_range *range)
 {
-	const unsigned long device_vma =3D VM_IO | VM_PFNMAP | VM_MIXEDMAP;
-	unsigned long start =3D range->start, end;
-	struct hmm_vma_walk hmm_vma_walk;
+	unsigned long start =3D range->start;
+	struct hmm_vma_walk hmm_vma_walk =3D {};
 	struct hmm *hmm =3D range->hmm;
-	struct vm_area_struct *vma;
-	struct mm_walk mm_walk;
+	struct mm_walk mm_walk =3D {};
+	int ret;
=20
 	lockdep_assert_held(&hmm->mm->mmap_sem);
-	do {
-		/* If range is no longer valid force retry. */
-		if (!range->valid)
-			return -EBUSY;
=20
-		vma =3D find_vma(hmm->mm, start);
-		if (vma =3D=3D NULL || (vma->vm_flags & device_vma))
-			return -EFAULT;
-
-		if (is_vm_hugetlb_page(vma)) {
-			if (huge_page_shift(hstate_vma(vma)) !=3D
-				    range->page_shift &&
-			    range->page_shift !=3D PAGE_SHIFT)
-				return -EINVAL;
-		} else {
-			if (range->page_shift !=3D PAGE_SHIFT)
-				return -EINVAL;
-		}
+	hmm_vma_walk.range =3D range;
+	hmm_vma_walk.last =3D start;
+	mm_walk.private =3D &hmm_vma_walk;
=20
-		if (!(vma->vm_flags & VM_READ)) {
-			/*
-			 * If vma do not allow read access, then assume that it
-			 * does not allow write access, either. HMM does not
-			 * support architecture that allow write without read.
-			 */
-			hmm_pfns_clear(range, range->pfns,
-				range->start, range->end);
-			return -EPERM;
-		}
+	mm_walk.mm =3D hmm->mm;
+	mm_walk.pud_entry =3D hmm_vma_walk_pud;
+	mm_walk.pmd_entry =3D hmm_vma_walk_pmd;
+	mm_walk.pte_hole =3D hmm_vma_walk_hole;
+	mm_walk.hugetlb_entry =3D hmm_vma_walk_hugetlb_entry;
+	mm_walk.test_walk =3D hmm_vma_walk_test;
=20
-		range->vma =3D vma;
-		hmm_vma_walk.pgmap =3D NULL;
-		hmm_vma_walk.last =3D start;
-		hmm_vma_walk.fault =3D false;
-		hmm_vma_walk.range =3D range;
-		mm_walk.private =3D &hmm_vma_walk;
-		end =3D min(range->end, vma->vm_end);
-
-		mm_walk.vma =3D vma;
-		mm_walk.mm =3D vma->vm_mm;
-		mm_walk.pte_entry =3D NULL;
-		mm_walk.test_walk =3D NULL;
-		mm_walk.hugetlb_entry =3D NULL;
-		mm_walk.pud_entry =3D hmm_vma_walk_pud;
-		mm_walk.pmd_entry =3D hmm_vma_walk_pmd;
-		mm_walk.pte_hole =3D hmm_vma_walk_hole;
-		mm_walk.hugetlb_entry =3D hmm_vma_walk_hugetlb_entry;
-
-		walk_page_range(start, end, &mm_walk);
-		start =3D end;
-	} while (start < range->end);
+	ret =3D walk_page_range(start, range->end, &mm_walk);
+	if (ret)
+		return ret;
=20
 	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
 }
@@ -1043,83 +1033,36 @@ EXPORT_SYMBOL(hmm_range_snapshot);
  */
 long hmm_range_fault(struct hmm_range *range, bool block)
 {
-	const unsigned long device_vma =3D VM_IO | VM_PFNMAP | VM_MIXEDMAP;
-	unsigned long start =3D range->start, end;
-	struct hmm_vma_walk hmm_vma_walk;
+	unsigned long start =3D range->start;
+	struct hmm_vma_walk hmm_vma_walk =3D {};
 	struct hmm *hmm =3D range->hmm;
-	struct vm_area_struct *vma;
-	struct mm_walk mm_walk;
+	struct mm_walk mm_walk =3D {};
 	int ret;
=20
 	lockdep_assert_held(&hmm->mm->mmap_sem);
=20
-	do {
-		/* If range is no longer valid force retry. */
-		if (!range->valid)
-			return -EBUSY;
+	hmm_vma_walk.range =3D range;
+	hmm_vma_walk.last =3D start;
+	hmm_vma_walk.fault =3D true;
+	hmm_vma_walk.block =3D block;
+	mm_walk.private =3D &hmm_vma_walk;
=20
-		vma =3D find_vma(hmm->mm, start);
-		if (vma =3D=3D NULL || (vma->vm_flags & device_vma))
-			return -EFAULT;
-
-		if (is_vm_hugetlb_page(vma)) {
-			if (huge_page_shift(hstate_vma(vma)) !=3D
-			    range->page_shift &&
-			    range->page_shift !=3D PAGE_SHIFT)
-				return -EINVAL;
-		} else {
-			if (range->page_shift !=3D PAGE_SHIFT)
-				return -EINVAL;
-		}
+	mm_walk.mm =3D hmm->mm;
+	mm_walk.pud_entry =3D hmm_vma_walk_pud;
+	mm_walk.pmd_entry =3D hmm_vma_walk_pmd;
+	mm_walk.pte_hole =3D hmm_vma_walk_hole;
+	mm_walk.hugetlb_entry =3D hmm_vma_walk_hugetlb_entry;
+	mm_walk.test_walk =3D hmm_vma_walk_test;
=20
-		if (!(vma->vm_flags & VM_READ)) {
-			/*
-			 * If vma do not allow read access, then assume that it
-			 * does not allow write access, either. HMM does not
-			 * support architecture that allow write without read.
-			 */
-			hmm_pfns_clear(range, range->pfns,
-				range->start, range->end);
-			return -EPERM;
-		}
+	do {
+		ret =3D walk_page_range(start, range->end, &mm_walk);
+		start =3D hmm_vma_walk.last;
=20
-		range->vma =3D vma;
-		hmm_vma_walk.pgmap =3D NULL;
-		hmm_vma_walk.last =3D start;
-		hmm_vma_walk.fault =3D true;
-		hmm_vma_walk.block =3D block;
-		hmm_vma_walk.range =3D range;
-		mm_walk.private =3D &hmm_vma_walk;
-		end =3D min(range->end, vma->vm_end);
-
-		mm_walk.vma =3D vma;
-		mm_walk.mm =3D vma->vm_mm;
-		mm_walk.pte_entry =3D NULL;
-		mm_walk.test_walk =3D NULL;
-		mm_walk.hugetlb_entry =3D NULL;
-		mm_walk.pud_entry =3D hmm_vma_walk_pud;
-		mm_walk.pmd_entry =3D hmm_vma_walk_pmd;
-		mm_walk.pte_hole =3D hmm_vma_walk_hole;
-		mm_walk.hugetlb_entry =3D hmm_vma_walk_hugetlb_entry;
-
-		do {
-			ret =3D walk_page_range(start, end, &mm_walk);
-			start =3D hmm_vma_walk.last;
-
-			/* Keep trying while the range is valid. */
-		} while (ret =3D=3D -EBUSY && range->valid);
-
-		if (ret) {
-			unsigned long i;
-
-			i =3D (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
-			hmm_pfns_clear(range, &range->pfns[i],
-				hmm_vma_walk.last, range->end);
-			return ret;
-		}
-		start =3D end;
+		/* Keep trying while the range is valid. */
+	} while (ret =3D=3D -EBUSY && range->valid);
=20
-	} while (start < range->end);
+	if (ret)
+		return ret;
=20
 	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
 }
--=20
2.20.1

