Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24446C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06AF217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfDYIQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:16:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729013AbfDYIQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:16:40 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5F3C055965E714D60F99;
        Thu, 25 Apr 2019 16:16:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.210) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Apr 2019
 16:16:31 +0800
Subject: Re: [PATCH] sched: fix a potential divide error
To:     Peter Zijlstra <peterz@infradead.org>
References: <20190420083416.170446-1-xiexiuqi@huawei.com>
 <20190423184458.GW4038@hirez.programming.kicks-ass.net>
 <14cdc45e-7a6f-5e1f-e877-10503180ac4e@huawei.com>
 <20190425080016.GX11158@hirez.programming.kicks-ass.net>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <cj.chengjian@huawei.com>
From:   Xie XiuQi <xiexiuqi@huawei.com>
Message-ID: <da2a154a-6a97-4e87-8914-343643824b5b@huawei.com>
Date:   Thu, 25 Apr 2019 16:16:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20190425080016.GX11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.210]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2019/4/25 16:00, Peter Zijlstra wrote:
> On Thu, Apr 25, 2019 at 11:52:28AM +0800, Xie XiuQi wrote:
>> On 2019/4/24 2:44, Peter Zijlstra wrote:
> 
>>> I'll try and come up with a better Changelog tomorrow.
> 
> I actually did, but forgot to send out. I have the below.
> Does that work for you?

It works for me, thank you very much.

> 
> ---
> Subject: sched/numa: Fix a possible divide-by-zero
> From: Xie XiuQi <xiexiuqi@huawei.com>
> Date: Sat, 20 Apr 2019 16:34:16 +0800
> 
> sched_clock_cpu() may not be consistent between CPUs. If a task
> migrates to another CPU, then se.exec_start is set to that CPU's
> rq_clock_task() by update_stats_curr_start(). Specifically, the new
> value might be before the old value due to clock skew.
> 
> So then if in numa_get_avg_runtime() the expression:
> 
>   'now - p->last_task_numa_placement'
> 
> ends up as -1, then the divider '*period + 1' in task_numa_placement()
> is 0 and things go bang. Similar to update_curr(), check if time goes
> backwards to avoid this.
> 
> Cc: mingo@redhat.com
> Cc: cj.chengjian@huawei.com
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> [peterz: simplified changelog]
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20190420083416.170446-1-xiexiuqi@huawei.com
> ---
>  kernel/sched/fair.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2007,6 +2007,10 @@ static u64 numa_get_avg_runtime(struct t
>  	if (p->last_task_numa_placement) {
>  		delta = runtime - p->last_sum_exec_runtime;
>  		*period = now - p->last_task_numa_placement;
> +
> +		/* Avoid backward, and prevent potential divide error */
> +		if (unlikely((s64)*period < 0))
> +			*period = 0;
>  	} else {
>  		delta = p->se.avg.load_sum;
>  		*period = LOAD_AVG_MAX;
> 
> .
> 

-- 
Thanks,
Xie XiuQi

