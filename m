Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E402C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB93727DC4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rFRBDyN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfFCNft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:35:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50733 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfFCNft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:35:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DZVeC610880
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:35:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DZVeC610880
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568932;
        bh=lHqjRRv0Wnw+s9KszV1IOBLCGvBzI5CQL0Iu/2JWEyA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rFRBDyN8TFLv8gqDXwyf10O3rN41wHPLLlfu8Gh53bQwsiR+t2zF6zvVMmkbmRlB0
         yacHpztyOcxJZklxLgdOwaSINvMSaUxWQAXRBIGxhh75f28D0+kcs3BwvQiz3kM1GB
         B0UlK9UG5KPUfnTArzTTGgllN153zWS8qLOu4fbkBOSnPm/PKuFp92PzjTrORpFcbo
         bhSvTwal1IuiCyed7SM/8+vEd1Vn9m8aFD+i9Ja4nGvs4qzvnUsBXkVkedqRulVwoI
         PimWjH6dpHkXeyfapz/VgvY88rXUqQIo35x/dcwHBAxs9h/bLXSmL2Dwqv86q0qu7u
         565W6rN9i+qhQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DZVQE610877;
        Mon, 3 Jun 2019 06:35:31 -0700
Date:   Mon, 3 Jun 2019 06:35:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-9255813d5841e158f033e0d83d455bffdae009a4@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, will.deacon@arm.com,
        tglx@linutronix.de, mark.rutland@arm.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, mingo@kernel.org,
          will.deacon@arm.com, mark.rutland@arm.com, tglx@linutronix.de,
          arnd@arndb.de, hpa@zytor.com
In-Reply-To: <20190522132250.26499-4-mark.rutland@arm.com>
References: <20190522132250.26499-4-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic: Use s64 for atomic64
Git-Commit-ID: 9255813d5841e158f033e0d83d455bffdae009a4
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

Commit-ID:  9255813d5841e158f033e0d83d455bffdae009a4
Gitweb:     https://git.kernel.org/tip/9255813d5841e158f033e0d83d455bffdae009a4
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:35 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic: Use s64 for atomic64

As a step towards making the atomic64 API use consistent types treewide,
let's have the generic atomic64 implementation use s64 as the underlying
type for atomic64_t, rather than long long, matching the generated
headers.

Otherwise, there should be no functional change as a result of this
patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aou@eecs.berkeley.edu
Cc: bp@alien8.de
Cc: catalin.marinas@arm.com
Cc: davem@davemloft.net
Cc: fenghua.yu@intel.com
Cc: heiko.carstens@de.ibm.com
Cc: herbert@gondor.apana.org.au
Cc: ink@jurassic.park.msu.ru
Cc: jhogan@kernel.org
Cc: linux@armlinux.org.uk
Cc: mattst88@gmail.com
Cc: mpe@ellerman.id.au
Cc: palmer@sifive.com
Cc: paul.burton@mips.com
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: tony.luck@intel.com
Cc: vgupta@synopsys.com
Link: https://lkml.kernel.org/r/20190522132250.26499-4-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/atomic64.h | 20 ++++++++++----------
 lib/atomic64.c                 | 32 ++++++++++++++++----------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index d7a15096fb3b..370f01d4450f 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -10,24 +10,24 @@
 #include <linux/types.h>
 
 typedef struct {
-	long long counter;
+	s64 counter;
 } atomic64_t;
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-extern long long atomic64_read(const atomic64_t *v);
-extern void	 atomic64_set(atomic64_t *v, long long i);
+extern s64 atomic64_read(const atomic64_t *v);
+extern void atomic64_set(atomic64_t *v, s64 i);
 
 #define atomic64_set_release(v, i)	atomic64_set((v), (i))
 
 #define ATOMIC64_OP(op)							\
-extern void	 atomic64_##op(long long a, atomic64_t *v);
+extern void	 atomic64_##op(s64 a, atomic64_t *v);
 
 #define ATOMIC64_OP_RETURN(op)						\
-extern long long atomic64_##op##_return(long long a, atomic64_t *v);
+extern s64 atomic64_##op##_return(s64 a, atomic64_t *v);
 
 #define ATOMIC64_FETCH_OP(op)						\
-extern long long atomic64_fetch_##op(long long a, atomic64_t *v);
+extern s64 atomic64_fetch_##op(s64 a, atomic64_t *v);
 
 #define ATOMIC64_OPS(op)	ATOMIC64_OP(op) ATOMIC64_OP_RETURN(op) ATOMIC64_FETCH_OP(op)
 
