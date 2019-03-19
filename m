Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6053C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9640F2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dsShfLT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfCSO3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:29:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40366 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfCSO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:29:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so13964993pgo.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 07:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9om5QJZsJKNhMP+qIVE/OgL0ptHNmMTB1Erc9MBg9Gs=;
        b=dsShfLT5ONbIyV9P7eRs1l/EGJTZUK1Wx/pyJu1mXTBZUOiNW01pRqIGgSS745AQT9
         mslmk0ARTFjsgy9s2CboNPlVYLeO8EL9QcMNAYsevKih8GhtHOqnDwQyZAgaaI/OF8Aw
         CQoy1lJPmeNhmBUaubMRQrbkbch8eH0QjMBkegJ1VtEM6VOo14XwXOU5VvL0cA67RfTb
         TpKzZQPAZUyV5ffp9ClckR4KTBlT1H8qGxf3pZas30ng/5md12Hpwpm0qNIUcMMwyTWF
         MyOIOsgcpeVCIH5xM5xiq6DkkgSsvCObtTlelL2yD6TbavY8uMXoWVLs8ZCOXOZMiSnz
         JWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9om5QJZsJKNhMP+qIVE/OgL0ptHNmMTB1Erc9MBg9Gs=;
        b=tAq6ZlxtIoc5WrTFXeA7YV0TbIs3hCQzmgHaG70hrlIyOpGQ2EIQj4tXisFJHx+FXT
         AB8CY7RzUL2VZtBtQC5uLz2C6zS7/qSRzjefhyQ0mgnW61Eu0rKLz2vUCnWg9FlQsrRA
         bUZHnnezF1IxRKt7F+89mOSHLG0hIBrpH54N1enNyIKPFaHz4sX5Dhg2N7ya9BlyCKlr
         CAofVDrw+EifrURZLh+Fy9ZhVC7J5HmtslIH6F+WGeiccdqHt6oyl0cVHttQIcZCfBlz
         cMDZSw5ViHPWH/Q4DsXGbseaFl8utBqQzbnSSCbaiydO9TLz0CsJivK5GA5rXNjK9wM2
         EjpQ==
X-Gm-Message-State: APjAAAVxinyJNxDJPUwebmmCsMr+OSi4kKzKswIspHGuZr+PLlNTV6cI
        sUeNGeGReoaVssZN0JJQBJxZDg==
X-Google-Smtp-Source: APXvYqwVlnkNNeWECRvv0LgzsnPJkLdTZl0ZYqkVgXeRvM69+DJG+xllmrD9YvrSDgTnYy8wdGHdNw==
X-Received: by 2002:a17:902:168:: with SMTP id 95mr2414703plb.212.1553005763360;
        Tue, 19 Mar 2019 07:29:23 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id b7sm28545812pff.136.2019.03.19.07.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 07:29:22 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id C09CC3011DA; Tue, 19 Mar 2019 17:29:18 +0300 (+03)
Date:   Tue, 19 Mar 2019 17:29:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jerome Glisse <jglisse@redhat.com>
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
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190319142918.6a5vom55aeojapjp@kshutemo-mobl1>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <20190308213633.28978-2-jhubbard@nvidia.com>
 <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
 <20190319134724.GB3437@redhat.com>
 <20190319141416.GA3879@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319141416.GA3879@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:14:16AM -0400, Jerome Glisse wrote:
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
> Forgot to mention one thing, we had a discussion with Andrea and Jan
> about set_page_dirty() and Andrea had the good idea of maybe doing
> the set_page_dirty() at GUP time (when GUP with write) not when the
> GUP user calls put_page(). We can do that by setting the dirty bit
> in the pte for instance. They are few bonus of doing things that way:
>     - amortize the cost of calling set_page_dirty() (ie one call for
>       GUP and page_mkclean()
>     - it is always safe to do so at GUP time (ie the pte has write
>       permission and thus the page is in correct state)
>     - safe from truncate race
>     - no need to ever lock the page
> 
> Extra bonus from my point of view, it simplify thing for my generic
> page protection patchset (KSM for file back page).
> 
> So maybe we should explore that ? It would also be a lot less code.

Yes, please. It sounds more sensible to me to dirty the page on get, not
on put.

-- 
 Kirill A. Shutemov
