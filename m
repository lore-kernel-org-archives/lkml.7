Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6560ECA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393B82084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571670162;
	bh=DqEhKJfH7uJ8EHcQnsA3moMseuxgMIJR1Y3HofZOvRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dtgp6yQ4lLnKsAHfHFOqlDY8j9HSmV5SlNa0G4iA++Px3Tyj7yMYwGJ5vdUnaZSJH
	 i8Y/DnybEARqgTg0f9bLkfiqpnqpHkwlEVant6IUwUNnp4pXBN8lmK13hfXeHczfma
	 3jLGqustLny+9GeZWqOBEhMSaNxgbfAkD0E9KnWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfJUPCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:02:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:53670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfJUPCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:02:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18F6CB2E9;
        Mon, 21 Oct 2019 15:02:38 +0000 (UTC)
Date:   Mon, 21 Oct 2019 17:02:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH v1 2/2] mm/page_isolation.c: Convert SKIP_HWPOISON to
 MEMORY_OFFLINE
Message-ID: <20191021150237.GU9379@dhcp22.suse.cz>
References: <20191021141927.10252-1-david@redhat.com>
 <20191021141927.10252-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021141927.10252-3-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 16:19:26, David Hildenbrand wrote:
> We have two types of users of page isolation:
> 1. Memory offlining: Offline memory so it can be unplugged. Memory won't
> 		     be touched.
> 2. Memory allocation: Allocate memory (e.g., alloc_contig_range()) to
> 		      become the owner of the memory and make use of it.
> 
> For example, in case we want to offline memory, we can ignore (skip over)
> PageHWPoison() pages, as the memory won't get used. We can allow to
> offline memory. In contrast, we don't want to allow to allocate such
> memory.
> 
> Let's generalize the approach so we can special case other types of
> pages we want to skip over in case we offline memory. While at it, also
> pass the same flags to test_pages_isolated().
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pingfan Liu <kernelfans@gmail.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Yes, a highlevel flag makes more sense than requesting specific types of
pages to skip over.

Acked-by: Michal Hocko <mhocko@suse.com>

Please make the code easier to follow ...
> ---
>  include/linux/page-isolation.h |  4 ++--
>  mm/memory_hotplug.c            |  8 +++++---
>  mm/page_alloc.c                |  4 ++--
>  mm/page_isolation.c            | 12 ++++++------
>  4 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bf6b21f02154..b44712c7fdd7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8270,7 +8270,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  		 * The HWPoisoned page may be not in buddy system, and
>  		 * page_count() is not 0.
>  		 */
> -		if ((flags & SKIP_HWPOISON) && PageHWPoison(page))
> +		if (flags & MEMORY_OFFLINE && PageHWPoison(page))
>  			continue;
>  
>  		if (__PageMovable(page))
[...]
> @@ -257,7 +258,7 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>   */
>  static unsigned long
>  __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
> -				  bool skip_hwpoisoned_pages)
> +				  int flags)
>  {
>  	struct page *page;
>  
> @@ -274,7 +275,7 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
>  			 * simple way to verify that as VM_BUG_ON(), though.
>  			 */
>  			pfn += 1 << page_order(page);
> -		else if (skip_hwpoisoned_pages && PageHWPoison(page))
> +		else if (flags & MEMORY_OFFLINE && PageHWPoison(page))
>  			/* A HWPoisoned page cannot be also PageBuddy */
>  			pfn++;
>  		else

.. and use parentheses for the flag check.
-- 
Michal Hocko
SUSE Labs
