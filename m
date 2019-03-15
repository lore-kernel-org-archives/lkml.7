Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5B1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0473621872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfCOAnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:43:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727254AbfCOAnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 20:43:21 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 06BCC734732244197B04;
        Fri, 15 Mar 2019 08:43:19 +0800 (CST)
Received: from [127.0.0.1] (10.184.38.59) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Fri, 15 Mar 2019
 08:43:08 +0800
Subject: Re: WARN ON at kernel/sched/deadline.c task_non_contending
To:     luca abeni <luca.abeni@santannapisa.it>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Li Bin <huawei.libin@huawei.com>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>, <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <dfb46874-3657-71c6-e068-9413ffe3f82e@huawei.com>
 <20190313154948.773427d6@luca64>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <0032cd53-05b4-002a-6860-62b51e9e8299@huawei.com>
Date:   Fri, 15 Mar 2019 08:43:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190313154948.773427d6@luca64>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.38.59]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/13 22:49, luca abeni wrote:
> Hi,
>
> After looking at the patch a little bit more and running some tests,
> I suspect this solution might be racy:
> when the timer is already active, (and hrtimer_start() fails), it
> relies on its handler to decrease the running bw (by setting
> dl_non_contending to 1)... But inactive_task_timer() might have
> already checked dl_non_contending, finding it equal to 0 (so, it
> ends up doing nothing and the running bw is not decreased).
>
>
> So, I would prefer a different solution. I think this patch should work:
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 6a73e41a2016..43901fa3f269 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -252,7 +252,6 @@ static void task_non_contending(struct task_struct *p)
>   	if (dl_entity_is_special(dl_se))
>   		return;
>   
> -	WARN_ON(hrtimer_active(&dl_se->inactive_timer));
>   	WARN_ON(dl_se->dl_non_contending);
>   
>   	zerolag_time = dl_se->deadline -
> @@ -269,7 +268,7 @@ static void task_non_contending(struct task_struct *p)
>   	 * If the "0-lag time" already passed, decrease the active
>   	 * utilization now, instead of starting a timer
>   	 */
> -	if (zerolag_time < 0) {
> +	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
>   		if (dl_task(p))
>   			sub_running_bw(dl_se, dl_rq);
>   		if (!dl_task(p) || p->state == TASK_DEAD) {
>
>
> The idea is that if the timer is active, we leave dl_non_contending set to
> 0 (so that the timer handler does nothing), and we immediately decrease the
> running bw.
> I think this is OK, because this situation can happen only if the task
> blocks, wakes up while the timer handler is running, and then immediately
> blocks again - while the timer handler is still running. So, the "zero lag
> time" cannot be too much in the future.
>
>
> 			Thanks,
> 				Luca
>
> .


Yeah, it looks good.

I can do some experiments with it ,

Do you have some testcases to help me with the test ?


Thanks,

     Cheng Jian.




