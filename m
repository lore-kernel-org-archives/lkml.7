Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E528ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 01:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F3420659
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 01:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfJ1BrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 21:47:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727923AbfJ1BrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 21:47:19 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F237CDCA730A6794C051;
        Mon, 28 Oct 2019 09:47:14 +0800 (CST)
Received: from [127.0.0.1] (10.177.224.82) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 28 Oct 2019
 09:47:09 +0800
Subject: Re: [QUESTION] Hung task warning while running syzkaller test
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <patrick.bellasi@arm.com>, <tglx@linutronix.de>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <0d7aa66d-d2b9-775c-56b3-543d132fdb84@huawei.com>
 <1693d19e-56c7-9d6f-8e80-10fe82101cff@arm.com>
 <aa5d0f35-e707-f5e3-251e-f940c0b0232b@huawei.com>
 <4ca01869-7997-cfce-edce-e75337d3a6fa@arm.com>
 <abba880d-cfa6-3485-7831-9998db290396@huawei.com>
Message-ID: <de51e96e-6878-082e-32a9-9e51ce671e3f@huawei.com>
Date:   Mon, 28 Oct 2019 09:47:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <abba880d-cfa6-3485-7831-9998db290396@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.224.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PS: Using strace to track system calls (such as nice,setpriority,sched_setscheduler,sched_setparam,sched_setaffinity, etc.) that may change the task priority during execution, we did not find that the task priority of syzkaller had been changed.


