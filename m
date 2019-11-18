Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9375C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78EB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574085849;
	bh=av3AhznIp2gfPqs6mRCnuXdU7jr5kJV6P2YudnQ2ELk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=My5wTOuOhoAi4oE1w3LBWkn2jT+s4Ej9FIjYdtX18meRlRJzMXRzVRtH6vOIc/mlb
	 3pReyfVEW3jVP7DGW9w4aDHczcbDYSP2Jxb6nOMjaOgUGL4y9zLxWNYrAoRCCi+2ai
	 3cFjFbu93Aj34251AdPPed/IwWpACkS1hbMGLXn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKROEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:04:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:51048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbfKROEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:04:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9ECC6ADDD;
        Mon, 18 Nov 2019 14:04:06 +0000 (UTC)
Date:   Mon, 18 Nov 2019 15:04:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>, Rong Chen <rong.a.chen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3] memcg: add memcg lru
Message-ID: <20191118140405.GD14255@dhcp22.suse.cz>
References: <20191118125014.11516-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118125014.11516-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-11-19 20:50:14, Hillf Danton wrote:
> 
> On Mon, 18 Nov 2019 11:29:50 +0100 Michal Hocko wrote:
> > 
> > On Sun 17-11-19 19:35:26, Hillf Danton wrote:
> > > 
> > > Currently soft limit reclaim (slr) is frozen, see
> > > Documentation/admin-guide/cgroup-v2.rst for reasons.
> > > 
> > > This work adds memcg hook into kswapd's logic to bypass slr, paving
> > > a brick for its cleanup later.
> > > 
> > > After b23afb93d317 ("memcg: punt high overage reclaim to
> > > return-to-userland path"), high limit breachers (hlb) are reclaimed
> > > one after another spiraling up through the memcg hierarchy before
> > > returning to userspace.
> > > 
> > > The current memcg high work helps to add the lru because we get to
> > > collect hlb at zero price and in particular without adding changes
> > > to the high work's behavior.
> > > 
> > > Then a fifo list, which is essencially a simple copy of the page lru,
> > > is needed to facilitate queuing up hlb and ripping pages off them in
> > > round robin once kswapd starts doing its job.
> > > 
> > > Finally new hook is added with slr's two problems addressed i.e.
> > > hierarchy-unaware reclaim and overreclaim.
> > > 
> > > Thanks to Rong Chen for testing.
> > 
> Hey Michal
> 
> Thanks for your comments, this time and previous.
> 
> > You have ignored the previous review feedback again [1]. I have nacked
> > the patch on grounds that it is completely missing any real use case
> > scenario or any numbers suggesting there is an actual improvement.
> > 
> You are right though around half.
> 
> After another peep at your comment on v2, I think you didn't approve
> the change added in high work to defer reclaim until kswapd becomes
> active with good reasoning. That defer is cut in v3.

OK, that part was obviously broken in the previous version. But please
read the whole feedback I (and Johannes) have provided.
Besides that I would consider it polite to summarize the previous
version which received to NAKs from maintainers and explain why you
believe the code has addressed that problem.

> The added lru will take the place of the current slr, so slr's use
> cases apply to it with no exception, yes? Please feel free let us
> know what use cases else you may have interests in.

Let me ask differently. There must be a reason you have spent time on
developing this feature. There must be a usecase you are targetting.
Can you describe it so that we can evaluate pros and cons?
-- 
Michal Hocko
SUSE Labs
