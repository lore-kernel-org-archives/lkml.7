Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC40C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8F52089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564489960;
	bh=fBUqCoenMUXj+UTof67hBbwUfxH9olno/QLTQe6JHw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=akyX2jDmhVLZdMYOzWRX7K5TFZh4/S6gAWSt/qqtj3KrEdVnPmbsmfczvDAmV/YDr
	 nYgLnGo8q7l+/L6QokzlLPxijfaCNN+q45cA1y1sm3Q223DJFP7BK6AeE0BBy7iO4t
	 HIaPsCd9qh3NLerpUspvvaGniZWYdbCNBnz4BVXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfG3Mcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:32:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:55110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbfG3Mcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:32:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EDE1AAFD2;
        Tue, 30 Jul 2019 12:32:37 +0000 (UTC)
Date:   Tue, 30 Jul 2019 14:32:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: release the spinlock on zap_pte_range
Message-ID: <20190730123237.GR9330@dhcp22.suse.cz>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190729074523.GC9330@dhcp22.suse.cz>
 <20190729082052.GA258885@google.com>
 <20190729083515.GD9330@dhcp22.suse.cz>
 <20190730121110.GA184615@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730121110.GA184615@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-07-19 21:11:10, Minchan Kim wrote:
> On Mon, Jul 29, 2019 at 10:35:15AM +0200, Michal Hocko wrote:
> > On Mon 29-07-19 17:20:52, Minchan Kim wrote:
> > > On Mon, Jul 29, 2019 at 09:45:23AM +0200, Michal Hocko wrote:
> > > > On Mon 29-07-19 16:10:37, Minchan Kim wrote:
> > > > > In our testing(carmera recording), Miguel and Wei found unmap_page_range
> > > > > takes above 6ms with preemption disabled easily. When I see that, the
> > > > > reason is it holds page table spinlock during entire 512 page operation
> > > > > in a PMD. 6.2ms is never trivial for user experince if RT task couldn't
> > > > > run in the time because it could make frame drop or glitch audio problem.
> > > > 
> > > > Where is the time spent during the tear down? 512 pages doesn't sound
> > > > like a lot to tear down. Is it the TLB flushing?
> > > 
> > > Miguel confirmed there is no such big latency without mark_page_accessed
> > > in zap_pte_range so I guess it's the contention of LRU lock as well as
> > > heavy activate_page overhead which is not trivial, either.
> > 
> > Please give us more details ideally with some numbers.
> 
> I had a time to benchmark it via adding some trace_printk hooks between
> pte_offset_map_lock and pte_unmap_unlock in zap_pte_range. The testing
> device is 2018 premium mobile device.
> 
> I can get 2ms delay rather easily to release 2M(ie, 512 pages) when the
> task runs on little core even though it doesn't have any IPI and LRU
> lock contention. It's already too heavy.
> 
> If I remove activate_page, 35-40% overhead of zap_pte_range is gone
> so most of overhead(about 0.7ms) comes from activate_page via
> mark_page_accessed. Thus, if there are LRU contention, that 0.7ms could
> accumulate up to several ms.

Thanks for this information. This is something that should be a part of
the changelog. I am sorry to still poke into this because I still do not
have a full understanding of what is going on and while I do not object
to drop the spinlock I still suspect this is papering over a deeper
problem.

If mark_page_accessed is really expensive then why do we even bother to
do it in the tear down path in the first place? Why don't we simply set
a referenced bit on the page to reflect the young pte bit? I might be
missing something here of course.

-- 
Michal Hocko
SUSE Labs
