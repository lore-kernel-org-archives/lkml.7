Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35C6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B665020675
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h2lvm4kV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCDRki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:40:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfCDRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=40I1v536/b41E6WOnWF6IY07esNf1kVynE6ckzDTCe4=; b=h2lvm4kVxd7o+Kbxp1w0Drrxj
        +DygUkgjo0VTEPI9+CmBrLNtRt5/88dNiPK9GxYlSSeKmyDJJaVSXxsdVYCukFN5NlUHaTNaQGl93
        VcKB+121hnCrQWeoZGbE3KvEAeU4h8NQwjv3zrN0DBhCZPfvUKr6PJwbULj9kSwTLoNomta8SmuoK
        eYvA2g98sxXcVjwTUynPFpixmkBMnhpSsjZDZeJ9lhswllFd2zca87WjNRaKxSZ8hbd9EdlI9LE7j
        G+K1Uho4XfD9Q6fSXD0Wr2dycIBFN41N2mHYbqqJTOGGmqlDCvGKZ0oHBt0DJIDAzcylNRgLQ82QS
        lSw0od06g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0rZm-0001Hi-Rg; Mon, 04 Mar 2019 17:40:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53B752029319B; Mon,  4 Mar 2019 18:40:28 +0100 (CET)
Date:   Mon, 4 Mar 2019 18:40:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
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
Message-ID: <20190304174028.GO32494@hirez.programming.kicks-ass.net>
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
 <20190222105957.wxhlcmoag5f3i4fi@queper01-lin>
 <9099990618e242e1bab77ce3f9d9b1e3@BJMBX02.spreadtrum.com>
 <20190304135810.rq2ojnbn5vezrab3@queper01-lin>
 <20190304152616.GM32494@hirez.programming.kicks-ass.net>
 <20190304164816.4fnxxesjwzdoqria@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304164816.4fnxxesjwzdoqria@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 04:48:16PM +0000, Quentin Perret wrote:

> > @@ -837,7 +818,9 @@ static int sugov_start(struct cpufreq_policy *policy)
> >  		memset(sg_cpu, 0, sizeof(*sg_cpu));
> >  		sg_cpu->cpu			= cpu;
> >  		sg_cpu->sg_policy		= sg_policy;
> > -		sg_cpu->iowait_boost_max	= policy->cpuinfo.max_freq;
> > +		sg_cpu->min			=
> > +			(SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
> > +			policy->cpuinfo.max_freq;
> 
> The 'funny' thing is that on big little this 'min' can end up being
> larger than 'max' ...
> 
> On juno r0 for example, min_freq and max_freq for little CPUs are
> respectively 450MHz and 850MHz. So you get sg_cpu->min=542, but
> sg_cpu->max=446 ... So you'll max out after the first IO wakeup.
> And since iowait_boost is reset whenever it is smaller than sg_cpu->min,
> you end up with something that can either force max freq or apply no
> boost at all ...
> 
> Perhaps you could keep the 'util' and 'max' pointers in
> sugov_iowait_apply() and overwrite them like before, but in the
> SCHED_CAPACITY_SCALE scale as you suggest ?

Urgh; but then we're back to having that boostrap problem.

Now; at this time; @max is in fact scale_cpu_capacity, so can't we
change this:

-       /*
-        * Apply the current boost value: a CPU is boosted only if its current
-        * utilization is smaller then the current IO boost level.
-        */
-       boost_util = sg_cpu->iowait_boost;
-       boost_max = sg_cpu->iowait_boost_max;
-       if (*util * boost_max < *max * boost_util) {
-               *util = boost_util;
-               *max = boost_max;
-       }
+       sg_cpu->iowait_boost_pending = false;
+
+       return min(max(util, sg_cpu->iowait_boost), max);
}

to something like:

	/*
	 * @util is already in capacity scale, convert iowait_boost
	 * into the same scale so we can compare.
	 */
	boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
	util = max(boost, util);
	return min(util, max);

