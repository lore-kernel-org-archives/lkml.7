Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D3CC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAD224056
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VqmIMS+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfFCNh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:37:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49339 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfFCNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:37:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53Dbc0q611268
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:37:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53Dbc0q611268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569059;
        bh=PXdcDq8IdKAsu7kMx6Sxo5r3c9Al9uxjH28EH2os50Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VqmIMS+U9Wz12lm2hDyTZOhTHECFjMhJDmuV2+nm0RAK3MH1WFDbVyxpCunNtkVqT
         yulEVmq3jQSABK8JlwPyw58LCvmjg4hOQhIxeJLp9RGfI/PI/l1VFWG6aEE6kGd5Yq
         kCmlGexdW7NJYZVIMHPA9cKfjycefUBBmOfVU25wWRrFZ3X0+lYTSEu7EV0MwgmD4L
         spsz7T94ljUo2fUO1uXsGDGP52C9mOvaS3DeeeGBW/jDLtJVt4P0hsNxTgMuDkgmBT
         x9uKXqz1FmbrWtuz/FlgMABRGQ0ksvbh7F0qkfR8TSSCfEmct1HpMNDTvlhYJwVrj1
         N6PkBOlFoh7rQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DbbB9611265;
        Mon, 3 Jun 2019 06:37:37 -0700
Date:   Mon, 3 Jun 2019 06:37:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-ef4cdc09260e2b0576423ca708e245e7549aa8e0@git.kernel.org>
Cc:     mark.rutland@arm.com, tglx@linutronix.de, will.deacon@arm.com,
        mingo@kernel.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          linux@armlinux.org.uk, will.deacon@arm.com, mingo@kernel.org,
          tglx@linutronix.de, mark.rutland@arm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190522132250.26499-7-mark.rutland@arm.com>
References: <20190522132250.26499-7-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, arm: Use s64 for atomic64
Git-Commit-ID: ef4cdc09260e2b0576423ca708e245e7549aa8e0
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

Commit-ID:  ef4cdc09260e2b0576423ca708e245e7549aa8e0
Gitweb:     https://git.kernel.org/tip/ef4cdc09260e2b0576423ca708e245e7549aa8e0
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:38 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, arm: Use s64 for atomic64

As a step towards making the atomic64 API use consistent types treewide,
let's have the arm atomic64 implementation use s64 as the underlying
type for atomic64_t, rather than long long, matching the generated
headers.

Otherwise, there should be no functional change as a result of this
patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
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
Cc: mattst88@gmail.com
Cc: mpe@ellerman.id.au
Cc: palmer@sifive.com
Cc: paul.burton@mips.com
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: tony.luck@intel.com
Cc: vgupta@synopsys.com
Link: https://lkml.kernel.org/r/20190522132250.26499-7-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/include/asm/atomic.h | 50 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index f74756641410..d45c41f6f69c 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -249,15 +249,15 @@ ATOMIC_OPS(xor, ^=, eor)
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 typedef struct {
-	long long counter;
+	s64 counter;
 } atomic64_t;
 
 #define ATOMIC64_INIT(i) { (i) }
 
 #ifdef CONFIG_ARM_LPAE
