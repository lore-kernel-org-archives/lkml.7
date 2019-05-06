Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550E0C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3102C2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfEFPFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:05:50 -0400
Received: from foss.arm.com ([217.140.101.70]:52592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfEFOiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:38:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A8ACA78;
        Mon,  6 May 2019 07:38:16 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12D6A3F575;
        Mon,  6 May 2019 07:38:14 -0700 (PDT)
Date:   Mon, 6 May 2019 15:38:12 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] sched: Add sched_load_rq tracepoint
Message-ID: <20190506143811.tvvvguz3erptdb3k@e107158-lin.cambridge.arm.com>
References: <20190505115732.9844-1-qais.yousef@arm.com>
 <20190505115732.9844-5-qais.yousef@arm.com>
 <20190506090859.GK2606@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506090859.GK2606@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/19 11:08, Peter Zijlstra wrote:
> On Sun, May 05, 2019 at 12:57:29PM +0100, Qais Yousef wrote:
> 
> > +/*
> > + * Following tracepoints are not exported in tracefs and provide hooking
> > + * mechanisms only for testing and debugging purposes.
> > + */
> > +DECLARE_TRACE(sched_load_rq,
> > +	TP_PROTO(int cpu, const char *path, struct sched_avg *avg),
> > +	TP_ARGS(cpu, path, avg));
> > +
> 
> > +DECLARE_TRACE(sched_load_se,
> > +       TP_PROTO(int cpu, const char *path, struct sched_entity *se),
> > +       TP_ARGS(cpu, path, se));
> > +
> 
> > +DECLARE_TRACE(sched_overutilized,
> > +       TP_PROTO(int overutilized),
> > +       TP_ARGS(overutilized));
> 
> This doesn't generate any actual userspace because of the lack of
> DEFINE_EVENT() ?

Documentation/trace/tracepoints.rst suggests using DEFINE_TRACE(). But using
that causes compilation errors because of some magic that is being redefined.
Not doing DEFINE_TRACE() gave the intended effect according to the document, so
I assumed it's outdated.


kernel/sched/core.c:27:1: note: in expansion of macro ‘DEFINE_TRACE’
 DEFINE_TRACE(sched_overutilized);
 ^~~~~~~~~~~~
./include/linux/tracepoint.h:287:20: note: previous definition of ‘__tracepoint_sched_overutilized’ was here
  struct tracepoint __tracepoint_##name     \
                    ^
./include/linux/tracepoint.h:293:2: note: in expansion of macro ‘DEFINE_TRACE_FN’
  DEFINE_TRACE_FN(name, NULL, NULL);
  ^~~~~~~~~~~~~~~
./include/trace/define_trace.h:67:2: note: in expansion of macro ‘DEFINE_TRACE’
  DEFINE_TRACE(name)
  ^~~~~~~~~~~~
./include/trace/events/sched.h:603:1: note: in expansion of macro ‘DECLARE_TRACE’
 DECLARE_TRACE(sched_overutilized,
 ^~~~~~~~~~~~~


DEFINE_EVENT() is only used with TRACE_EVENT() so certainly we don't want it
here.

> 
> > diff --git a/kernel/sched/sched_tracepoints.h b/kernel/sched/sched_tracepoints.h
> > new file mode 100644
> > index 000000000000..f4ded705118e
> > --- /dev/null
> > +++ b/kernel/sched/sched_tracepoints.h
> > @@ -0,0 +1,39 @@
> 
> Like with the other newly introduced header files, this one is lacking
> the normal include guard.

I was going to add them but then when I looked in sched.h and autogroup.h they
had none. So I thought the convention is to not use guard here.

I will add it.

> 
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Scheduler tracepoints that are probe-able only and aren't exported ABI in
> > + * tracefs.
> > + */
> > +
> > +#include <trace/events/sched.h>
> > +
> > +#define SCHED_TP_PATH_LEN		64
> > +
> > +
> > +static __always_inline void sched_tp_load_cfs_rq(struct cfs_rq *cfs_rq)
> > +{
> > +	if (trace_sched_load_rq_enabled()) {
> > +		int cpu = cpu_of(rq_of(cfs_rq));
> > +		char path[SCHED_TP_PATH_LEN];
> > +
> > +		cfs_rq_tg_path(cfs_rq, path, SCHED_TP_PATH_LEN);
> > +		trace_sched_load_rq(cpu, path, &cfs_rq->avg);
> > +	}
> > +}
> > +
> > +static __always_inline void sched_tp_load_rt_rq(struct rq *rq)
> > +{
> > +	if (trace_sched_load_rq_enabled()) {
> > +		int cpu = cpu_of(rq);
> > +
> > +		trace_sched_load_rq(cpu, NULL, &rq->avg_rt);
> > +	}
> > +}
> > +
> > +static __always_inline void sched_tp_load_dl_rq(struct rq *rq)
> > +{
> > +	if (trace_sched_load_rq_enabled()) {
> > +		int cpu = cpu_of(rq);
> > +
> > +		trace_sched_load_rq(cpu, NULL, &rq->avg_dl);
> > +	}
> > +}
> 
> > +static __always_inline void sched_tp_load_se(struct sched_entity *se)
> > +{
> > +       if (trace_sched_load_se_enabled()) {
> > +               struct cfs_rq *gcfs_rq = group_cfs_rq(se);
> > +               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > +               char path[SCHED_TP_PATH_LEN];
> > +               int cpu = cpu_of(rq_of(cfs_rq));
> > +
> > +               cfs_rq_tg_path(gcfs_rq, path, SCHED_TP_PATH_LEN);
> > +               trace_sched_load_se(cpu, path, se);
> > +       }
> > +}
> 
> These functions really should be called trace_*()

I can rename the wrappers to trace_pelt_load_rq() or sched_trace_pelt_load_rq()
as Steve was suggesting.

I assume you're okay with the name of the tracepoints and your comment was
about the wrapper above only? ie: sched_load_rq vs pelt_rq.

> 
> Also; I _really_ hate how fat they are. Why can't we do simple straight

We can create a percpu variable instead of pushing the path on the stack. But
this might fail if the trancepoint is called in a preempt enabled path. Also
having the percpu variable always hanging when these mostly disabled is ugly.

Maybe there's a better way to handle extracting this path info without copying
it here. Let me see if I can improve on this.

> forward things like:
> 
> 	trace_pelt_cfq(cfq);
> 	trace_pelt_rq(rq);
> 	trace_pelt_se(se);
> 
> And then have the thing attached to the event do the fat bits like
> extract the path and whatnot.

Thanks

--
Qais Yousef
