Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA55C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF59F20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSEuBJIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbfFXV1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:27:13 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:47317 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFXV1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:27:13 -0400
Received: by mail-pg1-f201.google.com with SMTP id o19so1681767pgl.14
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sa3SuUX0bUdZ+/DPsEnrnSpXOijycTDQTkt1G/hyG1Q=;
        b=YSEuBJIYgMuNvjA5C4AGwJRKYgCKfgAywDauf23tmhw82cTmENHQLSvleNMzTMUx7a
         dZdvl6ekaexPTY21e5PaGnf+lgSUZu3WqOXpa6/figfc9kb1B0PMgYBKA2VT8GIu3YCq
         rTbauU2LdrdyYT3l5T5/rtaX1TFiAuvnVKfJItAnUP7n0q3u8IpF2wYJOu0hU4zeDA9X
         HfP23YZkkbhEgmtyOSbozmDz5BMLF+kpxuNpbnVIR1VQcSJ804QHBmI4cvTQdb67Gbw2
         A2tvWqeHUrD+dG99W/OTl342w2Wi0Cn0mY3VCUrl1weMEeNcjssekT8BYB3g/PQDOjNu
         ZoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sa3SuUX0bUdZ+/DPsEnrnSpXOijycTDQTkt1G/hyG1Q=;
        b=NJTwJ09gFbBtEszZ0G7GwD1GqRLhwWLt9kQojA1XAGNczlViFp29T4WHhYXylHFEmR
         8rcloXwvWTKQTucaQm296SWjfbQECdmEAMNrGLjDdRNP8cOqiCRRI6rAPcuUjH5aNXXL
         sed2iY7dzpitkSTdfP60iVKQUEbN6nBZIwp1p2JtM/Wa/vuXKu8z2cnZzDRZlezaWHvV
         lfqPxKEHR4pbtq5vITRR+RR6L2I/MAngVmYjsASFUTon9v953mJ77sxZDnbiP0dIbMyi
         qSsW39jP52quVSME1O0hbk0tfhIJ60/jPPUQHaYtR6ihnCPkHsyyFjNUYf9m5SWkZq8M
         Wu1A==
X-Gm-Message-State: APjAAAUkLbZBfPhqo9BoVEewgwZo8FTe/DPSTLvQ6gqORbR/tsYjr+Cf
        MiwkuAG19ntOcr+rVrM2kRgJldyz4KDb5A==
X-Google-Smtp-Source: APXvYqzE+87QCjeOOWH6Ce+0epylnDirKlTALkb9slWcVHEI96itaGHM0hDlOF2bc4DiIuDSmbo0WgHvL2/DWg==
X-Received: by 2002:a63:3d0f:: with SMTP id k15mr35177489pga.343.1561411631861;
 Mon, 24 Jun 2019 14:27:11 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:26:31 -0700
