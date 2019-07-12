Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C72BC742B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAED2064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfGLJtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:49:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:37850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbfGLJtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:49:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90E6EAF6B;
        Fri, 12 Jul 2019 09:49:21 +0000 (UTC)
Date:   Fri, 12 Jul 2019 10:49:19 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Hillf Danton <hdanton@sina.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [Question] Should direct reclaim time be bounded?
Message-ID: <20190712094919.GI13484@suse.de>
References: <d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com>
 <80036eed-993d-1d24-7ab6-e495f01b1caa@oracle.com>
 <885afb7b-f5be-590a-00c8-a24d2bc65f37@oracle.com>
 <20190710194403.GR29695@dhcp22.suse.cz>
 <9d6c8b74-3cf6-4b9e-d3cb-a7ef49f838c7@oracle.com>
 <20190711071245.GB29483@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190711071245.GB29483@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 09:12:45AM +0200, Michal Hocko wrote:
> On Wed 10-07-19 16:36:58, Mike Kravetz wrote:
> > On 7/10/19 12:44 PM, Michal Hocko wrote:
> > > On Wed 10-07-19 11:42:40, Mike Kravetz wrote:
> > > [...]
> > >> As Michal suggested, I'm going to do some testing to see what impact
> > >> dropping the __GFP_RETRY_MAYFAIL flag for these huge page allocations
> > >> will have on the number of pages allocated.
> > > 
> > > Just to clarify. I didn't mean to drop __GFP_RETRY_MAYFAIL from the
> > > allocation request. I meant to drop the special casing of the flag in
> > > should_continue_reclaim. I really have hard time to argue for this
> > > special casing TBH. The flag is meant to retry harder but that shouldn't
> > > be reduced to a single reclaim attempt because that alone doesn't really
> > > help much with the high order allocation. It is more about compaction to
> > > be retried harder.
> > 
> > Thanks Michal.  That is indeed what you suggested earlier.  I remembered
> > incorrectly.  Sorry.
> > 
> > Removing the special casing for __GFP_RETRY_MAYFAIL in should_continue_reclaim
> > implies that it will return false if nothing was reclaimed (nr_reclaimed == 0)
> > in the previous pass.
> > 
> > When I make such a modification and test, I see long stalls as a result
> > of should_compact_retry returning true too often.  On a system I am currently
> > testing, should_compact_retry has returned true 36000000 times.  My guess
> > is that this may stall forever.  Vlastmil previously asked about this behavior,
> > so I am capturing the reason.  Like before [1], should_compact_retry is
> > returning true mostly because compaction_withdrawn() returns COMPACT_DEFERRED.
> 
> This smells like a problem to me. But somebody more familiar with
> compaction should comment.
> 

Examine in should_compact_retry if it's retrying because
compaction_zonelist_suitable is true. Looking at it now, it would not
necessarily do the right thing because any non-skipped zone would make
it eligible which is too strong a condition as COMPACT_SKIPPED is not
reliably set. If that function is the case, it would be reasonable
remove "ret = compaction_zonelist_suitable(ac, order, alloc_flags);" and
the implementation of compaction_zonelist_suitable entirely as part of
your fix.

-- 
Mel Gorman
SUSE Labs
