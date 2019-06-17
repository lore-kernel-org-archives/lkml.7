Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB92C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5671F208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ob/UZNpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfFQQAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:00:04 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:43847 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFQQAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:00:03 -0400
Received: by mail-oi1-f202.google.com with SMTP id d12so3744084oic.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6OF/I8mViVS6VwGoK9t/TkowxaH44NQujziCKAFpMDc=;
        b=ob/UZNpGxGPuF0OzSr4yeSWfIhOdnYSQGvAhj9DxsKpWZaLHEMyF+kLANJU5hFdcvW
         0dl8fnSbB4XcNXABqAjMH4UDEZvd/s1ql9mumUa+KVBf6QAUN7ay18H/v5sbj5OGz9Br
         +fVmQEkyUjwCYAgpqwHLsiJB37ZJojWELK5ziJ3+1+DCvkgsq0po/LlG/rmE7BBt2SUq
         UwqNJ/F6t0lmPzthj1U0o87GNOmVAuViobWjvZ6c7F5lJe0DjYepiF4XWlRgvm10JdBv
         nJkd+aiEenu+daU8g5bnkoWD+JOBlJFc8bEkQAJzjZn3o0DTakI6KihKzku0iZeFKuTk
         HM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6OF/I8mViVS6VwGoK9t/TkowxaH44NQujziCKAFpMDc=;
        b=NyWjK1wZXK2Sa4rwpR7y61V/T2JaXafVpdojofZfVB7y0g8sqeQYoi6gGchmeeRlxq
         DfUf8fbdRBuvSUE2QUrmy8ZH/MV2FAaw9TIMIle3EK+IhWO8g1+sO09PQXjgFbrqkyUY
         4q7e05v1Vm422o6Xk1ZZ7/w5gt2c8/LzWC3SKtRNEw55XOHVw7KA4xp/9mQCQsEPIppU
         /5YbzIW12FrSdJG2TJE73yLzPK2cMZfwDPOTs4fspdb2TL7ip6NivqSWxjFz1cbyV6ZS
         smBOcI8hUd23yRSNMWASZglqPJsoRrHsC6Yf5daHp+yilvSununjsrudD74rBShRWbEI
         BGiQ==
X-Gm-Message-State: APjAAAWRzxQuAuY9Q4CVXk9JUSKwTexjMz5vOejdo1ro/hVB5lg7uaqu
        bCH6IMZi5trBl/YLaQ7GcidAv8ZVfaVG0A==
X-Google-Smtp-Source: APXvYqw79N91taxJtuNvC4ql7FsQuNTdHnWvRgS0qX8lER0ovOxErjWwzD8UXKz0aKsJ1UGmr1SZtb87+JnEEw==
X-Received: by 2002:aca:cc8e:: with SMTP id c136mr11155223oig.18.1560787202795;
 Mon, 17 Jun 2019 09:00:02 -0700 (PDT)
Date:   Mon, 17 Jun 2019 08:59:54 -0700
Message-Id: <20190617155954.155791-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] mm, oom: fix oom_unkillable_task for memcg OOMs
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently oom_unkillable_task() checks mems_allowed even for memcg OOMs
which does not make sense as memcg OOMs can not be triggered due to
numa constraints. Fixing that.

Also if memcg is given, oom_unkillable_task() will check the task's
memcg membership as well to detect oom killability. However all the
memcg related code paths leading to oom_unkillable_task(), other than
dump_tasks(), come through mem_cgroup_scan_tasks() which traverses
tasks through memcgs. Once dump_tasks() is converted to use
mem_cgroup_scan_tasks(), there is no need to do memcg membership check
in oom_unkillable_task().

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 fs/proc/base.c      |   3 +-
 include/linux/oom.h |   3 +-
 mm/oom_kill.c       | 100 +++++++++++++++++++++++++-------------------
 3 files changed, 60 insertions(+), 46 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b8d5d100ed4a..69b0d1b6583d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -532,8 +532,7 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long totalpages = totalram_pages() + total_swap_pages;
 	unsigned long points = 0;
 
-	points = oom_badness(task, NULL, NULL, totalpages) *
-					1000 / totalpages;
+	points = oom_badness(task, NULL, totalpages) * 1000 / totalpages;
 	seq_printf(m, "%lu\n", points);
 
 	return 0;
diff --git a/include/linux/oom.h b/include/linux/oom.h
index d07992009265..39c42caa3231 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -108,8 +108,7 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 bool __oom_reap_task_mm(struct mm_struct *mm);
 
 extern unsigned long oom_badness(struct task_struct *p,
-		struct mem_cgroup *memcg, const nodemask_t *nodemask,
-		unsigned long totalpages);
+		struct oom_control *oc, unsigned long totalpages);
 
 extern bool out_of_memory(struct oom_control *oc);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 05aaa1a5920b..47ded0e07e98 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -152,20 +152,25 @@ static inline bool is_memcg_oom(struct oom_control *oc)
 }
 
 /* return true if the task is not adequate as candidate victim task. */
