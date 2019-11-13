Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C5EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F172196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rliVUmAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfKMJhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:37:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMJhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qSG9uSaAn7qofE50Yn5j5jsLtO131S+8AtBXIrCvYT4=; b=rliVUmAZLX+u0ixJ/WjtceIH2
        z7YMtymyk/RzzWYXW5gOS7qQc6K1ozrKI5frsTTYmz2vYsMErYlGm0AMFF5ueeS3cfdqdwI6vPIv/
        fHft0w8ZCCX9x0u/3wbTgJo1o6TXjwsZpRgoYEmpF+UhhoiU/XXt9cAmLh5nMkxcV2b/QADR8U729
        msrz7Vh0AyD+nLcqPX5tKVLgOa3RIZazF4cTdb17fK6+tvSmezzDn6c8HnuwrW6NgzwaUCqYyM5uI
        ACyFE2ovh5fAbrXVxNsGAl8IHaUYqya/xCYjU68+aHhoXfDLCKMB09nJ+VjSzbdKw3x8vTOVlrLFF
        VIq1+NoTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUp52-0005Wr-Mo; Wed, 13 Nov 2019 09:36:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1FE4305DE2;
        Wed, 13 Nov 2019 10:35:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4D5A20302F11; Wed, 13 Nov 2019 10:36:49 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:36:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, glenn@aurora.tech, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, tglx@linutronix.de,
        luca.abeni@santannapisa.it, c.scordino@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com
Subject: Re: [PATCH 2/2] sched/deadline: Temporary copy static parameters to
 boosted non-DEADLINE entities
Message-ID: <20191113093649.GI4131@hirez.programming.kicks-ass.net>
References: <20191112075056.19971-1-juri.lelli@redhat.com>
 <20191112075056.19971-3-juri.lelli@redhat.com>
 <20191112105130.GZ4131@hirez.programming.kicks-ass.net>
 <20191113092241.GB29273@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113092241.GB29273@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:22:41AM +0100, Juri Lelli wrote:

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 26e4ffa01e7a..16164b0ba80b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4452,9 +4452,11 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
> >  		if (!dl_prio(p->normal_prio) ||
> >  		    (pi_task && dl_entity_preempt(&pi_task->dl, &p->dl))) {
> >  			p->dl.dl_boosted = 1;
> > -			queue_flag |= ENQUEUE_REPLENISH;
> > -		} else
> > +			p->dl.deadline = pi_task->dl.deadline;
> > +		} else {
> >  			p->dl.dl_boosted = 0;
> > +			p->dl.deadline = p->dl.normal_deadline;
> > +		}
> >  		p->sched_class = &dl_sched_class;
> >  	} else if (rt_prio(prio)) {
> >  		if (dl_prio(oldprio))

> So, the problem is more related to pi_se->dl_runtime than its deadline.
> Even if we don't replenish at the instant in time when boosting happens,
> the boosted task might still deplete its runtime while being boosted and

I thought we ignored all runtime checks when we were boosted? Yes, that
is all sorts of broken, but IIRC we figured that barring something like
proxy-execution there really wasn't anything sane we could do wrt
bandwidth anyway.

Seeing how proper bandwidth handling would have the boosted task consume
the boostee's budget etc.. And blocking the entire boost chain when it
collectively runs out.
