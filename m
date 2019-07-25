Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02A5C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BAE218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nsvkcERT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbfGYQVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:21:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38227 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389270AbfGYQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:21:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGLEVd1076251
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:21:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGLEVd1076251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071675;
        bh=cB9y3PKjHJf+huh/27TkLzlTxt9Hu4k/FtdI8pyOZ6E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nsvkcERT34a4HhTO7yIyESkDe4zdWO5FpObrSBN467m/H8f95RdqZouJveqLL9Vtd
         7DtazP+6vDXFXDGZbHBncqpAz2ICeVlwXL6z9dAbypb3ziNzjuguoHF6EgRpEUzduJ
         QNYdsFK2FQQA7IljWVPNLywnpt6UyeQWCPu7q3fUr6SnptQ2r8D6pH79MGKULxAUeQ
         ZKb6ee5IIxBoXsxMfHW+TNjAWSnK9qT3hoadcOZWSv6uz55CIBDL5fvf5Lb+FZCNOV
         r9D+Yp1qDp+rf+fvRim+WSTk4B5h24J0BG7i9WF0TYMybTOfMKDB/DOBvev/CpGLKb
         ahbvAJ2ZQsvEg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGLDGg1076243;
        Thu, 25 Jul 2019 09:21:13 -0700
Date:   Thu, 25 Jul 2019 09:21:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-f9a25f776d780bfa3279f0b6e5f5cf3224997976@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, mathieu.poirier@linaro.org,
        dietmar.eggemann@arm.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          mathieu.poirier@linaro.org, dietmar.eggemann@arm.com,
          peterz@infradead.org, hpa@zytor.com, juri.lelli@redhat.com
In-Reply-To: <20190719140000.31694-4-juri.lelli@redhat.com>
References: <20190719140000.31694-4-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] cpusets: Rebuild root domain deadline accounting
 information
Git-Commit-ID: f9a25f776d780bfa3279f0b6e5f5cf3224997976
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f9a25f776d780bfa3279f0b6e5f5cf3224997976
Gitweb:     https://git.kernel.org/tip/f9a25f776d780bfa3279f0b6e5f5cf3224997976
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 19 Jul 2019 15:59:55 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:55:01 +0200

cpusets: Rebuild root domain deadline accounting information

When the topology of root domains is modified by CPUset or CPUhotplug
operations information about the current deadline bandwidth held in the
root domain is lost.

This patch addresses the issue by recalculating the lost deadline
bandwidth information by circling through the deadline tasks held in
CPUsets and adding their current load to the root domain they are
associated with.

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[ Various additional modifications. ]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bristot@redhat.com
Cc: claudio@evidence.eu.com
Cc: lizefan@huawei.com
Cc: longman@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: rostedt@goodmis.org
Cc: tj@kernel.org
Cc: tommaso.cucinotta@santannapisa.it
Link: https://lkml.kernel.org/r/20190719140000.31694-4-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/cgroup.h         |  1 +
 include/linux/sched.h          |  5 ++++
 include/linux/sched/deadline.h |  8 ++++++
 kernel/cgroup/cgroup.c         |  2 +-
 kernel/cgroup/cpuset.c         | 64 +++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/deadline.c        | 30 ++++++++++++++++++++
 kernel/sched/sched.h           |  3 --
 kernel/sched/topology.c        | 13 ++++++++-
 8 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f6b048902d6c..3ba3e6da13a6 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -150,6 +150,7 @@ struct task_struct *cgroup_taskset_first(struct cgroup_taskset *tset,
 struct task_struct *cgroup_taskset_next(struct cgroup_taskset *tset,
 					struct cgroup_subsys_state **dst_cssp);
 
+void cgroup_enable_task_cg_lists(void);
 void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 			 struct css_task_iter *it);
 struct task_struct *css_task_iter_next(struct css_task_iter *it);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9f51932bd543..b94ad92dfbe6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -295,6 +295,11 @@ enum uclamp_id {
 	UCLAMP_CNT
 };
 
