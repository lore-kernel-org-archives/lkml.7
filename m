Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F145BECDE28
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D393120CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfIKHK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:10:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbfIKHKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:10:55 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D37C181129
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 07:10:54 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id z13so14992109pfr.15
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 00:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCWgxmciM/l530v7wrFJtbFp6IYoQ8sTPq58RJeE1HI=;
        b=LYgIYD+mSUXK2+nbEp9sDX6h9gHKV65P6jry0Th/HgOtayoDZ5EV8VX3kq7D1aSDeH
         2M4pKVc9fYOUvGmZMPUxSoJ7jVRmQBmQYwcJerk9dva9cdTHTnsxTrs1cPZqZFAfhIda
         OBxgI+J7YltdfRwdEsApS28ElidOMtdSw3OLIqbKNjNc87UzywKswm7xkUO0gGq3SdeY
         lTd4f9kYRm4ZK14CC45Y7ptEIkanG5DcSTMJhPg2i36EjT5QAnddtG3rojvEyy2GpJwD
         U9McSPjAxMwEwEJjYWXtWncfCjsspZmRqHM88/KPOKYzxnniqN0itgxQ7Cb0fBcgCt5L
         I8MA==
X-Gm-Message-State: APjAAAUvOITdQ47fTqfRxNs5vNuszjq5FfuZlkzNIuYopwloyDBgS887
        o16+E5ZtKgWDE2rUiHUUBn6ZzKtF7GsIYaJPF6SOOvr1qpFoVYxfRusrAQZ9vf0J8VPKUT3baVm
        k6uF/lig74iPOyCVNpX6Cw1uS
X-Received: by 2002:a65:41c6:: with SMTP id b6mr31409837pgq.269.1568185854285;
        Wed, 11 Sep 2019 00:10:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyaZ0K+GupwEKQ1pzKeVSBxX5TVirPii/f+DAFpTry982e3Pz4k9gUxwDbP6/093iBtczteUQ==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr31409801pgq.269.1568185854002;
        Wed, 11 Sep 2019 00:10:54 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j10sm1573091pjn.3.2019.09.11.00.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 00:10:53 -0700 (PDT)
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
Subject: [PATCH v3 5/7] userfaultfd: Don't retake mmap_sem to emulate NOPAGE
Date:   Wed, 11 Sep 2019 15:10:05 +0800
Message-Id: <20190911071007.20077-6-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911071007.20077-1-peterx@redhat.com>
References: <20190911071007.20077-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea comes from the upstream discussion between Linus and Andrea:

https://lkml.org/lkml/2017/10/30/560

A summary to the issue: there was a special path in handle_userfault()
in the past that we'll return a VM_FAULT_NOPAGE when we detected
non-fatal signals when waiting for userfault handling.  We did that by
reacquiring the mmap_sem before returning.  However that brings a risk
in that the vmas might have changed when we retake the mmap_sem and
even we could be holding an invalid vma structure.

This patch removes the risk path in handle_userfault() then we will be
sure that the callers of handle_mm_fault() will know that the VMAs
might have changed.  Meanwhile with previous patch we don't lose
responsiveness as well since the core mm code now can handle the
nonfatal userspace signals quickly even if we return VM_FAULT_RETRY.

Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4a8ad2dc2b6f..48b7ecf39f25 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -522,30 +522,6 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	__set_current_state(TASK_RUNNING);
 
-	if (return_to_userland) {
-		if (signal_pending(current) &&
-		    !fatal_signal_pending(current)) {
-			/*
-			 * If we got a SIGSTOP or SIGCONT and this is
-			 * a normal userland page fault, just let
-			 * userland return so the signal will be
-			 * handled and gdb debugging works.  The page
-			 * fault code immediately after we return from
-			 * this function is going to release the
-			 * mmap_sem and it's not depending on it
-			 * (unlike gup would if we were not to return
-			 * VM_FAULT_RETRY).
-			 *
-			 * If a fatal signal is pending we still take
-			 * the streamlined VM_FAULT_RETRY failure path
-			 * and there's no need to retake the mmap_sem
-			 * in such case.
-			 */
-			down_read(&mm->mmap_sem);
-			ret = VM_FAULT_NOPAGE;
-		}
-	}
-
 	/*
 	 * Here we race with the list_del; list_add in
 	 * userfaultfd_ctx_read(), however because we don't ever run
-- 
2.21.0

