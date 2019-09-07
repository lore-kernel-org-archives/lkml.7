Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E85C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 10:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E3B20854
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 10:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390034AbfIGKyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 06:54:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52103 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbfIGKyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 06:54:47 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x87Asc2N089321;
        Sat, 7 Sep 2019 19:54:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Sat, 07 Sep 2019 19:54:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x87AsYNQ089307
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 7 Sep 2019 19:54:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH (resend)] mm,oom: Defer dump_tasks() output.
To:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <1567159493-5232-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7de2310d-afbd-e616-e83a-d75103b986c6@i-love.sakura.ne.jp>
Date:   Sat, 7 Sep 2019 19:54:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1567159493-5232-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending to LKML as linux-mm ML dropped my posts.)

If /proc/sys/vm/oom_dump_tasks != 0, dump_header() can become very slow
because dump_tasks() synchronously reports all OOM victim candidates, and
as a result ratelimit test for dump_header() cannot work as expected.

This patch defers dump_tasks() output till oom_lock is released. As a
result of this patch, the latency between out_of_memory() is called and
SIGKILL is sent (and the OOM reaper starts reclaiming memory) will be
significantly reduced.

Since CONFIG_PRINTK_CALLER was introduced, concurrent printk() became less
problematic. But we still need to correlate synchronously printed messages
and asynchronously printed messages if we defer dump_tasks() messages.
Thus, this patch also prefixes OOM killer messages using "OOM[$serial]:"
format. As a result, OOM killer messages would look like below.

  [   31.935015][   T71] OOM[1]: kworker/4:1 invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=-1, oom_score_adj=0
  (...snipped....)
  [   32.052635][   T71] OOM[1]: oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),global_oom,task_memcg=/,task=firewalld,pid=737,uid=0
  [   32.056886][   T71] OOM[1]: Out of memory: Killed process 737 (firewalld) total-vm:358672kB, anon-rss:22640kB, file-rss:12328kB, shmem-rss:0kB, UID:0 pgtables:421888kB oom_score_adj:0
  [   32.064291][   T71] OOM[1]: Tasks state (memory values in pages):
  [   32.067807][   T71] OOM[1]: [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
  [   32.070057][   T54] oom_reaper: reaped process 737 (firewalld), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
  [   32.072417][   T71] OOM[1]: [    548]     0   548     9772     1172   110592        0             0 systemd-journal
  (...snipped....)
  [   32.139566][   T71] OOM[1]: [    737]     0   737    89668     8742   421888        0             0 firewalld
  (...snipped....)
  [   32.221990][   T71] OOM[1]: [   1300]    48  1300    63025     1788   532480        0             0 httpd

This patch might affect panic behavior triggered by panic_on_oom or no
OOM-killable tasks, for dump_header(oc, NULL) will not report OOM victim
candidates if there are not-yet-reported OOM victim candidates from past
rounds of OOM killer invocations. I don't know if that matters.

For now this patch embeds "struct oom_task_info" into each
"struct task_struct". In order to avoid bloating "struct task_struct",
future patch might detach from "struct task_struct" because one
"struct oom_task_info" for one "struct signal_struct" will be enough.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/sched.h |  17 +++++-
 mm/oom_kill.c         | 149 +++++++++++++++++++++++++++++++++++---------------
 2 files changed, 121 insertions(+), 45 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b6ec130dff9b..8960e7dc2077 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -639,6 +639,21 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+/* Memory usage and misc info as of invocation of OOM killer. */
+struct oom_task_info {
+	struct list_head list;
+	unsigned int seq;
+	char comm[TASK_COMM_LEN];
+	pid_t pid;
+	uid_t uid;
+	pid_t tgid;
+	unsigned long total_vm;
+	unsigned long mm_rss;
+	unsigned long pgtables_bytes;
+	unsigned long swapents;
+	int score_adj;
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -1260,7 +1275,7 @@ struct task_struct {
 #ifdef CONFIG_MMU
 	struct task_struct		*oom_reaper_list;
 #endif
-	struct list_head		oom_victim_list;
+	struct oom_task_info		oom_task_info;
 #ifdef CONFIG_VMAP_STACK
 	struct vm_struct		*stack_vm_area;
 #endif
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 93eae768a475..fbe17007fb76 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -377,16 +377,80 @@ static void select_bad_process(struct oom_control *oc)
 	}
 }
 
+static unsigned int oom_killer_seq; /* Serialized by oom_lock. */
+static LIST_HEAD(oom_candidate_list); /* Serialized by oom_lock. */
 
 static int add_candidate_task(struct task_struct *p, void *arg)
 {
-	if (!oom_unkillable_task(p)) {
-		get_task_struct(p);
-		list_add_tail(&p->oom_victim_list, (struct list_head *) arg);
-	}
+	struct oom_control *oc = arg;
+	struct mm_struct *mm;
+	struct oom_task_info *oti;
+
+	if (oom_unkillable_task(p))
+		return 0;
+	/* p may not have freeable memory in nodemask */
+	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
+		return 0;
+	/* All of p's threads might have already detached their mm's. */
+	p = find_lock_task_mm(p);
+	if (!p)
+		return 0;
+	get_task_struct(p);
+	oti = &p->oom_task_info;
+	mm = p->mm;
+	oti->seq = oom_killer_seq;
+	memcpy(oti->comm, p->comm, sizeof(oti->comm));
+	oti->pid = task_pid_nr(p);
+	oti->uid = from_kuid(&init_user_ns, task_uid(p));
+	oti->tgid = p->tgid;
+	oti->total_vm = mm->total_vm;
+	oti->mm_rss = get_mm_rss(mm);
+	oti->pgtables_bytes = mm_pgtables_bytes(mm);
+	oti->swapents = get_mm_counter(mm, MM_SWAPENTS);
+	oti->score_adj = p->signal->oom_score_adj;
+	task_unlock(p);
+	list_add_tail(&oti->list, &oom_candidate_list);
 	return 0;
 }
 
+static void dump_candidate_tasks(struct work_struct *work)
+{
+	bool first = true;
+	unsigned int seq;
+	struct oom_task_info *oti;
+
+	if (work) /* Serialize only if asynchronous. */
+		mutex_lock(&oom_lock);
+	while (!list_empty(&oom_candidate_list)) {
+		oti = list_first_entry(&oom_candidate_list,
+				       struct oom_task_info, list);
+		seq = oti->seq;
+		if (first) {
+			pr_info("OOM[%u]: Tasks state (memory values in pages):\n",
+				seq);
+			pr_info("OOM[%u]: [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n",
+				seq);
+			first = false;
+		}
+		pr_info("OOM[%u]: [%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
+			seq, oti->pid, oti->uid, oti->tgid, oti->total_vm,
+			oti->mm_rss, oti->pgtables_bytes, oti->swapents,
+			oti->score_adj, oti->comm);
+		list_del(&oti->list);
+		if (work)
+			mutex_unlock(&oom_lock);
+		put_task_struct(container_of(oti, struct task_struct,
+					     oom_task_info));
+		cond_resched();
+		if (work)
+			mutex_lock(&oom_lock);
+	}
+	if (work)
+		mutex_unlock(&oom_lock);
+}
+
+static DECLARE_WORK(oom_dump_candidates_work, dump_candidate_tasks);
+
 /**
  * dump_tasks - dump current memory state of all system tasks
  * @oc: pointer to struct oom_control
@@ -399,49 +463,41 @@ static int add_candidate_task(struct task_struct *p, void *arg)
  */
 static void dump_tasks(struct oom_control *oc)
 {
-	LIST_HEAD(list);
 	struct task_struct *p;
-	struct task_struct *t;
 
+	/*
+	 * Suppress as long as there is any OOM victim candidate from past
+	 * rounds of OOM killer invocations. We could change this to suppress
+	 * only if there is an OOM victim candidate in the same OOM domain if
+	 * we want to see OOM victim candidates from different OOM domains.
+	 * But since dump_header() is already ratelimited, I don't know whether
+	 * it makes difference to suppress OOM victim candidates from different
+	 * OOM domains...
+	 */
+	if (!list_empty(&oom_candidate_list))
+		return;
 	if (is_memcg_oom(oc))
-		mem_cgroup_scan_tasks(oc->memcg, add_candidate_task, &list);
+		mem_cgroup_scan_tasks(oc->memcg, add_candidate_task, oc);
 	else {
 		rcu_read_lock();
 		for_each_process(p)
-			add_candidate_task(p, &list);
+			add_candidate_task(p, oc);
 		rcu_read_unlock();
 	}
-	pr_info("Tasks state (memory values in pages):\n");
-	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
-	list_for_each_entry(p, &list, oom_victim_list) {
-		cond_resched();
-		/* p may not have freeable memory in nodemask */
-		if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
-			continue;
-		/* All of p's threads might have already detached their mm's. */
-		t = find_lock_task_mm(p);
-		if (!t)
-			continue;
-		pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
-			t->pid, from_kuid(&init_user_ns, task_uid(t)),
-			t->tgid, t->mm->total_vm, get_mm_rss(t->mm),
-			mm_pgtables_bytes(t->mm),
-			get_mm_counter(t->mm, MM_SWAPENTS),
-			t->signal->oom_score_adj, t->comm);
-		task_unlock(t);
-	}
-	list_for_each_entry_safe(p, t, &list, oom_victim_list) {
-		list_del(&p->oom_victim_list);
-		put_task_struct(p);
-	}
+	/*
+	 * Report OOM victim candidates after SIGKILL is sent to OOM victims
+	 * and the OOM reaper started reclaiming.
+	 */
+	if (!list_empty(&oom_candidate_list))
+		queue_work(system_long_wq, &oom_dump_candidates_work);
 }
 
 static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
 {
 	/* one line summary of the oom killer context. */
-	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
-			oom_constraint_text[oc->constraint],
-			nodemask_pr_args(oc->nodemask));
+	pr_info("OOM[%u]: oom-kill:constraint=%s,nodemask=%*pbl",
+		oom_killer_seq, oom_constraint_text[oc->constraint],
+		nodemask_pr_args(oc->nodemask));
 	cpuset_print_current_mems_allowed();
 	mem_cgroup_print_oom_context(oc->memcg, victim);
 	pr_cont(",task=%s,pid=%d,uid=%d\n", victim->comm, victim->pid,
@@ -450,11 +506,11 @@ static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
 
 static void dump_header(struct oom_control *oc, struct task_struct *p)
 {
-	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
-		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
-			current->signal->oom_score_adj);
+	pr_warn("OOM[%u]: %s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
+		oom_killer_seq, current->comm, oc->gfp_mask, &oc->gfp_mask,
+		oc->order, current->signal->oom_score_adj);
 	if (!IS_ENABLED(CONFIG_COMPACTION) && oc->order)
-		pr_warn("COMPACTION is disabled!!!\n");
+		pr_warn("OOM[%u]: COMPACTION is disabled!!!\n", oom_killer_seq);
 
 	dump_stack();
 	if (is_memcg_oom(oc))
@@ -883,8 +939,9 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	 */
 	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
-	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
-		message, task_pid_nr(victim), victim->comm, K(mm->total_vm),
+	pr_err("OOM[%u]: %s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
+	       oom_killer_seq, message, task_pid_nr(victim), victim->comm,
+	       K(mm->total_vm),
 		K(get_mm_counter(mm, MM_ANONPAGES)),
 		K(get_mm_counter(mm, MM_FILEPAGES)),
 		K(get_mm_counter(mm, MM_SHMEMPAGES)),
@@ -910,9 +967,9 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 		if (is_global_init(p)) {
 			can_oom_reap = false;
 			set_bit(MMF_OOM_SKIP, &mm->flags);
-			pr_info("oom killer %d (%s) has mm pinned by %d (%s)\n",
-					task_pid_nr(victim), victim->comm,
-					task_pid_nr(p), p->comm);
+			pr_info("OOM[%u]: oom killer %d (%s) has mm pinned by %d (%s)\n",
+				oom_killer_seq, task_pid_nr(victim),
+				victim->comm, task_pid_nr(p), p->comm);
 			continue;
 		}
 		/*
@@ -1012,6 +1069,7 @@ static void check_panic_on_oom(struct oom_control *oc)
 	if (is_sysrq_oom(oc))
 		return;
 	dump_header(oc, NULL);
+	dump_candidate_tasks(NULL);
 	panic("Out of memory: %s panic_on_oom is enabled\n",
 		sysctl_panic_on_oom == 2 ? "compulsory" : "system-wide");
 }
@@ -1074,6 +1132,7 @@ bool out_of_memory(struct oom_control *oc)
 	if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
 		return true;
 
+	oom_killer_seq++;
 	/*
 	 * Check if there were limitations on the allocation (only relevant for
 	 * NUMA and memcg) that may require different handling.
@@ -1103,8 +1162,10 @@ bool out_of_memory(struct oom_control *oc)
 		 * system level, we cannot survive this and will enter
 		 * an endless loop in the allocator. Bail out now.
 		 */
-		if (!is_sysrq_oom(oc) && !is_memcg_oom(oc))
+		if (!is_sysrq_oom(oc) && !is_memcg_oom(oc)) {
+			dump_candidate_tasks(NULL);
 			panic("System is deadlocked on memory\n");
+		}
 	}
 	if (oc->chosen && oc->chosen != (void *)-1UL)
 		oom_kill_process(oc, !is_memcg_oom(oc) ? "Out of memory" :
-- 
2.16.5


