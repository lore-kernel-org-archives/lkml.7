Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340A1CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B67E207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfJUIRO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:17:14 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:38047 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfJUIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:17:13 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9L8GtuI017043
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Oct 2019 17:16:55 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L8GtY5015611;
        Mon, 21 Oct 2019 17:16:55 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L8EIaa018392;
        Mon, 21 Oct 2019 17:16:55 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-79913; Mon, 21 Oct 2019 16:45:35 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0439.000; Mon,
 21 Oct 2019 16:45:34 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Thread-Topic: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Thread-Index: AQHVhPYxuKrdanK4Pk2pyFsBlimO86dkJj2A
Date:   Mon, 21 Oct 2019 07:45:33 +0000
Message-ID: <20191021074533.GA10507@hori.linux.bs1.fc.nec.co.jp>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-11-osalvador@suse.de>
In-Reply-To: <20191017142123.24245-11-osalvador@suse.de>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <A00B02FA1827904C9C12E61048EDFF8B@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 04:21:17PM +0200, Oscar Salvador wrote:
> When trying to soft-offline a free page, we need to first take it off
> the buddy allocator.
> Once we know is out of reach, we can safely flag it as poisoned.
> 
> take_page_off_buddy will be used to take a page meant to be poisoned
> off the buddy allocator.
> take_page_off_buddy calls break_down_buddy_pages, which splits a
> higher-order page in case our page belongs to one.
> 
> Once the page is under our control, we call page_set_poison to set it

I guess you mean page_handle_poison here.

> as poisoned and grab a refcount on it.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/memory-failure.c | 20 +++++++++++-----
>  mm/page_alloc.c     | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 37b230b8cfe7..1d986580522d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -78,6 +78,15 @@ EXPORT_SYMBOL_GPL(hwpoison_filter_dev_minor);
>  EXPORT_SYMBOL_GPL(hwpoison_filter_flags_mask);
>  EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
>  
> +extern bool take_page_off_buddy(struct page *page);
> +
> +static void page_handle_poison(struct page *page)

hwpoison is a separate idea from page poisoning, so maybe I think
it's better to be named like page_handle_hwpoison().

> +{
> +	SetPageHWPoison(page);
> +	page_ref_inc(page);
> +	num_poisoned_pages_inc();
> +}
> +
>  static int hwpoison_filter_dev(struct page *p)
>  {
>  	struct address_space *mapping;
> @@ -1830,14 +1839,13 @@ static int soft_offline_in_use_page(struct page *page)
>  
>  static int soft_offline_free_page(struct page *page)
>  {
> -	int rc = dissolve_free_huge_page(page);
> +	int rc = -EBUSY;
>  
> -	if (!rc) {
> -		if (set_hwpoison_free_buddy_page(page))
> -			num_poisoned_pages_inc();
> -		else
> -			rc = -EBUSY;
> +	if (!dissolve_free_huge_page(page) && take_page_off_buddy(page)) {
> +		page_handle_poison(page);
> +		rc = 0;
>  	}
> +
>  	return rc;
>  }
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cd1dd0712624..255df0c76a40 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8632,6 +8632,74 @@ bool is_free_buddy_page(struct page *page)
>  
>  #ifdef CONFIG_MEMORY_FAILURE
>  /*
> + * Break down a higher-order page in sub-pages, and keep our target out of
> + * buddy allocator.
> + */
> +static void break_down_buddy_pages(struct zone *zone, struct page *page,
> +				   struct page *target, int low, int high,
> +				   struct free_area *area, int migratetype)
> +{
> +	unsigned long size = 1 << high;
> +	struct page *current_buddy, *next_page;
> +
> +	while (high > low) {
> +		area--;
> +		high--;
> +		size >>= 1;
> +
> +		if (target >= &page[size]) {
> +			next_page = page + size;
> +			current_buddy = page;
> +		} else {
> +			next_page = page;
> +			current_buddy = page + size;
> +		}
> +
> +		if (set_page_guard(zone, current_buddy, high, migratetype))
> +			continue;
> +
> +		if (current_buddy != target) {
> +			add_to_free_area(current_buddy, area, migratetype);
> +			set_page_order(current_buddy, high);
> +			page = next_page;
> +		}
> +	}
> +}
> +
> +/*
> + * Take a page that will be marked as poisoned off the buddy allocator.
> + */
> +bool take_page_off_buddy(struct page *page)
> + {
> +	struct zone *zone = page_zone(page);
> +	unsigned long pfn = page_to_pfn(page);
> +	unsigned long flags;
> +	unsigned int order;
> +	bool ret = false;
> +
> +	spin_lock_irqsave(&zone->lock, flags);
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

indent with whitespace?
And you can find a few more coding style warning with checkpatch.pl.

BTW, if we consider to make unpoison mechanism to keep up with the
new semantics, we will need the reverse operation of take_page_off_buddy().
Do you think that that part will come with a separate work?

Thanks,
Naoya Horiguchi

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
> 
> 
