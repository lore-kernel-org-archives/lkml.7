Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7B3C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3965621743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oqCGas35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbfFMPLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:11:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbfFMNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e/95LaWQsIjh/CQjR8ISIdEucc0o3duu6IK91Iv8lFA=; b=oqCGas35MVTnFD9x8QE56vHl0U
        VUV+nd1h1RwWCVWXNE0R9Rd2psoES5L3wRRUDmbc6/EYjD7n6LwmUTNmjcLpjr7Fl/4GTX8Z9Mbq9
        Ei6ResJ3Sr1TnzNm5W8WYfFMpho8j246zEGUtXZsfS3+Fo4YKV9ZDEukfN/u06NibgXUY/cBlcvqa
        NT57jkIzuZUIwziqiN/MrU3agq8Wpvx7rKubZ12SvjzQXjXiNEYq3rnxb3Sw24bzIBc90Y+47jM6e
        NR122gvgbWVf1vSRSIvv0mNtRVWPfssIujkUFt6cDl6NJU6YuxjbKNg5hayNxGVoTFNf0alezuxyD
        LdMBa8Fg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbQ80-0001Gc-2x; Thu, 13 Jun 2019 13:50:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F36F3202C9D74; Thu, 13 Jun 2019 15:50:53 +0200 (CEST)
Message-Id: <20190613134932.853419066@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Jun 2019 15:43:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        peterz@infradead.org, will.deacon@arm.com, paul.burton@mips.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: [PATCH v2 1/4] mips/atomic: Fix cmpxchg64 barriers
References: <20190613134317.734881240@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were no memory barriers on the 32bit implementation of
cmpxchg64(). Fix this.

Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/include/asm/cmpxchg.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -290,10 +290,13 @@ static inline unsigned long __cmpxchg64(
 	 * will cause a build error unless cpu_has_64bits is a		\
 	 * compile-time constant 1.					\
 	 */								\
-	if (cpu_has_64bits && kernel_uses_llsc)				\
+	if (cpu_has_64bits && kernel_uses_llsc) {			\
+		smp_mb__before_llsc();					\
 		__res = __cmpxchg64((ptr), __old, __new);		\
-	else								\
+		smp_llsc_mb();						\
+	} else {							\
 		__res = __cmpxchg64_unsupported();			\
+	}								\
 									\
 	__res;								\
 })


