Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F3C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9F82086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfJARM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:12:29 -0400
Received: from foss.arm.com ([217.140.110.172]:54798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfJARM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:12:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 483B4337;
        Tue,  1 Oct 2019 10:12:28 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E5283F706;
        Tue,  1 Oct 2019 10:12:26 -0700 (PDT)
Subject: Re: [PATCH v3 08/10] sched/fair: use utilization to select misfit
 task
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-9-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e395537d-2292-ab5e-dd11-f2d39293667e@arm.com>
Date:   Tue, 1 Oct 2019 18:12:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568878421-12301-9-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2019 08:33, Vincent Guittot wrote:
> utilization is used to detect a misfit task but the load is then used to
> select the task on the CPU which can lead to select a small task with
> high weight instead of the task that triggered the misfit migration.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a7c8ee6..acca869 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7429,14 +7429,8 @@ static int detach_tasks(struct lb_env *env)
>  			break;
>  
>  		case migrate_misfit:
> -			load = task_h_load(p);
> -
> -			/*
> -			 * utilization of misfit task might decrease a bit
> -			 * since it has been recorded. Be conservative in the
> -			 * condition.
> -			 */
> -			if (load < env->imbalance)
> +			/* This is not a misfit task */
> +			if (task_fits_capacity(p, capacity_of(env->src_cpu)))
>  				goto next;
>  
>  			env->imbalance = 0;
> 

Following my comment in [1], if you can't squash that in patch 04 then
perhaps you could add that to this change:

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1fac444a4831..d09ce304161d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8343,7 +8343,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	if (busiest->group_type == group_misfit_task) {
 		/* Set imbalance to allow misfit task to be balanced. */
 		env->balance_type = migrate_misfit;
-		env->imbalance = busiest->group_misfit_task_load;
+		env->imbalance = 1;
 		return;
 	}
 
---

Reason being we don't care about the load (anymore), we just want a nonzero
imbalance value, so might as well assign something static.

[1]: https://lore.kernel.org/r/74bb33d7-3ba4-aabe-c7a2-3865d5759281@arm.com
