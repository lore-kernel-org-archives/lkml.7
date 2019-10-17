Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C345EFA372D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961A320820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sSSWDSRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408237AbfJQIZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:25:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51732 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390082AbfJQIZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lwJxn9QBi3wt/6dfD+wqzvEQfXxlMoAjM2J8+Itpyoc=; b=sSSWDSRcexzsb2xf3aHmyAa/I
        XdhMJr2FL9dMfRcV5eKO/MagVWWOrIvZbGSJXNW0SLqxvIdM/NCDx57wIkYqRp+IXs0tOAEkqbA+Y
        dy3ngfwqYaQM4xrLHrZuKTZ9wUvSt1RiglPDvEjwSf/08yUBS5CDYqveFN9dbPKgunTc922e5+Fcl
        hy1YaPnHMu83yHVytxJPSwUk9PG1tjSZpBVOF4ET9J4Qm7TLPsTQL/86ijbvnRz7p5BTqs7UUn6NB
        1RoH4GNNGwCtlOrRioGrsluOS6klVyndyCFOldqmUOMjl+u7gPgApGNCQpYj0jFPaKdDhSyNdcRLM
        VUSdGsvxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL16J-0003yN-QC; Thu, 17 Oct 2019 08:25:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32BAE304637;
        Thu, 17 Oct 2019 10:24:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7311F200DE9E1; Thu, 17 Oct 2019 10:25:37 +0200 (CEST)
Date:   Thu, 17 Oct 2019 10:25:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization
 increases
Message-ID: <20191017082537.GX2328@hirez.programming.kicks-ass.net>
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
 <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
 <20190628100751.lpcwsouacsi2swkm@e110439-lin>
 <20190628123800.GS3419@hirez.programming.kicks-ass.net>
 <20190628140057.7aujh2wsk7wtqib3@e110439-lin>
 <20190802094725.ploqfarz7fj7vrtp@e110439-lin>
 <20191014145218.GI2328@hirez.programming.kicks-ass.net>
 <48adc956-77a4-e293-29d9-cd8b82a40ae8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48adc956-77a4-e293-29d9-cd8b82a40ae8@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 05:16:02PM +0100, Douglas Raillard wrote:

> random idea: Since these things are much easier to understand by looking at a graph
> of util over time, we may agree on some mailing-list-friendly way to convey graphs.

I don't think that this patch warrants something like that. It is fairly
clear what it does.

For other stuff, maybe.

> For example, a simple CSV with:
> * before/after delimiters (line of # or =)
> * graph title
> * one point per signal transition, so that it can be plotted with gnuplot style "steps" or matplotlib drawstyle='steps-post'
> * consistent column names:
>    - time: in seconds (scientific notation for nanoseconds)
>    - activation: 1 when the task is actually running, 0 otherwise
>     (so it can be turned into transparent coloured bands like using gnuplot filledcurves, like in [1])
>    - util: util_avg of the task being talked about
> 
> The delimiters allow writing a scripts to render graphs directly out of an mbox file or ML archive URL.
> This won't solve the issue for the commit message itself, but that may ease the ML discussions.

Something like that could work; mutt can easily pipe emails into
scripts. OTOH gnuplot also has ASCII output, so one can easily stick
something like that into email.

