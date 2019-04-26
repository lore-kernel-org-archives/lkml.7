Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003A5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CE3206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfDZEwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 00:52:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfDZEwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 00:52:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6AB33082B41;
        Fri, 26 Apr 2019 04:52:49 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7AAD17B21;
        Fri, 26 Apr 2019 04:52:38 +0000 (UTC)
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
Subject: [PATCH v4 05/27] mm: gup: allow VM_FAULT_RETRY for multiple times
Date:   Fri, 26 Apr 2019 12:51:29 +0800
Message-Id: <20190426045151.19556-6-peterx@redhat.com>
In-Reply-To: <20190426045151.19556-1-peterx@redhat.com>
References: <20190426045151.19556-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 26 Apr 2019 04:52:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the gup counterpart of the change that allows the VM_FAULT_RETRY
to happen for more than once.

Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c     | 17 +++++++++++++----
 mm/hugetlb.c |  6 ++++--
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a78d252d6358..46b1d1412364 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -531,7 +531,10 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 	if (*flags & FOLL_NOWAIT)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT;
 	if (*flags & FOLL_TRIED) {
-		VM_WARN_ON_ONCE(fault_flags & FAULT_FLAG_ALLOW_RETRY);
+		/*
+		 * Note: FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_TRIED
+		 * can co-exist
+		 */
 		fault_flags |= FAULT_FLAG_TRIED;
 	}
 
@@ -946,17 +949,23 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 		/* VM_FAULT_RETRY triggered, so seek to the faulting offset */
 		pages += ret;
 		start += ret << PAGE_SHIFT;
+		lock_dropped = true;
 
+retry:
 		/*
 		 * Repeat on the address that fired VM_FAULT_RETRY
-		 * without FAULT_FLAG_ALLOW_RETRY but with
+		 * with both FAULT_FLAG_ALLOW_RETRY and
 		 * FAULT_FLAG_TRIED.
 		 */
 		*locked = 1;
-		lock_dropped = true;
 		down_read(&mm->mmap_sem);
 		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
-				       pages, NULL, NULL);
+				       pages, NULL, locked);
+		if (!*locked) {
+			/* Continue to retry until we succeeded */
+			BUG_ON(ret != 0);
+			goto retry;
+		}
 		if (ret != 1) {
 			BUG_ON(ret > 1);
 			if (!pages_done)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e77b56141f0c..d14e2cc6f7c1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4268,8 +4268,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
 					FAULT_FLAG_RETRY_NOWAIT;
 			if (flags & FOLL_TRIED) {
-				VM_WARN_ON_ONCE(fault_flags &
-						FAULT_FLAG_ALLOW_RETRY);
+				/*
+				 * Note: FAULT_FLAG_ALLOW_RETRY and
+				 * FAULT_FLAG_TRIED can co-exist
+				 */
 				fault_flags |= FAULT_FLAG_TRIED;
 			}
 			ret = hugetlb_fault(mm, vma, vaddr, fault_flags);
-- 
2.17.1

