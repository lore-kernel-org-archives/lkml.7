Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21305C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E152146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfGAI7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:59:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:43756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728236AbfGAI7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:59:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 297ADAD2A;
        Mon,  1 Jul 2019 08:59:22 +0000 (UTC)
Date:   Mon, 1 Jul 2019 09:59:20 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [Question] Should direct reclaim time be bounded?
Message-ID: <20190701085920.GB2812@suse.de>
References: <d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com>
 <20190423071953.GC25106@dhcp22.suse.cz>
 <eac582cf-2f76-4da1-1127-6bb5c8c959e4@oracle.com>
 <04329fea-cd34-4107-d1d4-b2098ebab0ec@suse.cz>
 <dede2f84-90bf-347a-2a17-fb6b521bf573@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <dede2f84-90bf-347a-2a17-fb6b521bf573@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:20:42AM -0700, Mike Kravetz wrote:
> On 4/24/19 7:35 AM, Vlastimil Babka wrote:
> > On 4/23/19 6:39 PM, Mike Kravetz wrote:
> >>> That being said, I do not think __GFP_RETRY_MAYFAIL is wrong here. It
> >>> looks like there is something wrong in the reclaim going on.
> >>
> >> Ok, I will start digging into that.  Just wanted to make sure before I got
> >> into it too deep.
> >>
> >> BTW - This is very easy to reproduce.  Just try to allocate more huge pages
> >> than will fit into memory.  I see this 'reclaim taking forever' behavior on
> >> v5.1-rc5-mmotm-2019-04-19-14-53.  Looks like it was there in v5.0 as well.
> > 
> > I'd suspect this in should_continue_reclaim():
> > 
> >         /* Consider stopping depending on scan and reclaim activity */
> >         if (sc->gfp_mask & __GFP_RETRY_MAYFAIL) {
> >                 /*
> >                  * For __GFP_RETRY_MAYFAIL allocations, stop reclaiming if the
> >                  * full LRU list has been scanned and we are still failing
> >                  * to reclaim pages. This full LRU scan is potentially
> >                  * expensive but a __GFP_RETRY_MAYFAIL caller really wants to succeed
> >                  */
> >                 if (!nr_reclaimed && !nr_scanned)
> >                         return false;
> > 
> > And that for some reason, nr_scanned never becomes zero. But it's hard
> > to figure out through all the layers of functions :/
> 
> I got back to looking into the direct reclaim/compaction stalls when
> trying to allocate huge pages.  As previously mentioned, the code is
> looping for a long time in shrink_node().  The routine
> should_continue_reclaim() returns true perhaps more often than it should.
> 
> As Vlastmil guessed, my debug code output below shows nr_scanned is remaining
> non-zero for quite a while.  This was on v5.2-rc6.
> 

I think it would be reasonable to have should_continue_reclaim allow an
exit if scanning at higher priority than DEF_PRIORITY - 2, nr_scanned is
less than SWAP_CLUSTER_MAX and no pages are being reclaimed.

-- 
Mel Gorman
SUSE Labs
