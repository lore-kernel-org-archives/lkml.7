Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BDFC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8237621721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfGANz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:55:58 -0400
Received: from foss.arm.com ([217.140.110.172]:35482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbfGANz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:55:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E40F3344;
        Mon,  1 Jul 2019 06:55:56 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 066623F246;
        Mon,  1 Jul 2019 06:55:54 -0700 (PDT)
Date:   Mon, 1 Jul 2019 14:55:52 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, Paul Turner <pjt@google.com>,
        riel@surriel.com, morten.rasmussen@arm.com
Subject: Re: [RESEND PATCH v3 0/7] Improve scheduler scalability for fast path
Message-ID: <20190701135552.kb4os6bxxhh2lyw6@e110439-lin>
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190701090204.GQ3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701090204.GQ3402@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-Jul 11:02, Peter Zijlstra wrote:
> On Wed, Jun 26, 2019 at 06:29:12PM -0700, subhra mazumdar wrote:
> > Hi,
> > 
> > Resending this patchset, will be good to get some feedback. Any suggestions
> > that will make it more acceptable are welcome. We have been shipping this
> > with Unbreakable Enterprise Kernel in Oracle Linux.
> > 
> > Current select_idle_sibling first tries to find a fully idle core using
> > select_idle_core which can potentially search all cores and if it fails it
> > finds any idle cpu using select_idle_cpu. select_idle_cpu can potentially
> > search all cpus in the llc domain. This doesn't scale for large llc domains
> > and will only get worse with more cores in future.
> > 
> > This patch solves the scalability problem by:
> >  - Setting an upper and lower limit of idle cpu search in select_idle_cpu
> >    to keep search time low and constant
> >  - Adding a new sched feature SIS_CORE to disable select_idle_core
> > 
> > Additionally it also introduces a new per-cpu variable next_cpu to track
> > the limit of search so that every time search starts from where it ended.
> > This rotating search window over cpus in LLC domain ensures that idle
> > cpus are eventually found in case of high load.
> 
> Right, so we had a wee conversation about this patch series at OSPM, and
> I don't see any of that reflected here :-(
> 
> Specifically, given that some people _really_ want the whole L3 mask
> scanned to reduce tail latency over raw throughput, while you guys
> prefer the other way around, it was proposed to extend the task model.
> 
> Specifically something like a latency-nice was mentioned (IIRC) where a

Right, AFAIR PaulT suggested to add support for the concept of a task
being "latency tolerant": meaning we can spend more time to search for
a CPU and/or avoid preempting the current task.

> task can give a bias but not specify specific behaviour. This is very
> important since we don't want to be ABI tied to specific behaviour.

I like the idea of biasing, especially considering we are still in the
domain of the FAIR scheduler. If something more mandatory should be
required there are other classes which are likely more appropriate.

> Some of the things we could tie to this would be:
> 
>   - select_idle_siblings; -nice would scan more than +nice,

Just to be sure, you are not proposing to use the nice value we
already have, i.e.
  p->{static,normal}_prio
but instead a new similar concept, right?

Otherwise, pros would be we don't touch userspace, but as a cons we
would have side effects, i.e. bandwidth allocation.
While I think we don't want to mix "specific behaviors" with "biases".

>   - wakeup preemption; when the wakee has a relative smaller
>     latency-nice value than the current running task, it might preempt
>     sooner and the other way around of course.

I think we currently have a single system-wide parameter for that now:

   sched_wakeup_granularity_ns ==> sysctl_sched_min_granularity

which is used in:

   wakeup_gran()                for the wakeup path
   check_preempt_tick()         for the periodic tick

that's where it should be possible to extend the heuristics with some
biasing based on the latency-nice attribute of a task, right?

>   - pack-vs-spread; +nice would pack more with like tasks (since we
>     already spread by default [0] I don't think -nice would affect much
>     here).

That will be very useful for the Android case too.
In Android we used to call it "prefer_idle", but that's probably not
the best name, conceptually similar however.

In Android we would use a latency-nice concept to go for either the
fast (select_idle_siblings) or the slow (energy aware) path.

> Hmmm?

Just one more requirement I think it's worth to consider since the
beginning: CGroups support

That would be very welcome interface. Just because is so much more
convenient (and safe) to set these bias on a group of tasks depending
on their role in the system.

Do you have any idea on how we can expose such a "lantency-nice"
property via CGroups? It's very similar to cpu.shares but it does not
represent a resource which can be partitioned.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
