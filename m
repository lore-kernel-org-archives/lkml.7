Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B308BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC602083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565792776;
	bh=db2Aav5vFBNwT/zC2U1Vx5uEvy4r3lI7XKLAhPnfaK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nCYEvDUNbzRQB0VLe0LPyfBG6m3AljA53mldgGyQDj2X2fpPysSCpdyecEKukuqky
	 FwbzBFx2kl9Svq2EFEP59Y8Z/uHS8jPZqzIzb/Y/PGJKJ77pbVdXPOzj+XcJCIwsBu
	 sOnV/bFmYcS5v/M33reDDN5AMg1Q2uMBU3OAywHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfHNO0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:26:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:35134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfHNO0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:26:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A45FEAEE9;
        Wed, 14 Aug 2019 14:26:13 +0000 (UTC)
Date:   Wed, 14 Aug 2019 16:26:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 4/4] mm/memory_hotplug: online_pages cannot be 0 in
 online_pages()
Message-ID: <20190814142613.GC17933@dhcp22.suse.cz>
References: <20190809125701.3316-1-david@redhat.com>
 <20190809125701.3316-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809125701.3316-5-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-08-19 14:57:01, David Hildenbrand wrote:
> walk_system_ram_range() will fail with -EINVAL in case
> online_pages_range() was never called (== no resource applicable in the
> range). Otherwise, we will always call online_pages_range() with
> nr_pages > 0 and, therefore, have online_pages > 0.

I have no idea why those checks where there TBH. Tried to dig out
commits which added them but didn't help.

> Remove that special handling.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 87f85597a19e..07e72fe17495 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -854,6 +854,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
>  	ret = walk_system_ram_range(pfn, nr_pages, &onlined_pages,
>  		online_pages_range);
>  	if (ret) {
> +		/* not a single memory resource was applicable */
>  		if (need_zonelists_rebuild)
>  			zone_pcp_reset(zone);
>  		goto failed_addition;
> @@ -867,27 +868,22 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
>  
>  	shuffle_zone(zone);
>  
> -	if (onlined_pages) {
> -		node_states_set_node(nid, &arg);
> -		if (need_zonelists_rebuild)
> -			build_all_zonelists(NULL);
> -		else
> -			zone_pcp_update(zone);
> -	}
> +	node_states_set_node(nid, &arg);
> +	if (need_zonelists_rebuild)
> +		build_all_zonelists(NULL);
> +	else
> +		zone_pcp_update(zone);
>  
>  	init_per_zone_wmark_min();
>  
> -	if (onlined_pages) {
> -		kswapd_run(nid);
> -		kcompactd_run(nid);
> -	}
> +	kswapd_run(nid);
> +	kcompactd_run(nid);
>  
>  	vm_total_pages = nr_free_pagecache_pages();
>  
>  	writeback_set_ratelimit();
>  
> -	if (onlined_pages)
> -		memory_notify(MEM_ONLINE, &arg);
> +	memory_notify(MEM_ONLINE, &arg);
>  	mem_hotplug_done();
>  	return 0;
>  
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
