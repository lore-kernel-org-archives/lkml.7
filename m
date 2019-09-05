Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733B7C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CBF2184B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbfIEKQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:16:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733138AbfIEKQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:16:25 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E4998830A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2019 10:16:25 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id b12so1054683pgm.14
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 03:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCWgxmciM/l530v7wrFJtbFp6IYoQ8sTPq58RJeE1HI=;
        b=Fl+YT4pHrsKrhKB2wiCLsW3M0DM2jkbmUzijRnVbshBh6D7s+eBgx5WGJ4NjxPJ+Yf
         9cJkYSaAyQANNVmO3eTpGOJTQ53vUSxmUXWVh6WUh71NS42oh4c/Cqhf1s/ik1CK9P5R
         OY/hlzZ6Nqt8YWJgj8qY5X9x4YDX+2t3wBaQd2ntWFFshn4awh912fxM9TrM8gi3tEv5
         qI1zG6jrdi58R2TW/va4iFaK9JafqkV3AFfQhGVxpiohiSO00gRzi4v6HF+f9tZNWWEx
         LN3z4Ac3KjRSN4G/3jAaxqUttDPLJJFACSjTDTWT0CCZIm/NLZMr6Dhqag6BWWigNtg4
         a6jg==
X-Gm-Message-State: APjAAAVsvZYyG4jA3j2dxBR5/oZoJSGPQuax4QY+CBZTqtlgRSESStm+
        aD8KszJCCRd9Wl5Dnf2lyh4u9LOElKEitQEhBXTq28e+egjAP4W1SEDA+rtfw/gMaVhMQiae9Ix
        s4wU/ye3peX9mrPONNTO392RA
X-Received: by 2002:a17:902:988a:: with SMTP id s10mr2410545plp.119.1567678584563;
        Thu, 05 Sep 2019 03:16:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySfDc/zhOFXj3cLsVFTtpVlLwUaGTCQLDhWRP0rJ8KpSGAK+5oupbPfAYaTJR2LP4bgKauaA==
X-Received: by 2002:a17:902:988a:: with SMTP id s10mr2410525plp.119.1567678584389;
        Thu, 05 Sep 2019 03:16:24 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a20sm413852pfo.33.2019.09.05.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 03:16:23 -0700 (PDT)
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
Subject: [PATCH v2 5/7] userfaultfd: Don't retake mmap_sem to emulate NOPAGE
Date:   Thu,  5 Sep 2019 18:15:32 +0800
Message-Id: <20190905101534.9637-6-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905101534.9637-1-peterx@redhat.com>
References: <20190905101534.9637-1-peterx@redhat.com>
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

