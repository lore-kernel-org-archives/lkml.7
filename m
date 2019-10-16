Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C935FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AEA2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571224856;
	bh=doIzJeXQHVjz1M7XJVXHJuv2iUQRkWCgC9w9YrOIaAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JpQ8RC5xpd+1mnUxQsF5W/86JrK7osiae2nMnYi8hu6SMk6r8ziTKMLYuIHfdAEWp
	 vbBsMooMlPcRsEwguOS3aCvbdTGKZglgvppb5Fq20skDq+EYQ0CsydukkLs2shwk7d
	 u+n0UHiONe48ZI0hhGCzBagR2rmrg3n+lIM2CPS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392703AbfJPLUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:20:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:57446 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfJPLUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:20:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF6F0B304;
        Wed, 16 Oct 2019 11:20:52 +0000 (UTC)
Date:   Wed, 16 Oct 2019 13:20:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH RFC v3 4/9] mm: Export alloc_contig_range() /
 free_contig_range()
Message-ID: <20191016112051.GW317@dhcp22.suse.cz>
References: <20190919142228.5483-1-david@redhat.com>
 <20190919142228.5483-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919142228.5483-5-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-09-19 16:22:23, David Hildenbrand wrote:
> A virtio-mem device wants to allocate memory from the memory region it
> manages in order to unplug it in the hypervisor - similar to
> a balloon driver. Also, it might want to plug previously unplugged
> (allocated) memory and give it back to Linux. alloc_contig_range() /
> free_contig_range() seem to be the perfect interface for this task.
> 
> In contrast to existing balloon devices, a virtio-mem device operates
> on bigger chunks (e.g., 4MB) and only on physical memory it manages. It
> tracks which chunks (subblocks) are still plugged, so it can go ahead
> and try to alloc_contig_range()+unplug them on unplug request, or
> plug+free_contig_range() unplugged chunks on plug requests.
> 
> A virtio-mem device will use alloc_contig_range() / free_contig_range()
> only on ranges that belong to the same node/zone in at least
> MAX(MAX_ORDER - 1, pageblock_order) order granularity - e.g., 4MB on
> x86-64. The virtio-mem device added that memory, so the memory
> exists and does not contain any holes. virtio-mem will only try to allocate
> on ZONE_NORMAL, never on ZONE_MOVABLE, just like when allocating
> gigantic pages (we don't put unmovable data into the movable zone).

Is there any real reason to export as GPL rather than generic
EXPORT_SYMBOL? In other words do we need to restrict the usage this
interface only to GPL modules and why if so. All other allocator APIs
are EXPORT_SYMBOL so there should better be a good reason for this one
to differ. I can understand that this one is slightly different by
requesting a specific range of the memory but it is still under a full
control of the core MM to say no.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Cc: Alexander Potapenko <glider@google.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Other than that, I do not think exporting this function is harmful. It
would be worse to reinvent it and do it wrong.

I usually prefer to add a caller in the same patch, though, because it
makes the usage explicit and clear.

Acked-by: Michal Hocko <mhocko@suse.com> # to export contig range allocator API

> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3334a769eb91..d5d7944954b3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8469,6 +8469,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  				pfn_max_align_up(end), migratetype);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(alloc_contig_range);
>  #endif /* CONFIG_CONTIG_ALLOC */
>  
>  void free_contig_range(unsigned long pfn, unsigned int nr_pages)
> @@ -8483,6 +8484,7 @@ void free_contig_range(unsigned long pfn, unsigned int nr_pages)
>  	}
>  	WARN(count != 0, "%d pages are still in use!\n", count);
>  }
> +EXPORT_SYMBOL_GPL(free_contig_range);
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  /*
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
