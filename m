Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD173C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA9922BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lMw9ynBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390530AbfGYQZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:25:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42903 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387697AbfGYQZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:25:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGOubb1078518
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:24:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGOubb1078518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071897;
        bh=7Z/U/sV1DlY/6wWREagcbYMxViQaNouXlbPQ0OFaT/I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lMw9ynBlnLVSRlVFqkBmUlMlonEr44l9U3NJmKyXITpHSbZN5qJUbOiEBOb5KY/nM
         FV3bENJZS/ru3xZrrF9PdxmzwG1Q/qRO2rzjdXjxVIbY/PKmxDiHXxdVeLBoRwpEyh
         WmCWuVorqojo/G/Iwb/oWwRsYz1EfwVKt2eXJYddCVOD8IGUvx07OdOlfV7GHlsY8z
         hkVxGw93YFrDWbAJwCnzZuU98WN220mLnwqACVQOvHfYhy7VOKgZtB8CHRzs+L/ERj
         0YKQtNoX7UNqWzqDq1kyQgPMos1FNEH6sUXjjr3up9uvzlvl90v9sBfZjWhKmLASE2
         lASm0Hf0Fbbag==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGOtBT1078515;
        Thu, 25 Jul 2019 09:24:55 -0700
Date:   Thu, 25 Jul 2019 09:24:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-710da3c8ea7dfbd327920afd3831d8c82c42789d@git.kernel.org>
Cc:     torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
          dietmar.eggemann@arm.com
In-Reply-To: <20190719140000.31694-9-juri.lelli@redhat.com>
References: <20190719140000.31694-9-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Prevent race condition between cpuset
 and __sched_setscheduler()
Git-Commit-ID: 710da3c8ea7dfbd327920afd3831d8c82c42789d
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

Commit-ID:  710da3c8ea7dfbd327920afd3831d8c82c42789d
Gitweb:     https://git.kernel.org/tip/710da3c8ea7dfbd327920afd3831d8c82c42789d
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Fri, 19 Jul 2019 16:00:00 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:55:04 +0200

sched/core: Prevent race condition between cpuset and __sched_setscheduler()

No synchronisation mechanism exists between the cpuset subsystem and
calls to function __sched_setscheduler(). As such, it is possible that
new root domains are created on the cpuset side while a deadline
acceptance test is carried out in __sched_setscheduler(), leading to a
potential oversell of CPU bandwidth.

Grab cpuset_rwsem read lock from core scheduler, so to prevent
situations such as the one described above from happening.

The only exception is normalize_rt_tasks() which needs to work under
tasklist_lock and can't therefore grab cpuset_rwsem. We are fine with
this, as this function is only called by sysrq and, if that gets
triggered, DEADLINE guarantees are already gone out of the window
anyway.

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
Link: https://lkml.kernel.org/r/20190719140000.31694-9-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/cpuset.h |  5 +++++
 kernel/cgroup/cpuset.c | 11 +++++++++++
 kernel/sched/core.c    | 20 +++++++++++++++++---
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 7f1478c26a33..04c20de66afc 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -55,6 +55,8 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
+extern void cpuset_read_lock(void);
+extern void cpuset_read_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern void cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
@@ -176,6 +178,9 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
+static inline void cpuset_read_lock(void) { }
+static inline void cpuset_read_unlock(void) { }
+
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
 {
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5c5014caa23c..c52bc91f882b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -334,6 +334,17 @@ static struct cpuset top_cpuset = {
  */
 
 DEFINE_STATIC_PERCPU_RWSEM(cpuset_rwsem);
+
+void cpuset_read_lock(void)
+{
+	percpu_down_read(&cpuset_rwsem);
+}
+
+void cpuset_read_unlock(void)
+{
+	percpu_up_read(&cpuset_rwsem);
+}
+
 static DEFINE_SPINLOCK(callback_lock);
 
 static struct workqueue_struct *cpuset_migrate_mm_wq;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1af3d2dc6b29..1bceb22dac18 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4698,6 +4698,9 @@ recheck:
 			return retval;
 	}
 
+	if (pi)
+		cpuset_read_lock();
+
 	/*
 	 * Make sure no PI-waiters arrive (or leave) while we are
 	 * changing the priority of the task:
@@ -4772,6 +4775,8 @@ change:
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, p, &rf);
+		if (pi)
+			cpuset_read_unlock();
 		goto recheck;
 	}
 
@@ -4832,8 +4837,10 @@ change:
 	preempt_disable();
 	task_rq_unlock(rq, p, &rf);
 
-	if (pi)
+	if (pi) {
+		cpuset_read_unlock();
 		rt_mutex_adjust_pi(p);
+	}
 
 	/* Run balance callbacks after we've adjusted the PI chain: */
 	balance_callback(rq);
@@ -4843,6 +4850,8 @@ change:
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
+	if (pi)
+		cpuset_read_unlock();
 	return retval;
 }
 
@@ -4927,10 +4936,15 @@ do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 	rcu_read_lock();
 	retval = -ESRCH;
 	p = find_process_by_pid(pid);
-	if (p != NULL)
-		retval = sched_setscheduler(p, policy, &lparam);
+	if (likely(p))
+		get_task_struct(p);
 	rcu_read_unlock();
 
+	if (likely(p)) {
+		retval = sched_setscheduler(p, policy, &lparam);
+		put_task_struct(p);
+	}
+
 	return retval;
 }
 
