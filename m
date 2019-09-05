Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEB5C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ED7206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbfIENH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:07:59 -0400
Received: from foss.arm.com ([217.140.110.172]:44802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfIENH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:07:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27A4728;
        Thu,  5 Sep 2019 06:07:58 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57CE53F67D;
        Thu,  5 Sep 2019 06:07:56 -0700 (PDT)
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com> <20190830174944.21741-2-subhra.mazumdar@oracle.com> <20190905083127.GA2332@hirez.programming.kicks-ass.net> <87r24v2i14.fsf@arm.com> <20190905104616.GD2332@hirez.programming.kicks-ass.net> <87imq72dpc.fsf@arm.com> <df69627e-8aa0-e2cb-044e-fb392f34efa5@arm.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
In-reply-to: <df69627e-8aa0-e2cb-044e-fb392f34efa5@arm.com>
Date:   Thu, 05 Sep 2019 14:07:54 +0100
Message-ID: <87d0ge3n85.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Sep 05, 2019 at 12:46:37 +0100, Valentin Schneider wrote...

> On 05/09/2019 12:18, Patrick Bellasi wrote:
>>> There's a few things wrong there; I really feel that if we call it nice,
>>> it should be like nice. Otherwise we should call it latency-bias and not
>>> have the association with nice to confuse people.
>>>
>>> Secondly; the default should be in the middle of the range. Naturally
>>> this would be a signed range like nice [-(x+1),x] for some x. but if you
>>> want [0,1024], then the default really should be 512, but personally I
>>> like 0 better as a default, in which case we need negative numbers.
>>>
>>> This is important because we want to be able to bias towards less
>>> importance to (tail) latency as well as more importantance to (tail)
>>> latency.
>>>
>>> Specifically, Oracle wants to sacrifice (some) latency for throughput.
>>> Facebook OTOH seems to want to sacrifice (some) throughput for latency.
>> 
>> Right, we have this dualism to deal with and current mainline behaviour
>> is somehow in the middle.
>> 
>> BTW, the FB requirement is the same we have in Android.
>> We want some CFS tasks to have very small latency and a low chance
>> to be preempted by the wake-up of less-important "background" tasks.
>> 
>> I'm not totally against the usage of a signed range, but I'm thinking
>> that since we are introducing a new (non POSIX) concept we can get the
>> chance to make it more human friendly.
>> 
>> Give the two extremes above, would not be much simpler and intuitive to
>> have 0 implementing the FB/Android (no latency) case and 1024 the
>> (max latency) Oracle case?
>> 
>
> For something like latency-<whatever>, I don't see the point of having
> such a wide range. The nice range is probably more than enough - and before
> even bothering about the range, we should probably agree on what the range
> should represent.
>
> If it's niceness, I read it as: positive latency-nice value means we're
> nice to latency, means we reduce it. So the further up you go, the more you
> restrict your wakeup scan. I think it's quite easy to map that into the
> code: current behaviour at 0, with a decreasing scan mask size as we go
> towards +19. I don't think anyone needs 512 steps to tune this.
>
> I don't know what logic we'd follow for negative values though. Maybe
> latency-nice -20 means always going through the slowpath, but what of the
> intermediate values?

Yep, I think so fare we are all converging towards the idea to use the
a signed range. Regarding the range itself, yes: 1024 looks very
oversized, but +-20 is still something which leave room for a bit of
flexibility and it also better matches the idea that we don't want to
"enumerate behaviours" but just expose a knob. To map certain "bias" we
could benefit from a slightly larger range.

> AFAICT this RFC only looks at wakeups, but I guess latency-nice can be

For the wakeup path there is also the TurboSched proposal by Parth:

   Message-ID: <20190725070857.6639-1-parth@linux.ibm.com> 
   https://lore.kernel.org/lkml/20190725070857.6639-1-parth@linux.ibm.com/

we should keep in mind.

> applied elsewhere (e.g. load-balance, something like task_hot() and its
> use of sysctl_sched_migration_cost).

For LB can you come up with some better description of what usages you
see could benefit from a "per task" or "per task-group" latency niceness?

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
