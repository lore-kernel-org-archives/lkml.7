Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3DDC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA03325CF7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LQahd2Da"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfFCNnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:43:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55645 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfFCNnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:43:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DhH8i612324
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:43:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DhH8i612324
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569398;
        bh=YGtaM+V3pbGIkGEIPGitEElsGDkhauWGMuFfH+iKewk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LQahd2DaQTxLSMgbPGsY5h0mTGQechgxn35WPKb0+9B8Ok4U7vsFh5qHgNlzU/6G3
         ze0ZAkf5z6tWLMgg/dBtGcoHkP41CyxYDXoLqXLH3aKRB9XQYYyadexXSRy63Bj2ff
         vd4gA/Wv4T8GxMLjNaBsyoEnqjr9oTjPJMiaagGUjQMG62o+XO1GR5NpXEej4BvxEd
         ya6nWBghVGgQCh/9RRsR3dnxSOkp/jROj02kZBddtbKuUMAyIzxRRDjBkFQ+/OYgdq
         Fm/fsUn4i+JOLTvoY/+5Z/2ZnPcvP4kaxGmUV0YgFeEfGKPO2N4bwjv2503zJCg5+H
         c+0+uB8DhUykg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DhHm8612321;
        Mon, 3 Jun 2019 06:43:17 -0700
Date:   Mon, 3 Jun 2019 06:43:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-04e8851af767153c0878cc79ce30c0d8806eec43@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        will.deacon@arm.com, mark.rutland@arm.com
Reply-To: will.deacon@arm.com, mark.rutland@arm.com, davem@davemloft.net,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          hpa@zytor.com
In-Reply-To: <20190522132250.26499-15-mark.rutland@arm.com>
References: <20190522132250.26499-15-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, sparc: Use s64 for atomic64
Git-Commit-ID: 04e8851af767153c0878cc79ce30c0d8806eec43
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

Commit-ID:  04e8851af767153c0878cc79ce30c0d8806eec43
Gitweb:     https://git.kernel.org/tip/04e8851af767153c0878cc79ce30c0d8806eec43
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:46 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, sparc: Use s64 for atomic64

As a step towards making the atomic64 API use consistent types treewide,
let's have the sparc atomic64 implementation use s64 as the underlying
type for atomic64_t, rather than long, matching the generated headers.

As atomic64_read() depends on the generic defintion of atomic64_t, this
still returns long. This will be converted in a subsequent patch.

Otherwise, there should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aou@eecs.berkeley.edu
Cc: arnd@arndb.de
Cc: bp@alien8.de
Cc: catalin.marinas@arm.com
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
Link: https://lkml.kernel.org/r/20190522132250.26499-15-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/sparc/include/asm/atomic_64.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index 6963482c81d8..b60448397d4f 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -23,15 +23,15 @@
 
 #define ATOMIC_OP(op)							\
 void atomic_##op(int, atomic_t *);					\
-void atomic64_##op(long, atomic64_t *);
+void atomic64_##op(s64, atomic64_t *);
 
 #define ATOMIC_OP_RETURN(op)						\
 int atomic_##op##_return(int, atomic_t *);				\
-long atomic64_##op##_return(long, atomic64_t *);
+s64 atomic64_##op##_return(s64, atomic64_t *);
 
 #define ATOMIC_FETCH_OP(op)						\
 int atomic_fetch_##op(int, atomic_t *);					\
-long atomic64_fetch_##op(long, atomic64_t *);
+s64 atomic64_fetch_##op(s64, atomic64_t *);
 
 #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(op)
 
@@ -61,7 +61,7 @@ static inline int atomic_xchg(atomic_t *v, int new)
 	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
-long atomic64_dec_if_positive(atomic64_t *v);
+s64 atomic64_dec_if_positive(atomic64_t *v);
 #define atomic64_dec_if_positive atomic64_dec_if_positive
 
 #endif /* !(__ARCH_SPARC64_ATOMIC__) */
