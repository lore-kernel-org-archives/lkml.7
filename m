Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF81206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCDRuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:50:39 -0500
Received: from foss.arm.com ([217.140.101.70]:36794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfCDRuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:50:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DB37A78;
        Mon,  4 Mar 2019 09:50:38 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45CD43F703;
        Mon,  4 Mar 2019 09:50:37 -0800 (PST)
Date:   Mon, 4 Mar 2019 17:50:32 +0000
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
Message-ID: <20190304175030.4slf247y2eftkmu4@queper01-lin>
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
 <20190222105957.wxhlcmoag5f3i4fi@queper01-lin>
 <9099990618e242e1bab77ce3f9d9b1e3@BJMBX02.spreadtrum.com>
 <20190304135810.rq2ojnbn5vezrab3@queper01-lin>
 <20190304152616.GM32494@hirez.programming.kicks-ass.net>
 <20190304164816.4fnxxesjwzdoqria@queper01-lin>
 <20190304174028.GO32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304174028.GO32494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 Mar 2019 at 18:40:28 (+0100), Peter Zijlstra wrote:
> > Perhaps you could keep the 'util' and 'max' pointers in
> > sugov_iowait_apply() and overwrite them like before, but in the
> > SCHED_CAPACITY_SCALE scale as you suggest ?
> 
> Urgh; but then we're back to having that boostrap problem.

Hmm, I don't understand :/

> Now; at this time; @max is in fact scale_cpu_capacity, so can't we
> change this:
> 
> -       /*
> -        * Apply the current boost value: a CPU is boosted only if its current
> -        * utilization is smaller then the current IO boost level.
> -        */
> -       boost_util = sg_cpu->iowait_boost;
> -       boost_max = sg_cpu->iowait_boost_max;

I was basically suggesting to do 'boost_max = 1024;' here and you
should be good with you way of computing 'min' no ?

> -       if (*util * boost_max < *max * boost_util) {
> -               *util = boost_util;
> -               *max = boost_max;
> -       }
> +       sg_cpu->iowait_boost_pending = false;
> +
> +       return min(max(util, sg_cpu->iowait_boost), max);
> }
> 
> to something like:
> 
> 	/*
> 	 * @util is already in capacity scale, convert iowait_boost
> 	 * into the same scale so we can compare.
> 	 */
> 	boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
> 	util = max(boost, util);
> 	return min(util, max);
> 

But this should work too, I think.

Thanks,
Quentin
