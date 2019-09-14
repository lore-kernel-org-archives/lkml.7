Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4689FC49ED6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 06:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1472220717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 06:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfINGPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 02:15:50 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50174 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfINGPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 02:15:50 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x8E6FSFL004117;
        Sat, 14 Sep 2019 15:15:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Sat, 14 Sep 2019 15:15:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x8E6FMFa004086
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 14 Sep 2019 15:15:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH (resend)] mm,oom: Defer dump_tasks() output.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <1567159493-5232-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <7de2310d-afbd-e616-e83a-d75103b986c6@i-love.sakura.ne.jp>
 <20190909113627.GJ27159@dhcp22.suse.cz>
 <579a27d2-52fb-207e-9278-fc20a2154394@i-love.sakura.ne.jp>
 <20190909130435.GO27159@dhcp22.suse.cz>
 <5bbcd93f-aa42-6c62-897a-d7b94aacdb87@i-love.sakura.ne.jp>
Message-ID: <57be50b2-a97a-e559-e4bd-10d923895f83@i-love.sakura.ne.jp>
Date:   Sat, 14 Sep 2019 15:15:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5bbcd93f-aa42-6c62-897a-d7b94aacdb87@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/10 20:00, Tetsuo Handa wrote:
> On 2019/09/09 22:04, Michal Hocko wrote:
>> On Mon 09-09-19 21:40:24, Tetsuo Handa wrote:
>>> On 2019/09/09 20:36, Michal Hocko wrote:
>>>> This is not an improvement. It detaches the oom report and tasks_dump
>>>> for an arbitrary amount of time because the worder context might be
>>>> stalled for an arbitrary time. Even long after the oom is resolved.
>>>
>>> A new worker thread is created if all existing worker threads are busy
>>> because this patch solves OOM situation quickly when a new worker thread
>>> cannot be created due to OOM situation.
>>>
>>> Also, if a worker thread cannot run due to CPU starvation, the same thing
>>> applies to dump_tasks(). In other words, dump_tasks() cannot complete due
>>> to CPU starvation, which results in more costly and serious consequences.
>>> Being able to send SIGKILL and reclaim memory as soon as possible is
>>> an improvement.
>>
>> There might be zillion workers waiting to make a forward progress and
>> you cannot expect any timing here. Just remember your own experiments
>> with xfs and low memory conditions.
> 
> Even if there were zillion workers waiting to make a forward progress, the
> worker for processing dump_tasks() output can make a forward progress. That's
> how workqueue works. (If you still don't trust workqueue, I can update my patch
> to use a kernel thread.) And if there were zillion workers waiting to make a
> forward progress, completing the OOM killer quickly will be more important than
> keep blocking zillion workers waiting for the OOM killer to solve OOM situation.
> Preempting a thread calling out_of_memory() by zillion workers is a nightmare. ;-)
> 
>>
>>>> Not to mention that 1:1 (oom to tasks) information dumping is
>>>> fundamentally broken. Any task might be on an oom list of different
>>>> OOM contexts in different oom scopes (think of OOM happening in disjunct
>>>> NUMA sets).
>>>
>>> I can't understand what you are talking about. This patch just defers
>>> printk() from /proc/sys/vm/oom_dump_tasks != 0. Please look at the patch
>>> carefully. If you are saying that it is bad that OOM victim candidates for
>>> OOM domain B, C, D ... cannot be printed if printing of OOM victim candidates
>>> for OOM domain A has not finished, I can update this patch to print them.
>>
>> You would have to track each ongoing oom context separately.
> 
> I can update my patch to track each OOM context separately. But
> 
>>                                                              And not
>> only those from different oom scopes because as a matter of fact a new
>> OOM might trigger before the previous dump_tasks managed to be handled.
> 
> please be aware that we are already dropping OOM messages from different scopes
> due to __ratelimit(&oom_rs). The difference is, given that __ratelimit(&oom_rs)
> can work, nothing but which OOM messages will be dropped when cluster of OOM
> events from multiple different scopes happened.
> 
> And "OOM events from multiple different scopes can trivially happen" is a
> violation for commit dc56401fc9f25e8f ("mm: oom_kill: simplify OOM killer
> locking") saying
> 
>     However, the OOM killer is a fairly cold error path, there is really no
>     reason to optimize for highly performant and concurrent OOM kills.
> 
> where we will need "per an OOM scope locking mechanism" in order to avoid
> deferring OOM killer event in current thread's OOM scope due to processing
> OOM killer events in other threads' OOM scopes.
> 

Here is a delta patch.

From d34ef26275635d14c746ed46e5478c1dc0319ca2 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 14 Sep 2019 15:11:02 +0900
Subject: [PATCH] mm,oom: Don't suppress dump_tasks() output from different OOM
 scopes.

Michal Hocko is complaining that "mm,oom: Defer dump_tasks() output."
needlessly suppresses concurrent OOM killer invocations from different
OOM scopes. This patch changes dump_tasks() not to suppress such output.

---
 kernel/fork.c |  1 +
 mm/oom_kill.c | 64 ++++++++++++++++++++++++++++++++++++++---------------------
 2 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f601168..c86a126d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1854,6 +1854,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
+	INIT_LIST_HEAD(&p->oom_task_info.list);
 
 	/*
 	 * This _must_ happen before we call free_task(), i.e. before we jump
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index db62f50..7f57cea 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -379,6 +379,7 @@ static void select_bad_process(struct oom_control *oc)
 
 static unsigned int oom_killer_seq; /* Serialized by oom_lock. */
 static LIST_HEAD(oom_candidate_list); /* Serialized by oom_lock. */
+static LIST_HEAD(oom_tmp_candidate_list); /* Serialized by oom_lock. */
 
 static int add_candidate_task(struct task_struct *p, void *arg)
 {
@@ -395,8 +396,13 @@ static int add_candidate_task(struct task_struct *p, void *arg)
 	p = find_lock_task_mm(p);
 	if (!p)
 		return 0;
-	get_task_struct(p);
 	oti = &p->oom_task_info;
+	/* p might be still waiting for dump_candidate_tasks(). */
+	if (!list_empty(&oti->list)) {
+		task_unlock(p);
+		return 1;
+	}
+	get_task_struct(p);
 	mm = p->mm;
 	oti->seq = oom_killer_seq;
 	memcpy(oti->comm, p->comm, sizeof(oti->comm));
@@ -409,14 +415,14 @@ static int add_candidate_task(struct task_struct *p, void *arg)
 	oti->swapents = get_mm_counter(mm, MM_SWAPENTS);
 	oti->score_adj = p->signal->oom_score_adj;
 	task_unlock(p);
-	list_add_tail(&oti->list, &oom_candidate_list);
+	list_add_tail(&oti->list, &oom_tmp_candidate_list);
 	return 0;
 }
 
 static void dump_candidate_tasks(struct work_struct *work)
 {
 	bool first = true;
-	unsigned int seq;
+	unsigned int seq = 0;
 	struct oom_task_info *oti;
 
 	if (work) /* Serialize only if asynchronous. */
@@ -424,7 +430,10 @@ static void dump_candidate_tasks(struct work_struct *work)
 	while (!list_empty(&oom_candidate_list)) {
 		oti = list_first_entry(&oom_candidate_list,
 				       struct oom_task_info, list);
-		seq = oti->seq;
+		if (seq != oti->seq) {
+			seq = oti->seq;
+			first = true;
+		}
 		if (first) {
 			pr_info("OOM[%u]: Tasks state (memory values in pages):\n",
 				seq);
@@ -436,7 +445,7 @@ static void dump_candidate_tasks(struct work_struct *work)
 			seq, oti->pid, oti->uid, oti->tgid, oti->total_vm,
 			oti->mm_rss, oti->pgtables_bytes, oti->swapents,
 			oti->score_adj, oti->comm);
-		list_del(&oti->list);
+		list_del_init(&oti->list);
 		if (work)
 			mutex_unlock(&oom_lock);
 		put_task_struct(container_of(oti, struct task_struct,
@@ -464,32 +473,41 @@ static void dump_candidate_tasks(struct work_struct *work)
 static void dump_tasks(struct oom_control *oc)
 {
 	struct task_struct *p;
+	int ret = 0;
 
 	/*
-	 * Suppress as long as there is any OOM victim candidate from past
-	 * rounds of OOM killer invocations. We could change this to suppress
-	 * only if there is an OOM victim candidate in the same OOM domain if
-	 * we want to see OOM victim candidates from different OOM domains.
-	 * But since dump_header() is already ratelimited, I don't know whether
-	 * it makes difference to suppress OOM victim candidates from different
-	 * OOM domains...
+	 * Suppress if OOM victim candidates in the same OOM scope from past
+	 * OOM killer invocations are still waiting for dump_candidate_tasks(),
+	 * for it is possible that the OOM reaper or exit_mmap() sets
+	 * MMF_OOM_SKIP before dump_candidate_tasks() completes. Otherwise,
+	 * call dump_candidate_tasks() after SIGKILL is sent to OOM victims and
+	 * the OOM reaper started reclaiming.
 	 */
-	if (!list_empty(&oom_candidate_list))
-		return;
 	if (is_memcg_oom(oc))
-		mem_cgroup_scan_tasks(oc->memcg, add_candidate_task, oc);
+		ret = mem_cgroup_scan_tasks(oc->memcg, add_candidate_task, oc);
 	else {
 		rcu_read_lock();
-		for_each_process(p)
-			add_candidate_task(p, oc);
+		for_each_process(p) {
+			ret = add_candidate_task(p, oc);
+			if (ret)
+				break;
+		}
 		rcu_read_unlock();
 	}
-	/*
-	 * Report OOM victim candidates after SIGKILL is sent to OOM victims
-	 * and the OOM reaper started reclaiming.
-	 */
-	if (!list_empty(&oom_candidate_list))
-		queue_work(system_long_wq, &oom_dump_candidates_work);
+	if (ret) {
+		while (!list_empty(&oom_tmp_candidate_list)) {
+			struct oom_task_info *oti =
+				list_first_entry(&oom_tmp_candidate_list,
+						 struct oom_task_info, list);
+
+			list_del_init(&oti->list);
+			put_task_struct(container_of(oti, struct task_struct,
+						     oom_task_info));
+		}
+		return;
+	}
+	list_splice_tail_init(&oom_tmp_candidate_list, &oom_candidate_list);
+	queue_work(system_unbound_wq, &oom_dump_candidates_work);
 }
 
 static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
-- 
1.8.3.1
