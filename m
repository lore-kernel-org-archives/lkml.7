Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A19C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786CD22CBB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rXZjgdHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfGZA5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:57:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11322 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGZA5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:57:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3a4fe10001>; Thu, 25 Jul 2019 17:57:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 17:57:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jul 2019 17:57:04 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 00:57:04 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 00:57:02 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jul 2019 00:57:02 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d3a4fdd0002>; Thu, 25 Jul 2019 17:57:01 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        "Christoph Hellwig" <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 3/7] mm/hmm: replace the block argument to hmm_range_fault with a flags value
Date:   Thu, 25 Jul 2019 17:56:46 -0700
Message-ID: <20190726005650.2566-4-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726005650.2566-1-rcampbell@nvidia.com>
References: <20190726005650.2566-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564102625; bh=BVcR9FOkcQWKlh12sJ9h4SDAhWYtefde9yC9fidSqE0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=rXZjgdHY8rHwjV8iDsfZ2U8drIU14TZmcOsA6OvqghZ46qvpINYq9DOZbmsybzGQg
         dBxnKm1+4HEQE0psP+UP69x7VkDOVUnE2sBy5cfP6GiNRwAqPdZ5IjVgIL83Uvscrk
         wpfHV1Ecfx9gfcjYyWh9k/IlmM3t0MHGLZLOAPczL/1KnkieDvgflWD+WOBb4DElgK
         ir+IydhQ7eANkDONcV2jAiUC8aSwkxhZZfSbY1mDYBRdti04SWSlnS7/Bos5gqsmSj
         vefJoL3PtYtPNoRlLLcn8ipSzfzJzwp3dD2O0Ws2DCz4EWPhPHGAPUwi1gUW8nmjex
         0tVy0PRdT8nwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

This allows easier expansion to other flags, and also makes the
callers a little easier to read.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c   |  2 +-
 include/linux/hmm.h                     | 11 +++-
 mm/hmm.c                                | 74 ++++++++++++-------------
 4 files changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index e51b48ac48eb..12a59ac83f72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -832,7 +832,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, =
struct page **pages)
=20
 	down_read(&mm->mmap_sem);
