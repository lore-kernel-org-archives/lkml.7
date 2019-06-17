Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758D2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5E3208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q9HxfQrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfFQPud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:50:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfFQPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BR2md6n6Q18on79dMFcaXNz3srYx6Sfx4K07iFPAszA=; b=Q9HxfQrqVz+qo4SCuT0oYOUGY
        s2zAOLRSQbww5wegoEzCwYdsqD7jW6FS56wDaXTzTFCAOd+Hi0z3HWWssf+Gn2Ilf3bfFHLug2JP7
        +4LTrS5GXNNupL0/8f8fqBt3TYUmoICe5y64Vgbmg9h6WXWsp6eQb/+4/hj1B33TR8czRrK8vvlLZ
        COXJJN+qpkiM5eEhvQqoIeardkUme6LKIOgjCvEma1iklypdDJverql/CC+FYraT0j/Gb7osmIpnK
        Sb+miWQ6wXmNPCTaqqK9ykDY+KkFid/Skbutgsu7KAprjgGp7sweQWo5p7xt8fRgIM83+Fg1MR1Bs
        UyDwHJF3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcttc-0007YJ-4V; Mon, 17 Jun 2019 15:50:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D6CE201F4619; Mon, 17 Jun 2019 17:50:10 +0200 (CEST)
Date:   Mon, 17 Jun 2019 17:50:10 +0200
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
Subject: Re: [PATCH v3 5/6] sched: Add sched_overutilized tracepoint
Message-ID: <20190617155010.GH3436@hirez.programming.kicks-ass.net>
References: <20190604111459.2862-1-qais.yousef@arm.com>
 <20190604111459.2862-6-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604111459.2862-6-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 12:14:58PM +0100, Qais Yousef wrote:
> The new tracepoint allows us to track the changes in overutilized
> status.
> 
> Overutilized status is associated with EAS. It indicates that the system
> is in high performance state. EAS is disabled when the system is in this
> state since there's not much energy savings while high performance tasks
> are pushing the system to the limit and it's better to default to the
> spreading behavior of the scheduler.
> 
> This tracepoint helps understanding and debugging the conditions under
> which this happens.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  include/trace/events/sched.h |  4 ++++
>  kernel/sched/fair.c          | 11 +++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index c7dd9bc7f001..edd96e04049f 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -621,6 +621,10 @@ DECLARE_TRACE(pelt_se_tp,
>  	TP_PROTO(struct sched_entity *se),
>  	TP_ARGS(se));
>  
> +DECLARE_TRACE(sched_overutilized_tp,
> +	TP_PROTO(int overutilized, struct root_domain *rd),
> +	TP_ARGS(overutilized, rd));
> +

strictly speaking you only need @rd :-)

>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8e0015ebf109..e2418741608e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5179,8 +5179,10 @@ static inline bool cpu_overutilized(int cpu)
>  
>  static inline void update_overutilized_status(struct rq *rq)
>  {
> -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> +	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
>  		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> +		trace_sched_overutilized_tp(1, rq->rd);
> +	}
>  }
>  #else
>  static inline void update_overutilized_status(struct rq *rq) { }
> @@ -8542,8 +8544,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  
>  		/* Update over-utilization (tipping point, U >= 0) indicator */
>  		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
> +
> +		trace_sched_overutilized_tp(!!(sg_status & SG_OVERUTILIZED), rd);
>  	} else if (sg_status & SG_OVERUTILIZED) {
> -		WRITE_ONCE(env->dst_rq->rd->overutilized, SG_OVERUTILIZED);
> +		struct root_domain *rd = env->dst_rq->rd;
> +
> +		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> +		trace_sched_overutilized_tp(1, rd);
>  	}
>  }

But I figure since we need both values anyway, this isn't too much of a
bother.

I'm going to flip the argument order though.
