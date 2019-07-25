Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B04C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B548A22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="S6FvozyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390422AbfGYQXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:23:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46591 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388971AbfGYQXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:23:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGMgG61076465
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:22:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGMgG61076465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071763;
        bh=Opltyb754+G+CUU6RWtbrUw+m8e4wAw/JBIKiJ/XHQc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=S6FvozyOcrmxasVTWZSvj4bcBSD2Hm4jiVTBJEkbdQBJJXnBalSmEzmvbG2w5w27I
         ih30azNqqNNtte1C0xcedofEWyIRfEzQx8QXGqEokQ6yXwQv7AB+2JKbqDzlTv7Hk3
         j7bPfqgGLvsC7++YiDfaO/fjmNAgNvMd0iVcQzXx5OEJlTE+0xqPpWM6WoW5ybSWtD
         S8cBrUfcOop45e1sFDioGEbyCO96mYwXTgQKqmoAvby0F0ZExCnOV1jbTMHuLkC353
         WCqrXmJyhDXVJ4cHR5/Iwd+FK00Tv9/KMXLDyZBXAgBi1d5Xyi3hw/9dk+6koKYela
         3npWnfTe2b+fA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGMfSR1076454;
        Thu, 25 Jul 2019 09:22:41 -0700
Date:   Thu, 25 Jul 2019 09:22:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-1243dc518c9da467da6635313a2dbb41b8ffc275@git.kernel.org>
Cc:     dietmar.eggemann@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, juri.lelli@redhat.com, torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          dietmar.eggemann@arm.com, peterz@infradead.org,
          torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
          juri.lelli@redhat.com
In-Reply-To: <20190719140000.31694-6-juri.lelli@redhat.com>
References: <20190719140000.31694-6-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] cgroup/cpuset: Convert cpuset_mutex to
 percpu_rwsem
Git-Commit-ID: 1243dc518c9da467da6635313a2dbb41b8ffc275
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

Commit-ID:  1243dc518c9da467da6635313a2dbb41b8ffc275
Gitweb:     https://git.kernel.org/tip/1243dc518c9da467da6635313a2dbb41b8ffc275
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Fri, 19 Jul 2019 15:59:57 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:55:02 +0200

cgroup/cpuset: Convert cpuset_mutex to percpu_rwsem

Holding cpuset_mutex means that cpusets are stable (only the holder can
make changes) and this is required for fixing a synchronization issue
between cpusets and scheduler core.  However, grabbing cpuset_mutex from
setscheduler() hotpath (as implemented in a later patch) is a no-go, as
it would create a bottleneck for tasks concurrently calling
setscheduler().

Convert cpuset_mutex to be a percpu_rwsem (cpuset_rwsem), so that
setscheduler() will then be able to read lock it and avoid concurrency
issues.

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bristot@redhat.com
Cc: claudio@evidence.eu.com
Cc: lizefan@huawei.com
Cc: longman@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: mathieu.poirier@linaro.org
Cc: rostedt@goodmis.org
Cc: tj@kernel.org
Cc: tommaso.cucinotta@santannapisa.it
Link: https://lkml.kernel.org/r/20190719140000.31694-6-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/cgroup/cpuset.c | 68 ++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 846cbdb68566..e1a8d168c5e9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -333,7 +333,7 @@ static struct cpuset top_cpuset = {
  * guidelines for accessing subsystem state in kernel/cgroup.c
  */
 
-static DEFINE_MUTEX(cpuset_mutex);
+DEFINE_STATIC_PERCPU_RWSEM(cpuset_rwsem);
 static DEFINE_SPINLOCK(callback_lock);
 
 static struct workqueue_struct *cpuset_migrate_mm_wq;
@@ -913,7 +913,7 @@ static void rebuild_root_domains(void)
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
 
-	lockdep_assert_held(&cpuset_mutex);
+	percpu_rwsem_assert_held(&cpuset_rwsem);
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&sched_domains_mutex);
 
@@ -973,7 +973,7 @@ static void rebuild_sched_domains_locked(void)
 	cpumask_var_t *doms;
 	int ndoms;
 
-	lockdep_assert_held(&cpuset_mutex);
+	percpu_rwsem_assert_held(&cpuset_rwsem);
 	get_online_cpus();
 
 	/*
@@ -1005,9 +1005,9 @@ static void rebuild_sched_domains_locked(void)
 
 void rebuild_sched_domains(void)
 {
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	rebuild_sched_domains_locked();
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 }
 
 /**
@@ -1113,7 +1113,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	int deleting;	/* Moving cpus from subparts_cpus to effective_cpus */
 	bool part_error = false;	/* Partition error? */
 
