Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA35C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CA221743
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbfIEKQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732083AbfIEKQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:16:42 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B75FC821D1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2019 10:16:41 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id j9so1046955pgk.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 03:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZxGn2ZdCmZxu7XSt21NyGW/6BPjnqeicp2jG9/gg754=;
        b=rlilf6IPiR55klRVwElZZPzxg0DWOg1mhpA6DQmbaX+up5J+9amwjjhwRAbZcKtQ4q
         hQRpSQhrReOAXa1CMQyt4CIlKa3Xs9QxCiDXJ7i+J9cDqjGXRHb9WLJrDrlpkVMlxcP6
         vu6krl+DKzHIQpZD9jnAMX6WK3Eba14VCW+ICIa4EOJ6wzlnBkVveI1cKbfxQQ+P6ZyS
         QR6VTighslNusghww1dH+h2QaNNkujSxtXPD7w53/LPP58qQUhNmJxYjuAeLtGRrYEwe
         WU5fcGWlPhqzGwwFakWCX5mDcnxGPQZWeH5dhuvBcDlTUsPEVeyaR0ERUh9cmwiVbX40
         cd3g==
X-Gm-Message-State: APjAAAUkbJTBlWMyxB2UJiKFXKx4kpunJgSlGGeaRnagKH2d94FYaYoF
        4RCs4Jq5ACzFVVuWHp8+nwfTgChp7ofAXFGhUUlKOOr4bOTqly0xUInAbcsBT1cVBlAfvmARJfE
        nXKeRu1uXmzHlverxemmVT3ad
X-Received: by 2002:a63:4c5a:: with SMTP id m26mr2400210pgl.270.1567678601206;
        Thu, 05 Sep 2019 03:16:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyKY6zyOi9KJwWuM85hdo9q/xf5YhRviK2C6aqVXRBBcdCiehlIc9Px5hIh14dORwxN2WooCg==
X-Received: by 2002:a63:4c5a:: with SMTP id m26mr2400188pgl.270.1567678600925;
        Thu, 05 Sep 2019 03:16:40 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a20sm413852pfo.33.2019.09.05.03.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 03:16:39 -0700 (PDT)
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
Subject: [PATCH v2 7/7] mm/gup: Allow VM_FAULT_RETRY for multiple times
Date:   Thu,  5 Sep 2019 18:15:34 +0800
Message-Id: <20190905101534.9637-8-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905101534.9637-1-peterx@redhat.com>
References: <20190905101534.9637-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index eddbb95dcb8f..65d0b45be5c9 100644
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
 
@@ -1059,17 +1062,23 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
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

