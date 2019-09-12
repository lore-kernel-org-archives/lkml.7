Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18131C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B47206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfILWKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:10:00 -0400
Received: from foss.arm.com ([217.140.110.172]:37656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbfILWJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:09:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0095728;
        Thu, 12 Sep 2019 15:09:59 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45E213F71F;
        Thu, 12 Sep 2019 15:09:58 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH] sched: fix migration to invalid cpu in
 __set_cpus_allowed_ptr
To:     shikemeng <shikemeng@huawei.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <4a492fe8-09b7-d8ee-8a16-602e592b00b6@huawei.com>
Message-ID: <979d57f8-802b-57e5-632a-f94ad0f9d6a1@arm.com>
Date:   Thu, 12 Sep 2019 23:09:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4a492fe8-09b7-d8ee-8a16-602e592b00b6@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2019 02:55, shikemeng wrote:
> From 089dbf0216628ac6ae98742ab90725ca9c2bf201 Mon Sep 17 00:00:00 2001
> From:  <shikemeng@huawei.com>
> Date: Tue, 10 Sep 2019 09:44:58 -0400
> Subject: [PATCH] sched: fix migration to invalid cpu in __set_cpus_allowed_ptr
> 
> reason: migration to invalid cpu in __set_cpus_allowed_ptr
> archive path: patches/euleros/sched
> 

The above should probably be trimmed from the log.

> Oops occur when running qemu on arm64:
>  Unable to handle kernel paging request at virtual address ffff000008effe40
>  Internal error: Oops: 96000007 [#1] SMP
>  Process migration/0 (pid: 12, stack limit = 0x00000000084e3736)
>  pstate: 20000085 (nzCv daIf -PAN -UAO)
>  pc : __ll_sc___cmpxchg_case_acq_4+0x4/0x20
>  lr : move_queued_task.isra.21+0x124/0x298
>  ...
>  Call trace:
>   __ll_sc___cmpxchg_case_acq_4+0x4/0x20
>   __migrate_task+0xc8/0xe0
>   migration_cpu_stop+0x170/0x180
>   cpu_stopper_thread+0xec/0x178
>   smpboot_thread_fn+0x1ac/0x1e8
>   kthread+0x134/0x138
>   ret_from_fork+0x10/0x18
> 
> __set_cpus_allowed_ptr will choose an active dest_cpu in affinity mask to migrage the process if process is not
> currently running on any one of the CPUs specified in affinity mask.__set_cpus_allowed_ptr will choose an invalid
> dest_cpu(>= nr_cpu_ids, 1024 in my virtual machine) if CPUS in affinity mask are deactived by cpu_down after
> cpumask_intersects check.

Right, cpumask_any_and() returns >= nr_cpu_ids when there isn't any valid CPU
bit set.

> Cpumask_test_cpu of dest_cpu afterwards is overflow and may passes if corresponding bit
> is coincidentally set.

Ouch. I was going to say the cpu_active_mask check from is_cpu_allowed()
should've stopped the whole thing there, but AFAICT there's no safeguard
against > nr_cpu_ids bit accesses. I see CONFIG_DEBUG_PER_CPU_MAPS should
fire a warning for such accesses, but we don't enable it by default.

Would it make sense to do something like

	return test_bit(...) && cpu < nr_cpu_ids;

for cpumask_test_cpu()? We still get the warn with the right config, but we
prevent sneaky mistakes like this one. And it seems it's not the only one
according to:

--
virtual patch
virtual report

@nocheck@
expression E;
identifier any_func =~ "^cpumask_any";
position pos;
@@

E@pos = any_func(...);
... when != E >= nr_cpu_ids
    when != E < nr_cpu_ids

@script:python depends on nocheck && report@
p << nocheck.pos;
@@
coccilib.report.print_report(p[0], "Missing cpumask_any_*() return value check!")
---

Some of those seem benign since they are on e.g. cpu_online_mask, some other
are somewhat dubious (e.g. deadline.c::dl_task_can_attach()).

As a consequence, kernel will access a invalid rq address associate with the invalid cpu in
> migration_cpu_stop->__migrate_task->move_queued_task and the Oops occurs. Process as follows may trigger the Oops:
> 1) A process repeatedly bind itself to cpu0 and cpu1 in turn by calling sched_setaffinity
> 2) A shell script repeatedly "echo 0 > /sys/devices/system/cpu/cpu1/online" and "echo 1 > /sys/devices/system/cpu/cpu1/online" in turn
> 3) Oops appears if the invalid cpu is set in memory after tested cpumask.
> 
> 
> Change-Id: I9c2f95aecd3da568991b7408397215f26c990e40

- This doesn't respect the 75 char per line limit
- Change IDs don't belong here (we're not using Gerrit)
- You're missing a Signed-off-by.

You'll find all the guidelines you need for formatting patches in
Documentation/process/submitting-patches.rst.

> ---
>  kernel/sched/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4b63fef..5181ea9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1112,7 +1112,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>     if (cpumask_equal(&p->cpus_allowed, new_mask))
>         goto out;
> 
> -   if (!cpumask_intersects(new_mask, cpu_valid_mask)) {
> +   dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
> +   if (dest_cpu >= nr_cpu_ids) {
>         ret = -EINVAL;
>         goto out;
>     }
> @@ -1133,7 +1134,6 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>     if (cpumask_test_cpu(task_cpu(p), new_mask))
>         goto out;
> 
> -   dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);>     if (task_running(rq, p) || p->state == TASK_WAKING) {
>         struct migration_arg arg = { p, dest_cpu };
>         /* Need help from migration thread: drop lock and wait. */
> --
> 1.8.5.6
> 
