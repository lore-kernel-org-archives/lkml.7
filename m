Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76ECC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B64208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfFQQbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:31:24 -0400
Received: from foss.arm.com ([217.140.110.172]:55768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfFQQbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:31:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BA5E28;
        Mon, 17 Jun 2019 09:31:23 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 012AF3F718;
        Mon, 17 Jun 2019 09:31:21 -0700 (PDT)
Date:   Mon, 17 Jun 2019 17:31:19 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 5/6] sched: Add sched_overutilized tracepoint
Message-ID: <20190617163119.iawzbpc4pgsoljme@e107158-lin.cambridge.arm.com>
References: <20190604111459.2862-1-qais.yousef@arm.com>
 <20190604111459.2862-6-qais.yousef@arm.com>
 <20190617155010.GH3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190617155010.GH3436@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/17/19 17:50, Peter Zijlstra wrote:
> On Tue, Jun 04, 2019 at 12:14:58PM +0100, Qais Yousef wrote:
> > The new tracepoint allows us to track the changes in overutilized
> > status.
> > 
> > Overutilized status is associated with EAS. It indicates that the system
> > is in high performance state. EAS is disabled when the system is in this
> > state since there's not much energy savings while high performance tasks
> > are pushing the system to the limit and it's better to default to the
> > spreading behavior of the scheduler.
> > 
> > This tracepoint helps understanding and debugging the conditions under
> > which this happens.
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> >  include/trace/events/sched.h |  4 ++++
> >  kernel/sched/fair.c          | 11 +++++++++--
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index c7dd9bc7f001..edd96e04049f 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -621,6 +621,10 @@ DECLARE_TRACE(pelt_se_tp,
> >  	TP_PROTO(struct sched_entity *se),
> >  	TP_ARGS(se));
> >  
> > +DECLARE_TRACE(sched_overutilized_tp,
> > +	TP_PROTO(int overutilized, struct root_domain *rd),
> > +	TP_ARGS(overutilized, rd));
> > +
> 
> strictly speaking you only need @rd :-)

Yes. Sorry my brain was hardwired this is overutilized event so we need to
pass this info :-)

> 
> >  #endif /* _TRACE_SCHED_H */
> >  
> >  /* This part must be outside protection */
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8e0015ebf109..e2418741608e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5179,8 +5179,10 @@ static inline bool cpu_overutilized(int cpu)
> >  
> >  static inline void update_overutilized_status(struct rq *rq)
> >  {
> > -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> > +	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
> >  		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> > +		trace_sched_overutilized_tp(1, rq->rd);
> > +	}
> >  }
> >  #else
> >  static inline void update_overutilized_status(struct rq *rq) { }
> > @@ -8542,8 +8544,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  
> >  		/* Update over-utilization (tipping point, U >= 0) indicator */
> >  		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
> > +
> > +		trace_sched_overutilized_tp(!!(sg_status & SG_OVERUTILIZED), rd);
> >  	} else if (sg_status & SG_OVERUTILIZED) {
> > -		WRITE_ONCE(env->dst_rq->rd->overutilized, SG_OVERUTILIZED);
> > +		struct root_domain *rd = env->dst_rq->rd;
> > +
> > +		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> > +		trace_sched_overutilized_tp(1, rd);
> >  	}
> >  }
> 
> But I figure since we need both values anyway, this isn't too much of a
> bother.
> 
> I'm going to flip the argument order though.

Sounds good to me. The good news is that changing the signature should be
doable in the future if we felt the need to evolve it :-)

Thanks

--
Qais Yousef
