Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6C2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF2A2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbfFTQXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:23:52 -0400
Received: from foss.arm.com ([217.140.110.172]:47402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfFTQXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:23:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86B9F2B;
        Thu, 20 Jun 2019 09:23:51 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D64693F246;
        Thu, 20 Jun 2019 09:23:49 -0700 (PDT)
Subject: Re: [PATCH 5/8] sched,cfs: use explicit cfs_rq of parent se helper
To:     Rik van Riel <riel@surriel.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
References: <20190612193227.993-1-riel@surriel.com>
 <20190612193227.993-6-riel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <55c0dc01-24b2-bb7f-6ceb-b65c52f7b46b@arm.com>
Date:   Thu, 20 Jun 2019 18:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612193227.993-6-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 9:32 PM, Rik van Riel wrote:
> Use an explicit "cfs_rq of parent sched_entity" helper in a few
> strategic places, where cfs_rq_of(se) may no longer point at the
> right runqueue once we flatten the hierarchical cgroup runqueues.
> 
> No functional change.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index dcc521d251e3..c6ede2ecc935 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -275,6 +275,15 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
>  	return grp->my_q;
>  }
>  
> +/* runqueue owned by the parent entity */
> +static inline struct cfs_rq *group_cfs_rq_of_parent(struct sched_entity *se)
> +{
> +	if (se->parent)
> +		return group_cfs_rq(se->parent);
> +
> +	return &cfs_rq_of(se)->rq->cfs;
> +}
> +
>  static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>  	struct rq *rq = rq_of(cfs_rq);
> @@ -3298,7 +3307,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
>  
>  	gcfs_rq->propagate = 0;
>  
> -	cfs_rq = cfs_rq_of(se);
> +	cfs_rq = group_cfs_rq_of_parent(se);
>  
>  	add_tg_cfs_propagate(cfs_rq, gcfs_rq->prop_runnable_sum);
>  
> @@ -7779,7 +7788,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
>  
>  	WRITE_ONCE(cfs_rq->h_load_next, NULL);
>  	for_each_sched_entity(se) {
> -		cfs_rq = cfs_rq_of(se);
> +		cfs_rq = group_cfs_rq_of_parent(se);

Why do you change this here? task_se_h_load() calls
update_cfs_rq_h_load() with cfs_rq = group_cfs_rq_of_parent(se) because
the task might not be on the cfs_rq yet.

But inside update_cfs_rq_h_load() the first se is derived from
cfs_rq->tg->se[cpu_of(rq)] so in the first for_each_sched_entity() loop
we should still start with group_cfs_rq() (se->my_q) ?

The system doesn't barf with these two WARN_ON's in.

@@ -7663,12 +7673,17 @@ static void update_cfs_rq_h_load(struct cfs_rq
*cfs_rq)
        unsigned long now = jiffies;
        unsigned long load;

+       WARN_ON(se && (se != group_cfs_rq(se)->tg->se[cpu_of(rq)]));
+
        if (cfs_rq->last_h_load_update == now)
                return;

        WRITE_ONCE(cfs_rq->h_load_next, NULL);
        for_each_sched_entity(se) {
                cfs_rq = group_cfs_rq_of_parent(se);
+
+               WARN_ON(se != group_cfs_rq(se)->tg->se[cpu_of(rq)]);
+
                WRITE_ONCE(cfs_rq->h_load_next, se);
                if (cfs_rq->last_h_load_update == now)
                        break;


[...]

