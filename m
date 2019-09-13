Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4BDC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969A8205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbfIMOPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:15:47 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39269 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387968AbfIMOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:15:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0TcEdX6g_1568384140;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TcEdX6g_1568384140)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Sep 2019 22:15:42 +0800
Date:   Fri, 13 Sep 2019 22:15:40 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190913141540.GB81644@aaronlu>
References: <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
 <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
 <20190912123532.GB16200@aaronlu>
 <8373e386-cb99-8f79-a78e-5e79dc962b81@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8373e386-cb99-8f79-a78e-5e79dc962b81@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 10:29:13AM -0700, Tim Chen wrote:
> On 9/12/19 5:35 AM, Aaron Lu wrote:
> > On Wed, Sep 11, 2019 at 12:47:34PM -0400, Vineeth Remanan Pillai wrote:
> 
> > 
> > core wide vruntime makes sense when there are multiple tasks of
> > different cgroups queued on the same core. e.g. when there are two
> > tasks of cgroupA and one task of cgroupB are queued on the same core,
> > assume cgroupA's one task is on one hyperthread and its other task is on
> > the other hyperthread with cgroupB's task. With my current
> > implementation or Tim's, cgroupA will get more time than cgroupB. 
> 
> I think that's expected because cgroup A has two tasks and cgroup B
> has one task, so cgroup A should get twice the cpu time than cgroup B
> to maintain fairness.

Like you said below, the ideal run time for each cgroup should depend on
their individual weight. The fact cgroupA has two tasks doesn't mean it
has twice the weight. Both cgroup can have the same cpu.share settings
and then, the more task a cgroup has, the less weight it can get for the
cgroup's per-cpu se.

I now realized one thing that's different in your idle_allowance
implementation and my core_vruntime implementation. In your
implementation, the idle_allowance is absolute time while vruntime can
be adjusted by the se's weight, that's probably one area your
implementation can make things less fair then mine.

> > If we
> > maintain core wide vruntime for cgroupA and cgroupB, we should be able
> > to maintain fairness between cgroups on this core. 
> 
> I don't think the right thing to do is to give cgroupA and cgroupB equal
> time on a core.  The time they get should still depend on their 
> load weight.

Agree.

> The better thing to do is to move one task from cgroupA to another core,
> that has only one cgroupA task so it can be paired up
> with that lonely cgroupA task.  This will eliminate the forced idle time
> for cgropuA both on current core and also the migrated core.

I'm not sure if this is always possible.

Say on a 16cores/32threads machine, there are 3 cgroups, each has 16 cpu
intensive tasks, will it be possible to make things perfectly balanced?

Don't get me wrong, I think this kind of load balancing is good and
needed, but I'm not sure if we can always make things perfectly
balanced. And if not, do we care those few cores where cgroup tasks are
not balanced and then, do we need to implement the core_wide cgoup
fairness functionality or we don't care since those cores are supposed
to be few and isn't a big deal?

> > Tim propose to solve
> > this problem by doing some kind of load balancing if I'm not mistaken, I
> > haven't taken a look at this yet.
> > 
> 
> My new patchset is trying to solve a different problem.  It is
> not trying to maintain fairness between cgroup on a core, but tries to
> even out the load of a cgroup between threads, and even out general
> load between cores. This will minimize the forced idle time.

Understood.

> 
> The fairness between cgroup relies still on
> proper vruntime accounting and proper comparison of vruntime between
> threads.  So for now, I am still using Aaron's patchset for this purpose
> as it has better fairness property than my other proposed patchsets
> for fairness purpose.
> 
> With just Aaron's current patchset we may have a lot of forced idle time
> due to the uneven distribution of tasks of different cgroup among the
> threads and cores, even though scheduling fairness is maintained.
> My new patches try to remove those forced idle time by moving the
> tasks around, to minimize cgroup unevenness between sibling threads
> and general load unevenness between the CPUs.

Yes I think this is definitely a good thing to do.
