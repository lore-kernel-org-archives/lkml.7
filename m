Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29580C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E777627B4B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="T8wjLAkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfFCNmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:42:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33229 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfFCNmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:42:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DfnY8611928
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:41:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DfnY8611928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569310;
        bh=awTI1eeX+Qg2TS+otR6dg6T9jf7a0nGzNV2qFkooTqc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=T8wjLAkvzpep2pOMtIPklyK+6F5SNJHckD+6FXk3W8vRpc0DUcOU2JG0v6k34Vdc8
         et/QIvkwBlfsZ5xjGL8ZqpkZLJ451aKEKw6HVo7rBVjQhnjHTQzveIz0NyME2aOwn1
         Ixr/HzeQSVcS8+xSwgYXXyavFvjgxdP82BIxSi/nYUHyz6giv/H+Z+4Vtn6MGqb0WL
         bKxM/fHPSdEPjzYkHIqML+VvKst7O8yuzCBmHPMFOcaHm2U+Y9yKvEm8TL8J1tqFMX
         7z5qzBW4Fx2UNQNm9uRzGUYikXWL1XEMzgEEVhNMNmCqrWthD7jhLtZ38muWx05yAd
         RXaPpf7Vc2DDQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53Dfntw611925;
        Mon, 3 Jun 2019 06:41:49 -0700
Date:   Mon, 3 Jun 2019 06:41:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-0754211847d7a228f1c34a49fd122979dfd19a1a@git.kernel.org>
Cc:     mark.rutland@arm.com, hpa@zytor.com, peterz@infradead.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, palmer@sifive.com
Reply-To: hpa@zytor.com, mark.rutland@arm.com, palmer@sifive.com,
          mingo@kernel.org, torvalds@linux-foundation.org,
          will.deacon@arm.com, aou@eecs.berkeley.edu, peterz@infradead.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190522132250.26499-13-mark.rutland@arm.com>
References: <20190522132250.26499-13-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, riscv: Use s64 for atomic64
Git-Commit-ID: 0754211847d7a228f1c34a49fd122979dfd19a1a
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

Commit-ID:  0754211847d7a228f1c34a49fd122979dfd19a1a
Gitweb:     https://git.kernel.org/tip/0754211847d7a228f1c34a49fd122979dfd19a1a
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:44 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, riscv: Use s64 for atomic64

As a step towards making the atomic64 API use consistent types treewide,
let's have the RISC-V atomic64 implementation use s64 as the underlying
type for atomic64_t, rather than long, matching the generated headers.

As atomic64_read() depends on the generic defintion of atomic64_t, this
still returns long on 64-bit. This will be converted in a subsequent
patch.

Otherwise, there should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
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
Cc: paul.burton@mips.com
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: tony.luck@intel.com
Cc: vgupta@synopsys.com
Link: https://lkml.kernel.org/r/20190522132250.26499-13-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/riscv/include/asm/atomic.h | 44 +++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 9c263bd9d5ad..96f95c9ebd97 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -38,11 +38,11 @@ static __always_inline void atomic_set(atomic_t *v, int i)
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 #define ATOMIC64_INIT(i) { (i) }
-static __always_inline long atomic64_read(const atomic64_t *v)
+static __always_inline s64 atomic64_read(const atomic64_t *v)
 {
 	return READ_ONCE(v->counter);
 }
-static __always_inline void atomic64_set(atomic64_t *v, long i)
+static __always_inline void atomic64_set(atomic64_t *v, s64 i)
 {
 	WRITE_ONCE(v->counter, i);
 }
@@ -66,11 +66,11 @@ void atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)		\
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #define ATOMIC_OPS(op, asm_op, I)					\
-        ATOMIC_OP (op, asm_op, I, w,  int,   )
+        ATOMIC_OP (op, asm_op, I, w, int,   )
 #else
 #define ATOMIC_OPS(op, asm_op, I)					\
