Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3C0C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB132148E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfDCIrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:47:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39589 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbfDCIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:47:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so7100621wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ErBaTttEX1F6sU4SnXuSVyJtw4L8yfU+WqQx6AeK3k0=;
        b=Te5uaWVGPsSYFhgTX+/qiL9u4A/NetXYQRfjjpOfwruHLUTYcFvoof7k7u92RZirwv
         cKJpgP6AzhKm2UT7A2YBrOStrZmkBFEamBmNAm2rRB3iiCKqgJFW8TngpMh2E75++rpp
         JfmBRBz8j4uWA5xukX4lS5p4bcDNzn9jHmb6419gWWB9E6keOFBT4bQFxebMlezzG7sV
         aAh0lHTB8vyqzyICiSrMsvL76FnA1cO1nn5Z9S17VuPfA+yqWVBzSwy20zxdzbHNLeys
         ieUzWpnRfYYmV/2vAMrSMr93wix5dk1cVIUIsnPiWOtPfXTrl1A+QeyMZkp6BWCP26N2
         wUcw==
X-Gm-Message-State: APjAAAXNtu+e0JCH+cauTqGoBxCI/FS4NI0u1Vg+NcV4jq9Uuh5jef2h
        FRXgzL96IfA5BZok7M0xNf8x+g==
X-Google-Smtp-Source: APXvYqzj42d7ftYscB6DGDsB6Mn1Caa74JRUkSAHcO8WVp4hz7ZvX6Rc3g7JMDazT1ZZMrXM2Vpghg==
X-Received: by 2002:a1c:4d02:: with SMTP id o2mr1205404wmh.134.1554281237567;
        Wed, 03 Apr 2019 01:47:17 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id o2sm12258081wrs.89.2019.04.03.01.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:47:16 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v7 5/7] cpuset: Rebuild root domain deadline accounting information
Date:   Wed,  3 Apr 2019 10:46:48 +0200
Message-Id: <20190403084650.4414-6-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190403084650.4414-1-juri.lelli@redhat.com>
References: <20190403084650.4414-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the topology of root domains is modified by CPUset or CPUhotplug
operations information about the current deadline bandwidth held in the
root domain is lost.

This patch addresses the issue by recalculating the lost deadline
bandwidth information by circling through the deadline tasks held in
CPUsets and adding their current load to the root domain they are
associated with.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---

v6 -> v7: make dk_add_task_root_domain() use raw_spin_(un)lock() instead
          of the _irqsave variants as irqs are already disabled by task_
          rq_lock(). Also use __dl_add() to update root domain total_bw.
---
 include/linux/cgroup.h         |  1 +
 include/linux/sched.h          |  5 +++
 include/linux/sched/deadline.h |  8 +++++
 kernel/cgroup/cgroup.c         |  2 +-
 kernel/cgroup/cpuset.c         | 64 +++++++++++++++++++++++++++++++++-
 kernel/sched/deadline.c        | 30 ++++++++++++++++
 kernel/sched/sched.h           |  3 --
 kernel/sched/topology.c        | 13 ++++++-
 8 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 81f58b4a5418..c73470f073a1 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -144,6 +144,7 @@ struct task_struct *cgroup_taskset_first(struct cgroup_taskset *tset,
 struct task_struct *cgroup_taskset_next(struct cgroup_taskset *tset,
 					struct cgroup_subsys_state **dst_cssp);
 
+void cgroup_enable_task_cg_lists(void);
 void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 			 struct css_task_iter *it);
 struct task_struct *css_task_iter_next(struct css_task_iter *it);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1549584a1538..a3d4d3b1db21 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -282,6 +282,11 @@ struct vtime {
 	u64			gtime;
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
index 3f2b4bde0f9c..55ceb286882f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1839,7 +1839,7 @@ static int cgroup_reconfigure(struct fs_context *fc)
  */
 static bool use_task_css_set_links __read_mostly;
 
-static void cgroup_enable_task_cg_lists(void)
+void cgroup_enable_task_cg_lists(void)
 {
 	struct task_struct *p, *g;
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ca5364f037a1..cb5ff6ca5d2c 100644
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
@@ -949,6 +950,67 @@ static int generate_sched_domains(cpumask_var_t **domains,
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
@@ -986,7 +1048,7 @@ static void rebuild_sched_domains_locked(void)
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
-	partition_sched_domains(ndoms, doms, attr);
+	partition_and_rebuild_sched_domains(ndoms, doms, attr);
 out:
 	put_online_cpus();
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6a73e41a2016..c8a654b133da 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2284,6 +2284,36 @@ void __init init_sched_dl_class(void)
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
index efa686eeff26..35d551bc2ab6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -783,9 +783,6 @@ struct root_domain {
 	struct perf_domain	*pd;
 };
 
-extern struct root_domain def_root_domain;
-extern struct mutex sched_domains_mutex;
-
 extern void init_defrootdomain(void);
 extern int sched_init_domains(const struct cpumask *cpu_map);
 extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b63ac11d0831..2b475198268a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2188,8 +2188,19 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
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
-- 
2.17.2

