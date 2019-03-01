Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B474FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CAA20848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="UFvJspbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbfCARtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:49:11 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43403 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfCARtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:49:11 -0500
Received: by mail-yw1-f67.google.com with SMTP id u200so14656024ywu.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=11xNCc8IrOYfkLVZn22iPNSqD9ucT1z6EjvhCqx5vjI=;
        b=UFvJspbTfkqlHqDrYdWhe5S6LUIIFl0SGfaQCApCRonuwd4wCDh2VCVKndlEMmlpNw
         m5kNR+LvXBnHiK9MtypF1tCq6xxaNJs6HfrbDx1UnUsxko6z3hoPlCTeHQl5JzM79Q3f
         fFulzQhpUXj6QCGKOgdwt1E8c26c0A5p39fOeQ2pUFtj5rOoSLjeMKh15KYBEGBZkN7y
         XOAnpzdIVzL3aPATYn1WXFRsgAEs2LfFvQsRVThIKk84955/jJCqfuIDZkx+qT+Tc+0D
         /bqOprTqayGFrxB0QVgii38rPjMJqtxGB9a3rcwC5bYdwAHyT6DjphzxNHPGPBbI8EbB
         XpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=11xNCc8IrOYfkLVZn22iPNSqD9ucT1z6EjvhCqx5vjI=;
        b=kDGCx1KYcycn1ak44eJChajPaFyPfRIxU0qDFJhrOk/hyLEItOArZ/00HDUzHfKe8h
         JIXgwZljEBfEcdF/vEzJBkGfIXGXUFO7DjeX+soJvrICnEYU4yVZyz0aTm3fKL6rCMiO
         uBeW3uAvJWUHmfohvmw5N4xO7YfdAvjFQ9UzXRM7PgoaM7LoNSxXZuBk4pk5BMTn4HZa
         ILrusi9C6PqTcUm7Xkc/+U+5Fk36CB+2SVQulC9gN77lxUnbqhTMYXCUL8JHW1FsPrQ1
         HBBKsf3+y21XqKEJPl5vYfimRrPI6pDxxNGgXxIhyb8QXBz2eTaQStoHhEKKo4jYC8W6
         Td8Q==
X-Gm-Message-State: APjAAAWtFyWM+xpkjhEfmRfMc990wzmyiZH4AQtLSf1gKyh9lzLYsZzN
        fl6oy94LAtMg+gtFG/eM2/UiEA==
X-Google-Smtp-Source: APXvYqztEKe8TaVu2Tliq0vif6ubNgSPgSSdbOYf0dtEXLxGIeGgpc9ZwkmYSOMRDlDAOjnIxbmesg==
X-Received: by 2002:a0d:e20b:: with SMTP id l11mr4719746ywe.1.1551462549671;
        Fri, 01 Mar 2019 09:49:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::3:5a5b])
        by smtp.gmail.com with ESMTPSA id h131sm11156688ywa.81.2019.03.01.09.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 09:49:08 -0800 (PST)
Date:   Fri, 1 Mar 2019 12:49:07 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH RFC] mm/vmscan: try to protect active working set of
 cgroup from reclaim.
Message-ID: <20190301174907.GA2375@cmpxchg.org>
References: <20190222175825.18657-1-aryabinin@virtuozzo.com>
 <20190222191552.GA15922@cmpxchg.org>
 <f752c208-599c-9b5a-bc42-e4282df43616@virtuozzo.com>
 <7c915942-6f52-e7a4-b879-e4c99dd65968@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c915942-6f52-e7a4-b879-e4c99dd65968@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrey,

