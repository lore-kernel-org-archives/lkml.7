Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCAAC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5864A20715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLWQkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 11:40:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLWQkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:40:35 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1E17206CB;
        Mon, 23 Dec 2019 16:40:32 +0000 (UTC)
Date:   Mon, 23 Dec 2019 11:40:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     chenying <chen.ying153@zte.com.cn>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn
Subject: Re: [PATCH] fix share rt runtime with offline rq
Message-ID: <20191223114030.1800b4c1@gandalf.local.home>
In-Reply-To: <1576894812-36688-1-git-send-email-chen.ying153@zte.com.cn>
References: <1576894812-36688-1-git-send-email-chen.ying153@zte.com.cn>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Dec 2019 10:20:12 +0800
chenying <chen.ying153@zte.com.cn> wrote:

> In my environment,cpu0-11 are online, cpu12-15 are offline, CPU2 is isolated,
> sched_rt_runtime_us is 950000,and then bind a rt process with dead loop to CPU2.
> We can see that CPU usage on CPU2 reaches 100%,but only one cpu is isolated,
> so it can be inferred that CPU2 shares the rt runtime of offline cpu.
> 
> / # cat /sys/devices/system/cpu/online
> 0-11
> / # cat /sys/devices/system/cpu/offline
> 12-15
> / # cat /sys/devices/system/cpu/isolated
> 2
> / # cat /proc/sys/kernel/sched_rt_runtime_us
> 950000
> / # chrt -p 357
> pid 357's current scheduling policy: SCHED_FIFO
> pid 357's current scheduling priority: 1

I'm guessing that you took the cpus offline via the kernel command line
parameter. Because when I tried this with just:

 # echo 0 > /sys/devices/system/cpu/cpu${cpu}/online

I could not reproduce it. But when I booted with maxcpus=X set, I could.


> 
> top - 15:52:12 up 4 min,  0 users,  load average: 0.92, 0.41, 0.16
> Tasks: 201 total,   2 running, 199 sleeping,   0 stopped,   0 zombie
> %Cpu0  :  0.3 us,  0.3 sy,  0.0 ni, 99.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu1  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu2  :100.0 us,  0.0 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu3  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu4  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu5  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu6  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu7  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu8  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu9  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> %Cpu10 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> 
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
>   357 root      -2   0    4044    172    136 R 100.0  0.0   2:32.99 deadloop
>   366 root      20   0   22060   2404   2128 R   0.7  0.0   0:00.06 top
>     1 root      20   0    2624     20      0 S   0.0  0.0   0:05.93 init
>     2 root      20   0       0      0      0 S   0.0  0.0   0:00.00 kthreadd
>     3 root      20   0       0      0      0 S   0.0  0.0   0:00.00 ksoftirqd/0
>     4 root      20   0       0      0      0 S   0.0  0.0   0:00.00 kworker/0:0
> 
> Signed-off-by: chenying <chen.ying153@zte.com.cn>
> ---
>  kernel/sched/rt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index a532558..d20dc86 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -648,8 +648,12 @@ static void do_balance_runtime(struct rt_rq *rt_rq)
>  	rt_period = ktime_to_ns(rt_b->rt_period);
>  	for_each_cpu(i, rd->span) {
>  		struct rt_rq *iter = sched_rt_period_rt_rq(rt_b, i);
> +		struct rq *rq = rq_of_rt_rq(iter);
>  		s64 diff;
>  
> +		if (!rq->online)
> +			continue;
> +

I think this might be papering over the real issue. Perhaps
rq_offline_rt() needs to be called for CPUs not being brought online?

-- Steve


>  		if (iter == rt_rq)
>  			continue;
>  

