Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641B3C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433092133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfFZOek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:34:40 -0400
Received: from foss.arm.com ([217.140.110.172]:34556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfFZOek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:34:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECD952B;
        Wed, 26 Jun 2019 07:34:39 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E39D53F706;
        Wed, 26 Jun 2019 07:34:34 -0700 (PDT)
Subject: Re: [PATCH 3/8] sched,fair: redefine runnable_load_avg as the sum of
 task_h_load
To:     Rik van Riel <riel@surriel.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggemann@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
References: <20190612193227.993-1-riel@surriel.com>
 <20190612193227.993-4-riel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4e50f0a6-92b1-7dfe-884c-d2f7d846cde8@arm.com>
Date:   Wed, 26 Jun 2019 16:34:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612193227.993-4-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 9:32 PM, Rik van Riel wrote:
> The runnable_load magic is used to quickly propagate information about
> runnable tasks up the hierarchy of runqueues. lhen switching to a flat

Looks like here is some information missing.

> runqueue, that no longer works.
> 
> Redefine the CPU cfs_rq runnable_load_avg to be the sum of task_h_loads
> of the runnable tasks. This provides enough information to the load
> balancer.
> 
> The runnable_load_avg of the cgroup cfs_rqs does not appear to be
> used for anything, so don't bother calculating those.
> 
> This removes one of the things that the code currently traverses the
> cgroup hierarchy for, and getting rid of it brings us one step closer
> to a flat runqueue for the CPU controller.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  include/linux/sched.h |   3 +-
>  kernel/sched/core.c   |   2 -
>  kernel/sched/debug.c  |   1 +
>  kernel/sched/fair.c   | 125 +++++++++++++-----------------------------
>  kernel/sched/pelt.c   |  49 ++++++-----------
>  kernel/sched/sched.h  |   6 --
>  6 files changed, 55 insertions(+), 131 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 11837410690f..f5bb6948e40c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -391,7 +391,6 @@ struct util_est {
>  struct sched_avg {
>  	u64				last_update_time;
>  	u64				load_sum;
> -	u64				runnable_load_sum;
>  	u32				util_sum;
>  	u32				period_contrib;
>  	unsigned long			load_avg;

Could you not also remove runnable_load_avg from struct sched_avg and
put it into the struct cfs_rq directly. The signal has nothing to to
with PELT anymore and se don't have to carry it. You only need it for
the root cfs_rq's but it's at least better than having it still for all
se's as well.

[...]

> @@ -2767,20 +2765,39 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  static inline void
>  enqueue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -	cfs_rq->runnable_weight += se->runnable_weight;
> +	if (entity_is_task(se)) {
> +		struct cfs_rq *cpu_cfs_rq = &cfs_rq->rq->cfs;

There are a couple of comments in fair.c referring to this cfs_rq as the
root cfs_rq, rather the cpu cfs_rq. IMHO, easier to read if we stick to
one name (root_cfs_rq vs. cpu_cfs_rq).

[...]
