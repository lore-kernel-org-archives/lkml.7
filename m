Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE62FC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B3F208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfEMMmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:42:36 -0400
Received: from foss.arm.com ([217.140.101.70]:54934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbfEMMme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:42:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D98380D;
        Mon, 13 May 2019 05:42:33 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3B4F3F6C4;
        Mon, 13 May 2019 05:42:31 -0700 (PDT)
Date:   Mon, 13 May 2019 13:42:29 +0100
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
Subject: Re: [PATCH v2 6/7] sched: Add sched_overutilized tracepoint
Message-ID: <20190513124228.a2imudj6ji3khnfg@e107158-lin.cambridge.arm.com>
References: <20190510113013.1193-1-qais.yousef@arm.com>
 <20190510113013.1193-7-qais.yousef@arm.com>
 <20190513120830.GS2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190513120830.GS2623@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/19 14:08, Peter Zijlstra wrote:
> On Fri, May 10, 2019 at 12:30:12PM +0100, Qais Yousef wrote:
> 
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index cbcb47972232..0cf42d13d6c4 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -600,6 +600,10 @@ DECLARE_TRACE(pelt_se,
> >  	TP_PROTO(int cpu, const char *path, struct sched_entity *se),
> >  	TP_ARGS(cpu, path, se));
> >  
> > +DECLARE_TRACE(sched_overutilized,
> > +	TP_PROTO(int overutilized),
> > +	TP_ARGS(overutilized));
> > +
> >  #endif /* _TRACE_SCHED_H */
> >  
> >  /* This part must be outside protection */
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 81036c34fd29..494032220fe7 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4965,8 +4965,10 @@ static inline bool cpu_overutilized(int cpu)
> >  
> >  static inline void update_overutilized_status(struct rq *rq)
> >  {
> > -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> > +	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
> >  		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> > +		trace_sched_overutilized(1);
> > +	}
> >  }
> >  #else
> >  static inline void update_overutilized_status(struct rq *rq) { }
> > @@ -8330,8 +8332,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  
> >  		/* Update over-utilization (tipping point, U >= 0) indicator */
> >  		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
> > +
> > +		trace_sched_overutilized(!!(sg_status & SG_OVERUTILIZED));
> >  	} else if (sg_status & SG_OVERUTILIZED) {
> >  		WRITE_ONCE(env->dst_rq->rd->overutilized, SG_OVERUTILIZED);
> > +		trace_sched_overutilized(1);
> >  	}
> >  }
> 
> Note how the state is per root domain and the tracepoint doesn't
> communicate that.

Right! I can pass rd->span so that the probing function can use it to
differentiate the root domains if they care?

--
Qais Yousef
