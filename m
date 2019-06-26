Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D033C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6268A208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQwE7NU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfFZFGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 01:06:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43864 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfFZFGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:06:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so711621plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 22:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xzo/mnAvVEkpnq/buLdSuv4HV/H6/z86Y20R9WnPjE4=;
        b=eQwE7NU+oCp9KQLtu9if6s1naRyX6V47OLHvSUOnQMJ57wE+SdMi2eKkLSlOb1qbh5
         8LPJLx3BspfBQgsO4BgJ2IAotpJk7MPyWQiK5nw6qDnPpCv/smYkWpuyi9dDIwgBS8/M
         D6AiPX8T8EQKfPoZwuHWUQLIN+peIPHkz0+eHbltgRjgCiuGV+OSWwobVagioOE9IKi/
         j2KLd+qBcB9t36RKX+2Mzqrw2LcZx6/XOYdrdViJk1IxBlsDrFg8C/4oX7T7YgqYeO2B
         zaYR3DLn5Y6/83Prbprq79lVnywZ75NHOvSHzOc3UX0YFm+YGx0MRfF6fi0YypiHyu5k
         17sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xzo/mnAvVEkpnq/buLdSuv4HV/H6/z86Y20R9WnPjE4=;
        b=J1M1WVExQL2XQLbWuTUfnW1YgHbfvofNEuyffIwGXvvncjwuy1BUcXxBI+faZl/u5e
         lLnc1nKl1JzEI0iPYCUL4kz+dIFqhygtGfkH4D2SQVd8EuRiZGl/cV2K7vVkFFFhTNej
         4EJtWqbJocIimlsE8MaXH7iHoKEjwgiodMct1VvrebhAbs5/dWbDIN/3mARzw6ALqcji
         DMVeLp61iea0T2DNsQFttzuAGpIMlXytjF/6vWkRO3gZYTLdt6GBtF/UYK/VaidFB81Y
         PPSwE5pRFpbbvChQQO5cP8pWtEHADQj8O/IzSTphtZKfCwbFxKNAIvM8UWkyPc43LokF
         Gu/g==
X-Gm-Message-State: APjAAAWlkqNPSdzlD34tYEOGH5WUKB+ktEhAOH3fwwL3IncNJRfRzjjC
        i6xPo2ICL2CRHcNfHD6YCwZ3IQ==
X-Google-Smtp-Source: APXvYqzlP7Bt0TpK2sgaNGz2joalNPwHdeVOqqkSnKMMtWSLq9pJcJtSk7/ZeY5yXVukzdZR+tGFug==
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr2854591pld.119.1561525610441;
        Tue, 25 Jun 2019 22:06:50 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id d6sm18462347pgf.55.2019.06.25.22.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 22:06:49 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, subhra.mazumdar@oracle.com,
        songliubraving@fb.com
Subject: [PATCH V3 2/2] sched/fair: Fallback to sched-idle CPU if idle CPU isn't found
Date:   Wed, 26 Jun 2019 10:36:30 +0530
Message-Id: <eeafa25fdeb6f6edd5b2da716bc8f0ba7708cbcf.1561523542.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561523542.git.viresh.kumar@linaro.org>
References: <cover.1561523542.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We try to find an idle CPU to run the next task, but in case we don't
find an idle CPU it is better to pick a CPU which will run the task the
soonest, for performance reason.

A CPU which isn't idle but has only SCHED_IDLE activity queued on it
should be a good target based on this criteria as any normal fair task
will most likely preempt the currently running SCHED_IDLE task
immediately. In fact, choosing a SCHED_IDLE CPU over a fully idle one
shall give better results as it should be able to run the task sooner
than an idle CPU (which requires to be woken up from an idle state).

This patch updates both fast and slow paths with this optimization.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1277adc3e7ed..2e0527fd468c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5376,6 +5376,15 @@ static struct {
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
+/* CPU only has SCHED_IDLE tasks enqueued */
+static int sched_idle_cpu(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
+			rq->nr_running);
+}
+
 static unsigned long cpu_runnable_load(struct rq *rq)
 {
 	return cfs_rq_runnable_load_avg(&rq->cfs);
@@ -5698,7 +5707,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 	unsigned int min_exit_latency = UINT_MAX;
 	u64 latest_idle_timestamp = 0;
 	int least_loaded_cpu = this_cpu;
-	int shallowest_idle_cpu = -1;
+	int shallowest_idle_cpu = -1, si_cpu = -1;
 	int i;
 
 	/* Check if we have any choice: */
@@ -5729,7 +5738,12 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 				latest_idle_timestamp = rq->idle_stamp;
 				shallowest_idle_cpu = i;
 			}
-		} else if (shallowest_idle_cpu == -1) {
+		} else if (shallowest_idle_cpu == -1 && si_cpu == -1) {
+			if (sched_idle_cpu(i)) {
+				si_cpu = i;
+				continue;
+			}
+
 			load = cpu_runnable_load(cpu_rq(i));
 			if (load < min_load) {
 				min_load = load;
@@ -5738,7 +5752,11 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 		}
 	}
 
-	return shallowest_idle_cpu != -1 ? shallowest_idle_cpu : least_loaded_cpu;
+	if (shallowest_idle_cpu != -1)
+		return shallowest_idle_cpu;
+	if (si_cpu != -1)
+		return si_cpu;
+	return least_loaded_cpu;
 }
 
 static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p,
@@ -5891,7 +5909,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
  */
 static int select_idle_smt(struct task_struct *p, int target)
 {
-	int cpu;
+	int cpu, si_cpu = -1;
 
 	if (!static_branch_likely(&sched_smt_present))
 		return -1;
@@ -5901,9 +5919,11 @@ static int select_idle_smt(struct task_struct *p, int target)
 			continue;
 		if (available_idle_cpu(cpu))
 			return cpu;
+		if (si_cpu == -1 && sched_idle_cpu(cpu))
+			si_cpu = cpu;
 	}
 
-	return -1;
+	return si_cpu;
 }
 
 #else /* CONFIG_SCHED_SMT */
@@ -5931,7 +5951,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, nr = INT_MAX;
+	int cpu, nr = INT_MAX, si_cpu = -1;
 	int this = smp_processor_id();
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
@@ -5960,11 +5980,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
 		if (!--nr)
-			return -1;
+			return si_cpu;
 		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 			continue;
 		if (available_idle_cpu(cpu))
 			break;
+		if (si_cpu == -1 && sched_idle_cpu(cpu))
+			si_cpu = cpu;
 	}
 
 	time = cpu_clock(this) - time;
@@ -5983,13 +6005,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
-	if (available_idle_cpu(target))
+	if (available_idle_cpu(target) || sched_idle_cpu(target))
 		return target;
 
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) && available_idle_cpu(prev))
+	if (prev != target && cpus_share_cache(prev, target) &&
+	    (available_idle_cpu(prev) || sched_idle_cpu(prev)))
 		return prev;
 
 	/* Check a recently used CPU as a potential idle candidate: */
@@ -5997,7 +6020,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
-	    available_idle_cpu(recent_used_cpu) &&
+	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr)) {
 		/*
 		 * Replace recent_used_cpu with prev as it is a potential
-- 
2.21.0.rc0.269.g1a574e7a288b

