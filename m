Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E948DCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C109D2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390969AbfJWJ4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:56:15 -0400
Received: from outbound-smtp21.blacknight.com ([81.17.249.41]:46754 "EHLO
        outbound-smtp21.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390952AbfJWJ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:56:13 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id 4D617B8781
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 10:56:11 +0100 (IST)
Received: (qmail 9435 invoked from network); 23 Oct 2019 09:56:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Oct 2019 09:56:11 -0000
Date:   Wed, 23 Oct 2019 10:56:08 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
Message-ID: <20191023095607.GE3016@techsingularity.net>
References: <20191022162156.17316-1-longman@redhat.com>
 <20191022165745.GT9379@dhcp22.suse.cz>
 <20191023083143.GC3016@techsingularity.net>
 <20191023090422.GK754@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191023090422.GK754@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:04:22AM +0200, Michal Hocko wrote:
> On Wed 23-10-19 09:31:43, Mel Gorman wrote:
> > On Tue, Oct 22, 2019 at 06:57:45PM +0200, Michal Hocko wrote:
> > > [Cc Mel]
> > > 
> > > On Tue 22-10-19 12:21:56, Waiman Long wrote:
> > > > The pagetypeinfo_showfree_print() function prints out the number of
> > > > free blocks for each of the page orders and migrate types. The current
> > > > code just iterates the each of the free lists to get counts.  There are
> > > > bug reports about hard lockup panics when reading the /proc/pagetyeinfo
> > > > file just because it look too long to iterate all the free lists within
> > > > a zone while holing the zone lock with irq disabled.
> > > > 
> > > > Given the fact that /proc/pagetypeinfo is readable by all, the possiblity
> > > > of crashing a system by the simple act of reading /proc/pagetypeinfo
> > > > by any user is a security problem that needs to be addressed.
> > > 
> > > Should we make the file 0400? It is a useful thing when debugging but
> > > not something regular users would really need for life.
> > > 
> > 
> > I think this would be useful in general. The information is not that
> > useful outside of debugging. Even then it's only useful when trying to
> > get a handle on why a path like compaction is taking too long.
> 
> So can we go with this to address the security aspect of this and have
> something trivial to backport.
> 

Yes.

> > > > There is a free_area structure associated with each page order. There
> > > > is also a nr_free count within the free_area for all the different
> > > > migration types combined. Tracking the number of free list entries
> > > > for each migration type will probably add some overhead to the fast
> > > > paths like moving pages from one migration type to another which may
> > > > not be desirable.
> > > 
> > > Have you tried to measure that overhead?
> > >  
> > 
> > I would prefer this option not be taken. It would increase the cost of
> > watermark calculations which is a relatively fast path.
> 
> Is the change for the wmark check going to require more than
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c0b2e0306720..5d95313ba4a5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3448,9 +3448,6 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
>  		struct free_area *area = &z->free_area[o];
>  		int mt;
>  
> -		if (!area->nr_free)
> -			continue;
> -
>  		for (mt = 0; mt < MIGRATE_PCPTYPES; mt++) {
>  			if (!free_area_empty(area, mt))
>  				return true;
> 
> Is this really going to be visible in practice? Sure we are going to do
> more checks but most orders tend to have at least some memory in a
> reasonably balanced system and we can hardly expect an optimal
> allocation path on those that are not.
>  

You also have to iterate over them all later in the same function.  The the
free counts are per migrate type then they would have to be iterated over
every time.

Similarly, there would be multiple places where all the counters would
have to be iterated -- find_suitable_fallback, show_free_areas,
fast_isolate_freepages, fill_contig_page_info, zone_init_free_lists etc.

It'd be a small cost but given that it's aimed at fixing a problem with
reading pagetypeinfo, is it really worth it? I don't think so.

> > > > we can actually skip iterating the list of one of the migration types
> > > > and used nr_free to compute the missing count. Since MIGRATE_MOVABLE
> > > > is usually the largest one on large memory systems, this is the one
> > > > to be skipped. Since the printing order is migration-type => order, we
> > > > will have to store the counts in an internal 2D array before printing
> > > > them out.
> > > > 
> > > > Even by skipping the MIGRATE_MOVABLE pages, we may still be holding the
> > > > zone lock for too long blocking out other zone lock waiters from being
> > > > run. This can be problematic for systems with large amount of memory.
> > > > So a check is added to temporarily release the lock and reschedule if
> > > > more than 64k of list entries have been iterated for each order. With
> > > > a MAX_ORDER of 11, the worst case will be iterating about 700k of list
> > > > entries before releasing the lock.
> > > 
> > > But you are still iterating through the whole free_list at once so if it
> > > gets really large then this is still possible. I think it would be
> > > preferable to use per migratetype nr_free if it doesn't cause any
> > > regressions.
> > > 
> > 
> > I think it will. The patch as it is contains the overhead within the
> > reader of the pagetypeinfo proc file which is a non-critical path. The
> > page allocator paths on the other hand is very important.
> 
> As pointed out in other email. The problem with this patch is that it
> hasn't really removed the iteration over the whole free_list which is
> the primary problem. So I think that we should either consider this a
> non-issue and make it "admin knows this is potentially expensive" or do
> something like Andrew was suggesting if we do not want to change the
> nr_free accounting.
> 

Again, the cost is when reading a proc file. From what Andrew said,
the lock is necessary to safely walk the list but if anything. I would
be ok with limiting the length of the walk but honestly, I would also
be ok with simply deleting the proc file. The utility for debugging a
problem with it is limited now (it was more important when fragmentation
avoidance was first introduced) and there is little an admin can do with
the information. I can't remember the last time I asked for the contents
of the file when trying to debug a problem. There is a possibility that
someone will complain but I'm not aware of any utility that reads the
information and does something useful with it. In the unlikely event
something breaks, the file can be re-added with a limited walk.

-- 
Mel Gorman
SUSE Labs
