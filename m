Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FB4C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C580F24C4B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eQp16pAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfFCNmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:42:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47289 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbfFCNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:42:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DgXqK612230
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:42:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DgXqK612230
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569354;
        bh=1B3EFEXNw0umT7bq7uVdz46zLj4UUSpc8p0Z55Jy9nE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eQp16pAtjwJEW54ip5k8WhcZI5I6mLc1OdyvRrhIhnjg+5K394x6+KWT3a6eJtRzd
         dCFMeKkZovMdfR0uNElg0qyTKo0gtYNzUzMLuJPOBHnkLXhuzWHBnwKSzf1TMCx77+
         CoKn9A/006wmB+X1b1XFBRjrUzkrXdNdJgznUvkFnN95StWnk8siaZFcNCXy0unHDs
         /LIpeYBDJdb8rMKg0XSIRPryJ5ZSFfyia/LLwnhTICSNVjZAJomx7+sRXuUq+ebkOU
         pGyQYhlyKIzvkRhpQ8svUhJlT5LKxH216hCyahVLVdwnjqVtRH28jlA/+0RJ7oNYvA
         +j4ZiBhR/mkvQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DgXSH612223;
        Mon, 3 Jun 2019 06:42:33 -0700
Date:   Mon, 3 Jun 2019 06:42:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-0ca94800762e8a2f7037c9b02ba74aff8016dd82@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        heiko.carstens@de.ibm.com, mark.rutland@arm.com,
        will.deacon@arm.com, peterz@infradead.org, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          will.deacon@arm.com, peterz@infradead.org,
          heiko.carstens@de.ibm.com, mark.rutland@arm.com, hpa@zytor.com
In-Reply-To: <20190522132250.26499-14-mark.rutland@arm.com>
References: <20190522132250.26499-14-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, s390: Use s64 for atomic64
Git-Commit-ID: 0ca94800762e8a2f7037c9b02ba74aff8016dd82
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

Commit-ID:  0ca94800762e8a2f7037c9b02ba74aff8016dd82
Gitweb:     https://git.kernel.org/tip/0ca94800762e8a2f7037c9b02ba74aff8016dd82
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:45 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, s390: Use s64 for atomic64

As a step towards making the atomic64 API use consistent types treewide,
let's have the s390 atomic64 implementation use s64 as the underlying
type for atomic64_t, rather than long, matching the generated headers.

As atomic64_read() depends on the generic defintion of atomic64_t, this
still returns long. This will be converted in a subsequent patch.

The s390-internal __atomic64_*() ops are also used by the s390 bitops,
and expect pointers to long. Since atomic64_t::counter will be converted
to s64 in a subsequent patch, pointes to this are explicitly cast to
pointers to long when passed to __atomic64_*() ops.

Otherwise, there should be no functional change as a result of this
patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
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
Link: https://lkml.kernel.org/r/20190522132250.26499-14-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/s390/include/asm/atomic.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index fd20ab5d4cf7..491ad53a0d4e 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -84,9 +84,9 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 
 #define ATOMIC64_INIT(i)  { (i) }
 
-static inline long atomic64_read(const atomic64_t *v)
+static inline s64 atomic64_read(const atomic64_t *v)
 {
-	long c;
+	s64 c;
 
 	asm volatile(
 		"	lg	%0,%1\n"
@@ -94,49 +94,49 @@ static inline long atomic64_read(const atomic64_t *v)
 	return c;
 }
 
-static inline void atomic64_set(atomic64_t *v, long i)
+static inline void atomic64_set(atomic64_t *v, s64 i)
 {
 	asm volatile(
 		"	stg	%1,%0\n"
 		: "=Q" (v->counter) : "d" (i));
 }
 
-static inline long atomic64_add_return(long i, atomic64_t *v)
+static inline s64 atomic64_add_return(s64 i, atomic64_t *v)
 {
-	return __atomic64_add_barrier(i, &v->counter) + i;
+	return __atomic64_add_barrier(i, (long *)&v->counter) + i;
 }
 
-static inline long atomic64_fetch_add(long i, atomic64_t *v)
+static inline s64 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
-	return __atomic64_add_barrier(i, &v->counter);
+	return __atomic64_add_barrier(i, (long *)&v->counter);
 }
 
-static inline void atomic64_add(long i, atomic64_t *v)
+static inline void atomic64_add(s64 i, atomic64_t *v)
 {
 #ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
 	if (__builtin_constant_p(i) && (i > -129) && (i < 128)) {
-		__atomic64_add_const(i, &v->counter);
+		__atomic64_add_const(i, (long *)&v->counter);
 		return;
 	}
 #endif
-	__atomic64_add(i, &v->counter);
+	__atomic64_add(i, (long *)&v->counter);
 }
 
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
-static inline long atomic64_cmpxchg(atomic64_t *v, long old, long new)
+static inline s64 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-	return __atomic64_cmpxchg(&v->counter, old, new);
+	return __atomic64_cmpxchg((long *)&v->counter, old, new);
 }
 
 #define ATOMIC64_OPS(op)						\
-static inline void atomic64_##op(long i, atomic64_t *v)			\
+static inline void atomic64_##op(s64 i, atomic64_t *v)			\
 {									\
-	__atomic64_##op(i, &v->counter);				\
+	__atomic64_##op(i, (long *)&v->counter);			\
 }									\
-static inline long atomic64_fetch_##op(long i, atomic64_t *v)		\
+static inline long atomic64_fetch_##op(s64 i, atomic64_t *v)		\
 {									\
-	return __atomic64_##op##_barrier(i, &v->counter);		\
+	return __atomic64_##op##_barrier(i, (long *)&v->counter);	\
 }
 
 ATOMIC64_OPS(and)
@@ -145,8 +145,8 @@ ATOMIC64_OPS(xor)
 
 #undef ATOMIC64_OPS
 
-#define atomic64_sub_return(_i, _v)	atomic64_add_return(-(long)(_i), _v)
-#define atomic64_fetch_sub(_i, _v)	atomic64_fetch_add(-(long)(_i), _v)
-#define atomic64_sub(_i, _v)		atomic64_add(-(long)(_i), _v)
+#define atomic64_sub_return(_i, _v)	atomic64_add_return(-(s64)(_i), _v)
+#define atomic64_fetch_sub(_i, _v)	atomic64_fetch_add(-(s64)(_i), _v)
+#define atomic64_sub(_i, _v)		atomic64_add(-(s64)(_i), _v)
 
 #endif /* __ARCH_S390_ATOMIC__  */
