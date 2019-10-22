Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244A5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9991207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571781555;
	bh=tl4VM/euQB200yzITWXCgGsKntOKepIcapE8JQ3Z8JY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yZ6jhrQf4krZWllAdBZTis5B3zSfPSmZ7aMnoxL4DLNFXEn9EDkHspEatohB9k/yX
	 L1AvDlSONfcSlrGc/Vsm8+fW5Y2P51XLq9SA2QFj8OxKp8d+MwLV5o5sBV50iqt2hn
	 NhKzo5VXDphYA41xVjs3iaDWxNucat0upja2j02Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfJVV7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 17:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731191AbfJVV7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 17:59:04 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5CD207FC;
        Tue, 22 Oct 2019 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571781543;
        bh=tl4VM/euQB200yzITWXCgGsKntOKepIcapE8JQ3Z8JY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cieUVQ/fzhpz8561vfQ4bIe9GHj4QnG5kPPW+zFooiQKvuGXtNQtdzhfYmt/V5jJu
         MFNAqvlcasyOwjj2BDt+/hxodLr0/ASXd4lp8cQ2Dtz08yJnJz/VR6YJh7xsUwJiN8
         GV9N90t/VzdF2OQcsGtQn1Md25pY62ugSAPOkXD4=
Date:   Tue, 22 Oct 2019 14:59:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
Message-Id: <20191022145902.d9c4a719c0b32175e06e4eee@linux-foundation.org>
In-Reply-To: <20191022162156.17316-1-longman@redhat.com>
References: <20191022162156.17316-1-longman@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 12:21:56 -0400 Waiman Long <longman@redhat.com> wrote:

> The pagetypeinfo_showfree_print() function prints out the number of
> free blocks for each of the page orders and migrate types. The current
> code just iterates the each of the free lists to get counts.  There are
> bug reports about hard lockup panics when reading the /proc/pagetyeinfo
> file just because it look too long to iterate all the free lists within
> a zone while holing the zone lock with irq disabled.
> 
> Given the fact that /proc/pagetypeinfo is readable by all, the possiblity
> of crashing a system by the simple act of reading /proc/pagetypeinfo
> by any user is a security problem that needs to be addressed.

Yes.

> There is a free_area structure associated with each page order. There
> is also a nr_free count within the free_area for all the different
> migration types combined. Tracking the number of free list entries
> for each migration type will probably add some overhead to the fast
> paths like moving pages from one migration type to another which may
> not be desirable.
> 
> we can actually skip iterating the list of one of the migration types
> and used nr_free to compute the missing count. Since MIGRATE_MOVABLE
> is usually the largest one on large memory systems, this is the one
> to be skipped. Since the printing order is migration-type => order, we
> will have to store the counts in an internal 2D array before printing
> them out.
> 
> Even by skipping the MIGRATE_MOVABLE pages, we may still be holding the
> zone lock for too long blocking out other zone lock waiters from being
> run. This can be problematic for systems with large amount of memory.
> So a check is added to temporarily release the lock and reschedule if
> more than 64k of list entries have been iterated for each order. With
> a MAX_ORDER of 11, the worst case will be iterating about 700k of list
> entries before releasing the lock.
> 
> ...
>
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1373,23 +1373,54 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
>  					pg_data_t *pgdat, struct zone *zone)
>  {
>  	int order, mtype;
> +	unsigned long nfree[MAX_ORDER][MIGRATE_TYPES];

600+ bytes is a bit much.  I guess it's OK in this situation.

> -	for (mtype = 0; mtype < MIGRATE_TYPES; mtype++) {
> -		seq_printf(m, "Node %4d, zone %8s, type %12s ",
> -					pgdat->node_id,
> -					zone->name,
> -					migratetype_names[mtype]);
> -		for (order = 0; order < MAX_ORDER; ++order) {
> +	lockdep_assert_held(&zone->lock);
> +	lockdep_assert_irqs_disabled();
> +
> +	/*
> +	 * MIGRATE_MOVABLE is usually the largest one in large memory
> +	 * systems. We skip iterating that list. Instead, we compute it by
> +	 * subtracting the total of the rests from free_area->nr_free.
> +	 */
> +	for (order = 0; order < MAX_ORDER; ++order) {
> +		unsigned long nr_total = 0;
> +		struct free_area *area = &(zone->free_area[order]);
> +
> +		for (mtype = 0; mtype < MIGRATE_TYPES; mtype++) {
>  			unsigned long freecount = 0;
> -			struct free_area *area;
>  			struct list_head *curr;
>  
> -			area = &(zone->free_area[order]);
> -
> +			if (mtype == MIGRATE_MOVABLE)
> +				continue;
>  			list_for_each(curr, &area->free_list[mtype])
>  				freecount++;
> -			seq_printf(m, "%6lu ", freecount);
> +			nfree[order][mtype] = freecount;
> +			nr_total += freecount;
>  		}
> +		nfree[order][MIGRATE_MOVABLE] = area->nr_free - nr_total;
> +
> +		/*
> +		 * If we have already iterated more than 64k of list
> +		 * entries, we might have hold the zone lock for too long.
> +		 * Temporarily release the lock and reschedule before
> +		 * continuing so that other lock waiters have a chance
> +		 * to run.
> +		 */
> +		if (nr_total > (1 << 16)) {
> +			spin_unlock_irq(&zone->lock);
> +			cond_resched();
> +			spin_lock_irq(&zone->lock);
> +		}
> +	}
> +
> +	for (mtype = 0; mtype < MIGRATE_TYPES; mtype++) {
> +		seq_printf(m, "Node %4d, zone %8s, type %12s ",
> +					pgdat->node_id,
> +					zone->name,
> +					migratetype_names[mtype]);
> +		for (order = 0; order < MAX_ORDER; ++order)
> +			seq_printf(m, "%6lu ", nfree[order][mtype]);
>  		seq_putc(m, '\n');

This is not exactly a thing of beauty :( Presumably there might still
be situations where the irq-off times remain excessive.

Why are we actually holding zone->lock so much?  Can we get away with
holding it across the list_for_each() loop and nothing else?  If so,
this still isn't a bulletproof fix.  Maybe just terminate the list
walk if freecount reaches 1024.  Would anyone really care?

Sigh.  I wonder if anyone really uses this thing for anything
important.  Can we just remove it all?

