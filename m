Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA61C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C604420872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfDQN4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:56:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:38716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729453AbfDQN4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:56:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8794BB177;
        Wed, 17 Apr 2019 13:56:35 +0000 (UTC)
Message-ID: <1555509378.3139.35.camel@suse.de>
Subject: Re: [PATCH v1 3/4] mm/memory_hotplug: Make __remove_section() never
 fail
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Wei Yang <richard.weiyang@gmail.com>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Date:   Wed, 17 Apr 2019 15:56:18 +0200
In-Reply-To: <20190409100148.24703-4-david@redhat.com>
References: <20190409100148.24703-1-david@redhat.com>
         <20190409100148.24703-4-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-09 at 12:01 +0200, David Hildenbrand wrote:
> Let's just warn in case a section is not valid instead of failing to
> remove somewhere in the middle of the process, returning an error
> that
> will be mostly ignored by callers.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Just a nit:

I think this could be combined with patch#2.
The only reason to fail in here is 1) !valid_section 2)
!present_section.
As I stated in patch#2, one cannot be without the other, so makes sense
to rip present_section check from unregister_mem_section() as well.
Then, you could combine both changelogs explaining the whole thing, and
why we do not need the present_section check either.

But the change looks good to me:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b0cb05748f99..17a60281c36f 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -517,15 +517,15 @@ static void __remove_zone(struct zone *zone,
> unsigned long start_pfn)
>  	pgdat_resize_unlock(zone->zone_pgdat, &flags);
>  }
>  
> -static int __remove_section(struct zone *zone, struct mem_section
> *ms,
> -		unsigned long map_offset, struct vmem_altmap
> *altmap)
> +static void __remove_section(struct zone *zone, struct mem_section
> *ms,
> +			     unsigned long map_offset,
> +			     struct vmem_altmap *altmap)
>  {
>  	unsigned long start_pfn;
>  	int scn_nr;
> -	int ret = -EINVAL;
>  
> -	if (!valid_section(ms))
> -		return ret;
> +	if (WARN_ON_ONCE(!valid_section(ms)))
> +		return;
>  
>  	unregister_memory_section(ms);
>  
> @@ -534,7 +534,6 @@ static int __remove_section(struct zone *zone,
> struct mem_section *ms,
>  	__remove_zone(zone, start_pfn);
>  
>  	sparse_remove_one_section(zone, ms, map_offset, altmap);
> -	return 0;
>  }
>  
>  /**
> @@ -554,7 +553,7 @@ int __remove_pages(struct zone *zone, unsigned
> long phys_start_pfn,
>  {
>  	unsigned long i;
>  	unsigned long map_offset = 0;
> -	int sections_to_remove, ret = 0;
> +	int sections_to_remove;
>  
>  	/* In the ZONE_DEVICE case device driver owns the memory
> region */
>  	if (is_dev_zone(zone)) {
> @@ -575,16 +574,13 @@ int __remove_pages(struct zone *zone, unsigned
> long phys_start_pfn,
>  		unsigned long pfn = phys_start_pfn +
> i*PAGES_PER_SECTION;
>  
>  		cond_resched();
> -		ret = __remove_section(zone, __pfn_to_section(pfn),
> map_offset,
> -				altmap);
> +		__remove_section(zone, __pfn_to_section(pfn),
> map_offset,
> +				 altmap);
>  		map_offset = 0;
> -		if (ret)
> -			break;
>  	}
>  
>  	set_zone_contiguous(zone);
> -
> -	return ret;
> +	return 0;
>  }
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
-- 
Oscar Salvador
SUSE L3
