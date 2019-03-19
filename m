Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644B9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9AA2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCSUpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:45:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfCSUpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:45:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05578F74AC;
        Tue, 19 Mar 2019 20:45:20 +0000 (UTC)
Received: from redhat.com (ovpn-120-246.rdu2.redhat.com [10.10.120.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A402D60C7F;
        Tue, 19 Mar 2019 20:45:15 +0000 (UTC)
Date:   Tue, 19 Mar 2019 16:45:13 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Tom Talpey <tom@talpey.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
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
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190319204512.GB3096@redhat.com>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <20190308213633.28978-2-jhubbard@nvidia.com>
 <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
 <20190319134724.GB3437@redhat.com>
 <20190319141416.GA3879@redhat.com>
 <20190319142918.6a5vom55aeojapjp@kshutemo-mobl1>
 <20190319153644.GB26099@quack2.suse.cz>
 <20190319090322.GE7485@iweiny-DESK2.sc.intel.com>
 <f9195df4-66ca-95f6-874e-d19cd775794d@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9195df4-66ca-95f6-874e-d19cd775794d@talpey.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 19 Mar 2019 20:45:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:43:44PM -0500, Tom Talpey wrote:
> On 3/19/2019 4:03 AM, Ira Weiny wrote:
> > On Tue, Mar 19, 2019 at 04:36:44PM +0100, Jan Kara wrote:
> > > On Tue 19-03-19 17:29:18, Kirill A. Shutemov wrote:
> > > > On Tue, Mar 19, 2019 at 10:14:16AM -0400, Jerome Glisse wrote:
> > > > > On Tue, Mar 19, 2019 at 09:47:24AM -0400, Jerome Glisse wrote:
> > > > > > On Tue, Mar 19, 2019 at 03:04:17PM +0300, Kirill A. Shutemov wrote:
> > > > > > > On Fri, Mar 08, 2019 at 01:36:33PM -0800, john.hubbard@gmail.com wrote:
> > > > > > > > From: John Hubbard <jhubbard@nvidia.com>
> > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > > > > > index f84e22685aaa..37085b8163b1 100644
> > > > > > > > --- a/mm/gup.c
> > > > > > > > +++ b/mm/gup.c
> > > > > > > > @@ -28,6 +28,88 @@ struct follow_page_context {
> > > > > > > >   	unsigned int page_mask;
> > > > > > > >   };
> > > > > > > > +typedef int (*set_dirty_func_t)(struct page *page);
> > > > > > > > +
> > > > > > > > +static void __put_user_pages_dirty(struct page **pages,
> > > > > > > > +				   unsigned long npages,
> > > > > > > > +				   set_dirty_func_t sdf)
> > > > > > > > +{
> > > > > > > > +	unsigned long index;
> > > > > > > > +
> > > > > > > > +	for (index = 0; index < npages; index++) {
> > > > > > > > +		struct page *page = compound_head(pages[index]);
> > > > > > > > +
> > > > > > > > +		if (!PageDirty(page))
> > > > > > > > +			sdf(page);
> > > > > > > 
> > > > > > > How is this safe? What prevents the page to be cleared under you?
> > > > > > > 
> > > > > > > If it's safe to race clear_page_dirty*() it has to be stated explicitly
> > > > > > > with a reason why. It's not very clear to me as it is.
> > > > > > 
> > > > > > The PageDirty() optimization above is fine to race with clear the
> > > > > > page flag as it means it is racing after a page_mkclean() and the
> > > > > > GUP user is done with the page so page is about to be write back
> > > > > > ie if (!PageDirty(page)) see the page as dirty and skip the sdf()
> > > > > > call while a split second after TestClearPageDirty() happens then
> > > > > > it means the racing clear is about to write back the page so all
> > > > > > is fine (the page was dirty and it is being clear for write back).
> > > > > > 
> > > > > > If it does call the sdf() while racing with write back then we
> > > > > > just redirtied the page just like clear_page_dirty_for_io() would
> > > > > > do if page_mkclean() failed so nothing harmful will come of that
> > > > > > neither. Page stays dirty despite write back it just means that
> > > > > > the page might be write back twice in a row.
> > > > > 
> > > > > Forgot to mention one thing, we had a discussion with Andrea and Jan
> > > > > about set_page_dirty() and Andrea had the good idea of maybe doing
> > > > > the set_page_dirty() at GUP time (when GUP with write) not when the
> > > > > GUP user calls put_page(). We can do that by setting the dirty bit
> > > > > in the pte for instance. They are few bonus of doing things that way:
> > > > >      - amortize the cost of calling set_page_dirty() (ie one call for
> > > > >        GUP and page_mkclean()
> > > > >      - it is always safe to do so at GUP time (ie the pte has write
> > > > >        permission and thus the page is in correct state)
> > > > >      - safe from truncate race
> > > > >      - no need to ever lock the page
> > > > > 
> > > > > Extra bonus from my point of view, it simplify thing for my generic
> > > > > page protection patchset (KSM for file back page).
> > > > > 
> > > > > So maybe we should explore that ? It would also be a lot less code.
> > > > 
> > > > Yes, please. It sounds more sensible to me to dirty the page on get, not
> > > > on put.
> > > 
> > > I fully agree this is a desirable final state of affairs.
> > 
> > I'm glad to see this presented because it has crossed my mind more than once
> > that effectively a GUP pinned page should be considered "dirty" at all times
> > until the pin is removed.  This is especially true in the RDMA case.
> 
> But, what if the RDMA registration is readonly? That's not uncommon, and
> marking dirty unconditonally would add needless overhead to such pages.

Yes and this is only when FOLL_WRITE is set ie when you are doing GUP and
asking for write. Doing GUP and asking for read is always safe.

Cheers,
Jérôme
