Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18182C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 08:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CEA20830
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 08:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfIOIVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 04:21:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfIOIVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 04:21:12 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6883986D29DAF84708BC;
        Sun, 15 Sep 2019 16:21:10 +0800 (CST)
Received: from HGHY2S004443181.china.huawei.com (10.184.52.157) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sun, 15 Sep 2019 16:21:07 +0800
From:   shikemeng <shikemeng@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <valentin.schneider@arm.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH] sched: fix migration to invalid cpu in __set_cpus_allowed_ptr
Date:   Sun, 15 Sep 2019 08:21:02 +0000
Message-ID: <1568535662-14956-1-git-send-email-shikemeng@huawei.com>
X-Mailer: git-send-email 2.7.0.windows.1
In-Reply-To: <979d57f8-802b-57e5-632a-f94ad0f9d6a1@arm.com>
References: <979d57f8-802b-57e5-632a-f94ad0f9d6a1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.52.157]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2019 6:13,shikemeng wrote:
>>> From 089dbf0216628ac6ae98742ab90725ca9c2bf201 Mon Sep 17 00:00:00 2001
>>> From:  <shikemeng@huawei.com>
>>> Date: Tue, 10 Sep 2019 09:44:58 -0400
>>> Subject: [PATCH] sched: fix migration to invalid cpu in 
>>> __set_cpus_allowed_ptr
>>> 
>>> reason: migration to invalid cpu in __set_cpus_allowed_ptr archive 
>>> path: patches/euleros/sched
>>> 
>>
>>The above should probably be trimmed from the log.
>>
>
>Thanks for reminding me. I will remove this part in a new patch.
>
>>> Oops occur when running qemu on arm64:
>>>  Unable to handle kernel paging request at virtual address 
>>> ffff000008effe40  Internal error: Oops: 96000007 [#1] SMP  Process 
>>> migration/0 (pid: 12, stack limit = 0x00000000084e3736)
>>>  pstate: 20000085 (nzCv daIf -PAN -UAO)  pc : 
>>> __ll_sc___cmpxchg_case_acq_4+0x4/0x20
>>>  lr : move_queued_task.isra.21+0x124/0x298
>>>  ...
>>>  Call trace:
>>>   __ll_sc___cmpxchg_case_acq_4+0x4/0x20
>>>   __migrate_task+0xc8/0xe0
>>>   migration_cpu_stop+0x170/0x180
>>>   cpu_stopper_thread+0xec/0x178
>>>   smpboot_thread_fn+0x1ac/0x1e8
>>>   kthread+0x134/0x138
>>>   ret_from_fork+0x10/0x18
>>> 
>>> __set_cpus_allowed_ptr will choose an active dest_cpu in affinity mask 
>>> to migrage the process if process is not currently running on any one 
>>> of the CPUs specified in affinity mask.__set_cpus_allowed_ptr will 
>>> choose an invalid dest_cpu(>= nr_cpu_ids, 1024 in my virtual machine) if CPUS in affinity mask are deactived by cpu_down after cpumask_intersects check.
>>
>>Right, cpumask_any_and() returns >= nr_cpu_ids when there isn't any valid CPU bit set.
>>
>>> Cpumask_test_cpu of dest_cpu afterwards is overflow and may passes if 
>>> corresponding bit is coincidentally set.
>>
>>Ouch. I was going to say the cpu_active_mask check from is_cpu_allowed() should've stopped the whole thing there, but AFAICT there's no safeguard against > nr_cpu_ids bit accesses. I see CONFIG_DEBUG_PER_CPU_MAPS should fire a warning for such accesses, but we don't enable it by default.
>>
>>Would it make sense to do something like
>>
>>	return test_bit(...) && cpu < nr_cpu_ids;
>>
>>for cpumask_test_cpu()? We still get the warn with the right config, but we prevent sneaky mistakes like this one. And it seems it's not the only one according to:
>>
>>--
>>virtual patch
>>virtual report
>>
>>@nocheck@
>>expression E;
>>identifier any_func =~ "^cpumask_any";
>>position pos;
>>@@
>>
>>E@pos = any_func(...);
>>... when != E >= nr_cpu_ids
>>    when != E < nr_cpu_ids
>>
>>@script:python depends on nocheck && report@ p << nocheck.pos; @@ coccilib.report.print_report(p[0], "Missing cpumask_any_*() return value check!")
>>---
>>
>>Some of those seem benign since they are on e.g. cpu_online_mask, some other are somewhat dubious (e.g. deadline.c::dl_task_can_attach()).
>>
>>As a consequence, kernel will access a invalid rq address associate with the invalid cpu in
>
>It's more thoughtful to add check in cpumask_test_cpu.It can solve this problem and can prevent other potential bugs.I will test it and resend
>a new patch.
>

Think again and again. As cpumask_check will fire a warning if cpu >= nr_cpu_ids, it seems that cpumask_check only expects cpu < nr_cpu_ids and it's
caller's responsibility to very cpu is in valid range. Interfaces like cpumask_test_and_set_cpu, cpumask_test_and_clear_cpu and so on are not checking
cpu < nr_cpu_ids either and may cause demage if cpu is out of range.

>>> migration_cpu_stop->__migrate_task->move_queued_task and the Oops occurs. Process as follows may trigger the Oops:
>>> 1) A process repeatedly bind itself to cpu0 and cpu1 in turn by 
>>> calling sched_setaffinity
>>> 2) A shell script repeatedly "echo 0 > 
>>> /sys/devices/system/cpu/cpu1/online" and "echo 1 > 
>>> /sys/devices/system/cpu/cpu1/online" in turn
>>> 3) Oops appears if the invalid cpu is set in memory after tested cpumask.
>>> 
>>> 
>>> Change-Id: I9c2f95aecd3da568991b7408397215f26c990e40
>>
>>- This doesn't respect the 75 char per line limit
>>- Change IDs don't belong here (we're not using Gerrit)
>>- You're missing a Signed-off-by.
>>
>>You'll find all the guidelines you need for formatting patches in Documentation/process/submitting-patches.rst.
>>
>
>Thanks for the guide.I will read it carefully before send next patch.
>
>>> ---
>>>  kernel/sched/core.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c index 
>>> 4b63fef..5181ea9 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -1112,7 +1112,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>>>     if (cpumask_equal(&p->cpus_allowed, new_mask))
>>>         goto out;
>>> 
>>> -   if (!cpumask_intersects(new_mask, cpu_valid_mask)) {
>>> +   dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
>>> +   if (dest_cpu >= nr_cpu_ids) {
>>>         ret = -EINVAL;
>>>         goto out;
>>>     }
>>> @@ -1133,7 +1134,6 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>>>     if (cpumask_test_cpu(task_cpu(p), new_mask))
>>>         goto out;
>>> 
>>> -   dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);>     if (task_running(rq, p) || p->state == TASK_WAKING) {
>>>         struct migration_arg arg = { p, dest_cpu };
>>>         /* Need help from migration thread: drop lock and wait. */
>>> --
>>> 1.8.5.6
>>> 
>
>Thansks for your review and advises.

