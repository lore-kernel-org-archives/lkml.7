Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D80C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A72214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="l3SZNumX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504719AbfIXLbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:31:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46314 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389832AbfIXLbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:31:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id t3so1470590edw.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 04:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0s5uYaNwj5xj6xYoxNOhC3OaXLMlVBvmApGp6ZZlckg=;
        b=l3SZNumXspIFEaMls1NecrGdIl6Ry+IRhRWMzsFzupD0fH0NHJ7VLDRB34lS0ldE7N
         ndbhQYf1ICl9fSCpzFNgQLuVcEJ+Np1jWL1nlP/Ia5G7ZsoW+3quKW0HRD+sA4yZbfKv
         FQi8y+0knNTKY1fme3FR8O1IgEJa0Sslu0mdfi1yESAjl0MzgIp/Y8P8x/sgeh6ZxSVx
         AN/W5IKyG2DWvgDmkGgCW5dlVcKH6VGo9P0NCMtpCbv5wPp6XtuvHQyvyp9x4hqPPTWz
         d74lvyP9UCmG/W3gY+KYgAUjckR945mqb2iEqP/ISWT4AxfzKR/HdN349nxlNzG71XRc
         W67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0s5uYaNwj5xj6xYoxNOhC3OaXLMlVBvmApGp6ZZlckg=;
        b=Wdpgkmytx635YbcDE48pvJw13F9Xi0w3ULcSgIipMC5SsYZgkP5B/50PjznqMhHIjR
         peEZ5B1tixirJmPLk/IEg9IGP9jhXrbjDk4yU92mgof4W306eKW2IRkUZQmZ3NSegECm
         fpwAK40l8FP05fxRjARFwgU83+vJSh7EMz33PBwtFG1F42JPlgARA+Uktxqa5AAHiIX7
         gVgUDrzn58jV7WnbvO2F4Q7gx++JKyM6ENR+w2BZxSVnS3tj86ee709nE8IFIvUeO2F6
         nBnfa9NM81q4GlVJHbOyMn/faucUfzArJxxYsEeCGG/1i4DIymOiyRf8dNxrwvW6R8RC
         INdA==
X-Gm-Message-State: APjAAAUzBbDL8XqK1KN73JVQFKwYcqSR0xVnTUTb/yYWdL5WJZGRMS2a
        cY5bP+DODtb40DUOwNrs50Mjr6k1Li0=
X-Google-Smtp-Source: APXvYqxtjktaC/U2yewI61ivQK1f6jLxNDhyr3uUo3Rjj/tslZy6jVYSP1ngpvQNdCvJd9RSzlf0Cg==
X-Received: by 2002:aa7:ce88:: with SMTP id y8mr2151323edv.145.1569324695442;
        Tue, 24 Sep 2019 04:31:35 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g17sm178398ejb.80.2019.09.24.04.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 04:31:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 014CC1022A6; Tue, 24 Sep 2019 14:31:35 +0300 (+03)
Date:   Tue, 24 Sep 2019 14:31:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 2/4] mm, page_owner: record page owner for each subpage
Message-ID: <20190924113135.2ekb7bmil3rxge6w@box>
References: <20190820131828.22684-1-vbabka@suse.cz>
 <20190820131828.22684-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820131828.22684-3-vbabka@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 03:18:26PM +0200, Vlastimil Babka wrote:
> Currently, page owner info is only recorded for the first page of a high-order
> allocation, and copied to tail pages in the event of a split page. With the
> plan to keep previous owner info after freeing the page, it would be benefical
> to record page owner for each subpage upon allocation. This increases the
> overhead for high orders, but that should be acceptable for a debugging option.
> 
> The order stored for each subpage is the order of the whole allocation. This
> makes it possible to calculate the "head" pfn and to recognize "tail" pages
> (quoted because not all high-order allocations are compound pages with true
> head and tail pages). When reading the page_owner debugfs file, keep skipping
> the "tail" pages so that stats gathered by existing scripts don't get inflated.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/page_owner.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index addcbb2ae4e4..813fcb70547b 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -154,18 +154,23 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
>  	return handle;
>  }
>  
> -static inline void __set_page_owner_handle(struct page_ext *page_ext,
> -	depot_stack_handle_t handle, unsigned int order, gfp_t gfp_mask)
> +static inline void __set_page_owner_handle(struct page *page,
> +	struct page_ext *page_ext, depot_stack_handle_t handle,
> +	unsigned int order, gfp_t gfp_mask)
>  {
>  	struct page_owner *page_owner;
> +	int i;
>  
> -	page_owner = get_page_owner(page_ext);
> -	page_owner->handle = handle;
> -	page_owner->order = order;
> -	page_owner->gfp_mask = gfp_mask;
> -	page_owner->last_migrate_reason = -1;
> +	for (i = 0; i < (1 << order); i++) {
> +		page_owner = get_page_owner(page_ext);
> +		page_owner->handle = handle;
> +		page_owner->order = order;
> +		page_owner->gfp_mask = gfp_mask;
> +		page_owner->last_migrate_reason = -1;
> +		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
>  
> -	__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
> +		page_ext = lookup_page_ext(page + i);

Isn't it off-by-one? You are calculating page_ext for the next page,
right? And cant we just do page_ext++ here instead?

> +	}
>  }
>  
>  noinline void __set_page_owner(struct page *page, unsigned int order,
> @@ -178,7 +183,7 @@ noinline void __set_page_owner(struct page *page, unsigned int order,
>  		return;
>  
>  	handle = save_stack(gfp_mask);
> -	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
> +	__set_page_owner_handle(page, page_ext, handle, order, gfp_mask);
>  }
>  
>  void __set_page_owner_migrate_reason(struct page *page, int reason)
> @@ -204,8 +209,11 @@ void __split_page_owner(struct page *page, unsigned int order)
>  
>  	page_owner = get_page_owner(page_ext);
>  	page_owner->order = 0;
> -	for (i = 1; i < (1 << order); i++)
> -		__copy_page_owner(page, page + i);
> +	for (i = 1; i < (1 << order); i++) {
> +		page_ext = lookup_page_ext(page + i);

Again, page_ext++?

> +		page_owner = get_page_owner(page_ext);
> +		page_owner->order = 0;
> +	}
>  }
>  
>  void __copy_page_owner(struct page *oldpage, struct page *newpage)
> @@ -483,6 +491,13 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  
>  		page_owner = get_page_owner(page_ext);
>  
> +		/*
> +		 * Don't print "tail" pages of high-order allocations as that
> +		 * would inflate the stats.
> +		 */
> +		if (!IS_ALIGNED(pfn, 1 << page_owner->order))
> +			continue;
> +
>  		/*
>  		 * Access to page_ext->handle isn't synchronous so we should
>  		 * be careful to access it.
> @@ -562,7 +577,8 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
>  				continue;
>  
>  			/* Found early allocated page */
> -			__set_page_owner_handle(page_ext, early_handle, 0, 0);
> +			__set_page_owner_handle(page, page_ext, early_handle,
> +						0, 0);
>  			count++;
>  		}
>  		cond_resched();
> -- 
> 2.22.0
> 
> 

-- 
 Kirill A. Shutemov
