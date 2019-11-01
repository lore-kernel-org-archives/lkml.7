Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70D2CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32A021855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfKAJN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:13:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:60602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727919AbfKAJN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:13:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8A74AB91;
        Fri,  1 Nov 2019 09:13:54 +0000 (UTC)
Date:   Fri, 1 Nov 2019 09:13:48 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     ?????? <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/numa: advanced per-cgroup numa statistic
Message-ID: <20191101091348.GM28938@suse.de>
References: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
 <20191030095505.GF28938@suse.de>
 <6f5e43db-24f1-5283-0881-f264b0d5f835@linux.alibaba.com>
 <20191031131731.GJ28938@suse.de>
 <5d69ff1b-a477-31b5-8600-9233a38445c7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <5d69ff1b-a477-31b5-8600-9233a38445c7@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 09:49:20AM +0800, ?????? wrote:
> 
> 
> On 2019/10/31 ??????9:17, Mel Gorman wrote:
> > On Thu, Oct 31, 2019 at 11:31:24AM +0800, ?????? wrote:
> [snip]
> >> For example, tasks bind to the cpus of node_0 could have their memory on
> >> node_1 when node_0 almost run out of memory, numa balancing may not be
> >> able to help in this case, while by reading locality we could know how
> >> critical the problem is, and may take action to rebind cpus to node_1 or
> >> reclaim the memory of node_0.
> >>
> > 
> > You can already do this by walking each cgroup, identifying what tasks are
> > in it and look at /proc/PID/numa_maps and /proc/PID/status to see what
> > CPU bindings if any exist. This would use the actual memory placements
> > and not those sampled by NUMA balancing, would not require NUMA balancing
> > and would work on older kernels. It would be costly to access so I would
> > not suggest doing it at high frequency but it makes sense for the tool
> > that cares to pay the cost instead of spreading tidy bits of cost to
> > every task whether there is an interested tool or not.
> 
> I see the biggest concern now is the necessity to let kernel providing these
> data, IMHO there are actually good reasons here:
>   * there are too many tasks to gathering data from, reading proc cost a lot
>   * tasks living and dying, data lost between each sample window
> 
> For example in our cases, we could have hundreds of cgroups, each contain
> hundreds of tasks, these worker thread could live and die at any moment,
> for gathering we need to cat the list of tasks and then go reading these proc
> files one by one, which fall into kernel rapidly and may even need to holding
> some locks, this introduced big latency impact, and give no accurate output
> since some task may already died before reading it's data.
> 
> Then before next sample window, info of tasks died during the window can't be
> acquired anymore.
> 
> We need kernel's help on reserving data since tool can't catch them in time
> before they are lost, also we have to avoid rapidly proc reading, which really
> cost a lot and further more, introduce big latency on each sample window.
> 

There is somewhat of a disconnect here. You say that the information must
be accurate and historical yet are relying on NUMA hinting faults to build
the picture which may not be accurate at all given that faults are not
guaranteed to happen. For short-lived tasks, it is also potentially skewed
information if short-lived tasks dominated remote accesses for whatever
reason even though it does not matter -- the tasks were short-lived and
their performance is probably irrelevant. Short-lived tasks may not even
show up if they do not run longer than sysctl_numa_balancing_scan_delay
so the data gathered already has holes in it.

While it's a bit more of a stretch, even this could still be done from
userspace if numa_hint_fault was probed and the event handled (eBPF,
systemtap etc) to build the picture or add a tracepoint. That would give
a much higher degree of flexibility on what information is tracked and
allow flexibility on 

So, overall I think this can be done outside the kernel but recognise
that it may not be suitable in all cases. If you feel it must be done
inside the kernel, split out the patch that adds information on failed
page migrations as it stands apart. Put it behind its own kconfig entry
that is disabled by default -- do not tie it directly to NUMA balancing
because of the data structure changes. When enabled, it should still be
disabled by default at runtime and only activated via kernel command line
parameter so that the only people who pay the cost are those that take
deliberate action to enable it.

-- 
Mel Gorman
SUSE Labs
