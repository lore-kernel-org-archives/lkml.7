Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050F5C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA96B21872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555070379;
	bh=7y4aLtSkAuA6CptoW5FxFJlKtisRm17JWiKrEtj1uE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ovQPUVagfq1+HE0X7r09c3/8km2EG5ksR1/Sh2qvjkE67FX1Zo+51jPalHiefM5nP
	 DYlQbd9c6YVIKOfNRWRvmmFMHK10uCx4plv63dzOS2bMB7CgQtuWCIL+ytLkq8AlE/
	 RqpZI6gvfoXP5M6SYsdxxzJBBhd8ux6/L3lRyQgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfDLL7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:59:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:45300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbfDLL7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:59:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0577EAA85;
        Fri, 12 Apr 2019 11:59:35 +0000 (UTC)
Date:   Fri, 12 Apr 2019 13:59:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: treat CMA pages as unmovable
Message-ID: <20190412115934.GC5223@dhcp22.suse.cz>
References: <20190411213124.8254-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411213124.8254-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-04-19 17:31:24, Qian Cai wrote:
> When offlining a memory block that contains reserved CMA areas, it will
> set those page blocks migration type as MIGRATE_ISOLATE. Then, onlining
> will set them as MIGRATE_MOVABLE. As the results, those page blocks lose
> their original types, i.e., MIGRATE_CMA, and then it causes troubles
> like accounting for CMA areas becomes inconsist,

Yes migrate type based accounting sucks. Joonsoo had a patch to use a
(movable) zone for that purpose. Anyway the above description is not
really easy to grasp. At least it was not for me. Because there are
mutlitple things going on here. I would suggest something like the
following:

: has_unmovable_pages is used by both CMA allocator and the memory
: hotplug. The later doesn't know how to offline CMA pool properly
: now but if an unused (free) CMA page is encountered then
: has_unmovable_pages happily considers it as a free memory and propagates
: this up the call chain. Memory offlining code then frees the page
: without a proper CMA tear down which leads to an accounting issues.
: Moreover if the same memory range is onlined again then the memory never
: gets back to the CMA pool.
: 
: State after memory offline
:  # grep cma /proc/vmstat
:  nr_free_cma 205824
: 
:  # cat /sys/kernel/debug/cma/cma-kvm_cma/count
:  209920
: 
And continue with the following kmemleak splat

> Also, kmemleak still think those memory address are reserved but have
> already been used by the buddy allocator after onlining.
> 
> Offlined Pages 4096
> kmemleak: Cannot insert 0xc000201f7d040008 into the object search tree
> (overlaps existing)
> Call Trace:
> [c00000003dc2faf0] [c000000000884b2c] dump_stack+0xb0/0xf4 (unreliable)
> [c00000003dc2fb30] [c000000000424fb4] create_object+0x344/0x380
> [c00000003dc2fbf0] [c0000000003d178c] __kmalloc_node+0x3ec/0x860
> [c00000003dc2fc90] [c000000000319078] kvmalloc_node+0x58/0x110
> [c00000003dc2fcd0] [c000000000484d9c] seq_read+0x41c/0x620
> [c00000003dc2fd60] [c0000000004472bc] __vfs_read+0x3c/0x70
> [c00000003dc2fd80] [c0000000004473ac] vfs_read+0xbc/0x1a0
> [c00000003dc2fdd0] [c00000000044783c] ksys_read+0x7c/0x140
> [c00000003dc2fe20] [c00000000000b108] system_call+0x5c/0x70
> kmemleak: Kernel memory leak detector disabled
> kmemleak: Object 0xc000201cc8000000 (size 13757317120):
> kmemleak:   comm "swapper/0", pid 0, jiffies 4294937297
> kmemleak:   min_count = -1
> kmemleak:   count = 0
> kmemleak:   flags = 0x5
> kmemleak:   checksum = 0
> kmemleak:   backtrace:
>      cma_declare_contiguous+0x2a4/0x3b0
>      kvm_cma_reserve+0x11c/0x134
>      setup_arch+0x300/0x3f8
>      start_kernel+0x9c/0x6e8
>      start_here_common+0x1c/0x4b0
> kmemleak: Automatic memory scanning thread ended
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/page_alloc.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d96ca5bc555b..896db9241fa6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8015,14 +8015,18 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  	 * can still lead to having bootmem allocations in zone_movable.
>  	 */
>  
> -	/*
> -	 * CMA allocations (alloc_contig_range) really need to mark isolate
> -	 * CMA pageblocks even when they are not movable in fact so consider
> -	 * them movable here.
> -	 */
> -	if (is_migrate_cma(migratetype) &&
> -			is_migrate_cma(get_pageblock_migratetype(page)))
> -		return false;
> +	if (is_migrate_cma(get_pageblock_migratetype(page))) {
> +		/*
> +		 * CMA allocations (alloc_contig_range) really need to mark
> +		 * isolate CMA pageblocks even when they are not movable in fact
> +		 * so consider them movable here.
> +		 */
> +		if (is_migrate_cma(migratetype))
> +			return false;
> +
> +		pr_warn("page: %px is in CMA", page);
> +		return true;

you want goto unmovable here. dum_page doesn't print the migrate type so
we will need to make the dump reason conditional defaulting to "unmovable page"
and overriding it to "CMA page" in this path.

Other than that the patch looks reasonable to me. I hate this special
casing here but this falls into the same bucket with 4da2ce250f986.

Thanks!

> +	}
>  
>  	pfn = page_to_pfn(page);
>  	for (found = 0, iter = 0; iter < pageblock_nr_pages; iter++) {
> -- 
> 2.20.1 (Apple Git-117)

-- 
Michal Hocko
SUSE Labs
