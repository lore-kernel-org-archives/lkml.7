Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973A6C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2C720820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406316AbfIWE0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 00:26:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9461 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405826AbfIWE0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 00:26:40 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81D7689AC2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 04:26:39 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id m1so6586806pgq.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 21:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKkEfjdoHGbVoKbr4xUEMS07lQumUdJTKR+cWS6/cLc=;
        b=HfS4FvngV1QF7SE12LuTaglIMjK6cbtG4k0EgIjLYMzqFRTWKrThKbszzAM0j1oUwj
         /99YBGFDoAMyghI/lLyqeHlQ6bPToEEM8xzX6ysZKdUI+6UlMif603LyKs4TdqOSQyY8
         py+dveaNuCGFnnJcY2BXmDQwOm4KM0BUelHlQpTUKYr0V2lkkpxaa68TyJxjX1Apib7B
         twxdU76SFswNNM78rG+8ixwIPFeCyEpQOUEf/P1Bzl5bCQ+KL/92TZg1DksGy5uFmM5k
         oGhncN+y961q6XrXLoDAZXYOBgFJNAQ7KBSDnJOkUnO31HfuiNCFli4Or4RObNve01Hr
         040w==
X-Gm-Message-State: APjAAAX3awsl1FRxuGvxh/YVUkz5sgC9gjfMZepog7ICOzpcR/xC8MB9
        UCwT1HYSLSGxK+uhqki+7q0wqcDhKmkYbg/p9a52YuBb7ETfZYSw35Vi9/CGrH5PS3Ah3CrRKB4
        HzvAyWmLA2KMuSiR/QnumoJyS
X-Received: by 2002:a63:f745:: with SMTP id f5mr12778397pgk.175.1569212798978;
        Sun, 22 Sep 2019 21:26:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCmcEfrc8QuXpBvHO5rswwqPBwY/o99XMn56GJV9UHiDMAd1lbEY/N2Jk/9XaUVCdbc3jZ2w==
X-Received: by 2002:a63:f745:: with SMTP id f5mr12778387pgk.175.1569212798740;
        Sun, 22 Sep 2019 21:26:38 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x20sm11781867pfp.120.2019.09.22.21.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 21:26:38 -0700 (PDT)
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
Subject: [PATCH v4 08/10] mm/gup: Allow VM_FAULT_RETRY for multiple times
Date:   Mon, 23 Sep 2019 12:25:21 +0800
Message-Id: <20190923042523.10027-9-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923042523.10027-1-peterx@redhat.com>
References: <20190923042523.10027-1-peterx@redhat.com>
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

