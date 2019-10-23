Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5314CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8632A21928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571811316;
	bh=Biry5v7LCcVD009i5oVWlZT4seoqvoMrFIE9bGSmYn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oLfE+okiyb/f6osh0LpR8QelBJjY3BontPIxuygL91uPFjoBtT3ZumeGZP8lBKszr
	 mX8aVOSMvlYfKaKPEfNtCXi6yaaszSZUDrJ5BIO6JO9qPo1FWVTFFyd8XB0rjQL3b2
	 Dhmm+gdZgKgiC/V/dR3CDyW6liyXWl97njgzxC2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbfJWGPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:15:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:46124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfJWGPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:15:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92ED5AEF3;
        Wed, 23 Oct 2019 06:15:12 +0000 (UTC)
Date:   Wed, 23 Oct 2019 08:15:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
Cc:     Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
Message-ID: <20191023061511.GA754@dhcp22.suse.cz>
References: <20191022162156.17316-1-longman@redhat.com>
 <20191022145902.d9c4a719c0b32175e06e4eee@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022145902.d9c4a719c0b32175e06e4eee@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 14:59:02, Andrew Morton wrote:
> On Tue, 22 Oct 2019 12:21:56 -0400 Waiman Long <longman@redhat.com> wrote:
[...]
> > -	for (mtype = 0; mtype < MIGRATE_TYPES; mtype++) {
> > -		seq_printf(m, "Node %4d, zone %8s, type %12s ",
> > -					pgdat->node_id,
> > -					zone->name,
> > -					migratetype_names[mtype]);
> > -		for (order = 0; order < MAX_ORDER; ++order) {
> > +	lockdep_assert_held(&zone->lock);
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	/*
> > +	 * MIGRATE_MOVABLE is usually the largest one in large memory
> > +	 * systems. We skip iterating that list. Instead, we compute it by
> > +	 * subtracting the total of the rests from free_area->nr_free.
> > +	 */
> > +	for (order = 0; order < MAX_ORDER; ++order) {
> > +		unsigned long nr_total = 0;
> > +		struct free_area *area = &(zone->free_area[order]);
> > +
> > +		for (mtype = 0; mtype < MIGRATE_TYPES; mtype++) {
> >  			unsigned long freecount = 0;
> > -			struct free_area *area;
> >  			struct list_head *curr;
> >  
> > -			area = &(zone->free_area[order]);
> > -
> > +			if (mtype == MIGRATE_MOVABLE)
> > +				continue;
> >  			list_for_each(curr, &area->free_list[mtype])
> >  				freecount++;
> > -			seq_printf(m, "%6lu ", freecount);
> > +			nfree[order][mtype] = freecount;
> > +			nr_total += freecount;
> >  		}
> > +		nfree[order][MIGRATE_MOVABLE] = area->nr_free - nr_total;
> > +
> > +		/*
> > +		 * If we have already iterated more than 64k of list
> > +		 * entries, we might have hold the zone lock for too long.
> > +		 * Temporarily release the lock and reschedule before
> > +		 * continuing so that other lock waiters have a chance
> > +		 * to run.
> > +		 */
> > +		if (nr_total > (1 << 16)) {
> > +			spin_unlock_irq(&zone->lock);
> > +			cond_resched();
> > +			spin_lock_irq(&zone->lock);
> > +		}
> > +	}
> > +
> > +	for (mtype = 0; mtype < MIGRATE_TYPES; mtype++) {
> > +		seq_printf(m, "Node %4d, zone %8s, type %12s ",
> > +					pgdat->node_id,
> > +					zone->name,
> > +					migratetype_names[mtype]);
> > +		for (order = 0; order < MAX_ORDER; ++order)
> > +			seq_printf(m, "%6lu ", nfree[order][mtype]);
> >  		seq_putc(m, '\n');
> 
> This is not exactly a thing of beauty :( Presumably there might still
> be situations where the irq-off times remain excessive.

Yes. It is the list_for_each over the free_list that needs the lock and
that is the actual problem here. This can be really large with a _lot_
of memory. And this is why I objected to the patch. Because it doesn't
really address this problem. I would like to hear from Mel and Vlastimil
how would they feel about making free_list fully migrate type aware
(including nr_free).

> Why are we actually holding zone->lock so much?  Can we get away with
> holding it across the list_for_each() loop and nothing else?  If so,
> this still isn't a bulletproof fix.  Maybe just terminate the list
> walk if freecount reaches 1024.  Would anyone really care?
> 
> Sigh.  I wonder if anyone really uses this thing for anything
> important.  Can we just remove it all?

Vlastimil would know much better but I have seen this being used for
fragmentation related debugging. That should imply that 0400 should be
sufficient and a quick and easily backportable fix for the most pressing
immediate problem.
-- 
Michal Hocko
SUSE Labs
