Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0984C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B4F206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfEFKqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:46:04 -0400
Received: from foss.arm.com ([217.140.101.70]:48322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfEFKqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:46:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9A11374;
        Mon,  6 May 2019 03:46:03 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0452C3F5AF;
        Mon,  6 May 2019 03:46:02 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Remove rq->load
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
References: <20190424084556.604-1-dietmar.eggemann@arm.com>
Message-ID: <c76a9ece-bfc9-c9dc-a0e0-a41698f56f78@arm.com>
Date:   Mon, 6 May 2019 12:46:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424084556.604-1-dietmar.eggemann@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/24/19 10:45 AM, Dietmar Eggemann wrote:
> The CFS class is the only one maintaining and using the CPU wide load
> (rq->load(.weight)). The last use case of the CPU wide load in CFS's
> set_next_entity() can be replaced by using the load of the CFS class
> (rq->cfs.load(.weight)) instead.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>   kernel/sched/debug.c | 2 --
>   kernel/sched/fair.c  | 7 ++-----
>   kernel/sched/sched.h | 2 --
>   3 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 8039d62ae36e..1148f43dbd42 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -656,8 +656,6 @@ do {									\
>   	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", #x, SPLIT_NS(rq->x))
>   
>   	P(nr_running);
> -	SEQ_printf(m, "  .%-30s: %lu\n", "load",
> -		   rq->load.weight);
>   	P(nr_switches);
>   	P(nr_load_updates);
>   	P(nr_uninterruptible);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a4d9e14bf138..73a6718f29cc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2682,8 +2682,6 @@ static void
>   account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   {
>   	update_load_add(&cfs_rq->load, se->load.weight);
> -	if (!parent_entity(se))
> -		update_load_add(&rq_of(cfs_rq)->load, se->load.weight);
>   #ifdef CONFIG_SMP
>   	if (entity_is_task(se)) {
>   		struct rq *rq = rq_of(cfs_rq);
> @@ -2699,8 +2697,6 @@ static void
>   account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   {
>   	update_load_sub(&cfs_rq->load, se->load.weight);
> -	if (!parent_entity(se))
> -		update_load_sub(&rq_of(cfs_rq)->load, se->load.weight);
>   #ifdef CONFIG_SMP
>   	if (entity_is_task(se)) {
>   		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
> @@ -4096,7 +4092,8 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   	 * least twice that of our own weight (i.e. dont track it
>   	 * when there are only lesser-weight tasks around):
>   	 */
> -	if (schedstat_enabled() && rq_of(cfs_rq)->load.weight >= 2*se->load.weight) {
> +	if (schedstat_enabled() &&
> +	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
>   		schedstat_set(se->statistics.slice_max,
>   			max((u64)schedstat_val(se->statistics.slice_max),
>   			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index efa686eeff26..e4059e81e99c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -830,8 +830,6 @@ struct rq {
>   	atomic_t nohz_flags;
>   #endif /* CONFIG_NO_HZ_COMMON */
>   
> -	/* capture load from *all* tasks on this CPU: */
> -	struct load_weight	load;
>   	unsigned long		nr_load_updates;
>   	u64			nr_switches;

Is there anything else I should do for this patch ?

Thanks,

-- Dietmar
