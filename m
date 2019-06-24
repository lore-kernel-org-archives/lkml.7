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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80265C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084B52063F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi4Uh0to"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfFXBvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:51:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44247 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFXBvt (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:51:49 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so524109iob.11
        for <Linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 18:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+MLzYEoEduR8Q+ofY+9DSCWoJU/Fb/z+zF7Y0bwVTI=;
        b=Qi4Uh0togE92l73msdpzeDUQYoLAyZbb6tYJqdSYxXXbCbuKYbIrOFew4kw1bAfb6k
         2d1A6Hsd9u2fJFbrs5TT5PAgHVkgKCRCKhE+DNc8NO7z5Ri+niBjt845zb3lruTCh9id
         uXToEifUf1p2SVDBJovQyBWllp+Y8V2ZMXca6QVxXMWTYO3beoTBtFqqHi0NGApE/RHg
         bshvgR9AJsc+zf1NdfI1cIEL2879R+1CA17sPwjJw6ZS4Zz3AYLcD3UjlKzyt1fcsmH0
         nMH/bmFil0zmY8bvMreCMOQCD6WM26TKyaSR61R324NacVQS/+A63xWa5rqFJNsmU9R+
         tqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+MLzYEoEduR8Q+ofY+9DSCWoJU/Fb/z+zF7Y0bwVTI=;
        b=OK5XPwUH9hvW4B+r+vAkhQEeXR7ZHUqge/dFvShXPyPHjS4Q1E6JWcKACJylrPWIZ+
         aP31X71ZnbgwWVzupvDoGs+O9Kul4/qQnPeiKDAr+n/tSLybwMaJz5R76VM1QI4pAzJ5
         C1/SIFM7w+59EG61VfVTkR0KNMmDONItvDhdeHXIYEav5DHQuknyOAxaXzPB96Fqi/Go
         dZGrcgpAjAs2SPG+uAVHIlWj3y3eko1FH1HA1GkTRItvzA63QgahSowrStOxOcew+tVE
         n+6s+PoB12w5ENI5HTe1CifiekrqLsbFHCafQ0BOzJOlRTZm2IR2vJymx5Du4aqOjMyx
         u7FA==
X-Gm-Message-State: APjAAAWwFCZn6XjkXY6Scg9xOiLjh/vvcpCFNpzgW6tWZACDEbuHwTBt
        /kTgtEMGC2guzfTPQMY/C3Z1JP/+T/2zOzq/aMOF
X-Google-Smtp-Source: APXvYqwlrTd7zZ+8C5LG65dPmV1E9CKsY7yiH4Q4qh+AomfR8v3cv/tfgFHaNCcDqrgpU1DtrOjGGbkR19Vqdm4kFkE=
X-Received: by 2002:a6b:5106:: with SMTP id f6mr8398579iob.15.1561339279746;
 Sun, 23 Jun 2019 18:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <1561112116-23072-1-git-send-email-kernelfans@gmail.com> <20190621181349.GA21680@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190621181349.GA21680@iweiny-DESK2.sc.intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 24 Jun 2019 09:21:07 +0800
Message-ID: <CAFgQCTt2M3NVD5Xmip3YX=eYM_wJn9mWLjZq8z-jXuvT5q-naQ@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: speed up check_and_migrate_cma_pages() on huge page
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <Linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2019 at 2:13 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Jun 21, 2019 at 06:15:16PM +0800, Pingfan Liu wrote:
> > Both hugetlb and thp locate on the same migration type of pageblock, since
> > they are allocated from a free_list[]. Based on this fact, it is enough to
> > check on a single subpage to decide the migration type of the whole huge
> > page. By this way, it saves (2M/4K - 1) times loop for pmd_huge on x86,
> > similar on other archs.
> >
> > Furthermore, when executing isolate_huge_page(), it avoid taking global
> > hugetlb_lock many times, and meanless remove/add to the local link list
> > cma_page_list.
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Linux-kernel@vger.kernel.org
> > ---
> >  mm/gup.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index ddde097..2eecb16 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1342,16 +1342,19 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
> >       LIST_HEAD(cma_page_list);
> >
> >  check_again:
> > -     for (i = 0; i < nr_pages; i++) {
> > +     for (i = 0; i < nr_pages;) {
> > +
> > +             struct page *head = compound_head(pages[i]);
> > +             long step = 1;
> > +
> > +             if (PageCompound(head))
> > +                     step = compound_order(head) - (pages[i] - head);
> >               /*
> >                * If we get a page from the CMA zone, since we are going to
> >                * be pinning these entries, we might as well move them out
> >                * of the CMA zone if possible.
> >                */
> >               if (is_migrate_cma_page(pages[i])) {
>
> I like this but I think for consistency I would change this pages[i] to be
> head.  Even though it is not required.
Yes, agree. Thank you for your good suggestion.

Regards,
  Pingfan
>
> Ira
>
> > -
> > -                     struct page *head = compound_head(pages[i]);
> > -
> >                       if (PageHuge(head)) {
> >                               isolate_huge_page(head, &cma_page_list);
> >                       } else {
> > @@ -1369,6 +1372,8 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
> >                               }
> >                       }
> >               }
> > +
> > +             i += step;
> >       }
> >
> >       if (!list_empty(&cma_page_list)) {
> > --
> > 2.7.5
> >
