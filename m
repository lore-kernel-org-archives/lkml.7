Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E5C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B283F22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gQ/TIyvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390455AbfGYQX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:23:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39671 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390430AbfGYQXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:23:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGNQea1076555
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:23:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGNQea1076555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071807;
        bh=4XZbGy6of/HK5BX4PpB9l0JZ8HH9PgSQCcAWgoR/oPs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gQ/TIyvMCY8FbwchVZi085Pb8HLQpwPl12xgF76p+tecVWSHop64VOWuUTxg18R1f
         pJSrEGZ1mJgnrcYbJRtC0GwYgMeuUV/vO6uNMrOkhVKAwhnj31VhmPu9bi5G2fZO/y
         2S0Ivu6HTseeZrnrel5LoRX2GfdNf5MbBwfZGRwI8dcLrB2dFo6LC+dI9JTec4okDu
         A6wbswtTWZmklCQ8NM/sUWRyTDj/CXWenSWBz9tTVgHMI6EVKvoQL7486rNjo5HRCG
         pPsDlpus2+zRhqN4HubjDbIZSaKO/3j9BEEYEwqU89dA7/jUczrJtpenudZVN55GfY
         A6XsIxrp+VzyQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGNQ1M1076552;
        Thu, 25 Jul 2019 09:23:26 -0700
Date:   Thu, 25 Jul 2019 09:23:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-d74b27d63a8bebe2fe634944e4ebdc7b10db7a39@git.kernel.org>
Cc:     juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          juri.lelli@redhat.com, dietmar.eggemann@arm.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190719140000.31694-7-juri.lelli@redhat.com>
References: <20190719140000.31694-7-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] cgroup/cpuset: Change cpuset_rwsem and hotplug
 lock order
Git-Commit-ID: d74b27d63a8bebe2fe634944e4ebdc7b10db7a39
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

Commit-ID:  d74b27d63a8bebe2fe634944e4ebdc7b10db7a39
Gitweb:     https://git.kernel.org/tip/d74b27d63a8bebe2fe634944e4ebdc7b10db7a39
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Fri, 19 Jul 2019 15:59:58 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:55:03 +0200

cgroup/cpuset: Change cpuset_rwsem and hotplug lock order

cpuset_rwsem is going to be acquired from sched_setscheduler() with a
following patch. There are however paths (e.g., spawn_ksoftirqd) in
which sched_scheduler() is eventually called while holding hotplug lock;
this creates a dependecy between hotplug lock (to be always acquired
first) and cpuset_rwsem (to be always acquired after hotplug lock).

Fix paths which currently take the two locks in the wrong order (after
a following patch is applied).

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
Link: https://lkml.kernel.org/r/20190719140000.31694-7-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/cpuset.h |  8 ++++----
 kernel/cgroup/cpuset.c | 22 +++++++++++++++++-----
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 934633a05d20..7f1478c26a33 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -40,14 +40,14 @@ static inline bool cpusets_enabled(void)
 
 static inline void cpuset_inc(void)
 {
-	static_branch_inc(&cpusets_pre_enable_key);
-	static_branch_inc(&cpusets_enabled_key);
+	static_branch_inc_cpuslocked(&cpusets_pre_enable_key);
+	static_branch_inc_cpuslocked(&cpusets_enabled_key);
 }
 
 static inline void cpuset_dec(void)
 {
-	static_branch_dec(&cpusets_enabled_key);
-	static_branch_dec(&cpusets_pre_enable_key);
+	static_branch_dec_cpuslocked(&cpusets_enabled_key);
+	static_branch_dec_cpuslocked(&cpusets_pre_enable_key);
 }
 
 extern int cpuset_init(void);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e1a8d168c5e9..5c5014caa23c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -973,8 +973,8 @@ static void rebuild_sched_domains_locked(void)
 	cpumask_var_t *doms;
 	int ndoms;
 
+	lockdep_assert_cpus_held();
 	percpu_rwsem_assert_held(&cpuset_rwsem);
-	get_online_cpus();
 
 	/*
 	 * We have raced with CPU hotplug. Don't do anything to avoid
@@ -983,19 +983,17 @@ static void rebuild_sched_domains_locked(void)
 	 */
 	if (!top_cpuset.nr_subparts_cpus &&
 	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
-		goto out;
+		return;
 
 	if (top_cpuset.nr_subparts_cpus &&
 	   !cpumask_subset(top_cpuset.effective_cpus, cpu_active_mask))
-		goto out;
+		return;
 
 	/* Generate domain masks and attrs */
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
 	partition_and_rebuild_sched_domains(ndoms, doms, attr);
-out:
-	put_online_cpus();
 }
 #else /* !CONFIG_SMP */
 static void rebuild_sched_domains_locked(void)
@@ -1005,9 +1003,11 @@ static void rebuild_sched_domains_locked(void)
 
 void rebuild_sched_domains(void)
 {
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	rebuild_sched_domains_locked();
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 }
 
 /**
@@ -2245,6 +2245,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = 0;
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
@@ -2282,6 +2283,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	}
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	return retval;
 }
 
@@ -2292,6 +2294,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = -ENODEV;
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
@@ -2306,6 +2309,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	}
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	return retval;
 }
 
@@ -2344,6 +2348,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	kernfs_break_active_protection(of->kn);
 	flush_work(&cpuset_hotplug_work);
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
@@ -2369,6 +2374,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	free_cpuset(trialcs);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
 	flush_workqueue(cpuset_migrate_mm_wq);
@@ -2499,6 +2505,7 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 		return -EINVAL;
 
 	css_get(&cs->css);
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
@@ -2506,6 +2513,7 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 	retval = update_prstate(cs, val);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	css_put(&cs->css);
 	return retval ?: nbytes;
 }
@@ -2711,6 +2719,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	if (!parent)
 		return 0;
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 
 	set_bit(CS_ONLINE, &cs->flags);
@@ -2763,6 +2772,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	spin_unlock_irq(&callback_lock);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	return 0;
 }
 
@@ -2781,6 +2791,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 
 	if (is_partition_root(cs))
@@ -2801,6 +2812,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	clear_bit(CS_ONLINE, &cs->flags);
 
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 }
 
 static void cpuset_css_free(struct cgroup_subsys_state *css)
