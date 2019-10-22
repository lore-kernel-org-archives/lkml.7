Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0852DCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35F021783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571763470;
	bh=HTouoyMb26+DnEoyaQ7CBfUZJD1uMsCFtgc9AuRuvJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J7cqAsM73uagji9JTATe5K/6GKD+NfU4Qu1KJ5XSBJTC1CDhCHLFl/bOuulYfhQop
	 Rkgw5ndSA7IYcvB2WWpQ2xTJeBT66J1dAxOHxpEpEMle9fbd0SJBRqrIbgGJCqhu8h
	 5UrThzN2hx4qD3jMhvrZYnIpI8QiX6IgAROrI2Qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbfJVQ5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:57:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:56182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730432AbfJVQ5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:57:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 398C6B3FA;
        Tue, 22 Oct 2019 16:57:47 +0000 (UTC)
Date:   Tue, 22 Oct 2019 18:57:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
Message-ID: <20191022165745.GT9379@dhcp22.suse.cz>
References: <20191022162156.17316-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022162156.17316-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Mel]

On Tue 22-10-19 12:21:56, Waiman Long wrote:
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

Should we make the file 0400? It is a useful thing when debugging but
not something regular users would really need for life.

> There is a free_area structure associated with each page order. There
> is also a nr_free count within the free_area for all the different
> migration types combined. Tracking the number of free list entries
> for each migration type will probably add some overhead to the fast
> paths like moving pages from one migration type to another which may
> not be desirable.

Have you tried to measure that overhead?
 
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

But you are still iterating through the whole free_list at once so if it
gets really large then this is still possible. I think it would be
preferable to use per migratetype nr_free if it doesn't cause any
regressions.

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/vmstat.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 6afc892a148a..40c9a1494709 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1373,23 +1373,54 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
>  					pg_data_t *pgdat, struct zone *zone)
>  {
>  	int order, mtype;
> +	unsigned long nfree[MAX_ORDER][MIGRATE_TYPES];
>  
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
>  	}
>  }
> -- 
> 2.18.1

-- 
Michal Hocko
SUSE Labs
