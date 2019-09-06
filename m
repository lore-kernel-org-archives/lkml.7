Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0467C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F4320842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394071AbfIFONk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:13:40 -0400
Received: from foss.arm.com ([217.140.110.172]:56916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731142AbfIFONj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:13:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5E9328;
        Fri,  6 Sep 2019 07:13:38 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DFCCD3F718;
        Fri,  6 Sep 2019 07:13:36 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
To:     Parth Shah <parth@linux.ibm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <87imq72dpc.fsf@arm.com> <df69627e-8aa0-e2cb-044e-fb392f34efa5@arm.com>
 <87d0ge3n85.fsf@arm.com> <3bb17e15-5492-b78c-20a8-5989519f20e2@linux.ibm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <75e782c7-121d-a0ea-7fbf-efb0c83f50e6@arm.com>
Date:   Fri, 6 Sep 2019 15:13:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3bb17e15-5492-b78c-20a8-5989519f20e2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2019 13:45, Parth Shah wrote:> 
> I guess there is some usecase in case of thermal throttling.
> If a task is heating up the core then in ideal scenarios POWER systems throttle
> down to rated frequency.
> In such case, if the task is latency sensitive (min latency nice), we can move the
> task around the chip to heat up the chip uniformly allowing me to gain more performance
> with sustained higher frequency.
> With this, we will require the help from active load balancer and latency-nice
> classification on per task and/or group basis.
> 
> Hopefully, this might be useful for other arch as well, right?
> 

Most of the functionality is already there, we're only really missing thermal
pressure awareness. There was [1] but it seems to have died.


At least with CFS load balancing, if thermal throttling is correctly
reflected as a CPU capacity reduction you will tend to move things away from
that CPU, since load is balanced over capacities.


For active balance, we actually already have a condition that moves a task
to a less capacity-pressured CPU (although it is somewhat specific). So if
thermal pressure follows that task (e.g. it's doing tons of vector/float),
it will be rotated around.

However there should be a point made on latency vs throughput. If you
care about latency you probably do not want to active balance your task. If
you care about throughput, it should be specified in some way (util-clamp
says hello!).

It sort of feels like you'd want an extension of misfit migration (salesman
hat goes on from here) - misfit moves tasks that are CPU bound (IOW their
util is >= 80% of the CPU capacity) to CPUs of higher capacity. It's only
enabled for systems with asymmetric capacities, but could be enabled globally
for "dynamically-created asymmetric capacities" (IOW RT/IRQ/thermal pressure
on SMP systems).

On top of that, if we make misfit consider e.g. uclamp.min (I don't think
that's already the case), then you have your throughput knob to have *some* 
designated tasks move away from (thermal & else) pressure. 


[1]: https://lore.kernel.org/lkml/1555443521-579-1-git-send-email-thara.gopinath@linaro.org/
