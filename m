Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D216BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E1F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjZsvhO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbfDQNA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:00:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45828 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbfDQNA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:00:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so14315225lfl.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nD5N/gZK0Hc9/leGn/iw1G+jz11LpAQc97DIEWLBEH0=;
        b=BjZsvhO3f2TtZdypKM0jxF9FMvsBQgKsjOjoxn88+v7JSDK6dBNSiffPm+ktPRILcE
         HmWGSWZxWZHKnDwj5FtEyQyi0yj7N3sx12LtX22qusLXABFr0uNQaTgY4ME5c+GsOW5/
         cdEURgaDBigSxdcG2kpRozIdV+yh2dtTvlQyqrQdcX1l+FHwwNxp3WKEhssRK+Dtj5ML
         bol8BNRZ/nTq/h9U2713ozFZCt/zN6G1HMOANjAJqqVeRne08HkFoDLPlb2H/asmksvu
         e57LwlEC/XyHZJILatdvhwGcZTcgiOGrP3JA0IsDCg6RlFrY0cwU1y9ZqEANl9d65w8L
         IoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nD5N/gZK0Hc9/leGn/iw1G+jz11LpAQc97DIEWLBEH0=;
        b=W4rLrWCXX+R0xchzbOgVF9V7yWo+8FYdWM1K2tvHbPr6EHXt8OqjtGnB8zb85BaLuj
         Gq3pZxWJFQTLYgXXfSuQiq6lp4eYtAG2fmDF/0Lp6WO+LyXoAi73BrTz3nLWSc4uYriq
         O4x75VXgeozLDYS55a2mjD3exr4ehiOtx/2YB/ufKBNTiwBGeDYCZAcOI5gGlhEwi4k8
         hqpQAFPBsJswqy8D+AKgsEivCUiy2599JEj/g1aE8Hd+ta0gSuFv/INwzQQZwUZ2Zg64
         CIwjJ22AhI88wiuqMxd5U/V2BasHAPlhbcK5zDUYlAK/nZw94fe9axmCbks1gjzrP+0b
         JqNg==
X-Gm-Message-State: APjAAAWIImzd3AvJzx8Ce/0zwB1Z2Mfp/6Hxq2cU0zWUPhlhxXIUdAjX
        2m5IHgNGYwDJBn5IFcVm4aypm2sczgWw0k4S2RA=
X-Google-Smtp-Source: APXvYqzYJsHEPZUdZi7dgUmK7iczzP/OpZWI0kCGkirNZhXZR65KeukbkI/1y7q+0vV1rRiXwgEe0vywbPgmOrs7Vcs=
X-Received: by 2002:a19:3f09:: with SMTP id m9mr14983716lfa.36.1555506054907;
 Wed, 17 Apr 2019 06:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190412160338.64994-1-thellstrom@vmware.com> <20190412160338.64994-2-thellstrom@vmware.com>
 <CAFqt6zb4qBdrWev1KEruDzPJt5wP4ax_7hUyz+JMV9zLxd_iiw@mail.gmail.com> <e9211a5c28de521bbaabf1c2576c640f3195b0c2.camel@vmware.com>
