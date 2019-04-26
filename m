Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA6AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F374206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfDZEyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 00:54:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZEyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 00:54:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1EBBFC0842AB;
        Fri, 26 Apr 2019 04:54:11 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80CB5194A0;
        Fri, 26 Apr 2019 04:54:05 +0000 (UTC)
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
Subject: [PATCH v4 15/27] userfaultfd: wp: drop _PAGE_UFFD_WP properly when fork
Date:   Fri, 26 Apr 2019 12:51:39 +0800
Message-Id: <20190426045151.19556-16-peterx@redhat.com>
In-Reply-To: <20190426045151.19556-1-peterx@redhat.com>
References: <20190426045151.19556-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 26 Apr 2019 04:54:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFFD_EVENT_FORK support for uffd-wp should be already there, except
that we should clean the uffd-wp bit if uffd fork event is not
enabled.  Detect that to avoid _PAGE_UFFD_WP being set even if the VMA
is not being tracked by VM_UFFD_WP.  Do this for both small PTEs and
huge PMDs.

Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 8 ++++++++
 mm/memory.c      | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3885747d4901..cf8f11d6e6cd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -976,6 +976,14 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	ret = -EAGAIN;
 	pmd = *src_pmd;
 
+	/*
+	 * Make sure the _PAGE_UFFD_WP bit is cleared if the new VMA
+	 * does not have the VM_UFFD_WP, which means that the uffd
+	 * fork event is not enabled.
+	 */
+	if (!(vma->vm_flags & VM_UFFD_WP))
+		pmd = pmd_clear_uffd_wp(pmd);
+
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 	if (unlikely(is_swap_pmd(pmd))) {
 		swp_entry_t entry = pmd_to_swp_entry(pmd);
diff --git a/mm/memory.c b/mm/memory.c
index 965d974bb9bd..2abf0934ad7f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -789,6 +789,14 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
 
+	/*
+	 * Make sure the _PAGE_UFFD_WP bit is cleared if the new VMA
+	 * does not have the VM_UFFD_WP, which means that the uffd
+	 * fork event is not enabled.
+	 */
+	if (!(vm_flags & VM_UFFD_WP))
+		pte = pte_clear_uffd_wp(pte);
+
 	page = vm_normal_page(vma, addr, pte);
 	if (page) {
 		get_page(page);
-- 
2.17.1

