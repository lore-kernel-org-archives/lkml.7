Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57AFC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCBD217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VEsafay3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbfHHSmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:42:02 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:56150 "EHLO
        smtp.aristanetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbfHHSmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:42:02 -0400
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Aug 2019 14:42:01 EDT
Received: from smtp.aristanetworks.com (localhost [127.0.0.1])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 55FA1427D9F;
        Thu,  8 Aug 2019 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1565289225;
        bh=wT3T8uxsvhilc5G/Tu7ixGp1PL3OKIzCeyPA7IhRvw8=;
        h=From:To:Cc:Subject:Date;
        b=VEsafay3g9WIqrjD9haNX+x23eCGDrXxTE0V8upopDUlWe/lPcATaM9odkhJ9QR++
         Au4D3fSf8h62w9LOzFz2b+d5hjLq5kW84wkHPYnv8ft+lmyQLNcut4TLqIKAWvMp6k
         WyuxvBI6odO2aKXsTKpAgYaHAZV+qvckM8nH0t9bvuCn3u+dNYC1tmq8kN9WHdRcA9
         ObapSM5RnUH3Wn2aiOL+5vD7W2dG3Ojn1ReRGYCgi+J4k4w3B9nXff0AQnKheJloZc
         rMwKUOWhNjpd3jAcZ0stOZLuZ+R10+S8XF0Z1JAtPx/Q9G1BelqEuzHIPj2tHMaMGX
         QXFvPLpFF5SgA==
Received: from egc101.sjc.aristanetworks.com (unknown [172.20.210.50])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 51E3E427D83;
        Thu,  8 Aug 2019 11:33:45 -0700 (PDT)
From:   Edward Chron <echron@arista.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com,
        Edward Chron <echron@arista.com>
Subject: [PATCH] mm/oom: Add killed process selection information
Date:   Thu,  8 Aug 2019 11:32:47 -0700
Message-Id: <20190808183247.28206-1-echron@arista.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For an OOM event: print oomscore, memory pct, oom adjustment of the process
that OOM kills and the totalpages value in kB (KiB) used in the calculation
with the OOM killed process message. This is helpful to document why the
process was selected by OOM at the time of the OOM event.

Sample message output:
Jul 21 20:07:48 yoursystem kernel: Out of memory: Killed process 2826
 (processname) total-vm:1056800kB, anon-rss:1052784kB, file-rss:4kB,
 shmem-rss:0kB memory-usage:3.2% oom_score:1032 oom_score_adj:1000
 total-pages: 32791748kB

Signed-off-by: Edward Chron <echron@arista.com>
---
 fs/proc/base.c      |  2 +-
 include/linux/oom.h | 18 +++++++++++-
 mm/oom_kill.c       | 67 +++++++++++++++++++++++++++++++++------------
 3 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..41880990e6a8 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -550,7 +550,7 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long totalpages = totalram_pages() + total_swap_pages;
 	unsigned long points = 0;
 
-	points = oom_badness(task, totalpages) * 1000 / totalpages;
+	points = oom_badness(task, totalpages, NULL) * 1000 / totalpages;
 	seq_printf(m, "%lu\n", points);
 
 	return 0;
diff --git a/include/linux/oom.h b/include/linux/oom.h
index c696c265f019..7f7ab125c21c 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -49,6 +49,8 @@ struct oom_control {
 	unsigned long totalpages;
 	struct task_struct *chosen;
 	unsigned long chosen_points;
+	unsigned long chosen_mempts;
+	unsigned long chosen_adj;
 
 	/* Used to print the constraint info. */
 	enum oom_constraint constraint;
@@ -105,10 +107,24 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 	return 0;
 }
 
+/*
+ * Optional argument that can be passed to oom_badness in the arg field
+ *
+ * Input fields that can be filled in: memcg and nodemask
+ * Output fields that can be returned: mempts, adj
+ */
+struct oom_bad_parms {
+	struct mem_cgroup *memcg;
+	const nodemask_t *nodemask;
+	unsigned long mempts;
+	long adj;
+};
+
 bool __oom_reap_task_mm(struct mm_struct *mm);
 
 extern unsigned long oom_badness(struct task_struct *p,
-		unsigned long totalpages);
+				 unsigned long totalpages,
+				 struct oom_bad_parms *obp);
 
 extern bool out_of_memory(struct oom_control *oc);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eda2e2a0bdc6..0548845dbef8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -42,6 +42,7 @@
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
+#include <linux/oom.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -195,7 +196,8 @@ static bool is_dump_unreclaim_slabs(void)
  * predictable as possible.  The goal is to return the highest value for the
  * task consuming the most memory to avoid subsequent oom failures.
  */
