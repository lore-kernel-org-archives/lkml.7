Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E525EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2042054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfD2IDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:03:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:59379 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfD2IDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:03:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 01:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="139699438"
Received: from shbuild999.sh.intel.com ([10.239.146.112])
  by orsmga006.jf.intel.com with ESMTP; 29 Apr 2019 01:03:33 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Eric W Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ying Huang <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH 3/3] latencytop: add a lazy mode for updating global latency data
Date:   Mon, 29 Apr 2019 16:03:31 +0800
Message-Id: <1556525011-28022-4-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556525011-28022-1-git-send-email-feng.tang@intel.com>
References: <1556525011-28022-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

latencytop is a nice tool for tracing system latency hotspots, and
we heavily use it in 0day/LKP test suites.

However, When running some scheduler benchmarks like hackbench,
we noticed in some cases the global latencytop_lock will occupy around
70% of CPU cycles from perf profile, mainly come from contention
for "latency_lock" inside __account_scheduler_latency(), as when
system is running with workload that causes massive process scheduling,
most of the processes contends for this global lock. Given that,
we have to disable the latencytop when running such benchmarks.

Add an extra lazy mode option, which will only update the global
latency data when a task exits, and this greatly reduces the possible
lock contion for "latency_lock". And with this new lazy mode, the lock
contention for latency_lock could be cut from 70% to less than 3%
(perf profile data),  and there is a hackbench throughput boost :

            v5.0    v5.0 + patches
---------------- ---------------------------
    540207          +267.6%    1986052        hackbench.throughput

The test we run is on a 2 sockets Xeon E5-2699 machine (44 Cores/88 CPUs)
with 64GB RAM, with cmd:
  "hackbench -g 1408 --process --pipe -l 1875 -s 1024"

As a new mode is added, the sysctl "kernel.latencytop" and
/proc/sys/kernel/latencytop are changed as follows:

	0 - Disabled
	1 - Enabled (normal mode): update the global data each time task
	    gets scheduled (same as before the patch)
	2 - Enabled (lazy mode): update the global data only when a task
	    exists

Suggested-by: Ying Huang <ying.huang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sysctl/kernel.txt | 17 +++++++++++------
 include/linux/latencytop.h      |  5 +++++
 kernel/exit.c                   |  2 ++
 kernel/latencytop.c             | 41 +++++++++++++++++++++++++++++++++++++----
 4 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 080ef66..05cd9e2 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -440,12 +440,17 @@ When kptr_restrict is set to (2), kernel pointers printed using
 
 latencytop:
 
-This value controls whether to start collecting kernel latency
-data, it is off (0) by default, and could be switched on (1).
-The latency talked here is not the 'traditional' interrupt
-latency (which is primarily caused by something else consuming CPU),
-but instead, it is the latency an application encounters because
-the kernel sleeps on its behalf for various reasons.
+This value controls whether and how to collect kernel latency
+data, it is off (0) by default. The latency talked here is not
+the 'traditional' interrupt latency (which is primarily caused by
+something else consuming CPU), but instead, it is the latency an
+application encounters because the kernel sleeps on its behalf
+for various reasons.
+
+0 - Disabled
+1 - Enabled (normal mode): update the global data each time task
+    gets scheduled
+2 - Enabled (lazy mode): update the global data only when a task exists
 
 The info is exported via /proc/latency_stats and /proc/<pid>/latency.
 
diff --git a/include/linux/latencytop.h b/include/linux/latencytop.h
index 7c560e0..08eeabb 100644
--- a/include/linux/latencytop.h
+++ b/include/linux/latencytop.h
@@ -41,6 +41,7 @@ void clear_all_latency_tracing(struct task_struct *p);
 extern int sysctl_latencytop(struct ctl_table *table, int write,
 			void __user *buffer, size_t *lenp, loff_t *ppos);
 
+extern void update_task_latency_data(struct task_struct *tsk);
 #else
 
 static inline void
@@ -52,6 +53,10 @@ static inline void clear_all_latency_tracing(struct task_struct *p)
 {
 }
 
+static inline void update_task_latency_data(struct task_struct *tsk)
+{
+}
+
 #endif
 
 #endif
diff --git a/kernel/exit.c b/kernel/exit.c
index 2639a30..701b8bd 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -859,6 +859,8 @@ void __noreturn do_exit(long code)
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
 
+	update_task_latency_data(tsk);
+
 	exit_mm();
 
 	if (group_dead)
diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 6d7a174..9943cce 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -65,6 +65,17 @@ static DEFINE_RAW_SPINLOCK(latency_lock);
 #define MAXLR 128
 static struct latency_record latency_record[MAXLR];
 
+/*
+ * latencytop working models:
+ *	0 - disabled
+ *	1 - enabled, update the global data each time task
+ *	    gets scheduled
+ *	2 - enabled, only update the global data when a task
+ *	    exists
+ */
+#define LATENCYTOP_DISABLED	0
+#define LATENCYTOP_NORMAL_MODE	1
+#define LATENCYTOP_LAZY_MODE	2
 int latencytop_enabled;
 
 void clear_all_latency_tracing(struct task_struct *p)
@@ -125,7 +136,7 @@ account_global_scheduler_latency(struct task_struct *tsk,
 				break;
 		}
 		if (same) {
-			latency_record[i].count++;
+			latency_record[i].count += lat->count;
 			latency_record[i].time += lat->time;
 			if (lat->time > latency_record[i].max)
 				latency_record[i].max = lat->time;
@@ -141,6 +152,25 @@ account_global_scheduler_latency(struct task_struct *tsk,
 	memcpy(&latency_record[i], lat, sizeof(struct latency_record));
 }
 
+/* Used only in lazy mode */
+void update_task_latency_data(struct task_struct *tsk)
+{
+	unsigned long flags;
+	int i;
+
+	if (latencytop_enabled != LATENCYTOP_LAZY_MODE)
+		return;
+
+	/* skip kernel threads for now */
+	if (!tsk->mm)
+		return;
+
+	raw_spin_lock_irqsave(&latency_lock, flags);
+	for (i = 0; i < tsk->latency_record_count; i++)
+		account_global_scheduler_latency(tsk, &tsk->latency_record[i]);
+	raw_spin_unlock_irqrestore(&latency_lock, flags);
+}
+
 /*
  * Iterator to store a backtrace into a latency record entry
  */
@@ -193,9 +223,12 @@ __account_scheduler_latency(struct task_struct *tsk, int usecs, int inter)
 	lat.max = usecs;
 	store_stacktrace(tsk, &lat);
 
-	raw_spin_lock_irqsave(&latency_lock, flags);
-	account_global_scheduler_latency(tsk, &lat);
-	raw_spin_unlock_irqrestore(&latency_lock, flags);
+	/* Don't do the global update in lazy mode */
+	if (latencytop_enabled == LATENCYTOP_NORMAL_MODE) {
+		raw_spin_lock_irqsave(&latency_lock, flags);
+		account_global_scheduler_latency(tsk, &lat);
+		raw_spin_unlock_irqrestore(&latency_lock, flags);
+	}
 
 	raw_spin_lock_irqsave(&tsk->latency_lock, flags);
 	for (i = 0; i < tsk->latency_record_count; i++) {
-- 
2.7.4

