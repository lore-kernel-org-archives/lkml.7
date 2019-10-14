Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003F0C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE78F2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571042663;
	bh=TTJMNaPXxhF46AHB9z6rS89KmtEIreG9wWYxyCTYSvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PoKalBT8rzPgKMt3zQSlKOZVQag4l5B17uATmciB+S3XJ8EVfOw1nf7XPutTZgXO8
	 2o87sHcCF5u92k4TrMmFmWGK9TIx/txFQxNcPyeMyOzab2eesXBdjdWFAOJTmQP2+b
	 8H2nBjXNQ35L+4Q3f6NS3L/lTf4Wakyp+inEcXmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfJNIoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:44:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:41946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729234AbfJNIoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:44:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B625ACE3;
        Mon, 14 Oct 2019 08:44:20 +0000 (UTC)
Date:   Mon, 14 Oct 2019 10:44:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-mm@kvack.org, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mm/page_owner: Don't access uninitialized memmaps
 when reading /proc/pagetypeinfo
Message-ID: <20191014084419.GB317@dhcp22.suse.cz>
References: <20191011140638.8160-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011140638.8160-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-10-19 16:06:38, David Hildenbrand wrote:
> From: Qian Cai <cai@lca.pw>
> 
> Uninitialized memmaps contain garbage and in the worst case trigger
> kernel BUGs, especially with CONFIG_PAGE_POISONING. They should not get
> touched.
> 
> For example, when not onlining a memory block that is spanned by a zone
> and reading /proc/pagetypeinfo with CONFIG_DEBUG_VM_PGFLAGS and
> CONFIG_PAGE_POISONING, we can trigger a kernel BUG:
> 
> :/# echo 1 > /sys/devices/system/memory/memory40/online
> :/# echo 1 > /sys/devices/system/memory/memory42/online
> :/# cat /proc/pagetypeinfo > test.file
>   [   42.489856] page:fffff2c585200000 is uninitialized and poisoned
>   [   42.489861] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
>   [   42.492235] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
>   [   42.493501] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>   [   42.494533] There is not page extension available.
>   [   42.495358] ------------[ cut here ]------------
>   [   42.496163] kernel BUG at include/linux/mm.h:1107!
>   [   42.497069] invalid opcode: 0000 [#1] SMP NOPTI
> 
> Please not that this change does not affect ZONE_DEVICE, because
> pagetypeinfo_showmixedcount_print() is called from
> mm/vmstat.c:pagetypeinfo_showmixedcount() only for populated zones, and
> ZONE_DEVICE is never populated (zone->present_pages always 0).
> 
> Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visible after d0dc12e86b319
> Signed-off-by: Qian Cai <cai@lca.pw>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Miles Chen <miles.chen@mediatek.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [ move check to outer loop, add comment, rephrase description ]
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> 
> Cai asked me to follow up on:
> 	[PATCH] mm/page_owner: fix a crash after memory offline
> 
> ---
>  mm/page_owner.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index dee931184788..7d149211f6be 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -284,7 +284,8 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>  	 * not matter as the mixed block count will still be correct
>  	 */
>  	for (; pfn < end_pfn; ) {
> -		if (!pfn_valid(pfn)) {
> +		page = pfn_to_online_page(pfn);
> +		if (!page) {
>  			pfn = ALIGN(pfn + 1, MAX_ORDER_NR_PAGES);
>  			continue;
>  		}
> @@ -292,13 +293,13 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>  		block_end_pfn = ALIGN(pfn + 1, pageblock_nr_pages);
>  		block_end_pfn = min(block_end_pfn, end_pfn);
>  
> -		page = pfn_to_page(pfn);
>  		pageblock_mt = get_pageblock_migratetype(page);
>  
>  		for (; pfn < block_end_pfn; pfn++) {
>  			if (!pfn_valid_within(pfn))
>  				continue;
>  
> +			/* The pageblock is online, no need to recheck. */
>  			page = pfn_to_page(pfn);
>  
>  			if (page_zone(page) != zone)
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