=20
-	r =3D hmm_range_fault(range, true);
+	r =3D hmm_range_fault(range, 0);
 	if (unlikely(r < 0)) {
 		if (likely(r =3D=3D -EAGAIN)) {
 			/*
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index 79b29c918717..49b520c60fc5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -505,7 +505,7 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct h=
mm_range *range)
 		return -EBUSY;
 	}
=20
-	ret =3D hmm_range_fault(range, true);
+	ret =3D hmm_range_fault(range, 0);
 	if (ret <=3D 0) {
 		if (ret =3D=3D 0)
 			ret =3D -EBUSY;
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 659e25a15700..15f1b113be3c 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -406,12 +406,19 @@ int hmm_range_register(struct hmm_range *range,
 		       unsigned long end,
 		       unsigned page_shift);
 void hmm_range_unregister(struct hmm_range *range);
+
+/*
+ * Retry fault if non-blocking, drop mmap_sem and return -EAGAIN in that c=
ase.
+ */
+#define HMM_FAULT_ALLOW_RETRY		(1 << 0)
+
 long hmm_range_snapshot(struct hmm_range *range);
-long hmm_range_fault(struct hmm_range *range, bool block);
+long hmm_range_fault(struct hmm_range *range, unsigned int flags);
+
 long hmm_range_dma_map(struct hmm_range *range,
 		       struct device *device,
 		       dma_addr_t *daddrs,
-		       bool block);
+		       unsigned int flags);
 long hmm_range_dma_unmap(struct hmm_range *range,
 			 struct vm_area_struct *vma,
 			 struct device *device,
diff --git a/mm/hmm.c b/mm/hmm.c
index 362944b0fbca..84f2791d3510 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -281,7 +281,7 @@ struct hmm_vma_walk {
 	struct dev_pagemap	*pgmap;
 	unsigned long		last;
 	bool			fault;
-	bool			block;
+	unsigned int		flags;
 };
=20
 static int hmm_vma_do_fault(struct mm_walk *walk, unsigned long addr,
@@ -293,8 +293,11 @@ static int hmm_vma_do_fault(struct mm_walk *walk, unsi=
gned long addr,
 	struct vm_area_struct *vma =3D walk->vma;
 	vm_fault_t ret;
=20
-	flags |=3D hmm_vma_walk->block ? 0 : FAULT_FLAG_ALLOW_RETRY;
-	flags |=3D write_fault ? FAULT_FLAG_WRITE : 0;
+	if (hmm_vma_walk->flags & HMM_FAULT_ALLOW_RETRY)
+		flags |=3D FAULT_FLAG_ALLOW_RETRY;
+	if (write_fault)
+		flags |=3D FAULT_FLAG_WRITE;
+
 	ret =3D handle_mm_fault(vma, addr, flags);
 	if (ret & VM_FAULT_RETRY) {
 		/* Note, handle_mm_fault did up_read(&mm->mmap_sem)) */
@@ -1012,26 +1015,26 @@ long hmm_range_snapshot(struct hmm_range *range)
 }
 EXPORT_SYMBOL(hmm_range_snapshot);
=20
-/*
- * hmm_range_fault() - try to fault some address in a virtual address rang=
e
- * @range: range being faulted
- * @block: allow blocking on fault (if true it sleeps and do not drop mmap=
_sem)
- * Return: number of valid pages in range->pfns[] (from range start
- *          address). This may be zero. If the return value is negative,
- *          then one of the following values may be returned:
+/**
+ * hmm_range_fault - try to fault some address in a virtual address range
+ * @range:	range being faulted
+ * @flags:	HMM_FAULT_* flags
  *
- *           -EINVAL  invalid arguments or mm or virtual address are in an
- *                    invalid vma (for instance device file vma).
- *           -ENOMEM: Out of memory.
- *           -EPERM:  Invalid permission (for instance asking for write an=
d
- *                    range is read only).
- *           -EAGAIN: If you need to retry and mmap_sem was drop. This can=
 only
- *                    happens if block argument is false.
- *           -EBUSY:  If the the range is being invalidated and you should=
 wait
- *                    for invalidation to finish.
- *           -EFAULT: Invalid (ie either no valid vma or it is illegal to =
access
- *                    that range), number of valid pages in range->pfns[] =
(from
- *                    range start address).
+ * Return: the number of valid pages in range->pfns[] (from range start
+ * address), which may be zero.  On error one of the following status code=
s
+ * can be returned:
+ *
+ * -EINVAL:	Invalid arguments or mm or virtual address is in an invalid vm=
a
+ *		(e.g., device file vma).
+ * -ENOMEM:	Out of memory.
+ * -EPERM:	Invalid permission (e.g., asking for write and range is read
+ *		only).
+ * -EAGAIN:	A page fault needs to be retried and mmap_sem was dropped.
+ * -EBUSY:	The range has been invalidated and the caller needs to wait for
+ *		the invalidation to finish.
+ * -EFAULT:	Invalid (i.e., either no valid vma or it is illegal to access
+ *		that range) number of valid pages in range->pfns[] (from
+ *              range start address).
  *
  * This is similar to a regular CPU page fault except that it will not tri=
gger
  * any memory migration if the memory being faulted is not accessible by C=
PUs
@@ -1040,7 +1043,7 @@ EXPORT_SYMBOL(hmm_range_snapshot);
  * On error, for one virtual address in the range, the function will mark =
the
  * corresponding HMM pfn entry with an error flag.
  */
-long hmm_range_fault(struct hmm_range *range, bool block)
+long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 {
 	const unsigned long device_vma =3D VM_IO | VM_PFNMAP | VM_MIXEDMAP;
 	unsigned long start =3D range->start, end;
@@ -1086,7 +1089,7 @@ long hmm_range_fault(struct hmm_range *range, bool bl=
ock)
 		hmm_vma_walk.pgmap =3D NULL;
 		hmm_vma_walk.last =3D start;
 		hmm_vma_walk.fault =3D true;
-		hmm_vma_walk.block =3D block;
+		hmm_vma_walk.flags =3D flags;
 		hmm_vma_walk.range =3D range;
 		mm_walk.private =3D &hmm_vma_walk;
 		end =3D min(range->end, vma->vm_end);
@@ -1125,25 +1128,22 @@ long hmm_range_fault(struct hmm_range *range, bool =
block)
 EXPORT_SYMBOL(hmm_range_fault);
=20
 /**
- * hmm_range_dma_map() - hmm_range_fault() and dma map page all in one.
- * @range: range being faulted
- * @device: device against to dma map page to
- * @daddrs: dma address of mapped pages
- * @block: allow blocking on fault (if true it sleeps and do not drop mmap=
_sem)
- * Return: number of pages mapped on success, -EAGAIN if mmap_sem have bee=
n
- *          drop and you need to try again, some other error value otherwi=
se
+ * hmm_range_dma_map - hmm_range_fault() and dma map page all in one.
+ * @range:	range being faulted
+ * @device:	device to map page to
+ * @daddrs:	array of dma addresses for the mapped pages
+ * @flags:	HMM_FAULT_*
  *
- * Note same usage pattern as hmm_range_fault().
+ * Return: the number of pages mapped on success (including zero), or any
+ * status return from hmm_range_fault() otherwise.
  */
-long hmm_range_dma_map(struct hmm_range *range,
-		       struct device *device,
-		       dma_addr_t *daddrs,
-		       bool block)
+long hmm_range_dma_map(struct hmm_range *range, struct device *device,
+		dma_addr_t *daddrs, unsigned int flags)
 {
 	unsigned long i, npages, mapped;
 	long ret;
=20
-	ret =3D hmm_range_fault(range, block);
+	ret =3D hmm_range_fault(range, flags);
 	if (ret <=3D 0)
 		return ret ? ret : -EBUSY;
=20
--=20
2.20.1

