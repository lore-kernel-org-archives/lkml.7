Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905DEC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E81208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfF1KqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:46:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfF1KqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:46:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72157308424E;
        Fri, 28 Jun 2019 10:46:15 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B9FC5D756;
        Fri, 28 Jun 2019 10:46:08 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 7/7] mm/gup: Allow VM_FAULT_RETRY for multiple times
Date:   Fri, 28 Jun 2019 18:44:32 +0800
Message-Id: <20190628104432.12799-8-peterx@redhat.com>
In-Reply-To: <20190628104432.12799-1-peterx@redhat.com>
References: <20190628104432.12799-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 28 Jun 2019 10:46:15 +0000 (UTC)
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
index 58d282115d9b..ac8d5b73c212 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -647,7 +647,10 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
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
 
@@ -1062,17 +1065,23 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 		if (likely(pages))
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
index ba179c2fa8fb..d9c739f9a28e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4317,8 +4317,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
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
2.21.0

