Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008F8C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBA520B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565075164;
	bh=Gh3oboFgr6PHbpKCtqBd7R+1JZfe8W30Q3qnEeexxmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yxRkkLF1lW+mcx4nzkZih4We4qkSZ6xSa+YRfMiwBJCwrVZQkNkkAK04VcVgZADbb
	 7oxwlvcFsCzc6f2BidLRD/T1BRK67TsbZbOSWstuOKYEx2UYN3gg++7+Jy0sHbaG65
	 BYd5HXVRhmQ/7oosa+qzLqB1k5Gx+t8AhM2XCYV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbfHFHGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:06:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:53950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731711AbfHFHF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:05:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 048C9AE34;
        Tue,  6 Aug 2019 07:05:55 +0000 (UTC)
Date:   Tue, 6 Aug 2019 09:05:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
Message-ID: <20190806070554.GA11812@dhcp22.suse.cz>
References: <20190729091738.GF9330@dhcp22.suse.cz>
 <3d6fc779-2081-ba4b-22cf-be701d617bb4@yandex-team.ru>
 <20190729103307.GG9330@dhcp22.suse.cz>
 <CAHbLzkrdj-O2uXwM8ujm90OcgjyR4nAiEbFtRGe7SOoY_fs=BA@mail.gmail.com>
 <20190729184850.GH9330@dhcp22.suse.cz>
 <CAHbLzkp9xFV2sE0TdKfWNRVcAwaYNKwDugRiBBoEKx6A_Hr3Jw@mail.gmail.com>
 <20190802093507.GF6461@dhcp22.suse.cz>
 <CAHbLzkrjh7KEvdfXackaVy8oW5CU=UaBucERffxcUorgq1vdoA@mail.gmail.com>
 <20190805143239.GS7597@dhcp22.suse.cz>
 <CAHbLzkpD+kawkR42mWpxvZHvSZNhYEsibiMYzx+3q0rTBS6L9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpD+kawkR42mWpxvZHvSZNhYEsibiMYzx+3q0rTBS6L9g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-08-19 20:28:40, Yang Shi wrote:
> On Mon, Aug 5, 2019 at 7:32 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 02-08-19 11:56:28, Yang Shi wrote:
> > > On Fri, Aug 2, 2019 at 2:35 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Thu 01-08-19 14:00:51, Yang Shi wrote:
> > > > > On Mon, Jul 29, 2019 at 11:48 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > > >
> > > > > > On Mon 29-07-19 10:28:43, Yang Shi wrote:
> > > > > > [...]
> > > > > > > I don't worry too much about scale since the scale issue is not unique
> > > > > > > to background reclaim, direct reclaim may run into the same problem.
> > > > > >
> > > > > > Just to clarify. By scaling problem I mean 1:1 kswapd thread to memcg.
> > > > > > You can have thousands of memcgs and I do not think we really do want
> > > > > > to create one kswapd for each. Once we have a kswapd thread pool then we
> > > > > > get into a tricky land where a determinism/fairness would be non trivial
> > > > > > to achieve. Direct reclaim, on the other hand is bound by the workload
> > > > > > itself.
> > > > >
> > > > > Yes, I agree thread pool would introduce more latency than dedicated
> > > > > kswapd thread. But, it looks not that bad in our test. When memory
> > > > > allocation is fast, even though dedicated kswapd thread can't catch
> > > > > up. So, such background reclaim is best effort, not guaranteed.
> > > > >
> > > > > I don't quite get what you mean about fairness. Do you mean they may
> > > > > spend excessive cpu time then cause other processes starvation? I
> > > > > think this could be mitigated by properly organizing and setting
> > > > > groups. But, I agree this is tricky.
> > > >
> > > > No, I meant that the cost of reclaiming a unit of charges (e.g.
> > > > SWAP_CLUSTER_MAX) is not constant and depends on the state of the memory
> > > > on LRUs. Therefore any thread pool mechanism would lead to unfair
> > > > reclaim and non-deterministic behavior.
> > >
> > > Yes, the cost depends on the state of pages, but I still don't quite
> > > understand what does "unfair" refer to in this context. Do you mean
> > > some cgroups may reclaim much more than others?
> >
> > > Or the work may take too long so it can't not serve other cgroups in time?
> >
> > exactly.
> 
> Actually, I'm not very concerned by this. In our design each memcg has
> its dedicated work (memcg->wmark_work), so the reclaim work for
> different memcgs could be run in parallel since they are *different*
> work in fact although they run the same function. And, We could queue
> them to a dedicated unbound workqueue which may have maximum 512 or
> scale with nr cpus active works. Although the system may have
> thousands of online memcgs, I'm supposed it should be rare to have all
> of them trigger reclaim at the same time.

I do believe that it might work for your particular usecase but I do not
think this is robust enough for the upstream kernel, I am afraid.

As I've said I am open to discuss an opt-in per memcg pro-active reclaim
(a kernel thread that belongs to the memcg) but it has to be a dedicated
worker bound by all the cgroup resource restrictions.

-- 
Michal Hocko
SUSE Labs
