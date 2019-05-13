Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58D9C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE5E20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pAZj5REt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfEMMPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:15:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54044 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfEMMPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZpcNkKkwbV7XDuk2MCk60XCE2xjkbPjnn6B0dzDT6L8=; b=pAZj5REtB8smm1/D8XVZkHZjL
        +Sl35XysCvOAfamEZkWS1loHiaIgJA0SEH/D0zEc+wkP+fkDz9QtpwduWJ+3lRxNLHFqbK9MwX6lC
        FjcbXqu0D6DnRJVJ+YkYkzonJUlZKAeFkf/IHd+qBjUF1n+wIRPrD+/rq6y0k6dHo8rVt2gskPggW
        37wzwT4cbFK40e5VuOKVuxOkLIRj2A662DByqBs0DbQxvwmpUd/HgFre+oR2E5TKOGuXNjii5nrJ8
        EMHarhUJ0PB+d6dNm/4h2vbHsGZlH0ME/ShlRPZe7opQHt5sYzYbPpLwIuH0oMMmxEiChc8N8zgXF
        9iDtz+9qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ9qw-0006uA-W6; Mon, 13 May 2019 12:14:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A01A2029FD7A; Mon, 13 May 2019 14:14:45 +0200 (CEST)
Date:   Mon, 13 May 2019 14:14:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 4/7] sched: Add pelt_rq tracepoint
Message-ID: <20190513121445.GT2623@hirez.programming.kicks-ass.net>
References: <20190510113013.1193-1-qais.yousef@arm.com>
 <20190510113013.1193-5-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510113013.1193-5-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 12:30:10PM +0100, Qais Yousef wrote:

> +DECLARE_TRACE(pelt_rq,
> +	TP_PROTO(int cpu, const char *path, struct sched_avg *avg),
> +	TP_ARGS(cpu, path, avg));
> +

> +static __always_inline void sched_trace_pelt_cfs_rq(struct cfs_rq *cfs_rq)
> +{
> +	if (trace_pelt_rq_enabled()) {
> +		int cpu = cpu_of(rq_of(cfs_rq));
> +		char path[SCHED_TP_PATH_LEN];
> +
> +		cfs_rq_tg_path(cfs_rq, path, SCHED_TP_PATH_LEN);
> +		trace_pelt_rq(cpu, path, &cfs_rq->avg);
> +	}
> +}
> +
> +static __always_inline void sched_trace_pelt_rt_rq(struct rq *rq)
> +{
> +	if (trace_pelt_rq_enabled()) {
> +		int cpu = cpu_of(rq);
> +
> +		trace_pelt_rq(cpu, NULL, &rq->avg_rt);
> +	}
> +}
> +
> +static __always_inline void sched_trace_pelt_dl_rq(struct rq *rq)
> +{
> +	if (trace_pelt_rq_enabled()) {
> +		int cpu = cpu_of(rq);
> +
> +		trace_pelt_rq(cpu, NULL, &rq->avg_dl);
> +	}
> +}

Since it is only the one real tracepoint, how do we know which avg is
which?
