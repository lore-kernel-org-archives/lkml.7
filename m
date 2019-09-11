Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DE0ECDE28
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF642084D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfIKHLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfIKHLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:11:08 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA31E2A09B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 07:11:07 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id 194so14219597pfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 00:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5V3o75iQXkQgVY+0z1NoQ3FPIfgARTaoPLE+FPdZTuk=;
        b=gs+RgAXWiInjtu5WJTkzWg3GJdeAYp3ZuPb+gu0LoTVjoRXHKgv/fJrtvLDJvvKvqO
         RZdf6TvYgZYM6ez2KvE1IAbqjLzzFT1IAt0J5zZlW3KaBtxv82FeZjoaBPgOhBSSXLyH
         JgQLU9nkVxZ/TVjQHR2sfAXXwUf5GxBNgFWUQDdJrQ4OqdSMWTEHFTY03daX2oPFVhM3
         DMebLd7pZMDeqWz/thh7TRgPI/Tc+N39HZ64p9VFcfUOlFNioVm77ok6PlFiFOeb4OBk
         NWYg0ZtTmcLFp2A9hKeSL6e0qSpC/UvH1gl6Qn3kcldPn1fh3GR5Og6lhyRApyBDWtNB
         QjjA==
X-Gm-Message-State: APjAAAXWBLoByOUyUcDj3/YUYyuYddWbIxzvC8ZK1C59ziZPHOhyvaoF
        bnQk2sshT7oArdx/IGKprD9a0f2VTEHYRMrhSOTI1/zlpKYBxbNMa+Dr4rfwJ6j6D2VCIBG2sSm
        0LmR0wVRUDvQKsjhU8FBmRAUb
X-Received: by 2002:a17:902:ac8d:: with SMTP id h13mr34358541plr.273.1568185867165;
        Wed, 11 Sep 2019 00:11:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBWqs9OHiqcVYnHixJfPeceFNFutrglNZt9VPFbnaRBihSuzuUiLIbWkefUjaIZNUHaxC65A==
X-Received: by 2002:a17:902:ac8d:: with SMTP id h13mr34358534plr.273.1568185867006;
        Wed, 11 Sep 2019 00:11:07 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j10sm1573091pjn.3.2019.09.11.00.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 00:11:06 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Marty McFadden <mcfadden8@llnl.gov>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v3 7/7] mm/gup: Allow VM_FAULT_RETRY for multiple times
Date:   Wed, 11 Sep 2019 15:10:07 +0800
Message-Id: <20190911071007.20077-8-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911071007.20077-1-peterx@redhat.com>
References: <20190911071007.20077-1-peterx@redhat.com>
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
 mm/gup.c     | 25 ++++++++++++++++++++-----
 mm/hugetlb.c |  6 ++++--
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index eddbb95dcb8f..4b9413ee7b23 100644
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
 
@@ -1059,17 +1062,29 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
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
+			goto out;
+
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
index 5f816ee42206..6b9d27925e7a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4328,8 +4328,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
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

