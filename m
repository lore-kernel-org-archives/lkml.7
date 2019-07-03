Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9948AC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E6E21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfGCJnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:43:32 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:37480 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbfGCJnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:43:31 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 053B81C346F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2019 10:43:28 +0100 (IST)
Received: (qmail 16561 invoked from network); 3 Jul 2019 09:43:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.36])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Jul 2019 09:43:27 -0000
Date:   Wed, 3 Jul 2019 10:43:25 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [Question] Should direct reclaim time be bounded?
Message-ID: <20190703094325.GB2737@techsingularity.net>
References: <d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com>
 <20190423071953.GC25106@dhcp22.suse.cz>
 <eac582cf-2f76-4da1-1127-6bb5c8c959e4@oracle.com>
 <04329fea-cd34-4107-d1d4-b2098ebab0ec@suse.cz>
 <dede2f84-90bf-347a-2a17-fb6b521bf573@oracle.com>
 <20190701085920.GB2812@suse.de>
 <80036eed-993d-1d24-7ab6-e495f01b1caa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <80036eed-993d-1d24-7ab6-e495f01b1caa@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 08:15:50PM -0700, Mike Kravetz wrote:
> On 7/1/19 1:59 AM, Mel Gorman wrote:
> > On Fri, Jun 28, 2019 at 11:20:42AM -0700, Mike Kravetz wrote:
> >> On 4/24/19 7:35 AM, Vlastimil Babka wrote:
> >>> On 4/23/19 6:39 PM, Mike Kravetz wrote:
> >>>>> That being said, I do not think __GFP_RETRY_MAYFAIL is wrong here. It
> >>>>> looks like there is something wrong in the reclaim going on.
> >>>>
> >>>> Ok, I will start digging into that.  Just wanted to make sure before I got
> >>>> into it too deep.
> >>>>
> >>>> BTW - This is very easy to reproduce.  Just try to allocate more huge pages
> >>>> than will fit into memory.  I see this 'reclaim taking forever' behavior on
> >>>> v5.1-rc5-mmotm-2019-04-19-14-53.  Looks like it was there in v5.0 as well.
> >>>
> >>> I'd suspect this in should_continue_reclaim():
> >>>
> >>>         /* Consider stopping depending on scan and reclaim activity */
> >>>         if (sc->gfp_mask & __GFP_RETRY_MAYFAIL) {
> >>>                 /*
> >>>                  * For __GFP_RETRY_MAYFAIL allocations, stop reclaiming if the
> >>>                  * full LRU list has been scanned and we are still failing
> >>>                  * to reclaim pages. This full LRU scan is potentially
> >>>                  * expensive but a __GFP_RETRY_MAYFAIL caller really wants to succeed
> >>>                  */
> >>>                 if (!nr_reclaimed && !nr_scanned)
> >>>                         return false;
> >>>
> >>> And that for some reason, nr_scanned never becomes zero. But it's hard
> >>> to figure out through all the layers of functions :/
> >>
> >> I got back to looking into the direct reclaim/compaction stalls when
> >> trying to allocate huge pages.  As previously mentioned, the code is
> >> looping for a long time in shrink_node().  The routine
> >> should_continue_reclaim() returns true perhaps more often than it should.
> >>
> >> As Vlastmil guessed, my debug code output below shows nr_scanned is remaining
> >> non-zero for quite a while.  This was on v5.2-rc6.
> >>
> > 
> > I think it would be reasonable to have should_continue_reclaim allow an
> > exit if scanning at higher priority than DEF_PRIORITY - 2, nr_scanned is
> > less than SWAP_CLUSTER_MAX and no pages are being reclaimed.
> 
> Thanks Mel,
> 
> I added such a check to should_continue_reclaim.  However, it does not
> address the issue I am seeing.  In that do-while loop in shrink_node,
> the scan priority is not raised (priority--).  We can enter the loop
> with priority == DEF_PRIORITY and continue to loop for minutes as seen
> in my previous debug output.
> 

Indeed. I'm getting knocked offline shortly so I didn't give this the
time it deserves but it appears that part of this problem is
hugetlb-specific when one node is full and can enter into this continual
loop due to __GFP_RETRY_MAYFAIL requiring both nr_reclaimed and
nr_scanned to be zero.

Have you considered one of the following as an option?

1. Always use the on-stack nodes_allowed in __nr_hugepages_store_common
   and copy nodes_states if necessary. Add a bool parameter to
   alloc_pool_huge_page that is true when called from set_max_huge_pages.
   If an allocation from alloc_fresh_huge_page, clear the failing node
   from the mask so it's not retried, bail if the mask is empty. The
   consequences are that round-robin allocation of huge pages will be
   different if a node failed to allocate for transient reasons.

2. Alter the condition in should_continue_reclaim for
   __GFP_RETRY_MAYFAIL to consider if nr_scanned < SWAP_CLUSTER_MAX.
   Either raise priority (will interfere with kswapd though) or
   bail entirely.  Consequences may be that other __GFP_RETRY_MAYFAIL
   allocations do not want this behaviour. There are a lot of users.

3. Move where __GFP_RETRY_MAYFAIL is set in a gfp_mask in mm/hugetlb.c.
   Strip the flag if an allocation fails on a node. Consequences are
   that setting the required number of huge pages is more likely to
   return without all the huge pages set.

-- 
Mel Gorman
SUSE Labs
