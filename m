Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B29C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B942146E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tZAnMjun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfLPOjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:39:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52958 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfLPOji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wGV7T+lq8INjf3GQ5DwP7BYt/gLG2M+cQmE37gow1nk=; b=tZAnMjunzpE2VuYRBtywLBdP7
        JCe2+UveERkf5wJc7Hji2kOXrsxnZxsfVtc35PiktFS+xBnWVV5lvgJ31uEuT6ZWgkdYz7FLXuSgJ
        ccM/L/+rcAGo4oH2K1TVRvSRI2FiFj0Qv7YIJ5/2kRSckCSf/9Jqap912xxJe+2lRNI81umISKu4A
        sE6Yqq+jhlLS8awUtbyBkhRKI4Eo2WIzEPDsHTIH3Gx87N1WgeYV19nfnJ3eqUTGd1rhAhXzNHKiA
        OiqJBp0dSrnCSBLv4LG/oM7KxP8ItHaenX9h487jY0pp0TAt8FIh9MP1oYI1p7IJ86WJJcOIP4zrR
        1SxtfLlng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igrX4-0004cj-80; Mon, 16 Dec 2019 14:39:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A68C3035D4;
        Mon, 16 Dec 2019 15:38:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A17D2B2A1916; Mon, 16 Dec 2019 15:39:32 +0100 (CET)
Date:   Mon, 16 Dec 2019 15:39:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
Subject: Re: [Patch v6 4/7] sched/fair: Enable periodic update of average
 thermal pressure
Message-ID: <20191216143932.GT2844@hirez.programming.kicks-ass.net>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-5-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576123908-12105-5-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:11:45PM -0500, Thara Gopinath wrote:
> Introduce support in CFS periodic tick and other bookkeeping apis
> to trigger the process of computing average thermal pressure for a
> cpu. Also consider avg_thermal.load_avg in others_have_blocked
> which allows for decay of pelt signals.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/fair.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> v4->v5:
> 	- Updated both versions of update_blocked_averages to trigger the
> 	  process of computing average thermal pressure.
> 	- Updated others_have_blocked to considerd avg_thermal.load_avg.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e..e12a375 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7462,6 +7462,9 @@ static inline bool others_have_blocked(struct rq *rq)
>  	if (READ_ONCE(rq->avg_dl.util_avg))
>  		return true;
>  
> +	if (READ_ONCE(rq->avg_thermal.load_avg))
> +		return true;
> +
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  	if (READ_ONCE(rq->avg_irq.util_avg))
>  		return true;
> @@ -7487,6 +7490,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>  {
>  	const struct sched_class *curr_class;
>  	u64 now = rq_clock_pelt(rq);
> +	unsigned long thermal_pressure = arch_scale_thermal_capacity(cpu_of(rq));
>  	bool decayed;
>  
>  	/*
> @@ -7497,6 +7501,8 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>  
>  	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>  		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> +		  update_thermal_load_avg(rq_clock_task(rq), rq,
> +					  thermal_pressure) 			|
>  		  update_irq_load_avg(rq, 0);
>  
>  	if (others_have_blocked(rq))
> @@ -10263,6 +10269,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  {
>  	struct cfs_rq *cfs_rq;
>  	struct sched_entity *se = &curr->se;
> +	unsigned long thermal_pressure = arch_scale_thermal_capacity(cpu_of(rq));
>  
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
> @@ -10274,6 +10281,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  
>  	update_misfit_status(curr, rq);
>  	update_overutilized_status(task_rq(curr));
> +	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
>  }

My objection here is that when the arch does not have support for it,
there is still code generated and runtime overhead associated with it.
