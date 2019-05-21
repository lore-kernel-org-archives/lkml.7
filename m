Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA76C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D896208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfEUPlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:41:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfEUPlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:41:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7524F30BB532;
        Tue, 21 May 2019 15:41:05 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE28453786;
        Tue, 21 May 2019 15:41:00 +0000 (UTC)
Date:   Tue, 21 May 2019 11:40:59 -0400
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
Message-ID: <20190521154059.GC3836@redhat.com>
References: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
 <20190520213945.17046-4-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520213945.17046-4-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 21 May 2019 15:41:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 11:39:45PM +0200, Daniel Vetter wrote:
> This is a similar idea to the fs_reclaim fake lockdep lock. It's
> fairly easy to provoke a specific notifier to be run on a specific
> range: Just prep it, and then munmap() it.
> 
> A bit harder, but still doable, is to provoke the mmu notifiers for
> all the various callchains that might lead to them. But both at the
> same time is really hard to reliable hit, especially when you want to
> exercise paths like direct reclaim or compaction, where it's not
> easy to control what exactly will be unmapped.
> 
> By introducing a lockdep map to tie them all together we allow lockdep
> to see a lot more dependencies, without having to actually hit them
> in a single challchain while testing.
> 
> Aside: Since I typed this to test i915 mmu notifiers I've only rolled
> this out for the invaliate_range_start callback. If there's
> interest, we should probably roll this out to all of them. But my
> undestanding of core mm is seriously lacking, and I'm not clear on
> whether we need a lockdep map for each callback, or whether some can
> be shared.

I need to read more on lockdep but it is legal to have mmu notifier
invalidation within each other. For instance when you munmap you
might split a huge pmd and it will trigger a second invalidate range
while the munmap one is not done yet. Would that trigger the lockdep
here ?

Worst case i can think of is 2 invalidate_range_start chain one after
the other. I don't think you can triggers a 3 levels nesting but maybe.

Cheers,
Jérôme
