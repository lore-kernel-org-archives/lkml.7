Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEAAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC072085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NY4hXDfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfCRO3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:29:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfCRO3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=laOtTVpv43PYwoSYj86I6ACQnkyPR7h6qSuvkrpg3DM=; b=NY4hXDfKI6zzBr794q9eqRSdP
        S7VRz7wKZXeuL9Wbiq9/zKUAdp5mjlk8Uxe9lefsuMllB7p1A/w+XOgncmHxzd0T8O63wzhsxmnxW
        2v6fgM7QR08Jfv6QdBEXC+PyICCXLRXnPpSxS+DPqFj2pR3ttnUeRP/2+uPSsTJpP+cshDjtn2QM+
        ozpaZghOBocFI4knFgP+b9TT3O9Iiwr4MhehM0L8zJ8Zcg+sgquOxhiw4mLaKHjMh6XChawAhfabt
        1RvKZ6hGpAN98QWWcbAJxqk/NqLXqPbcHPE6V40IgR/EKZnaFfAW7F5YRt09LHY5w+w1kNah1BVlO
        AlDXEJ/Uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5tGL-0004WS-5R; Mon, 18 Mar 2019 14:29:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57200202194F5; Mon, 18 Mar 2019 15:29:10 +0100 (CET)
Date:   Mon, 18 Mar 2019 15:29:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v7 03/15] sched/core: uclamp: Add system default clamps
Message-ID: <20190318142910.GR6058@hirez.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-4-patrick.bellasi@arm.com>
 <20190313201821.GW2482@worktop.programming.kicks-ass.net>
 <20190318121804.tr3myhtgczvovmkq@e110439-lin>
 <20190318131050.GQ6058@hirez.programming.kicks-ass.net>
 <20190318142152.44biczhoby44xlfz@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318142152.44biczhoby44xlfz@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 02:21:52PM +0000, Patrick Bellasi wrote:
> On 18-Mar 14:10, Peter Zijlstra wrote:
> > On Mon, Mar 18, 2019 at 12:18:04PM +0000, Patrick Bellasi wrote:
> > > On 13-Mar 21:18, Peter Zijlstra wrote:
> > > > On Fri, Feb 08, 2019 at 10:05:42AM +0000, Patrick Bellasi wrote:
> > > > > +static void uclamp_fork(struct task_struct *p)
> > > > > +{
> > > > > +	unsigned int clamp_id;
> > > > > +
> > > > > +	if (unlikely(!p->sched_class->uclamp_enabled))
> > > > > +		return;
> > > > > +
> > > > > +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
> > > > > +		p->uclamp[clamp_id].active = false;
> > > > > +}
> > > > 
> > > > Because in that case .active == false, and copy_process() will have done
> > > > thr right thing?
> > > 
> > > Don't really get what you mean here? :/
> > 
> > Why don't we have to set .active=false when
> > !sched_class->uclamp_enabled?
> 
> Ok, got it.
> 
> In principle because:
> - FAIR and RT will have uclamp_enabled
> - DL cannot fork
> 
> ... thus, yes, it seems that the check above is not necessary anyway.
> 
> Moreover, as per one of your comments in another message, we still need
> to cover the "reset on fork" case for FAIR and RT. Thus, I'm going to
> completely remove the support check in uclamp_fork and we always reset
> active for all classes.

Right, thanks!