@@ -46,11 +46,11 @@ ATOMIC64_OPS(xor)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-extern long long atomic64_dec_if_positive(atomic64_t *v);
+extern s64 atomic64_dec_if_positive(atomic64_t *v);
 #define atomic64_dec_if_positive atomic64_dec_if_positive
-extern long long atomic64_cmpxchg(atomic64_t *v, long long o, long long n);
-extern long long atomic64_xchg(atomic64_t *v, long long new);
-extern long long atomic64_fetch_add_unless(atomic64_t *v, long long a, long long u);
+extern s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
+extern s64 atomic64_xchg(atomic64_t *v, s64 new);
+extern s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
 #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
diff --git a/lib/atomic64.c b/lib/atomic64.c
index 7e6905751522..e98c85a99787 100644
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -42,11 +42,11 @@ static inline raw_spinlock_t *lock_addr(const atomic64_t *v)
 	return &atomic64_lock[addr & (NR_LOCKS - 1)].lock;
 }
 
-long long atomic64_read(const atomic64_t *v)
+s64 atomic64_read(const atomic64_t *v)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
-	long long val;
+	s64 val;
 
 	raw_spin_lock_irqsave(lock, flags);
 	val = v->counter;
@@ -55,7 +55,7 @@ long long atomic64_read(const atomic64_t *v)
 }
 EXPORT_SYMBOL(atomic64_read);
 
-void atomic64_set(atomic64_t *v, long long i)
+void atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -67,7 +67,7 @@ void atomic64_set(atomic64_t *v, long long i)
 EXPORT_SYMBOL(atomic64_set);
 
 #define ATOMIC64_OP(op, c_op)						\
-void atomic64_##op(long long a, atomic64_t *v)				\
+void atomic64_##op(s64 a, atomic64_t *v)				\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -79,11 +79,11 @@ void atomic64_##op(long long a, atomic64_t *v)				\
 EXPORT_SYMBOL(atomic64_##op);
 
 #define ATOMIC64_OP_RETURN(op, c_op)					\
-long long atomic64_##op##_return(long long a, atomic64_t *v)		\
+s64 atomic64_##op##_return(s64 a, atomic64_t *v)			\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
-	long long val;							\
+	s64 val;							\
 									\
 	raw_spin_lock_irqsave(lock, flags);				\
 	val = (v->counter c_op a);					\
@@ -93,11 +93,11 @@ long long atomic64_##op##_return(long long a, atomic64_t *v)		\
 EXPORT_SYMBOL(atomic64_##op##_return);
 
 #define ATOMIC64_FETCH_OP(op, c_op)					\
-long long atomic64_fetch_##op(long long a, atomic64_t *v)		\
+s64 atomic64_fetch_##op(s64 a, atomic64_t *v)				\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
-	long long val;							\
+	s64 val;							\
 									\
 	raw_spin_lock_irqsave(lock, flags);				\
 	val = v->counter;						\
@@ -130,11 +130,11 @@ ATOMIC64_OPS(xor, ^=)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-long long atomic64_dec_if_positive(atomic64_t *v)
+s64 atomic64_dec_if_positive(atomic64_t *v)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
-	long long val;
+	s64 val;
 
 	raw_spin_lock_irqsave(lock, flags);
 	val = v->counter - 1;
@@ -145,11 +145,11 @@ long long atomic64_dec_if_positive(atomic64_t *v)
 }
 EXPORT_SYMBOL(atomic64_dec_if_positive);
 
-long long atomic64_cmpxchg(atomic64_t *v, long long o, long long n)
+s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
-	long long val;
+	s64 val;
 
 	raw_spin_lock_irqsave(lock, flags);
 	val = v->counter;
@@ -160,11 +160,11 @@ long long atomic64_cmpxchg(atomic64_t *v, long long o, long long n)
 }
 EXPORT_SYMBOL(atomic64_cmpxchg);
 
-long long atomic64_xchg(atomic64_t *v, long long new)
+s64 atomic64_xchg(atomic64_t *v, s64 new)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
-	long long val;
+	s64 val;
 
 	raw_spin_lock_irqsave(lock, flags);
 	val = v->counter;
@@ -174,11 +174,11 @@ long long atomic64_xchg(atomic64_t *v, long long new)
 }
 EXPORT_SYMBOL(atomic64_xchg);
 
-long long atomic64_fetch_add_unless(atomic64_t *v, long long a, long long u)
+s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
-	long long val;
+	s64 val;
 
 	raw_spin_lock_irqsave(lock, flags);
 	val = v->counter;
