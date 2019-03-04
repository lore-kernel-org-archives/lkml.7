Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A01C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF75206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lVI2eVjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfCDSrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:47:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfCDSrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Qo0Oeh0RpzAZbpvBZeV1g3vpvW8KYSofTIrjzx3Di2w=; b=lVI2eVjRZSGsTwBssHFPQU+MY
        AvpaOlYqoswNkqFrNbRWCS6zGEwQPgkC2qQZlaY+Sq+D7uxibAGs1Ag5SIdmk15LndzIxj4Z9ZWjS
        xEnlhHf9o+zBn7p8EcrLiXNPL71x0Kjc3jT0yqiI93nC/SId2+cITg+rIM5mGrGZb39doHSFf5HW9
        s81nSLOBmXQztSah6BJfDKf5+Rca4kc1PWaj0vWecH2NbWAm/AIgU1QEkRtPzXinfH8PoIUFE86DS
        s8PV6rsv+NzP3Ca8DF3CCO/XZCrQHJNZPwnS3jBeyd3r2uy/O72jwOpPSMZLxbS79iUMft0njzwTu
        MAuQxNuyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0scI-0007vp-Cj; Mon, 04 Mar 2019 18:47:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 218E329AB097E; Mon,  4 Mar 2019 19:47:08 +0100 (CET)
Date:   Mon, 4 Mar 2019 19:47:08 +0100
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
Message-ID: <20190304184708.GQ32494@hirez.programming.kicks-ass.net>
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
 <20190222105957.wxhlcmoag5f3i4fi@queper01-lin>
 <9099990618e242e1bab77ce3f9d9b1e3@BJMBX02.spreadtrum.com>
 <20190304135810.rq2ojnbn5vezrab3@queper01-lin>
 <20190304152616.GM32494@hirez.programming.kicks-ass.net>
 <20190304164816.4fnxxesjwzdoqria@queper01-lin>
 <20190304174028.GO32494@hirez.programming.kicks-ass.net>
 <20190304175030.4slf247y2eftkmu4@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304175030.4slf247y2eftkmu4@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 05:50:32PM +0000, Quentin Perret wrote:
> On Monday 04 Mar 2019 at 18:40:28 (+0100), Peter Zijlstra wrote:
> > > Perhaps you could keep the 'util' and 'max' pointers in
> > > sugov_iowait_apply() and overwrite them like before, but in the
> > > SCHED_CAPACITY_SCALE scale as you suggest ?
> > 
> > Urgh; but then we're back to having that boostrap problem.
> 
> Hmm, I don't understand :/

Yeah, I seen to have reading comprehension issues today. Ignore that.

> > Now; at this time; @max is in fact scale_cpu_capacity, so can't we
> > change this:
> > 
> > -       /*
> > -        * Apply the current boost value: a CPU is boosted only if its current
> > -        * utilization is smaller then the current IO boost level.
> > -        */
> > -       boost_util = sg_cpu->iowait_boost;
> > -       boost_max = sg_cpu->iowait_boost_max;
> 
> I was basically suggesting to do 'boost_max = 1024;' here and you
> should be good with you way of computing 'min' no ?

Right, but then we keep having to retain those two mults.

> > -       if (*util * boost_max < *max * boost_util) {
> > -               *util = boost_util;
> > -               *max = boost_max;
> > -       }
> > +       sg_cpu->iowait_boost_pending = false;
> > +
> > +       return min(max(util, sg_cpu->iowait_boost), max);
> > }
> > 
> > to something like:
> > 
> > 	/*
> > 	 * @util is already in capacity scale, convert iowait_boost
> > 	 * into the same scale so we can compare.
> > 	 */
> > 	boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
> > 	util = max(boost, util);
> > 	return min(util, max);
> > 
> 
> But this should work too, I think.

While that is only a single mult.
