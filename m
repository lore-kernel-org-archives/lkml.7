Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675AAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2212082E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLRSyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:54:46 -0500
Received: from foss.arm.com ([217.140.110.172]:57448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfLRSyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:54:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27D821FB;
        Wed, 18 Dec 2019 10:54:45 -0800 (PST)
Received: from [192.168.42.50] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83DD83F67D;
        Wed, 18 Dec 2019 10:54:43 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20191218154402.GF3178@techsingularity.net>
Message-ID: <7f913d8b-609b-9aa7-019f-84c1d828b401@arm.com>
Date:   Wed, 18 Dec 2019 18:54:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218154402.GF3178@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On 18/12/2019 15:44, Mel Gorman wrote:
> The CPU load balancer balances between different domains to spread load
> and strives to have equal balance everywhere. Communicating tasks can
> migrate so they are topologically close to each other but these decisions
> are independent. On a lightly loaded NUMA machine, two communicating tasks
> pulled together at wakeup time can be pushed apart by the load balancer.
> In isolation, the load balancer decision is fine but it ignores the tasks
> data locality and the wakeup/LB paths continually conflict. NUMA balancing
> is also a factor but it also simply conflicts with the load balancer.
> 
> This patch allows a degree of imbalance to exist between NUMA domains
> based on the imbalance_pct defined by the scheduler domain to take into
> account that data locality is also important. This slight imbalance is
> allowed until the scheduler domain reaches almost 50% utilisation at which
> point other factors like HT utilisation and memory bandwidth come into
> play. While not commented upon in the code, the cutoff is important for
> memory-bound parallelised non-communicating workloads that do not fully
> utilise the entire machine. This is not necessarily the best universal
> cut-off point but it appeared appropriate for a variety of workloads
> and machines.
> 
> The most obvious impact is on netperf TCP_STREAM -- two simple
> communicating tasks with some softirq offloaded depending on the
> transmission rate.
> 

<snip>

> In general, the patch simply seeks to avoid unnecessarily cross-node
> migrations when a machine is lightly loaded but shows benefits for other
> workloads. While tests are still running, so far it seems to benefit
> light-utilisation smaller workloads on large machines and does not appear
> to do any harm to larger or parallelised workloads.
> 

Thanks for the detailed testing, I haven't digested it entirely yet but I
appreciate the effort.

> @@ -8690,6 +8686,38 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  		env->migration_type = migrate_task;
>  		env->imbalance = max_t(long, 0, (local->idle_cpus -
>  						 busiest->idle_cpus) >> 1);
> +
> +out_spare:
> +		/*
> +		 * Whether balancing the number of running tasks or the number
> +		 * of idle CPUs, consider allowing some degree of imbalance if
> +		 * migrating between NUMA domains.
> +		 */
> +		if (env->sd->flags & SD_NUMA) {
> +			unsigned int imbalance_adj, imbalance_max;
> +
> +			/*
> +			 * imbalance_adj is the allowable degree of imbalance
> +			 * to exist between two NUMA domains. It's calculated
> +			 * relative to imbalance_pct with a minimum of two
> +			 * tasks or idle CPUs.
> +			 */
> +			imbalance_adj = (busiest->group_weight *
> +				(env->sd->imbalance_pct - 100) / 100) >> 1;

IIRC imbalance_pct for NUMA domains uses the default 125, so I read this as
"allow an imbalance of 1 task per 8 CPU in the source group" (just making
sure I follow).

> +			imbalance_adj = max(imbalance_adj, 2U);
> +
> +			/*
> +			 * Ignore imbalance unless busiest sd is close to 50%
> +			 * utilisation. At that point balancing for memory
> +			 * bandwidth and potentially avoiding unnecessary use
> +			 * of HT siblings is as relevant as memory locality.
> +			 */
> +			imbalance_max = (busiest->group_weight >> 1) - imbalance_adj;
> +			if (env->imbalance <= imbalance_adj &&
> +			    busiest->sum_nr_running < imbalance_max) {

The code does "unless busiest group has half as many runnable tasks (or more)
as it has CPUs (modulo the adj thing)", is that what you mean by "unless
busiest sd is close to 50% utilisation" in the comment? It's somewhat
different IMO.

> +				env->imbalance = 0;
> +			}
> +		}
>  		return;
>  	}
>  
> 

I'm quite sure you have reasons to have written it that way, but I was
hoping we could squash it down to something like:
---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..f05d09a8452e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8680,16 +8680,27 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			env->migration_type = migrate_task;
 			lsub_positive(&nr_diff, local->sum_nr_running);
 			env->imbalance = nr_diff >> 1;
-			return;
+		} else {
+
+			/*
+			 * If there is no overload, we just want to even the number of
+			 * idle cpus.
+			 */
+			env->migration_type = migrate_task;
+			env->imbalance = max_t(long, 0, (local->idle_cpus -
+							 busiest->idle_cpus) >> 1);
 		}
 
 		/*
-		 * If there is no overload, we just want to even the number of
-		 * idle cpus.
+		 * Allow for a small imbalance between NUMA groups; don't do any
+		 * of it if there is at least half as many tasks / busy CPUs as
+		 * there are available CPUs in the busiest group
 		 */
-		env->migration_type = migrate_task;
-		env->imbalance = max_t(long, 0, (local->idle_cpus -
-						 busiest->idle_cpus) >> 1);
+		if (env->sd->flags & SD_NUMA &&
+		    (busiest->sum_nr_running < busiest->group_weight >> 1) &&
+		    (env->imbalance < busiest->group_weight * (env->sd->imbalance_pct - 100) / 100))
+				env->imbalance = 0;
+
 		return;
 	}
 
