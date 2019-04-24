Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565F2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0792089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfDXNmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:42:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43730 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfDXNmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:42:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3E0580D;
        Wed, 24 Apr 2019 06:42:02 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4E3E3F238;
        Wed, 24 Apr 2019 06:42:00 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:41:58 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [RFC][PATCH 5/5] x86/atomic: Fix smp_mb__{before,after}_atomic()
Message-ID: <20190424134158.GC14829@fuggles.cambridge.arm.com>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.808471451@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424124421.808471451@infradead.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 02:37:01PM +0200, Peter Zijlstra wrote:
> Recent probing at the Linux Kernel Memory Model uncovered a
> 'surprise'. Strongly ordered architectures where the atomic RmW
> primitive implies full memory ordering and
> smp_mb__{before,after}_atomic() are a simple barrier() (such as x86)
> fail for:
> 
> 	*x = 1;
> 	atomic_inc(u);
> 	smp_mb__after_atomic();
> 	r0 = *y;
> 
> Because, while the atomic_inc() implies memory order, it
> (surprisingly) does not provide a compiler barrier. This then allows
> the compiler to re-order like so:
> 
> 	atomic_inc(u);
> 	*x = 1;
> 	smp_mb__after_atomic();
> 	r0 = *y;
> 
> Which the CPU is then allowed to re-order (under TSO rules) like:
> 
> 	atomic_inc(u);
> 	r0 = *y;
> 	*x = 1;
> 
> And this very much was not intended. Therefore strengthen the atomic
> RmW ops to include a compiler barrier.
> 
> NOTE: atomic_{or,and,xor} and the bitops already had the compiler
> barrier.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Documentation/atomic_t.txt         |    3 +++
>  arch/x86/include/asm/atomic.h      |    8 ++++----
>  arch/x86/include/asm/atomic64_64.h |    8 ++++----
>  arch/x86/include/asm/barrier.h     |    4 ++--
>  4 files changed, 13 insertions(+), 10 deletions(-)
> 
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -194,6 +194,9 @@ These helper barriers exist because arch
>  ordering on their SMP atomic primitives. For example our TSO architectures
>  provide full ordered atomics and these barriers are no-ops.
>  
> +NOTE: when the atomic RmW ops are fully ordered, they should also imply a
> +compiler barrier.

This is also the case for acquire and release variants, so we should
probably include those as well to avoid the implication that they don't
need the "memory" clobber.

> +
>  Thus:
>  
>    atomic_fetch_add();
> --- a/arch/x86/include/asm/atomic.h
> +++ b/arch/x86/include/asm/atomic.h
> @@ -54,7 +54,7 @@ static __always_inline void arch_atomic_
>  {
>  	asm volatile(LOCK_PREFIX "addl %1,%0"
>  		     : "+m" (v->counter)
> -		     : "ir" (i));
> +		     : "ir" (i) : "memory");
>  }
>  
>  /**
> @@ -68,7 +68,7 @@ static __always_inline void arch_atomic_
>  {
>  	asm volatile(LOCK_PREFIX "subl %1,%0"
>  		     : "+m" (v->counter)
> -		     : "ir" (i));
> +		     : "ir" (i) : "memory");
>  }
>  
>  /**
> @@ -95,7 +95,7 @@ static __always_inline bool arch_atomic_
>  static __always_inline void arch_atomic_inc(atomic_t *v)
>  {
>  	asm volatile(LOCK_PREFIX "incl %0"
> -		     : "+m" (v->counter));
> +		     : "+m" (v->counter) :: "memory");
>  }
>  #define arch_atomic_inc arch_atomic_inc
>  
> @@ -108,7 +108,7 @@ static __always_inline void arch_atomic_
>  static __always_inline void arch_atomic_dec(atomic_t *v)
>  {
>  	asm volatile(LOCK_PREFIX "decl %0"
> -		     : "+m" (v->counter));
> +		     : "+m" (v->counter) :: "memory");
>  }
>  #define arch_atomic_dec arch_atomic_dec
>  
> --- a/arch/x86/include/asm/atomic64_64.h
> +++ b/arch/x86/include/asm/atomic64_64.h
> @@ -45,7 +45,7 @@ static __always_inline void arch_atomic6
>  {
>  	asm volatile(LOCK_PREFIX "addq %1,%0"
>  		     : "=m" (v->counter)
> -		     : "er" (i), "m" (v->counter));
> +		     : "er" (i), "m" (v->counter) : "memory");
>  }
>  
>  /**
> @@ -59,7 +59,7 @@ static inline void arch_atomic64_sub(lon
>  {
>  	asm volatile(LOCK_PREFIX "subq %1,%0"
>  		     : "=m" (v->counter)
> -		     : "er" (i), "m" (v->counter));
> +		     : "er" (i), "m" (v->counter) : "memory");
>  }
>  
>  /**
> @@ -87,7 +87,7 @@ static __always_inline void arch_atomic6
>  {
>  	asm volatile(LOCK_PREFIX "incq %0"
>  		     : "=m" (v->counter)
> -		     : "m" (v->counter));
> +		     : "m" (v->counter) : "memory");
>  }
>  #define arch_atomic64_inc arch_atomic64_inc
>  
> @@ -101,7 +101,7 @@ static __always_inline void arch_atomic6
>  {
>  	asm volatile(LOCK_PREFIX "decq %0"
>  		     : "=m" (v->counter)
> -		     : "m" (v->counter));
> +		     : "m" (v->counter) : "memory");
>  }
>  #define arch_atomic64_dec arch_atomic64_dec
>  
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -80,8 +80,8 @@ do {									\
>  })
>  
>  /* Atomic operations are already serializing on x86 */
> -#define __smp_mb__before_atomic()	barrier()
> -#define __smp_mb__after_atomic()	barrier()
> +#define __smp_mb__before_atomic()	do { } while (0)
> +#define __smp_mb__after_atomic()	do { } while (0)

I do wonder whether or not it would be cleaner to have a Kconfig option
such as ARCH_HAS_ORDERED_ATOMIC_RMW which, when selected, NOPs these
barrier macros out in the generic code. Then it's a requirement that
you have the "memory" clobber on your relaxed/non-returning atomics if
you select the option.

But that needn't hold this up, because your patch looks good to me modulo
the earlier, minor documentation nit.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
