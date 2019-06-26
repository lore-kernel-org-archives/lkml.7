Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE826C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90482133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561530227;
	bh=zCVYtajPY/QSiFvBDO8Al+SzA02Z3wzq9iiblk30rIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qAbU7fAxz8shKmegi4/B+gW74oRS7lyS1vDUXc8OrOX9zWfWYb62PxC11D66dmj1q
	 vdNS5hd+51yv5TspPNOywK7QVASILH/x/4SflkJJ5qYxiIK8EGU+m1Dd7YF+7yfymV
	 YVVrHG4xw0hgVOLGdjK+7omeveJJtTrYCTS+n/WE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfFZGXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:23:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:59306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZGXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:23:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BAE6AD47;
        Wed, 26 Jun 2019 06:23:45 +0000 (UTC)
Date:   Wed, 26 Jun 2019 08:23:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Qian Cai <cai@lca.pw>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm: don't hide potentially null memmap pointer in
 sparse_remove_one_section
Message-ID: <20190626062344.GG17798@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
 <20190626061124.16013-3-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626061124.16013-3-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-06-19 16:11:22, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> By adding offset to memmap before passing it in to clear_hwpoisoned_pages,
> we hide a potentially null memmap from the null check inside
> clear_hwpoisoned_pages.
> 
> This patch passes the offset to clear_hwpoisoned_pages instead, allowing
> memmap to successfully peform it's null check.

Same issue with the changelog as the previous patch (missing WHY).

> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  mm/sparse.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 57a1a3d9c1cf..1ec32aef5590 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -753,7 +753,8 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  #ifdef CONFIG_MEMORY_FAILURE
> -static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
> +static void clear_hwpoisoned_pages(struct page *memmap,
> +		unsigned long start, unsigned long count)
>  {
>  	int i;
>  
> @@ -769,7 +770,7 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
>  	if (atomic_long_read(&num_poisoned_pages) == 0)
>  		return;
>  
> -	for (i = 0; i < nr_pages; i++) {
> +	for (i = start; i < start + count; i++) {
>  		if (PageHWPoison(&memmap[i])) {
>  			atomic_long_sub(1, &num_poisoned_pages);
>  			ClearPageHWPoison(&memmap[i]);
> @@ -777,7 +778,8 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
>  	}
>  }
>  #else
> -static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
> +static inline void clear_hwpoisoned_pages(struct page *memmap,
> +		unsigned long start, unsigned long count)
>  {
>  }
>  #endif
> @@ -824,7 +826,7 @@ void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
>  		ms->pageblock_flags = NULL;
>  	}
>  
> -	clear_hwpoisoned_pages(memmap + map_offset,
> +	clear_hwpoisoned_pages(memmap, map_offset,
>  			PAGES_PER_SECTION - map_offset);
>  	free_section_usemap(memmap, usemap, altmap);
>  }
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
