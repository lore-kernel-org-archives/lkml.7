Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B5EC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5A02086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562768696;
	bh=xAScrm2/DGxrVjf72GPnATr7VaBqtNOzpq4YDgGC4N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k3NUlMdYzpl0JKvHylxce4C4oThV+0+dMKRQ0b9RG29kHs1cldmO6JQZV5guT1Rxj
	 0AKctUnErzU/y/s7Kf4duxXYTPYvHG/z46fXBZOrwtUActr5eIzRGDrLotg0LhhVGB
	 4NqznL1Y/VoR5Qg9wDYpE3AAseuSrtuhZA0YBL6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfGJOYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:24:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:47116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727373AbfGJOYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:24:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98CBAAE62;
        Wed, 10 Jul 2019 14:24:53 +0000 (UTC)
Date:   Wed, 10 Jul 2019 16:24:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Arun KS <arunks@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove the exporting of totalram_pages
Message-ID: <20190710142452.GN29695@dhcp22.suse.cz>
References: <20190710141031.15642-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710141031.15642-1-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-07-19 17:10:31, Denis Efremov wrote:
> Previously totalram_pages was the global variable. Currently,
> totalram_pages is the static inline function from the include/linux/mm.h
> However, the function is also marked as EXPORT_SYMBOL, which is at best
> an odd combination. Because there is no point for the static inline
> function from a public header to be exported, this commit removes the
> EXPORT_SYMBOL() marking. It will be still possible to use the function in
> modules because all the symbols it depends on are exported.
> 
> Fixes: ca79b0c211af6 ("mm: convert totalram_pages and totalhigh_pages variables to atomic")
> Signed-off-by: Denis Efremov <efremov@linux.com>

I have to confess I am not entirely sure what the export actually does in this
case. I _think_ it will simply create a symbol and the code will be same
as the static inline. But it certainly is not what we want/need.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8e3bc949ebcc..060303496094 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -224,8 +224,6 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES] = {
>  	[ZONE_MOVABLE] = 0,
>  };
>  
> -EXPORT_SYMBOL(totalram_pages);
> -
>  static char * const zone_names[MAX_NR_ZONES] = {
>  #ifdef CONFIG_ZONE_DMA
>  	 "DMA",
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
