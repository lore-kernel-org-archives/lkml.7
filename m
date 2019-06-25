Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF18EC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4442133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XIsccSIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfFYOZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:25:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58754 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfFYOZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QDHFsnBEJgM8MOF6BpnZs2ZdPuoYpXec9QhmGQ19BZw=; b=XIsccSIXyFHkR2444O904+knJF
        MiXgca8G+E89SpvaA8rOnAhwY/vDKNQctjBfoWzsLcJlFLlgy1rHMKOoqzEe5nm/F+qXHIjGXeTrh
        XDEuJAvYYp19m9Cbek5CbT8rkccWLCgCmRPI3lqYHwbhB4joVpHT7omJrmwCKqotaLGi+21I3GZIr
        vJX0j6DJ8Uo/mgYDYoBLtH8Ahl3zNdMuno2pWCcgTx2YCnW8hTCr9+o7KYfHFTOK9S1H0sBYAkd75
        hVDfRPJwWhr3DcrT1L7suTCwbENz2FuytcXS4o+c+JybOrKJkaLxQQ5Zo/VNU9AGKfLMl7bWKWaZw
        XQC83BNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfmNh-0001rE-9P; Tue, 25 Jun 2019 14:25:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A518209FD684; Tue, 25 Jun 2019 16:25:08 +0200 (CEST)
Date:   Tue, 25 Jun 2019 16:25:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: silence a warning in sched_init()
Message-ID: <20190625142508.GE3419@hirez.programming.kicks-ass.net>
References: <1561466662-22314-1-git-send-email-cai@lca.pw>
 <20190625135238.GA3419@hirez.programming.kicks-ass.net>
 <1561471459.5154.70.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561471459.5154.70.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:04:19AM -0400, Qian Cai wrote:
> On Tue, 2019-06-25 at 15:52 +0200, Peter Zijlstra wrote:

> Yes, -Wmissing-prototype makes no sense, but "-Wunused-but-set-variable" is
> pretty valid to catch certain developer errors. For example,
> 
> https://lists.linuxfoundation.org/pipermail/iommu/2019-May/035680.html
> 
> > 
> > As to this one, ideally the compiler would not be stupid, and understand
> > the below, but alas.
> 
> Pretty sure that won't work, as the compiler will complain something like,
> 
> ISO C90 forbids mixed declarations and code

No, it builds just fine, it's a new block and C allows new variables at
every block start -- with the scope of that block.

And for our config, alloc_size is an unconditional 0, so it should DCE
the whole block and with that our variable. But clearly the passes are
the other way around :/

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index fa43ce3962e7..cb652e165570 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6369,7 +6369,7 @@ DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
> >  
> >  void __init sched_init(void)
> >  {
> > -	unsigned long alloc_size = 0, ptr;
> > +	unsigned long alloc_size = 0;
> >  	int i;
> >  
> >  	wait_bit_init();
> > @@ -6381,7 +6381,7 @@ void __init sched_init(void)
> >  	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
> >  #endif
> >  	if (alloc_size) {
> > -		ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
> > +		unsigned long ptr = (unsigned long)kzalloc(alloc_size,
> > GFP_NOWAIT);
> >  
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >  		root_task_group.se = (struct sched_entity **)ptr;
