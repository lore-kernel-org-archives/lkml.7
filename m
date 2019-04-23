Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4093BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AAD21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wXiE1ZX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfDWMRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:17:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48118 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWMRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gCtwOyCFlFxh1jZN+a6ZC94e/pamz8rbwt0XZuIQgBI=; b=wXiE1ZX+BP4xgSjddpqsNtjZn
        upAtLIf7gBfch2PSR/IIA4oAefvfRDMkzIX0nyD6p1DqR06X+2LRqFvivlXi14G+DUfL/QrjA5KD0
        t8bhA5lmxT4Xzfg8rrowZkssBTCxfYHOgl85FFr/D0xWn3+C+slqeixbUVjDF8cMEOmeInglCbtbf
        tsocblBDPy/RopgocGGCkGwYVw4DMwF1Mb7zfrBcAqpKaqewNsgy6mmfMsYnGw2fWTI9YSJvWWXsc
        B4BNG2VLwXdXzEbbw+vZI+Ce74JG4UtRZiJemNkPjMFMufc2RJ8LBOmX6qMLgE+mfG8MfDiHzTsQy
        9I2UyfQ1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIuMP-0003rQ-2m; Tue, 23 Apr 2019 12:17:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8429829B8F6FE; Tue, 23 Apr 2019 14:17:15 +0200 (CEST)
Date:   Tue, 23 Apr 2019 14:17:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()
Message-ID: <20190423121715.GQ4038@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
 <20190419180017.GP4038@hirez.programming.kicks-ass.net>
 <20190419182620.GF14111@linux.ibm.com>
 <1555719429.t9n8gkf70y.astroid@bobo.none>
 <20190420085440.GK14111@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420085440.GK14111@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 01:54:40AM -0700, Paul E. McKenney wrote:
> 3.	Make non-value-returning atomics provide full ordering.
> 	This would of course need some benchmarking, but would be a
> 	simple change to make and would eliminate a large class of
> 	potential bugs.  My guess is that the loss in performance
> 	would be non-negligible, but who knows?

Well, only for the architectures that have
smp_mb__{before,after}_atomic() as barrier(), which are: ia64, mips,
s390, sparc, x86 and xtense.

$ ./compare.sh defconfig-build defconfig-build1 vmlinux
do_profile_hits                                           275        278   +3,+0
freezer_apply_state                                        86         98   +12,+0
perf_event_alloc                                         2232       2261   +29,+0
_free_event                                               631        660   +29,+0
shmem_add_to_page_cache                                   712        722   +10,+0
_enable_swap_info                                         333        337   +4,+0
do_mmu_notifier_register                                  303        311   +8,+0
__nfs_commit_inode                                        356        359   +3,+0
tcp_try_coalesce                                          246        250   +4,+0
i915_gem_free_object                                       90         97   +7,+0
mce_intel_hcpu_update                                      39         47   +8,+0
__ia32_sys_swapoff                                       1177       1181   +4,+0
pci_enable_ats                                            124        131   +7,+0
__x64_sys_swapoff                                        1178       1182   +4,+0
i915_gem_madvise_ioctl                                    447        443   -4,+0
calc_global_load_tick                                      75         82   +7,+0
i915_gem_object_set_tiling                                712        708   -4,+0
					     total   11374236   11374367   +131,+0
Which doesn't look too bad.

---
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index ea3d95275b43..115127c7ad28 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -54,7 +54,7 @@ static __always_inline void arch_atomic_add(int i, atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "addl %1,%0"
 		     : "+m" (v->counter)
-		     : "ir" (i));
+		     : "ir" (i) : "memory");
 }
 
 /**
@@ -68,7 +68,7 @@ static __always_inline void arch_atomic_sub(int i, atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "subl %1,%0"
 		     : "+m" (v->counter)
-		     : "ir" (i));
+		     : "ir" (i) : "memory");
 }
 
 /**
@@ -95,7 +95,7 @@ static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
 static __always_inline void arch_atomic_inc(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "incl %0"
-		     : "+m" (v->counter));
+		     : "+m" (v->counter) :: "memory");
 }
 #define arch_atomic_inc arch_atomic_inc
 
@@ -108,7 +108,7 @@ static __always_inline void arch_atomic_inc(atomic_t *v)
 static __always_inline void arch_atomic_dec(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "decl %0"
-		     : "+m" (v->counter));
+		     : "+m" (v->counter) :: "memory");
 }
 #define arch_atomic_dec arch_atomic_dec
 
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index dadc20adba21..5e86c0d68ac1 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -45,7 +45,7 @@ static __always_inline void arch_atomic64_add(long i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "addq %1,%0"
 		     : "=m" (v->counter)
-		     : "er" (i), "m" (v->counter));
+		     : "er" (i), "m" (v->counter) : "memory");
 }
 
 /**
@@ -59,7 +59,7 @@ static inline void arch_atomic64_sub(long i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "subq %1,%0"
 		     : "=m" (v->counter)
-		     : "er" (i), "m" (v->counter));
+		     : "er" (i), "m" (v->counter) : "memory");
 }
 
 /**
@@ -87,7 +87,7 @@ static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "incq %0"
 		     : "=m" (v->counter)
-		     : "m" (v->counter));
+		     : "m" (v->counter) : "memory");
 }
 #define arch_atomic64_inc arch_atomic64_inc
 
@@ -101,7 +101,7 @@ static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "decq %0"
 		     : "=m" (v->counter)
-		     : "m" (v->counter));
+		     : "m" (v->counter) : "memory");
 }
 #define arch_atomic64_dec arch_atomic64_dec
 
