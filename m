Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E88DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204352183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gSMhv6z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388990AbfDRMnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:43:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRMnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:43:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3ICh4Gk191369
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Apr 2019 05:43:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3ICh4Gk191369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555591385;
        bh=qBcaZFLo33lmZ14WBDPwGBcgn1BQvKWtk+e3kN6xh1c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gSMhv6z5bTrjWexQT84qAPe7MXn4IKmbqw9cMKriJfHqnu6uPiIIF6VJ3n4CvMOQZ
         9LpNWol28qGHsiHhX2alhVpOrIVKKiEBzUGwH5zmBqbMR33j9EKTvXtlN7Fgp0GxKK
         N8i/pXYOj0EJ/hFKgeEdipspmJr0GdM3AgQmfaegYBQ13ijLTWZXYZrGLfq0Zw6GPI
         jrI1PLw4nPwV+sAAiR5ckRoV/z3LLF9VVl4pXt9L8O4Xc3upLe24VORw2RR9Y+CcFS
         0a0u5p/SD+m8BEQDP/amf698fYIXtWmgS6gIT5u6gwZ64XAmQuK34o/rtKrtdsa3Fr
         XhmaSELbH10NQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3ICh31m191362;
        Thu, 18 Apr 2019 05:43:03 -0700
Date:   Thu, 18 Apr 2019 05:43:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-508b8482ea2227ba8695d1cf8311166a455c2ae0@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, mhocko@suse.com,
        luto@amacapital.net, akpm@linux-foundation.org, rguenther@suse.de,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        vbabka@suse.cz
Reply-To: luto@amacapital.net, mhocko@suse.com, akpm@linux-foundation.org,
          tglx@linutronix.de, dave.hansen@linux.intel.com, vbabka@suse.cz,
          hpa@zytor.com, mingo@kernel.org, rguenther@suse.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190401141549.3F4721FE@viggo.jf.intel.com>
References: <20190401141549.3F4721FE@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mpx: Fix recursive munmap() corruption
Git-Commit-ID: 508b8482ea2227ba8695d1cf8311166a455c2ae0
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

Commit-ID:  508b8482ea2227ba8695d1cf8311166a455c2ae0
Gitweb:     https://git.kernel.org/tip/508b8482ea2227ba8695d1cf8311166a455c2ae0
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Mon, 1 Apr 2019 07:15:49 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Apr 2019 14:39:08 +0200

x86/mpx: Fix recursive munmap() corruption

This is a bit of a mess, to put it mildly.  But, it's a bug that seems to
have gone unticked up to now, probably because nobody uses MPX.  The other
alternative to this fix is to just deprecate MPX, even in -stable kernels.

MPX has the arch_unmap() hook inside of munmap() because MPX uses bounds
tables that protect other areas of memory.  When memory is unmapped, there
is also a need to unmap the MPX bounds tables.  Barring this, unused bounds
tables can eat 80% of the address space.

But, the recursive do_munmap() that gets called via arch_unmap() wreaks
havoc with __do_munmap()'s state.  It can result in freeing populated page
tables, accessing bogus VMA state, double-freed VMAs and more.

To fix this, call arch_unmap() before __do_unmap() has a chance to do
anything meaningful.  Also, remove the 'vma' argument and force the MPX
code to do its own, independent VMA lookup.

For the common success case this is functionally identical to what was
there before.  For the munmap() failure case, it's possible that some MPX
tables will be zapped for memory that continues to be in use.  But, this is
an extraordinarily unlikely scenario and the harm would be that MPX
provides no protection since the bounds table got reset (zeroed).

It's hard to imagine that anyone is doing this:

	ptr = mmap();
	// use ptr
	ret = munmap(ptr);
	if (ret)
		// oh, there was an error, I'll
		// keep using ptr.

Because if after doing munmap(), the applitcation is *done* with the
memory.  There's probably no good data in there _anyway_.

This passes the original reproducer from Richard Biener as well as the
existing mpx selftests/.