-static inline long long atomic64_read(const atomic64_t *v)
+static inline s64 atomic64_read(const atomic64_t *v)
 {
-	long long result;
+	s64 result;
 
 	__asm__ __volatile__("@ atomic64_read\n"
 "	ldrd	%0, %H0, [%1]"
@@ -268,7 +268,7 @@ static inline long long atomic64_read(const atomic64_t *v)
 	return result;
 }
 
-static inline void atomic64_set(atomic64_t *v, long long i)
+static inline void atomic64_set(atomic64_t *v, s64 i)
 {
 	__asm__ __volatile__("@ atomic64_set\n"
 "	strd	%2, %H2, [%1]"
@@ -277,9 +277,9 @@ static inline void atomic64_set(atomic64_t *v, long long i)
 	);
 }
 #else
-static inline long long atomic64_read(const atomic64_t *v)
+static inline s64 atomic64_read(const atomic64_t *v)
 {
-	long long result;
+	s64 result;
 
 	__asm__ __volatile__("@ atomic64_read\n"
 "	ldrexd	%0, %H0, [%1]"
@@ -290,9 +290,9 @@ static inline long long atomic64_read(const atomic64_t *v)
 	return result;
 }
 
-static inline void atomic64_set(atomic64_t *v, long long i)
+static inline void atomic64_set(atomic64_t *v, s64 i)
 {
-	long long tmp;
+	s64 tmp;
 
 	prefetchw(&v->counter);
 	__asm__ __volatile__("@ atomic64_set\n"
@@ -307,9 +307,9 @@ static inline void atomic64_set(atomic64_t *v, long long i)
 #endif
 
 #define ATOMIC64_OP(op, op1, op2)					\
-static inline void atomic64_##op(long long i, atomic64_t *v)		\
+static inline void atomic64_##op(s64 i, atomic64_t *v)			\
 {									\
-	long long result;						\
+	s64 result;							\
 	unsigned long tmp;						\
 									\
 	prefetchw(&v->counter);						\
@@ -326,10 +326,10 @@ static inline void atomic64_##op(long long i, atomic64_t *v)		\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)				\
-static inline long long							\
-atomic64_##op##_return_relaxed(long long i, atomic64_t *v)		\
+static inline s64							\
+atomic64_##op##_return_relaxed(s64 i, atomic64_t *v)			\
 {									\
-	long long result;						\
+	s64 result;							\
 	unsigned long tmp;						\
 									\
 	prefetchw(&v->counter);						\
@@ -349,10 +349,10 @@ atomic64_##op##_return_relaxed(long long i, atomic64_t *v)		\
 }
 
 #define ATOMIC64_FETCH_OP(op, op1, op2)					\
-static inline long long							\
-atomic64_fetch_##op##_relaxed(long long i, atomic64_t *v)		\
+static inline s64							\
+atomic64_fetch_##op##_relaxed(s64 i, atomic64_t *v)			\
 {									\
-	long long result, val;						\
+	s64 result, val;						\
 	unsigned long tmp;						\
 									\
 	prefetchw(&v->counter);						\
@@ -406,10 +406,9 @@ ATOMIC64_OPS(xor, eor, eor)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-static inline long long
-atomic64_cmpxchg_relaxed(atomic64_t *ptr, long long old, long long new)
+static inline s64 atomic64_cmpxchg_relaxed(atomic64_t *ptr, s64 old, s64 new)
 {
-	long long oldval;
+	s64 oldval;
 	unsigned long res;
 
 	prefetchw(&ptr->counter);
@@ -430,9 +429,9 @@ atomic64_cmpxchg_relaxed(atomic64_t *ptr, long long old, long long new)
 }
 #define atomic64_cmpxchg_relaxed	atomic64_cmpxchg_relaxed
 
-static inline long long atomic64_xchg_relaxed(atomic64_t *ptr, long long new)
+static inline s64 atomic64_xchg_relaxed(atomic64_t *ptr, s64 new)
 {
-	long long result;
+	s64 result;
 	unsigned long tmp;
 
 	prefetchw(&ptr->counter);
@@ -450,9 +449,9 @@ static inline long long atomic64_xchg_relaxed(atomic64_t *ptr, long long new)
 }
 #define atomic64_xchg_relaxed		atomic64_xchg_relaxed
 
-static inline long long atomic64_dec_if_positive(atomic64_t *v)
+static inline s64 atomic64_dec_if_positive(atomic64_t *v)
 {
-	long long result;
+	s64 result;
 	unsigned long tmp;
 
 	smp_mb();
@@ -478,10 +477,9 @@ static inline long long atomic64_dec_if_positive(atomic64_t *v)
 }
 #define atomic64_dec_if_positive atomic64_dec_if_positive
 
-static inline long long atomic64_fetch_add_unless(atomic64_t *v, long long a,
-						  long long u)
+static inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	long long oldval, newval;
+	s64 oldval, newval;
 	unsigned long tmp;
 
 	smp_mb();
