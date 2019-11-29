Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03370C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68282086A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfK2Ghk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:37:40 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42853 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfK2Ghj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:37:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xiejingfeng@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TjMhZfY_1575009453;
Received: from 30.18.122.9(mailfrom:xiejingfeng@linux.alibaba.com fp:SMTPD_---0TjMhZfY_1575009453)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Nov 2019 14:37:34 +0800
User-Agent: Microsoft-MacOutlook/10.1f.0.191110
Date:   Fri, 29 Nov 2019 14:37:57 +0800
Subject: Re: [PATCH] psi:fix divide by zero in psi_update_stats
From:   Jingfeng Xie <xiejingfeng@linux.alibaba.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        "=?UTF-8?B?6b2Q5rGf?=(=?UTF-8?B?56qF6buY?=)" 
        <qijiang.qj@alibaba-inc.com>
Message-ID: <D25F9D3F-AA65-4BC1-B2CE-EECD2F49AE03@linux.alibaba.com>
Thread-Topic: [PATCH] psi:fix divide by zero in psi_update_stats
References: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com> <20191112154144.GC168812@cmpxchg.org> <20191112154844.GD168812@cmpxchg.org> <20191112160821.GE168812@cmpxchg.org>
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Weiner,
The crash does not happen right after boot, in my case,  it happens in 58914 ~ 815463 seconds range since boot 

With my coredump，some values are extracted as below：

period = 001df2dc00000000
now = 001df2dc00000000， same as period
expires = group->next_update = rdi = 00003594f700648e
group->avg_last_update  could not be known
missed_periods = 0

﻿在 2019/11/13 上午12:08，“Johannes Weiner”<hannes@cmpxchg.org> 写入:

    On Tue, Nov 12, 2019 at 10:48:46AM -0500, Johannes Weiner wrote:
    > On Tue, Nov 12, 2019 at 10:41:46AM -0500, Johannes Weiner wrote:
    > > On Fri, Nov 08, 2019 at 03:33:24PM +0800, tim wrote:
    > > > In psi_update_stats, it is possible that period has value like
    > > > 0xXXXXXXXX00000000 where the lower 32 bit is 0, then it calls div_u64 which
    > > > truncates u64 period to u32, results in zero divisor.
    > > > Use div64_u64() instead of div_u64()  if the divisor is u64 to avoid
    > > > truncation to 32-bit on 64-bit platforms.
    > > > 
    > > > Signed-off-by: xiejingfeng <xiejingfeng@linux.alibaba.com>
    > > 
    > > This is legit. When we stop the periodic averaging worker due to an
    > > idle CPU, the period after restart can be much longer than the ~4 sec
    > > in the lower 32 bits. See the missed_periods logic in update_averages.
    > 
    > Argh, that's not right. Of course I notice right after hitting send.
    > 
    > missed_periods are subtracted out of the difference between now and
    > the last update, so period should be not much bigger than 2s.
    > 
    > Something else is going on here.
    
    Tim, does this happen right after boot? I wonder if it's because we're
    not initializing avg_last_update, and the initial delta between the
    last update (0) and the first scheduled update (sched_clock() + 2s)
    ends up bigger than 4 seconds somehow. Later on, the delta between the
    last and the scheduled update should always be ~2s. But for that to
    happen, it would require a pretty slow boot, or a sched_clock() that
    does not start at 0.
    
    Tim, if you have a coredump, can you extract the value of the other
    variables printed in the following patch?
    
    diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
    index 84af7aa158bf..1b6836d23091 100644
    --- a/kernel/sched/psi.c
    +++ b/kernel/sched/psi.c
    @@ -374,6 +374,10 @@ static u64 update_averages(struct psi_group *group, u64 now)
     	 */
     	avg_next_update = expires + ((1 + missed_periods) * psi_period);
     	period = now - (group->avg_last_update + (missed_periods * psi_period));
    +
    +	WARN(period >> 32, "period=%ld now=%ld expires=%ld last=%ld missed=%ld\n",
    +	     period, now, expires, group->avg_last_update, missed_periods);
    +
     	group->avg_last_update = now;
     
     	for (s = 0; s < NR_PSI_STATES - 1; s++) {
    
    And we may need something like this to make the tick initialization
    more robust regardless of the reported bug here:
    
    diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
    index 84af7aa158bf..ce8f6748678a 100644
    --- a/kernel/sched/psi.c
    +++ b/kernel/sched/psi.c
    @@ -185,7 +185,8 @@ static void group_init(struct psi_group *group)
     
     	for_each_possible_cpu(cpu)
     		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
    -	group->avg_next_update = sched_clock() + psi_period;
    +	group->avg_last_update = sched_clock();
    +	group->avg_next_update = group->avg_last_update + psi_period;
     	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
     	mutex_init(&group->avgs_lock);
     	/* Init trigger-related members */
    



