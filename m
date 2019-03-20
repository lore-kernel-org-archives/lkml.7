Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54811C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168872184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="EfTOEFcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCTJ2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:28:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36451 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfCTJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:28:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id p10so1512052pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PMKD8S5T9yArnDmdhpqN5MR0f4dumLtOhH5vwozX4IQ=;
        b=EfTOEFcH5cnj4doeFG9zxcqsWx8ydGaJhsKvypWgceFUIkZFyY9CLnRWTuxRLp1+ZS
         52khN2+/SXpeLN+uzhC8amB1KBLKmuL+A7F7NA3Tz5/o4x0mtKx0BnZ0QqPlzR43PN9R
         8f84HPNQDXtodyytZx/1A+4+Dcge4L78IVeSvcTfDRLBT+LvzT/nUNPjtzTh+drtfdg2
         B5Ycd2HGe8iPDKPew7MwVqh9UdCQ/rv8b/VBFDdh+Q6X5uPMpK1dY1DTc82hXg+lgkvC
         hK+ug40jMozhArURfK4G7FT7DBI4sFcFMUUfwPnKWrv3o0Omq/FksIP5NnnfzsyxYpoe
         7XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PMKD8S5T9yArnDmdhpqN5MR0f4dumLtOhH5vwozX4IQ=;
        b=AqAXeF7yJjQOImLFJU4JIeyrnMiXAVBLhFi8BdIHg2fsfjfJ372wPV0G4qSE6Flmh1
         WOtTpJPEBq2PwH4OO2MjSGdR4RCskUD9STOjwSPhhiL3XVEMAjz1xvrUpshKd/PckOxv
         Do7HwQltJpWdLqdJTWoQ28KHWo76Q9XVRXzS8ODVM0c3G0fSBtf3t4pcygxoQy6+QIm3
         c4mfzldNmBxN7+UV5M2JlWZFYuV3Q8RmtLwdsOrshApIXTwu+H172FJLdC20I/0Y1FgQ
         vdpZXifwMl8emn1C2LXk5Yhfl0Co07Mxji1Lx/1uitsJxg+wi7fgf3rfKQtUGk8ErpSQ
         /Usg==
X-Gm-Message-State: APjAAAV8Dll5RBw8fq3f/CpxG8ccB++DT4qa+ADMj26nFbF1lugYxQXc
        d62NldaR6v933PBR2h2vhnUJDQ==
X-Google-Smtp-Source: APXvYqxSqLim0h0p/+px6G2tqdWX71LosiVLrLstelYvy1G6zCFngK8HljidHMKL3LjJ+hzG22N7Gw==
X-Received: by 2002:a17:902:b481:: with SMTP id y1mr3762966plr.338.1553074121866;
        Wed, 20 Mar 2019 02:28:41 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id e123sm2034061pfe.35.2019.03.20.02.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 02:28:40 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 783A13011DB; Wed, 20 Mar 2019 12:28:36 +0300 (+03)
Date:   Wed, 20 Mar 2019 12:28:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, john.hubbard@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
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
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190320092836.rbc3fscxxpibgt3m@kshutemo-mobl1>
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <20190308213633.28978-2-jhubbard@nvidia.com>
 <20190319120417.yzormwjhaeuu7jpp@kshutemo-mobl1>
 <20190319134724.GB3437@redhat.com>
 <20190319140623.tblqyb4dcjabjn3o@kshutemo-mobl1>
 <6aa32cca-d97a-a3e5-b998-c67d0a6cc52a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aa32cca-d97a-a3e5-b998-c67d0a6cc52a@nvidia.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 01:01:01PM -0700, John Hubbard wrote:
