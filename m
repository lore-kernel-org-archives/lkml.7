Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDE0C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4BC20673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407989AbfIXCrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:47:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfIXCrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:47:37 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83191C057EC6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 02:47:36 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id i12so357418pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 19:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dawL3gZl0cgvJxFAFGhhMpWB4gBmiwF4cK4JY0OgXlE=;
        b=nt1lF8dK8d3CgTJr/KcnGa1oxPzigrxWpy4nhTfPN6Wiqu4R0XN0EmXkANNM8eLiQj
         E+JX1x/DIbjz09sJY7Z/3Hzyr9vHRyHTRMCslLksh+AgFE4UFpXhTVNXq1LbvlVIk7CA
         ZsRoIou9IvR+vLdV6Gn7d1VGbj9Zm0aJYa0VnrV+wGhR/T70umPN+en1WKal90J9iCe6
         Zs90E1OyvY6iFgN3+7SE3EPehZysLcA4vqmhRIRwPRTW03cviVwZ667dnFai1yg3Qus+
         BzJUdpfs7aecFTmDI4dBHU7KZDXwbFyIk9ZvWtXJD++qFuTULGxLJ0MYRYFWOPUvh21k
         4wZQ==
X-Gm-Message-State: APjAAAUlsshc/ye/z1O7dy1k5NiclESCNJ30TtnhJKPaAExQRlSqMdCi
        rS9BQEhEdOh2u6NYwHUafp1wkdquSpZ4bmvmvOk+GQSvEUkbTvNrvXsVFyrILupPKi9tkZ4ny8Z
        OqoxtPOdI7QJZqyX0VVK38we3
X-Received: by 2002:a63:fe42:: with SMTP id x2mr812192pgj.80.1569293255931;
        Mon, 23 Sep 2019 19:47:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwRgU3CqgohEY+lP4uYBj1BAhzYCOAvLILwrqMkiEeyJbe8dfAcEe20xsxkYH3ELyGIEPbog==
X-Received: by 2002:a63:fe42:: with SMTP id x2mr812152pgj.80.1569293255534;
        Mon, 23 Sep 2019 19:47:35 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 129sm151539pfd.173.2019.09.23.19.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 19:47:34 -0700 (PDT)
Date:   Tue, 24 Sep 2019 10:47:21 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Marty McFadden <mcfadden8@llnl.gov>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 05/10] mm: Return faster for non-fatal signals in user
 mode faults
Message-ID: <20190924024721.GD28074@xz-x1>
References: <20190923042523.10027-1-peterx@redhat.com>
 <20190923042523.10027-6-peterx@redhat.com>
 <CAHk-=wiNGtUaXtRv1wniw3hfxFnU7SO7ZuisFSVg0btvROcW6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNGtUaXtRv1wniw3hfxFnU7SO7ZuisFSVg0btvROcW6w@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Sep 23, 2019 at 11:03:49AM -0700, Linus Torvalds wrote:
> On Sun, Sep 22, 2019 at 9:26 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > This patch is a preparation of removing that special path by allowing
> > the page fault to return even faster if we were interrupted by a
> > non-fatal signal during a user-mode page fault handling routine.
> 
> So I really wish saome other vm person would also review these things,
> but looking over this series once more, this is the patch I probably
> like the least.
> 
> And the reason I like it the least is that I have a hard time
> explaining to myself what the code does and why, and why it's so full
> of this pattern:
> 
> > -       if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> > +       if ((fault & VM_FAULT_RETRY) &&
> > +           fault_should_check_signal(user_mode(regs)))
> >                 return;
> 
> which isn't all that pretty.
> 
> Why isn't this just
> 
>   static bool fault_signal_pending(unsigned int fault_flags, struct
> pt_regs *regs)
>   {
>         return (fault_flags & VM_FAULT_RETRY) &&
>                 (fatal_signal_pending(current) ||
>                  (user_mode(regs) && signal_pending(current)));
>   }
> 
> and then most of the users would be something like
> 
>         if (fault_signal_pending(fault, regs))
>                 return;
> 
> and the exceptions could do their own thing.
> 
> Now the code is prettier and more understandable, I feel.
> 
> And if something doesn't follow this pattern, maybe it either _should_
> follow that pattern or it should just not use the helper but explain
> why it has an unusual pattern.

