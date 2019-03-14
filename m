Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E6DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C0121855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCNIJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:09:24 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:10937 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbfCNIJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:09:24 -0400
Received: by suse.de (Postfix, from userid 1000)
        id CB6F94571; Thu, 14 Mar 2019 09:09:22 +0100 (CET)
Date:   Thu, 14 Mar 2019 09:09:22 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hotplug: fix offline undo_isolate_page_range()
Message-ID: <20190314080922.dk5ljg7fbtarzrog@d104.suse.de>
References: <20190313143133.46200-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313143133.46200-1-cai@lca.pw>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 10:31:33AM -0400, Qian Cai wrote:
> Also, after calling the "useless" undo_isolate_page_range() here, it
> reaches the point of no returning by notifying MEM_OFFLINE. Those pages
> will be marked as MIGRATE_MOVABLE again once onlining. The only thing
> left to do is to decrease the number of isolated pageblocks zone
> counter which would make some paths of the page allocation slower that
> the above commit introduced. A memory block is usually at most 1GiB in
> size, so an "int" should be enough to represent the number of pageblocks
> in a block. Fix an incorrect comment along the way.

Well, x86_64's memblocks can be up to 2GB depending on the memory we got.
Plus the fact that alloc_contig_range can be used to isolate 16GB-hugetlb
pages on powerpc, and that could be a lot of pageblocks.

While an "int" could still hold, I think we should use "long" just to be
more future-proof.

> 
> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: return the nubmer of isolated pageblocks in start_isolate_page_range() per
>     Oscar; take the zone lock when undoing zone->nr_isolate_pageblock per
>     Michal.
> 
>  mm/memory_hotplug.c | 17 +++++++++++++----
>  mm/page_alloc.c     |  2 +-
>  mm/page_isolation.c | 16 ++++++++++------
>  mm/sparse.c         |  2 +-
>  4 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index cd23c081924d..8ffe844766da 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1580,7 +1580,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  {
>  	unsigned long pfn, nr_pages;
>  	long offlined_pages;
> -	int ret, node;
> +	int ret, node, count;

I would rather use a meaningful name here, like "nr_isolated_pageblocks" or
something like that.
 

-- 
Oscar Salvador
SUSE L3
