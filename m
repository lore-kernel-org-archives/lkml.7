Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1905C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6B220717
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfLBPNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:13:02 -0500
Received: from foss.arm.com ([217.140.110.172]:55488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfLBPNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:13:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4861A31B;
        Mon,  2 Dec 2019 07:13:01 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C7F43F52E;
        Mon,  2 Dec 2019 07:12:59 -0800 (PST)
Subject: Re: [PATCH] sched/cfs: fix spurious active migration
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
References: <1575036287-6052-1-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b8cee573-d1a7-bc26-c6d3-4f9e1a4ad330@arm.com>
Date:   Mon, 2 Dec 2019 16:12:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1575036287-6052-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2019 15:04, Vincent Guittot wrote:
> The load balance can fail to find a suitable task during the periodic check
> because  the imbalance is smaller than half of the load of the waiting
> tasks. This results in the increase of the number of failed load balance,
> which can end up to start an active migration. This active migration is
> useless because the current running task is not a better choice than the
> waiting ones. In fact, the current task was probably not running but
> waiting for the CPU during one of the previous attempts and it had already
> not been selected.
> 
> When load balance fails too many times to migrate a task, we should relax
> the contraint on the maximum load of the tasks that can be migrated
> similarly to what is done with cache hotness.
> 
> Before the rework, load balance used to set the imbalance to the average
> load_per_task in order to mitigate such situation. This increased the
> likelihood of migrating a task but also of selecting a larger task than
> needed while more appropriate ones were in the list.

Why not use '&& !env->sd->nr_balance_failed' then? Too aggressive? But
the average load_per_task was calculated at each load balance attempt,
so it would have led to a migration at the first load balance.

This would be in sync with the LB_MIN check in the same switch case
(migrate_load). Although LB_MIN is false by default.

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> I haven't seen any noticable performance changes on the benchmarks that I
> usually run but the problem can be easily highlight with a simple test
> with 9 always running tasks on 8 cores.
> 
>  kernel/sched/fair.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e0d662a..d1b4fa7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7433,7 +7433,14 @@ static int detach_tasks(struct lb_env *env)
>  			    load < 16 && !env->sd->nr_balance_failed)
>  				goto next;
>  
> -			if (load/2 > env->imbalance)
> +			/*
> +			 * Make sure that we don't migrate too much load.
> +			 * Nevertheless, let relax the constraint if
> +			 * scheduler fails to find a good waiting task to
> +			 * migrate.
> +			 */
> +			if (load/2 > env->imbalance &&
> +			    env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
>  				goto next;
>  
>  			env->imbalance -= load;
> 
