Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A995C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCA727DC4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MDLpl7ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfFCNgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:36:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55687 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfFCNgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:36:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DaD7k611177
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:36:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DaD7k611177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568974;
        bh=y209N5hqjIengwRziW7lpeTaL+YzrJkvglcBMN43i88=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MDLpl7niFtKkXBjg7HJtP4cAauQxWBwLpeA9dWjMwSb0HpMacctGkiseN2ot0LJvh
         4LF/VvFa25lz1gWWuWm9mSASpK4A+o3D36Io5G7Jnzjlj7kEgkR4fE9nfIcAnVoEg8
         jSlk+EVkxNBAVcI2gWch4xq20wvdCwato3nHsadAcZo1CQoi1asctm57NRo8WGC60g
         hRCkmWeSBjZqSfEPM4vIiYF3RJKXTmAne8x2Blz2j9Wg8EcToin7pLUdbGnZdXzDFO
         wjQmlV8L5CqYcDO8q863cGfuaDDvMRnz2DFZXnYsyL3sKOJPfD2zfb9UMKMVFMoWIa
         J4NRZmY3JJ08w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DaDUF611171;
        Mon, 3 Jun 2019 06:36:13 -0700
Date:   Mon, 3 Jun 2019 06:36:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-0203fdc160a8c8d8651a3b79aa453ec36cfbd867@git.kernel.org>
Cc:     torvalds@linux-foundation.org, rth@twiddle.net,
        peterz@infradead.org, will.deacon@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, mattst88@gmail.com,
        ink@jurassic.park.msu.ru, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: will.deacon@arm.com, rth@twiddle.net,
          torvalds@linux-foundation.org, ink@jurassic.park.msu.ru,
          mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
          tglx@linutronix.de, mattst88@gmail.com,
          linux-kernel@vger.kernel.org, mark.rutland@arm.com
In-Reply-To: <20190522132250.26499-5-mark.rutland@arm.com>
References: <20190522132250.26499-5-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, alpha: Use s64 for atomic64
Git-Commit-ID: 0203fdc160a8c8d8651a3b79aa453ec36cfbd867
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

Commit-ID:  0203fdc160a8c8d8651a3b79aa453ec36cfbd867
Gitweb:     https://git.kernel.org/tip/0203fdc160a8c8d8651a3b79aa453ec36cfbd867
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:36 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, alpha: Use s64 for atomic64

As a step towards making the atomic64 API use consistent types treewide,
let's have the alpha atomic64 implementation use s64 as the underlying
type for atomic64_t, rather than long, matching the generated headers.

As atomic64_read() depends on the generic defintion of atomic64_t, this
still returns long. This will be converted in a subsequent patch.

Otherwise, there should be no functional change as a result of this
patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
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
Cc: jhogan@kernel.org
Cc: linux@armlinux.org.uk
Cc: mpe@ellerman.id.au
Cc: palmer@sifive.com
Cc: paul.burton@mips.com
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: tony.luck@intel.com
Cc: vgupta@synopsys.com
Link: https://lkml.kernel.org/r/20190522132250.26499-5-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/alpha/include/asm/atomic.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 150a1c5d6a2c..2144530d1428 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -93,9 +93,9 @@ static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 }
 
 #define ATOMIC64_OP(op, asm_op)						\
-static __inline__ void atomic64_##op(long i, atomic64_t * v)		\
+static __inline__ void atomic64_##op(s64 i, atomic64_t * v)		\
 {									\
-	unsigned long temp;						\
+	s64 temp;							\
 	__asm__ __volatile__(						\
 	"1:	ldq_l %0,%1\n"						\
 	"	" #asm_op " %0,%2,%0\n"					\
@@ -109,9 +109,9 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, asm_op)					\
-static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v)	\
+static __inline__ s64 atomic64_##op##_return_relaxed(s64 i, atomic64_t * v)	\
 {									\
-	long temp, result;						\
+	s64 temp, result;						\
 	__asm__ __volatile__(						\
 	"1:	ldq_l %0,%1\n"						\
 	"	" #asm_op " %0,%3,%2\n"					\
@@ -128,9 +128,9 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v)	\
 }
 
 #define ATOMIC64_FETCH_OP(op, asm_op)					\
-static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)	\
+static __inline__ s64 atomic64_fetch_##op##_relaxed(s64 i, atomic64_t * v)	\
 {									\
-	long temp, result;						\
+	s64 temp, result;						\
 	__asm__ __volatile__(						\
 	"1:	ldq_l %2,%1\n"						\
 	"	" #asm_op " %2,%3,%0\n"					\
@@ -246,9 +246,9 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
+static __inline__ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	long c, new, old;
+	s64 c, new, old;
 	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldq_l	%[old],%[mem]\n"
@@ -276,9 +276,9 @@ static __inline__ long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
  * The function returns the old value of *v minus 1, even if
  * the atomic variable, v, was not decremented.
  */
-static inline long atomic64_dec_if_positive(atomic64_t *v)
+static inline s64 atomic64_dec_if_positive(atomic64_t *v)
 {
-	long old, tmp;
+	s64 old, tmp;
 	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldq_l	%[old],%[mem]\n"
