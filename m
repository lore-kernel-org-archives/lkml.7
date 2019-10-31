Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF64CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D805208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfJaJro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:47:44 -0400
Received: from foss.arm.com ([217.140.110.172]:46348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfJaJrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:47:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0073B1F1;
        Thu, 31 Oct 2019 02:47:43 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 946833F719;
        Thu, 31 Oct 2019 02:47:42 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:47:41 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v4 1/6] sched/pelt.c: Add support to track thermal
 pressure
Message-ID: <20191031094741.GB19197@e108754-lin>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-2-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571776465-29763-2-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 Oct 2019 at 16:34:20 (-0400), Thara Gopinath wrote:
> Extrapolating on the exisiting framework to track rt/dl utilization using
> pelt signals, add a similar mechanism to track thermal pressure. The
> difference here from rt/dl utilization tracking is that, instead of
> tracking time spent by a cpu running a rt/dl task through util_avg,
> the average thermal pressure is tracked through load_avg. This is
> because thermal pressure signal is weighted "delta" capacity
> and is not binary(util_avg is binary). "delta capacity" here
> means delta between the actual capacity of a cpu and the decreased
> capacity a cpu due to a thermal event.
> In order to track average thermal pressure, a new sched_avg variable
> avg_thermal is introduced. Function update_thermal_avg can be called

Nit: s/update_thermal_avg/update_thermal_load_avg

> to do the periodic bookeeping (accumulate, decay and average)
> of the thermal pressure.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> v3->v4:
> 	- Renamed update_thermal_avg to update_thermal_load_avg.
> 	- Fixed typos as per review comments on mailing list
> 	- Reordered the code as per review comments
> 
>  kernel/sched/pelt.c  | 13 +++++++++++++
>  kernel/sched/pelt.h  |  7 +++++++
>  kernel/sched/sched.h |  1 +
>  3 files changed, 21 insertions(+)
> 
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index a96db50..3821069 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -353,6 +353,19 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>  	return 0;
>  }
>  
> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +	if (___update_load_sum(now, &rq->avg_thermal,
> +			       capacity,
> +			       capacity,
> +			       capacity)) {
> +		___update_load_avg(&rq->avg_thermal, 1, 1);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  /*
>   * irq:
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index afff644..c74226d 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -6,6 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
>  int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
>  
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  int update_irq_load_avg(struct rq *rq, u64 running);
> @@ -159,6 +160,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>  }
>  
>  static inline int
> +update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +	return 0;
> +}
> +
> +static inline int
>  update_irq_load_avg(struct rq *rq, u64 running)
>  {
>  	return 0;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 0db2c1b..d5d82c8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -944,6 +944,7 @@ struct rq {
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>  	struct sched_avg	avg_irq;
>  #endif
> +	struct sched_avg	avg_thermal;
>  	u64			idle_stamp;
>  	u64			avg_idle;
>  
> -- 
> 2.1.4
> 