-        ATOMIC_OP (op, asm_op, I, w,  int,   )				\
-        ATOMIC_OP (op, asm_op, I, d, long, 64)
+        ATOMIC_OP (op, asm_op, I, w, int,   )				\
+        ATOMIC_OP (op, asm_op, I, d, s64, 64)
 #endif
 
 ATOMIC_OPS(add, add,  i)
@@ -127,14 +127,14 @@ c_type atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)	\
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #define ATOMIC_OPS(op, asm_op, c_op, I)					\
-        ATOMIC_FETCH_OP( op, asm_op,       I, w,  int,   )		\
-        ATOMIC_OP_RETURN(op, asm_op, c_op, I, w,  int,   )
+        ATOMIC_FETCH_OP( op, asm_op,       I, w, int,   )		\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I, w, int,   )
 #else
 #define ATOMIC_OPS(op, asm_op, c_op, I)					\
-        ATOMIC_FETCH_OP( op, asm_op,       I, w,  int,   )		\
-        ATOMIC_OP_RETURN(op, asm_op, c_op, I, w,  int,   )		\
-        ATOMIC_FETCH_OP( op, asm_op,       I, d, long, 64)		\
-        ATOMIC_OP_RETURN(op, asm_op, c_op, I, d, long, 64)
+        ATOMIC_FETCH_OP( op, asm_op,       I, w, int,   )		\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I, w, int,   )		\
+        ATOMIC_FETCH_OP( op, asm_op,       I, d, s64, 64)		\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I, d, s64, 64)
 #endif
 
 ATOMIC_OPS(add, add, +,  i)
@@ -166,11 +166,11 @@ ATOMIC_OPS(sub, add, +, -i)
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #define ATOMIC_OPS(op, asm_op, I)					\
-        ATOMIC_FETCH_OP(op, asm_op, I, w,  int,   )
+        ATOMIC_FETCH_OP(op, asm_op, I, w, int,   )
 #else
 #define ATOMIC_OPS(op, asm_op, I)					\
-        ATOMIC_FETCH_OP(op, asm_op, I, w,  int,   )			\
-        ATOMIC_FETCH_OP(op, asm_op, I, d, long, 64)
+        ATOMIC_FETCH_OP(op, asm_op, I, w, int,   )			\
+        ATOMIC_FETCH_OP(op, asm_op, I, d, s64, 64)
 #endif
 
 ATOMIC_OPS(and, and, i)
@@ -219,9 +219,10 @@ static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 #define atomic_fetch_add_unless atomic_fetch_add_unless
 
 #ifndef CONFIG_GENERIC_ATOMIC64
-static __always_inline long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
+static __always_inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-       long prev, rc;
+       s64 prev;
+       long rc;
 
 	__asm__ __volatile__ (
 		"0:	lr.d     %[p],  %[c]\n"
@@ -290,11 +291,11 @@ c_t atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #define ATOMIC_OPS()							\
-	ATOMIC_OP( int,   , 4)
+	ATOMIC_OP(int,   , 4)
 #else
 #define ATOMIC_OPS()							\
-	ATOMIC_OP( int,   , 4)						\
-	ATOMIC_OP(long, 64, 8)
+	ATOMIC_OP(int,   , 4)						\
+	ATOMIC_OP(s64, 64, 8)
 #endif
 
 ATOMIC_OPS()
@@ -332,9 +333,10 @@ static __always_inline int atomic_sub_if_positive(atomic_t *v, int offset)
 #define atomic_dec_if_positive(v)	atomic_sub_if_positive(v, 1)
 
 #ifndef CONFIG_GENERIC_ATOMIC64
-static __always_inline long atomic64_sub_if_positive(atomic64_t *v, long offset)
+static __always_inline s64 atomic64_sub_if_positive(atomic64_t *v, s64 offset)
 {
-       long prev, rc;
+       s64 prev;
+       long rc;
 
 	__asm__ __volatile__ (
 		"0:	lr.d     %[p],  %[c]\n"