Further details:

munmap() has a couple of pieces:
1. Find the affected VMA(s)
2. Split the start/end one(s) if neceesary
3. Pull the VMAs out of the rbtree
4. Actually zap the memory via unmap_region(), including
   freeing page tables (or queueing them to be freed).
5. Fixup some of the accounting (like fput()) and actually
   free the VMA itself.

The original MPX implementation chose to put the arch_unmap() call right
afer #3.  This was *just* before mmap_sem looked like it might get
downgraded (it won't in this context), but it looked right.  It wasn't.

Richard Biener reported a test that shows this in dmesg:

[1216548.787498] BUG: Bad rss-counter state mm:0000000017ce560b idx:1 val:551
[1216548.787500] BUG: non-zero pgtables_bytes on freeing mm: 24576

What triggered this was the recursive do_munmap() called via arch_unmap().
It was freeing page tables that has not been properly zapped.

But, the problem was bigger than this.  For one, arch_unmap() can free
VMAs.  But, the calling __do_munmap() has variables that *point* to VMAs
and obviously can't handle them just getting freed while the pointer is
still valid.

A couple of attempts were made to fix this. First, was to fix the page
table freeing problem in isolation, but this lead to the VMA issue.  The
next approach was to let the MPX code return a flag if it modified the
rbtree which would force __do_munmap() to re-walk to restart.  That
spiralled out of control in complexity pretty fast.

Just moving arch_unmap() and accepting that the bonkers failure case might
eat some bounds tables is the simplest viable fix.

Fixes: 1de4fa14e ("x86, mpx: Cleanup unused bound tables")
Reported-by: Richard Biener <rguenther@suse.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190401141549.3F4721FE@viggo.jf.intel.com
---
 arch/x86/include/asm/mmu_context.h |  6 +++---
 arch/x86/include/asm/mpx.h         |  5 ++---
 arch/x86/mm/mpx.c                  | 10 ++++++----
 include/asm-generic/mm_hooks.h     |  1 -
 mm/mmap.c                          | 15 ++++++++-------
 5 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 19d18fae6ec6..41019af68adf 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -277,8 +277,8 @@ static inline void arch_bprm_mm_init(struct mm_struct *mm,
 	mpx_mm_init(mm);
 }
 
-static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
-			      unsigned long start, unsigned long end)
+static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
+			      unsigned long end)
 {
 	/*
 	 * mpx_notify_unmap() goes and reads a rarely-hot
@@ -298,7 +298,7 @@ static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * consistently wrong.
 	 */
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_MPX)))
-		mpx_notify_unmap(mm, vma, start, end);
+		mpx_notify_unmap(mm, start, end);
 }
 
 /*
diff --git a/arch/x86/include/asm/mpx.h b/arch/x86/include/asm/mpx.h
index d0b1434fb0b6..2f9d86bc7e48 100644
--- a/arch/x86/include/asm/mpx.h
+++ b/arch/x86/include/asm/mpx.h
@@ -78,8 +78,8 @@ static inline void mpx_mm_init(struct mm_struct *mm)
 	 */
 	mm->context.bd_addr = MPX_INVALID_BOUNDS_DIR;
 }
-void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
-		      unsigned long start, unsigned long end);
+void mpx_notify_unmap(struct mm_struct *mm, unsigned long start,
+		unsigned long end);
 
 unsigned long mpx_unmapped_area_check(unsigned long addr, unsigned long len,
 		unsigned long flags);
@@ -100,7 +100,6 @@ static inline void mpx_mm_init(struct mm_struct *mm)
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
index 41eb48d9b527..01944c378d38 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2730,9 +2730,17 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
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
@@ -2741,7 +2749,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	/* we have  start < vma->vm_end  */
 
 	/* if it doesn't overlap, we have nothing.. */
-	end = start + len;
 	if (vma->vm_start >= end)
 		return 0;
 
@@ -2811,12 +2818,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
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
 
