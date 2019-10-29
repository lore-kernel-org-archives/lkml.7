Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E358CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B6B2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572362155;
	bh=aF+LM3KxiCVPNSCejHnFLeLQ2+Drg3dy2zQ0J2GugPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KI9FfUaHAXuBMIxZEc4m+PbkTaamMADNRO9eMf3WMLxvS9HUfW/opYnJyQDuvsjNB
	 y9S+5HWM/AGMorOvNKLV/f68lgTYDElmGXiawVKnJ/ngmsnLCRDSLgCFD3hWps+kUM
	 kLTY1JWw7qxCFQSXr9r99t4S2K8Ee0ouodZ1rIUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390032AbfJ2PPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:15:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:39132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389924AbfJ2PPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:15:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D09A9B1F5;
        Tue, 29 Oct 2019 15:15:50 +0000 (UTC)
Date:   Tue, 29 Oct 2019 16:15:49 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20191029151549.GO31513@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com>
 <20190927074803.GB26848@dhcp22.suse.cz>
 <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
 <20190930112817.GC15942@dhcp22.suse.cz>
 <20191001054343.GA15624@dhcp22.suse.cz>
 <20191001083743.GC15624@dhcp22.suse.cz>
 <20191018141550.GS5017@dhcp22.suse.cz>
 <53c4a6ca-a4d0-0862-8744-f999b17d82d8@suse.cz>
 <alpine.DEB.2.21.1910241156370.130350@chino.kir.corp.google.com>
 <08a3f4dd-c3ce-0009-86c5-9ee51aba8557@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a3f4dd-c3ce-0009-86c5-9ee51aba8557@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29-10-19 15:14:59, Vlastimil Babka wrote:
> >From 4c3a2217d0ee5ead00b1443010d07c664b6ac645 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 1 Oct 2019 14:20:58 +0200
> Subject: [PATCH] mm, thp: tweak reclaim/compaction effort of local-only and
>  all-node allocations
> 
> THP page faults now attempt a __GFP_THISNODE allocation first, which should
> only compact existing free memory, followed by another attempt that can
> allocate from any node using reclaim/compaction effort specified by global
> defrag setting and madvise.
> 
> This patch makes the following changes to the scheme:
> 
> - before the patch, the first allocation relies on a check for pageblock order
>   and __GFP_IO to prevent excessive reclaim. This however affects also the
>   second attempt, which is not limited to single node. Instead of that, reuse
>   the existing check for costly order __GFP_NORETRY allocations, and make sure
>   the first THP attempt uses __GFP_NORETRY. As a side-effect, all costly order
>   __GFP_NORETRY allocations will bail out if compaction needs reclaim, while
>   previously they only bailed out when compaction was deferred due to previous
>   failures. This should be still acceptable within the __GFP_NORETRY semantics.
> 
> - before the patch, the second allocation attempt (on all nodes) was passing
>   __GFP_NORETRY. This is redundant as the check for pageblock order (discussed
>   above) was stronger. It's also contrary to madvise(MADV_HUGEPAGE) which means
>   some effort to allocate THP is requested. After this patch, the second
>   attempt doesn't pass __GFP_THISNODE nor __GFP_NORETRY.
> 
> To sum up, THP page faults now try the following attempts:
> 
> 1. local node only THP allocation with no reclaim, just compaction.
> 2. for madvised VMA's or when synchronous compaction is enabled always - THP
>    allocation from any node with effort determined by global defrag setting
>    and VMA madvise
> 3. fallback to base pages on any node
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

