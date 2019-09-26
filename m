Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62868C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B27222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfIZJlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:41:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbfIZJlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:41:16 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DEDA2CD811
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:41:16 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id o12so1182694pll.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKkEfjdoHGbVoKbr4xUEMS07lQumUdJTKR+cWS6/cLc=;
        b=BA+KgO8pFmhp4ZHanBOyMU7NzJObVFHXFXthnBSm21tSEfTuwy7UU49TppWodVOLcX
         qyjCcgpmISdpriCG8pHl8t/2UtduAcsOHAF+8g9FbiKiH/vVggQZzp8qXkkn462A7Fus
         KL9MUJfGEt0Sg3e6DaE+ECYEYN1V8gyWm0MEqHy9rxXu0dyRu+814HSVV6KmC257kodb
         GJGyBJ0B7k/SIjh7jKWJeW2L3wtmuv/y60Bz5th8InaCewgBZCt22XMJUCPl/cFd9C8I
         0uNFhV3roFWznysM5nrN8rxUn9Fw8fXpQKxycI2J8eRtwoEzHLVihym6Pp1IbcvM4Krj
         pq1A==
X-Gm-Message-State: APjAAAXoYVECk4MuvVLB72CrjeIBC0aRdcIXbiTI90Ksn+mWjMMwgH3+
        lTfo1Y3AyWDzG0GS2nmGLg42oA+D4wGdU6y1nWuVFiSl7IX8D2QFk7ripgnPSJJx7GnpAY4p7Rc
        wRoEmN2F/7nm2MRftSgdEOcdo
X-Received: by 2002:a63:550a:: with SMTP id j10mr2421058pgb.369.1569490875457;
        Thu, 26 Sep 2019 02:41:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxqpoKkAjxWiSXeTQqhUit0kZdkveOCToqkIiL/LTZ+4SbaywQVnIYZ9dztItKxDR6cACgk0A==
X-Received: by 2002:a63:550a:: with SMTP id j10mr2421036pgb.369.1569490875206;
        Thu, 26 Sep 2019 02:41:15 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:41:14 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Matthew Wilcox <willy@infradead.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 14/16] mm/gup: Allow VM_FAULT_RETRY for multiple times
Date:   Thu, 26 Sep 2019 17:39:02 +0800
Message-Id: <20190926093904.5090-15-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the gup counterpart of the change that allows the
VM_FAULT_RETRY to happen for more than once.  One thing to mention is
that we must check the fatal signal here before retry because the GUP
can be interrupted by that, otherwise we can loop forever.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c     | 27 +++++++++++++++++++++------
 mm/hugetlb.c |  6 ++++--
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e60d32f1674d..d2811bb15a25 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -644,7 +644,10 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
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
 
@@ -994,7 +997,6 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 		down_read(&mm->mmap_sem);
 		if (!(fault_flags & FAULT_FLAG_TRIED)) {
 			*unlocked = true;
-			fault_flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			fault_flags |= FAULT_FLAG_TRIED;
 			goto retry;
 		}
@@ -1069,17 +1071,30 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 		if (likely(pages))
 			pages += ret;
 		start += ret << PAGE_SHIFT;
+		lock_dropped = true;
 
+retry:
 		/*
 		 * Repeat on the address that fired VM_FAULT_RETRY
-		 * without FAULT_FLAG_ALLOW_RETRY but with
-		 * FAULT_FLAG_TRIED.
+		 * with both FAULT_FLAG_ALLOW_RETRY and
+		 * FAULT_FLAG_TRIED.  Note that GUP can be interrupted
+		 * by fatal signals, so we need to check it before we
+		 * start trying again otherwise it can loop forever.
 		 */
+
+		if (fatal_signal_pending(current))
+			break;
+
 		*locked = 1;
-		lock_dropped = true;
 		down_read(&mm->mmap_sem);
+
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
index 31c2a6275023..d0c98cff5b0f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4347,8 +4347,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
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

