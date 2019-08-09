Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1714C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFA42166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436531AbfHIRnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:43:12 -0400
Received: from foss.arm.com ([217.140.110.172]:51304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406730AbfHIRnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:43:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81B7415A2;
        Fri,  9 Aug 2019 10:43:11 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC493F694;
        Fri,  9 Aug 2019 10:43:10 -0700 (PDT)
Subject: Re: [PATCH] sched: use rq_lock/unlock in online_fair_sched_group
To:     Phil Auld <pauld@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20190801133749.11033-1-pauld@redhat.com>
 <20190806130334.GO2349@hirez.programming.kicks-ass.net>
 <20190809133342.GA18727@pauld.bos.csb>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d1997635-0e89-c901-00d4-819d6c2cc33c@arm.com>
Date:   Fri, 9 Aug 2019 18:43:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809133342.GA18727@pauld.bos.csb>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2019 14:33, Phil Auld wrote:
> On Tue, Aug 06, 2019 at 03:03:34PM +0200 Peter Zijlstra wrote:
>> On Thu, Aug 01, 2019 at 09:37:49AM -0400, Phil Auld wrote:
>>> Enabling WARN_DOUBLE_CLOCK in /sys/kernel/debug/sched_features causes
>>
>> ISTR there were more issues; but it sure is good to start picking them
>> off.
>>
> 
> Following up on this I hit another in rt.c which looks like:
> 
> [  156.348854] Call Trace:
> [  156.351301]  <IRQ>
> [  156.353322]  sched_rt_period_timer+0x124/0x350
> [  156.357766]  ? sched_rt_rq_enqueue+0x90/0x90
> [  156.362037]  __hrtimer_run_queues+0xfb/0x270
> [  156.366303]  hrtimer_interrupt+0x122/0x270
> [  156.370403]  smp_apic_timer_interrupt+0x6a/0x140
> [  156.375022]  apic_timer_interrupt+0xf/0x20
> [  156.379119]  </IRQ>
> 
> It looks like the same issue of not using the rq_lock* wrappers and
> hence not using the pinning. From looking at the code there is at 
> least one potential hit in deadline.c in the push_dl_task path with 
> find_lock_later_rq but I have not hit that in practice.
> 
> This commit, which introduced the warning, seems to imply that the use
> of the rq_lock* wrappers is required, at least for any sections that will
> call update_rq_clock:
> 
> commit 26ae58d23b94a075ae724fd18783a3773131cfbc
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Mon Oct 3 16:53:49 2016 +0200
> 
>     sched/core: Add WARNING for multiple update_rq_clock() calls
>     
>     Now that we have no missing calls, add a warning to find multiple
>     calls.
>     
>     By having only a single update_rq_clock() call per rq-lock section,
>     the section appears 'atomic' wrt time.
> 
> 
> Is that the case? Otherwise we have these false positives.
> 

Looks like it - only rq_pin_lock() clears RQCF_UPDATED, so any
update_rq_clock() that isn't preceded by that function will still have
RQCF_UPDATED set the second time it's executed and will trigger the warn.

Seeing as the wrappers boil down to raw_spin_*() when the debug bits are
disabled, I don't see why we wouldn't want to convert these callsites.

> I can spin up patches if so. 
> 
> 
> Thanks,
> Phil
> 
> 
