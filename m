Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54057C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23112218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lRSwhxnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfDXMsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:48:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfDXMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lAnnFjObmRAZCEWLYKe9gxDuF6UP5+CYMl2OsiAC6yc=; b=lRSwhxnmzf52ZyVInfl7VNyxHl
        /jYh/am2pAzBuw454Pda6P+BPcXxubFL8bYSu24CwIKe2WpXqrC+BLrS3D1oWezD9WnQ94TdzWSdn
        /Zu8St/g3ss5AmYXBqjFOfsKiRo0PrBResh55EHsO7AZ6XsdjJeOwFrgPtgSwfEqrvne7yVw/Qp9e
        9osQjky1km1d8aITvqZNEJnJ1XhRp1LwALPAPGdojeRHXbmSq4V8O9N5B4EJFopkIJlJbHj71pEHE
        r/Y1N21GIs97bMpH/7k486ob5xDJZKJ67RrfKp5Eqb4pOjg3tTrKDWoXjZAAqPgRRu1RUdMFkkyG5
        AwwvowiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJHJR-0006O5-LI; Wed, 24 Apr 2019 12:47:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6D4ED203BFD62; Wed, 24 Apr 2019 14:47:43 +0200 (CEST)
Message-Id: <20190424124421.693353463@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 24 Apr 2019 14:36:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        peterz@infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Huacai Chen <chenhc@lemote.com>,
        Huang Pei <huangpei@loongson.cn>,
        Paul Burton <paul.burton@mips.com>
Subject: [RFC][PATCH 3/5] mips/atomic: Optimize loongson3_llsc_mb()
References: <20190424123656.484227701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that every single LL/SC loop has loongson_llsc_mb() in front, we
can NO-OP smp_mb__before_llsc() in that case.

While there, remove the superfluous __smp_mb__before_llsc().

Cc: Huacai Chen <chenhc@lemote.com>
Cc: Huang Pei <huangpei@loongson.cn>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/include/asm/barrier.h |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -221,15 +221,12 @@
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #define smp_mb__before_llsc() smp_wmb()
-#define __smp_mb__before_llsc() __smp_wmb()
 /* Cause previous writes to become visible on all CPUs as soon as possible */
 #define nudge_writes() __asm__ __volatile__(".set push\n\t"		\
 					    ".set arch=octeon\n\t"	\
 					    "syncw\n\t"			\
 					    ".set pop" : : : "memory")
 #else
-#define smp_mb__before_llsc() smp_llsc_mb()
-#define __smp_mb__before_llsc() smp_llsc_mb()
 #define nudge_writes() mb()
 #endif
 
@@ -264,11 +261,19 @@
  *    This case affects all current Loongson 3 CPUs.
  */
 #ifdef CONFIG_CPU_LOONGSON3_WORKAROUNDS /* Loongson-3's LLSC workaround */
+#define smp_mb__before_llsc()	do { } while (0)
 #define loongson_llsc_mb()	__asm__ __volatile__("sync" : : :"memory")
 #else
 #define loongson_llsc_mb()	do { } while (0)
 #endif
 
+#ifndef smp_mb__before_llsc
+#define smp_mb__before_llsc() smp_llsc_mb()
+#endif
+
+#define __smp_mb__before_atomic()	smp_mb__before_llsc()
+#define __smp_mb__after_atomic()	smp_llsc_mb()
+
 static inline void sync_ginv(void)
 {
 	asm volatile("sync\t%0" :: "i"(STYPE_GINV));


