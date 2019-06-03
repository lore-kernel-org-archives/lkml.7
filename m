Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEA2C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A9D25476
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IR5H6ezn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfFCNie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:38:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56537 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfFCNie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:38:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DcKei611329
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:38:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DcKei611329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569100;
        bh=9wGOvt0pKpE4wcF7Tj/DiP7os/Sj+y4fSF+JYm9eecs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=IR5H6eznHUjijCk4IyNscu1yZ4QueSvAoela1hH2fxZ0gJHSRbRkcQ7blBtMnW9Oi
         4ZieXKWXXg0oJcfjQ1LCjSJ86RRWa0RIJZ/YPr7QAWDF5aUwUbp+Qs//doI8dT7Ze8
         3DTx7oUbpYCmJoibL3XVuDO2wd1d5olRnO6nZXrtKWWdYUaRSt7oA5B6+LaqpFTpUA
         I7iey2xmvOylSNOVbloZABf1BhpYCktdhoOtc9jyEvfHFSlp6OqpkN53NDgZxvG1hZ
         qlr/LTEptGpAqrZPU9RI8W7/zLhV7WXfZnl3LW5rOCxYBcB3ffLiteWn5GgW1B2xWf
         dT5lG+ndS88UQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DcJk7611326;
        Mon, 3 Jun 2019 06:38:19 -0700
Date:   Mon, 3 Jun 2019 06:38:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-16f18688af7ea6c65f6daa3efb4661415e2e6041@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        peterz@infradead.org, hpa@zytor.com, mark.rutland@arm.com,
        mingo@kernel.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: catalin.marinas@arm.com, hpa@zytor.com, mark.rutland@arm.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org, will.deacon@arm.com,
          torvalds@linux-foundation.org
In-Reply-To: <20190522132250.26499-8-mark.rutland@arm.com>
References: <20190522132250.26499-8-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, arm64: Use s64 for atomic64
Git-Commit-ID: 16f18688af7ea6c65f6daa3efb4661415e2e6041
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

Commit-ID:  16f18688af7ea6c65f6daa3efb4661415e2e6041
Gitweb:     https://git.kernel.org/tip/16f18688af7ea6c65f6daa3efb4661415e2e6041
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:39 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, arm64: Use s64 for atomic64

As a step towards making the atomic64 API use consistent types treewide,
let's have the arm64 atomic64 implementation use s64 as the underlying
type for atomic64_t, rather than long, matching the generated headers.

As atomic64_read() depends on the generic defintion of atomic64_t, this
still returns long. This will be converted in a subsequent patch.

Note that in arch_atomic64_dec_if_positive(), the x0 variable is left as
long, as this variable is also used to hold the pointer to the
atomic64_t.

Otherwise, there should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aou@eecs.berkeley.edu
Cc: arnd@arndb.de
Cc: bp@alien8.de
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
Link: https://lkml.kernel.org/r/20190522132250.26499-8-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 20 ++++++++++----------
 arch/arm64/include/asm/atomic_lse.h   | 34 +++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index e321293e0c89..f3b12d7f431f 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -133,9 +133,9 @@ ATOMIC_OPS(xor, eor)
 
 #define ATOMIC64_OP(op, asm_op)						\
 __LL_SC_INLINE void							\
