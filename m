Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F89C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28EE2341D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567577752;
	bh=sSf0iY0ZsxGlWWy/h3qWcBXV1FJOSyd0uy/5Xz+VZLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wpynuozf9s6TFtC7zbHKXuk08VmzFAFrcFqGtwSXrAOSG5vOaAU75VDA506dsrkS9
	 SE0bkc4BCY/jfBYkZd4C2ofvt9Oa2U0UedRy0Kcj+1ous/tAmAnwn4VWsXTUTPfWw8
	 4BwgipN4GvqxG90syPOoqKB9MJisL4Yr70iXNASI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfIDGPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:15:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:33542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfIDGPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:15:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA5DBAE65;
        Wed,  4 Sep 2019 06:15:49 +0000 (UTC)
Date:   Wed, 4 Sep 2019 08:15:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/skbuff: silence warnings under memory pressure
Message-ID: <20190904061548.GC3838@dhcp22.suse.cz>
References: <1567177025-11016-1-git-send-email-cai@lca.pw>
 <6109dab4-4061-8fee-96ac-320adf94e130@gmail.com>
 <1567178728.5576.32.camel@lca.pw>
 <229ebc3b-1c7e-474f-36f9-0fa603b889fb@gmail.com>
 <20190903132231.GC18939@dhcp22.suse.cz>
 <1567525342.5576.60.camel@lca.pw>
 <20190903185305.GA14028@dhcp22.suse.cz>
 <1567546948.5576.68.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567546948.5576.68.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2019-09-03 at 20:53 +0200, Michal Hocko wrote:
> > On Tue 03-09-19 11:42:22, Qian Cai wrote:
> > > On Tue, 2019-09-03 at 15:22 +0200, Michal Hocko wrote:
> > > > On Fri 30-08-19 18:15:22, Eric Dumazet wrote:
> > > > > If there is a risk of flooding the syslog, we should fix this
> > > > > generically
> > > > > in mm layer, not adding hundred of __GFP_NOWARN all over the places.
> > > > 
> > > > We do already ratelimit in warn_alloc. If it isn't sufficient then we
> > > > can think of a different parameters. Or maybe it is the ratelimiting
> > > > which doesn't work here. Hard to tell and something to explore.
> > > 
> > > The time-based ratelimit won't work for skb_build() as when a system under
> > > memory pressure, and the CPU is fast and IO is so slow, it could take a long
> > > time to swap and trigger OOM.
> > 
> > I really do not understand what does OOM and swapping have to do with
> > the ratelimiting here. The sole purpose of the ratelimit is to reduce
> > the amount of warnings to be printed. Slow IO might have an effect on
> > when the OOM killer is invoked but atomic allocations are not directly
> > dependent on IO.
> 
> When there is a heavy memory pressure, the system is trying hard to reclaim
> memory to fill up the watermark. However, the IO is slow to page out, but the
> memory pressure keep draining atomic reservoir, and some of those skb_build()
> will fail eventually.

Yes this is true but this has nothing to do with the ratelimitted
warn_alloc AFAICS. It is natural that atomic allocations are going
to fail more likely under extreme memory pressure but we are talking
about an excessive amount of debugging output that is generated and
that should be throttled. And that's why we have ratelimit there. If it
doesn't work well then we should look into why.

> Only if there is a fast IO, it will finish swapping sooner and then invoke the
> OOM to end the memory pressure.
-- 
Michal Hocko
SUSE Labs
