Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2AEC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D771321897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfH3PoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:44:11 -0400
Received: from foss.arm.com ([217.140.110.172]:34206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfH3PoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:44:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F564344;
        Fri, 30 Aug 2019 08:44:07 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E8833F703;
        Fri, 30 Aug 2019 08:44:06 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] sched/fair: Prevent active LB from preempting
 higher sched classes
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
References: <20190815145107.5318-1-valentin.schneider@arm.com>
 <20190815145107.5318-5-valentin.schneider@arm.com>
 <CAKfTPtCq3fv_ajgwnUUodnd+G_Bx6Jqod3751FnB5AASxZczYg@mail.gmail.com>
 <1ba22164-bcae-3bec-a002-acca4e7c8eae@arm.com>
 <CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <99ff7a6a-6600-64a7-bf40-fe322f48eb4c@arm.com>
Date:   Fri, 30 Aug 2019 16:44:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2019 15:19, Vincent Guittot wrote:
[...]
>> Right, if we end up kicking the cpu_stopper this can still happen (since
>> we drop the lock). Thing is, you can't detect it on the cpu_stopper side,
>> since the currently running is obviously not going to be CFS (and it's
>> too late anyway, we already preempted whatever was running there). Though
>> I should probably change the name of the patch to reflect that it's not a
>> 100% cure.
>>
>> I tweaked the nr_running check of the cpu_stop callback in patch 3/4 to try
>> to bail out early, but AFAICT that's the best we can do without big changes
>> elsewhere.
>>
>> If we wanted to prevent those preemptions at all cost, I suppose we'd want
> 
> I'm not sure that it's worth the effort and the complexity
> 

My point exactly :)

[...]
>> I had this initially but convinced myself out of it: since we hold no
>> lock in need_active_balance(), the information we get on the current task
>> (and, arguably, on the h_nr_running) is too volatile to be of any use.
> 
> But since the lock is released anyway, everything will always be too
> volatile in this case.

We do release the lock if we go kick the cpu_stopper, but can nevertheless
make a decision with the most up to date information. I'd say it's for
similar reasons that we check busiest->curr->cpus_ptr right before
kicking the cpu_stopper rather than in need_active_balance().

The majority of the checks in need_active_balance() (all but one) depend
on env/sd stats which aren't volatile.

>>
>> I do believe those checks have their place in active_load_balance()'s
>> critical section, as that's the most accurate we're going to get. On the
>> plus side, if we *do* detect the remote rq's current task isn't CFS, we
>> can run detach_one_task() locally, which is an improvement IMO.
> 
> This add complexity in the code by adding another path to detach attach task(s).

Note that it's not a new detach/attach per se, rather it's about doing it
in active_load_balance() rather than active_load_balance_cpu_stop() in some
cases.

> We could simply bail out and wait the next load balance (which is
> already the case sometime) or if you really want to detach a task jump
> back to more_balance
> 

A simple bail-out is what I had in v1, but following Qais' comments I
figured I could add the detach_one_tasks().

Jumping back to more_balance is quite different than doing a detach_one_task().
