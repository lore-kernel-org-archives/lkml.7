Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0056C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9533222CBB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lQZvtydN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGZA5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:57:16 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18038 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfGZA5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:57:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3a4fea0000>; Thu, 25 Jul 2019 17:57:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 17:57:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jul 2019 17:57:06 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 00:57:04 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jul 2019 00:57:03 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d3a4fdf0003>; Thu, 25 Jul 2019 17:57:03 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        "Christoph Hellwig" <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 4/7] mm: merge hmm_range_snapshot into hmm_range_fault
Date:   Thu, 25 Jul 2019 17:56:47 -0700
Message-ID: <20190726005650.2566-5-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726005650.2566-1-rcampbell@nvidia.com>
References: <20190726005650.2566-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564102634; bh=ucErf2NgykfAIu7RRloJG8d1JIV1vHLQef+I+l6mEkc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=lQZvtydNiQ/49KQg58Da0PcYWPRDnlZegDqjgfVgmt3uTKcedgTkAIGbMli2vDbMD
         kDYa31DvyZNMh8dhuJ2IWfqbIOHBacsH8fBbU16atj2a9BdYcHSnXGYpb80sGZauso
         kfMsmb9lGwi2UoIb1cfA0skaNwNkey7+i7sOSA+oCRseHJn5wPZYyRCW1OssaSpbaH
         n5XiHMrMzFsCN8ZmF602lHwhJBsu0Vm6v3pqDkmjsBerRjL6c7s/OKsS+8ATwd0d1A
         o808TFkEvOypT/yIXFhXFaus06mg5T0Q0CTl+79AxJn20SnOToOr7oAV7jzTnd3Zac
         0Sj7FQ1ciSZPQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Add a HMM_FAULT_SNAPSHOT flag so that hmm_range_snapshot can be merged
into the almost identical hmm_range_fault function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
---
 Documentation/vm/hmm.rst | 17 ++++----
 include/linux/hmm.h      |  4 +-
 mm/hmm.c                 | 85 +---------------------------------------
 3 files changed, 13 insertions(+), 93 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 710ce1c701bf..ddcb5ca8b296 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -192,15 +192,14 @@ read only, or fully unmap, etc.). The device must com=
plete the update before
 the driver callback returns.
=20
 When the device driver wants to populate a range of virtual addresses, it =
can
-use either::
+use::
=20
-  long hmm_range_snapshot(struct hmm_range *range);
-  long hmm_range_fault(struct hmm_range *range, bool block);
+  long hmm_range_fault(struct hmm_range *range, unsigned int flags);
=20
-The first one (hmm_range_snapshot()) will only fetch present CPU page tabl=
e
+With the HMM_RANGE_SNAPSHOT flag, it will only fetch present CPU page tabl=
e
 entries and will not trigger a page fault on missing or non-present entrie=
s.
-The second one does trigger a page fault on missing or read-only entries i=
f
-write access is requested (see below). Page faults use the generic mm page
+Without that flag, it does trigger a page fault on missing or read-only en=
tries
+if write access is requested (see below). Page faults use the generic mm p=
age
 fault code path just like a CPU page fault.
=20
 Both functions copy CPU page table entries into their pfns array argument.=
 Each
@@ -227,20 +226,20 @@ The usage pattern is::
=20
       /*
        * Just wait for range to be valid, safe to ignore return value as w=
e
-       * will use the return value of hmm_range_snapshot() below under the
+       * will use the return value of hmm_range_fault() below under the
        * mmap_sem to ascertain the validity of the range.
        */
       hmm_range_wait_until_valid(&range, TIMEOUT_IN_MSEC);
=20
  again:
       down_read(&mm->mmap_sem);
