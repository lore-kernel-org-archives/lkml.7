Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5262EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E332147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfCSOPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:15:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSOPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:15:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 866CC40F44;
        Tue, 19 Mar 2019 14:15:37 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A17218BBA;
        Tue, 19 Mar 2019 14:15:35 +0000 (UTC)
Date:   Tue, 19 Mar 2019 10:15:33 -0400
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
Message-ID: <20190319141533.GB3879@redhat.com>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <20190308213633.28978-2-jhubbard@nvidia.com>
 <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
 <20190319134724.GB3437@redhat.com>
 <20190319140623.tblqyb4dcjabjn3o@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319140623.tblqyb4dcjabjn3o@kshutemo-mobl1>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 19 Mar 2019 14:15:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 05:06:23PM +0300, Kirill A. Shutemov wrote:
> On Tue, Mar 19, 2019 at 09:47:24AM -0400, Jerome Glisse wrote:
> > On Tue, Mar 19, 2019 at 03:04:17PM +0300, Kirill A. Shutemov wrote:
> > > On Fri, Mar 08, 2019 at 01:36:33PM -0800, john.hubbard@gmail.com wrote:
> > > > From: John Hubbard <jhubbard@nvidia.com>
> > 
> > [...]
> > 
> > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > index f84e22685aaa..37085b8163b1 100644
> > > > --- a/mm/gup.c
> > > > +++ b/mm/gup.c
> > > > @@ -28,6 +28,88 @@ struct follow_page_context {
> > > >  	unsigned int page_mask;
> > > >  };
> > > >  
> > > > +typedef int (*set_dirty_func_t)(struct page *page);
> > > > +
> > > > +static void __put_user_pages_dirty(struct page **pages,
> > > > +				   unsigned long npages,
> > > > +				   set_dirty_func_t sdf)
> > > > +{
> > > > +	unsigned long index;
> > > > +
> > > > +	for (index = 0; index < npages; index++) {
> > > > +		struct page *page = compound_head(pages[index]);
> > > > +
> > > > +		if (!PageDirty(page))
> > > > +			sdf(page);
> > > 
> > > How is this safe? What prevents the page to be cleared under you?
> > > 
> > > If it's safe to race clear_page_dirty*() it has to be stated explicitly
> > > with a reason why. It's not very clear to me as it is.
> > 
> > The PageDirty() optimization above is fine to race with clear the
> > page flag as it means it is racing after a page_mkclean() and the
> > GUP user is done with the page so page is about to be write back
> > ie if (!PageDirty(page)) see the page as dirty and skip the sdf()
> > call while a split second after TestClearPageDirty() happens then
> > it means the racing clear is about to write back the page so all
> > is fine (the page was dirty and it is being clear for write back).
> > 
> > If it does call the sdf() while racing with write back then we
> > just redirtied the page just like clear_page_dirty_for_io() would
> > do if page_mkclean() failed so nothing harmful will come of that
> > neither. Page stays dirty despite write back it just means that
> > the page might be write back twice in a row.
> 
> Fair enough. Should we get it into a comment here?

Yes definitly also i just sent an email with an alternative that is
slightly better from my POV as it simplify my life for other things :)

Cheers,
Jérôme
