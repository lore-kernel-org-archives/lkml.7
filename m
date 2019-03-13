Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A7BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84B220693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KgpbwLjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfCMTjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:39:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfCMTjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mkAEJ6osON4cSSNuJ8mxtyGzpNSZBltB7dt4tPBVi9g=; b=KgpbwLjHM6V8njnyaCm0cmoXB
        2bvSK+juXv3zR861JbkUiHZBwry8kN3ETgAqPCmhYwwGqdfD8yE7yNYz9Rv55bSo9TFGTSWTB5ML5
        ZDwJfdJwdzM5Gy3tKHhcPVHxBbwXjfI27yxyL9GmhVE5bbYYocpLS8qbcmwa0j6QKtbRA2eI3S5dD
        dPm43VyA1lvfgFHh72xuPjqGpWWr7N/EN7MXaRLxpmnQ6G6wZa1mfoOCPbD+B0W0EUxlbHWddWWOR
        YCvOLCbi3v/P53FmGVIczlW2xTLDXjoIw4MqD6Rc8nogu+bDFCkZTipXbc1b+nHDZGtabvU2GUod9
        4uJ/0Nlzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h49ih-0007sD-DM; Wed, 13 Mar 2019 19:39:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9FE69826C0; Wed, 13 Mar 2019 20:39:16 +0100 (CET)
Date:   Wed, 13 Mar 2019 20:39:16 +0100
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
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190313193916.GQ2482@worktop.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <20190313135238.GC5922@hirez.programming.kicks-ass.net>
 <20190313155954.jse2tyn5iqxm6wle@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313155954.jse2tyn5iqxm6wle@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 03:59:54PM +0000, Patrick Bellasi wrote:
> On 13-Mar 14:52, Peter Zijlstra wrote:

> Because of backetization, we potentially end up tracking tasks with
> different requested clamp values in the same bucket.
> 
> For example, with 20% bucket size, we can have:
>   Task1: util_min=25%
>   Task2: util_min=35%
> accounted in the same bucket.

> > Given all that, what is to stop the bucket value to climbing to
> > uclamp_bucket_value(+1)-1 and staying there (provided there's someone
> > runnable)?
> 
> Nothing... but that's an expected consequence of bucketization.

No, it is not.

> > Why are we doing this... ?
> 
> You can either decide to:
> 
>  a) always boost tasks to just the bucket nominal value
>     thus always penalizing both Task1 and Task2 of the example above

This is the expected behaviour. When was the last time your histogram
did something like b?

>  b) always boost tasks to the bucket "max" value
>     thus always overboosting both Task1 and Task2 of the example above
> 
> The solution above instead has a very good property: in systems
> where you have only few and well defined clamp values we always
> provide the exact boost.
> 
> For example, if your system requires only 23% and 47% boost values
> (totally random numbers), then you can always get the exact boost
> required using just 3 bucksts or ~33% size each.
> 
> In systems where you don't know which boost values you will have, you
> can still defined the maximum overboost granularity you accept for
> each task by just tuning the number of clamp groups. For example, with
> 20 groups you can have a 5% max overboost.

Maybe, but this is not a direct concequence of buckets, but an
additional heuristic that might work well in this case.

Maybe split this out in a separate patch? So start with the trivial
bucket, and then do this change on top with the above few paragraphs as
changelog?
