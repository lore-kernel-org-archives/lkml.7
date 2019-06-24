Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9444DC48BE3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C95A2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFwgZ0LN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfFXFzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:55:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40857 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfFXFzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:55:17 -0400
Received: by mail-io1-f68.google.com with SMTP id n5so224662ioc.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 22:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MB7jsoCN6B+KNrRXEg/uVPgC1Ut8P/kMidprTlNMk78=;
        b=EFwgZ0LNDntIB9LWehZbyrQruz2I2i5yx0XRhfFyt0IEUziPO1LjP8mBVrYgS/Vu9Z
         3gjIK3n7h57pkpzdrk/dSCXz/EwObWtY84KungPUtK9bM3yr4VYX7AzzbHshdmr1bBu3
         crFI7ZCBdRyXZDpjL+o8byiTblqaKFQiPr0OZB3JWH2Gf2DY//slHAWwsnhExYEsq6DV
         8BMytD3TEDXnBtdmlJ6a7AmCemcYqs2zR6a2/X7WKCBcm+a7kloxAnXeyp3E3m9JxtHT
         qTAUwN2PtzmkVwoxt9w3HW2FoDhdzjz5muPo79LXyfx2AK8pUkarOV6nXKrr2zNVcF8k
         otCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MB7jsoCN6B+KNrRXEg/uVPgC1Ut8P/kMidprTlNMk78=;
        b=FDqa8Jhgi6uQs9sCcwReYGI+GnC+wVOIu8XRrxmestqIZSq1ptFfo6Eo1A9TeaKyIl
         UpX5Z+5W4D2HMtnNJC8f4TVYECVNIsnqnHPXdeeR2F8DpXhfEWx8FEfwBtZXrb61scRI
         stI9zMNzdMNkjpcyW0DQZdF1K0Ca2kgAQ1l51EG4jq3F4TckbjqnolUGbbiduxjih6sO
         3zlDFZNAybOFeZ/OW0BaDviwsRha+nQA56AYWRYx5AoO91dgI+lLCWOAklgfvfc7kMs5
         RzPjAF+AKFn6fK8Op1TtcFB3loWjDQ1kFt3YM6RM5qrvdK2dTQ6jiY5oJWyuEJ3/rpvu
         ZgHw==
X-Gm-Message-State: APjAAAXNxgTNtjySSpW4YlXF+yRHzZ2akEMI9qQrtB+TUw2q+RQtDH1F
        HKcmUwScfHUPA4bVx8LMvLxKgq0ORbXWcu2Djg==
X-Google-Smtp-Source: APXvYqz21l53EP4/uEWFM2tah2RK5JkPnEImBUKlK56iy9SewaPdxqyxD6QTuB+hGojVTvragBolmaTARvs5BepDyhI=
X-Received: by 2002:a6b:4107:: with SMTP id n7mr7518421ioa.12.1561355716706;
 Sun, 23 Jun 2019 22:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <1561350068-8966-1-git-send-email-kernelfans@gmail.com> <20190624050341.GB30102@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190624050341.GB30102@iweiny-DESK2.sc.intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 24 Jun 2019 13:55:05 +0800
Message-ID: <CAFgQCTvT4HZn6ZOAxUzUOwqv--R4CLTkOC_V=y22Fy1m1thrRA@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: allow gigantic page allocation to migrate
 away smaller huge page
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 1:03 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Mon, Jun 24, 2019 at 12:21:08PM +0800, Pingfan Liu wrote:
> > The current pfn_range_valid_gigantic() rejects the pud huge page allocation
> > if there is a pmd huge page inside the candidate range.
> >
> > But pud huge resource is more rare, which should align on 1GB on x86. It is
> > worth to allow migrating away pmd huge page to make room for a pud huge
> > page.
> >
> > The same logic is applied to pgd and pud huge pages.
>
> I'm sorry but I don't quite understand why we should do this.  Is this a bug or
> an optimization?  It sounds like an optimization.
Yes, an optimization. It can help us to success to allocate a 1GB
hugetlb if there is some 2MB hugetlb sit in the candidate range.
Allocation 1GB hugetlb requires more tough condition, not only a
continuous 1GB range, but also aligned on GB. While allocating a 2MB
range is easier.
>
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  mm/hugetlb.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index ac843d3..02d1978 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1081,7 +1081,11 @@ static bool pfn_range_valid_gigantic(struct zone *z,
> >                       unsigned long start_pfn, unsigned long nr_pages)
> >  {
> >       unsigned long i, end_pfn = start_pfn + nr_pages;
> > -     struct page *page;
> > +     struct page *page = pfn_to_page(start_pfn);
> > +
> > +     if (PageHuge(page))
> > +             if (compound_order(compound_head(page)) >= nr_pages)
>
> I don't think you want compound_order() here.
Yes, your are right.

Thanks,
  Pingfan
>
> Ira
>
> > +                     return false;
> >
> >       for (i = start_pfn; i < end_pfn; i++) {
> >               if (!pfn_valid(i))
> > @@ -1098,8 +1102,6 @@ static bool pfn_range_valid_gigantic(struct zone *z,
> >               if (page_count(page) > 0)
> >                       return false;
> >
> > -             if (PageHuge(page))
> > -                     return false;
> >       }
> >
> >       return true;
> > --
> > 2.7.5
> >