+#ifdef CONFIG_SMP
+extern struct root_domain def_root_domain;
+extern struct mutex sched_domains_mutex;
+#endif
+
 struct sched_info {
 #ifdef CONFIG_SCHED_INFO
 	/* Cumulative counters: */
diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 0cb034331cbb..1aff00b65f3c 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -24,3 +24,11 @@ static inline bool dl_time_before(u64 a, u64 b)
 {
 	return (s64)(a - b) < 0;
 }
+
+#ifdef CONFIG_SMP
+
+struct root_domain;
+extern void dl_add_task_root_domain(struct task_struct *p);
+extern void dl_clear_root_domain(struct root_domain *rd);
+
+#endif /* CONFIG_SMP */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 753afbca549f..4b5bc452176c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1891,7 +1891,7 @@ static int cgroup_reconfigure(struct fs_context *fc)
  */
 static bool use_task_css_set_links __read_mostly;
 
-static void cgroup_enable_task_cg_lists(void)
+void cgroup_enable_task_cg_lists(void)
 {
 	struct task_struct *p, *g;
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5aa37531ce76..846cbdb68566 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -45,6 +45,7 @@
 #include <linux/proc_fs.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/sched/deadline.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/seq_file.h>
@@ -894,6 +895,67 @@ done:
 	return ndoms;
 }
 
+static void update_tasks_root_domain(struct cpuset *cs)
+{
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	css_task_iter_start(&cs->css, 0, &it);
+
+	while ((task = css_task_iter_next(&it)))
+		dl_add_task_root_domain(task);
+
+	css_task_iter_end(&it);
+}
+
+static void rebuild_root_domains(void)
+{
+	struct cpuset *cs = NULL;
+	struct cgroup_subsys_state *pos_css;
+
+	lockdep_assert_held(&cpuset_mutex);
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&sched_domains_mutex);
+
+	cgroup_enable_task_cg_lists();
+
+	rcu_read_lock();
+
+	/*
+	 * Clear default root domain DL accounting, it will be computed again
+	 * if a task belongs to it.
+	 */
+	dl_clear_root_domain(&def_root_domain);
+
+	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
+
+		if (cpumask_empty(cs->effective_cpus)) {
+			pos_css = css_rightmost_descendant(pos_css);
+			continue;
+		}
+
+		css_get(&cs->css);
+
+		rcu_read_unlock();
+
+		update_tasks_root_domain(cs);
+
+		rcu_read_lock();
+		css_put(&cs->css);
+	}
+	rcu_read_unlock();
+}
+
+static void
+partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+				    struct sched_domain_attr *dattr_new)
+{
+	mutex_lock(&sched_domains_mutex);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
+	rebuild_root_domains();
+	mutex_unlock(&sched_domains_mutex);
+}
+
 /*
  * Rebuild scheduler domains.
  *
@@ -931,7 +993,7 @@ static void rebuild_sched_domains_locked(void)
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
-	partition_sched_domains(ndoms, doms, attr);
+	partition_and_rebuild_sched_domains(ndoms, doms, attr);
 out:
 	put_online_cpus();
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ef5b9f6b1d42..0f9d2180be23 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2283,6 +2283,36 @@ void __init init_sched_dl_class(void)
 					GFP_KERNEL, cpu_to_node(i));
 }
 
+void dl_add_task_root_domain(struct task_struct *p)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+	struct dl_bw *dl_b;
+
+	rq = task_rq_lock(p, &rf);
+	if (!dl_task(p))
+		goto unlock;
+
+	dl_b = &rq->rd->dl_bw;
+	raw_spin_lock(&dl_b->lock);
+
+	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
+
+	raw_spin_unlock(&dl_b->lock);
+
+unlock:
+	task_rq_unlock(rq, p, &rf);
+}
+
+void dl_clear_root_domain(struct root_domain *rd)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
+	rd->dl_bw.total_bw = 0;
+	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
+}
+
 #endif /* CONFIG_SMP */
 
 static void switched_from_dl(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 16126efd14ed..7583faddba33 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -778,9 +778,6 @@ struct root_domain {
 	struct perf_domain __rcu *pd;
 };
 
-extern struct root_domain def_root_domain;
-extern struct mutex sched_domains_mutex;
-
 extern void init_defrootdomain(void);
 extern int sched_init_domains(const struct cpumask *cpu_map);
 extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 5a174ae6ecf3..8f83e8e3ea9a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2203,8 +2203,19 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	for (i = 0; i < ndoms_cur; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
 			if (cpumask_equal(doms_cur[i], doms_new[j]) &&
-			    dattrs_equal(dattr_cur, i, dattr_new, j))
+			    dattrs_equal(dattr_cur, i, dattr_new, j)) {
+				struct root_domain *rd;
+
+				/*
+				 * This domain won't be destroyed and as such
+				 * its dl_bw->total_bw needs to be cleared.  It
+				 * will be recomputed in function
+				 * update_tasks_root_domain().
+				 */
+				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
+				dl_clear_root_domain(rd);
 				goto match1;
+			}
 		}
 		/* No match - a current sched domain not in new doms_new[] */
 		detach_destroy_domains(doms_cur[i]);
