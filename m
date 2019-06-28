Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507A7C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CBC205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfF1K0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:26:30 -0400
Received: from foss.arm.com ([217.140.110.172]:44518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfF1K0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:26:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A582628;
        Fri, 28 Jun 2019 03:26:29 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF65E3F718;
        Fri, 28 Jun 2019 03:26:27 -0700 (PDT)
Subject: Re: [PATCH 8/8] sched,fair: flatten hierarchical runqueues
To:     Rik van Riel <riel@surriel.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggemann@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
References: <20190612193227.993-1-riel@surriel.com>
 <20190612193227.993-9-riel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1146bbfd-ae1e-27d8-6b62-d68392d8130f@arm.com>
Date:   Fri, 28 Jun 2019 12:26:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612193227.993-9-riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 9:32 PM, Rik van Riel wrote:
> Flatten the hierarchical runqueues into just the per CPU rq.cfs runqueue.
> 
> Iteration of the sched_entity hierarchy is rate limited to once per jiffy
> per sched_entity, which is a smaller change than it seems, because load
> average adjustments were already rate limited to once per jiffy before this
> patch series.
> 
> This patch breaks CONFIG_CFS_BANDWIDTH. The plan for that is to park tasks
> from throttled cgroups onto their cgroup runqueues, and slowly (using the
> GENTLE_FAIR_SLEEPERS) wake them back up, in vruntime order, once the cgroup
> gets unthrottled, to prevent thundering herd issues.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  include/linux/sched.h |   2 +
>  kernel/sched/fair.c   | 478 +++++++++++++++++-------------------------
>  kernel/sched/pelt.c   |   6 +-
>  kernel/sched/pelt.h   |   2 +-
>  kernel/sched/sched.h  |   2 +-
>  5 files changed, 194 insertions(+), 296 deletions(-)
> 

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c

[...]

> @@ -3491,7 +3544,7 @@ static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  	 * track group sched_entity load average for task_h_load calc in migration
>  	 */
>  	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
> -		updated = __update_load_avg_se(now, cfs_rq, se);
> +		updated = __update_load_avg_se(now, cfs_rq, se, curr, curr);

I wonder if task migration is still working correctly.

migrate_task_rq_fair(p, ...) -> remove_entity_load_avg(&p->se) would use
cfs_rq = se->cfs_rq (i.e. root cfs_rq). So load (and util) will not
propagate through the taskgroup hierarchy.

[...]

