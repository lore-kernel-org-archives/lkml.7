Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87BEC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7EC206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556215202;
	bh=RhrMziu6J5/OR7cQcGtJ0diftY7ZQyEqX2d/TK2pdDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2YaI5dCk8+CENN+1HX+nhYOAefuJThMK99+Dgj7T19t681PsTolCLf85o0+D9nkzW
	 Qd3uQeYWDMDVvH4xyKZMvlI7WVC5r5f57+tRSNCHxxhPbOH60TuWQFqlp6XI89lb8l
	 y29aV8Ta+6x4urrrTtGPZp7xZSaF+FUHoFk9TKdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfDYSAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:00:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38617 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfDYR77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:59:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so463084wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9eUz2mne6lABS+PQvvgkGSoseKHzMaugjxFz/U5X7So=;
        b=FEJJS2Cv14lKKbqMYS+2R6lQR/cPm6i8bKF08WKnIgwqqXOCwCnpmUBLbD3m9xqkDr
         QV64fFu/eEVKDhmu43ob4V7FVL6fuGnSa1cMAsJTVoKChh1J3J6soYHTlCmybGVWvdlH
         U8QkTcfRwHSu414S/86i0+WMmYF5WVP4wuuPPXJMmtkDQ90MsB9wR50aFVqlNHO0zEdc
         38k16iWtSOIMUNDz5clocQzibQ5brlpf+PRStQMJ40yVT8Di/yH0GwYWSQ7PjuDp2xGb
         YYwkxgEpjcDGb7orSQcLV+92DWE5Sush6NNq6gKYfVaibtIzewcVJ1wtqJB7DSCp9JyS
         PwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9eUz2mne6lABS+PQvvgkGSoseKHzMaugjxFz/U5X7So=;
        b=JRtI7iQ4RWFJBS4wF2R62eqJqDdVgo5wZUUPkChji/0iiL/j0zw3VKrXm9lfXQO+Mu
         yLxZwGe2DhDMksmWx7EkTYPteXtu9ipjW0Y1o4O+6MrxILWdqKPicolP5MgETMmYKbOV
         OIVPaMRZgWE++Z1qvTa+JGqim+08wplhkrCyJbKyjmHGI58nLkPZkRhpgkI6LRd2idvp
         qbsEeKuPY0qVDvKtJUbgXToL6UBd8xopAiOon9yUJeMkIk+/fQQF+KEOBOYDka92N5dx
         hV2Ur4NN3CUIWg1JFjiiL7xPKykMDPweYK/RL7BAGbStzp7SIiq2agvpV5GG1pvD+qf2
         zmsw==
X-Gm-Message-State: APjAAAX8Rfq7wdZczW5MtrCsymGtEn8WAMRU9B+rxrKT1A4TAU3FQTE2
        dvXjP9YxRJfwbcR8rWMj+Ss=
X-Google-Smtp-Source: APXvYqzfr2QSZW0Of3zhNMwKKR0HVlNtD5cB03et6zy2sre2hP9A80qeoWQR6Y1Js4DdnCfzR70MyQ==
X-Received: by 2002:a1c:4e14:: with SMTP id g20mr3144wmh.88.1556215197230;
        Thu, 25 Apr 2019 10:59:57 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n6sm27954466wmn.48.2019.04.25.10.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 10:59:56 -0700 (PDT)
Date:   Thu, 25 Apr 2019 19:59:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Xie XiuQi <xiexiuqi@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, cj.chengjian@huawei.com
Subject: Re: [PATCH] sched: fix a potential divide error
Message-ID: <20190425175953.GA21524@gmail.com>
References: <20190420083416.170446-1-xiexiuqi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420083416.170446-1-xiexiuqi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Xie XiuQi <xiexiuqi@huawei.com> wrote:

