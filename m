Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED30C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1541B20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfDJSEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:04:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:1100 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729176AbfDJSEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:04:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 11:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="scan'208";a="149739907"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 10 Apr 2019 11:04:21 -0700
Date:   Wed, 10 Apr 2019 11:04:18 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/gup.c: fix the wrong comments
Message-ID: <20190410180417.GC22989@iweiny-DESK2.sc.intel.com>
References: <20190408023746.16916-1-sjhuang@iluvatar.ai>
 <20190408141313.GU22763@bombadil.infradead.org>
 <20190409010832.GA28081@hsj-Precision-5520>
 <20190409024929.GW22763@bombadil.infradead.org>
 <20190409030417.GA3324@hsj-Precision-5520>
 <20190409111905.GY22763@bombadil.infradead.org>
 <2807E5FD2F6FDA4886F6618EAC48510E79CA51BA@CRSMSX101.amr.corp.intel.com>
 <20190410012034.GB3640@hsj-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410012034.GB3640@hsj-Precision-5520>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 09:20:36AM +0800, Huang Shijie wrote:
> On Tue, Apr 09, 2019 at 02:55:31PM +0000, Weiny, Ira wrote:
> > > On Tue, Apr 09, 2019 at 11:04:18AM +0800, Huang Shijie wrote:
> > > > On Mon, Apr 08, 2019 at 07:49:29PM -0700, Matthew Wilcox wrote:
> > > > > On Tue, Apr 09, 2019 at 09:08:33AM +0800, Huang Shijie wrote:
> > > > > > On Mon, Apr 08, 2019 at 07:13:13AM -0700, Matthew Wilcox wrote:
> > > > > > > On Mon, Apr 08, 2019 at 10:37:45AM +0800, Huang Shijie wrote:
> > > > > > > > The root cause is that sg_alloc_table_from_pages() requires
> > > > > > > > the page order to keep the same as it used in the user space,
> > > > > > > > but
> > > > > > > > get_user_pages_fast() will mess it up.
> > > > > > >
> > > > > > > I don't understand how get_user_pages_fast() can return the
> > > > > > > pages in a different order in the array from the order they appear in
> > > userspace.
> > > > > > > Can you explain?
> > > > > > Please see the code in gup.c:
> > > > > >
> > > > > > 	int get_user_pages_fast(unsigned long start, int nr_pages,
> > > > > > 				unsigned int gup_flags, struct page **pages)
> > > > > > 	{
> > > > > > 		.......
> > > > > > 		if (gup_fast_permitted(start, nr_pages)) {
> > > > > > 			local_irq_disable();
> > > > > > 			gup_pgd_range(addr, end, gup_flags, pages, &nr);
> > > // The @pages array maybe filled at the first time.
> > > > >
> > > > > Right ... but if it's not filled entirely, it will be filled
> > > > > part-way, and then we stop.
> > > > >
> > > > > > 			local_irq_enable();
> > > > > > 			ret = nr;
> > > > > > 		}
> > > > > > 		.......
> > > > > > 		if (nr < nr_pages) {
> > > > > > 			/* Try to get the remaining pages with
> > > get_user_pages */
> > > > > > 			start += nr << PAGE_SHIFT;
> > > > > > 			pages += nr;                                                  // The
> > > @pages is moved forward.
> > > > >
> > > > > Yes, to the point where gup_pgd_range() stopped.
> > > > >
> > > > > > 			if (gup_flags & FOLL_LONGTERM) {
> > > > > > 				down_read(&current->mm->mmap_sem);
> > > > > > 				ret = __gup_longterm_locked(current,
> > > current->mm,      // The @pages maybe filled at the second time
> > > > >
> > > > > Right.
> > > > >
> > > > > > 				/*
> > > > > > 				 * retain FAULT_FOLL_ALLOW_RETRY
> > > optimization if
> > > > > > 				 * possible
> > > > > > 				 */
> > > > > > 				ret = get_user_pages_unlocked(start,
> > > nr_pages - nr,    // The @pages maybe filled at the second time.
> > > > > > 							      pages, gup_flags);
> > > > >
> > > > > Yes.  But they'll be in the same order.
> > > > >
> > > > > > BTW, I do not know why we mess up the page order. It maybe used in
> > > some special case.
> > > > >
> > > > > I'm not discounting the possibility that you've found a bug.
> > > > > But documenting that a bug exists is not the solution; the solution
> > > > > is fixing the bug.
> > > > I do not think it is a bug :)
> > > >
> > > > If we use the get_user_pages_unlocked(), DMA is okay, such as:
> > > >                      ....
> > > > 		     get_user_pages_unlocked()
> > > > 		     sg_alloc_table_from_pages()
> > > > 	             .....
> > > >
> > > > I think the comment is not accurate enough. So just add more comments,
> > > > and tell the driver users how to use the GUPs.
> > > 
> > > gup_fast() and gup_unlocked() should return the pages in the same order.
> > > If they do not, then it is a bug.
> > 
> > Is there a reproducer for this?  Or do you have some debug output which shows this problem?
> Is Matthew right?
> 
>  " gup_fast() and gup_unlocked() should return the pages in the same order.
>  If they do not, then it is a bug."

Yes I think he is...

Ira

> 
> If Matthew is right,
> I need more time to debug the DMA issue...
> 	
> 
> Thanks
> Huang Shijie
>  
> 
> > 
> > Ira
> > 
> 
