Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6429ACA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4422D2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbfJWIbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:31:50 -0400
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:46920 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390165AbfJWIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:31:49 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 19574B86F3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 09:31:46 +0100 (IST)
Received: (qmail 2938 invoked from network); 23 Oct 2019 08:31:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Oct 2019 08:31:45 -0000
Date:   Wed, 23 Oct 2019 09:31:43 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@kernel.org>
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
Message-ID: <20191023083143.GC3016@techsingularity.net>
References: <20191022162156.17316-1-longman@redhat.com>
 <20191022165745.GT9379@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191022165745.GT9379@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 06:57:45PM +0200, Michal Hocko wrote:
> [Cc Mel]
> 
> On Tue 22-10-19 12:21:56, Waiman Long wrote:
> > The pagetypeinfo_showfree_print() function prints out the number of
> > free blocks for each of the page orders and migrate types. The current
> > code just iterates the each of the free lists to get counts.  There are
> > bug reports about hard lockup panics when reading the /proc/pagetyeinfo
> > file just because it look too long to iterate all the free lists within
> > a zone while holing the zone lock with irq disabled.
> > 
> > Given the fact that /proc/pagetypeinfo is readable by all, the possiblity
> > of crashing a system by the simple act of reading /proc/pagetypeinfo
> > by any user is a security problem that needs to be addressed.
> 
> Should we make the file 0400? It is a useful thing when debugging but
> not something regular users would really need for life.
> 

I think this would be useful in general. The information is not that
useful outside of debugging. Even then it's only useful when trying to
get a handle on why a path like compaction is taking too long.

> > There is a free_area structure associated with each page order. There
> > is also a nr_free count within the free_area for all the different
> > migration types combined. Tracking the number of free list entries
> > for each migration type will probably add some overhead to the fast
> > paths like moving pages from one migration type to another which may
> > not be desirable.
> 
> Have you tried to measure that overhead?
>  

I would prefer this option not be taken. It would increase the cost of
watermark calculations which is a relatively fast path.

> > we can actually skip iterating the list of one of the migration types
> > and used nr_free to compute the missing count. Since MIGRATE_MOVABLE
> > is usually the largest one on large memory systems, this is the one
> > to be skipped. Since the printing order is migration-type => order, we
> > will have to store the counts in an internal 2D array before printing
> > them out.
> > 
> > Even by skipping the MIGRATE_MOVABLE pages, we may still be holding the
> > zone lock for too long blocking out other zone lock waiters from being
> > run. This can be problematic for systems with large amount of memory.
> > So a check is added to temporarily release the lock and reschedule if
> > more than 64k of list entries have been iterated for each order. With
> > a MAX_ORDER of 11, the worst case will be iterating about 700k of list
> > entries before releasing the lock.
> 
> But you are still iterating through the whole free_list at once so if it
> gets really large then this is still possible. I think it would be
> preferable to use per migratetype nr_free if it doesn't cause any
> regressions.
> 

I think it will. The patch as it is contains the overhead within the
reader of the pagetypeinfo proc file which is a non-critical path. The
page allocator paths on the other hand is very important.

-- 
Mel Gorman
SUSE Labs
