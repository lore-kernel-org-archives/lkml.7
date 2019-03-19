Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5FEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5FC2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfCSNra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:47:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfCSNra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:47:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AE0320277;
        Tue, 19 Mar 2019 13:47:29 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A26125D706;
        Tue, 19 Mar 2019 13:47:26 +0000 (UTC)
Date:   Tue, 19 Mar 2019 09:47:24 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190319134724.GB3437@redhat.com>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <20190308213633.28978-2-jhubbard@nvidia.com>
 <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 19 Mar 2019 13:47:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:04:17PM +0300, Kirill A. Shutemov wrote:
> On Fri, Mar 08, 2019 at 01:36:33PM -0800, john.hubbard@gmail.com wrote:
> > From: John Hubbard <jhubbard@nvidia.com>

[...]

> > diff --git a/mm/gup.c b/mm/gup.c
> > index f84e22685aaa..37085b8163b1 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -28,6 +28,88 @@ struct follow_page_context {
> >  	unsigned int page_mask;
> >  };
> >  
> > +typedef int (*set_dirty_func_t)(struct page *page);
> > +
> > +static void __put_user_pages_dirty(struct page **pages,
> > +				   unsigned long npages,
> > +				   set_dirty_func_t sdf)
> > +{
> > +	unsigned long index;
> > +
> > +	for (index = 0; index < npages; index++) {
> > +		struct page *page = compound_head(pages[index]);
> > +
> > +		if (!PageDirty(page))
> > +			sdf(page);
> 
> How is this safe? What prevents the page to be cleared under you?
> 
> If it's safe to race clear_page_dirty*() it has to be stated explicitly
> with a reason why. It's not very clear to me as it is.

The PageDirty() optimization above is fine to race with clear the
page flag as it means it is racing after a page_mkclean() and the
GUP user is done with the page so page is about to be write back
ie if (!PageDirty(page)) see the page as dirty and skip the sdf()
call while a split second after TestClearPageDirty() happens then
it means the racing clear is about to write back the page so all
is fine (the page was dirty and it is being clear for write back).

If it does call the sdf() while racing with write back then we
just redirtied the page just like clear_page_dirty_for_io() would
do if page_mkclean() failed so nothing harmful will come of that
neither. Page stays dirty despite write back it just means that
the page might be write back twice in a row.

> > +
> > +		put_user_page(page);
> > +	}
> > +}
> > +
> > +/**
> > + * put_user_pages_dirty() - release and dirty an array of gup-pinned pages
> > + * @pages:  array of pages to be marked dirty and released.
> > + * @npages: number of pages in the @pages array.
> > + *
> > + * "gup-pinned page" refers to a page that has had one of the get_user_pages()
> > + * variants called on that page.
> > + *
> > + * For each page in the @pages array, make that page (or its head page, if a
> > + * compound page) dirty, if it was previously listed as clean. Then, release
> > + * the page using put_user_page().
> > + *
> > + * Please see the put_user_page() documentation for details.
> > + *
> > + * set_page_dirty(), which does not lock the page, is used here.
> > + * Therefore, it is the caller's responsibility to ensure that this is
> > + * safe. If not, then put_user_pages_dirty_lock() should be called instead.
> > + *
> > + */
> > +void put_user_pages_dirty(struct page **pages, unsigned long npages)
> > +{
> > +	__put_user_pages_dirty(pages, npages, set_page_dirty);
> 
> Have you checked if compiler is clever enough eliminate indirect function
> call here? Maybe it's better to go with an opencodded approach and get rid
> of callbacks?
> 

Good point, dunno if John did check that.

> 
> > +}
> > +EXPORT_SYMBOL(put_user_pages_dirty);
> > +
> > +/**
> > + * put_user_pages_dirty_lock() - release and dirty an array of gup-pinned pages
> > + * @pages:  array of pages to be marked dirty and released.
> > + * @npages: number of pages in the @pages array.
> > + *
> > + * For each page in the @pages array, make that page (or its head page, if a
> > + * compound page) dirty, if it was previously listed as clean. Then, release
> > + * the page using put_user_page().
> > + *
> > + * Please see the put_user_page() documentation for details.
> > + *
> > + * This is just like put_user_pages_dirty(), except that it invokes
> > + * set_page_dirty_lock(), instead of set_page_dirty().
> > + *
> > + */
> > +void put_user_pages_dirty_lock(struct page **pages, unsigned long npages)
> > +{
> > +	__put_user_pages_dirty(pages, npages, set_page_dirty_lock);
> > +}
> > +EXPORT_SYMBOL(put_user_pages_dirty_lock);
> > +
> > +/**
> > + * put_user_pages() - release an array of gup-pinned pages.
> > + * @pages:  array of pages to be marked dirty and released.
> > + * @npages: number of pages in the @pages array.
> > + *
> > + * For each page in the @pages array, release the page using put_user_page().
> > + *
> > + * Please see the put_user_page() documentation for details.
> > + */
> > +void put_user_pages(struct page **pages, unsigned long npages)
> > +{
> > +	unsigned long index;
> > +
> > +	for (index = 0; index < npages; index++)
> > +		put_user_page(pages[index]);
> 
> I believe there's an room for improvement for compound pages.
> 
> If there's multiple consequential pages in the array that belong to the
> same compound page we can get away with a single atomic operation to
> handle them all.

Yes maybe just add a comment with that for now and leave this kind of
optimization to latter ?

