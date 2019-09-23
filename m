Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EF4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1B720820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406494AbfIWE0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 00:26:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405826AbfIWE0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 00:26:47 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 547ED85360
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 04:26:47 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id m8so7958959plt.14
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 21:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zt8EwZyFUvlwT1VYMNYV6I/TnTem7aMxIFLElv6YJ/M=;
        b=J5o/rzUvmsO0Nrs0VlAUuLI5J9KkSp2U0jq6ATTitpRDlU5UktJ1KM/ruJLW5RAddd
         GMX0c3QlarVHjEy/DCo2m9OyoRNTeAFZR/IdLsdLTGscmxYFFGju+wfD/1S9KDaXwYua
         rpwa7cx3rqfNslUCjJHZJDI5ZoQj5CZPKq5HMEKXQQn6Dyuq3RUAwWmaJJuy+iG7VfPy
         cuPzoDn9/LfzmJcJpm2GkpH9N6kOw6cdUbQBfz3kYK0l1sjG4xuqE1BTCPVczT1Ktoyw
         gXW2q01GWNh1WUDqpfnV6qK9bhrNnzu6NKARVF7230lnK/djGHeo8+I/PzrHPHePPCew
         ORQw==
X-Gm-Message-State: APjAAAXvxoUnJAftV/4DVnGmxL77jYrNxBGcCqKDwOOYZH/j3KOwIjCm
        Cha7cVZSD34K4bkHaf4omH2LciLswyy0O//2h4kGmEMNxUR0KtHvkoH2IKwJsxjVTzCEsOLBczB
        8T6zSKXbYIRUW9/Rn+1TcMqLI
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr18843066pja.73.1569212805394;
        Sun, 22 Sep 2019 21:26:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwNMbTEwVZcWOawKIWtuccnJenC83wJpAVi10A5pUVIrEmJU1iYlQhFZ/KIbnUTXUKCTHPwqg==
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr18843054pja.73.1569212805196;
        Sun, 22 Sep 2019 21:26:45 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x20sm11781867pfp.120.2019.09.22.21.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 21:26:44 -0700 (PDT)
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
Subject: [PATCH v4 09/10] mm/gup: Allow to react to fatal signals
Date:   Mon, 23 Sep 2019 12:25:22 +0800
Message-Id: <20190923042523.10027-10-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923042523.10027-1-peterx@redhat.com>
References: <20190923042523.10027-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing gup code does not react to the fatal signals in many code
paths.  For example, in one retry path of gup we're still using
down_read() rather than down_read_killable().  Also, when doing page
faults we don't pass in FAULT_FLAG_KILLABLE as well, which means that
within the faulting process we'll wait in non-killable way as well.
These were spotted by Linus during the code review of some other
patches.

Let's allow the gup code to react to fatal signals to improve the
responsiveness of threads when during gup and being killed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c     | 12 +++++++++---
 mm/hugetlb.c |  3 ++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index d2811bb15a25..4c638473db83 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -640,7 +640,7 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 	if (*flags & FOLL_REMOTE)
 		fault_flags |= FAULT_FLAG_REMOTE;
 	if (locked)
-		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
+		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 	if (*flags & FOLL_NOWAIT)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT;
 	if (*flags & FOLL_TRIED) {
@@ -973,7 +973,7 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	vm_fault_t ret, major = 0;
 
 	if (unlocked)
-		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
+		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 retry:
 	vma = find_extend_vma(mm, address);
@@ -1086,7 +1086,13 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 			break;
 
 		*locked = 1;
-		down_read(&mm->mmap_sem);
+		ret = down_read_killable(&mm->mmap_sem);
+		if (ret) {
+			BUG_ON(ret > 0);
+			if (!pages_done)
+				pages_done = ret;
+			break;
+		}
 
 		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
 				       pages, NULL, locked);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0c98cff5b0f..84034154d50e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4342,7 +4342,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
 			if (locked)
-				fault_flags |= FAULT_FLAG_ALLOW_RETRY;
+				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
+					FAULT_FLAG_KILLABLE;
 			if (flags & FOLL_NOWAIT)
 				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
 					FAULT_FLAG_RETRY_NOWAIT;
-- 
2.21.0

