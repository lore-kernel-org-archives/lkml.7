Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3618AECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A45520815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YLeNdJ2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388595AbfJANog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:44:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33070 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJANof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2m24KAnnZ5y5sVgG4gm6joH2usJLTNvqw2r0eLXmqA8=; b=YLeNdJ2/KlYqexp/AFMUaoUJM
        etxHpft9okaRwQ7rJwh7yH58Cdfw3mL0t1siWVBFIJVwnAcNclRu7YMtDW7GOkgZ9Yiwc2Tdu7ITa
        1aKlf1Kj4LET0p2ZW0bcgwCNL3ekAN4wKpvrYXos7JzSJniWF26OmDK+HOfNdoDHliejHSNu+O5m8
        3yROoJrKjjADnCXqko3ifqDQVnV6jUeYkIQoJafTJV4j3E+8U5Uw6Vp039pKJC2MLBdqHzbyFr2oq
        wO1yNVxkLRvxv4CdbMzIcsB9GSBy/qQtpogr9pTDDbwFfCcOX7ocLO5whK2fnUI5b20ttNNEbBYJd
        IP3cxdgWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFIRp-0008Cn-6O; Tue, 01 Oct 2019 13:44:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F29FB305E4E;
        Tue,  1 Oct 2019 15:43:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 643C629CCFDD4; Tue,  1 Oct 2019 15:44:10 +0200 (CEST)
Date:   Tue, 1 Oct 2019 15:44:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        bigeasy@linutronix.de, tglx@linutronix.de, thgarnie@google.com,
        tytso@mit.edu, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, mingo@redhat.com, will@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH] sched: Avoid spurious lock dependencies
Message-ID: <20191001134410.GL4536@hirez.programming.kicks-ass.net>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
 <20190925093153.GC4553@hirez.programming.kicks-ass.net>
 <1569424727.5576.221.camel@lca.pw>
 <20190925164527.GG4553@hirez.programming.kicks-ass.net>
 <1569500974.5576.234.camel@lca.pw>
 <20191001091837.GK4536@hirez.programming.kicks-ass.net>
 <20191001113513.GB32306@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001113513.GB32306@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 05:06:56PM +0530, Srikar Dronamraju wrote:
> > Subject: sched: Avoid spurious lock dependencies
> > 
> > While seemingly harmless, __sched_fork() does hrtimer_init(), which,
> > when DEBUG_OBJETS, can end up doing allocations.
> > 
> 
> NIT: s/DEBUG_OBJETS/DEBUG_OBJECTS
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 7880f4f64d0e..1832fc0fbec5 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6039,10 +6039,11 @@ void init_idle(struct task_struct *idle, int cpu)
> >  	struct rq *rq = cpu_rq(cpu);
> >  	unsigned long flags;
> >  
> > +	__sched_fork(0, idle);
> > +
> >  	raw_spin_lock_irqsave(&idle->pi_lock, flags);
> >  	raw_spin_lock(&rq->lock);
> >  
> > -	__sched_fork(0, idle);
> >  	idle->state = TASK_RUNNING;
> >  	idle->se.exec_start = sched_clock();
> >  	idle->flags |= PF_IDLE;
> > 
> 
> Given that there is a comment just after this which says
> "init_task() gets called multiple times on a task",
> should we add a check if rq->idle is present and bail out?
> 
> if (rq->idle) {
>     raw_spin_unlock(&rq->lock);
>     raw_spin_unlock_irqrestore(&idle->pi_lock, flags);
>     return;
> }

Not really worth it; the best solution is to fix the callchains leading
up to it. It's all hotplug related IIRC and so it's slow anyway.

> Also can we also move the above 3 statements before the lock?

Probably, but to what effect?
