Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52769C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAE721473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfEVPBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:01:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:54214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727975AbfEVPBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:01:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 260D8B009;
        Wed, 22 May 2019 15:01:44 +0000 (UTC)
Subject: Re: [PATCH] proc/meminfo: add MemKernel counter
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <155853600919.381.8172097084053782598.stgit@buzz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <529aa7fd-2dc2-6979-4ea0-d40dfc7e3fde@suse.cz>
Date:   Wed, 22 May 2019 17:01:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155853600919.381.8172097084053782598.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/19 4:40 PM, Konstantin Khlebnikov wrote:
> Some kinds of kernel allocations are not accounted or not show in meminfo.
> For example vmalloc allocations are tracked but overall size is not shown

I think Roman's vmalloc patch [1] is on its way?

> for performance reasons. There is no information about network buffers.

xfs buffers can also occupy a lot, from my experience

> In most cases detailed statistics is not required. At first place we need
> information about overall kernel memory usage regardless of its structure.
> 
> This patch estimates kernel memory usage by subtracting known sizes of
> free, anonymous, hugetlb and caches from total memory size: MemKernel =
> MemTotal - MemFree - Buffers - Cached - SwapCached - AnonPages - Hugetlb.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

I've tried this once in [2]. The name was Unaccounted and one of the objections
was that people would get worried. Yours is a bit better, perhaps MemKernMisc
would be even more descriptive? Michal Hocko worried about maintainability, that
we forget something, but I don't think that's a big issue.

Vlastimil

[1] https://lore.kernel.org/linux-mm/20190514235111.2817276-2-guro@fb.com/T/#u
[2] https://lore.kernel.org/linux-mm/20161020121149.9935-1-vbabka@suse.cz/T/#u

> ---
>  Documentation/filesystems/proc.txt |    5 +++++
>  fs/proc/meminfo.c                  |   20 +++++++++++++++-----
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> index 66cad5c86171..a0ab7f273ea0 100644
> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -860,6 +860,7 @@ varies by architecture and compile options.  The following is from a
>  
>  MemTotal:     16344972 kB
>  MemFree:      13634064 kB
> +MemKernel:      862600 kB
>  MemAvailable: 14836172 kB
>  Buffers:          3656 kB
>  Cached:        1195708 kB
> @@ -908,6 +909,10 @@ MemAvailable: An estimate of how much memory is available for starting new
>                page cache to function well, and that not all reclaimable
>                slab will be reclaimable, due to items being in use. The
>                impact of those factors will vary from system to system.
> +   MemKernel: The sum of all kinds of kernel memory allocations: Slab,
> +              Vmalloc, Percpu, KernelStack, PageTables, socket buffers,
> +              and some other untracked allocations. Does not include
> +              MemFree, Buffers, Cached, SwapCached, AnonPages, Hugetlb.
>       Buffers: Relatively temporary storage for raw disk blocks
>                shouldn't get tremendously large (20MB or so)
>        Cached: in-memory cache for files read from the disk (the
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 568d90e17c17..b27d56dd619a 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -39,17 +39,27 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	long available;
>  	unsigned long pages[NR_LRU_LISTS];
>  	unsigned long sreclaimable, sunreclaim;
> +	unsigned long anon_pages, file_pages, swap_cached;
> +	long kernel_pages;
>  	int lru;
>  
>  	si_meminfo(&i);
>  	si_swapinfo(&i);
>  	committed = percpu_counter_read_positive(&vm_committed_as);
>  
> -	cached = global_node_page_state(NR_FILE_PAGES) -
> -			total_swapcache_pages() - i.bufferram;
> +	anon_pages = global_node_page_state(NR_ANON_MAPPED);
> +	file_pages = global_node_page_state(NR_FILE_PAGES);
> +	swap_cached = total_swapcache_pages();
> +
> +	cached = file_pages - swap_cached - i.bufferram;
>  	if (cached < 0)
>  		cached = 0;
>  
> +	kernel_pages = i.totalram - i.freeram - anon_pages - file_pages -
> +		       hugetlb_total_pages();
> +	if (kernel_pages < 0)
> +		kernel_pages = 0;
> +
>  	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
>  		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
>  
> @@ -60,9 +70,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	show_val_kb(m, "MemTotal:       ", i.totalram);
>  	show_val_kb(m, "MemFree:        ", i.freeram);
>  	show_val_kb(m, "MemAvailable:   ", available);
> +	show_val_kb(m, "MemKernel:      ", kernel_pages);
>  	show_val_kb(m, "Buffers:        ", i.bufferram);
>  	show_val_kb(m, "Cached:         ", cached);
> -	show_val_kb(m, "SwapCached:     ", total_swapcache_pages());
> +	show_val_kb(m, "SwapCached:     ", swap_cached);
>  	show_val_kb(m, "Active:         ", pages[LRU_ACTIVE_ANON] +
>  					   pages[LRU_ACTIVE_FILE]);
>  	show_val_kb(m, "Inactive:       ", pages[LRU_INACTIVE_ANON] +
> @@ -92,8 +103,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  		    global_node_page_state(NR_FILE_DIRTY));
>  	show_val_kb(m, "Writeback:      ",
>  		    global_node_page_state(NR_WRITEBACK));
> -	show_val_kb(m, "AnonPages:      ",
> -		    global_node_page_state(NR_ANON_MAPPED));
> +	show_val_kb(m, "AnonPages:      ", anon_pages);
>  	show_val_kb(m, "Mapped:         ",
>  		    global_node_page_state(NR_FILE_MAPPED));
>  	show_val_kb(m, "Shmem:          ", i.sharedram);
> 

