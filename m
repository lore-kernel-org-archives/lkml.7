Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3308C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C5C218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564557664;
	bh=BRyD0XI4GwRe0VUf5a7t1pGnEl0FtkVXZqDPETjZ4Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sAc9R62jIcubnJYxorT/k4d8aRspUXCvDEnXt4IZdfHqhiwwP9kR+YpW0fA22I7N4
	 ZGVBNg3yTh0eq1yejSAXH6Gc/udS/j65GgbACds5VzTlHB0tpUHUKg2WL33kN3Npk1
	 NOT4p5Fx0aBMbdmqSSfSwX/70hoA0wIfMTzoI3DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfGaHVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:21:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:38478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfGaHVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:21:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E663DAE52;
        Wed, 31 Jul 2019 07:21:01 +0000 (UTC)
Date:   Wed, 31 Jul 2019 09:21:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm: release the spinlock on zap_pte_range
Message-ID: <20190731072101.GX9330@dhcp22.suse.cz>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190729074523.GC9330@dhcp22.suse.cz>
 <20190729082052.GA258885@google.com>
 <20190729083515.GD9330@dhcp22.suse.cz>
 <20190730121110.GA184615@google.com>
 <20190730123237.GR9330@dhcp22.suse.cz>
 <20190730123935.GB184615@google.com>
 <20190730125751.GS9330@dhcp22.suse.cz>
 <20190731054447.GB155569@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731054447.GB155569@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-07-19 14:44:47, Minchan Kim wrote:
> On Tue, Jul 30, 2019 at 02:57:51PM +0200, Michal Hocko wrote:
> > [Cc Nick - the email thread starts http://lkml.kernel.org/r/20190729071037.241581-1-minchan@kernel.org
> >  A very brief summary is that mark_page_accessed seems to be quite
> >  expensive and the question is whether we still need it and why
> >  SetPageReferenced cannot be used instead. More below.]
> > 
> > On Tue 30-07-19 21:39:35, Minchan Kim wrote:
[...]
> > > commit bf3f3bc5e73
> > > Author: Nick Piggin <npiggin@suse.de>
> > > Date:   Tue Jan 6 14:38:55 2009 -0800
> > > 
> > >     mm: don't mark_page_accessed in fault path
> > > 
> > >     Doing a mark_page_accessed at fault-time, then doing SetPageReferenced at
> > >     unmap-time if the pte is young has a number of problems.
> > > 
> > >     mark_page_accessed is supposed to be roughly the equivalent of a young pte
> > >     for unmapped references. Unfortunately it doesn't come with any context:
> > >     after being called, reclaim doesn't know who or why the page was touched.
> > > 
> > >     So calling mark_page_accessed not only adds extra lru or PG_referenced
> > >     manipulations for pages that are already going to have pte_young ptes anyway,
> > >     but it also adds these references which are difficult to work with from the
> > >     context of vma specific references (eg. MADV_SEQUENTIAL pte_young may not
> > >     wish to contribute to the page being referenced).
> > > 
> > >     Then, simply doing SetPageReferenced when zapping a pte and finding it is
> > >     young, is not a really good solution either. SetPageReferenced does not
> > >     correctly promote the page to the active list for example. So after removing
> > >     mark_page_accessed from the fault path, several mmap()+touch+munmap() would
> > >     have a very different result from several read(2) calls for example, which
> > >     is not really desirable.
> > 
> > Well, I have to say that this is rather vague to me. Nick, could you be
> > more specific about which workloads do benefit from this change? Let's
> > say that the zapped pte is the only referenced one and then reclaim
> > finds the page on inactive list. We would go and reclaim it. But does
> > that matter so much? Hot pages would be referenced from multiple ptes
> > very likely, no?
> 
> As Nick mentioned in the description, without mark_page_accessed in
> zapping part, repeated mmap + touch + munmap never acticated the page
> while several read(2) calls easily promote it.

And is this really a problem? If we refault the same page then the
refaults detection should catch it no? In other words is the above still
a problem these days?

-- 
Michal Hocko
SUSE Labs
