Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60739CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3375720874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xgSb9VSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbfJ2NCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:02:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40124 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387901AbfJ2NCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TXp6GtZA1fnB+a0OnStAdqw3GTFynTzXAdUuYTPfr54=; b=xgSb9VSYh5Q85Nh4M/recBLR7
        4U/fKWmRlBQOG6yrhqwqxQPlG12WuXdub/XrZZvPjEuwh0gWIA6HWGWv/oDftAWPl98mRNYRxJESM
        zQd5XSGZIrLC7DvrFzTGHfo3xMqaoqJai6oOHLbWKqzkDfJ+OIfHC6tkCaYeLXUre1ziCukLiEHcB
        KBB8o91Cf6iReoBUYGYVLe3yuNNFMu+INako3SUceAZw2Qrp+fu8wCmPw4vMCcDmNB1caurduO/Mg
        NXTocc55dVJjeyX3hYd11gCjmnH2hXs0xzTzCx+rFo3+qFl4h2nTElRRPskKmOlyHxvulzBxHdf0v
        6zB5OA0dw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPR8g-00008h-HL; Tue, 29 Oct 2019 13:02:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 960DE30025A;
        Tue, 29 Oct 2019 14:01:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 345C920D7FEFA; Tue, 29 Oct 2019 14:02:19 +0100 (CET)
Date:   Tue, 29 Oct 2019 14:02:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191029130219.GN4114@hirez.programming.kicks-ass.net>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <CAKfTPtA6Fvc374oTfbHYkviAJbZebHkBg=w2O3f0oZ0m3ujVjA@mail.gmail.com>
 <20191029110224.awoi37pdquachqtd@e107158-lin.cambridge.arm.com>
 <CAKfTPtA=CzkTVwdCJL6ULYB628tWdGAvpD-sHfgSfL59PyYvxA@mail.gmail.com>
 <20191029114824.2kb4fygxxx72r3in@e107158-lin.cambridge.arm.com>
 <CAKfTPtD7e-dXhZ3mG36igArt=0f-mNc52vaJ1bb-jv5zB9bkgg@mail.gmail.com>
 <20191029124630.ivfbpenue3fw33qt@e107158-lin.cambridge.arm.com>
 <CAKfTPtDnt6oh7X6dGnPUn70sLJXAQoxdkn0GCwdPvA8G4Wg0fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDnt6oh7X6dGnPUn70sLJXAQoxdkn0GCwdPvA8G4Wg0fA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 01:54:24PM +0100, Vincent Guittot wrote:
> On Tue, 29 Oct 2019 at 13:46, Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 10/29/19 13:20, Vincent Guittot wrote:
> > > > > Making big cores the default CPUs for all RT tasks is not a minor
> > > > > change and IMO locality should stay the default behavior when there is
> > > > > no uclamp constraint
> > > >
> > > > How this is affecting locality? The task will always go to the big core, so it
> > > > should be local.
> > >
> > > local with the waker
> > > You will force rt task to run on big cluster although waker, data and
> > > interrupts can be on little one.
> > > So making big core as default is far from always being the best choice
> >
> > This is loaded with assumptions IMO. AFAICT we don't know what's the best
> > choice.
> >
> > First, the value of uclamp.min is outside of the scope of this patch. Unless
> > what you're saying is that when uclamp.min is 1024 then we should NOT choose a
> > big cpu then there's no disagreement about what this patch do. If that's what
> > you're objecting to please be more specific about how do you see this working
> > instead.
> 
> My point is that this patch makes the big cores the default CPUs for
> RT tasks which is far from being a minor change and far from being an
> obvious default good choice

FIFO/RR tasks don't have a bandwidth specification (barring uclamp),
therefore we must assume the worst. This is the same principle that has
them select max_freq all the time.

I think it is a very natural extention of that very principle to place
(otherwise unconstrained RT tasks) on big cores.

