Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1824CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB46820656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfF1Kp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:45:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfF1Kp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:45:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01550308FC22;
        Fri, 28 Jun 2019 10:45:27 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C0805D71B;
        Fri, 28 Jun 2019 10:45:18 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 3/7] mm: Introduce FAULT_FLAG_INTERRUPTIBLE
Date:   Fri, 28 Jun 2019 18:44:28 +0800
Message-Id: <20190628104432.12799-4-peterx@redhat.com>
In-Reply-To: <20190628104432.12799-1-peterx@redhat.com>
References: <20190628104432.12799-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 28 Jun 2019 10:45:27 +0000 (UTC)
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
index ae0b8b5f69e6..50a21fba25d2 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -452,9 +452,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	uwq.ctx = ctx;
 	uwq.waken = false;
 
-	return_to_userland =
-		(vmf->flags & (FAULT_FLAG_USER|FAULT_FLAG_KILLABLE)) ==
-		(FAULT_FLAG_USER|FAULT_FLAG_KILLABLE);
+	return_to_userland = vmf->flags & FAULT_FLAG_INTERRUPTIBLE;
 	blocking_state = return_to_userland ? TASK_INTERRUPTIBLE :
 			 TASK_KILLABLE;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8eb796f2fa19..845a4f5153dd 100644
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

