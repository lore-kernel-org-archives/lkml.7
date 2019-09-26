Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB17EC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92408222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfIZJlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:41:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfIZJle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:41:34 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 506F6806D0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:41:33 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id 135so1054040pgc.23
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4oZOlVdiq1iUNu2ipKdKrBjjBpOUecRmSvPVqDDXZc=;
        b=gPQookwY8xYIIboBl1MVmgM/Vs5CAr52sbiyVFHQohk08xk51FdhlW7YMudnapLSfs
         fzvwEEODIjftfZMwq3MSm/S9sxrVC4lXJfl11Ae419L8Bvyek560uBcMUaamgJSIgsG5
         OFgyxCQtNNw7bf31+Y8p5NgRgxC3LiP0SGBwrA6Hln2uWYLdv195HK3QUy30em7fOno5
         RUL2ZvHCV0WRmOUHY5rCp6XkZ92ia0RBVBaxC2ZAk+ON/zQ9TUBdKMNUolrqN9fc+28j
         nzCPgCTlO5NGN532o2efkhRwkPBfA1QshohbQGn7ButVXsU47E4yxS9rESXMYycUPjfs
         zctg==
X-Gm-Message-State: APjAAAWUVPerc8RVDDTXxPmk63NgDqGqve0pVjdg/cdxJvDIobHCCc42
        GmVNjKB8bAEOjJhzX2YuwoM3Yhlo0Eri63cQC1oK7384PkXNHqpu3BmtUpW2QDyKHniJ9b0swp+
        wnour2QDkPhFOYHIqLzN388yV
X-Received: by 2002:a63:f74a:: with SMTP id f10mr2441657pgk.171.1569490892241;
        Thu, 26 Sep 2019 02:41:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzXg+JR19ww+nQnL8fkRXYx+C2hv4fDrwyyYRZ7ETfndG7uYUVVmTKADTP0SGN/MJh50aMeMQ==
X-Received: by 2002:a63:f74a:: with SMTP id f10mr2441638pgk.171.1569490892002;
        Thu, 26 Sep 2019 02:41:32 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:41:31 -0700 (PDT)
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
Subject: [PATCH v5 16/16] mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in fault path
Date:   Thu, 26 Sep 2019 17:39:04 +0800
Message-Id: <20190926093904.5090-17-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd fault path was by default killable even if the caller does
not have FAULT_FLAG_KILLABLE.  That makes sense before in that when
with gup we don't have FAULT_FLAG_KILLABLE properly set before.  Now
after previous patch we've got FAULT_FLAG_KILLABLE applied even for
gup code so it should also make sense to let userfaultfd to honor the
FAULT_FLAG_KILLABLE.

Because we're unconditionally setting FAULT_FLAG_KILLABLE in gup code
right now, this patch should have no functional change.  It also
cleaned the code a little bit by introducing some helpers.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 2b3b48e94ae4..8c5863ccbf0e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -334,6 +334,30 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	return ret;
 }
 
+/* Should pair with userfaultfd_signal_pending() */
+static inline long userfaultfd_get_blocking_state(unsigned int flags)
+{
+	if (flags & FAULT_FLAG_INTERRUPTIBLE)
+		return TASK_INTERRUPTIBLE;
+
+	if (flags & FAULT_FLAG_KILLABLE)
+		return TASK_KILLABLE;
+
+	return TASK_UNINTERRUPTIBLE;
+}
+
+/* Should pair with userfaultfd_get_blocking_state() */
+static inline bool userfaultfd_signal_pending(unsigned int flags)
+{
+	if (flags & FAULT_FLAG_INTERRUPTIBLE)
+		return signal_pending(current);
+
+	if (flags & FAULT_FLAG_KILLABLE)
+		return fatal_signal_pending(current);
+
+	return false;
+}
+
 /*
  * The locking rules involved in returning VM_FAULT_RETRY depending on
  * FAULT_FLAG_ALLOW_RETRY, FAULT_FLAG_RETRY_NOWAIT and
@@ -355,7 +379,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	struct userfaultfd_ctx *ctx;
 	struct userfaultfd_wait_queue uwq;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
-	bool must_wait, return_to_userland;
+	bool must_wait;
 	long blocking_state;
 
 	/*
@@ -462,9 +486,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	uwq.ctx = ctx;
 	uwq.waken = false;
 
-	return_to_userland = vmf->flags & FAULT_FLAG_INTERRUPTIBLE;
-	blocking_state = return_to_userland ? TASK_INTERRUPTIBLE :
-			 TASK_KILLABLE;
+	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
 
 	spin_lock_irq(&ctx->fault_pending_wqh.lock);
 	/*
@@ -490,8 +512,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	up_read(&mm->mmap_sem);
 
 	if (likely(must_wait && !READ_ONCE(ctx->released) &&
-		   (return_to_userland ? !signal_pending(current) :
-		    !fatal_signal_pending(current)))) {
+		   userfaultfd_signal_pending(vmf->flags))) {
 		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
 		schedule();
 		ret |= VM_FAULT_MAJOR;
@@ -513,8 +534,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 			set_current_state(blocking_state);
 			if (READ_ONCE(uwq.waken) ||
 			    READ_ONCE(ctx->released) ||
-			    (return_to_userland ? signal_pending(current) :
-			     fatal_signal_pending(current)))
+			    userfaultfd_signal_pending(vmf->flags))
 				break;
 			schedule();
 		}
-- 
2.21.0

