Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A338C76196
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 16:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C57E2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 16:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qPRDkybI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfGUQCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 12:02:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfGUQCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 12:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5yrKtv7lLSBoGJQSfoUzlzXTf1lEOx7ratjEmiAYLgE=; b=qPRDkybIjsnEQrqVrMLPTBeEH
        g+yoZazgqTczET0c+OjZrudOmnCNNeeKYrkwA6aEmtn9mQjTqHx23bAenOjrh5jk0rGjghmlHvPSH
        a7pDftoHUDwwSpZ5FCb9oX8CJ4xUnrxzWvxMdQSXrud25gn/yG0qirKbx7XIAZybfZG7c0MH4ooM7
        TipoxwgxcNCmg7bWEMFLr81d+DTEAz7ouRpLwdkuQ5H+g7hOFjEaN+dVUPtfRaL9l7n6lrqT/ICrm
        a1qJk1F43VL+LYKSCijf7WKx7NIWMiToeOij1hHUySurmdqgN6Bfm7qW++/mWEMjDzENV5o+uaCEI
        b4R188mbQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hpEHk-00011f-FV; Sun, 21 Jul 2019 16:02:04 +0000
Date:   Sun, 21 Jul 2019 09:02:04 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] mm: document zone device struct page field usage
Message-ID: <20190721160204.GB363@bombadil.infradead.org>
References: <20190719192955.30462-1-rcampbell@nvidia.com>
 <20190719192955.30462-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719192955.30462-2-rcampbell@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 12:29:53PM -0700, Ralph Campbell wrote:
> Struct page for ZONE_DEVICE private pages uses the page->mapping and
> and page->index fields while the source anonymous pages are migrated to
> device private memory. This is so rmap_walk() can find the page when
> migrating the ZONE_DEVICE private page back to system memory.
> ZONE_DEVICE pmem backed fsdax pages also use the page->mapping and
> page->index fields when files are mapped into a process address space.
> 
> Restructure struct page and add comments to make this more clear.

NAK.  I just got rid of this kind of foolishness from struct page,
and you're making it harder to understand, not easier.  The comments
could be improved, but don't lay it out like this again.

> @@ -76,13 +76,35 @@ struct page {
>  	 * avoid collision and false-positive PageTail().
>  	 */
>  	union {
> -		struct {	/* Page cache and anonymous pages */
> -			/**
> -			 * @lru: Pageout list, eg. active_list protected by
> -			 * pgdat->lru_lock.  Sometimes used as a generic list
> -			 * by the page owner.
> -			 */
> -			struct list_head lru;
> +		struct {	/* Page cache, anonymous, ZONE_DEVICE pages */
> +			union {
> +				/**
> +				 * @lru: Pageout list, e.g., active_list
> +				 * protected by pgdat->lru_lock. Sometimes
> +				 * used as a generic list by the page owner.
> +				 */
> +				struct list_head lru;
> +				/**
> +				 * ZONE_DEVICE pages are never on the lru
> +				 * list so they reuse the list space.
> +				 * ZONE_DEVICE private pages are counted as
> +				 * being mapped so the @mapping and @index
> +				 * fields are used while the page is migrated
> +				 * to device private memory.
> +				 * ZONE_DEVICE MEMORY_DEVICE_FS_DAX pages also
> +				 * use the @mapping and @index fields when pmem
> +				 * backed DAX files are mapped.
> +				 */
> +				struct {
> +					/**
> +					 * @pgmap: Points to the hosting
> +					 * device page map.
> +					 */
> +					struct dev_pagemap *pgmap;
> +					/** @zone_device_data: opaque data. */
> +					void *zone_device_data;
> +				};
> +			};
>  			/* See page-flags.h for PAGE_MAPPING_FLAGS */
>  			struct address_space *mapping;
>  			pgoff_t index;		/* Our offset within mapping. */
> @@ -155,12 +177,6 @@ struct page {
>  			spinlock_t ptl;
>  #endif
>  		};
> -		struct {	/* ZONE_DEVICE pages */
> -			/** @pgmap: Points to the hosting device page map. */
> -			struct dev_pagemap *pgmap;
> -			void *zone_device_data;
> -			unsigned long _zd_pad_1;	/* uses mapping */
> -		};
>  
>  		/** @rcu_head: You can use this to free a page by RCU. */
>  		struct rcu_head rcu_head;
> -- 
> 2.20.1
> 
