Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78708C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329C620818
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bDsXbHxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfEQJLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 05:11:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56207 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfEQJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:11:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4H9A6ea1276014
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 17 May 2019 02:10:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4H9A6ea1276014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558084208;
        bh=esWes/HyiBs+HPZ1X4+FGUBTdfEIN0lDbsQRY5OvzCM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bDsXbHxNT6OBpvmk898pPKFP70Utw4t0tLo8NFz/hiHG+c55nfrcQherjV8WcSEJI
         b2T/pQ51idj3OBL3irHm1yYl0oN/aWU71ZZZ5Ysn4XxuQYQ697he7AgYTO6IVyatv2
         j4/xtMA5kViRyLg23DfY/wYX6aAxXtTnGFGQ7rh5DVsp3AOOnDbqfBoNCP764WwkON
         gx8YO9huTTnCqSm/6lHGZ3ENnBnWIf0wIJ39qiiTMrETStNZ0yN1spo9dW1E+GApFz
         CiMy4S8iT9oDQmmlDeFM0FQPls+nZ+yznLzHblJHfGWhg+P+G70EUTAsXpF7JIGbzu
         FXp6YrkyH+G6Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4H9A3qn1275997;
        Fri, 17 May 2019 02:10:03 -0700
Date:   Fri, 17 May 2019 02:10:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-5a28fc94c9143db766d1ba5480cae82d856ad080@git.kernel.org>
Cc:     paulus@samba.org, dave.hansen@linux.intel.com, luto@kernel.org,
        akpm@linux-foundation.org, bp@alien8.de,
        anton.ivanov@cambridgegreys.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, yang.shi@linux.alibaba.com,
        hjl.tools@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, rguenther@suse.de,
        torvalds@linux-foundation.org, richard@nod.at, mhocko@suse.com,
        peterz@infradead.org, vbabka@suse.cz, jdike@addtoit.com,
        hpa@zytor.com, mingo@kernel.org, gxt@pku.edu.cn, riel@surriel.com
Reply-To: dave.hansen@linux.intel.com, mhocko@suse.com, luto@kernel.org,
          torvalds@linux-foundation.org, richard@nod.at, paulus@samba.org,
          jdike@addtoit.com, anton.ivanov@cambridgegreys.com,
          hpa@zytor.com, peterz@infradead.org, akpm@linux-foundation.org,
          bp@alien8.de, vbabka@suse.cz, yang.shi@linux.alibaba.com,
          benh@kernel.crashing.org, mpe@ellerman.id.au, mingo@kernel.org,
          linux-kernel@vger.kernel.org, rguenther@suse.de,
          riel@surriel.com, hjl.tools@gmail.com, tglx@linutronix.de,
          gxt@pku.edu.cn
In-Reply-To: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
References: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] x86/mpx, mm/core: Fix recursive munmap()
 corruption
Git-Commit-ID: 5a28fc94c9143db766d1ba5480cae82d856ad080
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5a28fc94c9143db766d1ba5480cae82d856ad080
Gitweb:     https://git.kernel.org/tip/5a28fc94c9143db766d1ba5480cae82d856ad080
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 19 Apr 2019 12:47:47 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 9 May 2019 10:37:17 +0200

x86/mpx, mm/core: Fix recursive munmap() corruption

This is a bit of a mess, to put it mildly.  But, it's a bug
that only seems to have showed up in 4.20 but wasn't noticed
until now, because nobody uses MPX.

MPX has the arch_unmap() hook inside of munmap() because MPX
uses bounds tables that protect other areas of memory.  When
memory is unmapped, there is also a need to unmap the MPX
bounds tables.  Barring this, unused bounds tables can eat 80%
of the address space.

But, the recursive do_munmap() that gets called vi arch_unmap()
wreaks havoc with __do_munmap()'s state.  It can result in
freeing populated page tables, accessing bogus VMA state,
double-freed VMAs and more.

See the "long story" further below for the gory details.

To fix this, call arch_unmap() before __do_unmap() has a chance
to do anything meaningful.  Also, remove the 'vma' argument
and force the MPX code to do its own, independent VMA lookup.

== UML / unicore32 impact ==

Remove unused 'vma' argument to arch_unmap().  No functional
change.

I compile tested this on UML but not unicore32.

== powerpc impact ==

powerpc uses arch_unmap() well to watch for munmap() on the
VDSO and zeroes out 'current->mm->context.vdso_base'.  Moving
arch_unmap() makes this happen earlier in __do_munmap().  But,
'vdso_base' seems to only be used in perf and in the signal
delivery that happens near the return to userspace.  I can not
find any likely impact to powerpc, other than the zeroing
happening a little earlier.

powerpc does not use the 'vma' argument and is unaffected by
its removal.

I compile-tested a 64-bit powerpc defconfig.

== x86 impact ==

