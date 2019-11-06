Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA9BC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AD021848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfKFMDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:03:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:40712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729286AbfKFMDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:03:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33B8BB4E0;
        Wed,  6 Nov 2019 12:03:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 81CD01E4862; Wed,  6 Nov 2019 13:03:15 +0100 (CET)
Date:   Wed, 6 Nov 2019 13:03:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, snazy@snazy.de,
        Michal Hocko <mhocko@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191106120315.GF16085@quack2.suse.cz>
References: <20191025121104.GH17610@dhcp22.suse.cz>
 <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
 <20191025132700.GJ17610@dhcp22.suse.cz>
 <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
 <20191025135749.GK17610@dhcp22.suse.cz>
 <20191025140029.GL17610@dhcp22.suse.cz>
 <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
 <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
 <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
 <20191105182211.GA33242@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105182211.GA33242@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-11-19 13:22:11, Johannes Weiner wrote:
> On Tue, Nov 05, 2019 at 04:28:21PM +0100, Vlastimil Babka wrote:
> > On 11/5/19 2:23 PM, Robert Stupp wrote:
> > > "git bisect" led to a result.
> > > 
> > > The offending merge commit is f91f2ee54a21404fbc633550e99d69d14c2478f2
> > > "Merge branch 'akpm' (rest of patches from Andrew)".
> > > 
> > > The first bad commit in the merged series of commits is
> > > https://github.com/torvalds/linux/commit/6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11
> > > . a75d4c33377277b6034dd1e2663bce444f952c14, the commit before 6b4c9f44,
> > > is good.
> > 
> > Ah, great you could bisect this. CCing people from the commit
> > 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")
> 
> Judging from Robert's stack captures, the task is not hung but
> busy-looping in __mm_populate(). AFAICS, the only way this can occur
> is if populate_vma_page_range() returns 0 and we don't advance the
> iteration position (if it returned an error, we wouldn't reset nend
> and move on to the next vma as ignore_errors is 1 for mlockall.)
> 
> populate_vma_page_range() returns 0 when the first page is not found
> and faultin_page() returns -EBUSY (if it were processing pages, or if
> the error from faultin_page() would be a different one, we would
> return the number of pages processed or -error).
> 
> faultin_page() returns -EBUSY when VM_FAULT_RETRY is set, i.e. we
> dropped the mmap_sem in order to initiate IO and require a retry. That
> is consistent with the bisect result (new VM_FAULT_RETRY conditions).
> 
> At this point, regular page fault would retry with FAULT_FLAG_TRIED to
> indicate that the mmap_sem cannot be dropped a second time. But this
> mlock path doesn't set that flag and we can loop repeatedly. That is
> something we probably need to fix with a FOLL_TRIED somewhere.

It seems we could use __get_user_pages_locked() for that in
populate_vma_page_range() if we were guaranteed that mm stays alive.  This
is guaranteed for current->mm cases but there seem to be some callers to
populate_vma_page_range() where mm could indeed go away once we drop
mmap_sem. These luckily pass NULL for the 'nonblocking' parameter though so
all call sites seem to be fine but it would be fragile...

> What I don't quite understand yet is why the fault path doesn't make
> progress eventually. We must drop the mmap_sem without changing the
> state in any way. How can we keep looping on the same page?

That may be a slight suboptimality with Josef's patches. If the page
is marked as PageReadahead, we always drop mmap_sem if we can and start
readahead without checking whether that makes sense or not in
do_async_mmap_readahead(). OTOH page_cache_async_readahead() then clears
PageReadahead so the only way how I can see we could loop like this is when
file->ra->ra_pages is 0. Not sure if that's what's happening through. We'd
need to find which of the paths in filemap_fault() calls
maybe_unlock_mmap_for_io() to tell more.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
