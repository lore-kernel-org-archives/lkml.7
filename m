Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B9DC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBBB2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m7ArL+U2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfGSMv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:51:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSMv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HwmVrIGfPUAFOB2j8fC2lJCcCwOHkL3oDqLHYwS/kTM=; b=m7ArL+U2pXzyFfAcaflAo6wUF
        uoObEjBKk2rhaM2q7kRHxgUdcNlBo4Z3O1zYEmlVeEfpjbOoMzSh9iDV55U9H2bZBgApS2sHU33X5
        ocCQFlb/FCkHzx2SYNJSgsTUa3G1vrhgMTECTMXKm6pyn5SZA0jey+Sgb1t5wwbyMZQIJ0cEwzehg
        dYADoHnC4Mnl8x6cyzvV7IW2LlpT3KJEl63jJf3wl5JY4Z+LmwrEzAEkGUJ+1Dbd3nGCeFs4l289m
        opHiwpUa6FRQMV8/Rb/RZZm0Cy1Ku0hwXL9vBfEDc8r8FfWe0RxVkRwcIuZftAwp/qupo6BOug8A/
        IMpu2FTLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hoSMA-0007PC-Hg; Fri, 19 Jul 2019 12:51:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E18320B97994; Fri, 19 Jul 2019 14:51:24 +0200 (CEST)
Date:   Fri, 19 Jul 2019 14:51:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com
Subject: Re: [PATCH 2/5] sched/fair: rename sum_nr_running to sum_h_nr_running
Message-ID: <20190719125124.GH3419@hirez.programming.kicks-ass.net>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-3-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563523105-24673-3-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 09:58:22AM +0200, Vincent Guittot wrote:
> sum_nr_running will track rq->nr_running task and sum_h_nr_running
> will track cfs->h_nr_running so we can use both to detect when other
> scheduling class are running and preempt CFS.
> 
> There is no functional changes.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a530fd..67f0acd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7650,6 +7650,7 @@ struct sg_lb_stats {
>  	unsigned long group_capacity;
>  	unsigned long group_util; /* Total utilization of the group */
>  	unsigned int sum_nr_running; /* Nr tasks running in the group */
> +	unsigned int sum_h_nr_running; /* Nr tasks running in the group */
>  	unsigned int idle_cpus;
>  	unsigned int group_weight;
>  	enum group_type group_type;

> @@ -8000,6 +8002,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  
>  		sgs->group_load += cpu_runnable_load(rq);
>  		sgs->group_util += cpu_util(i);
> +		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
>  		sgs->sum_nr_running += rq->cfs.h_nr_running;
>  
>  		nr_running = rq->nr_running;

Maybe completely remove sum_nr_running in this patch, and introduce it
again later when you change what it counts.