For the common success case this is functionally identical to
what was there before.  For the munmap() failure case, it's
possible that some MPX tables will be zapped for memory that
continues to be in use.  But, this is an extraordinarily
unlikely scenario and the harm would be that MPX provides no
protection since the bounds table got reset (zeroed).

I can't imagine anyone doing this:

	ptr = mmap();
	// use ptr
	ret = munmap(ptr);
	if (ret)
		// oh, there was an error, I'll
		// keep using ptr.

Because if you're doing munmap(), you are *done* with the
memory.  There's probably no good data in there _anyway_.

This passes the original reproducer from Richard Biener as
well as the existing mpx selftests/.

The long story:

munmap() has a couple of pieces:

 1. Find the affected VMA(s)
 2. Split the start/end one(s) if neceesary
 3. Pull the VMAs out of the rbtree
 4. Actually zap the memory via unmap_region(), including
    freeing page tables (or queueing them to be freed).
 5. Fix up some of the accounting (like fput()) and actually
    free the VMA itself.

This specific ordering was actually introduced by:

  dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")

during the 4.20 merge window.  The previous __do_munmap() code
was actually safe because the only thing after arch_unmap() was
remove_vma_list().  arch_unmap() could not see 'vma' in the
rbtree because it was detached, so it is not even capable of
doing operations unsafe for remove_vma_list()'s use of 'vma'.

Richard Biener reported a test that shows this in dmesg:

  [1216548.787498] BUG: Bad rss-counter state mm:0000000017ce560b idx:1 val:551
  [1216548.787500] BUG: non-zero pgtables_bytes on freeing mm: 24576

What triggered this was the recursive do_munmap() called via
arch_unmap().  It was freeing page tables that has not been
properly zapped.

But, the problem was bigger than this.  For one, arch_unmap()
can free VMAs.  But, the calling __do_munmap() has variables
that *point* to VMAs and obviously can't handle them just
getting freed while the pointer is still in use.

I tried a couple of things here.  First, I tried to fix the page
table freeing problem in isolation, but I then found the VMA
issue.  I also tried having the MPX code return a flag if it
modified the rbtree which would force __do_munmap() to re-walk
to restart.  That spiralled out of control in complexity pretty
fast.

Just moving arch_unmap() and accepting that the bonkers failure
case might eat some bounds tables seems like the simplest viable
fix.

This was also reported in the following kernel bugzilla entry:

  https://bugzilla.kernel.org/show_bug.cgi?id=203123

There are some reports that this commit triggered this bug:

  dd2283f2605 ("mm: mmap: zap pages with read mmap_sem in munmap")

While that commit certainly made the issues easier to hit, I believe
the fundamental issue has been with us as long as MPX itself, thus
the Fixes: tag below is for one of the original MPX commits.

[ mingo: Minor edits to the changelog and the patch. ]

Reported-by: Richard Biener <rguenther@suse.de>
Reported-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Yang Shi <yang.shi@linux.alibaba.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Rik van Riel <riel@surriel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-um@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: stable@vger.kernel.org
Fixes: dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
Link: http://lkml.kernel.org/r/20190419194747.5E1AD6DC@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/powerpc/include/asm/mmu_context.h   |  1 -
 arch/um/include/asm/mmu_context.h        |  1 -
 arch/unicore32/include/asm/mmu_context.h |  1 -
 arch/x86/include/asm/mmu_context.h       |  6 +++---
 arch/x86/include/asm/mpx.h               | 15 ++++++++-------
 arch/x86/mm/mpx.c                        | 10 ++++++----
 include/asm-generic/mm_hooks.h           |  1 -
 mm/mmap.c                                | 15 ++++++++-------
 8 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 6ee8195a2ffb..4a6dd3ba0b0b 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -237,7 +237,6 @@ extern void arch_exit_mmap(struct mm_struct *mm);
 #endif
 
 static inline void arch_unmap(struct mm_struct *mm,
-			      struct vm_area_struct *vma,
 			      unsigned long start, unsigned long end)
 {
 	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index fca34b2177e2..9f4b4bb78120 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -22,7 +22,6 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
 }
 extern void arch_exit_mmap(struct mm_struct *mm);
 static inline void arch_unmap(struct mm_struct *mm,
-			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
 }
diff --git a/arch/unicore32/include/asm/mmu_context.h b/arch/unicore32/include/asm/mmu_context.h
index 5c205a9cb5a6..9f06ea5466dd 100644
--- a/arch/unicore32/include/asm/mmu_context.h
+++ b/arch/unicore32/include/asm/mmu_context.h
@@ -88,7 +88,6 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
 }
 
 static inline void arch_unmap(struct mm_struct *mm,
-			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
 }
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 93dff1963337..9024236693d2 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -278,8 +278,8 @@ static inline void arch_bprm_mm_init(struct mm_struct *mm,
 	mpx_mm_init(mm);
 }
 