-static bool oom_unkillable_task(struct task_struct *p,
-		struct mem_cgroup *memcg, const nodemask_t *nodemask)
+static bool oom_unkillable_task(struct task_struct *p, struct oom_control *oc)
 {
 	if (is_global_init(p))
 		return true;
 	if (p->flags & PF_KTHREAD)
 		return true;
+	if (!oc)
+		return false;
 
-	/* When mem_cgroup_out_of_memory() and p is not member of the group */
-	if (memcg && !task_in_mem_cgroup(p, memcg))
-		return true;
+	/*
+	 * For memcg OOM, we reach here through mem_cgroup_scan_tasks(), no
+	 * need to check p's membership. Also the following checks are
+	 * irrelevant to memcg OOMs.
+	 */
+	if (is_memcg_oom(oc))
+		return false;
 
 	/* p may not have freeable memory in nodemask */
-	if (!has_intersects_mems_allowed(p, nodemask))
+	if (!has_intersects_mems_allowed(p, oc->nodemask))
 		return true;
 
 	return false;
@@ -193,21 +198,20 @@ static bool is_dump_unreclaim_slabs(void)
 /**
  * oom_badness - heuristic function to determine which candidate task to kill
  * @p: task struct of which task we should calculate
+ * @oc: pointer to struct oom_control
  * @totalpages: total present RAM allowed for page allocation
- * @memcg: task's memory controller, if constrained
- * @nodemask: nodemask passed to page allocator for mempolicy ooms
  *
  * The heuristic for determining which task to kill is made to be as simple and
  * predictable as possible.  The goal is to return the highest value for the
  * task consuming the most memory to avoid subsequent oom failures.
  */
-unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
-			  const nodemask_t *nodemask, unsigned long totalpages)
+unsigned long oom_badness(struct task_struct *p, struct oom_control *oc,
+			  unsigned long totalpages)
 {
 	long points;
 	long adj;
 
-	if (oom_unkillable_task(p, memcg, nodemask))
+	if (oom_unkillable_task(p, oc))
 		return 0;
 
 	p = find_lock_task_mm(p);
@@ -318,7 +322,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 	struct oom_control *oc = arg;
 	unsigned long points;
 
-	if (oom_unkillable_task(task, NULL, oc->nodemask))
+	if (oom_unkillable_task(task, oc))
 		goto next;
 
 	/*
@@ -342,7 +346,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 		goto select;
 	}
 
-	points = oom_badness(task, NULL, oc->nodemask, oc->totalpages);
+	points = oom_badness(task, oc, oc->totalpages);
 	if (!points || points < oc->chosen_points)
 		goto next;
 
@@ -385,10 +389,38 @@ static void select_bad_process(struct oom_control *oc)
 	oc->chosen_points = oc->chosen_points * 1000 / oc->totalpages;
 }
 
+static int dump_task(struct task_struct *p, void *arg)
+{
+	struct oom_control *oc = arg;
+	struct task_struct *task;
+
+	if (oom_unkillable_task(p, oc))
+		return 0;
+
+	task = find_lock_task_mm(p);
+	if (!task) {
+		/*
+		 * This is a kthread or all of p's threads have already
+		 * detached their mm's.  There's no need to report
+		 * them; they can't be oom killed anyway.
+		 */
+		return 0;
+	}
+
+	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
+		task->pid, from_kuid(&init_user_ns, task_uid(task)),
+		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
+		mm_pgtables_bytes(task->mm),
+		get_mm_counter(task->mm, MM_SWAPENTS),
+		task->signal->oom_score_adj, task->comm);
+	task_unlock(task);
+
+	return 0;
+}
+
 /**
  * dump_tasks - dump current memory state of all system tasks
- * @memcg: current's memory controller, if constrained
- * @nodemask: nodemask passed to page allocator for mempolicy ooms
+ * @oc: pointer to struct oom_control
  *
  * Dumps the current memory state of all eligible tasks.  Tasks not in the same
  * memcg, not in the same cpuset, or bound to a disjoint set of mempolicy nodes
@@ -396,37 +428,21 @@ static void select_bad_process(struct oom_control *oc)
  * State information includes task's pid, uid, tgid, vm size, rss,
  * pgtables_bytes, swapents, oom_score_adj value, and name.
  */
-static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
+static void dump_tasks(struct oom_control *oc)
 {
-	struct task_struct *p;
-	struct task_struct *task;
-
 	pr_info("Tasks state (memory values in pages):\n");
 	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
-	rcu_read_lock();
-	for_each_process(p) {
-		if (oom_unkillable_task(p, memcg, nodemask))
-			continue;
 
-		task = find_lock_task_mm(p);
-		if (!task) {
-			/*
-			 * This is a kthread or all of p's threads have already
-			 * detached their mm's.  There's no need to report
-			 * them; they can't be oom killed anyway.
-			 */
-			continue;
-		}
+	if (is_memcg_oom(oc))
+		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
+	else {
+		struct task_struct *p;
 
-		pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
-			task->pid, from_kuid(&init_user_ns, task_uid(task)),
-			task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
-			mm_pgtables_bytes(task->mm),
-			get_mm_counter(task->mm, MM_SWAPENTS),
-			task->signal->oom_score_adj, task->comm);
-		task_unlock(task);
+		rcu_read_lock();
+		for_each_process(p)
+			dump_task(p, oc);
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
 }
 
 static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
@@ -458,7 +474,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 			dump_unreclaimable_slab();
 	}
 	if (sysctl_oom_dump_tasks)
-		dump_tasks(oc->memcg, oc->nodemask);
+		dump_tasks(oc);
 	if (p)
 		dump_oom_summary(oc, p);
 }
@@ -1078,7 +1094,7 @@ bool out_of_memory(struct oom_control *oc)
 	check_panic_on_oom(oc, constraint);
 
 	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
-	    current->mm && !oom_unkillable_task(current, NULL, oc->nodemask) &&
+	    current->mm && !oom_unkillable_task(current, oc) &&
 	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
 		get_task_struct(current);
 		oc->chosen = current;
-- 
2.22.0.410.gd8fdbe21b5-goog

