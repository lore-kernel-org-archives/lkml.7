Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BD0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0F92186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566887089;
	bh=yxWiW2mofrr3TlfEhVzDgKVojqrbyNQwTq/6PuhayOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZCsyjgvSwEZbmYzwB1yh13BTfgFGuCQ2j9iWxbRjy1dty+j7Zy4aIxgg8fTfn20za
	 IRZ3fPqKgnSX0RH+FikySuJdw1A2teE5+gQPC8gBWGy+MwWvjOlVhth8aC/aewCgTx
	 5dgcEdO4WXgcoIRT8F4SBkjJ5utjT7HEy6EuFRY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfH0GYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 02:24:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:55320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfH0GYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:24:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 491DDADB3;
        Tue, 27 Aug 2019 06:24:47 +0000 (UTC)
Date:   Tue, 27 Aug 2019 08:24:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: don't hide potentially null memmap pointer in
 sparse_remove_section
Message-ID: <20190827062445.GO7538@dhcp22.suse.cz>
References: <20190827053656.32191-1-alastair@au1.ibm.com>
 <20190827053656.32191-3-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827053656.32191-3-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 15:36:55, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> By adding offset to memmap before passing it in to clear_hwpoisoned_pages,
> we hide a theoretically null memmap from the null check inside
> clear_hwpoisoned_pages.

Isn't that other way around? Calculating the offset struct page pointer
will actually make the null check effective. Besides that I cannot
really see how pfn_to_page would return NULL. I have to confess that I
cannot really see how offset could lead to a NULL struct page either and
I strongly suspect that the NULL check is not really needed. Maybe it
used to be in the past.

> This patch passes the offset to clear_hwpoisoned_pages instead, allowing
> memmap to successfully perform it's null check.

I do not see any improvement in this patch. It just adds a new argument
unnecessarily.

> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  mm/sparse.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index e41917a7e844..3ff84e627e58 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -882,7 +882,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  }
>  
>  #ifdef CONFIG_MEMORY_FAILURE
> -static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
> +static void clear_hwpoisoned_pages(struct page *memmap, int start, int count)
>  {
>  	int i;
>  
> @@ -898,7 +898,7 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
>  	if (atomic_long_read(&num_poisoned_pages) == 0)
>  		return;
>  
> -	for (i = 0; i < nr_pages; i++) {
> +	for (i = start; i < start + count; i++) {
>  		if (PageHWPoison(&memmap[i])) {
>  			num_poisoned_pages_dec();
>  			ClearPageHWPoison(&memmap[i]);
> @@ -906,7 +906,8 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
>  	}
>  }
>  #else
> -static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
> +static inline void clear_hwpoisoned_pages(struct page *memmap, int start,
> +		int count)
>  {
>  }
>  #endif
> @@ -915,7 +916,7 @@ void sparse_remove_section(struct mem_section *ms, unsigned long pfn,
>  		unsigned long nr_pages, unsigned long map_offset,
>  		struct vmem_altmap *altmap)
>  {
> -	clear_hwpoisoned_pages(pfn_to_page(pfn) + map_offset,
> +	clear_hwpoisoned_pages(pfn_to_page(pfn), map_offset,
>  			nr_pages - map_offset);
>  	section_deactivate(pfn, nr_pages, altmap);
>  }
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
