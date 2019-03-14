Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91520C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFB52075C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfCNOqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:46:07 -0400
Received: from foss.arm.com ([217.140.101.70]:45836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfCNOqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:46:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C56EA78;
        Thu, 14 Mar 2019 07:46:06 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 575AB3F59C;
        Thu, 14 Mar 2019 07:46:03 -0700 (PDT)
Date:   Thu, 14 Mar 2019 14:46:00 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190314144600.2ulpeipad7jbxyiy@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <CAJuCfpGAZ6XxJj=e-wVzGx3zmRRLPs=wXm8K0BcjWOm5hM0FcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGAZ6XxJj=e-wVzGx3zmRRLPs=wXm8K0BcjWOm5hM0FcQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Mar 14:32, Suren Baghdasaryan wrote:
> On Fri, Feb 8, 2019 at 2:06 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >
> > Utilization clamping allows to clamp the CPU's utilization within a
> > [util_min, util_max] range, depending on the set of RUNNABLE tasks on
> > that CPU. Each task references two "clamp buckets" defining its minimum
> > and maximum (util_{min,max}) utilization "clamp values". A CPU's clamp
> > bucket is active if there is at least one RUNNABLE tasks enqueued on
> > that CPU and refcounting that bucket.
> >
> > When a task is {en,de}queued {on,from} a rq, the set of active clamp
> > buckets on that CPU can change. Since each clamp bucket enforces a
> > different utilization clamp value, when the set of active clamp buckets
> > changes, a new "aggregated" clamp value is computed for that CPU.
> >
> > Clamp values are always MAX aggregated for both util_min and util_max.
> > This ensures that no tasks can affect the performance of other
> > co-scheduled tasks which are more boosted (i.e. with higher util_min
> > clamp) or less capped (i.e. with higher util_max clamp).
> >
> > Each task has a:
> >    task_struct::uclamp[clamp_id]::bucket_id
> > to track the "bucket index" of the CPU's clamp bucket it refcounts while
> > enqueued, for each clamp index (clamp_id).
> >
> > Each CPU's rq has a:
> >    rq::uclamp[clamp_id]::bucket[bucket_id].tasks
> > to track how many tasks, currently RUNNABLE on that CPU, refcount each
> > clamp bucket (bucket_id) of a clamp index (clamp_id).
> >
> > Each CPU's rq has also a:
> >    rq::uclamp[clamp_id]::bucket[bucket_id].value
> > to track the clamp value of each clamp bucket (bucket_id) of a clamp
> > index (clamp_id).
> >
> > The rq::uclamp::bucket[clamp_id][] array is scanned every time we need
> > to find a new MAX aggregated clamp value for a clamp_id. This operation
> > is required only when we dequeue the last task of a clamp bucket
> > tracking the current MAX aggregated clamp value. In these cases, the CPU
> > is either entering IDLE or going to schedule a less boosted or more
> > clamped task.
> > The expected number of different clamp values, configured at build time,
> > is small enough to fit the full unordered array into a single cache
> > line.
> 
> I assume you are talking about "struct uclamp_rq uclamp[UCLAMP_CNT]"
> here.

No, I'm talking about the rq::uclamp::bucket[clamp_id][], which is an
array of:

   struct uclamp_bucket {
	unsigned long value : bits_per(SCHED_CAPACITY_SCALE);
	unsigned long tasks : BITS_PER_LONG - bits_per(SCHED_CAPACITY_SCALE);
   };

defined as part of:

   struct uclamp_rq {
	unsigned int value;
	struct uclamp_bucket bucket[UCLAMP_BUCKETS];
   };


So, it's an array of UCLAMP_BUCKETS (value, tasks) pairs.

> uclamp_rq size depends on UCLAMP_BUCKETS configurable to be up
> to 20. sizeof(long)*20 is already more than 64 bytes. What am I
> missing?

Right, the comment above refers to the default configuration, which is
5 buckets. With that configuration we have:


$> pahole kernel/sched/core.o

---8<---
   struct uclamp_bucket {
           long unsigned int          value:11;             /*     0:53  8 */
           long unsigned int          tasks:53;             /*     0: 0  8 */

           /* size: 8, cachelines: 1, members: 2 */
           /* last cacheline: 8 bytes */
   };

   struct uclamp_rq {
           unsigned int               value;                /*     0     4 */

           /* XXX 4 bytes hole, try to pack */

           struct uclamp_bucket       bucket[5];            /*     8    40 */

           /* size: 48, cachelines: 1, members: 2 */
           /* sum members: 44, holes: 1, sum holes: 4 */
           /* last cacheline: 48 bytes */
   };

   struct rq {
           // ...
           /* --- cacheline 2 boundary (128 bytes) --- */
           struct uclamp_rq           uclamp[2];            /*   128    96 */
           /* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */
           // ...
   };
---8<---

Where you see the array fits into a single cache line.

Actually I notice now that, since when we removed the bucket dedicated
to the default values, we now have some spare space and we can
probably increase the default (and minimum) value of UCLAMP_BUCKETS to
be 7.

This will uses two full cache lines in struct rq, one for each clamp
index...  Although 7 it's a bit of a odd number and gives by default
buckets of ~14% size instead of the ~20%.

Thoughts ?

[...]

-- 
#include <best/regards.h>

Patrick Bellasi
