Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B87C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B226820850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfCUJmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:42:42 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:56694 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727946AbfCUJml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:42:41 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 462B4464A; Thu, 21 Mar 2019 10:42:40 +0100 (CET)
Date:   Thu, 21 Mar 2019 10:42:40 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mike.kravetz@oracle.com, zi.yan@cs.rutgers.edu, mhocko@suse.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/isolation: Remove redundant pfn_valid_within() in
 __first_valid_page()
Message-ID: <20190321094237.onu3kar2ez7xv5wj@d104.suse.de>
References: <1553141595-26907-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553141595-26907-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 09:43:15AM +0530, Anshuman Khandual wrote:
> pfn_valid_within() calls pfn_valid() when CONFIG_HOLES_IN_ZONE making it
> redundant for both definitions (w/wo CONFIG_MEMORY_HOTPLUG) of the helper
> pfn_to_online_page() which either calls pfn_valid() or pfn_valid_within().
> pfn_valid_within() being 1 when !CONFIG_HOLES_IN_ZONE is irrelevant either
> way. This does not change functionality.
> 
> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

About the "Fixes:" tag issue, I agree with Michal that the code is not
really broken, but perhaps "suboptimal" depending on how much can affect
performance on those systems where pfn_valid_within() is more complicated than
simple returning true.

I see that on arm64, that calls memblock_is_map_memory()->memblock_search(),
to trigger a search for the region containing the address, so I guess it
is an expensive operation.

Depending on how much time we can shave, it might be worth to have the tag
Fixes, but the removal of the code is fine anyway, so:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/page_isolation.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index ce323e56b34d..d9b02bb13d60 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -150,8 +150,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>  	for (i = 0; i < nr_pages; i++) {
>  		struct page *page;
>  
> -		if (!pfn_valid_within(pfn + i))
> -			continue;
>  		page = pfn_to_online_page(pfn + i);
>  		if (!page)
>  			continue;
> -- 
> 2.20.1
> 

-- 
Oscar Salvador
SUSE L3
