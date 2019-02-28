Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFF6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDC8218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551347575;
	bh=Quo/ncyBcu9f8EyMJ01167BeFKDVnbj7qd+r6QKekiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I22WHNGgo0cCeJSxT3Sj/ZcSnf0hWFWMlaul+6t9QlBJyzJW+jmFmWndAM6/dquUo
	 586mXKha//0HWPf8rQAOfkb2QVHNl3IOz0V3JmaSZQWE/fFV+ptshCouq7NdJ9Y5ZS
	 AGd7UiXNf/lbEeWQ39a4OWw2Z4/IZ74eWuybxXCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfB1Jwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:52:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:57742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbfB1Jwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:52:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87261AEB3;
        Thu, 28 Feb 2019 09:52:51 +0000 (UTC)
Date:   Thu, 28 Feb 2019 10:52:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: Throttle allocators when failing reclaim over
 memory.high
Message-ID: <20190228095250.GA21078@dhcp22.suse.cz>
References: <20190201011352.GA14370@chrisdown.name>
 <20190201071757.GE11599@dhcp22.suse.cz>
 <20190201161233.GA11231@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201161233.GA11231@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for a late reply]

On Fri 01-02-19 11:12:33, Johannes Weiner wrote:
> On Fri, Feb 01, 2019 at 08:17:57AM +0100, Michal Hocko wrote:
> > On Thu 31-01-19 20:13:52, Chris Down wrote:
> > [...]
> > > The current situation goes against both the expectations of users of
> > > memory.high, and our intentions as cgroup v2 developers. In
> > > cgroup-v2.txt, we claim that we will throttle and only under "extreme
> > > conditions" will memory.high protection be breached. Likewise, cgroup v2
> > > users generally also expect that memory.high should throttle workloads
> > > as they exceed their high threshold. However, as seen above, this isn't
> > > always how it works in practice -- even on banal setups like those with
> > > no swap, or where swap has become exhausted, we can end up with
> > > memory.high being breached and us having no weapons left in our arsenal
> > > to combat runaway growth with, since reclaim is futile.
> > > 
> > > It's also hard for system monitoring software or users to tell how bad
> > > the situation is, as "high" events for the memcg may in some cases be
> > > benign, and in others be catastrophic. The current status quo is that we
> > > fail containment in a way that doesn't provide any advance warning that
> > > things are about to go horribly wrong (for example, we are about to
> > > invoke the kernel OOM killer).
> > > 
> > > This patch introduces explicit throttling when reclaim is failing to
> > > keep memcg size contained at the memory.high setting. It does so by
> > > applying an exponential delay curve derived from the memcg's overage
> > > compared to memory.high.  In the normal case where the memcg is either
> > > below or only marginally over its memory.high setting, no throttling
> > > will be performed.
> > 
> > How does this play wit the actual OOM when the user expects oom to
> > resolve the situation because the reclaim is futile and there is nothing
> > reclaimable except for killing a process?
> 
> Hm, can you elaborate on your question a bit?
> 
> The idea behind memory.high is to throttle allocations long enough for
> the admin or a management daemon to intervene, but not to trigger the
> kernel oom killer. It was designed as a replacement for the cgroup1
> oom_control, but without the deadlock potential, ptrace problems etc.

Yes, this makes sense. The high limit reclaim is also documented as a
best effort resource guarantee. My understanding is that if the workload
cannot be contained within the high limit then the system cannot do much
and eventually gives up. Having the full memory unreclaimable is such an
example. And there is either the global OOM killer or hard limit OOM
killer to trigger to resolve such a situation.

[...]
Thanks for describing the usecase.

> Right now, that throttling mechanism works okay with swap enabled, but
> we cannot enable swap everywhere, or sometimes run out of swap, and
> then it breaks down and we run into system OOMs.
> 
> This patch makes sure memory.high *always* implements the throttling
> semantics described in cgroup-v2.txt, not just most of the time.

I am not really opposed to the throttling in the absence of a
reclaimable memory. We do that for the regular allocation paths already
(should_reclaim_retry). A swapless system with anon memory is very
likely to oom too quickly and this sounds like a real problem. But I do
not think that we should throttle the allocation to freeze it
completely. We should eventually OOM. And that was my question about
essentially. How much we can/should throttle to give a high limit events
consumer enough time to intervene. I am sorry to still not have time to
study the patch more closely but this should be explained in the
changelog. Are we talking about seconds/minutes or simply freeze each
allocator to death?
-- 
Michal Hocko
SUSE Labs
