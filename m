Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76109C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B9120865
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574687390;
	bh=SJMvakbloMz9BgZEGw+AndDXoIuu0OOXnZkRAPqB0yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SthBcIYzYvnmrPmyurAR40sGydfmnvClRvqG93OpfI5sxxIOC0rozL41DW+TVk8X2
	 lyS+9sW4G6otcG9wKod5cgrCynCy9DGL4SPGVo1CyoH6M3/5J6u8fODPPRuofvICoZ
	 AH40sREdb/0D21niFEr/FNl/ER+gOOuSVIzKSND0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfKYNJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:09:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50194 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:09:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id l17so15375304wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 05:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tXx7WnuouGGUhU/NauClYeqNcJKDC+7DsxfDWyLw9b8=;
        b=l9x8aFLqv6ahu0QKuZTxUh7xaIypl1qJRTjUfM0tth3WkAglnGoDlxFRpWXtQHw7H7
         SOy3JbigM06MTwdheNaix8kdwZ7/XMEE/TTiUrnJoBWnEJGCaiig/NqJHEKHMz2wiK6n
         fEeESuvAnwEAo0gCMFyi7g4jL8gVSAGey8MpwO97En3R3OAKBfvMo5U4VkD4FLdb60cs
         IPrS5tDv0uLa58kl5Tf/V83vdrLZe1HDRYKwsTvcsVTkETQGdcDzykcxR/KZrgTtDPcS
         NW9zW4+ALXKKxza9084iZkG/zdgUd8+oCOCQJ3KNbVMVDiGcszESz+7iY7zWYdURHNZE
         FQ+w==
X-Gm-Message-State: APjAAAUpUuuad0Gtj6fCYNlivMI7kgL2uwqQqcSC4WiqjXRoiBvfEJRR
        rwh8c7/y7bP10kcEjbDLJ24=
X-Google-Smtp-Source: APXvYqxPE12BbUAAm8zMWxonxhdH3x6UEiQLpPMJqAAgTEUuO/hXQuvOTyc261pjH3Tf7Jl4eMfxuQ==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr22003278wmc.131.1574687385598;
        Mon, 25 Nov 2019 05:09:45 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id i127sm8711233wma.35.2019.11.25.05.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:09:44 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:09:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2] mm/memory_hotplug: Don't allow to online/offline
 memory blocks with holes
Message-ID: <20191125130943.GN31714@dhcp22.suse.cz>
References: <20191119115237.6662-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119115237.6662-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-11-19 12:52:37, David Hildenbrand wrote:
> Our onlining/offlining code is unnecessarily complicated. Only memory
> blocks added during boot can have holes (a range that is not
> IORESOURCE_SYSTEM_RAM). Hotplugged memory never has holes (e.g., see
> add_memory_resource()). All memory blocks that belong to boot memory are
> already online.
> 
> Note that boot memory can have holes and the memmap of the holes is marked
> PG_reserved. However, also memory allocated early during boot is
> PG_reserved - basically every page of boot memory that is not given to the
> buddy is PG_reserved.
> 
> Therefore, when we stop allowing to offline memory blocks with holes, we
> implicitly no longer have to deal with onlining memory blocks with holes.
> E.g., online_pages() will do a
> walk_system_ram_range(..., online_pages_range), whereby
> online_pages_range() will effectively only free the memory holes not
> falling into a hole to the buddy. The other pages (holes) are kept
> PG_reserved (via move_pfn_range_to_zone()->memmap_init_zone()).
> 
> This allows to simplify the code. For example, we no longer have to
> worry about marking pages that fall into memory holes PG_reserved when
> onlining memory. We can stop setting pages PG_reserved completely in
> memmap_init_zone().
> 
> Offlining memory blocks added during boot is usually not guaranteed to work
> either way (unmovable data might have easily ended up on that memory during
> boot). So stopping to do that should not really hurt. Also, people are not
> even aware of a setup where onlining/offlining of memory blocks with
> holes used to work reliably (see [1] and [2] especially regarding the
> hotplug path) - I doubt it worked reliably.
> 
> For the use case of offlining memory to unplug DIMMs, we should see no
> change. (holes on DIMMs would be weird).
> 
> Please note that hardware errors (PG_hwpoison) are not memory holes and
> are not affected by this change when offlining.
> 
> [1] https://lkml.org/lkml/2019/10/22/135
> [2] https://lkml.org/lkml/2019/8/14/1365

Please do not use lkml.org links, they tend to break longterm. Use
http://lkml.kernel.org/r/$msg_id instead.

> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

yes this looks sensible. We already do restrict offlining memry blocks
which span multiple zones (e.g. when NUMA nodes are interleaved through
a memblock boundary) so this is not the first restriction like that.
If that allows future changes then let's just try it out and see whether
there are real usecases that needs to handle boottime memory with holes
hotremove.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
> This patch was part of:
> 	[PATCH v1 00/10] mm: Don't mark hotplugged pages PG_reserved
> 	(including ZONE_DEVICE)
> 	-> https://www.spinics.net/lists/linux-driver-devel/msg130042.html
> 
> However, before we can perform the PG_reserved changes, we have to fix
> pfn_to_online_page() in special scenarios first (bootmem and devmem falling
> into a single section). Dan is working on that.
> 
> I propose to give this patch a churn in -next so we can identify if this
> change would break any existing setup. I will then follow up with cleanups
> and the PG_reserved changes later.
> 
> ---
>  mm/memory_hotplug.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 46b2e056a43f..fc617ad6f035 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1455,10 +1455,19 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
>  		node_clear_state(node, N_MEMORY);
>  }
>  
> +static int count_system_ram_pages_cb(unsigned long start_pfn,
> +				     unsigned long nr_pages, void *data)
> +{
> +	unsigned long *nr_system_ram_pages = data;
> +
> +	*nr_system_ram_pages += nr_pages;
> +	return 0;
> +}
> +
>  static int __ref __offline_pages(unsigned long start_pfn,
>  		  unsigned long end_pfn)
>  {
> -	unsigned long pfn, nr_pages;
> +	unsigned long pfn, nr_pages = 0;
>  	unsigned long offlined_pages = 0;
>  	int ret, node, nr_isolate_pageblock;
>  	unsigned long flags;
> @@ -1469,6 +1478,22 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  
>  	mem_hotplug_begin();
>  
> +	/*
> +	 * Don't allow to offline memory blocks that contain holes.
> +	 * Consequently, memory blocks with holes can never get onlined
> +	 * via the hotplug path - online_pages() - as hotplugged memory has
> +	 * no holes. This way, we e.g., don't have to worry about marking
> +	 * memory holes PG_reserved, don't need pfn_valid() checks, and can
> +	 * avoid using walk_system_ram_range() later.
> +	 */
> +	walk_system_ram_range(start_pfn, end_pfn - start_pfn, &nr_pages,
> +			      count_system_ram_pages_cb);
> +	if (nr_pages != end_pfn - start_pfn) {
> +		ret = -EINVAL;
> +		reason = "memory holes";
> +		goto failed_removal;
> +	}
> +
>  	/* This makes hotplug much easier...and readable.
>  	   we assume this for now. .*/
>  	if (!test_pages_in_a_zone(start_pfn, end_pfn, &valid_start,
> @@ -1480,7 +1505,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  
>  	zone = page_zone(pfn_to_page(valid_start));
>  	node = zone_to_nid(zone);
> -	nr_pages = end_pfn - start_pfn;
>  
>  	/* set above range as isolated */
>  	ret = start_isolate_page_range(start_pfn, end_pfn,
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
