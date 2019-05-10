Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25B6C04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D54217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lNZ7a6py"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfEJHVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:21:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfEJHVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uwdIcBUmVfzWGoctVjnYH5rQgHvL0u+qnruw3GjdPnQ=; b=lNZ7a6pyI902Z6aRZzYeDPq0C
        ogGK4N60ciJU0RpHq9y23wowsXTmw4T8f65owtYKg5qPv2FhCxNKTaZQCIDsXOBFKAJK9aa+ofjeG
        02ywY6seKiw1eJG2CGOx7yzEhurAbHsdN2+B8DU24ZC0yCYhOhB14jC6UYk0EIYu/X4o5GJDCH7yh
        egTsl2ZM+/ZIizCeUGYiOx6paEC6OXqlmOnZzMIEiiCWmgIfdpECmhYg/7G6shfflk4MnkLpwMmgE
        ak8Ne95SMzCWbfFnn7OnCWfRFeHaQoIFiH63YHneljN2aMIgIrBnfSz8s5a5oi2Tsv21rVT8tfqAu
        g5p5RFxLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOzqS-0004cY-2M; Fri, 10 May 2019 07:21:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07C83284B2F48; Fri, 10 May 2019 09:21:26 +0200 (CEST)
Date:   Fri, 10 May 2019 09:21:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org,
        steven.sistare@oracle.com
Subject: Re: [RFC V2 2/2] sched/fair: Fallback to sched-idle CPU if idle CPU
 isn't found
Message-ID: <20190510072125.GG2623@hirez.programming.kicks-ass.net>
References: <cover.1556182964.git.viresh.kumar@linaro.org>
 <59b37c56b8fcb834f7d3234e776eaeff74ad117f.1556182965.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b37c56b8fcb834f7d3234e776eaeff74ad117f.1556182965.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 03:07:40PM +0530, Viresh Kumar wrote:
> We target for an idle CPU in select_idle_sibling() to run the next task,
> but in case we don't find idle CPUs it is better to pick a CPU which
> will run the task the soonest, for performance reason. A CPU which isn't
> idle but has only SCHED_IDLE activity queued on it should be a good
> target based on this criteria as any normal fair task will most likely
> preempt the currently running SCHED_IDLE task immediately. In fact,
> choosing a SCHED_IDLE CPU shall give better results as it should be able
> to run the task sooner than an idle CPU (which requires to be woken up
> from an idle state).
> 
> This patch updates the fast path to fallback to a sched-idle CPU if the
> idle CPU isn't found, the slow path can be updated separately later.
> 
> Following is the order in which select_idle_sibling() picks up next CPU
> to run the task now:
> 
> 1. idle_cpu(target) OR sched_idle_cpu(target)
> 2. idle_cpu(prev) OR sched_idle_cpu(prev)
> 3. idle_cpu(recent_used_cpu) OR sched_idle_cpu(recent_used_cpu)
> 4. idle core(sd)
> 5. idle_cpu(sd)
> 6. sched_idle_cpu(sd)
> 7. idle_cpu(p) - smt
> 8. sched_idle_cpu(p)- smt
> 
> Though the policy can be tweaked a bit if we want to have different
> priorities.

I don't hate his per se; but the whole select_idle_sibling() thing is
something that needs looking at.

There was the task stealing thing from Steve that looked interesting and
that would render your apporach unfeasible.
