Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1268C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43272206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390072AbfIEOtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:49:01 -0400
Received: from foss.arm.com ([217.140.110.172]:46386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389853AbfIEOtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:49:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C718D28;
        Thu,  5 Sep 2019 07:48:59 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EDE93F67D;
        Thu,  5 Sep 2019 07:48:58 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <87imq72dpc.fsf@arm.com> <df69627e-8aa0-e2cb-044e-fb392f34efa5@arm.com>
 <87d0ge3n85.fsf@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <3d3306e4-3a78-5322-df69-7665cf01cc43@arm.com>
Date:   Thu, 5 Sep 2019 15:48:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87d0ge3n85.fsf@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2019 14:07, Patrick Bellasi wrote:
> Yep, I think so fare we are all converging towards the idea to use the
> a signed range. Regarding the range itself, yes: 1024 looks very
> oversized, but +-20 is still something which leave room for a bit of
> flexibility and it also better matches the idea that we don't want to
> "enumerate behaviours" but just expose a knob. To map certain "bias" we
> could benefit from a slightly larger range.
> 
>> AFAICT this RFC only looks at wakeups, but I guess latency-nice can be
> 
> For the wakeup path there is also the TurboSched proposal by Parth:
> 
>    Message-ID: <20190725070857.6639-1-parth@linux.ibm.com> 
>    https://lore.kernel.org/lkml/20190725070857.6639-1-parth@linux.ibm.com/
> 
> we should keep in mind.
> 
>> applied elsewhere (e.g. load-balance, something like task_hot() and its
>> use of sysctl_sched_migration_cost).
> 
> For LB can you come up with some better description of what usages you
> see could benefit from a "per task" or "per task-group" latency niceness?
> 

task_hot() "ratelimits" migrations of tasks that were running up until
very recently (hence "cache hot"), but the knob is system wide. It might
make sense to exploit a per-task attribute to tune this (e.g. go wild if
not latency sensitive, otherwise stay away for longer).

We could perhaps even apply it to active load balance to similarly stay
away from latency sensitive tasks. Right now this is gated by a
sched_domain-wide attribute (nr_balance_failed). We could tweak this to
requiring more (less) failed attempts before interrupting latency (in)
sensitive tasks.

I'm sure we can come up with even more creative ways to pour even more
heuristics in there ;)

> Best,
> Patrick
> 
