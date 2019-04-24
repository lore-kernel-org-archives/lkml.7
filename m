Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C3FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DE4218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SgWlqO5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfDXMr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:47:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfDXMr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4jO50iyN8dkpVMhN4IYEHBPaWTQRszhub+XoHAHWzRk=; b=SgWlqO5Q5qH3FyrSLzh8JGGk2H
        BQ2tBlnO+0pSn+nO2jbF5FTR5Om55ckXZE49Gp/CjP5PeGqy4+wWB2oSTQ9AARPio30H6S/1wwqj8
        Q8dyWWoBZ6IGzS4RYoigVdU60OBrZqgijjinmgxih9WKeOCELzlj2g+C8ZG92ZhSdHQsYlCi6wa7E
        wYJvXccrpBWwmrFISe8yTioI/GXztShjeF4ZfeMbdLnwPKNTtBlLj1ZuUwdopZy4htgD4ox9J+mKT
        KnvQHIWVHUd5DQdrkMqRu4h7UzHpjhR/FO3cDkCsOhLSswKQvvLsSmN3+7xggpdnxFyh6jcBwviZv
        c8QWMEsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJHJR-0006O6-Kz; Wed, 24 Apr 2019 12:47:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6558A203895C8; Wed, 24 Apr 2019 14:47:43 +0200 (CEST)
Message-Id: <20190424124421.579563933@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 24 Apr 2019 14:36:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        peterz@infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Paul Burton <paul.burton@mips.com>
Subject: [RFC][PATCH 1/5] mips/atomic: Fix cmpxchg64 barriers
References: <20190424123656.484227701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were no memory barriers on cmpxchg64() _at_all_. Fix this.

Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/include/asm/cmpxchg.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -290,9 +290,11 @@ static inline unsigned long __cmpxchg64(
 	 * will cause a build error unless cpu_has_64bits is a		\
 	 * compile-time constant 1.					\
 	 */								\
-	if (cpu_has_64bits && kernel_uses_llsc)				\
+	if (cpu_has_64bits && kernel_uses_llsc) {			\
+		smp_mb__before_llsc();					\
 		__res = __cmpxchg64((ptr), __old, __new);		\
-	else								\
+		smp_llsc_mb();						\
+	} else								\
 		__res = __cmpxchg64_unsupported();			\
 									\
 	__res;								\


