Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B88C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DCC22BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfGYWnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:43:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:35318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbfGYWnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:43:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEB95AEF6;
        Thu, 25 Jul 2019 22:43:12 +0000 (UTC)
Date:   Thu, 25 Jul 2019 23:43:07 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 3/3] hugetlbfs: don't retry when pool page
 allocations start to fail
Message-ID: <20190725224307.GE2708@suse.de>
References: <20190724175014.9935-1-mike.kravetz@oracle.com>
 <20190724175014.9935-4-mike.kravetz@oracle.com>
 <20190725081350.GD2708@suse.de>
 <6a7f3705-9550-e22f-efa1-5e3616351df6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <6a7f3705-9550-e22f-efa1-5e3616351df6@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:15:29AM -0700, Mike Kravetz wrote:
> On 7/25/19 1:13 AM, Mel Gorman wrote:
> > On Wed, Jul 24, 2019 at 10:50:14AM -0700, Mike Kravetz wrote:
> >> When allocating hugetlbfs pool pages via /proc/sys/vm/nr_hugepages,
> >> the pages will be interleaved between all nodes of the system.  If
> >> nodes are not equal, it is quite possible for one node to fill up
> >> before the others.  When this happens, the code still attempts to
> >> allocate pages from the full node.  This results in calls to direct
> >> reclaim and compaction which slow things down considerably.
> >>
> >> When allocating pool pages, note the state of the previous allocation
> >> for each node.  If previous allocation failed, do not use the
> >> aggressive retry algorithm on successive attempts.  The allocation
> >> will still succeed if there is memory available, but it will not try
> >> as hard to free up memory.
> >>
> >> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > 
> > set_max_huge_pages can fail the NODEMASK_ALLOC() alloc which you handle
> > *but* in the event of an allocation failure this bug can silently recur.
> > An informational message might be justified in that case in case the
> > stall should recur with no hint as to why.
> 
> Right.
> Perhaps a NODEMASK_ALLOC() failure should just result in a quick exit/error.
> If we can't allocate a node mask, it is unlikely we will be able to allocate
> a/any huge pages.  And, the system must be extremely low on memory and there
> are likely other bigger issues.
> 

That might be better overall, you make a valid point that a failed
kmalloc is not a good sign for hugetlbfs allocations.

> There have been discussions elsewhere about discontinuing the use of
> NODEMASK_ALLOC() and just putting the mask on the stack.  That may be
> acceptable here as well.
> 

They can be big and while this particular path would be relatively safe,
I think the fact that there will not be much functional difference
between allocating on the stack and a failed kmalloc in terms of
hugetlbfs allocation success rates.

> >                                            Technically passing NULL into
> > NODEMASK_FREE is also safe as kfree (if used for that kernel config) can
> > handle freeing of a NULL pointer. However, that is cosmetic more than
> > anything. Whether you decide to change either or not;
> 
> Yes.
> I will clean up with an updated series after more feedback.
> 

Thanks.

-- 
Mel Gorman
SUSE Labs
