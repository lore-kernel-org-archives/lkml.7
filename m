Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F81CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFC9205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfJ3RnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:43:15 -0400
Received: from foss.arm.com ([217.140.110.172]:38600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfJ3RnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:43:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BC2B1FB;
        Wed, 30 Oct 2019 10:43:14 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 425273F6C4;
        Wed, 30 Oct 2019 10:43:13 -0700 (PDT)
Date:   Wed, 30 Oct 2019 17:43:10 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191030174309.buptfbqha374efpl@e107158-lin.cambridge.arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <39c08971-5d07-8018-915b-9c6284f89d5d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39c08971-5d07-8018-915b-9c6284f89d5d@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/19 12:57, Dietmar Eggemann wrote:
> On 09.10.19 12:46, Qais Yousef wrote:
> 
> [...]
> 
> > Changes in v2:
> > 	- Use cpupri_find() to check the fitness of the task instead of
> > 	  sprinkling find_lowest_rq() with several checks of
> > 	  rt_task_fits_capacity().
> > 
> > 	  The selected implementation opted to pass the fitness function as an
> > 	  argument rather than call rt_task_fits_capacity() capacity which is
> > 	  a cleaner to keep the logical separation of the 2 modules; but it
> > 	  means the compiler has less room to optimize rt_task_fits_capacity()
> > 	  out when it's a constant value.
> 
> I would prefer exporting rt_task_fits_capacity() sched-internally via
> kernel/sched/sched.h. Less code changes and the indication whether
> rt_task_fits_capacity() has to be used in cpupri_find() is already given
> by lowest_mask being !NULL or NULL.
> 

I don't mind if the maintainers agree too. The reason I did that way is because
it keeps the implementation of cpupri generic and self contained.

rt_task_fits_capacity() at the moment is a static function in rt.c
To use it in cpupri_find() I either need to make it public somewhere or have an

	extern bool rt_task_fits_capacity(...);

in cpupri.c. Neither of which appealed to me personally.

> [...]
> 
> > +inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> > +{
> > +	unsigned int min_cap;
> > +	unsigned int max_cap;
> > +	unsigned int cpu_cap;
> 
> Nit picking. Since we discussed it already,
> 
> I found this "Also please try to aggregate variables of the same type
> into a single line. There is no point in wasting screen space::" ;-)
> 
> https://lore.kernel.org/r/20181107171149.165693799@linutronix.de

That wasn't merged at the end AFAICT :)

It's not my preferred style in this case if I have the choice - but I promise
to change it if I ended up having to spin another version anyway :)

> 
> [...]
> 
> > @@ -2223,7 +2273,10 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
> >  	 */
> >  	if (task_on_rq_queued(p) && rq->curr != p) {
> >  #ifdef CONFIG_SMP
> > -		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
> > +		bool need_to_push = rq->rt.overloaded ||
> > +				    !rt_task_fits_capacity(p, cpu_of(rq));
> > +
> > +		if (p->nr_cpus_allowed > 1 && need_to_push)
> >  			rt_queue_push_tasks(rq);
> >  #endif /* CONFIG_SMP */
> >  		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
> What happens to a always running CFS task which switches to RT? Luca
> introduced a special migrate callback (next to push and pull)
> specifically to deal with this scenario. A lot of new infrastructure for
> this one use case, but still, do we care for it in RT as well?
> 
> https://lore.kernel.org/r/20190506044836.2914-4-luca.abeni@santannapisa.it
> 

Good question. This scenario and the one where uclamp values are changed while
an RT task is running are similar.

In both cases the migration will happen on the next activation/wakeup AFAICS.

I am not sure an always running rt/deadline task is something conceivable in
practice and we want to cater for. It is certainly something we can push a fix
for in the future on top of this. IMHO we're better off trying to keep the
complexity low until we have a real scenario/use case that justifies it.

As it stands when the system is overloaded or when there are more RT tasks than
big cores we're stuffed too. And there are probably more ways where we can
shoot ourselves in the foot. Using RT and deadline is hard and that's one of
their unavoidable plagues I suppose.

Thanks

--
Qais Yousef