On Fri, Mar 01, 2019 at 01:38:26PM +0300, Andrey Ryabinin wrote:
> On 2/26/19 3:50 PM, Andrey Ryabinin wrote:
> > On 2/22/19 10:15 PM, Johannes Weiner wrote:
> >> On Fri, Feb 22, 2019 at 08:58:25PM +0300, Andrey Ryabinin wrote:
> >>> In a presence of more than 1 memory cgroup in the system our reclaim
> >>> logic is just suck. When we hit memory limit (global or a limit on
> >>> cgroup with subgroups) we reclaim some memory from all cgroups.
> >>> This is sucks because, the cgroup that allocates more often always wins.
> >>> E.g. job that allocates a lot of clean rarely used page cache will push
> >>> out of memory other jobs with active relatively small all in memory
> >>> working set.
> >>>
> >>> To prevent such situations we have memcg controls like low/max, etc which
> >>> are supposed to protect jobs or limit them so they to not hurt others.
> >>> But memory cgroups are very hard to configure right because it requires
> >>> precise knowledge of the workload which may vary during the execution.
> >>> E.g. setting memory limit means that job won't be able to use all memory
> >>> in the system for page cache even if the rest the system is idle.
> >>> Basically our current scheme requires to configure every single cgroup
> >>> in the system.
> >>>
> >>> I think we can do better. The idea proposed by this patch is to reclaim
> >>> only inactive pages and only from cgroups that have big
> >>> (!inactive_is_low()) inactive list. And go back to shrinking active lists
> >>> only if all inactive lists are low.
> >>
> >> Yes, you are absolutely right.
> >>
> >> We shouldn't go after active pages as long as there are plenty of
> >> inactive pages around. That's the global reclaim policy, and we
> >> currently fail to translate that well to cgrouped systems.
> >>
> >> Setting group protections or limits would work around this problem,
> >> but they're kind of a red herring. We shouldn't ever allow use-once
> >> streams to push out hot workingsets, that's a bug.
> >>
> >>> @@ -2489,6 +2491,10 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
> >>>  
> >>>  		scan >>= sc->priority;
> >>>  
> >>> +		if (!sc->may_shrink_active && inactive_list_is_low(lruvec,
> >>> +						file, memcg, sc, false))
> >>> +			scan = 0;
> >>> +
> >>>  		/*
> >>>  		 * If the cgroup's already been deleted, make sure to
> >>>  		 * scrape out the remaining cache.
> >>> @@ -2733,6 +2739,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >>>  	struct reclaim_state *reclaim_state = current->reclaim_state;
> >>>  	unsigned long nr_reclaimed, nr_scanned;
> >>>  	bool reclaimable = false;
> >>> +	bool retry;
> >>>  
> >>>  	do {
> >>>  		struct mem_cgroup *root = sc->target_mem_cgroup;
> >>> @@ -2742,6 +2749,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >>>  		};
> >>>  		struct mem_cgroup *memcg;
> >>>  
> >>> +		retry = false;
> >>> +
> >>>  		memset(&sc->nr, 0, sizeof(sc->nr));
> >>>  
> >>>  		nr_reclaimed = sc->nr_reclaimed;
> >>> @@ -2813,6 +2822,13 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >>>  			}
> >>>  		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
> >>>  
> >>> +		if ((sc->nr_scanned - nr_scanned) == 0 &&
> >>> +		     !sc->may_shrink_active) {
> >>> +			sc->may_shrink_active = 1;
> >>> +			retry = true;
> >>> +			continue;
> >>> +		}
> >>
> >> Using !scanned as the gate could be a problem. There might be a cgroup
> >> that has inactive pages on the local level, but when viewed from the
> >> system level the total inactive pages in the system might still be low
> >> compared to active ones. In that case we should go after active pages.
> >>
> >> Basically, during global reclaim, the answer for whether active pages
> >> should be scanned or not should be the same regardless of whether the
> >> memory is all global or whether it's spread out between cgroups.
> >>
> >> The reason this isn't the case is because we're checking the ratio at
> >> the lruvec level - which is the highest level (and identical to the
> >> node counters) when memory is global, but it's at the lowest level
> >> when memory is cgrouped.
> >>
> >> So IMO what we should do is:
> >>
> >> - At the beginning of global reclaim, use node_page_state() to compare
> >>   the INACTIVE_FILE:ACTIVE_FILE ratio and then decide whether reclaim
> >>   can go after active pages or not. Regardless of what the ratio is in
> >>   individual lruvecs.
> >>
> >> - And likewise at the beginning of cgroup limit reclaim, walk the
> >>   subtree starting at sc->target_mem_cgroup, sum up the INACTIVE_FILE
> >>   and ACTIVE_FILE counters, and make inactive_is_low() decision on
> >>   those sums.
> >>
> > 
> > Sounds reasonable.
> > 
> 
> On the second thought it seems to be better to keep the decision on lru level.
> There are couple reasons for this:
> 
> 1) Using bare node_page_state() (or sc->targe_mem_cgroup's total_[in]active counters) would be wrong.
>  Because some cgroups might have protection set (memory.low) and we must take it into account. Also different
> cgroups have different available swap space/memory.swappiness and it must be taken into account as well to.
>
> So it has to be yet another full memcg-tree iteration.

It should be possible to take that into account on the first iteration
and adjust the inactive/active counters in proportion to how much of
the cgroup's total memory is exempt by memory.low or min, right?

> 2) Let's consider simple case. Two cgroups, one with big 'active' set of pages the other allocates one-time used pages.
> So the total inactive is low, thus checking inactive ratio on higher level will result in reclaiming pages.
> While with check on lru-level only inactive will be reclaimed.

It's the other way around. Let's say you have two cgroups, A and B:

        A:  500M inactive   10G active -> inactive is low
        B:   10G inactive  500M active -> inactive is NOT low
   ----------------------------------------------------------
   global: 10.5G inactive 10.5G active -> inactive is NOT low

Checking locally will scan active pages from A. Checking globally will
not, because there is plenty of use-once pages from B.

So if you check globally, without any protection, A and B compete
evenly during global reclaim. Under the same reclaim pressure, A has
managed to activate most of its pages whereas B has not. That means A
is hotter and B provides the better reclaim candidates.

If you apply this decision locally, on the other hand, you are no
longer aging the groups at the same rate. And then the LRU orders
between groups will no longer be comparable, and you won't be
reclaiming the coldest memory in the system anymore.