In-Reply-To: <e9211a5c28de521bbaabf1c2576c640f3195b0c2.camel@vmware.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 17 Apr 2019 18:30:43 +0530
Message-ID: <CAFqt6zYw=Fj8R-18TJ-Xwdjs+AD7nW1pVO57vT8wuUK0Tv+FCQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm: Allow the [page|pfn]_mkwrite callbacks to drop
 the mmap_sem
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "riel@surriel.com" <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 4:28 PM Thomas Hellstrom <thellstrom@vmware.com> wr=
ote:
>
> Hi, Souptick,
>
> On Sat, 2019-04-13 at 20:41 +0530, Souptick Joarder wrote:
> > On Fri, Apr 12, 2019 at 9:34 PM Thomas Hellstrom <
> > thellstrom@vmware.com> wrote:
> > > Driver fault callbacks are allowed to drop the mmap_sem when
> > > expecting
> > > long hardware waits to avoid blocking other mm users. Allow the
> > > mkwrite
> > > callbacks to do the same by returning early on VM_FAULT_RETRY.
> > >
> > > In particular we want to be able to drop the mmap_sem when waiting
> > > for
> > > a reservation object lock on a GPU buffer object. These locks may
> > > be
> > > held while waiting for the GPU.
> > >
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Rik van Riel <riel@surriel.com>
> > > Cc: Minchan Kim <minchan@kernel.org>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Huang Ying <ying.huang@intel.com>
> > > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > > Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-kernel@vger.kernel.org
> > >
> > > Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> > > ---
> > >  mm/memory.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index e11ca9dd823f..a95b4a3b1ae2 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -2144,7 +2144,7 @@ static vm_fault_t do_page_mkwrite(struct
> > > vm_fault *vmf)
> > >         ret =3D vmf->vma->vm_ops->page_mkwrite(vmf);
> > >         /* Restore original flags so that caller is not surprised
> > > */
> > >         vmf->flags =3D old_flags;
> > > -       if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
> > > +       if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_RETRY |
> > > VM_FAULT_NOPAGE)))
> >
> > With this patch there will multiple instances of (VM_FAULT_ERROR |
> > VM_FAULT_RETRY | VM_FAULT_NOPAGE)
> > in mm/memory.c. Does it make sense to wrap it in a macro and use it ?
>
> Even though the code will look neater, it might be trickier to follow a
> particular error path. Could we perhaps postpone to a follow-up patch?

Sure. follow-up-patch is fine.

>
> Thomas
>
>
>
> >
> > >                 return ret;
> > >         if (unlikely(!(ret & VM_FAULT_LOCKED))) {
> > >                 lock_page(page);
> > > @@ -2419,7 +2419,7 @@ static vm_fault_t wp_pfn_shared(struct
> > > vm_fault *vmf)
> > >                 pte_unmap_unlock(vmf->pte, vmf->ptl);
> > >                 vmf->flags |=3D FAULT_FLAG_MKWRITE;
> > >                 ret =3D vma->vm_ops->pfn_mkwrite(vmf);
> > > -               if (ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE))
> > > +               if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY |
> > > VM_FAULT_NOPAGE))
> > >                         return ret;
> > >                 return finish_mkwrite_fault(vmf);
> > >         }
> > > @@ -2440,7 +2440,8 @@ static vm_fault_t wp_page_shared(struct
> > > vm_fault *vmf)
> > >                 pte_unmap_unlock(vmf->pte, vmf->ptl);
> > >                 tmp =3D do_page_mkwrite(vmf);
> > >                 if (unlikely(!tmp || (tmp &
> > > -                                     (VM_FAULT_ERROR |
> > > VM_FAULT_NOPAGE)))) {
> > > +                                     (VM_FAULT_ERROR |
> > > VM_FAULT_RETRY |
> > > +                                      VM_FAULT_NOPAGE)))) {
> > >                         put_page(vmf->page);
> > >                         return tmp;
> > >                 }
> > > @@ -3494,7 +3495,8 @@ static vm_fault_t do_shared_fault(struct
> > > vm_fault *vmf)
> > >                 unlock_page(vmf->page);
> > >                 tmp =3D do_page_mkwrite(vmf);
> > >                 if (unlikely(!tmp ||
> > > -                               (tmp & (VM_FAULT_ERROR |
> > > VM_FAULT_NOPAGE)))) {
> > > +                               (tmp & (VM_FAULT_ERROR |
> > > VM_FAULT_RETRY |
> > > +                                       VM_FAULT_NOPAGE)))) {
> > >                         put_page(vmf->page);
> > >                         return tmp;
> > >                 }
> > > --
> > > 2.20.1
> > >
