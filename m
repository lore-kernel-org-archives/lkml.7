Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13073C4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E863320820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404261AbfIWE03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 00:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403797AbfIWE00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 00:26:26 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 503C2C056808
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 04:26:26 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id s139so9382610pfc.21
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 21:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmCNR49q9HpXGRvKjuRuWGZM/G5xvOD8IvISTorYf1k=;
        b=NB8HZJbD6nArOGR+1GN2PbBPCk0qeZ3DqiXnWxZHbb9+lSOKZCw7O32K03rFa9kVJR
         niUJgGhOv5paq9kVyISTOWD7/EbMDBOjDOJU2WQY0P10jDBx2MpdxFov1/hAEpKZLjOw
         RnFZ/bX7MmWd/fpkhwab1zQ5GvjFtnymEyF6EUJNzcQtTUgBpaWpstIELsbz6dpKWSvu
         4OvSImf/TJu578y6WxilE+zgB8NY6llBIY2om5wMEL+bIG8q2h/RmQ3mdNAIzEHFJJUc
         qtB9fSlH8gCyj2hBSrJ6km0f1uYuDKjPsCbWijEIdj95/wEGGKhf+l3JgBgUFHMm1R4X
         5utg==
X-Gm-Message-State: APjAAAVVTplAzu0NTW3xRdeE98OR/Yg0mnxAklkhhsOnzYTwKGO0oInT
        ikbqKbAkCRazzY1bAI1u/FaLEpterewFiO2OYlnhz6+P0bn+6mDfUqceeoa7I1frMvm6YPovQE4
        JmRhEfhNA18ttEkVMP91lBFzC
X-Received: by 2002:a65:5546:: with SMTP id t6mr27177520pgr.441.1569212785758;
        Sun, 22 Sep 2019 21:26:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqygb3V/LkvF1CW/oddzTISxP+CyZpRHXEfJdMfg/L+uhJ5pN2m1AqoDMJvxWgNhDIwD+LUMWA==
X-Received: by 2002:a65:5546:: with SMTP id t6mr27177491pgr.441.1569212785463;
        Sun, 22 Sep 2019 21:26:25 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x20sm11781867pfp.120.2019.09.22.21.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 21:26:24 -0700 (PDT)
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
Subject: [PATCH v4 06/10] userfaultfd: Don't retake mmap_sem to emulate NOPAGE
Date:   Mon, 23 Sep 2019 12:25:19 +0800
Message-Id: <20190923042523.10027-7-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923042523.10027-1-peterx@redhat.com>
References: <20190923042523.10027-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the risk path in handle_userfault() then we will be
sure that the callers of handle_mm_fault() will know that the VMAs
might have changed.  Meanwhile with previous patch we don't lose
responsiveness as well since the core mm code now can handle the
nonfatal userspace signals even if we return VM_FAULT_RETRY.

Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 3c55ee64bcb1..2b3b48e94ae4 100644
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

