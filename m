Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3331C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902B92146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLTPc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:32:59 -0500
Received: from foss.arm.com ([217.140.110.172]:52436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfLTPc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:32:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F9F330E;
        Fri, 20 Dec 2019 07:32:58 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC4F63F6CF;
        Fri, 20 Dec 2019 07:32:56 -0800 (PST)
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20191220084252.GL3178@techsingularity.net>
 <d44ae0ff-3bd7-fab1-66d0-71769c078918@arm.com>
 <20191220142239.GM3178@techsingularity.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <726b8216-6334-585e-3996-175e9a51df36@arm.com>
Date:   Fri, 20 Dec 2019 15:32:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220142239.GM3178@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2019 14:22, Mel Gorman wrote:
>> Now, I have to say I'm not sold on the idle_cpus thing, I'd much rather use
>> the number of runnable tasks. We are setting up a threshold for how far we
>> are willing to ignore imbalances; if we have overloaded CPUs we *really*
>> should try to solve this. Number of tasks is the safer option IMO: when we
>> do have one task per CPU, it'll be the same as if we had used idle_cpus, and
>> when we don't have one task per CPU we'll load-balance more often that we
>> would have with idle_cpus.
>>
> 
> I couldn't convince myself to really push back hard on the sum_nr_runnable
> versus idle_cpus.  If the local group has spare capacity and the busiest
> group has multiple tasks stacked on CPUs then it's most likely due to
> CPU affinity.

Not necessarily, for instance wakeup balancing (select_idle_sibling()) could
end up packing stuff within a node if said node spans more than one LLC
domain, which IIRC is the case on some AMD chips.

Or, still with the same LLC < node topology, you could start with the node
being completely utilized, then some tasks on some LLC domains terminate but
there's an LLC that still has a bunch of tasks running, and then you're left
with an imbalance between LLC domains that the wakeup balance cannot solve.

> In that case, there is no guarantee tasks can move to the
> local group either. In that case, the difference between sum_nr_running
> and idle_cpus is almost moot.  There may be common use cases where the
> distinction really matters but right now, I'm at the point where I think
> such a change could be a separate patch with the use case included and
> supporting data on why it must be sum_nr_running.  Right now, I feel it's
> mostly a cosmetic issue given the context and intent of the patch.
> 

Let me spin it this way: do we need to push this ignoring of the imbalance
as far as possible, or are we okay with it only happening when there's just a
few tasks running? The latter is achieved with sum_nr_running and is the
safer option IMO.