-	lockdep_assert_held(&cpuset_mutex);
+	percpu_rwsem_assert_held(&cpuset_rwsem);
 
 	/*
 	 * The parent must be a partition root.
@@ -2101,7 +2101,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
 	cs = css_cs(css);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 
 	/* allow moving tasks into an empty cpuset if on default hierarchy */
 	ret = -ENOSPC;
@@ -2125,7 +2125,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cs->attach_in_progress++;
 	ret = 0;
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 	return ret;
 }
 
@@ -2135,9 +2135,9 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 
 	cgroup_taskset_first(tset, &css);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	css_cs(css)->attach_in_progress--;
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 }
 
 /*
@@ -2160,7 +2160,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 
 	/* prepare for attach */
 	if (cs == &top_cpuset)
@@ -2214,7 +2214,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
 
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 }
 
 /* The various types of files and directories in a cpuset file system */
@@ -2245,7 +2245,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = 0;
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
 		goto out_unlock;
@@ -2281,7 +2281,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 	return retval;
 }
 
@@ -2292,7 +2292,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = -ENODEV;
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2305,7 +2305,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 	return retval;
 }
 
@@ -2344,7 +2344,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	kernfs_break_active_protection(of->kn);
 	flush_work(&cpuset_hotplug_work);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2368,7 +2368,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 
 	free_cpuset(trialcs);
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
 	flush_workqueue(cpuset_migrate_mm_wq);
@@ -2499,13 +2499,13 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 		return -EINVAL;
 
 	css_get(&cs->css);
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
 	retval = update_prstate(cs, val);
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 	css_put(&cs->css);
 	return retval ?: nbytes;
 }
@@ -2711,7 +2711,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	if (!parent)
 		return 0;
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 
 	set_bit(CS_ONLINE, &cs->flags);
 	if (is_spread_page(parent))
@@ -2762,7 +2762,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 	return 0;
 }
 
@@ -2781,7 +2781,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 
 	if (is_partition_root(cs))
 		update_prstate(cs, 0);
@@ -2800,7 +2800,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
 
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 }
 
 static void cpuset_css_free(struct cgroup_subsys_state *css)
@@ -2812,7 +2812,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 	spin_lock_irq(&callback_lock);
 
 	if (is_in_v2_mode()) {
@@ -2825,7 +2825,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 	}
 
 	spin_unlock_irq(&callback_lock);
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 }
 
 /*
@@ -2867,6 +2867,8 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
 
 int __init cpuset_init(void)
 {
+	BUG_ON(percpu_init_rwsem(&cpuset_rwsem));
+
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));
@@ -2938,7 +2940,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	is_empty = cpumask_empty(cs->cpus_allowed) ||
 		   nodes_empty(cs->mems_allowed);
 
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 
 	/*
 	 * Move tasks to the nearest ancestor with execution resources,
@@ -2948,7 +2950,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	if (is_empty)
 		remove_tasks_in_empty_cpuset(cs);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 }
 
 static void
@@ -2998,14 +3000,14 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 
 	/*
 	 * We have raced with task attaching. We wait until attaching
 	 * is finished, so we won't attach a task to an empty cpuset.
 	 */
 	if (cs->attach_in_progress) {
-		mutex_unlock(&cpuset_mutex);
+		percpu_up_write(&cpuset_rwsem);
 		goto retry;
 	}
 
@@ -3073,7 +3075,7 @@ update_tasks:
 		hotplug_update_tasks_legacy(cs, &new_cpus, &new_mems,
 					    cpus_updated, mems_updated);
 
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 }
 
 /**
@@ -3103,7 +3105,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
 		ptmp = &tmp;
 
-	mutex_lock(&cpuset_mutex);
+	percpu_down_write(&cpuset_rwsem);
 
 	/* fetch the available cpus/mems and find out which changed how */
 	cpumask_copy(&new_cpus, cpu_active_mask);
@@ -3153,7 +3155,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 		update_tasks_nodemask(&top_cpuset);
 	}
 
-	mutex_unlock(&cpuset_mutex);
+	percpu_up_write(&cpuset_rwsem);
 
 	/* if cpus or mems changed, we need to propagate to descendants */
 	if (cpus_updated || mems_updated) {
