Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECD1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4360218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aqiiWWkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbfDXMsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:48:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34548 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbfDXMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zn8s0XP36Iuv1htrYvx9v0M1ghruE1ikAPBYuxUQJjc=; b=aqiiWWktVPbWKY0DEukLgncjkJ
        zCJfwrxU4KSDYdXC1wUINlkUrBb7x/RxrO+BTL0eBJXRzEECcA7L1baJ+JcHe+Rjrvqtfr0mUFKVu
        Q6qfFJwlVE6fr5LxPJEDG///tmzjauL4IizW6k+uNRmSLXf1GfLkd0kJwwtthPF6+bCb4uDElYxlL
        ABe9aI738iE3V7OCaDj36TmHHsFNXcYLjjIbL6N2n3qLOCnOKzVTZfjNzLN9xof+jYsGU+37BTmlg
        rObQTNZwpeDBPnrn209219em3771uoxYwMM1yGMAe84GaISKervjDNAUPvWEt6HM1giiJ/XfM2SAX
        suhvTGhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJHJT-0003HN-3H; Wed, 24 Apr 2019 12:47:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 75CAC203E8863; Wed, 24 Apr 2019 14:47:43 +0200 (CEST)
Message-Id: <20190424124421.808471451@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 24 Apr 2019 14:37:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        peterz@infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: [RFC][PATCH 5/5] x86/atomic: Fix smp_mb__{before,after}_atomic()
References: <20190424123656.484227701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent probing at the Linux Kernel Memory Model uncovered a
'surprise'. Strongly ordered architectures where the atomic RmW
primitive implies full memory ordering and
smp_mb__{before,after}_atomic() are a simple barrier() (such as x86)
fail for:

	*x = 1;
	atomic_inc(u);
	smp_mb__after_atomic();
	r0 = *y;

Because, while the atomic_inc() implies memory order, it
(surprisingly) does not provide a compiler barrier. This then allows
the compiler to re-order like so:

	atomic_inc(u);
	*x = 1;
	smp_mb__after_atomic();
	r0 = *y;

Which the CPU is then allowed to re-order (under TSO rules) like:

	atomic_inc(u);
	r0 = *y;
	*x = 1;

And this very much was not intended. Therefore strengthen the atomic
RmW ops to include a compiler barrier.

NOTE: atomic_{or,and,xor} and the bitops already had the compiler
barrier.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/atomic_t.txt         |    3 +++
 arch/x86/include/asm/atomic.h      |    8 ++++----
 arch/x86/include/asm/atomic64_64.h |    8 ++++----
 arch/x86/include/asm/barrier.h     |    4 ++--
 4 files changed, 13 insertions(+), 10 deletions(-)

--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -194,6 +194,9 @@ These helper barriers exist because arch
 ordering on their SMP atomic primitives. For example our TSO architectures
 provide full ordered atomics and these barriers are no-ops.
 
+NOTE: when the atomic RmW ops are fully ordered, they should also imply a
+compiler barrier.
+
 Thus:
 
   atomic_fetch_add();
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -54,7 +54,7 @@ static __always_inline void arch_atomic_
 {
 	asm volatile(LOCK_PREFIX "addl %1,%0"
 		     : "+m" (v->counter)
-		     : "ir" (i));
+		     : "ir" (i) : "memory");
 }
 
 /**
@@ -68,7 +68,7 @@ static __always_inline void arch_atomic_
 {
 	asm volatile(LOCK_PREFIX "subl %1,%0"
 		     : "+m" (v->counter)
-		     : "ir" (i));
+		     : "ir" (i) : "memory");
 }
 
 /**
@@ -95,7 +95,7 @@ static __always_inline bool arch_atomic_
 static __always_inline void arch_atomic_inc(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "incl %0"
-		     : "+m" (v->counter));
+		     : "+m" (v->counter) :: "memory");
 }
 #define arch_atomic_inc arch_atomic_inc
 
@@ -108,7 +108,7 @@ static __always_inline void arch_atomic_
 static __always_inline void arch_atomic_dec(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "decl %0"
-		     : "+m" (v->counter));
+		     : "+m" (v->counter) :: "memory");
 }
 #define arch_atomic_dec arch_atomic_dec
 
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -45,7 +45,7 @@ static __always_inline void arch_atomic6
 {
 	asm volatile(LOCK_PREFIX "addq %1,%0"
 		     : "=m" (v->counter)
-		     : "er" (i), "m" (v->counter));
+		     : "er" (i), "m" (v->counter) : "memory");
 }
 
 /**
@@ -59,7 +59,7 @@ static inline void arch_atomic64_sub(lon
 {
 	asm volatile(LOCK_PREFIX "subq %1,%0"
 		     : "=m" (v->counter)
-		     : "er" (i), "m" (v->counter));
+		     : "er" (i), "m" (v->counter) : "memory");
 }
 
 /**
@@ -87,7 +87,7 @@ static __always_inline void arch_atomic6
 {
 	asm volatile(LOCK_PREFIX "incq %0"
 		     : "=m" (v->counter)
-		     : "m" (v->counter));
+		     : "m" (v->counter) : "memory");
 }
 #define arch_atomic64_inc arch_atomic64_inc
 
@@ -101,7 +101,7 @@ static __always_inline void arch_atomic6
 {
 	asm volatile(LOCK_PREFIX "decq %0"
 		     : "=m" (v->counter)
-		     : "m" (v->counter));
+		     : "m" (v->counter) : "memory");
 }
 #define arch_atomic64_dec arch_atomic64_dec
 
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -80,8 +80,8 @@ do {									\
 })
 
 /* Atomic operations are already serializing on x86 */
-#define __smp_mb__before_atomic()	barrier()
-#define __smp_mb__after_atomic()	barrier()
+#define __smp_mb__before_atomic()	do { } while (0)
+#define __smp_mb__after_atomic()	do { } while (0)
 
 #include <asm-generic/barrier.h>
 