-static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
-			      unsigned long start, unsigned long end)
+static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
+			      unsigned long end)
 {
 	/*
 	 * mpx_notify_unmap() goes and reads a rarely-hot
@@ -299,7 +299,7 @@ static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * consistently wrong.
 	 */
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_MPX)))
-		mpx_notify_unmap(mm, vma, start, end);
+		mpx_notify_unmap(mm, start, end);
 }
 
 /*
diff --git a/arch/x86/include/asm/mpx.h b/arch/x86/include/asm/mpx.h
index d0b1434fb0b6..143a5c193ed3 100644
--- a/arch/x86/include/asm/mpx.h
+++ b/arch/x86/include/asm/mpx.h
@@ -64,12 +64,15 @@ struct mpx_fault_info {
 };
 
 #ifdef CONFIG_X86_INTEL_MPX
-int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs);
-int mpx_handle_bd_fault(void);
+
+extern int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs);
+extern int mpx_handle_bd_fault(void);
+
 static inline int kernel_managing_mpx_tables(struct mm_struct *mm)
 {
 	return (mm->context.bd_addr != MPX_INVALID_BOUNDS_DIR);
 }
+
 static inline void mpx_mm_init(struct mm_struct *mm)
 {
 	/*
@@ -78,11 +81,10 @@ static inline void mpx_mm_init(struct mm_struct *mm)
 	 */
 	mm->context.bd_addr = MPX_INVALID_BOUNDS_DIR;
 }
-void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
-		      unsigned long start, unsigned long end);
 
-unsigned long mpx_unmapped_area_check(unsigned long addr, unsigned long len,
-		unsigned long flags);
+extern void mpx_notify_unmap(struct mm_struct *mm, unsigned long start, unsigned long end);
+extern unsigned long mpx_unmapped_area_check(unsigned long addr, unsigned long len, unsigned long flags);
+
 #else
 static inline int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs)
 {
@@ -100,7 +102,6 @@ static inline void mpx_mm_init(struct mm_struct *mm)
 {
 }
 static inline void mpx_notify_unmap(struct mm_struct *mm,
-				    struct vm_area_struct *vma,
 				    unsigned long start, unsigned long end)
 {
 }
diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index c805db6236b4..7aeb9fe2955f 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -881,9 +881,10 @@ static int mpx_unmap_tables(struct mm_struct *mm,
  * the virtual address region start...end have already been split if
  * necessary, and the 'vma' is the first vma in this range (start -> end).
  */
-void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end)
+void mpx_notify_unmap(struct mm_struct *mm, unsigned long start,
+		      unsigned long end)
 {
+	struct vm_area_struct *vma;
 	int ret;
 
 	/*
@@ -902,11 +903,12 @@ void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * which should not occur normally. Being strict about it here
 	 * helps ensure that we do not have an exploitable stack overflow.
 	 */
-	do {
+	vma = find_vma(mm, start);
+	while (vma && vma->vm_start < end) {
 		if (vma->vm_flags & VM_MPX)
 			return;
 		vma = vma->vm_next;
-	} while (vma && vma->vm_start < end);
+	}
 
 	ret = mpx_unmap_tables(mm, start, end);
 	if (ret)
diff --git a/include/asm-generic/mm_hooks.h b/include/asm-generic/mm_hooks.h
index 8ac4e68a12f0..6736ed2f632b 100644
--- a/include/asm-generic/mm_hooks.h
+++ b/include/asm-generic/mm_hooks.h
@@ -18,7 +18,6 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
 }
 
 static inline void arch_unmap(struct mm_struct *mm,
-			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index bd7b9f293b39..2d6a6662edb9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2735,9 +2735,17 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		return -EINVAL;
 
 	len = PAGE_ALIGN(len);
+	end = start + len;
 	if (len == 0)
 		return -EINVAL;
 
+	/*
+	 * arch_unmap() might do unmaps itself.  It must be called
+	 * and finish any rbtree manipulation before this code
+	 * runs and also starts to manipulate the rbtree.
+	 */
+	arch_unmap(mm, start, end);
+
 	/* Find the first overlapping VMA */
 	vma = find_vma(mm, start);
 	if (!vma)
@@ -2746,7 +2754,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	/* we have  start < vma->vm_end  */
 
 	/* if it doesn't overlap, we have nothing.. */
-	end = start + len;
 	if (vma->vm_start >= end)
 		return 0;
 
@@ -2816,12 +2823,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	/* Detach vmas from rbtree */
 	detach_vmas_to_be_unmapped(mm, vma, prev, end);
 
-	/*
-	 * mpx unmap needs to be called with mmap_sem held for write.
-	 * It is safe to call it before unmap_region().
-	 */
-	arch_unmap(mm, vma, start, end);
-
 	if (downgrade)
 		downgrade_write(&mm->mmap_sem);
 
