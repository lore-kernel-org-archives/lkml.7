Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D63C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A212085A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfCTAIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:08:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfCTAIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:08:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B023E2D7E0;
        Wed, 20 Mar 2019 00:08:45 +0000 (UTC)
Received: from redhat.com (ovpn-120-246.rdu2.redhat.com [10.10.120.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CA591973C;
        Wed, 20 Mar 2019 00:08:41 +0000 (UTC)
Date:   Tue, 19 Mar 2019 20:08:39 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190320000838.GA6364@redhat.com>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <20190308213633.28978-2-jhubbard@nvidia.com>
 <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
 <20190319134724.GB3437@redhat.com>
 <20190319141416.GA3879@redhat.com>
 <20190319212346.GA26298@dastard>
 <20190319220654.GC3096@redhat.com>
 <20190319235752.GB26298@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319235752.GB26298@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 20 Mar 2019 00:08:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:57:52AM +1100, Dave Chinner wrote:
> On Tue, Mar 19, 2019 at 06:06:55PM -0400, Jerome Glisse wrote:
> > On Wed, Mar 20, 2019 at 08:23:46AM +1100, Dave Chinner wrote:
> > > On Tue, Mar 19, 2019 at 10:14:16AM -0400, Jerome Glisse wrote:
> > > > On Tue, Mar 19, 2019 at 09:47:24AM -0400, Jerome Glisse wrote:
> > > > > On Tue, Mar 19, 2019 at 03:04:17PM +0300, Kirill A. Shutemov wrote:
> > > > > > On Fri, Mar 08, 2019 at 01:36:33PM -0800, john.hubbard@gmail.com wrote:
> > > > > > > From: John Hubbard <jhubbard@nvidia.com>
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > > > > index f84e22685aaa..37085b8163b1 100644
> > > > > > > --- a/mm/gup.c
> > > > > > > +++ b/mm/gup.c
> > > > > > > @@ -28,6 +28,88 @@ struct follow_page_context {
> > > > > > >  	unsigned int page_mask;
> > > > > > >  };
> > > > > > >  
> > > > > > > +typedef int (*set_dirty_func_t)(struct page *page);
> > > > > > > +
> > > > > > > +static void __put_user_pages_dirty(struct page **pages,
> > > > > > > +				   unsigned long npages,
> > > > > > > +				   set_dirty_func_t sdf)
> > > > > > > +{
> > > > > > > +	unsigned long index;
> > > > > > > +
> > > > > > > +	for (index = 0; index < npages; index++) {
> > > > > > > +		struct page *page = compound_head(pages[index]);
> > > > > > > +
> > > > > > > +		if (!PageDirty(page))
> > > > > > > +			sdf(page);
> > > > > > 
> > > > > > How is this safe? What prevents the page to be cleared under you?
> > > > > > 
> > > > > > If it's safe to race clear_page_dirty*() it has to be stated explicitly
> > > > > > with a reason why. It's not very clear to me as it is.
> > > > > 
> > > > > The PageDirty() optimization above is fine to race with clear the
> > > > > page flag as it means it is racing after a page_mkclean() and the
> > > > > GUP user is done with the page so page is about to be write back
> > > > > ie if (!PageDirty(page)) see the page as dirty and skip the sdf()
> > > > > call while a split second after TestClearPageDirty() happens then
> > > > > it means the racing clear is about to write back the page so all
> > > > > is fine (the page was dirty and it is being clear for write back).
> > > > > 
> > > > > If it does call the sdf() while racing with write back then we
> > > > > just redirtied the page just like clear_page_dirty_for_io() would
> > > > > do if page_mkclean() failed so nothing harmful will come of that
> > > > > neither. Page stays dirty despite write back it just means that
> > > > > the page might be write back twice in a row.
> > > > 
> > > > Forgot to mention one thing, we had a discussion with Andrea and Jan
> > > > about set_page_dirty() and Andrea had the good idea of maybe doing
> > > > the set_page_dirty() at GUP time (when GUP with write) not when the
> > > > GUP user calls put_page(). We can do that by setting the dirty bit
> > > > in the pte for instance. They are few bonus of doing things that way:
> > > >     - amortize the cost of calling set_page_dirty() (ie one call for
> > > >       GUP and page_mkclean()
> > > >     - it is always safe to do so at GUP time (ie the pte has write
> > > >       permission and thus the page is in correct state)
> > > >     - safe from truncate race
> > > >     - no need to ever lock the page
> > > 
> > > I seem to have missed this conversation, so please excuse me for
> > 
> > The set_page_dirty() at GUP was in a private discussion (it started
> > on another topic and drifted away to set_page_dirty()).
> > 
> > > asking a stupid question: if it's a file backed page, what prevents
> > > background writeback from cleaning the dirty page ~30s into a long
> > > term pin? i.e. I don't see anything in this proposal that prevents
> > > the page from being cleaned by writeback and putting us straight
> > > back into the situation where a long term RDMA is writing to a clean
> > > page....
> > 
> > So this patchset does not solve this issue.
> 
> OK, so it just kicks the can further down the road.
> 
> >     [3..N] decide what to do for GUPed page, so far the plans seems
> >          to be to keep the page always dirty and never allow page
> >          write back to restore the page in a clean state. This does
> >          disable thing like COW and other fs feature but at least
> >          it seems to be the best thing we can do.
> 
> So the plan for GUP vs writeback so far is "break fsync()"? :)
> 
> We might need to work on that a bit more...

Sorry forgot to say that we still do write back using a bounce page
so that at least we write something to disk that is just a snapshot
of the GUPed page everytime writeback kicks in (so either through
radix tree dirty page write back or fsync or any other sync events).
So many little details that i forgot the big chunk :)

Cheers,
Jérôme
