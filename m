Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C81C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2C9222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfIZJjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:39:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfIZJjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:39:44 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CD9E2DD43
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:39:44 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id w126so1336290pfd.22
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Xf2mVS9qjlemJ5iahoMhXHUO104cWay/UtduMM59II=;
        b=KTgbfkPc9Md5EHEqUc3eh04md5+9bsSsR51+iSwRGOiJJTfeU1ayh00TFw0lqJb89S
         w6+kzOsZxPx5DlHgTdlXUPCZwmEzsDqqwsFLHgAOkqPTxPn4boKqycTkgGRcr1n5mJBB
         kFXdRmSvNNfJejdKPZOQ+1rOat0gnMa4bNpzjTXNMIUsrhhTL4bC7j4XZ3yfW0b/H4yX
         CRj4w3RzcxPaqf+5utJEMOYAK9fbaIcTDxXBPqh2xO4rrjoqkYejpes1wVr3RZx5RoiX
         oAps2K+7C73Pj+IRBPb+AZ9H+XG99CvXSzLEk49EriWMqDLImTnEpuU6G6hX1I9ai9lH
         SHqA==
X-Gm-Message-State: APjAAAU9efUyJptT30EJbVIqSGAz5tu3u+yFZvtxbFlzCftHrs0+JYqf
        rH4vczH18T3/fvcCwo9Lxu9quOVbskfYkLvbF0MM3cKPJMTKMmjWsw2wRolA20pZKffBh2I834Z
        k4dPxaId3kdW/cj4nw8RIXkTh
X-Received: by 2002:a17:902:7615:: with SMTP id k21mr3121427pll.116.1569490782954;
        Thu, 26 Sep 2019 02:39:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxHW0fwK+IoUchcWFPvMLpv6AvUXTp+y8D8ocp6GpWly4yG9DEolwsrBfK/u0buOfL3Ie3qTg==
X-Received: by 2002:a17:902:7615:: with SMTP id k21mr3121390pll.116.1569490782632;
        Thu, 26 Sep 2019 02:39:42 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:39:41 -0700 (PDT)
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
Subject: [PATCH v5 03/16] mm: Introduce fault_signal_pending()
Date:   Thu, 26 Sep 2019 17:38:51 +0800
Message-Id: <20190926093904.5090-4-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For most architectures, we've got a quick path to detect fatal signal
after a handle_mm_fault().  Introduce a helper for that quick path.

It cleans the current codes a bit so we don't need to duplicate the
same check across archs.  More importantly, this will be an unified
place that we handle the signal immediately right after an interrupted
page fault, so it'll be much easier for us if we want to change the
behavior of handling signals later on for all the archs.

Note that currently only part of the archs are using this new helper,
because some archs have their own way to handle signals.  In the
follow up patches, we'll try to apply this helper to all the rest of
archs.

Another note is that the "regs" parameter in the new helper is not
used yet.  It'll be used very soon.  Now we kept it in this patch only
to avoid touching all the archs again in the follow up patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/alpha/mm/fault.c        |  2 +-
 arch/arm/mm/fault.c          |  2 +-
 arch/hexagon/mm/vm_fault.c   |  2 +-
 arch/ia64/mm/fault.c         |  2 +-
 arch/m68k/mm/fault.c         |  2 +-
 arch/microblaze/mm/fault.c   |  2 +-
 arch/mips/mm/fault.c         |  2 +-
 arch/nds32/mm/fault.c        |  2 +-
 arch/nios2/mm/fault.c        |  2 +-
 arch/openrisc/mm/fault.c     |  2 +-
 arch/parisc/mm/fault.c       |  2 +-
 arch/riscv/mm/fault.c        |  2 +-
 arch/s390/mm/fault.c         |  3 +--
 arch/sparc/mm/fault_32.c     |  2 +-
 arch/sparc/mm/fault_64.c     |  2 +-
 arch/unicore32/mm/fault.c    |  2 +-
 arch/xtensa/mm/fault.c       |  2 +-
 include/linux/sched/signal.h | 13 +++++++++++++
 18 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 741e61ef9d3f..aea33b599037 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -150,7 +150,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	   the fault.  */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 890eeaac3cbb..c8f2950fa733 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -295,7 +295,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * signal first. We do not need to release the mmap_sem because
 	 * it would already be released in __lock_page_or_retry in
 	 * mm/filemap.c. */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
+	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			goto no_context;
 		return 0;
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index b3bc71680ae4..d19beaf11b4c 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -91,7 +91,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	/* The most common case -- we are done. */
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index c2f299fe9e04..211b4f439384 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -141,7 +141,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index e9b1d7585b43..a455e202691b 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -138,7 +138,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	fault = handle_mm_fault(vma, address, flags);
 	pr_debug("handle_mm_fault returns %x\n", fault);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return 0;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index e6a810b0c7ad..cdde01dcdfc3 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -217,7 +217,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index f589aa8f47d9..31fda59199eb 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -154,7 +154,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(regs))
 		return;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 064ae5d2159d..c8f32b4784bd 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -210,7 +210,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	 * signal first. We do not need to release the mmap_sem because it
 	 * would already be released in __lock_page_or_retry in mm/filemap.c.
 	 */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
+	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			goto no_context;
 		return;
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index 6a2e716b959f..704ace8ca0ee 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -133,7 +133,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 5d4d3a9691d0..85c7eb0c0186 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -161,7 +161,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index adbd5e2144a3..f9be1d1cb43f 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -304,7 +304,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 96add1427a75..48a60e128b3f 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -115,7 +115,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * signal first. We do not need to release the mmap_sem because it
 	 * would already be released in __lock_page_or_retry in mm/filemap.c.
 	 */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(tsk))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 7b0bb475c166..179cf92a56e5 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -480,8 +480,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
-	/* No reason to continue if interrupted by SIGKILL. */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
+	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
 			goto out_up;
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 8d69de111470..7a62edf7f68b 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -237,7 +237,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 2371fb6b97e4..d90bafb63e17 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -421,7 +421,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		goto exit_exception;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 76342de9cf8c..59d0e6ec2cfc 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -250,7 +250,7 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * signal first. We do not need to release the mmap_sem because
 	 * it would already be released in __lock_page_or_retry in
 	 * mm/filemap.c. */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return 0;
 
 	if (!(fault & VM_FAULT_ERROR) && (flags & FAULT_FLAG_ALLOW_RETRY)) {
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index f81b1478da61..8651520de460 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -110,7 +110,7 @@ void do_page_fault(struct pt_regs *regs)
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index efd8ce7675ed..46429192733b 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -377,6 +377,19 @@ static inline int signal_pending_state(long state, struct task_struct *p)
 	return (state & TASK_INTERRUPTIBLE) || __fatal_signal_pending(p);
 }
 
+/*
+ * This should only be used in fault handlers to decide whether we
+ * should stop the current fault routine to handle the signals
+ * instead, especially with the case where we've got interrupted with
+ * a VM_FAULT_RETRY.
+ */
+static inline bool fault_signal_pending(unsigned int fault_flags,
+					struct pt_regs *regs)
+{
+	return unlikely((fault_flags & VM_FAULT_RETRY) &&
+			fatal_signal_pending(current));
+}
+
 /*
  * Reevaluate whether the task has signals pending delivery.
  * Wake the task if so.
-- 
2.21.0

