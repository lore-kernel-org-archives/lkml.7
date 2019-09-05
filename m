Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE37C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706FE21743
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbfIEKLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:11:21 -0400
Received: from foss.arm.com ([217.140.110.172]:41014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfIEKLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:11:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 195181576;
        Thu,  5 Sep 2019 03:11:20 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 632483F718;
        Thu,  5 Sep 2019 03:11:18 -0700 (PDT)
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com> <20190830174944.21741-2-subhra.mazumdar@oracle.com> <11aaa3a8-e6b9-cf1f-08bb-0f8e1b63942b@linux.intel.com> <c09bf5fc-8fc6-dddd-0a18-bd7d5f2136b5@linux.ibm.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        mgorman@techsingularity.net
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
In-reply-to: <c09bf5fc-8fc6-dddd-0a18-bd7d5f2136b5@linux.ibm.com>
Date:   Thu, 05 Sep 2019 11:11:16 +0100
Message-ID: <87o8zz2gu3.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Sep 05, 2019 at 07:15:34 +0100, Parth Shah wrote...

> On 9/4/19 11:02 PM, Tim Chen wrote:
>> On 8/30/19 10:49 AM, subhra mazumdar wrote:
>>> Add Cgroup interface for latency-nice. Each CPU Cgroup adds a new file
>>> "latency-nice" which is shared by all the threads in that Cgroup.
>> 
>> 
>> Subhra,
>> 
>> Thanks for posting the patchset.  Having a latency nice hint
>> is useful beyond idle load balancing.  I can think of other
>> application scenarios, like scheduling batch machine learning AVX 512
>> processes with latency sensitive processes.  AVX512 limits the frequency
>> of the CPU and it is best to avoid latency sensitive task on the
>> same core with AVX512.  So latency nice hint allows the scheduler
>> to have a criteria to determine the latency sensitivity of a task
>> and arrange latency sensitive tasks away from AVX512 tasks.
>> 
>
>
> Hi Tim and Subhra,
>
> This patchset seems to be interesting for my TurboSched patches as well
> where I try to pack jitter tasks on fewer cores to get higher Turbo Frequencies.
> Well, the problem I face is that we sometime end up putting multiple jitter tasks on a core
> running some latency sensitive application which may see performance degradation.
> So my plan was to classify such tasks to be latency sensitive thereby hinting the load
> balancer to not put tasks on such cores.
>
> TurboSched: https://lkml.org/lkml/2019/7/25/296
>
>> You configure the latency hint on a cgroup basis.
>> But I think not all tasks in a cgroup necessarily have the same
>> latency sensitivity.
>> 
>> For example, I can see that cgroup can be applied on a per user basis,
>> and the user could run different tasks that have different latency sensitivity.
>> We may also need a way to configure latency sensitivity on a per task basis instead on
>> a per cgroup basis.
>> 
>
> AFAIU, the problem defined above intersects with my patches as well where the interface
> is required to classify the jitter tasks. I have already tried few methods like
> syscall and cgroup to classify such tasks and maybe something like that can be adopted
> with these patchset as well.

Agree, these two patchest are definitively overlapping in terms of
mechanisms and APIs to expose to userspace. You to guys seems to target
different goals but the general approach should be:

 - expose a single and abstract concept to user-space
   latency-nice or latency-tolerant as PaulT proposed at OSPM

 - map this concept in kernel-space to different kind of bias, both at
   wakeup time and load-balance time, and use both for RT and CFS tasks.

That's my understanding at least ;)

I guess we will have interesting discussions at the upcoming LPC to
figure out a solution fitting all needs.

> Thanks,
> Parth

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
