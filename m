Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBB2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BD72083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfCSREp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:04:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:2385 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSREo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:04:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 10:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,245,1549958400"; 
   d="scan'208";a="308543962"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2019 10:04:42 -0700
Date:   Tue, 19 Mar 2019 02:03:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>, john.hubbard@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190319090322.GE7485@iweiny-DESK2.sc.intel.com>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <20190308213633.28978-2-jhubbard@nvidia.com>
 <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
 <20190319134724.GB3437@redhat.com>
 <20190319141416.GA3879@redhat.com>
 <20190319142918.6a5vom55aeojapjp@kshutemo-mobl1>
 <20190319153644.GB26099@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319153644.GB26099@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:36:44PM +0100, Jan Kara wrote:
> On Tue 19-03-19 17:29:18, Kirill A. Shutemov wrote:
> > On Tue, Mar 19, 2019 at 10:14:16AM -0400, Jerome Glisse wrote:
> > > On Tue, Mar 19, 2019 at 09:47:24AM -0400, Jerome Glisse wrote:
> > > > On Tue, Mar 19, 2019 at 03:04:17PM +0300, Kirill A. Shutemov wrote:
> > > > > On Fri, Mar 08, 2019 at 01:36:33PM -0800, john.hubbard@gmail.com wrote:
> > > > > > From: John Hubbard <jhubbard@nvidia.com>
> > > > 
> > > > [...]
> > > > 
> > > > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > > > index f84e22685aaa..37085b8163b1 100644
> > > > > > --- a/mm/gup.c
> > > > > > +++ b/mm/gup.c
> > > > > > @@ -28,6 +28,88 @@ struct follow_page_context {
> > > > > >  	unsigned int page_mask;
> > > > > >  };
> > > > > >  
> > > > > > +typedef int (*set_dirty_func_t)(struct page *page);
> > > > > > +
> > > > > > +static void __put_user_pages_dirty(struct page **pages,
> > > > > > +				   unsigned long npages,
> > > > > > +				   set_dirty_func_t sdf)
> > > > > > +{
> > > > > > +	unsigned long index;
> > > > > > +
> > > > > > +	for (index = 0; index < npages; index++) {
> > > > > > +		struct page *page = compound_head(pages[index]);
> > > > > > +
> > > > > > +		if (!PageDirty(page))
> > > > > > +			sdf(page);
> > > > > 
> > > > > How is this safe? What prevents the page to be cleared under you?
> > > > > 
> > > > > If it's safe to race clear_page_dirty*() it has to be stated explicitly
> > > > > with a reason why. It's not very clear to me as it is.
> > > > 
> > > > The PageDirty() optimization above is fine to race with clear the
> > > > page flag as it means it is racing after a page_mkclean() and the
> > > > GUP user is done with the page so page is about to be write back
> > > > ie if (!PageDirty(page)) see the page as dirty and skip the sdf()
> > > > call while a split second after TestClearPageDirty() happens then
> > > > it means the racing clear is about to write back the page so all
> > > > is fine (the page was dirty and it is being clear for write back).
> > > > 
> > > > If it does call the sdf() while racing with write back then we
> > > > just redirtied the page just like clear_page_dirty_for_io() would
> > > > do if page_mkclean() failed so nothing harmful will come of that
> > > > neither. Page stays dirty despite write back it just means that
> > > > the page might be write back twice in a row.
> > > 
> > > Forgot to mention one thing, we had a discussion with Andrea and Jan
> > > about set_page_dirty() and Andrea had the good idea of maybe doing
> > > the set_page_dirty() at GUP time (when GUP with write) not when the
> > > GUP user calls put_page(). We can do that by setting the dirty bit
> > > in the pte for instance. They are few bonus of doing things that way:
> > >     - amortize the cost of calling set_page_dirty() (ie one call for
> > >       GUP and page_mkclean()
> > >     - it is always safe to do so at GUP time (ie the pte has write
> > >       permission and thus the page is in correct state)
> > >     - safe from truncate race
> > >     - no need to ever lock the page
> > > 
> > > Extra bonus from my point of view, it simplify thing for my generic
> > > page protection patchset (KSM for file back page).
> > > 
> > > So maybe we should explore that ? It would also be a lot less code.
> > 
> > Yes, please. It sounds more sensible to me to dirty the page on get, not
> > on put.
> 
> I fully agree this is a desirable final state of affairs.

I'm glad to see this presented because it has crossed my mind more than once
that effectively a GUP pinned page should be considered "dirty" at all times
until the pin is removed.  This is especially true in the RDMA case.

> And with changes
> to how we treat pinned pages during writeback there won't have to be any
> explicit dirtying at all in the end because the page is guaranteed to be
> dirty after a write page fault and pin would make sure it stays dirty until
> unpinned. However initially I want the helpers to be as close to code they
> are replacing as possible. Because it will be hard to catch all the bugs
> due to driver conversions even in that situation. So I still think that
> these helpers as they are a good first step. Then we need to convert
> GUP users to use them and then it is much easier to modify the behavior
> since it is no longer opencoded in two hudred or how many places...

Agreed.  I continue to test with these patches and RDMA and have not seen any
problems thus far.

Ira

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
