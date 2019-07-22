Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC88C76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616F521E73
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfGVFNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:13:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:22296 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfGVFNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:13:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2019 22:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,293,1559545200"; 
   d="scan'208";a="344308827"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2019 22:13:45 -0700
Date:   Sun, 21 Jul 2019 22:13:45 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20190722051345.GB6157@iweiny-DESK2.sc.intel.com>
References: <20190719192955.30462-1-rcampbell@nvidia.com>
 <20190719192955.30462-2-rcampbell@nvidia.com>
 <20190721160204.GB363@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721160204.GB363@bombadil.infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 09:02:04AM -0700, Matthew Wilcox wrote:
> On Fri, Jul 19, 2019 at 12:29:53PM -0700, Ralph Campbell wrote:
> > Struct page for ZONE_DEVICE private pages uses the page->mapping and
> > and page->index fields while the source anonymous pages are migrated to
> > device private memory. This is so rmap_walk() can find the page when
> > migrating the ZONE_DEVICE private page back to system memory.
> > ZONE_DEVICE pmem backed fsdax pages also use the page->mapping and
> > page->index fields when files are mapped into a process address space.
> > 
> > Restructure struct page and add comments to make this more clear.
> 
> NAK.  I just got rid of this kind of foolishness from struct page,
> and you're making it harder to understand, not easier.  The comments
> could be improved, but don't lay it out like this again.

Was V1 of Ralphs patch ok?  It seemed ok to me.

Ira

> 
> > @@ -76,13 +76,35 @@ struct page {
> >  	 * avoid collision and false-positive PageTail().
> >  	 */
> >  	union {
> > -		struct {	/* Page cache and anonymous pages */
> > -			/**
> > -			 * @lru: Pageout list, eg. active_list protected by
> > -			 * pgdat->lru_lock.  Sometimes used as a generic list
> > -			 * by the page owner.
> > -			 */
> > -			struct list_head lru;
> > +		struct {	/* Page cache, anonymous, ZONE_DEVICE pages */
> > +			union {
> > +				/**
> > +				 * @lru: Pageout list, e.g., active_list
> > +				 * protected by pgdat->lru_lock. Sometimes
> > +				 * used as a generic list by the page owner.
> > +				 */
> > +				struct list_head lru;
> > +				/**
> > +				 * ZONE_DEVICE pages are never on the lru
> > +				 * list so they reuse the list space.
> > +				 * ZONE_DEVICE private pages are counted as
> > +				 * being mapped so the @mapping and @index
> > +				 * fields are used while the page is migrated
> > +				 * to device private memory.
> > +				 * ZONE_DEVICE MEMORY_DEVICE_FS_DAX pages also
> > +				 * use the @mapping and @index fields when pmem
> > +				 * backed DAX files are mapped.
> > +				 */
> > +				struct {
> > +					/**
> > +					 * @pgmap: Points to the hosting
> > +					 * device page map.
> > +					 */
> > +					struct dev_pagemap *pgmap;
> > +					/** @zone_device_data: opaque data. */
> > +					void *zone_device_data;
> > +				};
> > +			};
> >  			/* See page-flags.h for PAGE_MAPPING_FLAGS */
> >  			struct address_space *mapping;
> >  			pgoff_t index;		/* Our offset within mapping. */
> > @@ -155,12 +177,6 @@ struct page {
> >  			spinlock_t ptl;
> >  #endif
> >  		};
> > -		struct {	/* ZONE_DEVICE pages */
> > -			/** @pgmap: Points to the hosting device page map. */
> > -			struct dev_pagemap *pgmap;
> > -			void *zone_device_data;
> > -			unsigned long _zd_pad_1;	/* uses mapping */
> > -		};
> >  
> >  		/** @rcu_head: You can use this to free a page by RCU. */
> >  		struct rcu_head rcu_head;
> > -- 
> > 2.20.1
> > 
> 
