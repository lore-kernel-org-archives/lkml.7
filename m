Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53353ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26606222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfIKHKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfIKHKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:10:41 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79448C069B4B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 07:10:41 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id z13so14991825pfr.15
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 00:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRZuHtIpu1kWmysN8fGt73f3ShagvK1FUD0BwRzbsQk=;
        b=PVDNeOyagkFbP+854ddr1Ei2NWXzz9QTBzqyHx9ZHpve425uC3HIVHakomAjndBNgP
         Q2M9wTG8ZQ6kGg8/ph6Rfq4VQF7IPIi1fgZ2H5G/gNauldq111K2wrVjk+0WQL+anssv
         +kOanBPJMHNlEEqXeYT91JzRDLlWmeKCKnJlpK5Bg71DBd6yf5iWeai0f/h/yQTUprlT
         wyWP5VvTRL1uK2LcaldJNHfseYXlei0TjZG/s4eHuUJMP2OimguN9/4tY0rOWCXoC5TP
         eOVjGNklgX+T21GyHy6oTL4fw6MylvnOtbwgrteXthYrR+3ejRXYNsCtMsyI+Mz6kxb2
         JUrQ==
X-Gm-Message-State: APjAAAWXF39+3Nu14K08s2+cAlxY6uoa9UgTghHJynF7xPgidoAaHyfK
        n0N2wpI+U1mdW1j0Gd1lNzFd+6FrU60JPu6txSH4A+0BM4luUHPpo/L2wG1Zw+qd0awrDQ3S9Tq
        lNIdqQhCmCZIzi8PDyygWpN1X
X-Received: by 2002:a17:90a:8087:: with SMTP id c7mr3941890pjn.59.1568185840886;
        Wed, 11 Sep 2019 00:10:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyXqWwipKZlbNXuE5nSmvPfMz0PF4ACL32nLVeD8IPCXyUeFRzLXRsOGRhumPNt++A4TAfHVA==
X-Received: by 2002:a17:90a:8087:: with SMTP id c7mr3941869pjn.59.1568185840666;
        Wed, 11 Sep 2019 00:10:40 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j10sm1573091pjn.3.2019.09.11.00.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 00:10:39 -0700 (PDT)
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
Subject: [PATCH v3 3/7] mm: Introduce FAULT_FLAG_INTERRUPTIBLE
Date:   Wed, 11 Sep 2019 15:10:03 +0800
Message-Id: <20190911071007.20077-4-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911071007.20077-1-peterx@redhat.com>
References: <20190911071007.20077-1-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c   |  4 +---
 include/linux/mm.h | 39 ++++++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ccbdbd62f0d8..4a8ad2dc2b6f 100644
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

