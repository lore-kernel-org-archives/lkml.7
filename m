Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568AFC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C9D2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfIORBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:01:03 -0400
Received: from foss.arm.com ([217.140.110.172]:36466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfIORBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 13:01:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94A5428;
        Sun, 15 Sep 2019 10:01:02 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB5503F575;
        Sun, 15 Sep 2019 10:01:01 -0700 (PDT)
Subject: Re: [PATCH] sched: fix migration to invalid cpu in
 __set_cpus_allowed_ptr
To:     shikemeng <shikemeng@huawei.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <1568516867-11300-1-git-send-email-shikemeng@huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <2e856d95-0fbd-7239-000e-11cd7a1d05eb@arm.com>
Date:   Sun, 15 Sep 2019 18:00:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568516867-11300-1-git-send-email-shikemeng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2019 04:07, shikemeng wrote:
> From: <shikemeng@huawei.com>
> 
> reason: migration to invalid cpu in __set_cpus_allowed_ptr
> archive path: patches/euleros/sched
> 
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
> cpumask_intersects check.Cpumask_test_cpu of dest_cpu afterwards is overflow and may passes if corresponding bit
> is coincidentally set.As a consequence, kernel will access a invalid rq address associate with the invalid cpu in
> migration_cpu_stop->__migrate_task->move_queued_task and the Oops occurs. Process as follows may trigger the Oops:
> 1) A process repeatedly bind itself to cpu0 and cpu1 in turn by calling sched_setaffinity
> 2) A shell script repeatedly "echo 0 > /sys/devices/system/cpu/cpu1/online" and "echo 1 > /sys/devices/system/cpu/cpu1/online" in turn
> 3) Oops appears if the invalid cpu is set in memory after tested cpumask.
> 
> Change-Id: I9c2f95aecd3da568991b7408397215f26c990e40
> Signed-off-by: <shikemeng@huawei.com>

The log still isn't wrapped to 75 chars, and the change-id still hasn't been
removed.

The subject should also mention that this is v2 of the patch, again this is
all in the process documentation.

The fix itself looks fine though, so once the log respects the rules:
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
