Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77086C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5524820830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfDJSJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:09:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:9754 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfDJSJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:09:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 11:09:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="scan'208";a="141643445"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2019 11:09:01 -0700
Date:   Wed, 10 Apr 2019 11:08:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        william.kucharski@oracle.com, palmer@sifive.com, axboe@kernel.dk,
        keescook@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/gup.c: fix the wrong comments
Message-ID: <20190410180857.GD22989@iweiny-DESK2.sc.intel.com>
References: <20190408023746.16916-1-sjhuang@iluvatar.ai>
 <20190408141313.GU22763@bombadil.infradead.org>
 <20190409010832.GA28081@hsj-Precision-5520>
 <20190409202316.GA22989@iweiny-DESK2.sc.intel.com>
 <20190410011850.GA3640@hsj-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410011850.GA3640@hsj-Precision-5520>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 09:18:50AM +0800, Huang Shijie wrote:
> On Tue, Apr 09, 2019 at 01:23:16PM -0700, Ira Weiny wrote:
> > On Tue, Apr 09, 2019 at 09:08:33AM +0800, Huang Shijie wrote:
> > > On Mon, Apr 08, 2019 at 07:13:13AM -0700, Matthew Wilcox wrote:
> > > > On Mon, Apr 08, 2019 at 10:37:45AM +0800, Huang Shijie wrote:
> > > > > When CONFIG_HAVE_GENERIC_GUP is defined, the kernel will use its own
> > > > > get_user_pages_fast().
> > > > > 
> > > > > In the following scenario, we will may meet the bug in the DMA case:
> > > > > 	    .....................
> > > > > 	    get_user_pages_fast(start,,, pages);
> > > > > 	        ......
> > > > > 	    sg_alloc_table_from_pages(, pages, ...);
> > > > > 	    .....................
> > > > > 
> > > > > The root cause is that sg_alloc_table_from_pages() requires the
> > > > > page order to keep the same as it used in the user space, but
> > > > > get_user_pages_fast() will mess it up.
> > > > 
> > > > I don't understand how get_user_pages_fast() can return the pages in a
> > > > different order in the array from the order they appear in userspace.
> > > > Can you explain?
> > > Please see the code in gup.c:
> > > 
> > > 	int get_user_pages_fast(unsigned long start, int nr_pages,
> > > 				unsigned int gup_flags, struct page **pages)
> > > 	{
> > > 		.......
> > > 		if (gup_fast_permitted(start, nr_pages)) {
> > > 			local_irq_disable();
> > > 			gup_pgd_range(addr, end, gup_flags, pages, &nr);               // The @pages array maybe filled at the first time.
> > > 			local_irq_enable();
> > > 			ret = nr;
> > > 		}
> > > 		.......
> > > 		if (nr < nr_pages) {
> > > 			/* Try to get the remaining pages with get_user_pages */
> > > 			start += nr << PAGE_SHIFT;
> > > 			pages += nr;                                                  // The @pages is moved forward.
> > > 
> > > 			if (gup_flags & FOLL_LONGTERM) {
> > > 				down_read(&current->mm->mmap_sem);
> > > 				ret = __gup_longterm_locked(current, current->mm,      // The @pages maybe filled at the second time
> > >
> > 
> > Neither this nor the get_user_pages_unlocked is filling the pages a second
> The get_user_pages_unlocked() will call the handle_mm_fault which will allocate a
> new page for the empty PTE, and save the new page into the @pages array.

But shouldn't this happen if get_user_pages_unlocked() is called directly?

> 
> 
> > time.  It is adding to the page array having moved start and the page array
> > forward.
> 
> Yes. This will mess up the page order.
> 
> I will read the code again to check if I am wrong :)
> 
> > 
> > Are you doing a FOLL_LONGTERM GUP?  Or are you in the else clause below when
> > you get this bug?
> I do not use FOLL_LONGTERM, I just use the FOLL_WRITE.
> 
> So it seems it runs into the else clause below.

Ok thanks,
Ira

> 
> Thanks
> Huang Shijie
> 
> > 
> > Ira
> > 
> > > 							    start, nr_pages - nr,
> > > 							    pages, NULL, gup_flags);
> > > 				up_read(&current->mm->mmap_sem);
> > > 			} else {
> > > 				/*
> > > 				 * retain FAULT_FOLL_ALLOW_RETRY optimization if
> > > 				 * possible
> > > 				 */
> > > 				ret = get_user_pages_unlocked(start, nr_pages - nr,    // The @pages maybe filled at the second time.
> > > 							      pages, gup_flags);
> > > 			}
> > > 		}
> > > 
> > > 
> 
