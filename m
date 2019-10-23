Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22044CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EFA20679
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571821472;
	bh=ZmVZoPdxxoehQbJawDew6wgaE9PLNjAkXDMn2kn900M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nzBHOAqMySA4bSbxEIiaYCROJ9izERXBEV9jlLnejcBBZBYQ+MaCmlu3X+1k1AFGS
	 9UNm/dGUy4FQZZNdErp6azlVNIpE+0VIOV8KAkZSgNJnglq7b9xKKk4cyo8Il1b+iS
	 OLeY5ak3tIa6UtwDgk5H6/+weixb+xy/Bb9qLrXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390862AbfJWJEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:04:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:52432 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390314AbfJWJEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:04:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C3B1B83F;
        Wed, 23 Oct 2019 09:04:28 +0000 (UTC)
Date:   Wed, 23 Oct 2019 11:04:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
Message-ID: <20191023090422.GK754@dhcp22.suse.cz>
References: <20191022162156.17316-1-longman@redhat.com>
 <20191022165745.GT9379@dhcp22.suse.cz>
 <20191023083143.GC3016@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023083143.GC3016@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 09:31:43, Mel Gorman wrote:
> On Tue, Oct 22, 2019 at 06:57:45PM +0200, Michal Hocko wrote:
> > [Cc Mel]
> > 
> > On Tue 22-10-19 12:21:56, Waiman Long wrote:
> > > The pagetypeinfo_showfree_print() function prints out the number of
> > > free blocks for each of the page orders and migrate types. The current
> > > code just iterates the each of the free lists to get counts.  There are
> > > bug reports about hard lockup panics when reading the /proc/pagetyeinfo
> > > file just because it look too long to iterate all the free lists within
> > > a zone while holing the zone lock with irq disabled.
> > > 
> > > Given the fact that /proc/pagetypeinfo is readable by all, the possiblity
> > > of crashing a system by the simple act of reading /proc/pagetypeinfo
> > > by any user is a security problem that needs to be addressed.
> > 
> > Should we make the file 0400? It is a useful thing when debugging but
> > not something regular users would really need for life.
> > 
> 
> I think this would be useful in general. The information is not that
> useful outside of debugging. Even then it's only useful when trying to
> get a handle on why a path like compaction is taking too long.

So can we go with this to address the security aspect of this and have
something trivial to backport.

> > > There is a free_area structure associated with each page order. There
> > > is also a nr_free count within the free_area for all the different
> > > migration types combined. Tracking the number of free list entries
> > > for each migration type will probably add some overhead to the fast
> > > paths like moving pages from one migration type to another which may
> > > not be desirable.
> > 
> > Have you tried to measure that overhead?
> >  
> 
> I would prefer this option not be taken. It would increase the cost of
> watermark calculations which is a relatively fast path.

Is the change for the wmark check going to require more than
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c0b2e0306720..5d95313ba4a5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3448,9 +3448,6 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 		struct free_area *area = &z->free_area[o];
 		int mt;
 
-		if (!area->nr_free)
-			continue;
-
 		for (mt = 0; mt < MIGRATE_PCPTYPES; mt++) {
 			if (!free_area_empty(area, mt))
 				return true;

Is this really going to be visible in practice? Sure we are going to do
more checks but most orders tend to have at least some memory in a
reasonably balanced system and we can hardly expect an optimal
allocation path on those that are not.
 
> > > we can actually skip iterating the list of one of the migration types
> > > and used nr_free to compute the missing count. Since MIGRATE_MOVABLE
> > > is usually the largest one on large memory systems, this is the one
> > > to be skipped. Since the printing order is migration-type => order, we
> > > will have to store the counts in an internal 2D array before printing
> > > them out.
> > > 
> > > Even by skipping the MIGRATE_MOVABLE pages, we may still be holding the
> > > zone lock for too long blocking out other zone lock waiters from being
> > > run. This can be problematic for systems with large amount of memory.
> > > So a check is added to temporarily release the lock and reschedule if
> > > more than 64k of list entries have been iterated for each order. With
> > > a MAX_ORDER of 11, the worst case will be iterating about 700k of list
> > > entries before releasing the lock.
> > 
> > But you are still iterating through the whole free_list at once so if it
> > gets really large then this is still possible. I think it would be
> > preferable to use per migratetype nr_free if it doesn't cause any
> > regressions.
> > 
> 
> I think it will. The patch as it is contains the overhead within the
> reader of the pagetypeinfo proc file which is a non-critical path. The
> page allocator paths on the other hand is very important.

As pointed out in other email. The problem with this patch is that it
hasn't really removed the iteration over the whole free_list which is
the primary problem. So I think that we should either consider this a
non-issue and make it "admin knows this is potentially expensive" or do
something like Andrew was suggesting if we do not want to change the
nr_free accounting.

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6afc892a148a..83c0295ecddc 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1386,8 +1386,16 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 
 			area = &(zone->free_area[order]);
 
-			list_for_each(curr, &area->free_list[mtype])
+			list_for_each(curr, &area->free_list[mtype]) {
 				freecount++;
+				if (freecount > BIG_NUMBER) {
+					seq_printf(">%6lu ", freecount);
+					spin_unlock_irq(&zone->lock);
+					cond_resched();
+					spin_lock_irq(&zone->lock);
+					continue;
+				}
+			}
 			seq_printf(m, "%6lu ", freecount);
 		}
 		seq_putc(m, '\n');
-- 
Michal Hocko
SUSE Labs
