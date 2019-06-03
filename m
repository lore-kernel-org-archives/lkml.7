Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A2AC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A4227B4D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MT2pKiBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfFCNkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:40:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37711 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfFCNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:40:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53Ddhr9611682
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:39:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53Ddhr9611682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569184;
        bh=iHBTjDhluTQ2zBaV47PKxH7HnOpa3y45rlesZFAinB8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MT2pKiBescjijKrkpGOBgH3/54wrXZmmnOCsF+5nSvtFRmePKZSU/18dMQEb77Nh9
         Re0VNPfgmeOzglwq8ICSdBVCw9d5A28c9Jg1mjjVDfJs4fXQe0fchm0SV1SvdfZ9VU
         tp1REtrpMUQwFDsmrb6aFzyYRBbUMW8+UvfcBcIPIESWj6YRd2u+XEg5NMG57UTdw2
         AbfGv3U5FzEUyOmvokVO1dsxQURGr2yxwgk1taAazDlN6D/kF8eWrrP19p4go7icJA
         aWE+ahWj/9Y1nAzutwz/1RzkO2IpZ5D2o1G3aJ73+qAul+A7wEAmTnY5BO/4RRQlME
         LcfD6fyfMPZSg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DdgBx611679;
        Mon, 3 Jun 2019 06:39:42 -0700
Date:   Mon, 3 Jun 2019 06:39:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-d184cf1a449ca4cb0d86f3dd82c3337c645ea6c0@git.kernel.org>
Cc:     will.deacon@arm.com, paul.burton@mips.com, tglx@linutronix.de,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        jhogan@kernel.org, mingo@kernel.org, ralf@linux-mips.org,
        hpa@zytor.com
Reply-To: mingo@kernel.org, ralf@linux-mips.org, jhogan@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, will.deacon@arm.com,
          mark.rutland@arm.com, peterz@infradead.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          paul.burton@mips.com
In-Reply-To: <20190522132250.26499-10-mark.rutland@arm.com>
References: <20190522132250.26499-10-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, mips: Use s64 for atomic64
Git-Commit-ID: d184cf1a449ca4cb0d86f3dd82c3337c645ea6c0
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

Commit-ID:  d184cf1a449ca4cb0d86f3dd82c3337c645ea6c0
Gitweb:     https://git.kernel.org/tip/d184cf1a449ca4cb0d86f3dd82c3337c645ea6c0
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:41 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, mips: Use s64 for atomic64

As a step towards making the atomic64 API use consistent types treewide,
let's have the mips atomic64 implementation use s64 as the underlying
type for atomic64_t, rather than long or __s64, matching the generated
headers.

As atomic64_read() depends on the generic defintion of atomic64_t, this
still returns long on 64-bit. This will be converted in a subsequent
patch.

Otherwise, there should be no functional change as a result of this
patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
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
Cc: linux@armlinux.org.uk
Cc: mattst88@gmail.com
Cc: mpe@ellerman.id.au
Cc: palmer@sifive.com
Cc: paulus@samba.org
Cc: rth@twiddle.net
Cc: tony.luck@intel.com
Cc: vgupta@synopsys.com
Link: https://lkml.kernel.org/r/20190522132250.26499-10-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/mips/include/asm/atomic.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 94096299fc56..9a82dd11c0e9 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -254,10 +254,10 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 #define atomic64_set(v, i)	WRITE_ONCE((v)->counter, (i))
 
 #define ATOMIC64_OP(op, c_op, asm_op)					      \
-static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
+static __inline__ void atomic64_##op(s64 i, atomic64_t * v)		      \
 {									      \
 	if (kernel_uses_llsc) {						      \
-		long temp;						      \
+		s64 temp;						      \
 									      \
 		loongson_llsc_mb();					      \
 		__asm__ __volatile__(					      \
@@ -280,12 +280,12 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
 }
 
 #define ATOMIC64_OP_RETURN(op, c_op, asm_op)				      \
-static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
+static __inline__ s64 atomic64_##op##_return_relaxed(s64 i, atomic64_t * v)   \
 {									      \
-	long result;							      \
+	s64 result;							      \
 									      \
 	if (kernel_uses_llsc) {						      \
-		long temp;						      \
+		s64 temp;						      \
 									      \
 		loongson_llsc_mb();					      \
 		__asm__ __volatile__(					      \
@@ -314,12 +314,12 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
 }
 
 #define ATOMIC64_FETCH_OP(op, c_op, asm_op)				      \
-static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
+static __inline__ s64 atomic64_fetch_##op##_relaxed(s64 i, atomic64_t * v)    \
 {									      \
-	long result;							      \
+	s64 result;							      \
 									      \
 	if (kernel_uses_llsc) {						      \
-		long temp;						      \
+		s64 temp;						      \
 									      \
 		loongson_llsc_mb();					      \
 		__asm__ __volatile__(					      \
@@ -386,14 +386,14 @@ ATOMIC64_OPS(xor, ^=, xor)
  * Atomically test @v and subtract @i if @v is greater or equal than @i.
  * The function returns the old value of @v minus @i.
  */
-static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
+static __inline__ s64 atomic64_sub_if_positive(s64 i, atomic64_t * v)
 {
-	long result;
+	s64 result;
 
 	smp_mb__before_llsc();
 
 	if (kernel_uses_llsc) {
-		long temp;
+		s64 temp;
 
 		__asm__ __volatile__(
 		"	.set	push					\n"
