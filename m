Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39303C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6DE2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1/o08/7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390190AbfGRLiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:38:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43324 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390175AbfGRLiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1XG9ETPfNXBdNR3murMRWQhuyxiiIWkFmuE6S3E2wT8=; b=1/o08/7tmX+HDtavM1ps+YmJb
        MhYxip3PmYG60pHlETONIUpfVDnYkS1v+bG/HXysh/59aCdbHUOzVyWiI7GlO2LPlUqh3CkCCsyTk
        lWTPjsmj+7gGGhiNnOsTXNQ5VgvFl3ad4WssRDPUvwt8qbmdKh/3tBe3PKdhh4/REyVTtBZU1b5u7
        hl40aTazOPDFSG1gAxTz4TIQTHXDa6aFL3VZg11Eo9K18p6xDYRmcaKJbLuMyph8GYAWak3TnjCyv
        Yts4VkIHfqpIBRI7pGZS8zY0yDb95xKKJdE9wNb6sLYt9EXYOfz0GuAcjkU7XauiCK3nO7GWeMF1u
        qcNHrqcGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ho4jX-0003CC-TY; Thu, 18 Jul 2019 11:38:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A42B920197A71; Thu, 18 Jul 2019 13:37:58 +0200 (CEST)
Date:   Thu, 18 Jul 2019 13:37:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        prakash.sangappa@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, Paul Turner <pjt@google.com>
Subject: Re: [RFC PATCH 2/3] sched: change scheduler to give preference to
 soft affinity CPUs
Message-ID: <20190718113758.GN3402@hirez.programming.kicks-ass.net>
References: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
 <20190626224718.21973-3-subhra.mazumdar@oracle.com>
 <20190702172851.GA3436@hirez.programming.kicks-ass.net>
 <a91c09ce-aec1-eaa1-4daf-70024cebf360@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a91c09ce-aec1-eaa1-4daf-70024cebf360@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 08:31:25AM +0530, Subhra Mazumdar wrote:
> 
> On 7/2/19 10:58 PM, Peter Zijlstra wrote:
> > On Wed, Jun 26, 2019 at 03:47:17PM -0700, subhra mazumdar wrote:
> > > The soft affinity CPUs present in the cpumask cpus_preferred is used by the
> > > scheduler in two levels of search. First is in determining wake affine
> > > which choses the LLC domain and secondly while searching for idle CPUs in
> > > LLC domain. In the first level it uses cpus_preferred to prune out the
> > > search space. In the second level it first searches the cpus_preferred and
> > > then cpus_allowed. Using affinity_unequal flag it breaks early to avoid
> > > any overhead in the scheduler fast path when soft affinity is not used.
> > > This only changes the wake up path of the scheduler, the idle balancing
> > > is unchanged; together they achieve the "softness" of scheduling.
> > I really dislike this implementation.
> > 
> > I thought the idea was to remain work conserving (in so far as that
> > we're that anyway), so changing select_idle_sibling() doesn't make sense
> > to me. If there is idle, we use it.
> > 
> > Same for newidle; which you already retained.
> The scheduler is already not work conserving in many ways. Soft affinity is
> only for those who want to use it and has no side effects when not used.
> Also the way scheduler is implemented in the first level of search it may
> not be possible to do it in a work conserving way, I am open to ideas.

I really don't understand the premise of this soft affinity stuff then.

I understood it was to allow spreading if under-utilized, but group when
over-utilized, but you're arguing for the exact opposite, which doesn't
make sense.

> > And I also really don't want a second utilization tipping point; we
> > already have the overloaded thing.
> The numbers in the cover letter show that a static tipping point will not
> work for all workloads. What soft affinity is doing is essentially trading
> off cache coherence for more CPU. The optimum tradeoff point will vary
> from workload to workload and the system metrics of coherence overhead etc.
> If we just use the domain overload that becomes a static definition of
> tipping point, we need something tunable that captures this tradeoff. The
> ratio of CPU util seemed to work well and capture that.

And then you run two workloads with different characteristics on the
same box.

Global knobs are buggered.
