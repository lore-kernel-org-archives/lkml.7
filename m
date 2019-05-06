Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C630C04AAE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58001208C2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfEFFtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 01:49:03 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:57922 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfEFFtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 01:49:02 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 01:48:55 EDT
Received: from [151.41.47.232] (account l.abeni@santannapisa.it HELO sweethome.home-life.hub)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 138841008; Mon, 06 May 2019 06:48:58 +0200
From:   Luca Abeni <luca.abeni@santannapisa.it>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        luca abeni <luca.abeni@santannapisa.it>
Subject: [RFC PATCH 2/6] sched/dl: Capacity-aware migrations
Date:   Mon,  6 May 2019 06:48:32 +0200
Message-Id: <20190506044836.2914-3-luca.abeni@santannapisa.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506044836.2914-1-luca.abeni@santannapisa.it>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luca abeni <luca.abeni@santannapisa.it>

Currently, the SCHED_DEADLINE scheduler uses a global EDF scheduling
algorithm, migrating tasks to CPU cores without considering the core
capacity and the task utilization. This works well on homogeneous
systems (SCHED_DEADLINE tasks are guaranteed to have a bounded
tardiness), but presents some issues on heterogeneous systems. For
example, a SCHED_DEADLINE task might be migrated on a core that has not
enough processing capacity to correctly serve the task (think about a
task with runtime 70ms and period 100ms migrated to a core with
processing capacity 0.5)

This commit is a first step to address the issue: When a task wakes
up or migrates away from a CPU core, the scheduler tries to find an
idle core having enough processing capacity to serve the task.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/cpudeadline.c | 31 +++++++++++++++++++++++++++++--
 kernel/sched/deadline.c    |  8 ++++++--
 kernel/sched/sched.h       |  7 ++++++-
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 50316455ea66..d21f7905b9c1 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -110,6 +110,22 @@ static inline int cpudl_maximum(struct cpudl *cp)
 	return cp->elements[0].cpu;
 }
 
+static inline int dl_task_fit(const struct sched_dl_entity *dl_se,
+			      int cpu, u64 *c)
+{
+	u64 cap = (arch_scale_cpu_capacity(NULL, cpu) * arch_scale_freq_capacity(cpu)) >> SCHED_CAPACITY_SHIFT;
+	s64 rel_deadline = dl_se->dl_deadline;
+	u64 rem_runtime  = dl_se->dl_runtime;
+
+	if (c)
+		*c = cap;
+
+	if ((rel_deadline * cap) >> SCHED_CAPACITY_SHIFT < rem_runtime)
+		return 0;
+
+	return 1;
+}
+
 /*
  * cpudl_find - find the best (later-dl) CPU in the system
  * @cp: the cpudl max-heap context
@@ -125,8 +141,19 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 
 	if (later_mask &&
 	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_allowed)) {
-		return 1;
-	} else {
+		int cpu;
+
+		for_each_cpu(cpu, later_mask) {
+			u64 cap;
+
+			if (!dl_task_fit(&p->dl, cpu, &cap))
+				cpumask_clear_cpu(cpu, later_mask);
+		}
+
+		if (!cpumask_empty(later_mask))
+			return 1;
+	}
+	{
 		int best_cpu = cpudl_maximum(cp);
 
 		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5b981eeeb944..3436f3d8fa8f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1584,6 +1584,9 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
 	if (sd_flag != SD_BALANCE_WAKE)
 		goto out;
 
+	if (dl_entity_is_special(&p->dl))
+		goto out;
+
 	rq = cpu_rq(cpu);
 
 	rcu_read_lock();
@@ -1598,10 +1601,11 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
 	 * other hand, if it has a shorter deadline, we
 	 * try to make it stay here, it might be important.
 	 */
-	if (unlikely(dl_task(curr)) &&
+	if ((unlikely(dl_task(curr)) &&
 	    (curr->nr_cpus_allowed < 2 ||
 	     !dl_entity_preempt(&p->dl, &curr->dl)) &&
-	    (p->nr_cpus_allowed > 1)) {
+	    (p->nr_cpus_allowed > 1)) ||
+	    static_branch_unlikely(&sched_asym_cpucapacity)) {
 		int target = find_later_rq(p);
 
 		if (target != -1 &&
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 32d242694863..e5f9fd3aee80 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2367,7 +2367,12 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
-	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
+	unsigned long res;
+
+	res = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
+
+	return (res << SCHED_CAPACITY_SHIFT) /
+	       arch_scale_cpu_capacity(NULL, rq->cpu);
 }
 
 static inline unsigned long cpu_util_dl(struct rq *rq)
-- 
2.20.1

