Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7364BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 05:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4595521848
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 05:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZXA2l76s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="efjS0cR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392339AbfIQFLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 01:11:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391009AbfIQFLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 01:11:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7953D6122D; Tue, 17 Sep 2019 05:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568697104;
        bh=PTpNNr9vCZKBb1PrXQnp9HGdb+U59T2W9Ge1jwsrEts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXA2l76sSyUfiPOQw8BajIYhbYjp7Gr9AotyWHJyxUY32vjq9bP1Hh04NKyfL7AE3
         rPTvzc4XUOW7EppiOajzgnR/sWsPKmpgIkqxwTFC6nauMW8a0eIJvpf5wfengeYpDd
         7pm8tI5kKA4oAoMAV5hJ+cGTX+BRC22HeSLk0/dc=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97B51611BF;
        Tue, 17 Sep 2019 05:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568697103;
        bh=PTpNNr9vCZKBb1PrXQnp9HGdb+U59T2W9Ge1jwsrEts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efjS0cR08PeQa8dpw/eFA+nRVsiDlbQYgYNxS757tcUBmlKk/XrYuhXsb1ZCMl94+
         E+U41Cno9e8MLtvNPu5b8vcbFHkDBYR9+7f9qvqx4xXHuHLFez1Rny3S7Pk9bDxdz+
         IyO1E6qkM49u+mAHycvjJu6hsvtS4xdJsITqCLqA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97B51611BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 17 Sep 2019 10:41:35 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     KeMeng Shi <shikemeng@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: fix migration to invalid cpu in
 __set_cpus_allowed_ptr
Message-ID: <20190917051134.GA23924@codeaurora.org>
References: <1568616808-16808-1-git-send-email-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568616808-16808-1-git-send-email-shikemeng@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 06:53:28AM +0000, KeMeng Shi wrote:
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
> __set_cpus_allowed_ptr will choose an active dest_cpu in affinity mask to
> migrage the process if process is not currently running on any one of the
> CPUs specified in affinity mask. __set_cpus_allowed_ptr will choose an
> invalid dest_cpu (dest_cpu >= nr_cpu_ids, 1024 in my virtual machine) if 
> CPUS in an affinity mask are deactived by cpu_down after cpumask_intersects
> check. cpumask_test_cpu of dest_cpu afterwards is overflow and may pass if
> corresponding bit is coincidentally set. As a consequence, kernel will
> access an invalid rq address associate with the invalid cpu in
> migration_cpu_stop->__migrate_task->move_queued_task and the Oops occurs.
> 
> Process as follows may trigger the Oops:
> 1) A process repeatedly binds itself to cpu0 and cpu1 in turn by calling
> sched_setaffinity.
> 2) A shell script repeatedly "echo 0 > /sys/devices/system/cpu/cpu1/online"
> and "echo 1 > /sys/devices/system/cpu/cpu1/online" in turn.
> 3) Oops appears if the invalid cpu is set in memory after tested cpumask.
> 
> Signed-off-by: KeMeng Shi <shikemeng@huawei.com>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
> Changes in v2:
> -solve format problems in log
> 
>  kernel/sched/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3c7b90bcbe4e..087f4ac30b60 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1656,7 +1656,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  	if (cpumask_equal(p->cpus_ptr, new_mask))
>  		goto out;
>  
> -	if (!cpumask_intersects(new_mask, cpu_valid_mask)) {
> +	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
> +	if (dest_cpu >= nr_cpu_ids) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -1677,7 +1678,6 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  	if (cpumask_test_cpu(task_cpu(p), new_mask))
>  		goto out;
>  
> -	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
>  	if (task_running(rq, p) || p->state == TASK_WAKING) {
>  		struct migration_arg arg = { p, dest_cpu };
>  		/* Need help from migration thread: drop lock and wait. */
> -- 
> 2.19.1
> 
> 

The cpu_active_mask might have changed in between. Your fix looks good to me.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

