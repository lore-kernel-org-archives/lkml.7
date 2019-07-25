Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D23C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3142E2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JLuoLd3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbfGYP6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:58:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36165 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387874AbfGYP6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:58:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PFwGp61070129
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 08:58:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PFwGp61070129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070297;
        bh=pkv9Pzi1/qzRemsbyXBf2Bz0rR8Jehrktj9YpBc5z50=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JLuoLd3NhskA8pKAuMQc4k7HswUzB3q2fBul8fz7C0nROGewRgMlSentps9UHa7P9
         B5dfaovgA+EveDguY5MFRl52VZwOnvzIrc9+wg5sQhpnIuNOc9oUt/1tGYkUBfKyKJ
         mw4iEFWlPTL0zlQe2K9qfsIC3KoXvE7cgVJrfHzN2yJff8pZUFhGWa3CwQguqtGK3T
         elm6Wo1OoaeiQf/VgdUa7CKJFuhdj8NxV0Uv/rpu64bHjCSISZZst6LLIAVEUQYOBf
         9qqjzW4LWPumhpi/UesgJJSxcJA4eOOvg+t09+s3swTqi1EGVQZDlrV/GBvd4yEwbe
         Fw498nwwTiFkA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PFwFEG1070124;
        Thu, 25 Jul 2019 08:58:15 -0700
Date:   Thu, 25 Jul 2019 08:58:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-16d51a590a8ce3befb1308e0e7ab77f3b661af33@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        jannh@google.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, pmladek@suse.com, will@kernel.org
Reply-To: jannh@google.com, torvalds@linux-foundation.org, hpa@zytor.com,
          mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, pmladek@suse.com, will@kernel.org,
          tglx@linutronix.de, sergey.senozhatsky@gmail.com
In-Reply-To: <20190716152047.14424-1-jannh@google.com>
References: <20190716152047.14424-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Don't free p->numa_faults with
 concurrent readers
Git-Commit-ID: 16d51a590a8ce3befb1308e0e7ab77f3b661af33
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

Commit-ID:  16d51a590a8ce3befb1308e0e7ab77f3b661af33
Gitweb:     https://git.kernel.org/tip/16d51a590a8ce3befb1308e0e7ab77f3b661af33
Author:     Jann Horn <jannh@google.com>
AuthorDate: Tue, 16 Jul 2019 17:20:45 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:37:04 +0200

sched/fair: Don't free p->numa_faults with concurrent readers

When going through execve(), zero out the NUMA fault statistics instead of
freeing them.

During execve, the task is reachable through procfs and the scheduler. A
concurrent /proc/*/sched reader can read data from a freed ->numa_faults
allocation (confirmed by KASAN) and write it back to userspace.
I believe that it would also be possible for a use-after-free read to occur
through a race between a NUMA fault and execve(): task_numa_fault() can
lead to task_numa_compare(), which invokes task_weight() on the currently
running task of a different CPU.

Another way to fix this would be to make ->numa_faults RCU-managed or add
extra locking, but it seems easier to wipe the NUMA fault statistics on
execve.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Fixes: 82727018b0d3 ("sched/numa: Call task_numa_free() from do_execve()")
Link: https://lkml.kernel.org/r/20190716152047.14424-1-jannh@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 fs/exec.c                            |  2 +-
 include/linux/sched/numa_balancing.h |  4 ++--
 kernel/fork.c                        |  2 +-
 kernel/sched/fair.c                  | 24 ++++++++++++++++++++----
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index c71cbfe6826a..f7f6a140856a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1828,7 +1828,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	membarrier_execve(current);
 	rseq_execve(current);
 	acct_update_integrals(current);
-	task_numa_free(current);
+	task_numa_free(current, false);
 	free_bprm(bprm);
 	kfree(pathbuf);
 	if (filename)
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index e7dd04a84ba8..3988762efe15 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -19,7 +19,7 @@
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
 extern pid_t task_numa_group_id(struct task_struct *p);
 extern void set_numabalancing_state(bool enabled);
-extern void task_numa_free(struct task_struct *p);
+extern void task_numa_free(struct task_struct *p, bool final);
 extern bool should_numa_migrate_memory(struct task_struct *p, struct page *page,
 					int src_nid, int dst_cpu);
 #else
@@ -34,7 +34,7 @@ static inline pid_t task_numa_group_id(struct task_struct *p)
 static inline void set_numabalancing_state(bool enabled)
 {
 }
-static inline void task_numa_free(struct task_struct *p)
+static inline void task_numa_free(struct task_struct *p, bool final)
 {
 }
 static inline bool should_numa_migrate_memory(struct task_struct *p,
diff --git a/kernel/fork.c b/kernel/fork.c
index d8ae0f1b4148..2852d0e76ea3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -726,7 +726,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(tsk == current);
 
 	cgroup_free(tsk);
-	task_numa_free(tsk);
+	task_numa_free(tsk, true);
 	security_task_free(tsk);
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 036be95a87e9..6adb0e0f5feb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2353,13 +2353,23 @@ no_join:
 	return;
 }
 
-void task_numa_free(struct task_struct *p)
+/*
+ * Get rid of NUMA staticstics associated with a task (either current or dead).
+ * If @final is set, the task is dead and has reached refcount zero, so we can
+ * safely free all relevant data structures. Otherwise, there might be
+ * concurrent reads from places like load balancing and procfs, and we should
+ * reset the data back to default state without freeing ->numa_faults.
+ */
+void task_numa_free(struct task_struct *p, bool final)
 {
 	struct numa_group *grp = p->numa_group;
-	void *numa_faults = p->numa_faults;
+	unsigned long *numa_faults = p->numa_faults;
 	unsigned long flags;
 	int i;
 
+	if (!numa_faults)
+		return;
+
 	if (grp) {
 		spin_lock_irqsave(&grp->lock, flags);
 		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
@@ -2372,8 +2382,14 @@ void task_numa_free(struct task_struct *p)
 		put_numa_group(grp);
 	}
 
-	p->numa_faults = NULL;
-	kfree(numa_faults);
+	if (final) {
+		p->numa_faults = NULL;
+		kfree(numa_faults);
+	} else {
+		p->total_numa_faults = 0;
+		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
+			numa_faults[i] = 0;
+	}
 }
 
 /*
