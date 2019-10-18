Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89D7CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98542222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571400382;
	bh=XgvySpT9kJeggEeBr1q62VofvxDTbLnscXrY3StwVqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xdejQ88xp0pueUdLzvz1SfkKR+1NJZfLjhaV5lqsCa33G1LIBJJGjxpsj4QNtJ0vn
	 VJcdDydlBAhe39dFdmlGFxIUBWb4RWXdRprcek1OUjdzYodfju3bHXDAXp5V6/Qgs3
	 fuo+PWF8bWFyvDROJVAoXTPc7Gl0oXcEbRrb9nKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409957AbfJRMGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:06:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:40798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394320AbfJRMGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:06:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04FC1B537;
        Fri, 18 Oct 2019 12:06:18 +0000 (UTC)
Date:   Fri, 18 Oct 2019 14:06:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Message-ID: <20191018120615.GM5017@dhcp22.suse.cz>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-11-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017142123.24245-11-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-10-19 16:21:17, Oscar Salvador wrote:
[...]
> +bool take_page_off_buddy(struct page *page)
> + {
> +	struct zone *zone = page_zone(page);
> +	unsigned long pfn = page_to_pfn(page);
> +	unsigned long flags;
> +	unsigned int order;
> +	bool ret = false;
> +
> +	spin_lock_irqsave(&zone->lock, flags);

What prevents the page to be allocated in the meantime? Also what about
free pages on the pcp lists? Also the page could be gone by the time you
have reached here.

> +	for (order = 0; order < MAX_ORDER; order++) {
> +		struct page *page_head = page - (pfn & ((1 << order) - 1));
> +		int buddy_order = page_order(page_head);
> +		struct free_area *area = &(zone->free_area[buddy_order]);
> +
> +		if (PageBuddy(page_head) && buddy_order >= order) {
> +			unsigned long pfn_head = page_to_pfn(page_head);
> +			int migratetype = get_pfnblock_migratetype(page_head,
> +		                                                   pfn_head);
> +
> +			del_page_from_free_area(page_head, area);
> +			break_down_buddy_pages(zone, page_head, page, 0,
> +		                               buddy_order, area, migratetype);
> +			ret = true;
> +		        break;
> +		 }
> +	}
> +	spin_unlock_irqrestore(&zone->lock, flags);
> +	return ret;
> + }
> +
> +/*
>   * Set PG_hwpoison flag if a given page is confirmed to be a free page.  This
>   * test is performed under the zone lock to prevent a race against page
>   * allocation.
> -- 
> 2.12.3

-- 
Michal Hocko
SUSE Labs
