Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5717FCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E4721734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKANfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 09:35:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:49510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726860AbfKANfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 09:35:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D600DB07B;
        Fri,  1 Nov 2019 13:35:30 +0000 (UTC)
Date:   Fri, 1 Nov 2019 13:35:28 +0000
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
Message-ID: <20191101133528.GP28938@suse.de>
References: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
 <20191030095505.GF28938@suse.de>
 <6f5e43db-24f1-5283-0881-f264b0d5f835@linux.alibaba.com>
 <20191031131731.GJ28938@suse.de>
 <5d69ff1b-a477-31b5-8600-9233a38445c7@linux.alibaba.com>
 <20191101091348.GM28938@suse.de>
 <2573b108-7885-5c4f-a0ae-2b245d663250@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <2573b108-7885-5c4f-a0ae-2b245d663250@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 07:52:15PM +0800, ?????? wrote:
> > a much higher degree of flexibility on what information is tracked and
> > allow flexibility on 
> > 
> > So, overall I think this can be done outside the kernel but recognise
> > that it may not be suitable in all cases. If you feel it must be done
> > inside the kernel, split out the patch that adds information on failed
> > page migrations as it stands apart. Put it behind its own kconfig entry
> > that is disabled by default -- do not tie it directly to NUMA balancing
> > because of the data structure changes. When enabled, it should still be
> > disabled by default at runtime and only activated via kernel command line
> > parameter so that the only people who pay the cost are those that take
> > deliberate action to enable it.
> 
> Agree, we could have these per-task faults info there, give the possibility
> to implement maybe a practical userland tool,

I'd prefer not because that would still require the space in the locality
array to store the data. I'd also prefer that numa_faults_locality[]
information is not exposed unless this feature is enabled. That information
is subject to change and interpreting it requires knowledge of the
internals of automatic NUMA balancing.

There are just too many corner cases where the information is garbage.
Tasks with a memory policy would never update the counters, short-lived
tasks may not update it, interleaving will give confused information about
locality, the timing of the reads matter because it might be cleared,
the frequency at which they clear is unknown as the frequency is adaptive
-- the list goes on. I find it very very difficult to believe that a
tool based on faults_locality will be able to give anything but the
most superficial help and any sensible decision will require ftrace or
numa_maps to get real information.

> meanwhile have these kernel
> numa data disabled by default, folks who got no tool but want to do easy
> monitoring can just turn on the switch :-)
> 
> Will have these in next version:
> 
>  * separate patch for showing per-task faults info

Please only expose the failed= (or migfailed=) in that patch. Do not
expose numa_faults_locality unless it is explicitly enabled on behalf of
a tool that claims it can sensibly interpret it.

>  * new CONFIG for numa stat (disabled by default)
>  * dynamical runtime switch for numa stat (disabled by default)

Dynamic runtime enabling will mean that if it's turned on, the information
will be temporarily useless until stats are accumulated. Make sure to
note that in any associated documentation stating a preference to
enabling it with a kernel parameter.

-- 
Mel Gorman
SUSE Labs
