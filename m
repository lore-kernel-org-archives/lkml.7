Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5148DC06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A273206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls2sEpPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfGBMSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:18:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41197 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBMSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:18:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id g7so12840265oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EQFPfKnigVqvBSqD9eQKtRGLDR0XGFyOvketyNfarh4=;
        b=ls2sEpPFocepLR1LGzbnqUzUwF+ciDgl01tJ7V/hLHyZtwBlogxVkrUQFcWfjlxIvu
         q+nn6CIlHJBl7dcMXZJ90rSMk+VevPYy6tQjj/sW0ugvjNiEBpZuTQCGH2zF8lU52T26
         iVKmoD3dbzIMHqCHvQ5odNKYUmzon2UFN0V5pr108k4+aDXs+lmAcaP9f1IvRZC0A+UY
         NE3kzN9l1fPaqSTDpH1wrPsOTRuPHgIoILtDfPn/yh2jkBIw1hiyPTg3F0LMRHf3miCh
         FELJ2Y/H8vxeYrHTPwMhYh+shlDV/cQna94UoGmpMUChneBkvz2R8ZIXP4k/4ndhUxQK
         l3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EQFPfKnigVqvBSqD9eQKtRGLDR0XGFyOvketyNfarh4=;
        b=c1cwMgACY/iospBGv0oX45/TiCxgljeWidcrm9+2CYp/oH6saFu1uGlBuYxqDqj4aj
         k/lRdpz52WohcUXyYwsbHzBxd+S6Ncdg7e/da7MMFycwsePEqLJe4hMn1v40ZqcwwCld
         +6RSzKrjGSmzaOgBgna+RiYWaBQo5TvBzYziyhBM8OU4nTDHW/XAZY8THiLAOwgWu64R
         ChF/UzHYZ+RTIPHf7ISdk0RM1AuGTR04y7ScIQVBYewZos92ENnB99xZ/h/PFSZu33Yk
         0XGNBqjoOzrzVpyI+qJWXER38c1HHn9Ee4XdQMCVlAmYWoF2yGSE/kTtS+oATNAKciPX
         wiBg==
X-Gm-Message-State: APjAAAUIc/b30aAxXZWvjD1SeaLRkhEJNSV/GzlCpPPh5DRoSzz2wjHX
        FNbXm4dl6MNZ8M9Ui312WOuS3JIz1dK9kgEemoU=
X-Google-Smtp-Source: APXvYqyt7Ig9UUzbNaFPCtBVZS+wdjqfYzgY/wZ2HVVvdVJosrc4gzvrc4xAGX15Elp6hune+llTQZ21TxydrUFTt6U=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr2660841oic.21.1562069894627;
 Tue, 02 Jul 2019 05:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190630075650.8516-1-lpf.vector@gmail.com> <20190701092037.GL6376@dhcp22.suse.cz>
 <20190701101121.kyg65fbcd7reszk7@pc636>
In-Reply-To: <20190701101121.kyg65fbcd7reszk7@pc636>
From:   oddtux <lpf.vector@gmail.com>
Date:   Tue, 2 Jul 2019 20:18:03 +0800
Message-ID: <CAD7_sbEwxk-avBMONmihHOeKAnWoeANLQ7cR6LBO2YfzJ5Q8kw@mail.gmail.com>
Subject: Re: [PATCH 0/5] mm/vmalloc.c: improve readability and rewrite vmap_area
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        peterz@infradead.org, rpenyaev@suse.de, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uladzislau Rezki <urezki@gmail.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=886:11=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 01, 2019 at 11:20:37AM +0200, Michal Hocko wrote:
> > On Sun 30-06-19 15:56:45, Pengfei Li wrote:
> > > Hi,
> > >
> > > This series of patches is to reduce the size of struct vmap_area.
> > >
> > > Since the members of struct vmap_area are not being used at the same =
time,
> > > it is possible to reduce its size by placing several members that are=
 not
> > > used at the same time in a union.
> > >
> > > The first 4 patches did some preparatory work for this and improved
> > > readability.
> > >
> > > The fifth patch is the main patch, it did the work of rewriting vmap_=
area.
> > >
> > > More details can be obtained from the commit message.
> >
> > None of the commit messages talk about the motivation. Why do we want t=
o
> > add quite some code to achieve this? How much do we save? This all
> > should be a part of the cover letter.
> >
> > > Thanks,
> > >
> > > Pengfei
> > >
> > > Pengfei Li (5):
> > >   mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area()
> > >   mm/vmalloc.c: Introduce a wrapper function of
> > >     insert_vmap_area_augment()
> > >   mm/vmalloc.c: Rename function __find_vmap_area() for readability
> > >   mm/vmalloc.c: Modify function merge_or_add_vmap_area() for readabil=
ity
> > >   mm/vmalloc.c: Rewrite struct vmap_area to reduce its size
> > >
> > >  include/linux/vmalloc.h |  28 +++++---
> > >  mm/vmalloc.c            | 144 +++++++++++++++++++++++++++-----------=
--
> > >  2 files changed, 117 insertions(+), 55 deletions(-)
> > >
> > > --
> > > 2.21.0
>
> > > Pengfei Li (5):
> > >   mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area()
> > >   mm/vmalloc.c: Introduce a wrapper function of
> > >     insert_vmap_area_augment()
> > >   mm/vmalloc.c: Rename function __find_vmap_area() for readability
> > >   mm/vmalloc.c: Modify function merge_or_add_vmap_area() for readabil=
ity
> > >   mm/vmalloc.c: Rewrite struct vmap_area to reduce its size
> Fitting vmap_area to 1 cacheline boundary makes sense to me. I was thinki=
ng about
> that and i have patches in my pipeline to send out but implementation is =
different.
>
> I had a look at all 5 patches. What you are doing is reasonable to me, i =
mean when
> it comes to the idea of reducing the size to L1 cache line.
>

Thank you for your review.

> I have a concern about implementation and all logic around when we can us=
e va_start
> and when it is something else. It is not optimal at least to me, from per=
formance point
> of view and complexity. All hot paths and tree traversal are affected by =
that.
>
> For example running the vmalloc test driver against this series shows the=
 following
> delta:
>
> <5.2.0-rc6+>
> Summary: fix_size_alloc_test passed: loops: 1000000 avg: 969370 usec
> Summary: full_fit_alloc_test passed: loops: 1000000 avg: 989619 usec
> Summary: long_busy_list_alloc_test loops: 1000000 avg: 12895813 usec
> <5.2.0-rc6+>
>
> <this series>
> Summary: fix_size_alloc_test passed: loops: 1000000 avg: 1098372 usec
> Summary: full_fit_alloc_test passed: loops: 1000000 avg: 1167260 usec
> Summary: long_busy_list_alloc_test passed: loops: 1000000 avg: 12934286 u=
sec
> <this series>
>
> For example, the degrade in second test is ~15%.
>
> --
> Vlad Rezki

Hi, Vlad

I think the reason for the performance degradation is that the value
of va_start is obtained by va->vm->addr.

And since the vmap area in the BUSY tree is always page-aligned,
there is no reason for _va_vmlid to override va_start, just let
the va->flags use the bits that lower than PAGE_OFFSET.

I will use this implementation in the next version and show almost
no performance penalty in my local tests.

I will send the next version soon.

Thank you for taking your time for the review.

Best regards,

Pengfei
