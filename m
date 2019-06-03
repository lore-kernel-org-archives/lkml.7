Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB91C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB83A27B4B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gK0vQm6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfFCNkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:40:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37191 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfFCNky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:40:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DePpt611816
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:40:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DePpt611816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569225;
        bh=VYU0yV3lqUuGFDknFr3qL8pGjIjf+GFkOSn+t7h3la4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gK0vQm6LTdDC+dENnXDjWY1uviJCdf3l/mKbvGRKc6xqD2DIqCH4AeOFvKWvLwtRq
         lck/eSFOxAqNgeVr/iUKsJf/hxMDmRl09jsEsuDhzwsCefzfgk+XaCcuiQYPRYWh9H
         mG/aCMyecKW9CbIEyVSxR0PqSj/FzwqAWiEEF+8R/P77+rK2eMNXyiLRWMeY8QBYma
         3gaDV1DhiiKU25xdJXu4vwTccayC0Fl7g5rGPaLQyAHpT+wvqOXG1IUF5v8g4eVY0w
         zTcxkY7D8uADtD1+//TL7nupusmBZZ63E88wNpLecVf721RGLb1FMmgmeCkhxXh9D6
         0dBOBhcXAfmHQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DeODn611813;
        Mon, 3 Jun 2019 06:40:24 -0700
Date:   Mon, 3 Jun 2019 06:40:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-8cd8de59748ba71b476d1b7101f9ecaccd5cb8c2@git.kernel.org>
Cc:     hpa@zytor.com, mark.rutland@arm.com, peterz@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org,
        will.deacon@arm.com, mpe@ellerman.id.au, tglx@linutronix.de,
        paulus@samba.org, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, will.deacon@arm.com, mpe@ellerman.id.au,
          paulus@samba.org, linux-kernel@vger.kernel.org,
          mark.rutland@arm.com, hpa@zytor.com,
          torvalds@linux-foundation.org, mingo@kernel.org,
          peterz@infradead.org
In-Reply-To: <20190522132250.26499-11-mark.rutland@arm.com>
References: <20190522132250.26499-11-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, powerpc: Use s64 for atomic64
Git-Commit-ID: 8cd8de59748ba71b476d1b7101f9ecaccd5cb8c2
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

Commit-ID:  8cd8de59748ba71b476d1b7101f9ecaccd5cb8c2
Gitweb:     https://git.kernel.org/tip/8cd8de59748ba71b476d1b7101f9ecaccd5cb8c2
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:42 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, powerpc: Use s64 for atomic64

As a step towards making the atomic64 API use consistent types treewide,
let's have the powerpc atomic64 implementation use s64 as the underlying
type for atomic64_t, rather than long, matching the generated headers.

As atomic64_read() depends on the generic defintion of atomic64_t, this
still returns long on 64-bit. This will be converted in a subsequent
patch.

Otherwise, there should be no functional change as a result of this
patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Mackerras <paulus@samba.org>
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
Cc: palmer@sifive.com
Cc: paul.burton@mips.com
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: tony.luck@intel.com
Cc: vgupta@synopsys.com
Link: https://lkml.kernel.org/r/20190522132250.26499-11-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/powerpc/include/asm/atomic.h | 44 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 52eafaf74054..31c231ea56b7 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -297,24 +297,24 @@ static __inline__ int atomic_dec_if_positive(atomic_t *v)
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-static __inline__ long atomic64_read(const atomic64_t *v)
+static __inline__ s64 atomic64_read(const atomic64_t *v)
 {
-	long t;
+	s64 t;
 
 	__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : "m"(v->counter));
 
 	return t;
 }
 
-static __inline__ void atomic64_set(atomic64_t *v, long i)
+static __inline__ void atomic64_set(atomic64_t *v, s64 i)
 {
 	__asm__ __volatile__("std%U0%X0 %1,%0" : "=m"(v->counter) : "r"(i));
 }
 
 #define ATOMIC64_OP(op, asm_op)						\
