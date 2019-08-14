Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406D0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125D52084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565791688;
	bh=9qd7WZWkxjZdPlBqJg3lWGrPvYLLoS3ilLpPgaHmXIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=laVkMSThNuWszlWIQkGfseTzzxRMHRwuAwAjk4Psiwq0jF3Ozm2aWAs8PPVuI5zHW
	 A6y8e0LVIyCFP2bu0k3nxQ57CTlhBcdKR7sIFjcBa6D/URz1AwOPili5MDT9FBV1HK
	 +hr3kAX4LsZAt+xpep+kzw8gL6HUGnh8/TdcUcsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfHNOIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:08:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:57790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfHNOIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:08:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A6B0ADCC;
        Wed, 14 Aug 2019 14:08:05 +0000 (UTC)
Date:   Wed, 14 Aug 2019 16:08:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Arun KS <arunks@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 2/4] mm/memory_hotplug: Handle unaligned start and
 nr_pages in online_pages_blocks()
Message-ID: <20190814140805.GA17933@dhcp22.suse.cz>
References: <20190809125701.3316-1-david@redhat.com>
 <20190809125701.3316-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809125701.3316-3-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-08-19 14:56:59, David Hildenbrand wrote:
> Take care of nr_pages not being a power of two and start not being
> properly aligned. Essentially, what walk_system_ram_range() could provide
> to us. get_order() will round-up in case it's not a power of two.
> 
> This should only apply to memory blocks that contain strange memory
> resources (especially with holes), not to ordinary DIMMs.

I would really like to see an example of such setup before making the
code hard to read. Because I am not really sure something like that
exists at all.

> Fixes: a9cd410a3d29 ("mm/page_alloc.c: memory hotplug: free pages as higher order")
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 3706a137d880..2abd938c8c45 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -640,6 +640,10 @@ static int online_pages_blocks(unsigned long start, unsigned long nr_pages)
>  	while (start < end) {
>  		order = min(MAX_ORDER - 1,
>  			get_order(PFN_PHYS(end) - PFN_PHYS(start)));
> +		/* make sure the PFN is aligned and we don't exceed the range */
> +		while (!IS_ALIGNED(start, 1ul << order) ||
> +		       (1ul << order) > end - start)
> +			order--;
>  		(*online_page_callback)(pfn_to_page(start), order);
>  
>  		onlined_pages += (1UL << order);
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
