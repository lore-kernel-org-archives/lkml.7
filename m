Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FFDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D522206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfCDQsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:48:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfCDQsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:48:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 487B0A78;
        Mon,  4 Mar 2019 08:48:19 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E45CF3F703;
        Mon,  4 Mar 2019 08:48:17 -0800 (PST)
Date:   Mon, 4 Mar 2019 16:48:16 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?utf-8?B?V2FuZywgVmluY2VudCAo546L5LqJKQ==?= 
        <Vincent.Wang@unisoc.com>,
        =?utf-8?B?WmhhbmcsIENodW55YW4gKOW8oOaYpeiJsyk=?= 
        <Chunyan.Zhang@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggVjRdIHNj?=
 =?utf-8?Q?hed=2Fcpufreq=3A_initializ?= =?utf-8?Q?e?= iowait_boost_max and
 iowait_boost with cpu capacity
Message-ID: <20190304164816.4fnxxesjwzdoqria@queper01-lin>
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
 <20190222105957.wxhlcmoag5f3i4fi@queper01-lin>
 <9099990618e242e1bab77ce3f9d9b1e3@BJMBX02.spreadtrum.com>
 <20190304135810.rq2ojnbn5vezrab3@queper01-lin>
 <20190304152616.GM32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304152616.GM32494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 Mar 2019 at 16:26:16 (+0100), Peter Zijlstra wrote:
> On Mon, Mar 04, 2019 at 01:58:12PM +0000, Quentin Perret wrote:
> > You could also update the values in sugov_get_util() at the cost of a
> > small overhead to compute 'min'. I'm not sure what's preferable since
> > we wanted to avoid that kind of overhead in the first place ...
> 
> Or,... we could actually make things simpler.
> 
> How's the below? I have a feq questions wrt min, mostly:
> 
>  - what's the difference between policy->min and
>    policy->cpuinfo.min_freq; it used to be the former, the below uses
>    the latter.

As mentioned on IRC, IIRC policy->min is something that can be written
from userspace (for example) to cap the min freq. OTOH, cpuinfo.min_freq
is read-only and just reports the lowest OPP.

Rafael is this correct ?

>  - should we have a min_freq based value, instead of a constant; the
>    difference being that with this the actual boost speed depends in the
>    gap between min/max.

If the above is correct, then I agree. Looking at min_freq simplifies
things quite a bit since it doesn't need to be updated all the time,
and the whole policy->min stuff is dealt with at the CPUFreq core level
so it's not obvious sugov should care.

> Anyway; the below converts iowait_boost to capacity scale (from kHz), it
> side-steps the whole issue you guys are bickering about by limiting it
> to SCHED_CAPACITY_SCALE (aka. 1024) on the boost path, and then limiting
> it to @max by the time we figured out we ought to use it.
>
> And since that means we never change @max anymore; we can simplify whole
> return value thing.

[...]

> @@ -837,7 +818,9 @@ static int sugov_start(struct cpufreq_policy *policy)
>  		memset(sg_cpu, 0, sizeof(*sg_cpu));
>  		sg_cpu->cpu			= cpu;
>  		sg_cpu->sg_policy		= sg_policy;
> -		sg_cpu->iowait_boost_max	= policy->cpuinfo.max_freq;
> +		sg_cpu->min			=
> +			(SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
> +			policy->cpuinfo.max_freq;

The 'funny' thing is that on big little this 'min' can end up being
larger than 'max' ...

On juno r0 for example, min_freq and max_freq for little CPUs are
respectively 450MHz and 850MHz. So you get sg_cpu->min=542, but
sg_cpu->max=446 ... So you'll max out after the first IO wakeup.
And since iowait_boost is reset whenever it is smaller than sg_cpu->min,
you end up with something that can either force max freq or apply no
boost at all ...

Perhaps you could keep the 'util' and 'max' pointers in
sugov_iowait_apply() and overwrite them like before, but in the
SCHED_CAPACITY_SCALE scale as you suggest ?

Thanks,
Quentin
