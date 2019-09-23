Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5AFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209B720820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfIWE0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 00:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfIWE0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 00:26:11 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22F8A883C2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 04:26:11 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id f8so175203plj.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 21:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GXIovqwqm63wtxzzyeIbAQrpQWpcAdR9JxWJf3/Rl1Y=;
        b=o5E1l53LErR3s4OIW+hvnymQBEnCooSAFgNiLGGcf6mQr/q3oKj7wrRQBDXQVmVyRB
         LjGOYExFLMmHSiBGLHGVM5CtdVHpN9dpCmeJEQrhyLzxOZe+iQ0HPWL9KxbZ2IqRZhYd
         mCVOcX6YC94ox76oanxu7d3KWr9a3+iTGOabeb4djJXfim1C+N86klX93RoZwnBtOYRC
         6tH/5xfKPzMV1nJmAuetuTeKtPtB7+TEHKlKjTRM/W6DPy2YFRRzQs6+vXIrMs4uBg56
         QNuhFudkhQhQVOptbDq1JzzhLFAF8ksxvBieH4pWTypVWv638fP+v3YUAe8NdQ+twSyS
         CLXQ==
X-Gm-Message-State: APjAAAXdlZjviq3tMWnoGxLVy7lHXRHkLF+W7jNWMw5Te8kU0ZoerDrE
        i8BFpq0k9SsgOI2zeVKmmwIT4uf+dScy5J8o8MiEf6rlDwhGTmnPzmxW/DK4DhdskQqdn4XKVym
        3LVd2iHKwBpzngGQlIEjpxBXz
X-Received: by 2002:aa7:8acf:: with SMTP id b15mr24586110pfd.191.1569212770634;
        Sun, 22 Sep 2019 21:26:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx6iUJWUgZ29uQGs7aHG+ZKt7JXzV+Gz1NXrFI6pYw3jfFgBbkb+Z15GkLEoauMRbp2DWsMsw==
X-Received: by 2002:aa7:8acf:: with SMTP id b15mr24586091pfd.191.1569212770425;
        Sun, 22 Sep 2019 21:26:10 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x20sm11781867pfp.120.2019.09.22.21.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 21:26:09 -0700 (PDT)
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
Subject: [PATCH v4 04/10] mm: Introduce FAULT_FLAG_INTERRUPTIBLE
Date:   Mon, 23 Sep 2019 12:25:17 +0800
Message-Id: <20190923042523.10027-5-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923042523.10027-1-peterx@redhat.com>
References: <20190923042523.10027-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

handle_userfaultfd() is currently the only one place in the kernel
page fault procedures that can respond to non-fatal userspace signals.
It was trying to detect such an allowance by checking against USER &
KILLABLE flags, which was "un-official".

In this patch, we introduced a new flag (FAULT_FLAG_INTERRUPTIBLE) to
show that the fault handler allows the fault procedure to respond even
to non-fatal signals.  Meanwhile, add this new flag to the default
fault flags so that all the page fault handlers can benefit from the
new flag.  With that, replacing the userfault check to this one.

Since the line is getting even longer, clean up the fault flags a bit
too to ease TTY users.

Although we've got a new flag and applied it, we shouldn't have any
functional change with this patch so far.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c   |  4 +---
 include/linux/mm.h | 39 ++++++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index fe6d804a38dc..3c55ee64bcb1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -462,9 +462,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	uwq.ctx = ctx;
 	uwq.waken = false;
 
-	return_to_userland =
-		(vmf->flags & (FAULT_FLAG_USER|FAULT_FLAG_KILLABLE)) ==
-		(FAULT_FLAG_USER|FAULT_FLAG_KILLABLE);
+	return_to_userland = vmf->flags & FAULT_FLAG_INTERRUPTIBLE;
 	blocking_state = return_to_userland ? TASK_INTERRUPTIBLE :
 			 TASK_KILLABLE;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 57fb5c535f8e..53ec7abb8472 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -383,22 +383,38 @@ extern unsigned int kobjsize(const void *objp);
  */
 extern pgprot_t protection_map[16];
 
-#define FAULT_FLAG_WRITE	0x01	/* Fault was a write access */
-#define FAULT_FLAG_MKWRITE	0x02	/* Fault was mkwrite of existing pte */
-#define FAULT_FLAG_ALLOW_RETRY	0x04	/* Retry fault if blocking */
-#define FAULT_FLAG_RETRY_NOWAIT	0x08	/* Don't drop mmap_sem and wait when retrying */
-#define FAULT_FLAG_KILLABLE	0x10	/* The fault task is in SIGKILL killable region */
-#define FAULT_FLAG_TRIED	0x20	/* Second try */
-#define FAULT_FLAG_USER		0x40	/* The fault originated in userspace */
-#define FAULT_FLAG_REMOTE	0x80	/* faulting for non current tsk/mm */
-#define FAULT_FLAG_INSTRUCTION  0x100	/* The fault was during an instruction fetch */
+/**
+ * Fault flag definitions.
+ *
+ * @FAULT_FLAG_WRITE: Fault was a write fault.
+ * @FAULT_FLAG_MKWRITE: Fault was mkwrite of existing PTE.
+ * @FAULT_FLAG_ALLOW_RETRY: Allow to retry the fault if blocked.
+ * @FAULT_FLAG_RETRY_NOWAIT: Don't drop mmap_sem and wait when retrying.
+ * @FAULT_FLAG_KILLABLE: The fault task is in SIGKILL killable region.
+ * @FAULT_FLAG_TRIED: The fault has been tried once.
+ * @FAULT_FLAG_USER: The fault originated in userspace.
+ * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
+ * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
+ * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ */
+#define FAULT_FLAG_WRITE			0x01
+#define FAULT_FLAG_MKWRITE			0x02
+#define FAULT_FLAG_ALLOW_RETRY			0x04
+#define FAULT_FLAG_RETRY_NOWAIT			0x08
+#define FAULT_FLAG_KILLABLE			0x10
+#define FAULT_FLAG_TRIED			0x20
+#define FAULT_FLAG_USER				0x40
+#define FAULT_FLAG_REMOTE			0x80
+#define FAULT_FLAG_INSTRUCTION  		0x100
+#define FAULT_FLAG_INTERRUPTIBLE		0x200
 
 /*
  * The default fault flags that should be used by most of the
  * arch-specific page fault handlers.
  */
 #define FAULT_FLAG_DEFAULT  (FAULT_FLAG_ALLOW_RETRY | \
-			     FAULT_FLAG_KILLABLE)
+			     FAULT_FLAG_KILLABLE | \
+			     FAULT_FLAG_INTERRUPTIBLE)
 
 #define FAULT_FLAG_TRACE \
 	{ FAULT_FLAG_WRITE,		"WRITE" }, \
@@ -409,7 +425,8 @@ extern pgprot_t protection_map[16];
 	{ FAULT_FLAG_TRIED,		"TRIED" }, \
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
-	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }
+	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
 
 /*
  * vm_fault is filled by the the pagefault handler and passed to the vma's
-- 
2.21.0