-__LL_SC_PREFIX(arch_atomic64_##op(long i, atomic64_t *v))		\
+__LL_SC_PREFIX(arch_atomic64_##op(s64 i, atomic64_t *v))		\
 {									\
-	long result;							\
+	s64 result;							\
 	unsigned long tmp;						\
 									\
 	asm volatile("// atomic64_" #op "\n"				\
@@ -150,10 +150,10 @@ __LL_SC_PREFIX(arch_atomic64_##op(long i, atomic64_t *v))		\
 __LL_SC_EXPORT(arch_atomic64_##op);
 
 #define ATOMIC64_OP_RETURN(name, mb, acq, rel, cl, op, asm_op)		\
-__LL_SC_INLINE long							\
-__LL_SC_PREFIX(arch_atomic64_##op##_return##name(long i, atomic64_t *v))\
+__LL_SC_INLINE s64							\
+__LL_SC_PREFIX(arch_atomic64_##op##_return##name(s64 i, atomic64_t *v))\
 {									\
-	long result;							\
+	s64 result;							\
 	unsigned long tmp;						\
 									\
 	asm volatile("// atomic64_" #op "_return" #name "\n"		\
@@ -172,10 +172,10 @@ __LL_SC_PREFIX(arch_atomic64_##op##_return##name(long i, atomic64_t *v))\
 __LL_SC_EXPORT(arch_atomic64_##op##_return##name);
 
 #define ATOMIC64_FETCH_OP(name, mb, acq, rel, cl, op, asm_op)		\
-__LL_SC_INLINE long							\
-__LL_SC_PREFIX(arch_atomic64_fetch_##op##name(long i, atomic64_t *v))	\
+__LL_SC_INLINE s64							\
+__LL_SC_PREFIX(arch_atomic64_fetch_##op##name(s64 i, atomic64_t *v))	\
 {									\
-	long result, val;						\
+	s64 result, val;						\
 	unsigned long tmp;						\
 									\
 	asm volatile("// atomic64_fetch_" #op #name "\n"		\
@@ -225,10 +225,10 @@ ATOMIC64_OPS(xor, eor)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-__LL_SC_INLINE long
+__LL_SC_INLINE s64
 __LL_SC_PREFIX(arch_atomic64_dec_if_positive(atomic64_t *v))
 {
-	long result;
+	s64 result;
 	unsigned long tmp;
 
 	asm volatile("// atomic64_dec_if_positive\n"
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 9256a3921e4b..c53832b08af7 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -224,9 +224,9 @@ ATOMIC_FETCH_OP_SUB(        , al, "memory")
 
 #define __LL_SC_ATOMIC64(op)	__LL_SC_CALL(arch_atomic64_##op)
 #define ATOMIC64_OP(op, asm_op)						\
-static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
+static inline void arch_atomic64_##op(s64 i, atomic64_t *v)		\
 {									\
-	register long x0 asm ("x0") = i;				\
+	register s64 x0 asm ("x0") = i;					\
 	register atomic64_t *x1 asm ("x1") = v;				\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(op),	\
@@ -244,9 +244,9 @@ ATOMIC64_OP(add, stadd)
 #undef ATOMIC64_OP
 
 #define ATOMIC64_FETCH_OP(name, mb, op, asm_op, cl...)			\
-static inline long arch_atomic64_fetch_##op##name(long i, atomic64_t *v)\
+static inline s64 arch_atomic64_fetch_##op##name(s64 i, atomic64_t *v)	\
 {									\
-	register long x0 asm ("x0") = i;				\
+	register s64 x0 asm ("x0") = i;					\
 	register atomic64_t *x1 asm ("x1") = v;				\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
@@ -276,9 +276,9 @@ ATOMIC64_FETCH_OPS(add, ldadd)
 #undef ATOMIC64_FETCH_OPS
 
 #define ATOMIC64_OP_ADD_RETURN(name, mb, cl...)				\
-static inline long arch_atomic64_add_return##name(long i, atomic64_t *v)\
+static inline s64 arch_atomic64_add_return##name(s64 i, atomic64_t *v)	\
 {									\
-	register long x0 asm ("x0") = i;				\
+	register s64 x0 asm ("x0") = i;					\
 	register atomic64_t *x1 asm ("x1") = v;				\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
@@ -302,9 +302,9 @@ ATOMIC64_OP_ADD_RETURN(        , al, "memory")
 
 #undef ATOMIC64_OP_ADD_RETURN
 
-static inline void arch_atomic64_and(long i, atomic64_t *v)
+static inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
-	register long x0 asm ("x0") = i;
+	register s64 x0 asm ("x0") = i;
 	register atomic64_t *x1 asm ("x1") = v;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
@@ -320,9 +320,9 @@ static inline void arch_atomic64_and(long i, atomic64_t *v)
 }
 
 #define ATOMIC64_FETCH_OP_AND(name, mb, cl...)				\
-static inline long arch_atomic64_fetch_and##name(long i, atomic64_t *v)	\
+static inline s64 arch_atomic64_fetch_and##name(s64 i, atomic64_t *v)	\
 {									\
-	register long x0 asm ("x0") = i;				\
+	register s64 x0 asm ("x0") = i;					\
 	register atomic64_t *x1 asm ("x1") = v;				\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
@@ -346,9 +346,9 @@ ATOMIC64_FETCH_OP_AND(        , al, "memory")
 
 #undef ATOMIC64_FETCH_OP_AND
 
-static inline void arch_atomic64_sub(long i, atomic64_t *v)
+static inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 {
-	register long x0 asm ("x0") = i;
+	register s64 x0 asm ("x0") = i;
 	register atomic64_t *x1 asm ("x1") = v;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
@@ -364,9 +364,9 @@ static inline void arch_atomic64_sub(long i, atomic64_t *v)
 }
 
 #define ATOMIC64_OP_SUB_RETURN(name, mb, cl...)				\
-static inline long arch_atomic64_sub_return##name(long i, atomic64_t *v)\
+static inline s64 arch_atomic64_sub_return##name(s64 i, atomic64_t *v)	\
 {									\
-	register long x0 asm ("x0") = i;				\
+	register s64 x0 asm ("x0") = i;					\
 	register atomic64_t *x1 asm ("x1") = v;				\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
@@ -392,9 +392,9 @@ ATOMIC64_OP_SUB_RETURN(        , al, "memory")
 #undef ATOMIC64_OP_SUB_RETURN
 
 #define ATOMIC64_FETCH_OP_SUB(name, mb, cl...)				\
-static inline long arch_atomic64_fetch_sub##name(long i, atomic64_t *v)	\
+static inline s64 arch_atomic64_fetch_sub##name(s64 i, atomic64_t *v)	\
 {									\
-	register long x0 asm ("x0") = i;				\
+	register s64 x0 asm ("x0") = i;					\
 	register atomic64_t *x1 asm ("x1") = v;				\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
@@ -418,7 +418,7 @@ ATOMIC64_FETCH_OP_SUB(        , al, "memory")
 
 #undef ATOMIC64_FETCH_OP_SUB
 
-static inline long arch_atomic64_dec_if_positive(atomic64_t *v)
+static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	register long x0 asm ("x0") = (long)v;
 
