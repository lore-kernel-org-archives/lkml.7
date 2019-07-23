Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF93C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD1021842
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0+NQ0ipb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbfGWOJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:09:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44556 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfGWOJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0cYM+DTV87A8Im7WmiAo3ahAlUZLht+ioCM/P9jm3xs=; b=0+NQ0ipbp40HPoN0bwsD2IYm7
        TfJzAW4ifIJutuHCj6ueh2ldmzZ2/b4fFjh9Rty4XUAJdKZOhbBSSfXc6vuslcM3pv9jCc3m5JT2K
        Vy4g0XeRl5LpHOoRHY3+3nUFth7JciMPKdQuve2eQ4nA/EoTdcX5ULyz9/HZ01mB8rcA1Sc7Nj1DW
        c8rBo7GW97AHCT03RP7HZPWZminaufXvmV/BPldP0NxR3NdHKRmz+uQwt3XWhDO/9tCpfkKfb/bnj
        HqZOnp7k5hDi9CCP5P3ciVZ2+8LBnPIJbDqVD4/mzxP/efxhqfIBQlPrS8J5IgH11MI6te7Ehoms6
        6l8oJv2MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpvTY-0008UM-66; Tue, 23 Jul 2019 14:09:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2636201A93DD; Tue, 23 Jul 2019 16:09:05 +0200 (CEST)
Date:   Tue, 23 Jul 2019 16:09:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Matt Fleming <matt@codeblueprint.co.uk>,
        linux-kernel@vger.kernel.org,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20190723140905.GF3402@hirez.programming.kicks-ass.net>
References: <20190723104830.26623-1-matt@codeblueprint.co.uk>
 <20190723114248.GJ24383@techsingularity.net>
 <20190723120030.GN3419@hirez.programming.kicks-ass.net>
 <20190723130321.GK24383@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723130321.GK24383@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 02:03:21PM +0100, Mel Gorman wrote:
> On Tue, Jul 23, 2019 at 02:00:30PM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 23, 2019 at 12:42:48PM +0100, Mel Gorman wrote:
> > > On Tue, Jul 23, 2019 at 11:48:30AM +0100, Matt Fleming wrote:
> > > > Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
> > > > Cc: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
> > > > Cc: Mel Gorman <mgorman@techsingularity.net>
> > > > Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
> > > > Cc: Borislav Petkov <bp@alien8.de>
> > > 
> > > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> > > 
> > > The only caveat I can think of is that a future generation of Zen might
> > > take a different magic number than 32 as their remote distance. If or
> > > when this happens, it'll need additional smarts but lacking a crystal
> > > ball, we can cross that bridge when we come to it.
> > 
> > I just suggested to Matt on IRC we could do something along these lines,
> > but we can do that later.
> > 
> 
> That would seem fair but I do think it's something that could be done
> later (maybe 1 release away?) to avoid a false bisection to this patch by
> accident.

Quite agreed; changing reclaim_distance like that will affect a lot of
hardware, while the current patch limits the impact to just AMD-Zen
based bits.

> I don't *think* there are any machines out there with a 1-hop
> distance of 14 but if there is, your patch would make a difference to
> MM behaviour.  In the same context, it might make sense to rename the
> value to somewhat reflective of the fact that "reclaim distance" affects
> scheduler placement. No good name springs to mind at the moment.

Yeah, naming sucks. Let us pain this bicycle shed blue!
