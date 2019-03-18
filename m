Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E8C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4549D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CJiyaqWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfCRPxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:53:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfCRPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KOI1sSR5MbmakeqqmiayCh7hafvj0XMrvXW7Klit8UU=; b=CJiyaqWBOEhOkZkCzMCYdOu02+
        7nlIKB9fMXEBOnv2Q22t9OfgIzqSWxFoawqEyglXW7RtixIm81JJrWTNRC5gCnzWi3VCemuA4kQei
        Ypa5fCKrlvUik7FME4th2l39GD+aGHu+JxA6YVx1uBQ+HVyQIOUJP36jEx9yrZEFORa4QiY47d+I/
        EaqG+655OXvYdrpP9yUyhZb7h0Q7PYV2U4XAQai9OIISzWyCVwnQ4F8rZDnoUYVd0ZyUQDSxSzKtQ
        CTKt1sR5iaRB8XbXTicm3OFaWPWOsJaSZbo+dhe3Dt5BaYELaXZZgJKKb0A5B3TlyHKqPrL4zXRQs
        zDih9rLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ7-0006iV-D1; Mon, 18 Mar 2019 15:52:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8449025E45D5F; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155140.058627431@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 02/25] tracing: Improve "if" macro code generation
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_PROFILE_ALL_BRANCHES, the "if" macro converts the
conditional to an array index.  This can cause GCC to create horrible
code.  When there are nested ifs, the generated code uses register
values to encode branching decisions.

Make it easier for GCC to optimize by keeping the conditional as a
conditional rather than converting it to an integer.  This shrinks the
generated code quite a bit, and also makes the code sane enough for
objtool to understand.

Cc: rostedt@goodmis.org
Cc: valentin.schneider@arm.com
Cc: luto@amacapital.net
Cc: brgerst@gmail.com
Cc: catalin.marinas@arm.com
Cc: mingo@kernel.org
Cc: dvlasenk@redhat.com
Cc: will.deacon@arm.com
Cc: julien.thierry@arm.com
Cc: torvalds@linux-foundation.org
Cc: dvyukov@google.com
Cc: bp@alien8.de
Cc: tglx@linutronix.de
Cc: james.morse@arm.com
Cc: luto@kernel.org
Cc: hpa@zytor.com
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190307174802.46fmpysxyo35hh43@treble
---
 include/linux/compiler.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -67,7 +67,7 @@ void ftrace_likely_update(struct ftrace_
 				.line = __LINE__,			\
 			};						\
 		______r = !!(cond);					\
-		______f.miss_hit[______r]++;					\
+		______r ? ______f.miss_hit[1]++ : ______f.miss_hit[0]++;\
 		______r;						\
 	}))
 #endif /* CONFIG_PROFILE_ALL_BRANCHES */


