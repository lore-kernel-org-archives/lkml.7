Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4085C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F2620656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfF1Kpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:45:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfF1Kpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:45:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17EE88552E;
        Fri, 28 Jun 2019 10:45:40 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 757175D71B;
        Fri, 28 Jun 2019 10:45:27 +0000 (UTC)
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
Subject: [PATCH 4/7] mm: Return faster for non-fatal signals in user mode faults
Date:   Fri, 28 Jun 2019 18:44:29 +0800
Message-Id: <20190628104432.12799-5-peterx@redhat.com>
In-Reply-To: <20190628104432.12799-1-peterx@redhat.com>
References: <20190628104432.12799-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 28 Jun 2019 10:45:40 +0000 (UTC)
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

This patch is a preparation of removing that special path by allowing
the page fault to return even faster if we were interrupted by a
non-fatal signal during a user-mode page fault handling routine.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/alpha/mm/fault.c        |  3 ++-
 arch/arc/mm/fault.c          | 14 ++++----------
 arch/arm/mm/fault.c          |  9 +++++----
 arch/arm64/mm/fault.c        |  9 +++++----
 arch/hexagon/mm/vm_fault.c   |  3 ++-
 arch/ia64/mm/fault.c         |  3 ++-
 arch/m68k/mm/fault.c         |  5 +++--
 arch/microblaze/mm/fault.c   |  3 ++-
 arch/mips/mm/fault.c         |  3 ++-
 arch/nds32/mm/fault.c        |  9 +++++----
 arch/nios2/mm/fault.c        |  3 ++-
 arch/openrisc/mm/fault.c     |  3 ++-
 arch/parisc/mm/fault.c       |  3 ++-
 arch/powerpc/mm/fault.c      |  2 ++
 arch/riscv/mm/fault.c        |  5 +++--
 arch/s390/mm/fault.c         |  4 ++--
 arch/sh/mm/fault.c           |  4 ++++
 arch/sparc/mm/fault_32.c     |  2 +-
 arch/sparc/mm/fault_64.c     |  3 ++-
 arch/um/kernel/trap.c        |  4 +++-
 arch/unicore32/mm/fault.c    |  5 +++--
 arch/x86/mm/fault.c          |  2 ++
 arch/xtensa/mm/fault.c       |  3 ++-
 include/linux/sched/signal.h | 12 ++++++++++++
 24 files changed, 74 insertions(+), 42 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index fceb684d3090..adf5c46ddb68 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -150,7 +150,8 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	   the fault.  */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs)))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 9f9b55d431ac..49b6a6802862 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -136,17 +136,11 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if (fatal_signal_pending(current)) {
-
-		/*
-		 * if fault retry, mmap_sem already relinquished by core mm
-		 * so OK to return to user mode (with signal handled first)
-		 */
-		if (fault & VM_FAULT_RETRY) {
-			if (!user_mode(regs))
-				goto no_context;
+	if (unlikely((fault & VM_FAULT_RETRY) && signal_pending(current))) {
+		if (fatal_signal_pending(current) && !user_mode(regs))
+			goto no_context;
+		if (user_mode(regs))
 			return;
-		}
 	}
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index d98af3169d69..9af92c1c5510 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -311,14 +311,15 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	fault = __do_page_fault(mm, addr, fsr, flags, tsk);
 
-	/* If we need to retry but a fatal signal is pending, handle the
+	/* If we need to retry but a signal is pending, try to handle the
 	 * signal first. We do not need to release the mmap_sem because
 	 * it would already be released in __lock_page_or_retry in
 	 * mm/filemap.c. */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
-		if (!user_mode(regs))
+	if (unlikely(fault & VM_FAULT_RETRY && signal_pending(current))) {
+		if (fatal_signal_pending(current) && !user_mode(regs))
 			goto no_context;
-		return 0;
+		if (user_mode(regs))
+			return 0;
 	}
 
 	/*
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 1cdd68e1c63c..40cb184068f2 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -502,15 +502,16 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 
 	if (fault & VM_FAULT_RETRY) {
 		/*
-		 * If we need to retry but a fatal signal is pending,
+		 * If we need to retry but a signal is pending, try to
 		 * handle the signal first. We do not need to release
 		 * the mmap_sem because it would already be released
 		 * in __lock_page_or_retry in mm/filemap.c.
 		 */
-		if (fatal_signal_pending(current)) {
-			if (!user_mode(regs))
+		if (signal_pending(current)) {
+			if (fatal_signal_pending(current) && !user_mode(regs))
 				goto no_context;
-			return 0;
+			if (user_mode(regs))
+				return 0;
 		}
 
 		/*
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index c0411412ce3c..e051564b5e33 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -91,7 +91,8 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs)))
 		return;
 
 	/* The most common case -- we are done. */
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index b01588e18079..54fc86b4f418 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -163,7 +163,8 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs)))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 22e4e6c68bfe..6376c079ea54 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -138,8 +138,9 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	fault = handle_mm_fault(vma, address, flags);
 	pr_debug("handle_mm_fault returns %x\n", fault);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
