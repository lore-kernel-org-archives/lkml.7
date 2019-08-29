Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362EDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C1D215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n/5qsmvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfH2NxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:53:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58844 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfH2NxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zZ5dIDLPt1Nso49/uiRsureRpg7rvs2R4X3SF+2XaOA=; b=n/5qsmvgT6yVyYOrprJemW4eO
        K/p/fUfTe9nfZ77ynJ2k5zM8QZ9pzTT07SGpBYJhtYl1AY/cjB2Fi/9LsngmyDGOmvtDX2FfVQhV4
        qLkZfuLv+5rzYF4UlMlmu99VJw8iPmw2jVGh/FlbYuf6JqF5wyg1nSMQrhExi2EbguGS2NX/0nBm+
        ih0OQShQ5Tc7ftsvLbdMqUGD5nlN/gb3b6DJ4A9PtKc4SAq7H0Q4ah9V3GO749icczvAygC4JzAbS
        ZaBz7zT3E08ltBVLqkbjQ+ZZz7b09yHWkKPWXqnawXIsl6iuzE7JUZEpUkUDmEKYz4wCQVlW0LYmd
        AVb0fQEAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3KrD-0003DJ-9b; Thu, 29 Aug 2019 13:52:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C6FA301174;
        Thu, 29 Aug 2019 15:52:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A73E320CA3889; Thu, 29 Aug 2019 15:52:56 +0200 (CEST)
Date:   Thu, 29 Aug 2019 15:52:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
Message-ID: <20190829135256.GW2369@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <20190828151921.GD17205@worktop.programming.kicks-ass.net>
 <fd95a255-4499-2907-8af9-d340f157da68@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd95a255-4499-2907-8af9-d340f157da68@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:31:37AM -0400, Liang, Kan wrote:
> On 8/28/2019 11:19 AM, Peter Zijlstra wrote:
> > > +static int icl_set_topdown_event_period(struct perf_event *event)
> > > +{
> > > +	struct hw_perf_event *hwc = &event->hw;
> > > +	s64 left = local64_read(&hwc->period_left);
> > > +
> > > +	/*
> > > +	 * Clear PERF_METRICS and Fixed counter 3 in initialization.
> > > +	 * After that, both MSRs will be cleared for each read.
> > > +	 * Don't need to clear them again.
> > > +	 */
> > > +	if (left == x86_pmu.max_period) {
> > > +		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
> > > +		wrmsrl(MSR_PERF_METRICS, 0);
> > > +		local64_set(&hwc->period_left, 0);
> > > +	}
> > This really doesn't make sense to me; if you set FIXED_CTR3 := 0, you'll
> > never trigger the overflow there; this then seems to suggest the actual
> > counter value is irrelevant. Therefore you don't actually need this.
> > 
> 
> Could you please elaborate on why initialization to 0 never triggers an
> overflow?

Well, 'never' as in a 'long' time.

> As of my understanding, initialization to 0 only means that it will take
> more time than initialization to -max_period (0x8000 0000 0001) to trigger
> an overflow.

Only twice as long. And why do we care about that?

The problem with it is though that you get the overflow at the end of
the whole period, instead of halfway through, so reconstruction is
trickier.

> Maybe 0 is too tricky. We can set the initial value to 1.

That's even worse. I'm still not understanding why we can't use the
normal code.

> I think the bottom line is that we need a small initial value for FIXED_CTR3
> here.

But why?!

> PERF_METRICS reports an 8bit integer fraction which is something like 0xff *
> internal counters / FIXCTR3.
> The internal counters only start counting from 0. (SW cannot set an
> arbitrary initial value for internal counters.)
> If the initial value of FIXED_CTR3 is too big, PERF_METRICS could always
> remain constant, e.g. 0.

What what? The PERF_METRICS contents depends on the FIXCTR3 value ?!
That's bloody insane. /me goes find the SDM. The SDM is bloody useless
:-(.

Please give a complete and coherent description of all of this. I can't
very well review any of this until I know how the hardware works, now
can I.

In this write-up, include the exact condition for METRICS_OVF (the SDM
states: 'it indicates that PERF_METRIC counter has overflowed', which is
gramatically incorrect and makes no sense even with the missing article
injected).
