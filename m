Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B13C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2B620673
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+uIMTCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfFQXMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 19:12:34 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:36128 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfFQXMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:12:33 -0400
Received: by mail-qk1-f202.google.com with SMTP id b7so10640199qkk.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OqXw0t9fRr/azQRpWaonaAmH3L30B0p/Fx4/9IaKmEU=;
        b=l+uIMTCI5npW/nqR+ky6CSGLylxdHVeLxb2jOLCH1qr1XrTumE2XBxgN6ZmUkAXra1
         ntBZBh41tlpF3BBA55+I1PGrd6z4kEdS8Uv82kOLTTVnfUrFHdX7tbZQJyF8UcROls0i
         1c93b9o006nR8CZgd2EWyEyscBDXP8MnS+KB2Ue3lzsyD5dzhYW+nUGofuF/y74syGBs
         PYDHmZSJAzuMLtWDAbG4Af+6ggzwaueNFoqmaDUDXSIi/Z3MtYtfRNflCgo074OpQHfj
         EmRyhNDKDwlw3B3NOKNfeYgQU2FjysANV51nYmq0c4D+tKsQDNTP6PgD7PTxwPFDKxCU
         /p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OqXw0t9fRr/azQRpWaonaAmH3L30B0p/Fx4/9IaKmEU=;
        b=mUzsgK9o2/1FMN/Ibn67KzeXX7hfnA4i23wGEwjv4xav6gMMPrYT7dgDUY0WLF2nZI
         jn0fJIkcM6luU8XyIUjB+JqyoFnhYz4djMu4flMJdkbqzGoL5h8DDnmyfk9FukZhWBWG
         x4gAgZoIVIuo3WHs2e2Du0wSs9L9imOozjqa5mNZbZ85kSZa/JeLROuRvqQGuJnJ9DER
         ZKl41I3uaPYyejGkndoMMmafXoPr7M+KmWk0QxJqmSdVmN7E7B7eOuLd6PUwBVQToBEP
         dKheBxePISKFTmw37b7y6V2UITIz01hw40ewWH5g1cI5P+w6fMewxLfgsj9RrDDZcw3k
         RuYA==
X-Gm-Message-State: APjAAAXpfWYzsCaDegEdUmUhiP0g/z0RX9LqLLjvJIX3aaZ1l111mksH
        PyUhDarULHmNp6rR766Ipa6dBhes2cd3fw==
X-Google-Smtp-Source: APXvYqypIi8nO7ZBX6Y8v6IyGHG5MzrimR5HjvoCIsgCWDQWP5j91s5/qQKuaJpxz7EBH4UYoTFh6kJ18bE4Zw==
X-Received: by 2002:ac8:2b01:: with SMTP id 1mr26419700qtu.177.1560813152241;
 Mon, 17 Jun 2019 16:12:32 -0700 (PDT)
Date:   Mon, 17 Jun 2019 16:12:07 -0700
In-Reply-To: <20190617231207.160865-1-shakeelb@google.com>
Message-Id: <20190617231207.160865-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20190617231207.160865-1-shakeelb@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 2/2] mm, oom: fix oom_unkillable_task for memcg OOMs
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

This commit also removed the bogus usage of oom_unkillable_task() from
oom_badness(). Currently reading /proc/[pid]/oom_score will do a bogus
cpuset_mems_allowed_intersects() check. Removing that.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changelog since v1:
- Divide the patch into two patches.

 fs/proc/base.c      |  3 +--
 include/linux/oom.h |  1 -
 mm/oom_kill.c       | 28 +++++++++++++++-------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b8d5d100ed4a..57b7a0d75ef5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -532,8 +532,7 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long totalpages = totalram_pages() + total_swap_pages;
 	unsigned long points = 0;
 
-	points = oom_badness(task, NULL, NULL, totalpages) *
-					1000 / totalpages;
+	points = oom_badness(task, totalpages) * 1000 / totalpages;
 	seq_printf(m, "%lu\n", points);
 
 	return 0;
diff --git a/include/linux/oom.h b/include/linux/oom.h
index d07992009265..c696c265f019 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -108,7 +108,6 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 bool __oom_reap_task_mm(struct mm_struct *mm);
 
 extern unsigned long oom_badness(struct task_struct *p,
-		struct mem_cgroup *memcg, const nodemask_t *nodemask,
 		unsigned long totalpages);
 
 extern bool out_of_memory(struct oom_control *oc);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index bd80997e0969..d779d9da1069 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -152,20 +152,23 @@ static inline bool is_memcg_oom(struct oom_control *oc)
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
 
-	/* When mem_cgroup_out_of_memory() and p is not member of the group */
-	if (memcg && !task_in_mem_cgroup(p, memcg))
-		return true;
+	/*
+	 * For memcg OOM, we reach here through mem_cgroup_scan_tasks(), no
+	 * need to check p's memcg membership and the checks after this
+	 * are irrelevant for memcg OOMs.
+	 */
+	if (is_memcg_oom(oc))
+		return false;
 
 	/* p may not have freeable memory in nodemask */
-	if (!has_intersects_mems_allowed(p, nodemask))
+	if (!has_intersects_mems_allowed(p, oc->nodemask))
 		return true;
 
 	return false;
@@ -201,13 +204,12 @@ static bool is_dump_unreclaim_slabs(void)
  * predictable as possible.  The goal is to return the highest value for the
  * task consuming the most memory to avoid subsequent oom failures.
  */
-unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
-			  const nodemask_t *nodemask, unsigned long totalpages)
+unsigned long oom_badness(struct task_struct *p, unsigned long totalpages)
 {
 	long points;
 	long adj;
 
-	if (oom_unkillable_task(p, memcg, nodemask))
+	if (is_global_init(p) || p->flags & PF_KTHREAD)
 		return 0;
 
 	p = find_lock_task_mm(p);
@@ -318,7 +320,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 	struct oom_control *oc = arg;
 	unsigned long points;
 
-	if (oom_unkillable_task(task, NULL, oc->nodemask))
+	if (oom_unkillable_task(task, oc))
 		goto next;
 
 	/*
@@ -342,7 +344,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 		goto select;
 	}
 
-	points = oom_badness(task, NULL, oc->nodemask, oc->totalpages);
+	points = oom_badness(task, oc->totalpages);
 	if (!points || points < oc->chosen_points)
 		goto next;
 
@@ -390,7 +392,7 @@ static int dump_task(struct task_struct *p, void *arg)
 	struct oom_control *oc = arg;
 	struct task_struct *task;
 
-	if (oom_unkillable_task(p, NULL, oc->nodemask))
+	if (oom_unkillable_task(p, oc))
 		return 0;
 
 	task = find_lock_task_mm(p);
@@ -1090,7 +1092,7 @@ bool out_of_memory(struct oom_control *oc)
 	check_panic_on_oom(oc, constraint);
 
 	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
-	    current->mm && !oom_unkillable_task(current, NULL, oc->nodemask) &&
+	    current->mm && !oom_unkillable_task(current, oc) &&
 	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
 		get_task_struct(current);
 		oc->chosen = current;
-- 
2.22.0.410.gd8fdbe21b5-goog

