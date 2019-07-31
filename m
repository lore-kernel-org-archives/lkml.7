Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F81C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62728208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfGaM0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:26:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:41464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfGaM0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:26:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C955AC64;
        Wed, 31 Jul 2019 12:26:01 +0000 (UTC)
Date:   Wed, 31 Jul 2019 13:25:59 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hillf Danton <hdanton@sina.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/3] mm, reclaim: make should_continue_reclaim
 perform dryrun detection
Message-ID: <20190731122559.GH2708@suse.de>
References: <20190724175014.9935-1-mike.kravetz@oracle.com>
 <20190724175014.9935-2-mike.kravetz@oracle.com>
 <20190725080551.GB2708@suse.de>
 <295a37b1-8257-9b4a-b586-9a4990cc9d35@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <295a37b1-8257-9b4a-b586-9a4990cc9d35@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 01:08:44PM +0200, Vlastimil Babka wrote:
> On 7/26/19 9:40 AM, Hillf Danton wrote:
> > 
> > On Thu, 25 Jul 2019 08:05:55 +0000 (UTC) Mel Gorman wrote:
> >>
> >> Agreed that the description could do with improvement. However, it
> >> makes sense that if compaction reports it can make progress that it is
> >> unnecessary to continue reclaiming.
> > 
> > Thanks Mike and Mel.
> > 
> > Hillf
> > ---8<---
> > From: Hillf Danton <hdanton@sina.com>
> > Subject: [RFC PATCH 1/3] mm, reclaim: make should_continue_reclaim perform dryrun detection
> > 
> > Address the issue of should_continue_reclaim continuing true too often
> > for __GFP_RETRY_MAYFAIL attempts when !nr_reclaimed and nr_scanned.
> > This could happen during hugetlb page allocation causing stalls for
> > minutes or hours.
> > 
> > We can stop reclaiming pages if compaction reports it can make a progress.
> > A code reshuffle is needed to do that. And it has side-effects, however,
> > with allocation latencies in other cases but that would come at the cost
> > of potential premature reclaim which has consequences of itself.
> 
> I don't really understand that paragraph, did Mel meant it like this?
> 

Fundamentally, the balancing act is between a) reclaiming more now so
that compaction is more likely to succeed or b) keep pages resident to
avoid refaulting.

With a) high order allocations are faster, less likely to stall and more
likely to succeed. However, it can also prematurely reclaim pages and free
more memory than is necessary for compaction to succeed in a reasonable
amount of time. We also know from testing that it can hit corner cases
with hugetlbfs where stalls happen for prolonged periods of time anyway
and the series overall is known to fix those stalls.

> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Hillf Danton <hdanton@sina.com>
> 
> I agree this is an improvement overall, but perhaps the patch does too
> many things at once. The reshuffle is one thing and makes sense. The
> change of the last return condition could perhaps be separate. Also
> AFAICS the ultimate result is that when nr_reclaimed == 0, the function
> will now always return false. Which makes the initial test for
> __GFP_RETRY_MAYFAIL and the comments there misleading. There will no
> longer be a full LRU scan guaranteed - as long as the scanned LRU chunk
> yields no reclaimed page, we abort.
> 

I've no strong feelings on whether it is worth splitting the patch. In
my mind it's more or less doing one thing even though the one thing is a
relatively high-level problem.

-- 
Mel Gorman
SUSE Labs