-      ret =3D hmm_range_snapshot(&range);
+      ret =3D hmm_range_fault(&range, HMM_RANGE_SNAPSHOT);
       if (ret) {
           up_read(&mm->mmap_sem);
           if (ret =3D=3D -EBUSY) {
             /*
              * No need to check hmm_range_wait_until_valid() return value
-             * on retry we will get proper error with hmm_range_snapshot()
+             * on retry we will get proper error with hmm_range_fault()
              */
             hmm_range_wait_until_valid(&range, TIMEOUT_IN_MSEC);
             goto again;
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 15f1b113be3c..f3693dcc8b98 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -412,7 +412,9 @@ void hmm_range_unregister(struct hmm_range *range);
  */
 #define HMM_FAULT_ALLOW_RETRY		(1 << 0)
=20
-long hmm_range_snapshot(struct hmm_range *range);
+/* Don't fault in missing PTEs, just snapshot the current state. */
+#define HMM_FAULT_SNAPSHOT		(1 << 1)
+
 long hmm_range_fault(struct hmm_range *range, unsigned int flags);
=20
 long hmm_range_dma_map(struct hmm_range *range,
diff --git a/mm/hmm.c b/mm/hmm.c
index 84f2791d3510..1bc014cddd78 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -280,7 +280,6 @@ struct hmm_vma_walk {
 	struct hmm_range	*range;
 	struct dev_pagemap	*pgmap;
 	unsigned long		last;
-	bool			fault;
 	unsigned int		flags;
 };
=20
@@ -373,7 +372,7 @@ static inline void hmm_pte_need_fault(const struct hmm_=
vma_walk *hmm_vma_walk,
 {
 	struct hmm_range *range =3D hmm_vma_walk->range;
=20
-	if (!hmm_vma_walk->fault)
+	if (hmm_vma_walk->flags & HMM_FAULT_SNAPSHOT)
 		return;
=20
 	/*
@@ -418,7 +417,7 @@ static void hmm_range_need_fault(const struct hmm_vma_w=
alk *hmm_vma_walk,
 {
 	unsigned long i;
=20
-	if (!hmm_vma_walk->fault) {
+	if (hmm_vma_walk->flags & HMM_FAULT_SNAPSHOT) {
 		*fault =3D *write_fault =3D false;
 		return;
 	}
@@ -936,85 +935,6 @@ void hmm_range_unregister(struct hmm_range *range)
 }
 EXPORT_SYMBOL(hmm_range_unregister);
=20
-/*
- * hmm_range_snapshot() - snapshot CPU page table for a range
- * @range: range
- * Return: -EINVAL if invalid argument, -ENOMEM out of memory, -EPERM inva=
lid
- *          permission (for instance asking for write and range is read on=
ly),
- *          -EBUSY if you need to retry, -EFAULT invalid (ie either no val=
id
- *          vma or it is illegal to access that range), number of valid pa=
ges
- *          in range->pfns[] (from range start address).
- *
- * This snapshots the CPU page table for a range of virtual addresses. Sna=
pshot
- * validity is tracked by range struct. See in include/linux/hmm.h for exa=
mple
- * on how to use.
- */
-long hmm_range_snapshot(struct hmm_range *range)
-{
-	const unsigned long device_vma =3D VM_IO | VM_PFNMAP | VM_MIXEDMAP;
-	unsigned long start =3D range->start, end;
-	struct hmm_vma_walk hmm_vma_walk;
-	struct hmm *hmm =3D range->hmm;
-	struct vm_area_struct *vma;
-	struct mm_walk mm_walk;
-
-	lockdep_assert_held(&hmm->mm->mmap_sem);
-	do {
-		/* If range is no longer valid force retry. */
-		if (!range->valid)
-			return -EBUSY;
-
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
-
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
-
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
-
-	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
-}
-EXPORT_SYMBOL(hmm_range_snapshot);
-
 /**
  * hmm_range_fault - try to fault some address in a virtual address range
  * @range:	range being faulted
@@ -1088,7 +1008,6 @@ long hmm_range_fault(struct hmm_range *range, unsigne=
d int flags)
 		range->vma =3D vma;
 		hmm_vma_walk.pgmap =3D NULL;
 		hmm_vma_walk.last =3D start;
-		hmm_vma_walk.fault =3D true;
 		hmm_vma_walk.flags =3D flags;
 		hmm_vma_walk.range =3D range;
 		mm_walk.private =3D &hmm_vma_walk;
--=20
2.20.1