-unsigned long oom_badness(struct task_struct *p, unsigned long totalpages)
+unsigned long oom_badness(struct task_struct *p, unsigned long totalpages,
+			  struct oom_bad_parms *obp)
 {
 	long points;
 	long adj;
@@ -208,15 +210,16 @@ unsigned long oom_badness(struct task_struct *p, unsigned long totalpages)
 		return 0;
 
 	/*
-	 * Do not even consider tasks which are explicitly marked oom
-	 * unkillable or have been already oom reaped or the are in
-	 * the middle of vfork
+	 * Do not consider tasks which have already been oom reaped or
+	 * that are in the middle of vfork.
 	 */
 	adj = (long)p->signal->oom_score_adj;
-	if (adj == OOM_SCORE_ADJ_MIN ||
-			test_bit(MMF_OOM_SKIP, &p->mm->flags) ||
-			in_vfork(p)) {
+	if (test_bit(MMF_OOM_SKIP, &p->mm->flags) || in_vfork(p)) {
 		task_unlock(p);
+		if (obp != NULL) {
+			obp->mempts = 0;
+			obp->adj = adj;
+		}
 		return 0;
 	}
 
@@ -228,6 +231,16 @@ unsigned long oom_badness(struct task_struct *p, unsigned long totalpages)
 		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
 	task_unlock(p);
 
+	/* Also return raw mempts and oom_score_adj along */
+	if (obp != NULL) {
+		obp->mempts = points;
+		obp->adj = adj;
+	}
+
+	/* Unkillable oom task skipped but returns mempts and oom_score_adj */
+	if (adj == OOM_SCORE_ADJ_MIN)
+		return 0;
+
 	/* Normalize to oom_score_adj units */
 	adj *= totalpages / 1000;
 	points += adj;
@@ -310,6 +323,8 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 {
 	struct oom_control *oc = arg;
 	unsigned long points;
+	struct oom_bad_parms obp = { .memcg = NULL, .nodemask = oc->nodemask,
+				     .mempts = 0, .adj = 0 };
 
 	if (oom_unkillable_task(task))
 		goto next;
@@ -339,7 +354,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 		goto select;
 	}
 
-	points = oom_badness(task, oc->totalpages);
+	points = oom_badness(task, oc->totalpages, &obp);
 	if (!points || points < oc->chosen_points)
 		goto next;
 
@@ -349,6 +364,8 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 	get_task_struct(task);
 	oc->chosen = task;
 	oc->chosen_points = points;
+	oc->chosen_mempts = obp.mempts;
+	oc->chosen_adj = obp.adj;
 next:
 	return 0;
 abort:
@@ -375,6 +392,9 @@ static void select_bad_process(struct oom_control *oc)
 				break;
 		rcu_read_unlock();
 	}
+
+	oc->chosen_points = oc->chosen_points * 1000 / oc->totalpages;
+	oc->chosen_mempts = oc->chosen_mempts * 1000 / oc->totalpages;
 }
 
 static int dump_task(struct task_struct *p, void *arg)
@@ -853,7 +873,8 @@ static bool task_will_free_mem(struct task_struct *task)
 	return ret;
 }
 
-static void __oom_kill_process(struct task_struct *victim, const char *message)
+static void __oom_kill_process(struct task_struct *victim, const char *message,
+				struct oom_control *oc)
 {
 	struct task_struct *p;
 	struct mm_struct *mm;
@@ -884,12 +905,24 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	 */
 	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
-	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
-		message, task_pid_nr(victim), victim->comm,
-		K(victim->mm->total_vm),
-		K(get_mm_counter(victim->mm, MM_ANONPAGES)),
-		K(get_mm_counter(victim->mm, MM_FILEPAGES)),
-		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
+
+	if (oc != NULL && oc->chosen_mempts > 0)
+		pr_info("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, memory-usage:%lu.%1lu%% oom_score:%lu oom_score_adj:%ld total-pages: %lukB",
+			message, task_pid_nr(victim), victim->comm,
+			K(victim->mm->total_vm),
+			K(get_mm_counter(victim->mm, MM_ANONPAGES)),
+			K(get_mm_counter(victim->mm, MM_FILEPAGES)),
+			K(get_mm_counter(victim->mm, MM_SHMEMPAGES)),
+			oc->chosen_mempts / 10, oc->chosen_mempts % 10,
+			oc->chosen_points, oc->chosen_adj, K(oc->totalpages));
+	else
+		pr_info("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB",
+			message, task_pid_nr(victim), victim->comm,
+			K(victim->mm->total_vm),
+			K(get_mm_counter(victim->mm, MM_ANONPAGES)),
+			K(get_mm_counter(victim->mm, MM_FILEPAGES)),
+			K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
+
 	task_unlock(victim);
 
 	/*
@@ -942,7 +975,7 @@ static int oom_kill_memcg_member(struct task_struct *task, void *message)
 	if (task->signal->oom_score_adj != OOM_SCORE_ADJ_MIN &&
 	    !is_global_init(task)) {
 		get_task_struct(task);
-		__oom_kill_process(task, message);
+		__oom_kill_process(task, message, NULL);
 	}
 	return 0;
 }
@@ -979,7 +1012,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 */
 	oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
 
-	__oom_kill_process(victim, message);
+	__oom_kill_process(victim, message, oc);
 
 	/*
 	 * If necessary, kill all tasks in the selected memory cgroup.
-- 
2.20.1