I see the point on why this patch is disliked - Yeh it should look
better to have a single function to cover the most common cases.
Besides, I attempted to squash the extra signal_pending() check into
some existing code path but maybe it's not really benefiting much
while instead it makes the review even harder.  So I plan to isolate
those paths out too, from something like:

====================================
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -291,14 +291,15 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)

        fault = __do_page_fault(mm, addr, fsr, flags, tsk);

-       /* If we need to retry but a fatal signal is pending, handle the
+       /* If we need to retry but a signal is pending, try to handle the
         * signal first. We do not need to release the mmap_sem because
         * it would already be released in __lock_page_or_retry in
         * mm/filemap.c. */
-       if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
-               if (!user_mode(regs))
+       if (unlikely(fault & VM_FAULT_RETRY && signal_pending(current))) {
+               if (fatal_signal_pending(current) && !user_mode(regs))
                        goto no_context;
-               return 0;
+               if (user_mode(regs))
+                       return 0;
        }
====================================

into:

====================================
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -301,6 +301,11 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		return 0;
 	}
 
+	/* Fast path to handle user mode signals */
+	if ((fault & VM_FAULT_RETRY) && user_mode(regs) &&
+	    signal_pending(current))
+		return 0;
+
 	/*
 	 * Major/minor page fault accounting is only done on the
 	 * initial attempt. If we go through a retry, it is extremely
====================================

I hope it'll be better with that.  A complete patch attached too.

Thanks,

-- 
Peter Xu

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="0001-mm-Return-faster-for-non-fatal-signals-in-user-mode-.patch"

From 2583226afc24bb51b78cf36484f0c5b064b1f75d Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 1 Nov 2018 09:55:29 +0800
Subject: [PATCH] mm: Return faster for non-fatal signals in user mode faults

The idea comes from the upstream discussion between Linus and Andrea:

  https://lore.kernel.org/lkml/20171102193644.GB22686@redhat.com/

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
 arch/alpha/mm/fault.c        |  2 +-
 arch/arc/mm/fault.c          |  5 +++++
 arch/arm/mm/fault.c          |  5 +++++
 arch/arm64/mm/fault.c        |  4 ++++
 arch/hexagon/mm/vm_fault.c   |  2 +-
 arch/ia64/mm/fault.c         |  2 +-
 arch/m68k/mm/fault.c         |  2 +-
 arch/microblaze/mm/fault.c   |  2 +-
 arch/mips/mm/fault.c         |  2 +-
 arch/nds32/mm/fault.c        |  5 +++++
 arch/nios2/mm/fault.c        |  2 +-
 arch/openrisc/mm/fault.c     |  2 +-
 arch/parisc/mm/fault.c       |  2 +-
 arch/powerpc/mm/fault.c      |  2 ++
 arch/riscv/mm/fault.c        |  4 ++--
 arch/s390/mm/fault.c         |  3 +--
 arch/sh/mm/fault.c           |  4 ++++
 arch/sparc/mm/fault_32.c     |  2 +-
 arch/sparc/mm/fault_64.c     |  2 +-
 arch/um/kernel/trap.c        |  4 +++-
 arch/unicore32/mm/fault.c    |  4 ++--
 arch/x86/mm/fault.c          |  2 ++
 arch/xtensa/mm/fault.c       |  2 +-
 include/linux/sched/signal.h | 14 ++++++++++++++
 24 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index de4cc6936391..fcfa229cc1e7 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -150,7 +150,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	   the fault.  */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 61919e4e4eec..27adf4e608e4 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -142,6 +142,11 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 				goto no_context;
 			return;
 		}
+
+		/* Allow user to handle non-fatal signals first */
+		if (signal_pending(current) && user_mode(regs))
+			return;
+
 		/*
 		 * retry state machine
 		 */
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2ae28ffec622..44fa64dbb8e0 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -301,6 +301,11 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		return 0;
 	}
 
