Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03FCECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01222089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfIKJqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:46:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbfIKJqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:46:10 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88E1A11A2D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:46:09 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id h17so10166512plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aGQLRgm7G2kTyYY3bxXh1HW8rTy0El4wjuzgSvgBfMw=;
        b=Wm/mEgy0gbz8IuXFB/PhxosffIiV0XCfJQ3S8HxOCyIcMHUujIrc6bbJQ09fgshs8k
         1/N+Vb/Bz9QnARL/+qxBJJGn81VuLYqsTDLIVPWebpw2SaEROxkGyztYR58WCqrv/Mhy
         /Gll2/IYTQPN2950q9nb0pRgPmgsBtg41lygzdyA8OZ2sRW81Rknp8URXG1DJbB+3Vpb
         V7yVGO/NWjVWvwTW6oPg71F20049jiB+ifWeRyZAn2WQGUHWn/vQhqgeWMNQC2PQfEM7
         zaZqxZES6orZWJ7cgJiUAItwviwY7isZvhqy9y9zeTYKhB14NeHxMvERwWIXleTo7zbc
         u3yA==
X-Gm-Message-State: APjAAAUqotuc37ZqXCKfYBdxA4K5iEOApLpJWZRAFID/dsanuwZXpb/c
        DJzbiFArU5Hylbsx3dMcu7IpUaIwy55NscPDGsFWu+JZbY8LnDVEramXYkkg86lT9xviHMjRewE
        URTmmh6MHHVABw3c5RU/IABcA
X-Received: by 2002:a17:90b:8d7:: with SMTP id ds23mr4268270pjb.141.1568195169013;
        Wed, 11 Sep 2019 02:46:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyLp2sZfcawkJJYszjOJIQ4z7kr7IN7Q37DCMo9yfe4m+hzrzukPqOTG4qN8IJMbHZpOAm2IA==
X-Received: by 2002:a17:90b:8d7:: with SMTP id ds23mr4268232pjb.141.1568195168646;
        Wed, 11 Sep 2019 02:46:08 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j7sm21610436pfi.96.2019.09.11.02.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 02:46:07 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: [PATCH v3.1 7/7] mm/gup: Allow VM_FAULT_RETRY for multiple times
Date:   Wed, 11 Sep 2019 17:45:55 +0800
Message-Id: <20190911094555.9180-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911071007.20077-8-peterx@redhat.com>
References: 
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
+			break;
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

