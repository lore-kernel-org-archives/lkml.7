Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032D7C28D18
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07E520872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmgXYItR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfFFCTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:19:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40534 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfFFCTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:19:50 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so99669ioc.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 19:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTWH24yA/1C8wqtT9jqxaOXK4VdWlElUekSQr6wCUNk=;
        b=kmgXYItRTWz7KU83m4f4kQdWt8EQlqNIcHOHwnh10wNa68tCz1p6bokonrDgngqEr+
         FRMLMaIy/lj5RAYS2Z0jJjnURXbh17DPBk341t6COKHH3QlsLfEvtoqXP1NllVRwEicd
         1SsU9xldKIqlRNVu1j1kw49OJgqIolMCZuxAzit5j6NdewERw7I9rjzHfEFc8Lk8ntwd
         XI1GCa7jtok3tNC+8zLVW7bL2tYjpPP1Md3foyuun58BQ32SuG+j0DtX8LC5sVbYHAdL
         p4VPKF4pCtFpj9AQ8swn3mpHQ2Ka0oQpGEeWUHC4RfvzPbvsg7Hioj3HcfIul55kE4sU
         XWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTWH24yA/1C8wqtT9jqxaOXK4VdWlElUekSQr6wCUNk=;
        b=Kkzi/XNcAWHBjNZzVXWHbZQRdBzGG/2NYSNu/ODdMZMD0jQxnsoC5N1RAhTMnItYa2
         +1NO4nZ2BZyPuMZ6PYcQfnJ0Btc+dFheWleZWqDW2VDJ6QqHaH2oNcVY1KcLmc0uvI7R
         3o8jt9sTVRsk2QZ1pBQ2CVrfBpxYf7x+wus+NsPbxz5iM609WhUf8XJsdzOiWPHChqVF
         OUOO8skJZfp6Dfi/uY8hMjxfaU7JbQCwrupH7wGCjkODeko9x4F/LiHu5MT85CZ/xMK6
         wG3RQuq7RCFxQWTv5xy1ZY+2DHuw04LT6gjNcBrYA/PSwx0bBw3k1rZYZ29BPI36Xa8R
         2ZjQ==
X-Gm-Message-State: APjAAAXCe3bh6VVmNod0MfAFk833+2aEHyuPwq+pmLTamPAcAs/RlAqM
        2CPpnOQa94QA6Od58wVVyQwt3FCylJa/KeEJGw==
X-Google-Smtp-Source: APXvYqx6tx6RmC3nwgq5oU/5SMi9/vNBFMonltoudZNJjPfSzLhIZd2vSB8s2xPe4+DAhUve/ybsToT4hpYWtZchLEw=
X-Received: by 2002:a6b:5106:: with SMTP id f6mr15331128iob.15.1559787589673;
 Wed, 05 Jun 2019 19:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <1559725820-26138-1-git-send-email-kernelfans@gmail.com> <20190605144912.f0059d4bd13c563ddb37877e@linux-foundation.org>
In-Reply-To: <20190605144912.f0059d4bd13c563ddb37877e@linux-foundation.org>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 6 Jun 2019 10:19:38 +0800
Message-ID: <CAFgQCTur5ReVHm6NHdbD3wWM5WOiAzhfEXdLnBGRdZtf7q1HFw@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 5:49 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  5 Jun 2019 17:10:19 +0800 Pingfan Liu <kernelfans@gmail.com> wrote:
>
> > As for FOLL_LONGTERM, it is checked in the slow path
> > __gup_longterm_unlocked(). But it is not checked in the fast path, which
> > means a possible leak of CMA page to longterm pinned requirement through
> > this crack.
> >
> > Place a check in the fast path.
>
> I'm not actually seeing a description (in either the existing code or
> this changelog or patch) an explanation of *why* we wish to exclude CMA
> pages from longterm pinning.
>
What about a short description like this:
FOLL_LONGTERM suggests a pin which is going to be given to hardware
and can't move. It would truncate CMA permanently and should be
excluded.

> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2196,6 +2196,26 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
> >       return ret;
> >  }
> >
> > +#ifdef CONFIG_CMA
> > +static inline int reject_cma_pages(int nr_pinned, struct page **pages)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < nr_pinned; i++)
> > +             if (is_migrate_cma_page(pages[i])) {
> > +                     put_user_pages(pages + i, nr_pinned - i);
> > +                     return i;
> > +             }
> > +
> > +     return nr_pinned;
> > +}
>
> There's no point in inlining this.
OK, will drop it in V4.

>
> The code seems inefficient.  If it encounters a single CMA page it can
> end up discarding a possibly significant number of non-CMA pages.  I
The trick is the page is not be discarded, in fact, they are still be
referrenced by pte. We just leave the slow path to pick up the non-CMA
pages again.

> guess that doesn't matter much, as get_user_pages(FOLL_LONGTERM) is
> rare.  But could we avoid this (and the second pass across pages[]) by
> checking for a CMA page within gup_pte_range()?
It will spread the same logic to hugetlb pte and normal pte. And no
improvement in performance due to slow path. So I think maybe it is
not worth.

>
> > +#else
> > +static inline int reject_cma_pages(int nr_pinned, struct page **pages)
> > +{
> > +     return nr_pinned;
> > +}
> > +#endif
> > +
> >  /**
> >   * get_user_pages_fast() - pin user pages in memory
> >   * @start:   starting user address
> > @@ -2236,6 +2256,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
> >               ret = nr;
> >       }
> >
> > +     if (unlikely(gup_flags & FOLL_LONGTERM) && nr)
> > +             nr = reject_cma_pages(nr, pages);
> > +
>
> This would be a suitable place to add a comment explaining why we're
> doing this...
Would add one comment "FOLL_LONGTERM suggests a pin given to hardware
and rarely returned."

Thanks for your kind review.

Regards,
  Pingfan