> We meet a divide error on 3.10.0 kernel, the error message is bellow:
> 
> [499992.287996] divide error: 0000 [#1] SMP
> [499992.297796] do nothing after die!
> [499992.299108] Modules linked in: signo_catch macvlan binfmt_misc
> ip_set_hash_netport ip_set_hash_ipport vport_vxlan ipt_REJECT
> xt_statistic xt_physdev xt_nat xt_recent xt_mark xt_comment ...
> [499992.312751] CPU: 8 PID: 23352 Comm: bash Tainted: G ----V-------   3.10.0+ #1
> [499992.314308] Hardware name: OpenStack Foundation OpenStack Nova, BIOS
> rel-1.9.1-0-gb3ef39f-20170329_185309-build9a64a246a231 04/01/2014
> [499992.317411] task: ffff880033fc9700 ti: ffff8807fed60000 task.ti:ffff8807fed60000
> [499992.318967] RIP: 0010:[<ffffffff810c15c2>]  [<ffffffff810c15c2>] task_numa_fault+0x1c2/0xbb0
> [499992.320515] RSP: 0000:ffff8807fed63d38  EFLAGS: 00010246
> [499992.322018] RAX: 0000002b7efd0000 RBX: ffff880033fc9700 RCX:0000000000000003
> [499992.323563] RDX: 0000000000000000 RSI: 0000000000000400 RDI:ffffffff81a80f60
> [499992.325052] RBP: ffff8807fed63db8 R08: ffffffff81a80f68 R09:0000000000000000
> [499992.326531] R10: ffff88083ffda000 R11: 0000000000000000 R12:0000000000000424
> [499992.327987] R13: 00000000002b7efd R14: 0000000000000000 R15:ffffea001ea42a00
> [499992.329420] FS:  00007fa01a3b7740(0000) GS:ffff88103ec00000(0000)knlGS:0000000000000000
> [499992.330866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [499992.332302] CR2: 0000000000ff1fb0 CR3: 00000007ff1d1000 CR4:00000000003407e0
> [499992.333763] DR0: 0000000000000000 DR1: 0000000000000000 DR2:0000000000000000
> [499992.335187] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:0000000000000400
> [499992.336595] Stack:
> [499992.337974]  0000000000000000 00000001bc9598a8 ffffea001ea42a00 0000000100000001
> [499992.339374]  0000000300000001 0000000000000001 ffffea001ea42a00 ffff8807fed63db8
> [499992.340768]  0000000000000000 0000000000000000 00000000bc9598a8 0000000000000001
> [499992.342148] Call Trace:
> [499992.343494]  [<ffffffff8119ab62>] do_numa_page+0x162/0x1f0
> [499992.344831]  [<ffffffff8119bde7>] handle_mm_fault+0x627/0xf50
> [499992.346145]  [<ffffffff8164e486>] __do_page_fault+0x166/0x470
> [499992.347442]  [<ffffffff8164e853>] trace_do_page_fault+0x43/0x110
> [499992.348711]  [<ffffffff8164df29>] do_async_page_fault+0x29/0xe0
> [499992.349948]  [<ffffffff8164a9f8>] async_page_fault+0x28/0x30
> [499992.351149] Code: 00 3d 00 04 00 00 44 0f 4e d8 41 81 fb 00 04 00 00
> 0f 84 67 07 00 00 4c 89 e8 49 83 c6 01 31 d2 48 c1 e0 10 49 83 c4 01 45
> 31 c9 <49> f7 f6 48 c7 45 a8 00 00 00 00 48 c7 45 b0 00 00 00 00 49 89
> [499992.353707] RIP  [<ffffffff810c15c2>] task_numa_fault+0x1c2/0xbb0
> [499992.354927]  RSP <ffff8807fed63d38>
> [499992.358114] ---[ end trace 4f2465cac18ff65e ]---
> [499992.359304] Kernel panic - not syncing: Fatal exception
> 
> sched_clock_cpu may not be consistent bwtwen cpus. If a task migrate
> to another cpu, the se.exec_start was set to that cpu's rq_clock_task
> by update_stats_curr_start(). Which may not be monotonic.
> 
> update_stats_curr_start
>   <- set_next_entity
>      <- set_curr_task_fair
>         <- sched_move_task
> 
> So, if  now - p->last_task_numa_placement is -1, then (*period + 1) is
> 0, and divide error was triggerred at the div operation:
>   task_numa_placement:
>     runtime = numa_get_avg_runtime(p, &period);
>     f_weight = div64_u64(runtime << 16, period + 1);  // divide error here
> 
> In this patch, we make sure period is not less than 0 to avoid this
> divide error.
> 
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> Cc: stable@vger.kernel.org
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 40bd1e27b1b7..f2abb258fc85 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2007,6 +2007,10 @@ static u64 numa_get_avg_runtime(struct task_struct *p, u64 *period)
>  	if (p->last_task_numa_placement) {
>  		delta = runtime - p->last_sum_exec_runtime;
>  		*period = now - p->last_task_numa_placement;
> +
> +		/* Avoid backward, and prevent potential divide error */
> +		if ((s64)*period < 0)
> +			*period = 0;
>  	} else {
>  		delta = p->se.avg.load_sum;
>  		*period = LOAD_AVG_MAX;

I've put this into sched/urgent, because this can be triggered in the 
wild it appears.

Thanks,

	Ingo
