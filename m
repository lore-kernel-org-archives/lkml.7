Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AEFC4320D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3CE217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569394421;
	bh=3I9N81YtR67BwSWbd01l59e9PfoymVO7oHoRVWCccdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QvZkY4fHHWhtOsgntouK+zjC1fdbhan1YQIXhqjv+dMaRY1hreqShS2bE0os0uO6p
	 5SN6US93EeqwYcTn6aeSXeMzlVCxNxa93VML6RNQQLvT/Qirta+HI+577+RmZ5GsIp
	 lFQ+MOipR6dj6V5/7GflQd9bAcboWEYkVxoCA4+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442387AbfIYGxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:53:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:46232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436671AbfIYGxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:53:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B72DB044;
        Wed, 25 Sep 2019 06:53:38 +0000 (UTC)
Date:   Wed, 25 Sep 2019 08:53:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH V2] mm/hotplug: Reorder memblock_[free|remove]() calls in
 try_remove_memory()
Message-ID: <20190925065337.GG23050@dhcp22.suse.cz>
References: <1569380273-7708-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569380273-7708-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-09-19 08:27:53, Anshuman Khandual wrote:
> Currently during memory hot add procedure, memory gets into memblock before
> calling arch_add_memory() which creates it's linear mapping.
> 
> add_memory_resource() {
> 	..................
> 	memblock_add_node()
> 	..................
> 	arch_add_memory()
> 	..................
> }
> 
> But during memory hot remove procedure, removal from memblock happens first
> before it's linear mapping gets teared down with arch_remove_memory() which
> is not consistent. Resource removal should happen in reverse order as they
> were added. However this does not pose any problem for now, unless there is
> an assumption regarding linear mapping. One example was a subtle failure on
> arm64 platform [1]. Though this has now found a different solution.
> 
> try_remove_memory() {
> 	..................
> 	memblock_free()
> 	memblock_remove()
> 	..................
> 	arch_remove_memory()
> 	..................
> }
> 
> This changes the sequence of resource removal including memblock and linear
> mapping tear down during memory hot remove which will now be the reverse
> order in which they were added during memory hot add. The changed removal
> order looks like the following.
> 
> try_remove_memory() {
> 	..................
> 	arch_remove_memory()
> 	..................
> 	memblock_free()
> 	memblock_remove()
> 	..................
> }
> 
> [1] https://patchwork.kernel.org/patch/11127623/
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> Changes in V2:
> 
> - Changed the commit message as per Michal and David 
> 
> Changed in V1: https://patchwork.kernel.org/patch/11146361/
> 
> Original patch https://lkml.org/lkml/2019/9/3/327
> 
> Memory hot remove now works on arm64 without this because a recent commit
> 60bb462fc7ad ("drivers/base/node.c: simplify unregister_memory_block_under_nodes()").
> 
> David mentioned that re-ordering should still make sense for consistency
> purpose (removing stuff in the reverse order they were added). This patch
> is now detached from arm64 hot-remove series.
> 
> https://lkml.org/lkml/2019/9/3/326
> 
>  mm/memory_hotplug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 49f7bf91c25a..4f7d426a84d0 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1763,13 +1763,13 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  
>  	/* remove memmap entry */
>  	firmware_map_remove(start, start + size, "System RAM");
> -	memblock_free(start, size);
> -	memblock_remove(start, size);
>  
>  	/* remove memory block devices before removing memory */
>  	remove_memory_block_devices(start, size);
>  
>  	arch_remove_memory(nid, start, size, NULL);
> +	memblock_free(start, size);
> +	memblock_remove(start, size);
>  	__release_memory_resource(start, size);
>  
>  	try_offline_node(nid);
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
