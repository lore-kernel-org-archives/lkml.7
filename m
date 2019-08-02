Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFF4C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5852620B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436609AbfHBOI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:08:59 -0400
Received: from foss.arm.com ([217.140.110.172]:52540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732817AbfHBOI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:08:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D66631570;
        Fri,  2 Aug 2019 07:08:57 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15B183F575;
        Fri,  2 Aug 2019 07:08:56 -0700 (PDT)
Date:   Fri, 2 Aug 2019 15:08:54 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] Fix FIFO-99 abuse
Message-ID: <20190802140854.ixq4cmo5nsfdaj24@e107158-lin.cambridge.arm.com>
References: <20190801111348.530242235@infradead.org>
 <20190801131707.5rpyydznnhz474la@e107158-lin.cambridge.arm.com>
 <20190802093244.GF2332@hirez.programming.kicks-ass.net>
 <20190802102611.54sae3onftck5fye@e107158-lin.cambridge.arm.com>
 <20190802124151.GG2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190802124151.GG2332@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/19 14:41, Peter Zijlstra wrote:
> On Fri, Aug 02, 2019 at 11:26:12AM +0100, Qais Yousef wrote:
> 
> > Yes a somewhat enforced default makes more sense to me. I assume you no longer
> > want to put the kthreads that just need to be above OTHER in FIFO-1?
> 
> I'm not sure, maybe, there's not that many of them, but possibly we add
> another interface for them.

By the way, did you see this one which is set to priority 16?

https://elixir.bootlin.com/linux/v5.3-rc2/source/drivers/gpu/drm/msm/msm_drv.c#L523

> 
> > While at it, since we will cram all kthreads on the same priority, isn't
> > a SCHED_RR a better choice now? I think the probability of a clash is pretty
> > low, but when it happens, shouldn't we try to guarantee some fairness?
> 
> It's never been a problem, and aside from these few straggler threads,
> everybody has effectively been there already for years, so if it were a
> problem someone would've complained by now.

Usually they can run on enough CPUs so a real clash is definitely hard.

I'm trying to collect data on that, if I find something interesting I'll share
it.

> 
> Also; like said before, the admin had better configure.

I agree. But I don't think an 'admin' is an easily defined entity for all
systems. On mobile, is it the SoC vendor, Android framework, or the
handset/platform vendor/integrator?

In a *real* realtime system I think things are better defined. But usage of RT
tasks on generic systems is the confusing part. There's no real ownership and
things are more ad-hoc.

> 
> Also also, RR-SMP is actually broken (and nobody has cared enough to
> bother fixing it).

If you can give me enough pointers to understand the problem I might be able to
bother with it :-)

Thanks

--
Qais Yousef
