Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798CBC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ACD2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="PzB1zI90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfCSOGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:06:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46134 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCSOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:06:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so13893511pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bHQ3oqYGOw6mAzwKVyAQ07+Fulp0qnOCWUl38WK1ISQ=;
        b=PzB1zI909lcNM/YzJY+3015iZEf+PdrS5ILcrKJDxpepK1ilmkl1iWSwgLK9C9jRuP
         lOEn9+woDg4FXKUQhKzz/YbTR2wcU50xlTG0nyqh871ae8/mVgJytd0beXkNQGM25ylV
         4GGYBZBaJR8lMwmEtIcAJJO9itvYqUjKu3NxBvPkUB5Q8GIBEjNFXzZT1WpC0wRkTDfl
         CxRBSP5n0HBYvdzdccyKtIPhgKLJO3xKcRA+RTAnqWh4X4jvFP+lveusANkgpepxgHQR
         nJ5g3BPEaN47OoRHxLAgMTIoYTj3tCqRpGmQkPlsmlxULX/JK45v3358CtvVxYqpfyJ4
         EWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bHQ3oqYGOw6mAzwKVyAQ07+Fulp0qnOCWUl38WK1ISQ=;
        b=X6z6j8rTGtcAOVCgDz8eo4Fi+JD64FltW5AMoHCyYxQXuPBPuT4w+WYUhRbti3P46M
         ZlmRTtLk2pcZ+tLGys+wBe4MrZpPnBOgWFelFqt+EUzMjyev/akLpG2mDwSLIk/k6ic/
         hXaNdxdOkOqCD8c4J14EVYTiBZk7CNsdIclG+MMbtB/1XFUVrM+7gc7N2YHgX92rEhA6
         MvuoKxhD1QDai0KPfqUm18i7iOd/34f2awGViUICvi4LEhn2btt+hnZWfVeBRG5z2m0q
         5gY2RCbWfl3alEnEttEJwJPbCLtYfuyUwiHxqe9fJ8mhDo23LSU5IjSkFukccZvcqIzE
         Gxgg==
X-Gm-Message-State: APjAAAXeB1KAWQa+UycKO3tEteNYAmUoMQyADMnN6KKcQTEBmZyTQ2HQ
        6c3Ey0PYb/CHQIx1vQrMEuHtQw==
X-Google-Smtp-Source: APXvYqzh/5+h50GyWZg4rnMdZOduspnjHPSIFlsjDZ11nKe18mb/ykay6zBdJhPiKKsk14fO52eTkw==
X-Received: by 2002:aa7:8d17:: with SMTP id j23mr2201765pfe.62.1553004388699;
        Tue, 19 Mar 2019 07:06:28 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id l5sm24631404pfi.97.2019.03.19.07.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 07:06:28 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id C7BBB3011DA; Tue, 19 Mar 2019 17:06:23 +0300 (+03)
Date:   Tue, 19 Mar 2019 17:06:23 +0300
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
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190319140623.tblqyb4dcjabjn3o@kshutemo-mobl1>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <20190308213633.28978-2-jhubbard@nvidia.com>
 <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
 <20190319134724.GB3437@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319134724.GB3437@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:47:24AM -0400, Jerome Glisse wrote:
> On Tue, Mar 19, 2019 at 03:04:17PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Mar 08, 2019 at 01:36:33PM -0800, john.hubbard@gmail.com wrote:
> > > From: John Hubbard <jhubbard@nvidia.com>
> 
> [...]
> 
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index f84e22685aaa..37085b8163b1 100644
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -28,6 +28,88 @@ struct follow_page_context {
> > >  	unsigned int page_mask;
> > >  };
> > >  
> > > +typedef int (*set_dirty_func_t)(struct page *page);
> > > +
> > > +static void __put_user_pages_dirty(struct page **pages,
> > > +				   unsigned long npages,
> > > +				   set_dirty_func_t sdf)
> > > +{
> > > +	unsigned long index;
> > > +
> > > +	for (index = 0; index < npages; index++) {
> > > +		struct page *page = compound_head(pages[index]);
> > > +
> > > +		if (!PageDirty(page))
> > > +			sdf(page);
> > 
> > How is this safe? What prevents the page to be cleared under you?
> > 
> > If it's safe to race clear_page_dirty*() it has to be stated explicitly
> > with a reason why. It's not very clear to me as it is.
> 
> The PageDirty() optimization above is fine to race with clear the
> page flag as it means it is racing after a page_mkclean() and the
> GUP user is done with the page so page is about to be write back
> ie if (!PageDirty(page)) see the page as dirty and skip the sdf()
> call while a split second after TestClearPageDirty() happens then
> it means the racing clear is about to write back the page so all
> is fine (the page was dirty and it is being clear for write back).
> 
> If it does call the sdf() while racing with write back then we
> just redirtied the page just like clear_page_dirty_for_io() would
> do if page_mkclean() failed so nothing harmful will come of that
> neither. Page stays dirty despite write back it just means that
> the page might be write back twice in a row.

Fair enough. Should we get it into a comment here?

> > > +void put_user_pages(struct page **pages, unsigned long npages)
> > > +{
> > > +	unsigned long index;
> > > +
> > > +	for (index = 0; index < npages; index++)
> > > +		put_user_page(pages[index]);
> > 
> > I believe there's an room for improvement for compound pages.
> > 
> > If there's multiple consequential pages in the array that belong to the
> > same compound page we can get away with a single atomic operation to
> > handle them all.
> 
> Yes maybe just add a comment with that for now and leave this kind of
> optimization to latter ?

Sounds good to me.

-- 
 Kirill A. Shutemov
