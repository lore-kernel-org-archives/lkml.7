Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D502DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40CA2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="giZeOeKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfCNNMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:12:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59864 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfCNNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YC9Gx+HXorwzGNqBKj+TM2KVrVoaiE1QTzQwhAmO6WI=; b=giZeOeKcV1HWC5Gwd+rxs5mbq5
        CsYvYhaW7tCsyAIUOB6pKemQ1kw8M7nyY1tTgto0rS7MD2cq5HF4SyQ5DqOhHtHYssKgHkNSS6g/w
        l4Y2bu3WNGeaUWGpc55g+a8jUf6k02lffV7AjKOGu3HoJwuOlMdyot9Ir8ncnf0GVdZq3HelVc8VX
        +Nplmw/M/Wb1zXRxGwgWd7eGfmpg8WrLVWDKTPziy7GPz/W4TK+bpXktlkuztfer+lAJhVGP91OeD
        d8/M22TGOx1Zs7S0MZoi+hpvs+DmfmMxOY1el5Jlkv/ZEvhEvVwW5bm5ztr6Ph8h4Yz25l4hd0vLN
        RwgbImJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4Q8u-0005RK-Kk; Thu, 14 Mar 2019 13:11:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4898E2028B0E8; Thu, 14 Mar 2019 14:11:27 +0100 (CET)
Message-Id: <20190314130705.547793802@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Mar 2019 14:01:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, eranian@google.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, tonyj@suse.com,
        nelson.dsouza@intel.com, peterz@infradead.org
Subject: [RFC][PATCH 2/8] perf/x86/intel: Simplify intel_tfa_commit_scheduling()
References: <20190314130113.919278615@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

validate_group() calls x86_schedule_events(.assign=NULL) and therefore
will not call intel_tfa_commit_scheduling(). So there is no point in
checking cpuc->is_fake, we'll never get there.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2015,7 +2015,7 @@ static void intel_tfa_commit_scheduling(
 	/*
 	 * We're going to use PMC3, make sure TFA is set before we touch it.
 	 */
-	if (cntr == 3 && !cpuc->is_fake)
+	if (cntr == 3)
 		intel_set_tfa(cpuc, true);
 }
 