-		return 0;
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs)))
+		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index fff0e08ec7c6..03c6a4cdf66c 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -217,7 +217,8 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs)))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 5879dd93bf34..f0b34674a01f 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -154,7 +154,8 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs)))
 		return;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 875e254aaa7c..d203d9b0f7a0 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -206,14 +206,15 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	fault = handle_mm_fault(vma, addr, flags);
 
 	/*
-	 * If we need to retry but a fatal signal is pending, handle the
+	 * If we need to retry but a signal is pending, try to handle the
 	 * signal first. We do not need to release the mmap_sem because it
 	 * would already be released in __lock_page_or_retry in mm/filemap.c.
 	 */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
-		if (!user_mode(regs))
+	if ((fault & VM_FAULT_RETRY) && signal_pending(current)) {
+		if (fatal_signal_pending(current) && !user_mode(regs))
 			goto no_context;
-		return;
+		if (user_mode(regs))
+			return;
 	}
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index a401b45cae47..f9f178484184 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -133,7 +133,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs)))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index ebdddcc1de60..26150520bee4 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -161,7 +161,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs)))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 48cc1305850a..46a0fcecabe1 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -303,7 +303,8 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs)))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 6d86d6b52b73..bf06a407d1a7 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -616,6 +616,8 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 			 */
 			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
+			if (is_user && signal_pending(current))
+				return 0;
 			if (!fatal_signal_pending(current))
 				goto retry;
 		}
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index a6b26c588ae6..ddd43d9ae45e 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -111,11 +111,12 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	fault = handle_mm_fault(vma, addr, flags);
 
 	/*
-	 * If we need to retry but a fatal signal is pending, handle the
+	 * If we need to retry but a signal is pending, try to handle the
 	 * signal first. We do not need to release the mmap_sem because it
 	 * would already be released in __lock_page_or_retry in mm/filemap.c.
 	 */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(tsk))
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs)))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 1717163e850a..62235ec77b03 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -493,8 +493,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
-	/* No reason to continue if interrupted by SIGKILL. */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs))) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
 			goto out_up;
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 5ca9f80f18d3..be559fcaa3ca 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -506,6 +506,10 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
+
+			if (user_mode(regs) && signal_pending(tsk))
+				return;
+
 			goto retry;
 		}
 	}
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index a2c9610e1666..9bcbfcb1b8c3 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -237,7 +237,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) && fault_should_check_signal(from_user))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 89a3a7913854..1c9d51b62222 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -435,7 +435,8 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(flags & FAULT_FLAG_USER))
 		goto exit_exception;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 9342ff15ac0d..3eaf37a5539f 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -76,7 +76,9 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 
 		fault = handle_mm_fault(vma, address, flags);
 
-		if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+
+		if ((fault & VM_FAULT_RETRY) &&
+		    fault_should_check_signal(is_user))
 			goto out_nosemaphore;
 
 		if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 0516c72ae702..185c9b1a7a55 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -245,11 +245,12 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	fault = __do_pf(mm, addr, fsr, flags, tsk);
 
-	/* If we need to retry but a fatal signal is pending, handle the
+	/* If we need to retry but a signal is pending, try to handle the
 	 * signal first. We do not need to release the mmap_sem because
 	 * it would already be released in __lock_page_or_retry in
 	 * mm/filemap.c. */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs)))
 		return 0;
 
 	if (!(fault & VM_FAULT_ERROR) && (flags & FAULT_FLAG_ALLOW_RETRY)) {
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 0b0d7737972a..f1b5df6758e5 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1467,6 +1467,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
 			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
+			if ((flags & FAULT_FLAG_USER) && signal_pending(tsk))
+				return;
 			if (!fatal_signal_pending(tsk))
 				goto retry;
 		}
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index d16b0607f147..b9c2ea0de49b 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -110,7 +110,8 @@ void do_page_fault(struct pt_regs *regs)
 	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) &&
+	    fault_should_check_signal(user_mode(regs)))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 38a0f0785323..a22ad4f25072 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -374,6 +374,18 @@ static inline int signal_pending_state(long state, struct task_struct *p)
 	return (state & TASK_INTERRUPTIBLE) || __fatal_signal_pending(p);
 }
 
+/*
+ * This should only be used in fault handlers to decide whether we
+ * should stop the current fault routine to handle the signals
+ * instead.  It should normally be used when a signal interrupted a
+ * page fault which can lead to a VM_FAULT_RETRY.
+ */
+static inline bool fault_should_check_signal(bool is_user)
+{
+	return (fatal_signal_pending(current) ||
+		(is_user && signal_pending(current)));
+}
+
 /*
  * Reevaluate whether the task has signals pending delivery.
  * Wake the task if so.
-- 
2.21.0

