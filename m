Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD571C47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40DC21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571818654;
	bh=BDMFWHG3Kt7jaqZQSx7QireHmRIcFf1sD41ptqhksHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kiKM5s6q7doFsi3ddp4SZeeMRl07bYdX/AwD8FBYx2cyHVo/A2wddLI9Ie23krJp2
	 r1ayc/eDPud3F/rlJS62XhpZw14EHRTKQyD5J4f8yg0O6yMH2S01pGSUQYLZ9QK8nS
	 Qs/tYUvXgwwVkOoKBqvx03zk5m9Et8AdavGWj5ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390230AbfJWIRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:17:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:55066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390050AbfJWIRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:17:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15D43C167;
        Wed, 23 Oct 2019 08:17:30 +0000 (UTC)
Date:   Wed, 23 Oct 2019 10:17:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC v1] mm: add page preemption
Message-ID: <20191023081729.GI754@dhcp22.suse.cz>
References: <20191020134304.11700-1-hdanton@sina.com>
 <20191022121439.7164-1-hdanton@sina.com>
 <20191022142802.14304-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022142802.14304-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 22:28:02, Hillf Danton wrote:
> 
> On Tue, 22 Oct 2019 14:42:41 +0200 Michal Hocko wrote:
> > 
> > On Tue 22-10-19 20:14:39, Hillf Danton wrote:
> > > 
> > > On Mon, 21 Oct 2019 14:27:28 +0200 Michal Hocko wrote:
> > [...]
> > > > Why do we care and which workloads would benefit and how much.
> > > 
> > > Page preemption, disabled by default, should be turned on by those
> > > who wish that the performance of their workloads can survive memory
> > > pressure to certain extent.
> > 
> > I am sorry but this doesn't say anything to me. How come not all
> > workloads would fit that description?
> 
> That means pp plays a role when kswapd becomes active, and it may
> prevent too much jitters in active lru pages.

This is still too vague to be useful in any way.

> > > The number of pp users is supposed near the people who change the
> > > nice value of their apps either to -1 or higher at least once a week,
> > > less than vi users among UK's undergraduates.
> > > 
> > > > And last but not least why the existing infrastructure doesn't help
> > > > (e.g. if you have clearly defined workloads with different
> > > > memory consumption requirements then why don't you use memory cgroups to
> > > > reflect the priority).
> > > 
> > > Good question:)
> > > 
> > > Though pp is implemented by preventing any task from reclaiming as many
> > > pages as possible from other tasks that are higher on priority, it is
> > > trying to introduce prio into page reclaiming, to add a feature.
> > > 
> > > Page and memcg are different objects after all; pp is being added at
> > > the page granularity. It should be an option available in environments
> > > without memcg enabled.
> > 
> > So do you actually want to establish LRUs per priority?
> 
> No, no change other than the prio for every lru page was added. LRU per prio
> is too much to implement.

Well, considering that per page priority is a no go as already pointed
out by Willy then you do not have other choice right?

> > Why using memcgs is not an option?
> 
> I have plan to add prio in memcg. As you see, I sent a rfc before v0 with
> nice added in memcg, and realised a couple days ago that its dependence on
> soft limit reclaim is not acceptable.
> 
> But we can't do that without determining how to define memcg's prio.
> What is in mind now is the highest (or lowest) prio of tasks in a memcg
> with a knob offered to userspace.
> 
> If you like, I want to have a talk about it sometime later.

This doesn't really answer my question. Why cannot you use memcgs as
they are now. Why exactly do you need a fixed priority?

> > This is the main facility to partition reclaimable
> > memory in the first place. You should really focus on explaining on why
> > a much more fine grained control is needed much more thoroughly.
> > 
> > > What is way different from the protections offered by memory cgroup
> > > is that pages protected by memcg:min/low can't be reclaimed regardless
> > > of memory pressure. Such guarantee is not available under pp as it only
> > > suggests an extra factor to consider on deactivating lru pages.
> > 
> > Well, low limit can be breached if there is no eliglible memcg to be
> > reclaimed. That means that you can shape some sort of priority by
> > setting the low limit already.
> > 
> > [...]
> > 
> > > What was added on the reclaimer side is
> > > 
> > > 1, kswapd sets pgdat->kswapd_prio, the switch between page reclaimer
> > >    and allocator in terms of prio, to the lowest value before taking
> > >    a nap.
> > > 
> > > 2, any allocator is able to wake up the reclaimer because of the
> > >    lowest prio, and it starts reclaiming pages using the waker's prio.
> > > 
> > > 3, allocator comes while kswapd is active, its prio is checked and
> > >    no-op if kswapd is higher on prio; otherwise switch is updated
> > >    with the higher prio.
> > > 
> > > 4, every time kswapd raises sc.priority that starts with DEF_PRIORITY,
> > >    it is checked if there is pending update of switch; and kswapd's
> > >    prio steps up if there is a pending one, thus its prio never steps
> > >    down. Nor prio inversion. 
> > > 
> > > 5, goto 1 when kswapd finishes its work.
> > 
> > What about the direct reclaim?
> 
> Their prio will not change before reclaiming finishes, so leave it be.

This doesn't answer my question.

> > What if pages of a lower priority are
> > hard to reclaim? Do you want a process of a higher priority stall more
> > just because it has to wait for those lower priority pages?
> 
> The problems above are not introduced by pp, let Mr. Kswapd take care of
> them.

No, this is not an answer.

-- 
Michal Hocko
SUSE Labs
