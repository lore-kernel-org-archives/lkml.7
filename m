Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BCFC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3933B2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtPgXcHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfF1PYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:24:51 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:41840 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1PYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:24:50 -0400
Received: by mail-pl1-f201.google.com with SMTP id i3so3698695plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZsiRx6xvzXROMUfoU65xDsRvBFu/S3BDc/iiU2HXWv4=;
        b=BtPgXcHakceSysUUvvTmVSqsGhdHXi1kTosXaG1TL6r/NdCk16Kn1UZudJwQ8FryNT
         MqMKLaTqfEshncO9iNRq3T2l4bFQs9lSi8YCG2CnMALJaJycGYuXhHwviqJu5AP4riC8
         i3YxItLgROyPMkeYXhbQ+04IIo3s28z1I4gbaqa10tstGRhTEsE7azL2mH+zTyglgFCp
         TB0VyCvjbF3Vt92IjWzM5k50QSqsGJtJ7QBekyVLXcBao3UchX5g5/oua87eS/1oWJUt
         brlC1HXwtP1z0swdd16RFVvCEJ2o2gDNUQpf/2Rc7F1tgTQ+cEGt2lKpSg+CStlr7gF1
         zxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZsiRx6xvzXROMUfoU65xDsRvBFu/S3BDc/iiU2HXWv4=;
        b=aDF8IjqC1TfFabMeeRVG7sceVFMLaihUaSnsTgRamRdB8OJFLSgG8sdu0J6ohDvraC
         R1B9Af+Qfzvt/+2Rh85XbP+wboaqvtLve0k1FxEX0mVPmob0q6cXSy3lCXP8QfYvliIC
         G6JsU8/20wPVvtM59MMUcSrbWxHD+Jv+xei/fOsAsSvT+693kUHkS/Zs7mQtuCuq6wRa
         brHoRh5K3iVViIk8fP0Peh4W8D+Gq8kiNOa/wJXt2QNZB/T6sOBXy78f//T79DqMwN+f
         oTi/H7WtxPTmtJGNT+jQe9tDzf6Z+4R/M70NKPr/Tp9G1lyncg9+vKXsgkAat4PgMq1s
         nNLg==
X-Gm-Message-State: APjAAAU1KVcCr08dPjgiP+7fUn/+LCNQRP1KPvHckptgFzswzoZ1CuYd
        PMYPKM/oejHdm2BMG6VA+ZnWc7vod3UH/w==
X-Google-Smtp-Source: APXvYqzEojWmbhFHT2oTqcaA/Uz0vqGKl0ZGIuOIBoO2lEvVjVcxnQ2cWLOCM1OrJQdFMc9IHU4lEf3YCZuZ6w==
X-Received: by 2002:a63:f953:: with SMTP id q19mr9792545pgk.367.1561735489272;
 Fri, 28 Jun 2019 08:24:49 -0700 (PDT)
Date:   Fri, 28 Jun 2019 08:24:19 -0700
Message-Id: <20190628152421.198994-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 1/3] mm, oom: refactor dump_tasks for memcg OOMs
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Paul Jackson <pj@sgi.com>, Nick Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_tasks() traverses all the existing processes even for the memcg OOM
context which is not only unnecessary but also wasteful.  This imposes a
long RCU critical section even from a contained context which can be quite
disruptive.

Change dump_tasks() to be aligned with select_bad_process and use
mem_cgroup_scan_tasks to selectively traverse only processes of the target
memcg hierarchy during memcg OOM.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: David Rientjes <rientjes@google.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Paul Jackson <pj@sgi.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changelog since v3:
- None

Changelog since v2:
- Updated the commit message.

Changelog since v1:
- Divide the patch into two patches.

 mm/oom_kill.c | 68 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 085abc91024d..a940d2aa92d6 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -380,10 +380,38 @@ static void select_bad_process(struct oom_control *oc)
 	}
 }
 
+static int dump_task(struct task_struct *p, void *arg)
+{
+	struct oom_control *oc = arg;
+	struct task_struct *task;
+
+	if (oom_unkillable_task(p, NULL, oc->nodemask))
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
@@ -391,37 +419,21 @@ static void select_bad_process(struct oom_control *oc)
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
@@ -453,7 +465,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 			dump_unreclaimable_slab();
 	}
 	if (sysctl_oom_dump_tasks)
-		dump_tasks(oc->memcg, oc->nodemask);
+		dump_tasks(oc);
 	if (p)
 		dump_oom_summary(oc, p);
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

