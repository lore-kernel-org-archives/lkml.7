Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E2DC004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2A42054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfD2IDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:03:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:59379 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbfD2IDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:03:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 01:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="139699424"
Received: from shbuild999.sh.intel.com ([10.239.146.112])
  by orsmga006.jf.intel.com with ESMTP; 29 Apr 2019 01:03:31 -0700
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
Subject: [RFC PATCH 2/3] latencytop: split latency_lock to global lock and per task lock
Date:   Mon, 29 Apr 2019 16:03:30 +0800
Message-Id: <1556525011-28022-3-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556525011-28022-1-git-send-email-feng.tang@intel.com>
References: <1556525011-28022-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is one global "latency_lock" to cover both the
global and per-task latency data updating. Splitting it into one
global lock and per-task one will improve lock's granularity and
reduce the contention.

Cc: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/sched.h | 1 +
 init/init_task.c      | 3 +++
 kernel/fork.c         | 4 ++++
 kernel/latencytop.c   | 9 +++++----
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f9b43c9..84cf13c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1095,6 +1095,7 @@ struct task_struct {
 	unsigned long			dirty_paused_when;
 
 #ifdef CONFIG_LATENCYTOP
+	raw_spinlock_t			latency_lock;
 	int				latency_record_count;
 	struct latency_record		latency_record[LT_SAVECOUNT];
 #endif
diff --git a/init/init_task.c b/init/init_task.c
index 5aebe3b..f7cc0fb 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -158,6 +158,9 @@ struct task_struct init_task
 	.numa_group	= NULL,
 	.numa_faults	= NULL,
 #endif
+#ifdef CONFIG_LATENCYTOP
+	.latency_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.latency_lock),
+#endif
 #ifdef CONFIG_KASAN
 	.kasan_depth	= 1,
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index b69248e..2109468 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1963,6 +1963,10 @@ static __latent_entropy struct task_struct *copy_process(
 #ifdef TIF_SYSCALL_EMU
 	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
 #endif
+
+#ifdef CONFIG_LATENCYTOP
+	raw_spin_lock_init(&p->latency_lock);
+#endif
 	clear_all_latency_tracing(p);
 
 	/* ok, now we should be set up.. */
diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 96b4179..6d7a174 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -74,10 +74,10 @@ void clear_all_latency_tracing(struct task_struct *p)
 	if (!latencytop_enabled)
 		return;
 
-	raw_spin_lock_irqsave(&latency_lock, flags);
+	raw_spin_lock_irqsave(&p->latency_lock, flags);
 	memset(&p->latency_record, 0, sizeof(p->latency_record));
 	p->latency_record_count = 0;
-	raw_spin_unlock_irqrestore(&latency_lock, flags);
+	raw_spin_unlock_irqrestore(&p->latency_lock, flags);
 }
 
 static void clear_global_latency_tracing(void)
@@ -194,9 +194,10 @@ __account_scheduler_latency(struct task_struct *tsk, int usecs, int inter)
 	store_stacktrace(tsk, &lat);
 
 	raw_spin_lock_irqsave(&latency_lock, flags);
-
 	account_global_scheduler_latency(tsk, &lat);
+	raw_spin_unlock_irqrestore(&latency_lock, flags);
 
+	raw_spin_lock_irqsave(&tsk->latency_lock, flags);
 	for (i = 0; i < tsk->latency_record_count; i++) {
 		struct latency_record *mylat;
 		int same = 1;
@@ -234,7 +235,7 @@ __account_scheduler_latency(struct task_struct *tsk, int usecs, int inter)
 	memcpy(&tsk->latency_record[i], &lat, sizeof(struct latency_record));
 
 out_unlock:
-	raw_spin_unlock_irqrestore(&latency_lock, flags);
+	raw_spin_unlock_irqrestore(&tsk->latency_lock, flags);
 }
 
 static int lstats_show(struct seq_file *m, void *v)
-- 
2.7.4

