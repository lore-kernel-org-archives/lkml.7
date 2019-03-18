Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF99C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB3820880
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PNuXXzun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfCRPyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:54:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfCRPw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hILVPKkKZIvpibHHGc3bEDAftLKRwBtgTKxm8PBDw3M=; b=PNuXXzun6iWNLDlKnitXbknvrr
        A0poRNz7LV9bQPUHlBwczBH+1KXMorUZYepKZSjtT4tqWpyKphn0kIw6FoqIAmk/OIxRQRK9RVtGh
        MAkx2qpPH1cF4phw0ThDNUpE4o4cJQpw8aXqrzV2DUoQ/qFusNU9diHJyRZV7bu9HkkoHznRU4+oW
        w6QUzziKL6cf7AwYfGxHi9Msmw6DQB68Po8H626iO+oxAiJqHHyjzE3GRagn9TFW3aPNUD1pGSYe6
        tX566bwx8lJaoufTMH27qzheZRvZgHApdd8bZqspyR9JPM3aNUjNNoTW49ONa2lPxpWTJ11Lap89H
        +FEq6KKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ9-0006n4-EH; Mon, 18 Mar 2019 15:52:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D56CC25E45D7D; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155141.469286375@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 17/25] objtool: Set insn->func for alternatives
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of function attributes, we need each instruction to
have a valid link back to its function.

Therefore make sure we set the function association for alternative
instruction sequences; they are, after all, still part of the function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -695,6 +695,7 @@ static int handle_group_alt(struct objto
 		last_new_insn = insn;
 
 		insn->ignore = orig_insn->ignore_alts;
+		insn->func = orig_insn->func;
 
 		if (insn->type != INSN_JUMP_CONDITIONAL &&
 		    insn->type != INSN_JUMP_UNCONDITIONAL)


