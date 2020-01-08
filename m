Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B54C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D8F208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtY+C22h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgAHI1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:27:17 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38251 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHI1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:27:17 -0500
Received: by mail-pj1-f66.google.com with SMTP id l35so753774pje.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 00:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Msod3mRVT9tJQexgvtHelBQzsmC3LbzZpFMhO8EK+Q8=;
        b=QtY+C22hxjxOJew7IsLFFRzks5ODsTo8qYxAJ7s0pphQHcLSzg+9J1AR1Hy+uYSouO
         92jEhG/YY+mI91x6FHhKuVjLid2LhvBKm9mCIt4tDBhgkxq6kEqyEQul2dT5wBnUH0jX
         9uC84PBOF5528QkMAS/6cl+O4Kqtg52R6+PvRefpcE5/E5gcolTQVcR0ffKXnbhjbsyK
         aTQPRuK+UcsXuLvKndly/1FJLearfiI5klwd9JFL96zdsjjK55j7rWKQ6NpUDoTKviiO
         PeMisQ/RVu6Npf8lKXq7VVC11ML6ODhgCGhzvoWUZgVLpW2u2neVqgKR6o5QJRPa2xZy
         yBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Msod3mRVT9tJQexgvtHelBQzsmC3LbzZpFMhO8EK+Q8=;
        b=jAp+A1DQfUFZ8rH97T64xPyCWZ+j2KaAsjqYB7YPy0LZ3z/NZ8bBedD1AHYMbdYOl3
         JBLk8qyPoeNhy5n1ZYIj+1S1QFa1kJ7EOVW5VIj9DiFYsbvNmmDxyAKxv4M3CojMnNBL
         Cchln2h7XchWPRGR23XjH+3E5B22kaGAlTPI1ppfP5XMDI4HmsmKCCUwBRu9NX1P+bXI
         vuPPJbNV0BUXclekKhMqwRgbsteC1EWXGNdYdEWuBm1VMynjGuUzcNJfbjr+uKZgtOXu
         IGDOHqwc6aJnRV7Vf4/NY9WxBw97m47esxa02C1zKInOq5j72oEVJyiwnhRYKfbssMXk
         wt2g==
X-Gm-Message-State: APjAAAW+7aWCYHQeOSaolCSMkaYEhN1g5UH7dNVvjqMMdJFnCULl4Hkl
        HKQ6BPzWIqp8hqqUy5Wo1G0yQw==
X-Google-Smtp-Source: APXvYqw0GOQFou/cbA1Ys2K5eQPVa8Y+shvCnV8vfoR2jYv1U4p3Y49fzrgaWG4pJuwNf4EP0vlH1A==
X-Received: by 2002:a17:902:7c0f:: with SMTP id x15mr4226160pll.267.1578472035995;
        Wed, 08 Jan 2020 00:27:15 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id d24sm2457626pfq.75.2020.01.08.00.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 00:27:15 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] sched/fair: Load balance aggressively for SCHED_IDLE CPUs
Date:   Wed,  8 Jan 2020 13:57:04 +0530
Message-Id: <e485827eb8fe7db0943d6f3f6e0f5a4a70272781.1578471925.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fair scheduler performs periodic load balance on every CPU to check
if it can pull some tasks from other busy CPUs. The duration of this
periodic load balance is set to sd->balance_interval for the idle CPUs
and is calculated by multiplying the sd->balance_interval with the
sd->busy_factor (set to 32 by default) for the busy CPUs. The
multiplication is done for busy CPUs to avoid doing load balance too
often and rather spend more time executing actual task. While that is
the right thing to do for the CPUs busy with SCHED_OTHER or SCHED_BATCH
tasks, it may not be the optimal thing for CPUs running only SCHED_IDLE
tasks.

With the recent enhancements in the fair scheduler around SCHED_IDLE
CPUs, we now prefer to enqueue a newly-woken task to a SCHED_IDLE
CPU instead of other busy or idle CPUs. The same reasoning should be
applied to the load balancer as well to make it migrate tasks more
aggressively to a SCHED_IDLE CPU, as that will reduce the scheduling
latency of the migrated (SCHED_OTHER) tasks.

This patch makes minimal changes to the fair scheduler to do the next
load balance soon after the last non SCHED_IDLE task is dequeued from a
runqueue, i.e. making the CPU SCHED_IDLE. Also the sd->busy_factor is
ignored while calculating the balance_interval for such CPUs. This is
done to avoid delaying the periodic load balance by few hundred
milliseconds for SCHED_IDLE CPUs.

This is tested on ARM64 Hikey620 platform (octa-core) with the help of
rt-app and it is verified, using kernel traces, that the newly
SCHED_IDLE CPU does load balancing shortly after it becomes SCHED_IDLE
and pulls tasks from other busy CPUs.

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->
- Updated conditional statement based on Peter's suggestion.
- Added Reviewed-by from Vincent.

 kernel/sched/fair.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 83500b5b93dc..2255c4d69d02 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5210,6 +5210,18 @@ static inline void update_overutilized_status(struct rq *rq)
 static inline void update_overutilized_status(struct rq *rq) { }
 #endif
 
+/* Runqueue only has SCHED_IDLE tasks enqueued */
+static int sched_idle_rq(struct rq *rq)
+{
+	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
+			rq->nr_running);
+}
+
+static int sched_idle_cpu(int cpu)
+{
+	return sched_idle_rq(cpu_rq(cpu));
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -5324,6 +5336,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
 	int idle_h_nr_running = task_has_idle_policy(p);
+	bool was_sched_idle = sched_idle_rq(rq);
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -5370,6 +5383,10 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		sub_nr_running(rq, 1);
 
+	/* balance early to pull high priority tasks */
+	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
+		rq->next_balance = jiffies;
+
 	util_est_dequeue(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -5392,15 +5409,6 @@ static struct {
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
-/* CPU only has SCHED_IDLE tasks enqueued */
-static int sched_idle_cpu(int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-
-	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
-			rq->nr_running);
-}
-
 static unsigned long cpu_load(struct rq *rq)
 {
 	return cfs_rq_load_avg(&rq->cfs);
@@ -9531,6 +9539,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 {
 	int continue_balancing = 1;
 	int cpu = rq->cpu;
+	int busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
 	unsigned long interval;
 	struct sched_domain *sd;
 	/* Earliest time when we have to do rebalance again */
@@ -9567,7 +9576,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 			break;
 		}
 
-		interval = get_sd_balance_interval(sd, idle != CPU_IDLE);
+		interval = get_sd_balance_interval(sd, busy);
 
 		need_serialize = sd->flags & SD_SERIALIZE;
 		if (need_serialize) {
@@ -9583,9 +9592,10 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 				 * state even if we migrated tasks. Update it.
 				 */
 				idle = idle_cpu(cpu) ? CPU_IDLE : CPU_NOT_IDLE;
+				busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
 			}
 			sd->last_balance = jiffies;
-			interval = get_sd_balance_interval(sd, idle != CPU_IDLE);
+			interval = get_sd_balance_interval(sd, busy);
 		}
 		if (need_serialize)
 			spin_unlock(&balancing);
-- 
2.21.0.rc0.269.g1a574e7a288b

