Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A480C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D0620643
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfCDLku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:40:50 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:64660 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:40:50 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x24Belmv046174;
        Mon, 4 Mar 2019 20:40:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Mon, 04 Mar 2019 20:40:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x24BegDK046097
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 4 Mar 2019 20:40:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1550896930-12324-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190304032202.GD23578@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
Date:   Mon, 4 Mar 2019 20:40:37 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190304032202.GD23578@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/04 12:22, Sergey Senozhatsky wrote:
> On (02/23/19 13:42), Tetsuo Handa wrote:
> [..]
>> This patch tries to address "don't lockup the system" with minimal risk of
>> failing to "print out printk() messages", by allowing printk() callers to
>> tell printk() "store $body_text_lines lines into logbuf but start actual
>> printing after $trailer_text_line line is stored into logbuf". This patch
>> is different from existing printk_deferred(), for printk_deferred() is
>> intended for scheduler/timekeeping use only. Moreover, what this patch
>> wants to do is "do not try to print out printk() messages as soon as
>> possible", for accumulated stalling period cannot be decreased if
>> printk_deferred() from e.g. dump_tasks() from out_of_memory() immediately
>> prints out the messages. The point of this patch is to defer the stalling
>> duration to after leaving the critical section.
> 
> We can export printk deferred, I guess; but I'm not sure if it's going
> to be easy to switch OOM to printk_deferred - there are lots of direct
> printk callers: warn-s, dump_stacks, etc; it might even be simpler to
> start re-directing OOM printouts to printk_safe buffer.

I confirmed that printk_deferred() is not suitable for this purpose, for
it suddenly stalls for seconds at random locations flushing pending output
accumulated by printk_deferred(). Stalling inside critical section (e.g.
RCU read lock held) is what I don't like.

> 
> This is a bit of a strange issue, to be honest. If OOM prints too
> many messages then we might want to do some work on the OOM side.
> 
> But, to begin with, can you give an example of such a lockup? Just
> to understand how big/real the problem is.
> 
> What is that "OOM critical section" which printk can stall?

dump_task() is the OOM critical section from RCU perspective.
We can minimize RCU critical section by just getting a refcount on possible
candidates and then printing information and putting that refcount after
leaving RCU critical section.

----------
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f9b43c9..4781439 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1182,6 +1182,7 @@ struct task_struct {
 #ifdef CONFIG_MMU
 	struct task_struct		*oom_reaper_list;
 #endif
+	struct list_head		oom_candidate_list;
 #ifdef CONFIG_VMAP_STACK
 	struct vm_struct		*stack_vm_area;
 #endif
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 26ea863..6750b18 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -399,6 +399,7 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
 {
 	struct task_struct *p;
 	struct task_struct *task;
+	LIST_HEAD(candidates);
 
 	pr_info("Tasks state (memory values in pages):\n");
 	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
@@ -407,6 +408,11 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
 		if (oom_unkillable_task(p, memcg, nodemask))
 			continue;
 
+		get_task_struct(p);
+		list_add_tail(&p->oom_candidate_list, &candidates);
+	}
+	rcu_read_unlock();
+	list_for_each_entry(p, &candidates, oom_candidate_list) {
 		task = find_lock_task_mm(p);
 		if (!task) {
 			/*
@@ -425,7 +431,8 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
 			task->signal->oom_score_adj, task->comm);
 		task_unlock(task);
 	}
-	rcu_read_unlock();
+	list_for_each_entry_safe(p, task, &candidates, oom_candidate_list)
+		put_task_struct(p);
 }
 
 static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
----------

But almost all out_of_memory() (where oom_lock mutex is held) is the OOM critical
section from memory reclaiming perspective, for we cannot reclaim memory (and
other concurrently allocating threads are needlessly wasting CPU time) unless
SIGKILL is sent after all printk() completed. Therefore, despite out_of_memory()
prints a lot of messages, it is expected to complete quickly as if it is an interrupt
handler. We could disable preemption inside out_of_memory() if all printk() with
oom_lock mutex held is deferrable until oom_lock mutex is released.

> 
> [..]
>> The possibility of failing to store all printk() messages to logbuf might
>> be increased by using "async" printk(). But since we have a lot of RAM
>> nowadays, allocating large logbuf enough to hold the entire SysRq-t output
>> using log_buf_len= kernel command line parameter won't be difficult.
> 
> Note, logbuf size is limited - 2G. Might be not as large as people
> would want it to be.

Are "machines which want to use 2GB logbuf" hosting millions of threads such
that even 2GB is not enough for holding SysRq-t output? If yes, then I guess
that tasklist traversal under RCU read lock would lockup even without printk().

