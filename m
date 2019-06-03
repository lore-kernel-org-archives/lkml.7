Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A259CC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D91627DC4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WkAHh/SA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfFCNhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:37:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33487 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfFCNhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:37:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DatYu611218
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:36:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DatYu611218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569016;
        bh=Ow0nLH85zbe48djOl9pgog+NLxZAOuEj5tFHoEAJb3U=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WkAHh/SAoC3f5rbQ3W1LUiV9IbGLex8HI7irAKNpBJuonzJzxgf5mXZnQqW3uBpU3
         zeMFL69m83bJtBNkM1/zHJCw7BCuQIDc6e7MAfR0vilgtLGC5D8DuSgTGhUTE646nZ
         W6x0M6cXTMxdBYCdAdTfPO4MWqD8o6PRZoWOC/6g78kvJ7SmqWScgWnd2yYnAJP6kC
         rrY8J4/TtRD50JpGBSbUP305DMxn/XS46YM3Iph0Udi+DQG9bVI79C07IQVWrlGxrT
         RozGQDUpfbDEOWymCo+hw/3Ry29+dCz0kO4tJsOfawMZTJMll48RQgP+W6W6x8PP/6
         jlm8Sc/JvwTCg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DatD5611215;
        Mon, 3 Jun 2019 06:36:55 -0700
Date:   Mon, 3 Jun 2019 06:36:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-16fbad086976574b99ea7019c0504d0194e95dc3@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, mark.rutland@arm.com,
        torvalds@linux-foundation.org, vgupta@synopsys.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: vgupta@synopsys.com, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          mark.rutland@arm.com, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190522132250.26499-6-mark.rutland@arm.com>
References: <20190522132250.26499-6-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, arc: Use s64 for atomic64
Git-Commit-ID: 16fbad086976574b99ea7019c0504d0194e95dc3
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

Commit-ID:  16fbad086976574b99ea7019c0504d0194e95dc3
Gitweb:     https://git.kernel.org/tip/16fbad086976574b99ea7019c0504d0194e95dc3
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:37 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, arc: Use s64 for atomic64

As a step towards making the atomic64 API use consistent types treewide,
let's have the arc atomic64 implementation use s64 as the underlying
type for atomic64_t, rather than u64, matching the generated headers.

Otherwise, there should be no functional change as a result of this
patch.

Acked-By: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aou@eecs.berkeley.edu
Cc: arnd@arndb.de
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
Link: https://lkml.kernel.org/r/20190522132250.26499-6-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arc/include/asm/atomic.h | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 158af079838d..2c75df55d0d2 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -324,14 +324,14 @@ ATOMIC_OPS(xor, ^=, CTOP_INST_AXOR_DI_R2_R2_R3)
  */
 
 typedef struct {
-	aligned_u64 counter;
+	s64 __aligned(8) counter;
 } atomic64_t;
 
 #define ATOMIC64_INIT(a) { (a) }
 
-static inline long long atomic64_read(const atomic64_t *v)
+static inline s64 atomic64_read(const atomic64_t *v)
 {
-	unsigned long long val;
+	s64 val;
 
 	__asm__ __volatile__(
 	"	ldd   %0, [%1]	\n"
@@ -341,7 +341,7 @@ static inline long long atomic64_read(const atomic64_t *v)
 	return val;
 }
 
-static inline void atomic64_set(atomic64_t *v, long long a)
+static inline void atomic64_set(atomic64_t *v, s64 a)
 {
 	/*
 	 * This could have been a simple assignment in "C" but would need
@@ -362,9 +362,9 @@ static inline void atomic64_set(atomic64_t *v, long long a)
 }
 
 #define ATOMIC64_OP(op, op1, op2)					\
-static inline void atomic64_##op(long long a, atomic64_t *v)		\
+static inline void atomic64_##op(s64 a, atomic64_t *v)			\
 {									\
-	unsigned long long val;						\
+	s64 val;							\
 									\
 	__asm__ __volatile__(						\
 	"1:				\n"				\
@@ -375,13 +375,13 @@ static inline void atomic64_##op(long long a, atomic64_t *v)		\
 	"	bnz     1b		\n"				\
 	: "=&r"(val)							\
 	: "r"(&v->counter), "ir"(a)					\
-	: "cc");						\
+	: "cc");							\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)		        	\
-static inline long long atomic64_##op##_return(long long a, atomic64_t *v)	\
+static inline s64 atomic64_##op##_return(s64 a, atomic64_t *v)		\
 {									\
-	unsigned long long val;						\
+	s64 val;							\
 									\
 	smp_mb();							\
 									\
@@ -402,9 +402,9 @@ static inline long long atomic64_##op##_return(long long a, atomic64_t *v)	\
 }
 
 #define ATOMIC64_FETCH_OP(op, op1, op2)		        		\
-static inline long long atomic64_fetch_##op(long long a, atomic64_t *v)	\
+static inline s64 atomic64_fetch_##op(s64 a, atomic64_t *v)		\
 {									\
-	unsigned long long val, orig;					\
+	s64 val, orig;							\
 									\
 	smp_mb();							\
 									\
@@ -444,10 +444,10 @@ ATOMIC64_OPS(xor, xor, xor)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-static inline long long
-atomic64_cmpxchg(atomic64_t *ptr, long long expected, long long new)
+static inline s64
+atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
 {
-	long long prev;
+	s64 prev;
 
 	smp_mb();
 
@@ -467,9 +467,9 @@ atomic64_cmpxchg(atomic64_t *ptr, long long expected, long long new)
 	return prev;
 }
 
-static inline long long atomic64_xchg(atomic64_t *ptr, long long new)
+static inline s64 atomic64_xchg(atomic64_t *ptr, s64 new)
 {
-	long long prev;
+	s64 prev;
 
 	smp_mb();
 
@@ -495,9 +495,9 @@ static inline long long atomic64_xchg(atomic64_t *ptr, long long new)
  * the atomic variable, v, was not decremented.
  */
 
-static inline long long atomic64_dec_if_positive(atomic64_t *v)
+static inline s64 atomic64_dec_if_positive(atomic64_t *v)
 {
-	long long val;
+	s64 val;
 
 	smp_mb();
 
@@ -528,10 +528,9 @@ static inline long long atomic64_dec_if_positive(atomic64_t *v)
  * Atomically adds @a to @v, if it was not @u.
  * Returns the old value of @v
  */
-static inline long long atomic64_fetch_add_unless(atomic64_t *v, long long a,
-						  long long u)
+static inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	long long old, temp;
+	s64 old, temp;
 
 	smp_mb();
 
