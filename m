Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518222184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wt5uLC8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbfB1PFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:05:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfB1PFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RU2d1ob/JIs4GVG9mvliFQ/ZOQlLqtQdpEyhadDL6NQ=; b=Wt5uLC8+PhwFdCU4Ja8Ge+EbOD
        DaxGqLReHMBhOTWChXqH2DFJ8OUvG03Vco4ArceOwFs4746LIr6k8RK7Fz7oBtj0uCjRmwU/OLvhn
        hWLgoxNUVj06mJvB2u3fxihGSWbgEJpCEfSCxu4crJDOba1g6hyjNBgbm31W1Ef8yHECAMqcW5BYL
        HjTekaJJVjz8z3fgZvIowwHAaZWz7zc9iPVTLTnW0h7GZ0zZh1qJ/TjSnNjPoZEPpOR66FFSCPEZI
        5+FOaQzr4oAO6M2ccj20Dc0joS1F7GChCoDgvWpe8jD+qW4+kxGkhE8Wi5lyhYrmBFizwDvt20OM6
        5R6kAcHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzNFH-0002NJ-BD; Thu, 28 Feb 2019 15:05:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CDB6A202C2DA9; Thu, 28 Feb 2019 16:05:08 +0100 (CET)
Message-Id: <20190228150152.261568194@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 28 Feb 2019 15:54:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 3/8] objtool: Set insn->func for alternatives
References: <20190228145450.289603901@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure we set the function association for alternative function
sequences; they are after all still part of the function.

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


