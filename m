Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E76C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B93D218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390050AbfGWND0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:03:26 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:54464 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731916AbfGWND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:03:26 -0400
Received: from mail.blacknight.com (unknown [81.17.254.26])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id E59A1D0239
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 14:03:23 +0100 (IST)
Received: (qmail 32687 invoked from network); 23 Jul 2019 13:03:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.36])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Jul 2019 13:03:23 -0000
Date:   Tue, 23 Jul 2019 14:03:21 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Matt Fleming <matt@codeblueprint.co.uk>,
        linux-kernel@vger.kernel.org,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20190723130321.GK24383@techsingularity.net>
References: <20190723104830.26623-1-matt@codeblueprint.co.uk>
 <20190723114248.GJ24383@techsingularity.net>
 <20190723120030.GN3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190723120030.GN3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 02:00:30PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 23, 2019 at 12:42:48PM +0100, Mel Gorman wrote:
> > On Tue, Jul 23, 2019 at 11:48:30AM +0100, Matt Fleming wrote:
> > > Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
> > > Cc: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
> > > Cc: Mel Gorman <mgorman@techsingularity.net>
> > > Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > 
> > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> > 
> > The only caveat I can think of is that a future generation of Zen might
> > take a different magic number than 32 as their remote distance. If or
> > when this happens, it'll need additional smarts but lacking a crystal
> > ball, we can cross that bridge when we come to it.
> 
> I just suggested to Matt on IRC we could do something along these lines,
> but we can do that later.
> 

That would seem fair but I do think it's something that could be done
later (maybe 1 release away?) to avoid a false bisection to this patch by
accident. I don't *think* there are any machines out there with a 1-hop
distance of 14 but if there is, your patch would make a difference to
MM behaviour.  In the same context, it might make sense to rename the
value to somewhat reflective of the fact that "reclaim distance" affects
scheduler placement. No good name springs to mind at the moment.

-- 
Mel Gorman
SUSE Labs
