Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860BDC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7AC21848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmU0TeVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfISH7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:59:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46219 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfISH7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:59:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id e17so2534483ljf.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rvn6l+4CMtsztWTxkmjHyCK4XVDTrU7M/UklIZV3tDc=;
        b=QmU0TeVWL5IYmtIZRAwqGPyWQMU8rpVXNgt+0+UT/mkl4zCvGEyJUbzeytlvYSv505
         Zl8hAKMkPHsk2I/ZwsNir1CKmOJ0Yca3B6uny3G3gm+6FPaoFa/ol9k4T+qMEHpaQ6J8
         9UFPqFkGsXuKev14AZhgBc02OcKZg/OKcf3Qx7fNU42kQSfF0/Wax2EbSehc8v60xfsT
         EV1osoQakUXIx1JSca97nX6JKhVu9Y83BISyZASNSxM645Hr3Z1oGnQid68AwZfN0UP9
         x6m9tWFPSGpoK/Q6S6Zn/kmKjqclJviKLK80C1Fp2xYqY102J3ypspUKCaDpJAT8huRD
         Km0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rvn6l+4CMtsztWTxkmjHyCK4XVDTrU7M/UklIZV3tDc=;
        b=buNM7JvFma/AxcfQ5GvpoTmd+gfhRr5Pt7LCjz/OO1I7WiArjC8h7A1CkMUSHiAplB
         sUO1NnUirmUmT75w3To/6J1RzYMuQyKN+s9INq+tEU2U/MiszIjMN1II6sY1A/35U61P
         nQk2G/0DF7XzajK4Gpu9AN+wXwZqPapJQw+Hypnt900qeRZWc6c/VdBIAD1BN0Ika48S
         rz4CPLWAu/QRKb/AUYYAyJFYcUZh3CLMbI5w1gBBVSuiDidxBy6cOlO/RggfaQneNxJ+
         VLoV4mgkpBua8/HyZKboqfJlHAwHzEIv10rzyvHlvOsoreamXo/Z3Fo1By6i5SxcktiC
         W+iA==
X-Gm-Message-State: APjAAAVt/ffejA9d5ZuZpT3ld3kFPHnTNtKI95m1gOF5dZpYQy31AwNM
        s5+U3Y0ebTvWN14M1wrtFALMDyP7leMZgg4h/F8=
X-Google-Smtp-Source: APXvYqxNi8daZDreTYouNdVLu8ZHSKG5AaP8YON0k9rUx8mqaTKwmojwVQRbHlN4lnGpGE7pHwpBMpyoLY6BCxVhG/o=
X-Received: by 2002:a2e:5d98:: with SMTP id v24mr4784754lje.56.1568879958922;
 Thu, 19 Sep 2019 00:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190917185352.44cf285d3ebd9e64548de5de@gmail.com> <d6214fbd-e757-43a9-ab12-4b61fde434db@suse.cz>
In-Reply-To: <d6214fbd-e757-43a9-ab12-4b61fde434db@suse.cz>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Thu, 19 Sep 2019 09:59:07 +0200
Message-ID: <CAMJBoFMvz40pm-J3HxX-6ix-7U7xKXEXvBXTSODBvGqg8Ju8BA@mail.gmail.com>
Subject: Re: [PATCH] z3fold: fix memory leak in kmem cache
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Markus Linnala <markus.linnala@gmail.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 9:35 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 9/17/19 5:53 PM, Vitaly Wool wrote:
> > Currently there is a leak in init_z3fold_page() -- it allocates
> > handles from kmem cache even for headless pages, but then they are
> > never used and never freed, so eventually kmem cache may get
> > exhausted. This patch provides a fix for that.
> >
> > Reported-by: Markus Linnala <markus.linnala@gmail.com>
> > Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
>
> Can a Fixes: commit be pinpointed, and CC stable added?

Fixes: 7c2b8baa61fe578 "mm/z3fold.c: add structure for buddy handles"

Best regards,
   Vitaly

> > ---
> >  mm/z3fold.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/z3fold.c b/mm/z3fold.c
> > index 6397725b5ec6..7dffef2599c3 100644
> > --- a/mm/z3fold.c
> > +++ b/mm/z3fold.c
> > @@ -301,14 +301,11 @@ static void z3fold_unregister_migration(struct z3fold_pool *pool)
> >   }
> >
> >  /* Initializes the z3fold header of a newly allocated z3fold page */
> > -static struct z3fold_header *init_z3fold_page(struct page *page,
> > +static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
> >                                       struct z3fold_pool *pool, gfp_t gfp)
> >  {
> >       struct z3fold_header *zhdr = page_address(page);
> > -     struct z3fold_buddy_slots *slots = alloc_slots(pool, gfp);
> > -
> > -     if (!slots)
> > -             return NULL;
> > +     struct z3fold_buddy_slots *slots;
> >
> >       INIT_LIST_HEAD(&page->lru);
> >       clear_bit(PAGE_HEADLESS, &page->private);
> > @@ -316,6 +313,12 @@ static struct z3fold_header *init_z3fold_page(struct page *page,
> >       clear_bit(NEEDS_COMPACTING, &page->private);
> >       clear_bit(PAGE_STALE, &page->private);
> >       clear_bit(PAGE_CLAIMED, &page->private);
> > +     if (headless)
> > +             return zhdr;
> > +
> > +     slots = alloc_slots(pool, gfp);
> > +     if (!slots)
> > +             return NULL;
> >
> >       spin_lock_init(&zhdr->page_lock);
> >       kref_init(&zhdr->refcount);
> > @@ -962,7 +965,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
> >       if (!page)
> >               return -ENOMEM;
> >
> > -     zhdr = init_z3fold_page(page, pool, gfp);
> > +     zhdr = init_z3fold_page(page, bud == HEADLESS, pool, gfp);
> >       if (!zhdr) {
> >               __free_page(page);
> >               return -ENOMEM;
> >
>
