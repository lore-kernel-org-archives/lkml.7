Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D79BC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D161A21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WwEjeXeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfEMMIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:08:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfEMMIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nGZi1rJV08hqlNzuPgBpCzrtNGaM/yaNKex5AH3u+DA=; b=WwEjeXeIjuZnICrC9wVBPglDy
        EPeFrhKQ/0cPHvYjPsSYiBXjs0E4Di/9jvr/Q9yY4vo3+/gLUGEiITqQLay7FfnTP6EgCP4SGJyeQ
        kvPEBnHlkyy62xmOvm/EzPQWV28PQ9czfWgoP1h0OGTwJwXFjH7M69gzhvlU+65lniASFiOxBbwr2
        NtvzxMzrUFd2NIyVd9KIymtU+0yCyPtQppR2Au37G0yGYZEozjllHekVvMXy6uXQ2pC3f/DyxBrmx
        GntMaQeXQ9tTq0Dr8CFGHeX9Kd+0PmKNX+Z/rybJgk3Mzr9DliQiUomdXXGEuJBHw9PhSZ8ixhSe+
        qC24rW+vA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ9ku-000660-Gz; Mon, 13 May 2019 12:08:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D23002029FD7A; Mon, 13 May 2019 14:08:30 +0200 (CEST)
Date:   Mon, 13 May 2019 14:08:30 +0200
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
Subject: Re: [PATCH v2 6/7] sched: Add sched_overutilized tracepoint
Message-ID: <20190513120830.GS2623@hirez.programming.kicks-ass.net>
References: <20190510113013.1193-1-qais.yousef@arm.com>
 <20190510113013.1193-7-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510113013.1193-7-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 12:30:12PM +0100, Qais Yousef wrote:

> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index cbcb47972232..0cf42d13d6c4 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -600,6 +600,10 @@ DECLARE_TRACE(pelt_se,
>  	TP_PROTO(int cpu, const char *path, struct sched_entity *se),
>  	TP_ARGS(cpu, path, se));
>  
> +DECLARE_TRACE(sched_overutilized,
> +	TP_PROTO(int overutilized),
> +	TP_ARGS(overutilized));
> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 81036c34fd29..494032220fe7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4965,8 +4965,10 @@ static inline bool cpu_overutilized(int cpu)
>  
>  static inline void update_overutilized_status(struct rq *rq)
>  {
> -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> +	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
>  		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> +		trace_sched_overutilized(1);
> +	}
>  }
>  #else
>  static inline void update_overutilized_status(struct rq *rq) { }
> @@ -8330,8 +8332,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  
>  		/* Update over-utilization (tipping point, U >= 0) indicator */
>  		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
> +
> +		trace_sched_overutilized(!!(sg_status & SG_OVERUTILIZED));
>  	} else if (sg_status & SG_OVERUTILIZED) {
>  		WRITE_ONCE(env->dst_rq->rd->overutilized, SG_OVERUTILIZED);
> +		trace_sched_overutilized(1);
>  	}
>  }

Note how the state is per root domain and the tracepoint doesn't
communicate that.
