Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DB0C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049BF20825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbfIEJpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:45:35 -0400
Received: from foss.arm.com ([217.140.110.172]:40542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731806AbfIEJpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:45:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E17121576;
        Thu,  5 Sep 2019 02:45:34 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38E7B3F67D;
        Thu,  5 Sep 2019 02:45:33 -0700 (PDT)
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com> <20190830174944.21741-2-subhra.mazumdar@oracle.com> <20190905083127.GA2332@hirez.programming.kicks-ass.net>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
In-reply-to: <20190905083127.GA2332@hirez.programming.kicks-ass.net>
Date:   Thu, 05 Sep 2019 10:45:27 +0100
Message-ID: <87r24v2i14.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Sep 05, 2019 at 09:31:27 +0100, Peter Zijlstra wrote...

> On Fri, Aug 30, 2019 at 10:49:36AM -0700, subhra mazumdar wrote:
>> Add Cgroup interface for latency-nice. Each CPU Cgroup adds a new file
>> "latency-nice" which is shared by all the threads in that Cgroup.
>
> *sigh*, no. We start with a normal per task attribute, and then later,
> if it is needed and makes sense, we add it to cgroups.

FWIW, to add on top of what Peter says, we used this same approach for
uclamp and it proved to be a very effective way to come up with a good
design. General principles have been:

 - a system wide API [1] (under /proc/sys/kernel/sched_*) defines
   default values for all tasks affected by that feature.
   This interface has to define also upper bounds for task specific
   values. Thus, in the case of latency-nice, it should be set by
   default to the MIN value, since that's the current mainline
   behaviour: all tasks are latency sensitive.

 - a per-task API [2] (via the sched_setattr() syscall) can be used to
   relax the system wide setting thus implementing a "nice" policy.

 - a per-taskgroup API [3] (via cpu controller's attributes) can be used
   to relax the system-wide settings and restrict the per-task API.

The above features are worth to be added in that exact order.

> Also, your Changelog fails on pretty much every point. It doesn't
> explain why, it doesn't describe anything and so on.

On the description side, I guess it's worth to mention somewhere to
which scheduling classes this feature can be useful for. It's worth to
mention that it can apply only to:

 - CFS tasks: for example, at wakeup time a task with an high
   latency-nice should avoid to preempt a low latency-nice task.
   Maybe by mapping the latency nice value into proper vruntime
   normalization value?

 - RT tasks: for example, at wakeup time a task with an high
   latency-nice value could avoid to preempt a CFS task.

I'm sure there will be discussion about some of these features, that's
why it's important in the proposal presentation to keep a well defined
distinction among the "mechanisms and API" and how we use the new
concept to "bias" some scheduler policies.

> From just reading the above, I would expect it to have the range
> [-20,19] just like normal nice. Apparently this is not so.

Regarding the range for the latency-nice values, I guess we have two
options:

  - [-20..19], which makes it similar to priorities
  downside: we quite likely end up with a kernel space representation
  which does not match the user-space one, e.g. look at
  task_struct::prio.

  - [0..1024], which makes it more similar to a "percentage"

Being latency-nice a new concept, we are not constrained by POSIX and
IMHO the [0..1024] scale is a better fit.

That will translate into:

  latency-nice=0 : default (current mainline) behaviour, all "biasing"
  policies are disabled and we wakeup up as fast as possible

  latency-nice=1024 : maximum niceness, where for example we can imaging
  to turn switch a CFS task to be SCHED_IDLE?

Best,
Patrick

[1] commit e8f14172c6b1 ("sched/uclamp: Add system default clamps")
[2] commit a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
[3] 5 patches in today's tip/sched/core up to:
    commit babbe170e053 ("sched/uclamp: Update CPU's refcount on TG's clamp changes")

-- 
#include <best/regards.h>

Patrick Bellasi
