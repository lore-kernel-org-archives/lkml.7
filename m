Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9823C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD5B2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfGBIyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:54:43 -0400
Received: from foss.arm.com ([217.140.110.172]:46198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfGBIym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:54:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDFBC344;
        Tue,  2 Jul 2019 01:54:41 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E55A23F703;
        Tue,  2 Jul 2019 01:54:39 -0700 (PDT)
Date:   Tue, 2 Jul 2019 09:54:37 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, Paul Turner <pjt@google.com>,
        riel@surriel.com, morten.rasmussen@arm.com
Subject: Re: [RESEND PATCH v3 0/7] Improve scheduler scalability for fast path
Message-ID: <20190702085437.gzu7ilubbi5jx6sp@e110439-lin>
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190701090204.GQ3402@hirez.programming.kicks-ass.net>
 <20190701135552.kb4os6bxxhh2lyw6@e110439-lin>
 <81b2288a-579d-8dd1-f179-d672cf1edd68@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81b2288a-579d-8dd1-f179-d672cf1edd68@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-Jul 17:01, Subhra Mazumdar wrote:
> 
> On 7/1/19 6:55 AM, Patrick Bellasi wrote:
> > On 01-Jul 11:02, Peter Zijlstra wrote:
> > > On Wed, Jun 26, 2019 at 06:29:12PM -0700, subhra mazumdar wrote:
> > > > Hi,
> > > > 
> > > > Resending this patchset, will be good to get some feedback. Any suggestions
> > > > that will make it more acceptable are welcome. We have been shipping this
> > > > with Unbreakable Enterprise Kernel in Oracle Linux.
> > > > 
> > > > Current select_idle_sibling first tries to find a fully idle core using
> > > > select_idle_core which can potentially search all cores and if it fails it
> > > > finds any idle cpu using select_idle_cpu. select_idle_cpu can potentially
> > > > search all cpus in the llc domain. This doesn't scale for large llc domains
> > > > and will only get worse with more cores in future.
> > > > 
> > > > This patch solves the scalability problem by:
> > > >   - Setting an upper and lower limit of idle cpu search in select_idle_cpu
> > > >     to keep search time low and constant
> > > >   - Adding a new sched feature SIS_CORE to disable select_idle_core
> > > > 
> > > > Additionally it also introduces a new per-cpu variable next_cpu to track
> > > > the limit of search so that every time search starts from where it ended.
> > > > This rotating search window over cpus in LLC domain ensures that idle
> > > > cpus are eventually found in case of high load.
> > > Right, so we had a wee conversation about this patch series at OSPM, and
> > > I don't see any of that reflected here :-(
> > > 
> > > Specifically, given that some people _really_ want the whole L3 mask
> > > scanned to reduce tail latency over raw throughput, while you guys
> > > prefer the other way around, it was proposed to extend the task model.
> > > 
> > > Specifically something like a latency-nice was mentioned (IIRC) where a
> > Right, AFAIR PaulT suggested to add support for the concept of a task
> > being "latency tolerant": meaning we can spend more time to search for
> > a CPU and/or avoid preempting the current task.
> > 
> Wondering if searching and preempting needs will ever be conflicting?

I guess the winning point is that we don't commit behaviors to
userspace, but just abstract concepts which are turned into biases.

I don't see conflicts right now: if you are latency tolerant that
means you can spend more time to try finding a better CPU (e.g. we can
use the energy model to compare multiple CPUs) _and/or_ give the
current task a better chance to complete by delaying its preemption.

> Otherwise sounds like a good direction to me. For the searching aspect, can
> we map latency nice values to the % of cores we search in select_idle_cpu?
> Thus the search cost can be controlled by latency nice value.

I guess that's worth a try, only caveat I see is that it's turning the
bias into something very platform specific. Meaning, the same
latency-nice value on different machines can have very different
results.

Would not be better to try finding a more platform independent mapping?

Maybe something time bounded, e.g. the higher the latency-nice the more
time we can spend looking for CPUs?

> But the issue is if more latency tolerant workloads set to less
> search, we still need some mechanism to achieve good spread of
> threads.

I don't get this example: why more latency tolerant workloads should
require less search?

> Can we keep the sliding window mechanism in that case?

Which one? Sorry did not went through the patches, can you briefly
resume the idea?

> Also will latency nice do anything for select_idle_core and
> select_idle_smt?

I guess principle the same bias can be used at different levels, maybe
with different mappings.

In the mobile world use-case we will likely use it only to switch from
select_idle_sibling to the energy aware slow path. And perhaps to see
if we can bias the wakeup preemption granularity.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
