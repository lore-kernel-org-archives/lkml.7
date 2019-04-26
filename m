Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8F7C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2292077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfDZExL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 00:53:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfDZExK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 00:53:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5ECBD307D847;
        Fri, 26 Apr 2019 04:53:10 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 871F018500;
        Fri, 26 Apr 2019 04:52:59 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 07/27] userfaultfd: wp: hook userfault handler to write protection fault
Date:   Fri, 26 Apr 2019 12:51:31 +0800
Message-Id: <20190426045151.19556-8-peterx@redhat.com>
In-Reply-To: <20190426045151.19556-1-peterx@redhat.com>
References: <20190426045151.19556-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 26 Apr 2019 04:53:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

There are several cases write protection fault happens. It could be a
write to zero page, swaped page or userfault write protected
page. When the fault happens, there is no way to know if userfault
write protect the page before. Here we just blindly issue a userfault
notification for vma with VM_UFFD_WP regardless if app write protects
it yet. Application should be ready to handle such wp fault.

v1: From: Shaohua Li <shli@fb.com>

v2: Handle the userfault in the common do_wp_page. If we get there a
pagetable is present and readonly so no need to do further processing
until we solve the userfault.

In the swapin case, always swapin as readonly. This will cause false
positive userfaults. We need to decide later if to eliminate them with
a flag like soft-dirty in the swap entry (see _PAGE_SWP_SOFT_DIRTY).

hugetlbfs wouldn't need to worry about swapouts but and tmpfs would
be handled by a swap entry bit like anonymous memory.

The main problem with no easy solution to eliminate the false
positives, will be if/when userfaultfd is extended to real filesystem
pagecache. When the pagecache is freed by reclaim we can't leave the
radix tree pinned if the inode and in turn the radix tree is reclaimed
as well.

The estimation is that full accuracy and lack of false positives could
be easily provided only to anonymous memory (as long as there's no
fork or as long as MADV_DONTFORK is used on the userfaultfd anonymous
range) tmpfs and hugetlbfs, it's most certainly worth to achieve it
but in a later incremental patch.

v3: Add hooking point for THP wrprotect faults.

CC: Shaohua Li <shli@fb.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
[peterx: don't conditionally drop FAULT_FLAG_WRITE in do_swap_page]
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index ab650c21bccd..8ccd4927b58d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2492,6 +2492,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
+	if (userfaultfd_wp(vma)) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return handle_userfault(vmf, VM_UFFD_WP);
+	}
+
 	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
 	if (!vmf->page) {
 		/*
@@ -3707,8 +3712,11 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 /* `inline' is required to avoid gcc 4.1.2 build error */
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
 {
-	if (vma_is_anonymous(vmf->vma))
+	if (vma_is_anonymous(vmf->vma)) {
+		if (userfaultfd_wp(vmf->vma))
+			return handle_userfault(vmf, VM_UFFD_WP);
 		return do_huge_pmd_wp_page(vmf, orig_pmd);
+	}
 	if (vmf->vma->vm_ops->huge_fault)
 		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
 
-- 
2.17.1