> On 3/19/19 7:06 AM, Kirill A. Shutemov wrote:
> > On Tue, Mar 19, 2019 at 09:47:24AM -0400, Jerome Glisse wrote:
> >> On Tue, Mar 19, 2019 at 03:04:17PM +0300, Kirill A. Shutemov wrote:
> >>> On Fri, Mar 08, 2019 at 01:36:33PM -0800, john.hubbard@gmail.com wrote:
> >>>> From: John Hubbard <jhubbard@nvidia.com>
> >>
> >> [...]
> >>
> >>>> diff --git a/mm/gup.c b/mm/gup.c
> >>>> index f84e22685aaa..37085b8163b1 100644
> >>>> --- a/mm/gup.c
> >>>> +++ b/mm/gup.c
> >>>> @@ -28,6 +28,88 @@ struct follow_page_context {
> >>>>  	unsigned int page_mask;
> >>>>  };
> >>>>  
> >>>> +typedef int (*set_dirty_func_t)(struct page *page);
> >>>> +
> >>>> +static void __put_user_pages_dirty(struct page **pages,
> >>>> +				   unsigned long npages,
> >>>> +				   set_dirty_func_t sdf)
> >>>> +{
> >>>> +	unsigned long index;
> >>>> +
> >>>> +	for (index = 0; index < npages; index++) {
> >>>> +		struct page *page = compound_head(pages[index]);
> >>>> +
> >>>> +		if (!PageDirty(page))
> >>>> +			sdf(page);
> >>>
> >>> How is this safe? What prevents the page to be cleared under you?
> >>>
> >>> If it's safe to race clear_page_dirty*() it has to be stated explicitly
> >>> with a reason why. It's not very clear to me as it is.
> >>
> >> The PageDirty() optimization above is fine to race with clear the
> >> page flag as it means it is racing after a page_mkclean() and the
> >> GUP user is done with the page so page is about to be write back
> >> ie if (!PageDirty(page)) see the page as dirty and skip the sdf()
> >> call while a split second after TestClearPageDirty() happens then
> >> it means the racing clear is about to write back the page so all
> >> is fine (the page was dirty and it is being clear for write back).
> >>
> >> If it does call the sdf() while racing with write back then we
> >> just redirtied the page just like clear_page_dirty_for_io() would
> >> do if page_mkclean() failed so nothing harmful will come of that
> >> neither. Page stays dirty despite write back it just means that
> >> the page might be write back twice in a row.
> > 
> > Fair enough. Should we get it into a comment here?
> 
> How's this read to you? I reworded and slightly expanded Jerome's 
> description:
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index d1df7b8ba973..86397ae23922 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -61,6 +61,24 @@ static void __put_user_pages_dirty(struct page **pages,
>         for (index = 0; index < npages; index++) {
>                 struct page *page = compound_head(pages[index]);
>  
> +               /*
> +                * Checking PageDirty at this point may race with
> +                * clear_page_dirty_for_io(), but that's OK. Two key cases:
> +                *
> +                * 1) This code sees the page as already dirty, so it skips
> +                * the call to sdf(). That could happen because
> +                * clear_page_dirty_for_io() called page_mkclean(),
> +                * followed by set_page_dirty(). However, now the page is
> +                * going to get written back, which meets the original
> +                * intention of setting it dirty, so all is well:
> +                * clear_page_dirty_for_io() goes on to call
> +                * TestClearPageDirty(), and write the page back.
> +                *
> +                * 2) This code sees the page as clean, so it calls sdf().
> +                * The page stays dirty, despite being written back, so it
> +                * gets written back again in the next writeback cycle.
> +                * This is harmless.
> +                */
>                 if (!PageDirty(page))
>                         sdf(page);

Looks good to me.

Other nit: effectively the same type of callback called 'spd' in
set_page_dirty(). Should we rename 'sdf' to 'sdp' here too?

> >>>> +void put_user_pages(struct page **pages, unsigned long npages)
> >>>> +{
> >>>> +	unsigned long index;
> >>>> +
> >>>> +	for (index = 0; index < npages; index++)
> >>>> +		put_user_page(pages[index]);
> >>>
> >>> I believe there's an room for improvement for compound pages.
> >>>
> >>> If there's multiple consequential pages in the array that belong to the
> >>> same compound page we can get away with a single atomic operation to
> >>> handle them all.
> >>
> >> Yes maybe just add a comment with that for now and leave this kind of
> >> optimization to latter ?
> > 
> > Sounds good to me.
> > 
> 
> Here's a comment for that:
> 
> @@ -127,6 +145,11 @@ void put_user_pages(struct page **pages, unsigned long npages)
>  {
>         unsigned long index;
>  
> +       /*
> +        * TODO: this can be optimized for huge pages: if a series of pages is
> +        * physically contiguous and part of the same compound page, then a

Comound pages are always physically contiguous. I initially ment that the
optimization makes sense if they are next to each other in 'pages' array.

> +        * single operation to the head page should suffice.
> +        */
>         for (index = 0; index < npages; index++)
>                 put_user_page(pages[index]);
>  }
> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA

-- 
 Kirill A. Shutemov
