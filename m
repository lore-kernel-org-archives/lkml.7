Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF96C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEE320B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbfHAQ15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:27:57 -0400
Received: from foss.arm.com ([217.140.110.172]:38818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbfHAQ1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:27:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DDDE337;
        Thu,  1 Aug 2019 09:27:53 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 158A33F694;
        Thu,  1 Aug 2019 09:27:51 -0700 (PDT)
Subject: Re: [PATCH v2 8/8] sched/fair: use utilization to select misfit task
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-9-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <22ba6771-8bde-8c6e-65e0-4ab2ebc6e018@arm.com>
Date:   Thu, 1 Aug 2019 17:27:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564670424-26023-9-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2019 15:40, Vincent Guittot wrote:
> @@ -8261,7 +8261,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  		 * If we have more than one misfit sg go with the
>  		 * biggest misfit.
>  		 */
> -		if (sgs->group_misfit_task_load < busiest->group_misfit_task_load)
> +		if (sgs->group_misfit_task_util < busiest->group_misfit_task_util)
>  			return false;

I previously said this change would render the maximization useless, but I
had forgotten one thing: with PELT time scaling, task utilization can go
above its CPU's capacity.

So if you have two LITTLE CPUs running a busy loop (misfit task) each, the
one that's been running the longest would have the highest utilization
(assuming they haven't reached 1024 yet). In other words "utilizations
above the capacity_margin can't be compared" doesn't really stand.

Still, maximizing load would lead us there. Furthermore, if we have to pick
between two rqs with misfit tasks, I still believe we should pick the one
with the highest load, not the highest utilization.

We could keep load and fix the issue of detaching the wrong task with
something like:

-----8<-----
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 53e64a7b2ae0..bfc2b624ee98 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7489,12 +7489,8 @@ static int detach_tasks(struct lb_env *env)
                case migrate_misfit:
                        load = task_h_load(p);
 
-                       /*
-                        * utilization of misfit task might decrease a bit
-                        * since it has been recorded. Be conservative in the
-                        * condition.
-                        */
-                       if (load < env->imbalance)
+                       /* This is not a misfit task */
+                       if (task_fits_capacity(p, capacity_of(env->src_cpu)))
                                goto next;
 
                        env->imbalance = 0;
----->8-----

However what would be *even* better IMO would be:

-----8<-----
@@ -8853,6 +8853,7 @@ voluntary_active_balance(struct lb_env *env)
                        return 1;
        }
 
+       /* XXX: make sure current is still a misfit task? */
        if (env->balance_type == migrate_misfit)
                return 1;
 
@@ -8966,6 +8967,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
        env.src_rq = busiest;
 
        ld_moved = 0;
+
+       /*
+        * Misfit tasks are only misfit if they are currently running, see
+        * update_misfit_status().
+        *
+        * - If they're not running, we'll get an opportunity at wakeup to
+        *   migrate them to a bigger CPU.
+        * - If they're running, we need to active balance them to a bigger CPU.
+        *
+        * Do the smart thing and go straight for active balance.
+        */
+       if (env->balance_type == migrate_misfit)
+               goto active_balance;
+
        if (busiest->nr_running > 1) {
                /*
                 * Attempt to move tasks. If find_busiest_group has found
@@ -9074,7 +9089,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
                        goto out_all_pinned;
                }
        }
-
+active_balance:
        if (!ld_moved) {
                schedstat_inc(sd->lb_failed[idle]);
                /*
----->8-----
