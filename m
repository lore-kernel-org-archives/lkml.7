Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE10C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7F12089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZfxRwku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfFQXMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 19:12:20 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:41589 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfFQXMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:12:19 -0400
Received: by mail-qk1-f201.google.com with SMTP id o4so10574186qko.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 16:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TTbfAoCu4GcLQkkLsQIxh3IHCYFVhiWbbnmqLqGCZT0=;
        b=jZfxRwkuPiIZFdGi8/rcF/0bUZMdwezu9vWxjpUUpRPuvxG5dw4JNY14gsHU9oJO7L
         5Ij05KVs3YqhUSK4gIWk7xpWLfYXFKMftiSRm/Mgqzn7g0EmryRy3F2zWB6hOQWfPRY/
         JlTfwaY6GRkIfoFywWkH69cSk8CbEx2ZgsPSAm37sfkCwaVzqIx7vOf58IUykipTNvNi
         oBlN9+odE31x0bFBwmGnoXtcusvTakGy0oF8zsTPvn+VP6/+vhFxO+qPt5Mq50KOZFVi
         UvttSwG9/I+2SkU2G5Q/7CvQfoEiGhjcidF4r4zlvCxa4iexnTrcJDXbiNWo9kJ4rcBV
         +EAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TTbfAoCu4GcLQkkLsQIxh3IHCYFVhiWbbnmqLqGCZT0=;
        b=H1UmkCEV2ayinvS+f+fAgxUbYN0jnJ4ML/31RX93U4MIVHzjWAjQuZZQrBtG1zRMUo
         y1875YZ68N2AdcUdb/DXxolZQzOV8cUbrd8lKxVLBGUYlWrkwJP92ytND4uvi5DqxMtV
         Ri92PgU2Bac3FcztTO4aQ2mpL5JqsPjK0xFDpYKk6byJaPEALPwiojjQ3Zj1lRO+39tu
         tmCS1v1O4fNhg2uXLKng6B6E++DOMAPvOBSuRVxrk5KiYKlvl8Bc+yfHOsKf96xPAU6+
         e1s6YXsBxvhKB3rZUOimitisz3fzvjmvQPhjmU+Khrymco3HAtNBjmqQ20ocMEgrfqlh
         9e6g==
X-Gm-Message-State: APjAAAU6HLOjwX49tkemABVEJ/nbUo8Z1ObIbarj+6UiZO1ls2d/huVx
        ras7dl4jSzx9L7B511imHA1huizlmuJ3XQ==
X-Google-Smtp-Source: APXvYqxzU6qeR8sKemK093KPas/vEHXa3zteT7sWEEHxpSEXDl1Y6eqEq1INAQbGNd3g0D1h3RhweCuzOwlhjg==
X-Received: by 2002:ac8:17f7:: with SMTP id r52mr98077354qtk.235.1560813138436;
 Mon, 17 Jun 2019 16:12:18 -0700 (PDT)
Date:   Mon, 17 Jun 2019 16:12:06 -0700
Message-Id: <20190617231207.160865-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 1/2] mm, oom: refactor dump_tasks for memcg OOMs
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

dump_tasks() currently goes through all the processes present on the
system even for memcg OOMs. Change dump_tasks() similar to
select_bad_process() and use mem_cgroup_scan_tasks() to selectively
traverse the processes of the memcgs during memcg OOM.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
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