-static __inline__ void atomic64_##op(long a, atomic64_t *v)		\
+static __inline__ void atomic64_##op(s64 a, atomic64_t *v)		\
 {									\
-	long t;								\
+	s64 t;								\
 									\
 	__asm__ __volatile__(						\
 "1:	ldarx	%0,0,%3		# atomic64_" #op "\n"			\
@@ -327,10 +327,10 @@ static __inline__ void atomic64_##op(long a, atomic64_t *v)		\
 }
 
 #define ATOMIC64_OP_RETURN_RELAXED(op, asm_op)				\
-static inline long							\
-atomic64_##op##_return_relaxed(long a, atomic64_t *v)			\
+static inline s64							\
+atomic64_##op##_return_relaxed(s64 a, atomic64_t *v)			\
 {									\
-	long t;								\
+	s64 t;								\
 									\
 	__asm__ __volatile__(						\
 "1:	ldarx	%0,0,%3		# atomic64_" #op "_return_relaxed\n"	\
@@ -345,10 +345,10 @@ atomic64_##op##_return_relaxed(long a, atomic64_t *v)			\
 }
 
 #define ATOMIC64_FETCH_OP_RELAXED(op, asm_op)				\
-static inline long							\
-atomic64_fetch_##op##_relaxed(long a, atomic64_t *v)			\
+static inline s64							\
+atomic64_fetch_##op##_relaxed(s64 a, atomic64_t *v)			\
 {									\
-	long res, t;							\
+	s64 res, t;							\
 									\
 	__asm__ __volatile__(						\
 "1:	ldarx	%0,0,%4		# atomic64_fetch_" #op "_relaxed\n"	\
@@ -396,7 +396,7 @@ ATOMIC64_OPS(xor, xor)
 
 static __inline__ void atomic64_inc(atomic64_t *v)
 {
-	long t;
+	s64 t;
 
 	__asm__ __volatile__(
 "1:	ldarx	%0,0,%2		# atomic64_inc\n\
@@ -409,9 +409,9 @@ static __inline__ void atomic64_inc(atomic64_t *v)
 }
 #define atomic64_inc atomic64_inc
 
-static __inline__ long atomic64_inc_return_relaxed(atomic64_t *v)
+static __inline__ s64 atomic64_inc_return_relaxed(atomic64_t *v)
 {
-	long t;
+	s64 t;
 
 	__asm__ __volatile__(
 "1:	ldarx	%0,0,%2		# atomic64_inc_return_relaxed\n"
@@ -427,7 +427,7 @@ static __inline__ long atomic64_inc_return_relaxed(atomic64_t *v)
 
 static __inline__ void atomic64_dec(atomic64_t *v)
 {
-	long t;
+	s64 t;
 
 	__asm__ __volatile__(
 "1:	ldarx	%0,0,%2		# atomic64_dec\n\
@@ -440,9 +440,9 @@ static __inline__ void atomic64_dec(atomic64_t *v)
 }
 #define atomic64_dec atomic64_dec
 
-static __inline__ long atomic64_dec_return_relaxed(atomic64_t *v)
+static __inline__ s64 atomic64_dec_return_relaxed(atomic64_t *v)
 {
-	long t;
+	s64 t;
 
 	__asm__ __volatile__(
 "1:	ldarx	%0,0,%2		# atomic64_dec_return_relaxed\n"
@@ -463,9 +463,9 @@ static __inline__ long atomic64_dec_return_relaxed(atomic64_t *v)
  * Atomically test *v and decrement if it is greater than 0.
  * The function returns the old value of *v minus 1.
  */
-static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
+static __inline__ s64 atomic64_dec_if_positive(atomic64_t *v)
 {
-	long t;
+	s64 t;
 
 	__asm__ __volatile__(
 	PPC_ATOMIC_ENTRY_BARRIER
@@ -502,9 +502,9 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
+static __inline__ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	long t;
+	s64 t;
 
 	__asm__ __volatile__ (
 	PPC_ATOMIC_ENTRY_BARRIER
@@ -534,7 +534,7 @@ static __inline__ long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
  */
 static __inline__ int atomic64_inc_not_zero(atomic64_t *v)
 {
-	long t1, t2;
+	s64 t1, t2;
 
 	__asm__ __volatile__ (
 	PPC_ATOMIC_ENTRY_BARRIER
