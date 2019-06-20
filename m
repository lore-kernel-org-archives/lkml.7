Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93946C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73320214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbfFTCXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:23:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2213 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfFTCXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:23:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CF9B21BA4;
        Thu, 20 Jun 2019 02:23:53 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89BBD1001E69;
        Thu, 20 Jun 2019 02:23:43 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 17/25] userfaultfd: introduce helper vma_find_uffd
Date:   Thu, 20 Jun 2019 10:20:00 +0800
Message-Id: <20190620022008.19172-18-peterx@redhat.com>
In-Reply-To: <20190620022008.19172-1-peterx@redhat.com>
References: <20190620022008.19172-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 20 Jun 2019 02:23:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've have multiple (and more coming) places that would like to find a
userfault enabled VMA from a mm struct that covers a specific memory
range.  This patch introduce the helper for it, meanwhile apply it to
the code.

Suggested-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/userfaultfd.c | 54 +++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 5363376cb07a..6b9dd5b66f64 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -20,6 +20,34 @@
 #include <asm/tlbflush.h>
 #include "internal.h"
 
+/*
+ * Find a valid userfault enabled VMA region that covers the whole
+ * address range, or NULL on failure.  Must be called with mmap_sem
+ * held.
+ */
+static struct vm_area_struct *vma_find_uffd(struct mm_struct *mm,
+					    unsigned long start,
+					    unsigned long len)
+{
+	struct vm_area_struct *vma = find_vma(mm, start);
+
+	if (!vma)
+		return NULL;
+
+	/*
+	 * Check the vma is registered in uffd, this is required to
+	 * enforce the VM_MAYWRITE check done at uffd registration
+	 * time.
+	 */
+	if (!vma->vm_userfaultfd_ctx.ctx)
+		return NULL;
+
+	if (start < vma->vm_start || start + len > vma->vm_end)
+		return NULL;
+
+	return vma;
+}
+
 static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    pmd_t *dst_pmd,
 			    struct vm_area_struct *dst_vma,
@@ -228,20 +256,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	 */
 	if (!dst_vma) {
 		err = -ENOENT;
-		dst_vma = find_vma(dst_mm, dst_start);
+		dst_vma = vma_find_uffd(dst_mm, dst_start, len);
 		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
 			goto out_unlock;
-		/*
-		 * Check the vma is registered in uffd, this is
-		 * required to enforce the VM_MAYWRITE check done at
-		 * uffd registration time.
-		 */
-		if (!dst_vma->vm_userfaultfd_ctx.ctx)
-			goto out_unlock;
-
-		if (dst_start < dst_vma->vm_start ||
-		    dst_start + len > dst_vma->vm_end)
-			goto out_unlock;
 
 		err = -EINVAL;
 		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
@@ -487,20 +504,9 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 * both valid and fully within a single existing vma.
 	 */
 	err = -ENOENT;
-	dst_vma = find_vma(dst_mm, dst_start);
+	dst_vma = vma_find_uffd(dst_mm, dst_start, len);
 	if (!dst_vma)
 		goto out_unlock;
-	/*
-	 * Check the vma is registered in uffd, this is required to
-	 * enforce the VM_MAYWRITE check done at uffd registration
-	 * time.
-	 */
-	if (!dst_vma->vm_userfaultfd_ctx.ctx)
-		goto out_unlock;
-
-	if (dst_start < dst_vma->vm_start ||
-	    dst_start + len > dst_vma->vm_end)
-		goto out_unlock;
 
 	err = -EINVAL;
 	/*
-- 
2.21.0

