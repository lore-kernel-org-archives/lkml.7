Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0995DC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7C6206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfIBREU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 13:04:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60318 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfIBREU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:04:20 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i4pkW-0006Pb-Ne; Mon, 02 Sep 2019 11:04:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i4pkV-0006o8-II; Mon, 02 Sep 2019 11:04:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
        <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
        <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
        <20190830160957.GC2634@redhat.com>
        <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
        <87o906wimo.fsf@x220.int.ebiederm.org>
        <20190902134003.GA14770@redhat.com>
Date:   Mon, 02 Sep 2019 12:04:00 -0500
In-Reply-To: <20190902134003.GA14770@redhat.com> (Oleg Nesterov's message of
        "Mon, 2 Sep 2019 15:40:03 +0200")
Message-ID: <87tv9uiq9r.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i4pkV-0006o8-II;;;mid=<87tv9uiq9r.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19qRq1n9oP5NPVuqU9QbhvMTw2zsHSTbjU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference() without checking return value
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 08/30, Eric W. Biederman wrote:
>>
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -182,6 +182,24 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
>>  	put_task_struct(tsk);
>>  }
>>  
>> +void put_dead_task_struct(struct task_struct *task)
>> +{
>> +	bool delay = false;
>> +	unsigned long flags;
>> +
>> +	/* Is the task both reaped and no longer being scheduled? */
>> +	raw_spin_lock_irqsave(&task->pi_lock, flags);
>> +	if ((task->state == TASK_DEAD) &&
>> +	    (cmpxchg(&task->exit_state, EXIT_DEAD, EXIT_RCU) == EXIT_DEAD))
>> +		delay = true;
>> +	raw_spin_lock_irqrestore(&task->pi_lock, flags);
>> +
>> +	/* If both are true use rcu delay the put_task_struct */
>> +	if (delay)
>> +		call_rcu(&task->rcu, delayed_put_task_struct);
>> +	else
>> +		put_task_struct(task);
>> +}
>>  
>>  void release_task(struct task_struct *p)
>>  {
>> @@ -222,76 +240,13 @@ void release_task(struct task_struct *p)
>>  
>>  	write_unlock_irq(&tasklist_lock);
>>  	release_thread(p);
>> -	call_rcu(&p->rcu, delayed_put_task_struct);
>> +	put_dead_task_struct(p);
>
> I had a similar change in mind, see below. This is subjective, but to me
> it looks more simple and clean.
>
> Oleg.
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8dc1811..1f9b021 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1134,7 +1134,10 @@ struct task_struct {
>  
>  	struct tlbflush_unmap_batch	tlb_ubc;
>  
> -	struct rcu_head			rcu;
> +	union {
> +		bool			xxx;
> +		struct rcu_head		rcu;
> +	};
>  
>  	/* Cache last used pipe for splice(): */
>  	struct pipe_inode_info		*splice_pipe;
> diff --git a/kernel/exit.c b/kernel/exit.c
> index a75b6a7..baacfce 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -182,6 +182,11 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
>  	put_task_struct(tsk);
>  }
>  
> +void call_delayed_put_task_struct(struct task_struct *p)
> +{
> +	if (xchg(&p->xxx, 1))
> +		call_rcu(&p->rcu, delayed_put_task_struct);
> +}

I like using the storage we will later use for the rcu_head.

Is the intention your new variable xxx start as 0, and the only
on the second write it becomes 1 and we take action?

That should work but it is a funny way to encode a decrement.  I think
it would be more straight forward to use refcount_dec_and_test.

So something like this:

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9f51932bd543..99a4518b9b17 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1142,7 +1142,10 @@ struct task_struct {
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 
-	struct rcu_head			rcu;
+	union {
+		refcount_t		rcu_users;
+		struct rcu_head		rcu;
+	};
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0497091e40c1..8bd51af44bf8 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -115,7 +115,7 @@ static inline void put_task_struct(struct task_struct *t)
 		__put_task_struct(t);
 }
 
-struct task_struct *task_rcu_dereference(struct task_struct **ptask);
+void put_task_struct_rcu_user(struct task_struct *task);
 
 #ifdef CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT
 extern int arch_task_struct_size __read_mostly;
diff --git a/kernel/exit.c b/kernel/exit.c
index 5b4a5dcce8f8..a42fd8889036 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -182,6 +182,11 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 	put_task_struct(tsk);
 }
 
+void put_task_struct_rcu_user(struct task_struct *task)
+{
+	if (refcount_dec_and_test(&task->rcu_users))
+		call_rcu(&task->rcu, delayed_put_task_struct);
+}
 
 void release_task(struct task_struct *p)
 {
@@ -222,10 +227,10 @@ void release_task(struct task_struct *p)
 
 	write_unlock_irq(&tasklist_lock);
 	release_thread(p);
-	call_rcu(&p->rcu, delayed_put_task_struct);
+	put_task_struct_rcu_user(p);
 
 	p = leader;
 	if (unlikely(zap_leader))
 		goto repeat;
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 2852d0e76ea3..dc4799210e05 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -900,11 +900,15 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (orig->cpus_ptr == &orig->cpus_mask)
 		tsk->cpus_ptr = &tsk->cpus_mask;
 
-	/*
-	 * One for us, one for whoever does the "release_task()" (usually
-	 * parent)
+	/* One for the user space visible state that goes away when
+	 * the processes zombie is reaped.
+	 * One for the reference from the scheduler.
+	 *
+	 * The reference count is ignored and free_task is called
+	 * directly until copy_process completes.
 	 */
-	refcount_set(&tsk->usage, 2);
+	refcount_set(&tsk->rcu_users, 2);
+	refcount_set(&tsk->usage, 1); /* One for the rcu users */
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	tsk->btrace_seq = 0;
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..69015b7c28da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3135,7 +3135,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		/* Task is done with its stack. */
 		put_task_stack(prev);
 
-		put_task_struct(prev);
+		put_task_struct_rcu_user(prev);
 	}
 
 	tick_nohz_task_switch();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 802b1f3405f2..082f8ba2b1f4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -892,7 +892,7 @@ struct rq {
 	 */
 	unsigned long		nr_uninterruptible;
 
-	struct task_struct	*curr;
+	struct task_struct __rcu *curr;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;


Eric
