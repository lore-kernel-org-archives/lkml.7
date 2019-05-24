Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2336C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01A420851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Rn1w8rrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389947AbfEXPsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:48:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36069 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389079AbfEXPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:48:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id y124so7387785oiy.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VnZfOS1iwVY/y3S5ygO9n8yXSXom1QPOKMwgmm4Nkio=;
        b=Rn1w8rrq8jnqx+HnE9zs1bnGB0aDFB9M0RNzuGCNQxPDSvCjbZOLE/1/8l6w3jwS6V
         pmEZtLZqA1fmX11DldIiqC8w3eAWCNOn4/08jY4rmP1pCZJ9hrnoVvLAfyQP+nje0T10
         bGM7I4GosQwiCSD7vKCWa1RcNjBZv8Qr+KhCN+J8gkVBXvT7DPy2LVo97iuxRsREsnFD
         8ucA6KSgdfbUysB6hJuvkhTgO+XsMrjiV4fQ587UBx/kLhvb3YBgtTM4RL+0fTheleTt
         ql5JfvYfCMPOHAd9oHF1+7a45IA/oyBjb855gQdQf5OQivqCLy1zIlTBnTMkC0G99uw3
         Bm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VnZfOS1iwVY/y3S5ygO9n8yXSXom1QPOKMwgmm4Nkio=;
        b=fr/9sb4Vx13ucSQc4I5HCxBcICNCCe3NVS4kYNHgjYSGxOUJiygekX1+kypq63hYtf
         WIP/aX7OQugZpZ5CNo5oBMLMSf18v/K426KWFRZvDd/fQX6Wy0bxrrpV1XNo1vQ39g4o
         /L2vs1EUbHLLMrayXzSUDVH0uPFV4ffiaSY/N9iP/tYfZrp1N9arPnPsUJ+tGbBhLvlz
         lHXhSJNslMurDIdmB1j571bxnD8QCPnLrEgemhRMeJOxmlIAxpkwh9n9sgcMYCse6rhD
         EyqMT6C5f7D2M4xSmQHYKYjABLCOXqjWndHOsfOGGskj82XQ7V9VvCjUg1JYGa10CFrt
         UwZA==
X-Gm-Message-State: APjAAAWeMQLVoaSdVDg+XxxX0jQPQfYNdxgmF6T2nNOVdlM+VjaZOHxh
        /395z9PgB2JzIaw777cFGbSfnDGibePiobWjHEcs1g==
X-Google-Smtp-Source: APXvYqyW4iOkpvEW07bkloS7q8ueiELOVVaDniEHBFWvpgPMKVs+sfmDFFX+MOSdAC6C6h4JfkN/ao+FJlBeTpW2WMg=
X-Received: by 2002:aca:ab07:: with SMTP id u7mr6444454oie.73.1558712922804;
 Fri, 24 May 2019 08:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190523223746.4982-1-ira.weiny@intel.com> <CAPcyv4gYxyoX5U+Fg0LhwqDkMRb-NRvPShOh+nXp-r_HTwhbyA@mail.gmail.com>
 <20190524153625.GA23100@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190524153625.GA23100@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 24 May 2019 08:48:31 -0700
Message-ID: <CAPcyv4gtYws-csDXSEzyL4UUQtD8iDgCC=m4vk1x8fFqF9fttg@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: Fix release_pages() when releasing devmap pages
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 8:35 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Thu, May 23, 2019 at 08:58:12PM -0700, Dan Williams wrote:
> > On Thu, May 23, 2019 at 3:37 PM <ira.weiny@intel.com> wrote:
> > >
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > Device pages can be more than type MEMORY_DEVICE_PUBLIC.
> > >
> > > Handle all device pages within release_pages()
> > >
> > > This was found via code inspection while determining if release_pages=
()
> > > and the new put_user_pages() could be interchangeable.
> > >
> > > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  mm/swap.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/swap.c b/mm/swap.c
> > > index 3a75722e68a9..d1e8122568d0 100644
> > > --- a/mm/swap.c
> > > +++ b/mm/swap.c
> > > @@ -739,15 +739,14 @@ void release_pages(struct page **pages, int nr)
> > >                 if (is_huge_zero_page(page))
> > >                         continue;
> > >
> > > -               /* Device public page can not be huge page */
> > > -               if (is_device_public_page(page)) {
> > > +               if (is_zone_device_page(page)) {
> > >                         if (locked_pgdat) {
> > >                                 spin_unlock_irqrestore(&locked_pgdat-=
>lru_lock,
> > >                                                        flags);
> > >                                 locked_pgdat =3D NULL;
> > >                         }
> > > -                       put_devmap_managed_page(page);
> > > -                       continue;
> > > +                       if (put_devmap_managed_page(page))
> >
> > This "shouldn't" fail, and if it does the code that follows might get
>
> I agree it shouldn't based on the check.  However...
>
> > confused by a ZONE_DEVICE page. If anything I would make this a
> > WARN_ON_ONCE(!put_devmap_managed_page(page)), but always continue
> > unconditionally.
>
> I was trying to follow the pattern from put_page()  Where if fails it ind=
icated
> it was not a devmap page and so "regular" processing should continue.

In this case that regular continuation already happened by not taking
the if (is_zone_device_page(page)) branch

>
> Since I'm unsure I'll just ask what does this check do?
>
>         if (!static_branch_unlikely(&devmap_managed_key))
>                 return false;

That attempts to skip the overhead imposed by device-pages, i.e.
->page_free() callback and other extras, if there are no device-page
producers in the system. I.e. use the old simple put_page() path when
there is no hmm or pmem.
