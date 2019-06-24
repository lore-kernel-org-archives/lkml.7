Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881D4C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A44F208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCpgEkM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfFXV0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:26:51 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52583 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFXV0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:26:51 -0400
Received: by mail-pf1-f202.google.com with SMTP id a20so10324691pfn.19
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 14:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QuhQR2g5/6NgmqGFuivV/bpabSOVZ9f1VzuLjz/nCSs=;
        b=fCpgEkM3oU/q6tGjPXFgGeBjEu3hVd9yUvzw1RQH/0g25b6Jh+izus//6Javr+fxFc
         HH3rWllH1qzQxTgR+uHyVLDW9+cBU2XiQWne19jdSqEFYsuGN8N6hWC2lvovRusHjFPE
         wOHZB62oPVqhJ9vqAq/XIzj5rSF0X8WKlUCxK9TJtmCa/M1EUosulXBohIJZ5jLhOdY1
         h8BIR+9sdQhMyh/BkBVU8vmep7CExj0cBDdxuKwkUdAL/uvVGbi5K1xqsja0TmlJ+1ia
         lsKhi4mrjMbKSfw9mgRUaLGeY9+RY5b7ciQDh312AiL6TloQaBuIZobxBEM8VNlJd5vn
         PPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QuhQR2g5/6NgmqGFuivV/bpabSOVZ9f1VzuLjz/nCSs=;
        b=dHeaoeeklATdq5P7HuZKi7bEd2C75a9J6AJQkMrFsR6Rt1gbd5gZ84tCATzyHrTDRN
         l45d3b/speSkfTrZM9Cozp4QpU/gzmy3DR/yojE9XnrmqQvHYG9GGQ2SquoXNbyOeqgx
         BhIQw5YAuzHN+ldOpajBZC36ejGsHNvRZGHRz6Q4MO2try9cWhiJJGzqWc70NG9iDviI
         jVbrUmpflUEWFC6CuqgfczQs+ZWMoa+FgaMtUgU6t15vVyjMwTuJhzXoGnajQoa2PiMY
         B6xt11ETS1snzjxFsupeCN6hAkgcZ2Dk6qmPUMXCqPSCzdp3kPtUVMN3wWJ/n1Dg4u8/
         LypQ==
X-Gm-Message-State: APjAAAXLTQxq0H5ttLxwDaq3N7kk7ue7poKKz5Kt+IAz4Y+Y2mUtCWKD
        Pf1ujKs1q7ervd+tnsp8let9fD1F17aOJw==
X-Google-Smtp-Source: APXvYqz5a7SZDemOpTEhQLNyJry7dI+Y4LMqToKE27cqw3yUALC3EexEf36v0Lyn6dcmeZbhLipgWCztywg1PA==
X-Received: by 2002:a63:296:: with SMTP id 144mr35516171pgc.141.1561411610100;
 Mon, 24 Jun 2019 14:26:50 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:26:29 -0700
Message-Id: <20190624212631.87212-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 1/3] mm, oom: refactor dump_tasks for memcg OOMs
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
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_tasks() traverses all the existing processes even for the memcg OOM
context which is not only unnecessary but also wasteful. This imposes
a long RCU critical section even from a contained context which can be
quite disruptive.

Change dump_tasks() to be aligned with select_bad_process and use
mem_cgroup_scan_tasks to selectively traverse only processes of the
target memcg hierarchy during memcg OOM.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>

---
Changelog since v2:
- Updated the commit message.

Changelog since v1:
- Divide the patch into two patches.

 mm/oom_kill.c | 68 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 05aaa1a5920b..bd80997e0969 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -385,10 +385,38 @@ static void select_bad_process(struct oom_control *oc)
 	oc->chosen_points = oc->chosen_points * 1000 / oc->totalpages;
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
@@ -396,37 +424,21 @@ static void select_bad_process(struct oom_control *oc)
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
@@ -458,7 +470,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
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

