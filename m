Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9532CC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579BB20823
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbfFSMwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:52:41 -0400
Received: from foss.arm.com ([217.140.110.172]:38310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfFSMwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:52:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00E41360;
        Wed, 19 Jun 2019 05:52:40 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41A603F738;
        Wed, 19 Jun 2019 05:52:38 -0700 (PDT)
Subject: Re: [PATCH 1/8] sched: introduce task_se_h_load helper
To:     Rik van Riel <riel@surriel.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
References: <20190612193227.993-1-riel@surriel.com>
 <20190612193227.993-2-riel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <55d914d2-fba2-48c0-e7ff-3c7337c8cf8e@arm.com>
Date:   Wed, 19 Jun 2019 14:52:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612193227.993-2-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 9:32 PM, Rik van Riel wrote:
> Sometimes the hierarchical load of a sched_entity needs to be calculated.
> Split out task_h_load into a task_se_h_load that takes a sched_entity pointer
> as its argument, and a task_h_load wrapper that calls task_se_h_load.
> 
> No functional changes.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f35930f5e528..df624f7a68e7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -706,6 +706,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  #ifdef CONFIG_SMP
>  
>  static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
> +static unsigned long task_se_h_load(struct sched_entity *se);
>  static unsigned long task_h_load(struct task_struct *p);
>  static unsigned long capacity_of(int cpu);
>  
> @@ -7833,14 +7834,19 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
>  	}
>  }
>  
> -static unsigned long task_h_load(struct task_struct *p)
> +static unsigned long task_se_h_load(struct sched_entity *se)
>  {
> -	struct cfs_rq *cfs_rq = task_cfs_rq(p);
> +	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  
>  	update_cfs_rq_h_load(cfs_rq);
> -	return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
> +	return div64_ul(se->avg.load_avg * cfs_rq->h_load,
>  			cfs_rq_load_avg(cfs_rq) + 1);
>  }

I wonder if this is necessary. I placed a BUG_ON(!entity_is_task(se))
into task_se_h_load() after I applied the whole patch-set and ran some
taskgroup related testcases. It didn't hit.

So why not use task_h_load(task_of(se)) instead?

[...]
