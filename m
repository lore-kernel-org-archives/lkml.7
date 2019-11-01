Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1795CCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA489217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfKAMRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:17:36 -0400
Received: from foss.arm.com ([217.140.110.172]:34498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730572AbfKAMRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:17:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC3B91F1;
        Fri,  1 Nov 2019 05:17:30 -0700 (PDT)
Received: from [192.168.1.20] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB9A83F6C4;
        Fri,  1 Nov 2019 05:17:28 -0700 (PDT)
Subject: Re: [Patch v4 2/6] sched: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-3-git-send-email-thara.gopinath@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <379d23e5-79a5-9d90-0fb6-125d9be85e99@arm.com>
Date:   Fri, 1 Nov 2019 13:17:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571776465-29763-3-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.19 22:34, Thara Gopinath wrote:

[...]

> +/**
> + * trigger_thermal_pressure_average: Trigger the thermal pressure accumulate
> + *				     and average algorithm
> + */
> +void trigger_thermal_pressure_average(struct rq *rq)
> +{
> +	update_thermal_load_avg(rq_clock_task(rq), rq,
> +				per_cpu(delta_capacity, cpu_of(rq)));
> +}

Why not call update_thermal_load_avg() directly in fair.c? We do this for all
the other update_foo_load_avg() functions (foo eq. irq, rt_rq, dl_rq ...)

You don't have to pass 'u64 now', so you can hide it plus the 
sched_thermal_decay_coeff add-on within update_thermal_load_avg().
(Similar to update_irq_load_avg()).

You could even hide 'u64 capacity' in it.

So we save one function layer (trigger_thermal_pressure_average()), thermal becomes
more aligned with the other PELT users when it comes to call-sites and we have less
code for this feature.

Something like this (only for 'u64 now' and only compile tested on arm64:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index be3e802a2dc5..ac3ec3a04469 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7576,7 +7576,7 @@ static void update_blocked_averages(int cpu)
 
        update_blocked_load_status(rq, !done);
 
-       trigger_thermal_pressure_average(rq);
+       update_thermal_load_avg(rq, per_cpu(delta_capacity, cpu_of(rq)));
        rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -9938,7 +9938,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
        update_misfit_status(curr, rq);
        update_overutilized_status(task_rq(curr));
 
-       trigger_thermal_pressure_average(rq);
+       update_thermal_load_avg(rq, per_cpu(delta_capacity, cpu_of(rq)));
 }
 
 /*
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 38210691c615..7dd0d7e43854 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -353,8 +353,12 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
        return 0;
 }
 
-int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+extern int sched_thermal_decay_coeff;
+
+int update_thermal_load_avg(struct rq *rq, u64 capacity)
 {
+       u64 now = rq_clock_task(rq) >> sched_thermal_decay_coeff;
+
        if (___update_load_sum(now, &rq->avg_thermal,
                               capacity,
                               capacity,
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index c74226de716e..91483c957b6c 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -6,7 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
-int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
+int update_thermal_load_avg(struct rq *rq, u64 capacity);
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 int update_irq_load_avg(struct rq *rq, u64 running);
diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
index 0da31e12a5ff..7b8c4e35c28d 100644
--- a/kernel/sched/thermal.c
+++ b/kernel/sched/thermal.c
@@ -21,7 +21,7 @@
  *     3                       256
  *     4                       512
  */
-static int sched_thermal_decay_coeff;
+int sched_thermal_decay_coeff;
 
 static int __init setup_sched_thermal_decay_coeff(char *str)
 {
@@ -32,7 +32,7 @@ static int __init setup_sched_thermal_decay_coeff(char *str)
 }
 __setup("sched_thermal_decay_coeff=", setup_sched_thermal_decay_coeff);
 
-static DEFINE_PER_CPU(unsigned long, delta_capacity);
+DEFINE_PER_CPU(unsigned long, delta_capacity);
 
 /**
  * update_thermal_pressure: Update thermal pressure
@@ -55,14 +55,3 @@ void update_thermal_pressure(int cpu, u64 capped_freq_ratio)
 
        per_cpu(delta_capacity, cpu) = delta;
 }
-
-/**
- * trigger_thermal_pressure_average: Trigger the thermal pressure accumulate
- *                                  and average algorithm
- */
-void trigger_thermal_pressure_average(struct rq *rq)
-{
-       update_thermal_load_avg(rq_clock_task(rq) >>
-                               sched_thermal_decay_coeff, rq,
-                               per_cpu(delta_capacity, cpu_of(rq)));
-}
diff --git a/kernel/sched/thermal.h b/kernel/sched/thermal.h
index 26e5b07e9c29..a6ee973db41b 100644
--- a/kernel/sched/thermal.h
+++ b/kernel/sched/thermal.h
@@ -2,12 +2,4 @@
 /*
  * Scheduler thermal interaction internal methods.
  */
-
-#ifdef CONFIG_SMP
-void trigger_thermal_pressure_average(struct rq *rq);
-
-#else
-static inline void trigger_thermal_pressure_average(struct rq *rq)
-{
-}
-#endif
+DECLARE_PER_CPU(unsigned long , delta_capacity);
