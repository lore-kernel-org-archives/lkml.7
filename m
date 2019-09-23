Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E1EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FE12087C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406610AbfIWE0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 00:26:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405826AbfIWE0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 00:26:53 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A9B63B71F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 04:26:52 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id f8so175833plj.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 21:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4oZOlVdiq1iUNu2ipKdKrBjjBpOUecRmSvPVqDDXZc=;
        b=Oq/7zhuZwAz0bwKWpXkx9GKeYzfIjCbrpGX6d3F2LwpOwahJjeSqoBcfIna//oxwWw
         GwlaoVdav9S7vcWBgIXOr1l8b2fvHYt+FwDc+IJX8FmeGjplFIAFLPzKCvk9UVR31PQH
         VtbBNKrHIJudAlobDVGzrGKWUfuNDdgkwoudxiQ9hIKDZ4FQWKBWJLytUB16673PbWZv
         GmPvi+l51EItSvkIjgwQjh7uurgudDKCYnh2rgYUKBFvgwCSeV++R5bXdY9WxHgX4wui
         aKBKJzfly1ooLSmB1jFWVANyn1c6ghl/0/6P3LqpjfdZ9rfZD6AScV8XJR2U/Nd+G2li
         YhrA==
X-Gm-Message-State: APjAAAUBEWn4R8NWmH5hZCW47ofSYfKbgYsHeh2N0xF68sLB30k/V/2w
        PHWjqjznqnELkiqL0HvKMYb/MRYISodfmhoe9ykQifrtMClUs4ZFZPlVAY4X3JpTuN/oAIEzYwY
        7T1kVrrLM1wXpkB7Kx8Huoo4z
X-Received: by 2002:a17:902:166:: with SMTP id 93mr30567156plb.195.1569212811912;
        Sun, 22 Sep 2019 21:26:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqye+DK7u0JotOoJqpvnTZrRb6/Qt3/D8C+ZXa1+qVSUReRHxlafT5dNKcY1JDA9hSKH4gDDqQ==
X-Received: by 2002:a17:902:166:: with SMTP id 93mr30567137plb.195.1569212811739;
        Sun, 22 Sep 2019 21:26:51 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x20sm11781867pfp.120.2019.09.22.21.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 21:26:51 -0700 (PDT)
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
Subject: [PATCH v4 10/10] mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in fault path
Date:   Mon, 23 Sep 2019 12:25:23 +0800
Message-Id: <20190923042523.10027-11-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923042523.10027-1-peterx@redhat.com>
References: <20190923042523.10027-1-peterx@redhat.com>
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