在 2019/10/26 9:48, Zhihao Cheng 写道:
> In fact, I have some preliminary analysis at present. Someone task hold locks for a long time, and other tasks cannot obtain locks, resulting in hung tasks. The lock holding task for a long time finally releases the lock. The lock holding time is long only because the scheduling is not available.
>
> 1. I added time stamp record to mutex lock holding release lock to get some task printing with lock holding time more than 1s:
> ---------- Mutex held timeout ----------
>     [  110.100545] Lock ffff880422b7ad88 held by syz-executor.14[6823] for more than 1 seconds, it has 65 waiters.  // which means task 6823 holds mutex lock for more than 1s
>     [  110.100548] Task 6823 nr_voluntary_switches = 0, nr_involuntary_switches = 2, sum_exec_runtime = 1189949, vruntime = 20793616, state = 0, cpu = 3, runq = 85, cfs_runq = 24, cfs_h_runq = 85, rt_runq = 0, dl_runq = 0.
>     [  110.100550]  ffff8804157f7dd8 0000000000000246 ffffffff823a68c0 ffff88043fcd7d80
>     [  110.100554]  ffff88041867bd80 ffff8804150a8000 ffff8804157f8000 ffff88041e84a620
>     [  110.100557]  ffff880422a0aa20 0000000000000002 0000000000000000 ffff8804157f7df0
>     [  110.100561] Call Trace:
>     [  110.100564]  [<ffffffff81b0a05f>] preempt_schedule_common+0x1f/0x40
>     [  110.100566]  [<ffffffff81b0a09c>] _cond_resched+0x1c/0x30
>     [  110.100569]  [<ffffffff81302811>] dput+0x41/0x4b0
>     [  110.100572]  [<ffffffff812effed>] lookup_real+0x3d/0x60
>     [  110.100575]  [<ffffffff812f0c4d>] __lookup_hash+0x4d/0x90
>     [  110.100579]  [<ffffffff812f7a92>] filename_create+0x92/0x170
>     [  110.100582]  [<ffffffff812f89d1>] SyS_mkdir+0x51/0xe0
>     [  110.100585]  [<ffffffff81b11521>] entry_SYSCALL_64_fastpath+0x1e/0x9a
>     [  110.100587] ---------- ------------------ ----------
>     [  110.100589] [INFO] Waste 0 ms to handle mutex_lock_timeout event, current lock holders = 4
>                 ---------- Mutex held timeout ----------
>     [  111.102488] Lock ffff880422b7ad88 held by syz-executor.14[6823] for more than 2 seconds, it has 70 waiters.
>     [  111.102491] Task 6823 nr_voluntary_switches = 0, nr_involuntary_switches = 2, sum_exec_runtime = 1189949, vruntime= 20793616, state = 0, cpu = 3, runq = 96, cfs_runq = 26, cfs_h_runq = 96, rt_runq = 0, dl_runq = 0.
>     [  111.102495]  ffff8804157f7dd8 0000000000000246 ffffffff823a68c0 ffff88043fcd7d80
>     [  111.102500]  ffff88041867bd80 ffff8804150a8000 ffff8804157f8000 ffff88041e84a620
>     [  111.102503]  ffff880422a0aa20 0000000000000002 0000000000000000 ffff8804157f7df0
>     [  111.102507] Call Trace:
>     [  111.102518]  [<ffffffff81b0a05f>] preempt_schedule_common+0x1f/0x40
>     [  111.102521]  [<ffffffff81b0a09c>] _cond_resched+0x1c/0x30
>     [  111.102528]  [<ffffffff81302811>] dput+0x41/0x4b0
>     [  111.102532]  [<ffffffff812effed>] lookup_real+0x3d/0x60
>     [  111.102535]  [<ffffffff812f0c4d>] __lookup_hash+0x4d/0x90
>     [  111.102539]  [<ffffffff812f7a92>] filename_create+0x92/0x170
>     [  111.102542]  [<ffffffff812f89d1>] SyS_mkdir+0x51/0xe0
>     [  111.102546]  [<ffffffff81b11521>] entry_SYSCALL_64_fastpath+0x1e/0x9a
>     [  111.102548] ---------- ------------------ ----------
>     [  111.102550] [INFO] Waste 0 ms to handle mutex_lock_timeout event, current lock holders = 3
>                 ---------- Mutex held timeout ----------
>     [  112.104602] Lock ffff880422b7ad88 held by syz-executor.14[6823] for more than 3 seconds, it has 71 waiters.
>     [  112.104606] Task 6823 nr_voluntary_switches = 0, nr_involuntary_switches = 2, sum_exec_runtime = 1189949, vruntime = 20793616, state = 0, cpu = 3, runq = 106, cfs_runq = 28, cfs_h_runq = 106, rt_runq = 0, dl_runq = 0.
>
> !!! Notice here !!!
>     /* We found that task 6823 was not scheduled during the lock holding period and has always belonged to CPU 3.
>
>      * nr_voluntary_switches: mutex_owner_task->nvcsw
>
>      * nr_involuntary_switches: mutex_owner_task->nivcsw
>
>      * sum_exec_runtime: mutex_owner_task->se.sum_exec_runtime
>
>      * vruntime: mutex_owner_task->se.vruntime
>
>      * state = 0: mutex_owner_task->state, TASK_RUNNING
>
>      * cpu: task_cpu(mutex_owner_task)
>
>      * runq: task_rq(mutex_owner_task)->nr_running
>
>      * cfs_runq: task_rq(mutex_owner_task)->cfs.nr_running
>
>      * cfs_h_runq:  task_rq(mutex_owner_task)->cfs.h_nr_running
>
>      * rt_runq: task_rq(mutex_owner_task)->rt.rt_nr_running
>
>      * dl_runq: task_rq(mutex_owner_task)->dl.dl_nr_running
>
>     */
>    
>     [  112.104608]  ffff8804157f7dd8 0000000000000246 ffffffff823a68c0 ffff88043fcd7d80
>     [  112.104611]  ffff88041867bd80 ffff8804150a8000 ffff8804157f8000 ffff88041e84a620
>     [  112.104615]  ffff880422a0aa20 0000000000000002 0000000000000000 ffff8804157f7df0
>     [  112.104618] Call Trace:
>     [  112.104621]  [<ffffffff81b0a05f>] preempt_schedule_common+0x1f/0x40
>     [  112.104624]  [<ffffffff81b0a09c>] _cond_resched+0x1c/0x30
>     [  112.104627]  [<ffffffff81302811>] dput+0x41/0x4b0
>     [  112.104630]  [<ffffffff812effed>] lookup_real+0x3d/0x60
>     [  112.104633]  [<ffffffff812f0c4d>] __lookup_hash+0x4d/0x90
>     [  112.104636]  [<ffffffff812f7a92>] filename_create+0x92/0x170
>     [  112.104639]  [<ffffffff812f89d1>] SyS_mkdir+0x51/0xe0
>     [  112.104642]  [<ffffffff81b11521>] entry_SYSCALL_64_fastpath+0x1e/0x9a
>     [  112.104644] ---------- ------------------ ----------
>     [  112.104647] [INFO] Waste 0 ms to handle mutex_lock_timeout event, current lock holders = 7
>
>
> 2. By tracking the scheduling trajectory of cpu3 with trace, we find that CPU 003 is just scheduling tasks continuously, and the priority of these tasks is the same. Many tasks have been scheduled for many times (30-40 times), but lock holding task is not scheduled. See detail in trace_003.log.
>
> 3. You can convert the repro file into a C program by 'syzprog' tool(see syzprog.c). Using compiled syzprog.c directly for testing did not show hung task, which confused me.
>
> ---
>
> New attachments:
> A. 5.3-rc6-hung_task.txt: hung task verbose in 5.3-rc6 (witch lockdep)
> B. trace_003.log: scheduling trajectory of cpu3
> C. syzprog.c: convert the repro file into a C program
>
> 在 2019/10/25 23:29, Valentin Schneider 写道:
>> Picked the wrong outgoing smtp setting, sorry about that lovely disclaimer...
>>
>> On 25/10/2019 13:50, Zhihao Cheng wrote:
>>> I added config in attachment.
>>>
>>> It will take 5-10 minutes to reproduce on the kernel of the lower version(for example, v4.4). And ftrace may need to be enabled for the latest mainline to reproduce hung_task, it will take several hours.
>>>
>> That sounds fun. I'll try to get that running overnight someday I'm not
>> running other stuff, though TBH seeing as the freezer is involved I wonder if
>> it isn't just syzkaller keeping stuff frozen for too long.
>>
>> .