I've given this a try and here are the results of my previous testcase
(memory full of page cache).
root@test1:~# sh thp_test.sh 
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 18.5235 s, 58.0 MB/s
+ date +%s
+ TS=1572361069
+ cp /proc/vmstat vmstat.1572361069.before
+ numactl --preferred 1 ./mem_eater nowait 400M
7f959336a000-7f95ac36a000 rw-p 00000000 00:00 0 
Size:             409600 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:              409600 kB
Pss:              409600 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:    409600 kB
Referenced:       208296 kB
Anonymous:        409600 kB
LazyFree:              0 kB
AnonHugePages:    407552 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:            1
7f959336a000 prefer:1 anon=102400 dirty=102400 active=52074 N0=32768 N1=69632 kernelpagesize_kB=4
+ cp /proc/vmstat vmstat.1572361069.after
AnonHugePages:    407552 kB
7f590e2b3000 prefer:1 anon=102400 dirty=102400 active=61619 N0=45235 N1=57165 kernelpagesize_kB=4
AnonHugePages:    407552 kB
7f8667e9a000 prefer:1 anon=102400 dirty=102400 active=52378 N0=6144 N1=96256 kernelpagesize_kB=4

So the THP utilization is back to 100% (modulo alignment) and the node
locality is 55%-94% - with an obviously high variance based on the
kswapd activity in line with the kswapd based feedback backoff. All that
with a high THP utilization which sounds like an approvement. The code
is definitely less hackish so I would go with it for the time being. I
still believe that we have a more fundamental problem to deal with
though. All these open coded fallback allocations just point out that
our allocator doesn't cooperate with he kcompactd properly and that
should be fixed longterm.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/mempolicy.c  | 10 +++++++---
>  mm/page_alloc.c | 24 +++++-------------------
>  2 files changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4ae967bcf954..ed6fbc5b1e20 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2129,18 +2129,22 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  		nmask = policy_nodemask(gfp, pol);
>  		if (!nmask || node_isset(hpage_node, *nmask)) {
>  			mpol_cond_put(pol);
> +			/*
> +			 * First, try to allocate THP only on local node, but
> +			 * don't reclaim unnecessarily, just compact.
> +			 */
>  			page = __alloc_pages_node(hpage_node,
> -						gfp | __GFP_THISNODE, order);
> +				gfp | __GFP_THISNODE | __GFP_NORETRY, order);
>  
>  			/*
>  			 * If hugepage allocations are configured to always
>  			 * synchronous compact or the vma has been madvised
>  			 * to prefer hugepage backing, retry allowing remote
> -			 * memory as well.
> +			 * memory with both reclaim and compact as well.
>  			 */
>  			if (!page && (gfp & __GFP_DIRECT_RECLAIM))
>  				page = __alloc_pages_node(hpage_node,
> -						gfp | __GFP_NORETRY, order);
> +								gfp, order);
>  
>  			goto out;
>  		}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ecc3dbad606b..36d7d852f7b1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4473,8 +4473,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		if (page)
>  			goto got_pg;
>  
> -		 if (order >= pageblock_order && (gfp_mask & __GFP_IO) &&
> -		     !(gfp_mask & __GFP_RETRY_MAYFAIL)) {
> +		/*
> +		 * Checks for costly allocations with __GFP_NORETRY, which
> +		 * includes some THP page fault allocations
> +		 */
> +		if (costly_order && (gfp_mask & __GFP_NORETRY)) {
>  			/*
>  			 * If allocating entire pageblock(s) and compaction
>  			 * failed because all zones are below low watermarks
> @@ -4495,23 +4498,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  			if (compact_result == COMPACT_SKIPPED ||
>  			    compact_result == COMPACT_DEFERRED)
>  				goto nopage;
> -		}
> -
> -		/*
> -		 * Checks for costly allocations with __GFP_NORETRY, which
> -		 * includes THP page fault allocations
> -		 */
> -		if (costly_order && (gfp_mask & __GFP_NORETRY)) {
> -			/*
> -			 * If compaction is deferred for high-order allocations,
> -			 * it is because sync compaction recently failed. If
> -			 * this is the case and the caller requested a THP
> -			 * allocation, we do not want to heavily disrupt the
> -			 * system, so we fail the allocation instead of entering
> -			 * direct reclaim.
> -			 */
> -			if (compact_result == COMPACT_DEFERRED)
> -				goto nopage;
>  
>  			/*
>  			 * Looks like reclaim/compaction is worth trying, but
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
