Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C92AC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A3A2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dhi6pPP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEFJJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:09:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52710 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFJJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YyrAjxgQ6wZlNZ+nR1R9DcRAUSs/j51oPpwN+AtbQYw=; b=Dhi6pPP5I7t80yBo+iaCaym9z
        /NW9/6sN20rgT1Ffx6kaertv1hD4m20HL5CV2/42soS7neypQffC6KLCV8ol6yuR+nuNU48RV3LmV
        Yb5OhS0sfs20evHJvlEnQGiNSEolffLruW7zwq4t11o/F24vaiD3DalSkNHJ5vZ5VGKGOh+3RugM6
        Xcz3sMN6hnCYz32aEbydmn8bTOg0/nVC8ZQCB0eB8AgNxHI3uQD+weYqOjOLMKfONQJ5SdercZR7P
        YTmmwWpTrBuBLH9tuvtr7rM5UjjrqZsGnmBbsy/5NPmRXEp4eN/a5zTuNkamY2GAZqysAVA8NUgi2
        NN2TuvNKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNZcL-0006Yx-8a; Mon, 06 May 2019 09:09:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A961286AB2A0; Mon,  6 May 2019 11:08:59 +0200 (CEST)
Date:   Mon, 6 May 2019 11:08:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] sched: Add sched_load_rq tracepoint
Message-ID: <20190506090859.GK2606@hirez.programming.kicks-ass.net>
References: <20190505115732.9844-1-qais.yousef@arm.com>
 <20190505115732.9844-5-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505115732.9844-5-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05, 2019 at 12:57:29PM +0100, Qais Yousef wrote:

> +/*
> + * Following tracepoints are not exported in tracefs and provide hooking
> + * mechanisms only for testing and debugging purposes.
> + */
> +DECLARE_TRACE(sched_load_rq,
> +	TP_PROTO(int cpu, const char *path, struct sched_avg *avg),
> +	TP_ARGS(cpu, path, avg));
> +

> +DECLARE_TRACE(sched_load_se,
> +       TP_PROTO(int cpu, const char *path, struct sched_entity *se),
> +       TP_ARGS(cpu, path, se));
> +

> +DECLARE_TRACE(sched_overutilized,
> +       TP_PROTO(int overutilized),
> +       TP_ARGS(overutilized));

This doesn't generate any actual userspace because of the lack of
DEFINE_EVENT() ?

> diff --git a/kernel/sched/sched_tracepoints.h b/kernel/sched/sched_tracepoints.h
> new file mode 100644
> index 000000000000..f4ded705118e
> --- /dev/null
> +++ b/kernel/sched/sched_tracepoints.h
> @@ -0,0 +1,39 @@

Like with the other newly introduced header files, this one is lacking
the normal include guard.

> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Scheduler tracepoints that are probe-able only and aren't exported ABI in
> + * tracefs.
> + */
> +
> +#include <trace/events/sched.h>
> +
> +#define SCHED_TP_PATH_LEN		64
> +
> +
> +static __always_inline void sched_tp_load_cfs_rq(struct cfs_rq *cfs_rq)
> +{
> +	if (trace_sched_load_rq_enabled()) {
> +		int cpu = cpu_of(rq_of(cfs_rq));
> +		char path[SCHED_TP_PATH_LEN];
> +
> +		cfs_rq_tg_path(cfs_rq, path, SCHED_TP_PATH_LEN);
> +		trace_sched_load_rq(cpu, path, &cfs_rq->avg);
> +	}
> +}
> +
> +static __always_inline void sched_tp_load_rt_rq(struct rq *rq)
> +{
> +	if (trace_sched_load_rq_enabled()) {
> +		int cpu = cpu_of(rq);
> +
> +		trace_sched_load_rq(cpu, NULL, &rq->avg_rt);
> +	}
> +}
> +
> +static __always_inline void sched_tp_load_dl_rq(struct rq *rq)
> +{
> +	if (trace_sched_load_rq_enabled()) {
> +		int cpu = cpu_of(rq);
> +
> +		trace_sched_load_rq(cpu, NULL, &rq->avg_dl);
> +	}
> +}

> +static __always_inline void sched_tp_load_se(struct sched_entity *se)
> +{
> +       if (trace_sched_load_se_enabled()) {
> +               struct cfs_rq *gcfs_rq = group_cfs_rq(se);
> +               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +               char path[SCHED_TP_PATH_LEN];
> +               int cpu = cpu_of(rq_of(cfs_rq));
> +
> +               cfs_rq_tg_path(gcfs_rq, path, SCHED_TP_PATH_LEN);
> +               trace_sched_load_se(cpu, path, se);
> +       }
> +}

These functions really should be called trace_*()

Also; I _really_ hate how fat they are. Why can't we do simple straight
forward things like:

	trace_pelt_cfq(cfq);
	trace_pelt_rq(rq);
	trace_pelt_se(se);

And then have the thing attached to the event do the fat bits like
extract the path and whatnot.