In-Reply-To: <20190624212631.87212-1-shakeelb@google.com>
Message-Id: <20190624212631.87212-3-shakeelb@google.com>
Mime-Version: 1.0
References: <20190624212631.87212-1-shakeelb@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 3/3] oom: decouple mems_allowed from oom_unkillable_task
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Jackson <pj@sgi.com>, Nick Piggin <npiggin@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit ef08e3b4981a ("[PATCH] cpusets: confine oom_killer to
mem_exclusive cpuset") introduces a heuristic where a potential
oom-killer victim is skipped if the intersection of the potential victim
and the current (the process triggered the oom) is empty based on the
reason that killing such victim most probably will not help the current
allocating process. However the commit 7887a3da753e ("[PATCH] oom:
cpuset hint") changed the heuristic to just decrease the oom_badness
scores of such potential victim based on the reason that the cpuset of
such processes might have changed and previously they might have
allocated memory on mems where the current allocating process can
allocate from.

Unintentionally commit 7887a3da753e ("[PATCH] oom: cpuset hint")
introduced a side effect as the oom_badness is also exposed to the
user space through /proc/[pid]/oom_score, so, readers with different
cpusets can read different oom_score of th same process.

Later the commit 6cf86ac6f36b ("oom: filter tasks not sharing the same
cpuset") fixed the side effect introduced by 7887a3da753e by moving the
cpuset intersection back to only oom-killer context and out of
oom_badness. However the combination of the commit ab290adbaf8f ("oom:
make oom_unkillable_task() helper function") and commit 26ebc984913b
("oom: /proc/<pid>/oom_score treat kernel thread honestly")
unintentionally brought back the cpuset intersection check into the
oom_badness calculation function.

Other than doing cpuset/mempolicy intersection from oom_badness, the
memcg oom context is also doing cpuset/mempolicy intersection which is
quite wrong and is caught by syzcaller with the following report:

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 28426 Comm: syz-executor.5 Not tainted 5.2.0-rc3-next-20190607
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
RIP: 0010:has_intersects_mems_allowed mm/oom_kill.c:84 [inline]
RIP: 0010:oom_unkillable_task mm/oom_kill.c:168 [inline]
RIP: 0010:oom_unkillable_task+0x180/0x400 mm/oom_kill.c:155
Code: c1 ea 03 80 3c 02 00 0f 85 80 02 00 00 4c 8b a3 10 07 00 00 48 b8 00
00 00 00 00 fc ff df 4d 8d 74 24 10 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f
85 67 02 00 00 49 8b 44 24 10 4c 8d a0 68 fa ff ff
RSP: 0018:ffff888000127490 EFLAGS: 00010a03
RAX: dffffc0000000000 RBX: ffff8880a4cd5438 RCX: ffffffff818dae9c
RDX: 100000000c3cc602 RSI: ffffffff818dac8d RDI: 0000000000000001
RBP: ffff8880001274d0 R08: ffff888000086180 R09: ffffed1015d26be0
R10: ffffed1015d26bdf R11: ffff8880ae935efb R12: 8000000061e63007
R13: 0000000000000000 R14: 8000000061e63017 R15: 1ffff11000024ea6
FS:  00005555561f5940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000607304 CR3: 000000009237e000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  oom_evaluate_task+0x49/0x520 mm/oom_kill.c:321
  mem_cgroup_scan_tasks+0xcc/0x180 mm/memcontrol.c:1169
  select_bad_process mm/oom_kill.c:374 [inline]
  out_of_memory mm/oom_kill.c:1088 [inline]
  out_of_memory+0x6b2/0x1280 mm/oom_kill.c:1035
  mem_cgroup_out_of_memory+0x1ca/0x230 mm/memcontrol.c:1573
  mem_cgroup_oom mm/memcontrol.c:1905 [inline]
  try_charge+0xfbe/0x1480 mm/memcontrol.c:2468
  mem_cgroup_try_charge+0x24d/0x5e0 mm/memcontrol.c:6073
  mem_cgroup_try_charge_delay+0x1f/0xa0 mm/memcontrol.c:6088
  do_huge_pmd_wp_page_fallback+0x24f/0x1680 mm/huge_memory.c:1201
  do_huge_pmd_wp_page+0x7fc/0x2160 mm/huge_memory.c:1359
  wp_huge_pmd mm/memory.c:3793 [inline]
  __handle_mm_fault+0x164c/0x3eb0 mm/memory.c:4006
  handle_mm_fault+0x3b7/0xa90 mm/memory.c:4053
  do_user_addr_fault arch/x86/mm/fault.c:1455 [inline]
  __do_page_fault+0x5ef/0xda0 arch/x86/mm/fault.c:1521
  do_page_fault+0x71/0x57d arch/x86/mm/fault.c:1552
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1156
RIP: 0033:0x400590
Code: 06 e9 49 01 00 00 48 8b 44 24 10 48 0b 44 24 28 75 1f 48 8b 14 24 48
8b 7c 24 20 be 04 00 00 00 e8 f5 56 00 00 48 8b 74 24 08 <89> 06 e9 1e 01
00 00 48 8b 44 24 08 48 8b 14 24 be 04 00 00 00 8b
RSP: 002b:00007fff7bc49780 EFLAGS: 00010206
RAX: 0000000000000001 RBX: 0000000000760000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000000002000cffc RDI: 0000000000000001
RBP: fffffffffffffffe R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000075 R11: 0000000000000246 R12: 0000000000760008
R13: 00000000004c55f2 R14: 0000000000000000 R15: 00007fff7bc499b0
Modules linked in:
---[ end trace a65689219582ffff ]---
RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
RIP: 0010:has_intersects_mems_allowed mm/oom_kill.c:84 [inline]
RIP: 0010:oom_unkillable_task mm/oom_kill.c:168 [inline]
RIP: 0010:oom_unkillable_task+0x180/0x400 mm/oom_kill.c:155
Code: c1 ea 03 80 3c 02 00 0f 85 80 02 00 00 4c 8b a3 10 07 00 00 48 b8 00
00 00 00 00 fc ff df 4d 8d 74 24 10 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f
85 67 02 00 00 49 8b 44 24 10 4c 8d a0 68 fa ff ff
RSP: 0018:ffff888000127490 EFLAGS: 00010a03
RAX: dffffc0000000000 RBX: ffff8880a4cd5438 RCX: ffffffff818dae9c
RDX: 100000000c3cc602 RSI: ffffffff818dac8d RDI: 0000000000000001
RBP: ffff8880001274d0 R08: ffff888000086180 R09: ffffed1015d26be0
R10: ffffed1015d26bdf R11: ffff8880ae935efb R12: 8000000061e63007
R13: 0000000000000000 R14: 8000000061e63017 R15: 1ffff11000024ea6
FS:  00005555561f5940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f823000 CR3: 000000009237e000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600

The fix is to decouple the cpuset/mempolicy intersection check from
oom_unkillable_task() and make sure cpuset/mempolicy intersection check
is only done in the global oom context.

Reported-by: syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changelog since v2:
- Further divided the patch into two patches.
- More cleaned version.

Changelog since v1:
- Divide the patch into two patches.

 fs/proc/base.c      |  3 +--
 include/linux/oom.h |  1 -
 mm/oom_kill.c       | 51 ++++++++++++++++++++++++++-------------------
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5eacce5e924a..57b7a0d75ef5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -532,8 +532,7 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long totalpages = totalram_pages() + total_swap_pages;
 	unsigned long points = 0;
 
-	points = oom_badness(task, NULL, totalpages) *
-					1000 / totalpages;
+	points = oom_badness(task, totalpages) * 1000 / totalpages;
 	seq_printf(m, "%lu\n", points);
 
 	return 0;
diff --git a/include/linux/oom.h b/include/linux/oom.h
index b75104690311..c696c265f019 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -108,7 +108,6 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 bool __oom_reap_task_mm(struct mm_struct *mm);
 
 extern unsigned long oom_badness(struct task_struct *p,
-		const nodemask_t *nodemask,
 		unsigned long totalpages);
 
 extern bool out_of_memory(struct oom_control *oc);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index e0cdcbd58b0b..9f91cb7036fb 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -64,6 +64,11 @@ int sysctl_oom_dump_tasks = 1;
  */
 DEFINE_MUTEX(oom_lock);
 
+static inline bool is_memcg_oom(struct oom_control *oc)
+{
+	return oc->memcg != NULL;
+}
+
 #ifdef CONFIG_NUMA
 /**
  * has_intersects_mems_allowed() - check task eligiblity for kill
@@ -73,12 +78,18 @@ DEFINE_MUTEX(oom_lock);
  * Task eligibility is determined by whether or not a candidate task, @tsk,
  * shares the same mempolicy nodes as current if it is bound by such a policy
  * and whether or not it has the same set of allowed cpuset nodes.
+ *
+ * Only call in the global oom context (i.e. not in memcg oom). This function
+ * is assuming 'current' has triggered the oom-killer.
  */
 static bool has_intersects_mems_allowed(struct task_struct *start,
-					const nodemask_t *mask)
+					struct oom_control *oc)
 {
 	struct task_struct *tsk;
 	bool ret = false;
+	const nodemask_t *mask = oc->nodemask;
+
+	VM_BUG_ON(is_memcg_oom(oc));
 
 	rcu_read_lock();
 	for_each_thread(start, tsk) {
@@ -106,7 +117,7 @@ static bool has_intersects_mems_allowed(struct task_struct *start,
 }
 #else
 static bool has_intersects_mems_allowed(struct task_struct *tsk,
-					const nodemask_t *mask)
+					struct oom_control *oc)
 {
 	return true;
 }
@@ -146,24 +157,13 @@ static inline bool is_sysrq_oom(struct oom_control *oc)
 	return oc->order == -1;
 }
 
-static inline bool is_memcg_oom(struct oom_control *oc)
-{
-	return oc->memcg != NULL;
-}
-
 /* return true if the task is not adequate as candidate victim task. */
-static bool oom_unkillable_task(struct task_struct *p,
-				const nodemask_t *nodemask)
+static bool oom_unkillable_task(struct task_struct *p)
 {
 	if (is_global_init(p))
 		return true;
 	if (p->flags & PF_KTHREAD)
 		return true;
-
-	/* p may not have freeable memory in nodemask */
-	if (!has_intersects_mems_allowed(p, nodemask))
-		return true;
-
 	return false;
 }
 
@@ -190,19 +190,17 @@ static bool is_dump_unreclaim_slabs(void)
  * oom_badness - heuristic function to determine which candidate task to kill
  * @p: task struct of which task we should calculate
  * @totalpages: total present RAM allowed for page allocation
- * @nodemask: nodemask passed to page allocator for mempolicy ooms
  *
  * The heuristic for determining which task to kill is made to be as simple and
  * predictable as possible.  The goal is to return the highest value for the
  * task consuming the most memory to avoid subsequent oom failures.
  */
-unsigned long oom_badness(struct task_struct *p,
-			  const nodemask_t *nodemask, unsigned long totalpages)
+unsigned long oom_badness(struct task_struct *p, unsigned long totalpages)
 {
 	long points;
 	long adj;
 
-	if (oom_unkillable_task(p, nodemask))
+	if (oom_unkillable_task(p))
 		return 0;
 
 	p = find_lock_task_mm(p);
@@ -313,7 +311,11 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 	struct oom_control *oc = arg;
 	unsigned long points;
 
-	if (oom_unkillable_task(task, oc->nodemask))
+	if (oom_unkillable_task(task))
+		goto next;
+
+	/* p may not have freeable memory in nodemask */
+	if (!is_memcg_oom(oc) && !has_intersects_mems_allowed(task, oc))
 		goto next;
 
 	/*
@@ -337,7 +339,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 		goto select;
 	}
 
-	points = oom_badness(task, oc->nodemask, oc->totalpages);
+	points = oom_badness(task, oc->totalpages);
 	if (!points || points < oc->chosen_points)
 		goto next;
 
@@ -385,7 +387,11 @@ static int dump_task(struct task_struct *p, void *arg)
 	struct oom_control *oc = arg;
 	struct task_struct *task;
 
-	if (oom_unkillable_task(p, oc->nodemask))
+	if (oom_unkillable_task(p))
+		return 0;
+
+	/* p may not have freeable memory in nodemask */
+	if (!is_memcg_oom(oc) && !has_intersects_mems_allowed(p, oc))
 		return 0;
 
 	task = find_lock_task_mm(p);
@@ -1085,7 +1091,8 @@ bool out_of_memory(struct oom_control *oc)
 	check_panic_on_oom(oc, constraint);
 
 	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
-	    current->mm && !oom_unkillable_task(current, oc->nodemask) &&
+	    current->mm && !oom_unkillable_task(current) &&
+	    has_intersects_mems_allowed(current, oc) &&
 	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
 		get_task_struct(current);
 		oc->chosen = current;
-- 
2.22.0.410.gd8fdbe21b5-goog

