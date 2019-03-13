Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F08C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3E02075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F+lBHOhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfCMT7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:59:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54348 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfCMT67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ykiiJML9EDdU9ASqZCBZe++y3rcLe+e01y57sW4tjL0=; b=F+lBHOhUjTYh0s4cTcpuo/6eo
        VksRyO6WHJ0/OTbyGSbOxF+9I6//9XsyJOx0WzGys87yw2rse9ZXlLK/hTWoIVYgCQlBbmH7VxuYK
        9o6SiVExtJ8VUzOXimVruQ/WOAwE94drX82JEcWk2SsV5J5WVaOl3NVZwiFKl18wnY1glYON86A3C
        rPhC7/vy9aZhCSrtCRKQ3lTuBueK5J2xrsoROssOmFU8N+dD9ObCYd8pwQJ51FmCKGAWKDbVtFnN4
        vfjuWECeoeh9J4WlDCc1AOFrNIw+1eWwaGB3a1kgWLYgSF90oQlozCV5gxhBL3+uzlKKwzBF15NGU
        kPvsVIBSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4A1c-0008Fc-Fe; Wed, 13 Mar 2019 19:58:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DBCC9826C0; Wed, 13 Mar 2019 20:58:50 +0100 (CET)
Date:   Wed, 13 Mar 2019 20:58:50 +0100
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
Message-ID: <20190313195850.GT2482@worktop.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-4-patrick.bellasi@arm.com>
 <20190313143240.GH5922@hirez.programming.kicks-ass.net>
 <20190313170940.ngiafkmiijryhl2k@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313170940.ngiafkmiijryhl2k@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 05:09:40PM +0000, Patrick Bellasi wrote:
> On 13-Mar 15:32, Peter Zijlstra wrote:

> > I still think that this effective thing is backwards.

> With respect to the previous v6, I've now moved this concept to the
> patch where we actually use it for the first time.

> The "effective" values allows to efficiently enforce the most
> restrictive clamp value for a task at enqueue time by:
>  - not loosing track of the original request
>  - don't caring about updating non runnable tasks

My point is that you already had an effective value; namely p->uclamp[],
since patch 1.

This patch then changes that into something else, instead of adding
p->uclamp_orig[], and concequently has to update all sites that
previously used p->uclamp[], which is a lot of pointless churn.


