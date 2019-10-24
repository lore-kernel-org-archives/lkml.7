Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D44E20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="whQQndDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437769AbfJXGqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 02:46:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37089 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfJXGqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 02:46:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so13632365pgi.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 23:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NgFTobKzYLIoybimGSOXWg5eOtygrhwDEBEYyn3XxEY=;
        b=whQQndDhmoaZK9OecPknNrAyqb6J4Qy15F9F+r54pyj8/muqFAkT4vfgH6jCOH6K/l
         brQ6bB7gE1MNTawZQCct3jWf0VaVfXaLzHESz7uVzlgPu/2dmuAC7IvO61y/BG5iVWWT
         RZflyRHfwYYxJDDUkJqdwZDsZJlSFQ2DyAlkDAC3We5tIANqzQNu3D66tVwu2PZLr8gF
         zxVWntqQuoZSIcT8PcD0u5vdpHQh7LHNOLj82mWDmFV5oIjI3l4e10lQrgvhSWvocGV+
         A1xqlQhfAsc336vPQaN5B7P5L41ZUy4bNPnSkYCH6R/1TR/G1XiPkgDOp6hY/qkTv3yO
         KmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NgFTobKzYLIoybimGSOXWg5eOtygrhwDEBEYyn3XxEY=;
        b=thWbVwsAJnR5SYPF6QiMwL4dcw4Zmyg050SMhMOvkhMl+r4LAAsIr2xbBGXGMZQ2qW
         NdAG8tvfZiUVSmKHetmZR/Rewtkh5khU2x2ABQDAyEHhbe8ZJlXs7RMm4hnUwii4007a
         6nSa88WDYT+22oX7OSz3GBW1RXYx9fEYIjg0Ha6YB7lgA5J0ZFroce+BgcfbVk2hs3qS
         rmDDE9QENQiiguzvbD/q4n5aPwIbI74UnmVGODUGWQ5v7iP9IIEgWcIy4Q5g3oXDXQmm
         JQlH05a60kGpqgqUQpR9wu7PseqG4MYH+t6HVpdsqiedui5kuSDmigWkn2MaqMKFhiIA
         Tfjw==
X-Gm-Message-State: APjAAAU3RggDDMMz95F5K/iZwP1j31aeZMLSjaqFefadJgsMuwizeLAM
        MX7oitCOMhK0fl6qcubZUY6ZTw==
X-Google-Smtp-Source: APXvYqxjztcFISdvUxpx1aE88ZJTxLK90schhsrtICBont1kx2A2OOF1Dxai5vgrM1pndnCrIb5a1w==
X-Received: by 2002:a63:4553:: with SMTP id u19mr14508400pgk.436.1571899562379;
        Wed, 23 Oct 2019 23:46:02 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id l72sm2536946pjb.7.2019.10.23.23.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 23:46:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Make sched-idle cpu selection consistent throughout
Date:   Thu, 24 Oct 2019 12:15:27 +0530
Message-Id: <5eba2fb4af9ebc7396101bb9bd6c8aa9c8af0710.1571899508.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are instances where we keep searching for an idle CPU despite
having a sched-idle cpu already (in find_idlest_group_cpu(),
select_idle_smt() and select_idle_cpu() and then there are places where
we don't necessarily do that and return a sched-idle cpu as soon as we
find one (in select_idle_sibling()). This looks a bit inconsistent and
it may be worth having the same policy everywhere.

On the other hand, choosing a sched-idle cpu over a idle one shall be
beneficial from performance point of view as well, as we don't need to
get the cpu online from a deep idle state which is quite a time
consuming process and delays the scheduling of the newly wakeup task.

This patch tries to simplify code around sched-idle cpu selection and
make it consistent throughout.

FWIW, tests were done with the help of rt-app (8 SCHED_OTHER and 5
SCHED_IDLE tasks, not bound to any cpu) on ARM platform (octa-core), and
no significant difference in scheduling latency of SCHED_OTHER tasks was
found.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a81c36472822..bb367f48c1ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5545,7 +5545,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 	unsigned int min_exit_latency = UINT_MAX;
 	u64 latest_idle_timestamp = 0;
 	int least_loaded_cpu = this_cpu;
-	int shallowest_idle_cpu = -1, si_cpu = -1;
+	int shallowest_idle_cpu = -1;
 	int i;
 
 	/* Check if we have any choice: */
@@ -5554,6 +5554,9 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
+		if (sched_idle_cpu(i))
+			return i;
+
 		if (available_idle_cpu(i)) {
 			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
@@ -5576,12 +5579,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 				latest_idle_timestamp = rq->idle_stamp;
 				shallowest_idle_cpu = i;
 			}
-		} else if (shallowest_idle_cpu == -1 && si_cpu == -1) {
-			if (sched_idle_cpu(i)) {
-				si_cpu = i;
-				continue;
-			}
-
+		} else if (shallowest_idle_cpu == -1) {
 			load = cpu_load(cpu_rq(i));
 			if (load < min_load) {
 				min_load = load;
@@ -5590,11 +5588,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 		}
 	}
 
-	if (shallowest_idle_cpu != -1)
-		return shallowest_idle_cpu;
-	if (si_cpu != -1)
-		return si_cpu;
-	return least_loaded_cpu;
+	return shallowest_idle_cpu != -1 ? shallowest_idle_cpu : least_loaded_cpu;
 }
 
 static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p,
@@ -5747,7 +5741,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
  */
 static int select_idle_smt(struct task_struct *p, int target)
 {
-	int cpu, si_cpu = -1;
+	int cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
 		return -1;
@@ -5755,13 +5749,11 @@ static int select_idle_smt(struct task_struct *p, int target)
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
 		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 			continue;
-		if (available_idle_cpu(cpu))
+		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
-		if (si_cpu == -1 && sched_idle_cpu(cpu))
-			si_cpu = cpu;
 	}
 
-	return si_cpu;
+	return -1;
 }
 
 #else /* CONFIG_SCHED_SMT */
@@ -5790,7 +5782,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 time, cost;
 	s64 delta;
 	int this = smp_processor_id();
-	int cpu, nr = INT_MAX, si_cpu = -1;
+	int cpu, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -5818,13 +5810,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
 		if (!--nr)
-			return si_cpu;
+			return -1;
 		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 			continue;
-		if (available_idle_cpu(cpu))
+		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			break;
-		if (si_cpu == -1 && sched_idle_cpu(cpu))
-			si_cpu = cpu;
 	}
 
 	time = cpu_clock(this) - time;
-- 
2.21.0.rc0.269.g1a574e7a288b

