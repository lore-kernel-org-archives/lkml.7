Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A89FA373E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02202133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbfJAIPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:15:33 -0400
Received: from foss.arm.com ([217.140.110.172]:43458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfJAIPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:15:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D34F7337;
        Tue,  1 Oct 2019 01:15:31 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50B7F3F739;
        Tue,  1 Oct 2019 01:15:30 -0700 (PDT)
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <46e81a81-f88e-c935-d452-9b746bde492b@arm.com>
Date:   Tue, 1 Oct 2019 10:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2019 09:33, Vincent Guittot wrote:


[...]

> @@ -8042,14 +8104,24 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		}
>  	}
>  
> -	/* Adjust by relative CPU capacity of the group */
> +	/* Check if dst cpu is idle and preferred to this group */
> +	if (env->sd->flags & SD_ASYM_PACKING &&
> +	    env->idle != CPU_NOT_IDLE &&
> +	    sgs->sum_h_nr_running &&
> +	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> +		sgs->group_asym_packing = 1;
> +	}
> +

Since asym_packing check is done per-sg rather per-CPU (like misfit_task), can you
not check for asym_packing in group_classify() directly (like for overloaded) and
so get rid of struct sg_lb_stats::group_asym_packing?

Something like (only compile tested).

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d0c3aa1dc290..b2848d6f8a2a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7692,7 +7692,6 @@ struct sg_lb_stats {
        unsigned int idle_cpus;
        unsigned int group_weight;
        enum group_type group_type;
-       unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
        unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
        unsigned int nr_numa_running;
@@ -7952,6 +7951,20 @@ group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
        return false;
 }
 
+static inline bool
+group_has_asym_packing(struct lb_env *env, struct sched_group *sg,
+                      struct sg_lb_stats *sgs)
+{
+       if (env->sd->flags & SD_ASYM_PACKING &&
+           env->idle != CPU_NOT_IDLE &&
+           sgs->sum_h_nr_running &&
+           sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
+               return true;
+       }
+
+       return false;
+}
+
 /*
  * group_smaller_min_cpu_capacity: Returns true if sched_group sg has smaller
  * per-CPU capacity than sched_group ref.
@@ -7983,7 +7996,7 @@ group_type group_classify(struct lb_env *env,
        if (sg_imbalanced(group))
                return group_imbalanced;
 
-       if (sgs->group_asym_packing)
+       if (group_has_asym_packing(env, group, sgs))
                return group_asym_packing;
 
        if (sgs->group_misfit_task_load)
@@ -8076,14 +8089,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
                }
        }
 
-       /* Check if dst cpu is idle and preferred to this group */
-       if (env->sd->flags & SD_ASYM_PACKING &&
-           env->idle != CPU_NOT_IDLE &&
-           sgs->sum_h_nr_running &&
-           sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
-               sgs->group_asym_packing = 1;
-       }
-
        sgs->group_capacity = group->sgc->capacity;

[...]
