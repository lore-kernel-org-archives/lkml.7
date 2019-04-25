Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFCFC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B089E214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7k0W7bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfDYJhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:37:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34051 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfDYJhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:37:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so10831791plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VxJHwMzwUC98NetKMBaSVmux2SmEBHzy7mtAhsKX81g=;
        b=D7k0W7bi+xA2D+e+ltNJAPSgTGiJWE2lFoihqveBXLl44pk3niJa9NTdPbh2WrMMig
         T/k4eOG/q3M4oMs7VflyUURz0JTx5d0NQckbSwOtEv6wexIA9U0EbGYyMI9Oc22je+ef
         46yHHl0CJY95v7ISduXRs8mupNH/G0uYl9paXlwasBw4MNij9AenhXPWfPFno/jnNlmV
         +PXbap3M7CvxWx06poiISMFME5Whg803sNTXS6S583CsgTDRxVAzzYxE5IRmcu6kIAi5
         Jp5FGEfwNq5xhnnDI5Ms3fWJaedUTiOyi72k/FintRuXdkoW6wZRo5nO7hjCJs8EwFZN
         heHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VxJHwMzwUC98NetKMBaSVmux2SmEBHzy7mtAhsKX81g=;
        b=Rp/vyTnPmmGhMMFB1ik1iXq6VR/mlGxZra5wasWjvqWLXYscDgZGdgGntZyTOYOwJF
         R/7Hzi6UnO+fYhMr4BKD9RpLwPUKKNCRht8a17d8ArO/+ZJb4f81iroGlgYX43JwUUqo
         kOAKXjEynSHI58629qm8AiLkT1NeCXeKP0x0PsfEYF1nxXjbQkj/H8V3mlomHw3t886x
         bEYKhfRAVcAUw0Mfjy6KqwDDumMfUhpey80y9oRGagzm2Qi6PyRrOV4l9BEMoUKWWZwm
         oek21ZZnS3vA1mcPY7FYx+S3j6HOfIckGB/s4FkwQ6Xw7D66Dm1W9/+F1IIXQ1+MUQT8
         f6Ww==
X-Gm-Message-State: APjAAAUEjY2wqv9BkwtJkV/Najplok1GsRUaxYRVm3zvvquX6snB2v52
        dC2pvhN3HLT96FzeKjE7hrfnXw==
X-Google-Smtp-Source: APXvYqycGk2SrfJHcBlrStxcAOJpfQtkFPxQ1jjPFXykwyfGEqaoJNLpRVzDsfWG0KUqKDTSTxNLkw==
X-Received: by 2002:a17:902:7d8f:: with SMTP id a15mr37534600plm.3.1556185070478;
        Thu, 25 Apr 2019 02:37:50 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id b13sm30552400pfd.12.2019.04.25.02.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:37:49 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org
Subject: [RFC V2 2/2] sched/fair: Fallback to sched-idle CPU if idle CPU isn't found
Date:   Thu, 25 Apr 2019 15:07:40 +0530
Message-Id: <59b37c56b8fcb834f7d3234e776eaeff74ad117f.1556182965.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1556182964.git.viresh.kumar@linaro.org>
References: <cover.1556182964.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We target for an idle CPU in select_idle_sibling() to run the next task,
but in case we don't find idle CPUs it is better to pick a CPU which
will run the task the soonest, for performance reason. A CPU which isn't
idle but has only SCHED_IDLE activity queued on it should be a good
target based on this criteria as any normal fair task will most likely
preempt the currently running SCHED_IDLE task immediately. In fact,
choosing a SCHED_IDLE CPU shall give better results as it should be able
to run the task sooner than an idle CPU (which requires to be woken up
from an idle state).

This patch updates the fast path to fallback to a sched-idle CPU if the
idle CPU isn't found, the slow path can be updated separately later.

Following is the order in which select_idle_sibling() picks up next CPU
to run the task now:

1. idle_cpu(target) OR sched_idle_cpu(target)
2. idle_cpu(prev) OR sched_idle_cpu(prev)
3. idle_cpu(recent_used_cpu) OR sched_idle_cpu(recent_used_cpu)
4. idle core(sd)
5. idle_cpu(sd)
6. sched_idle_cpu(sd)
7. idle_cpu(p) - smt
8. sched_idle_cpu(p)- smt

Though the policy can be tweaked a bit if we want to have different
priorities.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6511cb57acdd..fbaefb9a9296 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6057,6 +6057,15 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 	return new_cpu;
 }
 
+/* CPU only has SCHED_IDLE tasks enqueued */
+static int sched_idle_cpu(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
+			rq->nr_running);
+}
+
 #ifdef CONFIG_SCHED_SMT
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
@@ -6154,7 +6163,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
  */
 static int select_idle_smt(struct task_struct *p, int target)
 {
-	int cpu;
+	int cpu, si_cpu = -1;
 
 	if (!static_branch_likely(&sched_smt_present))
 		return -1;
@@ -6164,9 +6173,11 @@ static int select_idle_smt(struct task_struct *p, int target)
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
@@ -6194,7 +6205,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, nr = INT_MAX;
+	int cpu, nr = INT_MAX, si_cpu = -1;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6222,11 +6233,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
 		if (!--nr)
-			return -1;
+			return si_cpu;
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
 			continue;
 		if (available_idle_cpu(cpu))
 			break;
+		if (si_cpu == -1 && sched_idle_cpu(cpu))
+			si_cpu = cpu;
 	}
 
 	time = local_clock() - time;
@@ -6245,13 +6258,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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
@@ -6259,7 +6273,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
-	    available_idle_cpu(recent_used_cpu) &&
+	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, &p->cpus_allowed)) {
 		/*
 		 * Replace recent_used_cpu with prev as it is a potential
-- 
2.21.0.rc0.269.g1a574e7a288b

