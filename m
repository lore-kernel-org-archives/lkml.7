Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC86C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D52C208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfEMMsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:48:35 -0400
Received: from foss.arm.com ([217.140.101.70]:55122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbfEMMse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:48:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41CE180D;
        Mon, 13 May 2019 05:48:34 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 984B33F6C4;
        Mon, 13 May 2019 05:48:32 -0700 (PDT)
Date:   Mon, 13 May 2019 13:48:29 +0100
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
Subject: Re: [PATCH v2 4/7] sched: Add pelt_rq tracepoint
Message-ID: <20190513124829.aybnwdh74bsm7ugv@e107158-lin.cambridge.arm.com>
References: <20190510113013.1193-1-qais.yousef@arm.com>
 <20190510113013.1193-5-qais.yousef@arm.com>
 <20190513121445.GT2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190513121445.GT2623@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/19 14:14, Peter Zijlstra wrote:
> On Fri, May 10, 2019 at 12:30:10PM +0100, Qais Yousef wrote:
> 
> > +DECLARE_TRACE(pelt_rq,
> > +	TP_PROTO(int cpu, const char *path, struct sched_avg *avg),
> > +	TP_ARGS(cpu, path, avg));
> > +
> 
> > +static __always_inline void sched_trace_pelt_cfs_rq(struct cfs_rq *cfs_rq)
> > +{
> > +	if (trace_pelt_rq_enabled()) {
> > +		int cpu = cpu_of(rq_of(cfs_rq));
> > +		char path[SCHED_TP_PATH_LEN];
> > +
> > +		cfs_rq_tg_path(cfs_rq, path, SCHED_TP_PATH_LEN);
> > +		trace_pelt_rq(cpu, path, &cfs_rq->avg);
> > +	}
> > +}
> > +
> > +static __always_inline void sched_trace_pelt_rt_rq(struct rq *rq)
> > +{
> > +	if (trace_pelt_rq_enabled()) {
> > +		int cpu = cpu_of(rq);
> > +
> > +		trace_pelt_rq(cpu, NULL, &rq->avg_rt);
> > +	}
> > +}
> > +
> > +static __always_inline void sched_trace_pelt_dl_rq(struct rq *rq)
> > +{
> > +	if (trace_pelt_rq_enabled()) {
> > +		int cpu = cpu_of(rq);
> > +
> > +		trace_pelt_rq(cpu, NULL, &rq->avg_dl);
> > +	}
> > +}
> 
> Since it is only the one real tracepoint, how do we know which avg is
> which?

Good question. I missed that to be honest since we are mainly interested in cfs
and I was focused into not adding too many tracepoints..

I'm happy to create a tracepoint per class assuming that's what you're
suggesting.

Thanks

--
Qais Yousef
