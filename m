Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2044BC2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 05:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE200206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 05:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="beZ4cUJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfLXFNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 00:13:36 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54367 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbfLXFNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 00:13:36 -0500
Received: by mail-pj1-f68.google.com with SMTP id kx11so709661pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 21:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uArY/n7lKcudSIQdaanha3jWm3R3XwcyZLgpfo2NysM=;
        b=beZ4cUJWJvHXnXxWzVcM+aTuAiQ49q/wwIJsWIUkHuXJ+tHW8tohuOK3lSlzPE2Tnr
         AaYCORZpELGM5GlHzxhMRiZuUn/jtmjOq4ahXHpCjxLlT3GEaNMmSFW2stfQVfnyqKQX
         HSila6kJz/xUkjW435LQfIBoGDJ/AM+JvxXRVW26jnBRtD8abYbXPHrOwcOuZ+3/oY9z
         uroOPiOSEKsc9Ws84m48Sf2Gb/E8EZcROmvX6OGcRa6j9c/bdYjof6cISZwkEfGNVejb
         WO1OLtC9V1FxlMp9bNNpsuNM+kEfMeG5h7oYETlozta5QInj1NbMOUhK5t6UuodYFIRy
         mFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uArY/n7lKcudSIQdaanha3jWm3R3XwcyZLgpfo2NysM=;
        b=LZEl0fDPRZSNSxVY4MnDZgVJOnQrMjKpg8WyNdPN+dSP3iB7d7dQjsq0s63N1u1JxY
         +mBm3RoAKEjwVyEfiputmUnpNvMq26uCZBL31FFdlJOPSl8lFqghd+G9EM+RaZBxmSOF
         aSesQaN/2b8JkDwwxhmbJ8BKpeJ0hy+Q0UgQyN4x11J7jnmge9PO3B7+d1EGkgg+z83t
         +dOrBC76rxWjGEfRNocvKQZv/cwJ06FMqoiPnsK7YAFY3Na7kvrQxSL4lRx5HAr02zAa
         KdqdsTBeiXrnHBRIuoI21LZ/7YxjOAl+ZIRU0KuhLasRpNOS4VW+404esQP0T/0kH3/q
         mpdw==
X-Gm-Message-State: APjAAAXlFO1osVlrxfaHtPhrwCSWqY3b3d3tHtlZZ9iq2fcyi5WunNVC
        4CSbNCiRI19j7w4FQoZaXkYRdoBQzb4=
X-Google-Smtp-Source: APXvYqw9VewohPDFkaKNKSDYX975Sw03Cb61j2YU8XC8E06d+Ko6uwLAMirYrA1w7O6uG9XEro4Wjw==
X-Received: by 2002:a17:90a:a88d:: with SMTP id h13mr3394363pjq.55.1577164415381;
        Mon, 23 Dec 2019 21:13:35 -0800 (PST)
Received: from localhost ([122.171.234.168])
        by smtp.gmail.com with ESMTPSA id i3sm26058099pfg.94.2019.12.23.21.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 21:13:34 -0800 (PST)
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
Subject: [PATCH] sched/fair: Load balance aggressively for SCHED_IDLE CPUs
Date:   Tue, 24 Dec 2019 10:43:30 +0530
Message-Id: <885b1be9af68d124f44a863f54e337f8eb6c4917.1577090998.git.viresh.kumar@linaro.org>
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 83500b5b93dc..645eb248a2d0 100644
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
@@ -9582,10 +9591,16 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 				 * env->dst_cpu, so we can't know our idle
 				 * state even if we migrated tasks. Update it.
 				 */
-				idle = idle_cpu(cpu) ? CPU_IDLE : CPU_NOT_IDLE;
+				if (idle_cpu(cpu)) {
+					idle = CPU_IDLE;
+					busy = 0;
+				} else {
+					idle = CPU_NOT_IDLE;
+					busy = !sched_idle_cpu(cpu);
+				}
 			}
 			sd->last_balance = jiffies;
-			interval = get_sd_balance_interval(sd, idle != CPU_IDLE);
+			interval = get_sd_balance_interval(sd, busy);
 		}
 		if (need_serialize)
 			spin_unlock(&balancing);
-- 
2.21.0.rc0.269.g1a574e7a288b

