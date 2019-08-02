Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7FBC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BFD2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aRUeVfro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389572AbfHBMmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:42:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfHBMl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NPQCPXvDjGrvv2bivXcGtX9P+vmLsG3oAEBjoCl8obE=; b=aRUeVfroazA+flrkU5ZsNgcCn
        0wd7LYL96qL0vjRya4G83XlluAE2aAqJyRWxeMYddeaA2O8lVlPdDB07jFpUx+0Q9X69Ok9bp6qVS
        26X7L38rv+o7FSwL5/o9bq/XGiCK7Gy6MpA9HqG/P9XGlhWYHQMCYb/FvoGhTsjPOWrWoUmcaLmQC
        dup31zIl4u6D1BIBE6cbLUmNvk0u7KNmkSSIE3ZpDoSefxRSu2s5B6d6O3oheI06TNzcI/J8SMQHM
        uXY7fsryBs/dNt4RM3blAmQMPLYEiDRQIMYjS/1b+FuOqTdVRowmYXDdyHiZBKoy8f2eATDGe1+kI
        ysZrE3R/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htWsc-00056T-0E; Fri, 02 Aug 2019 12:41:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0B11202953BA; Fri,  2 Aug 2019 14:41:51 +0200 (CEST)
Date:   Fri, 2 Aug 2019 14:41:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] Fix FIFO-99 abuse
Message-ID: <20190802124151.GG2332@hirez.programming.kicks-ass.net>
References: <20190801111348.530242235@infradead.org>
 <20190801131707.5rpyydznnhz474la@e107158-lin.cambridge.arm.com>
 <20190802093244.GF2332@hirez.programming.kicks-ass.net>
 <20190802102611.54sae3onftck5fye@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802102611.54sae3onftck5fye@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:26:12AM +0100, Qais Yousef wrote:

> Yes a somewhat enforced default makes more sense to me. I assume you no longer
> want to put the kthreads that just need to be above OTHER in FIFO-1?

I'm not sure, maybe, there's not that many of them, but possibly we add
another interface for them.

> While at it, since we will cram all kthreads on the same priority, isn't
> a SCHED_RR a better choice now? I think the probability of a clash is pretty
> low, but when it happens, shouldn't we try to guarantee some fairness?

It's never been a problem, and aside from these few straggler threads,
everybody has effectively been there already for years, so if it were a
problem someone would've complained by now.

Also; like said before, the admin had better configure.

Also also, RR-SMP is actually broken (and nobody has cared enough to
bother fixing it).
