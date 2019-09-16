Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DEBC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1862D2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2Ma8ZVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbfIPPEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:04:42 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:33044 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388896AbfIPPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:04:42 -0400
Received: by mail-oi1-f179.google.com with SMTP id e18so58182oii.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12uVa/vbHPUsxTmhn6LwynIHFIlD+WNeKDV9FVDcoCg=;
        b=L2Ma8ZVbuNQumBIZfwwzqwuIJBH/sB/nvGaAtEa16aHu8hlvyh258IjngMEZc1mZD4
         0T5E0L51ExctaPzEWG1RV+1gtBklRsIlu65BcmreQ/7j/nBpZKcVLsRfkZN9i6UPaznC
         xhvIsEbMVJ02056XbscM4QHEj6trIxVdTTOu72e6ElzdTayi5Qol+SXgaWodwayVio+F
         siU4VmORQxf7x6BS/AOEuPvvcPWG3r8zrVKgQWuEZ00VNq2+Bsvq0XeHC/YIyuUoGQkT
         GT7w7PEkGuIPEkZPm496ATcqqc7cQAXYIe+wPc9CsLGdiPKZPu80gbeWpFbw3E/LKp+0
         ld6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12uVa/vbHPUsxTmhn6LwynIHFIlD+WNeKDV9FVDcoCg=;
        b=Xs/V44qz/nmo7g82vZO9aRkUjBH0Mo32QB9+gTnykRC9cB+5tCrUoaUeYvkYKZwXoS
         ECdulP6VOHRZ4nmojVxc3AleGzz37qlMrvPuL6tXLl++5ZfSaWonCQeN5EypeT93EMWT
         gLksCaBTOFsJVc2bPZar5+ZJBMkNX7rAlT9Zpj0atzykjNEiBnbN/yiBMf9UKJkPdV83
         fMdm/4ePRtj4tkV1UKV42soKfE+ioEiWyAecyCgWtubFe7iUp5HHsqgEvG45da49Lxye
         EZpTEb/Y7klxugAUNO0/7NW0p2rDtaudnHkajlFjpBPK3GK/v83FMp7A/9L8smngzsfL
         8kUg==
X-Gm-Message-State: APjAAAW5C73eVADjxbkmd0U6adJEnd9kFBclj4h89mzQWXHn6HBbv3Cj
        q+g5LhpKiuU5MibB+wifzXQK/dHx3TMZSPKo5OI=
X-Google-Smtp-Source: APXvYqxzDJAmTOkYMBzaGEFLdHsuC8Q9Yf1wDWuj9OY97A7AAyO5m/qLr8u76F/E9fl8BiSr4oS6zzWdGUiu4aXVzG8=
X-Received: by 2002:aca:4f8f:: with SMTP id d137mr3394oib.33.1568646281210;
 Mon, 16 Sep 2019 08:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190915170809.10702-1-lpf.vector@gmail.com> <20190915170809.10702-7-lpf.vector@gmail.com>
 <alpine.DEB.2.21.1909151434140.211705@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1909151434140.211705@chino.kir.corp.google.com>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Mon, 16 Sep 2019 23:04:29 +0800
Message-ID: <CAD7_sbEKRc0ipTh2SU93C9wJ8hOdqpwFFhacFkWg0Yn71ZYQfA@mail.gmail.com>
Subject: Re: [RESEND v4 6/7] mm, slab_common: Initialize the same size of kmalloc_caches[]
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christopher Lameter <cl@linux.com>, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 5:38 AM David Rientjes <rientjes@google.com> wrote:

Thanks for your review comments!

>
> On Mon, 16 Sep 2019, Pengfei Li wrote:
>
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 2aed30deb071..e7903bd28b1f 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1165,12 +1165,9 @@ void __init setup_kmalloc_cache_index_table(void)
> >               size_index[size_index_elem(i)] = 0;
> >  }
> >
> > -static void __init
> > +static __always_inline void __init
> >  new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
> >  {
> > -     if (type == KMALLOC_RECLAIM)
> > -             flags |= SLAB_RECLAIM_ACCOUNT;
> > -
> >       kmalloc_caches[type][idx] = create_kmalloc_cache(
> >                                       kmalloc_info[idx].name[type],
> >                                       kmalloc_info[idx].size, flags, 0,
> > @@ -1185,30 +1182,22 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
> >  void __init create_kmalloc_caches(slab_flags_t flags)
> >  {
> >       int i;
> > -     enum kmalloc_cache_type type;
> >
> > -     for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
> > -             for (i = 0; i < KMALLOC_CACHE_NUM; i++) {
> > -                     if (!kmalloc_caches[type][i])
> > -                             new_kmalloc_cache(i, type, flags);
> > -             }
> > -     }
> > +     for (i = 0; i < KMALLOC_CACHE_NUM; i++) {
> > +             if (!kmalloc_caches[KMALLOC_NORMAL][i])
> > +                     new_kmalloc_cache(i, KMALLOC_NORMAL, flags);
> >
> > -     /* Kmalloc array is now usable */
> > -     slab_state = UP;
> > +             new_kmalloc_cache(i, KMALLOC_RECLAIM,
> > +                                     flags | SLAB_RECLAIM_ACCOUNT);
>
> This seems less robust, no?  Previously we verified that the cache doesn't
> exist before creating a new cache over top of it (for NORMAL and RECLAIM).
> Now we presume that the RECLAIM cache never exists.
>

Agree, this is really less robust.

I have checked the code and found that there is no place to initialize
kmalloc-rcl-xxx before create_kmalloc_caches(). So I assume that
kmalloc-rcl-xxx is NULL.

> Can we just move a check to new_kmalloc_cache() to see if
> kmalloc_caches[type][idx] already exists and, if so, just return?  This
> should be more robust and simplify create_kmalloc_caches() slightly more.

For better robustness, I will do it as you suggested in v5.