+	/* Fast path to handle user mode signals */
+	if ((fault & VM_FAULT_RETRY) && user_mode(regs) &&
+	    signal_pending(current))
+		return 0;
+
 	/*
 	 * Major/minor page fault accounting is only done on the
 	 * initial attempt. If we go through a retry, it is extremely
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 613e7434c208..8ff04af1d982 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -490,6 +490,10 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 			return 0;
 		}
 
+		/* Fast path for user mode signals */
+		if (user_mode(regs) && signal_pending(current))
+			return 0;
+
 		/*
 		 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk of
 		 * starvation.
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index 223787e01bdd..d9e15d941bdb 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -91,7 +91,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	/* The most common case -- we are done. */
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index d039b846f671..b5aa4e80c762 100644
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
index 8e734309ace9..182799fd9987 100644
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
index 45c9f66c1dbc..32da02778a63 100644
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
index 6660b77ff8f3..f811ef5efb80 100644
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
index a40de112a23a..c4c53de68ec3 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -216,6 +216,11 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 		return;
 	}
 
+	/* Fast path for user mode signals */
+	if ((fault & VM_FAULT_RETRY) && signal_pending(current) &&
+	    user_mode(regs))
+		return;
+
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index a401b45cae47..c38bea4220fb 100644
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
index fd1592a56238..30d5c51e9d40 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -161,7 +161,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 355e3e13fa72..8e88e5c5f26a 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -304,7 +304,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 408ee769c470..d321a6c5fe62 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -596,6 +596,8 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 			 */
 			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
+			if (is_user && signal_pending(current))
+				return 0;
 			if (!fatal_signal_pending(current))
 				goto retry;
 		}
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index deeb820bd855..ba652a2a6ad9 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -111,11 +111,11 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	fault = handle_mm_fault(vma, addr, flags);
 
 	/*
-	 * If we need to retry but a fatal signal is pending, handle the
+	 * If we need to retry but a signal is pending, try to handle the
 	 * signal first. We do not need to release the mmap_sem because it
 	 * would already be released in __lock_page_or_retry in mm/filemap.c.
 	 */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(tsk))
+	if (fault_signal_pending(fault, regs))
 		return;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 74a77b2bca75..551ac311bd35 100644
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
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index becf0be267bb..f620282a37fd 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -489,6 +489,10 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
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
index 0863f6fdd2c5..447f61c4e996 100644
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
index a1cba3eef79e..6807fba66331 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -421,7 +421,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 
 	fault = handle_mm_fault(vma, address, flags);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		goto exit_exception;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index bc2756782d64..32a6830c1d45 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -76,7 +76,9 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 
 		fault = handle_mm_fault(vma, address, flags);
 
-		if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+                if ((fault & VM_FAULT_RETRY) &&
+		    (fatal_signal_pending(current) ||
+		     (is_user && signal_pending(current))))
 			goto out_nosemaphore;
 
 		if (unlikely(fault & VM_FAULT_ERROR)) {
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 60453c892c51..f24a1967c323 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -246,11 +246,11 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	fault = __do_pf(mm, addr, fsr, flags, tsk);
 
-	/* If we need to retry but a fatal signal is pending, handle the
+	/* If we need to retry but a signal is pending, try to handle the
 	 * signal first. We do not need to release the mmap_sem because
 	 * it would already be released in __lock_page_or_retry in
 	 * mm/filemap.c. */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if (fault_signal_pending(fault, regs))
 		return 0;
 
 	if (!(fault & VM_FAULT_ERROR) && (flags & FAULT_FLAG_ALLOW_RETRY)) {
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 994c860ac2d8..f7836472961e 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1451,6 +1451,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
 			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
+			if ((flags & FAULT_FLAG_USER) && signal_pending(tsk))
+				return;
 			if (!fatal_signal_pending(tsk))
 				goto retry;
 		}
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index d2b082908538..6467e3fb9762 100644
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
index efd8ce7675ed..3f517a30ec4d 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -377,6 +377,20 @@ static inline int signal_pending_state(long state, struct task_struct *p)
 	return (state & TASK_INTERRUPTIBLE) || __fatal_signal_pending(p);
 }
 
+/*
+ * This should only be used in fault handlers to decide whether we
+ * should stop the current fault routine to handle the signals
+ * instead.  It should normally be used when a signal interrupted a
+ * page fault which can lead to a VM_FAULT_RETRY.
+ */
+static inline bool fault_signal_pending(unsigned int fault_flags,
+					struct pt_regs *regs)
+{
+	return (fault_flags & VM_FAULT_RETRY) &&
+	    (fatal_signal_pending(current) ||
+	     (user_mode(regs) && signal_pending(current)));
+}
+
 /*
  * Reevaluate whether the task has signals pending delivery.
  * Wake the task if so.
-- 
2.21.0


--C7zPtVaVf+AK4Oqc--
