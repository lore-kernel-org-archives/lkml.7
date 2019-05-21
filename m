Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AE8C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628DB2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfEUQci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:32:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbfEUQci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:32:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D9CD5947D;
        Tue, 21 May 2019 16:32:30 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0CEB1001E6C;
        Tue, 21 May 2019 16:32:26 +0000 (UTC)
Date:   Tue, 21 May 2019 12:32:24 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 4/4] mm, notifier: Add a lockdep map for
 invalidate_range_start
Message-ID: <20190521163224.GE3836@redhat.com>
References: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
 <20190520213945.17046-4-daniel.vetter@ffwll.ch>
 <20190521154059.GC3836@redhat.com>
 <CAKMK7uEaKJiT__=dt=ROUP4Kkq1NgwScLJFQcMuBs2GYjMWOLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uEaKJiT__=dt=ROUP4Kkq1NgwScLJFQcMuBs2GYjMWOLw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 21 May 2019 16:32:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 06:00:36PM +0200, Daniel Vetter wrote:
> On Tue, May 21, 2019 at 5:41 PM Jerome Glisse <jglisse@redhat.com> wrote:
> >
> > On Mon, May 20, 2019 at 11:39:45PM +0200, Daniel Vetter wrote:
> > > This is a similar idea to the fs_reclaim fake lockdep lock. It's
> > > fairly easy to provoke a specific notifier to be run on a specific
> > > range: Just prep it, and then munmap() it.
> > >
> > > A bit harder, but still doable, is to provoke the mmu notifiers for
> > > all the various callchains that might lead to them. But both at the
> > > same time is really hard to reliable hit, especially when you want to
> > > exercise paths like direct reclaim or compaction, where it's not
> > > easy to control what exactly will be unmapped.
> > >
> > > By introducing a lockdep map to tie them all together we allow lockdep
> > > to see a lot more dependencies, without having to actually hit them
> > > in a single challchain while testing.
> > >
> > > Aside: Since I typed this to test i915 mmu notifiers I've only rolled
> > > this out for the invaliate_range_start callback. If there's
> > > interest, we should probably roll this out to all of them. But my
> > > undestanding of core mm is seriously lacking, and I'm not clear on
> > > whether we need a lockdep map for each callback, or whether some can
> > > be shared.
> >
> > I need to read more on lockdep but it is legal to have mmu notifier
> > invalidation within each other. For instance when you munmap you
> > might split a huge pmd and it will trigger a second invalidate range
> > while the munmap one is not done yet. Would that trigger the lockdep
> > here ?
> 
> Depends how it's nesting. I'm wrapping the annotation only just around
> the individual mmu notifier callback, so if the nesting is just
> - munmap starts
> - invalidate_range_start #1
> - we noticed that there's a huge pmd we need to split
> - invalidate_range_start #2
> - invalidate_reange_end #2
> - invalidate_range_end #1
> - munmap is done

Yeah this is how it looks. All the callback from range_start #1 would
happens before range_start #2 happens so we should be fine.

> 
> But if otoh it's ok to trigger the 2nd invalidate range from within an
> mmu_notifier->invalidate_range_start callback, then lockdep will be
> pissed about that.

No that would be illegal for a callback to do that. There is no existing
callback that would do that at least AFAIK. So we can just say that it
is illegal. I would not see the point.

> 
> > Worst case i can think of is 2 invalidate_range_start chain one after
> > the other. I don't think you can triggers a 3 levels nesting but maybe.
> 
> Lockdep has special nesting annotations. I think it'd be more an issue
> of getting those funneled through the entire call chain, assuming we
> really need that.

I think we are fine. So this patch looks good.

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
