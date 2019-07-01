Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE79EC46478
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FFB208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561971154;
	bh=c27CKqOc16mlMGXnKK5D70qK+oD98EbgIRZ3DSOnI2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z0d522j/DNB6xDbcIntTX0wQvzNjoa2z390/Z4tqhaack6F5yKSofNEL3+rgJ9HrI
	 xpuQNXDmLoICYniCg5wzfQZ6quy4VqQCJavBCDPJiJOo9kEhQ5eL/rse32c5W3DNJV
	 BmitfheEbPcaKNDBcFZytC45p6Zj0EMI8aDiTNuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfGAIwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:52:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:41964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbfGAIwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:52:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE529AD23;
        Mon,  1 Jul 2019 08:52:31 +0000 (UTC)
Date:   Mon, 1 Jul 2019 10:52:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v3 11/11] mm/memory_hotplug: Remove "zone" parameter from
 sparse_remove_one_section
Message-ID: <20190701085231.GK6376@dhcp22.suse.cz>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-12-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527111152.16324-12-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-05-19 13:11:52, David Hildenbrand wrote:
> The parameter is unused, so let's drop it. Memory removal paths should
> never care about zones. This is the job of memory offlining and will
> require more refactorings.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memory_hotplug.h | 2 +-
>  mm/memory_hotplug.c            | 2 +-
>  mm/sparse.c                    | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 2f1f87e13baa..1a4257c5f74c 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -346,7 +346,7 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  extern bool is_memblock_offlined(struct memory_block *mem);
>  extern int sparse_add_one_section(int nid, unsigned long start_pfn,
>  				  struct vmem_altmap *altmap);
> -extern void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
> +extern void sparse_remove_one_section(struct mem_section *ms,
>  		unsigned long map_offset, struct vmem_altmap *altmap);
>  extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
>  					  unsigned long pnum);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 82136c5b4c5f..e48ec7b9dee2 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -524,7 +524,7 @@ static void __remove_section(struct zone *zone, struct mem_section *ms,
>  	start_pfn = section_nr_to_pfn((unsigned long)scn_nr);
>  	__remove_zone(zone, start_pfn);
>  
> -	sparse_remove_one_section(zone, ms, map_offset, altmap);
> +	sparse_remove_one_section(ms, map_offset, altmap);
>  }
>  
>  /**
> diff --git a/mm/sparse.c b/mm/sparse.c
> index d1d5e05f5b8d..1552c855d62a 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -800,8 +800,8 @@ static void free_section_usemap(struct page *memmap, unsigned long *usemap,
>  		free_map_bootmem(memmap);
>  }
>  
> -void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
> -		unsigned long map_offset, struct vmem_altmap *altmap)
> +void sparse_remove_one_section(struct mem_section *ms, unsigned long map_offset,
> +			       struct vmem_altmap *altmap)
>  {
>  	struct page *memmap = NULL;
>  	unsigned long *usemap = NULL;
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
