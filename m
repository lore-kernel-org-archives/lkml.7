Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A37C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 05:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20E32082E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 05:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1cB09Sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfK3F6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 00:58:46 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:46636 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3F6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 00:58:46 -0500
Received: by mail-pj1-f67.google.com with SMTP id z21so2731843pjq.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 21:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YU1p8ulCDRHuV/2STrjeEjC5+eZArWofUrYdxbS3oFg=;
        b=u1cB09Sgi9Q64BgW3XHkj/e9ZbsjnOEWQjcS0MPCmlTBQU0ox0O8Nyc6Vb3oQi/igB
         9kWIY7DM/S/dih7FVZal2XdGgPteNVsk+fFfxgjxsD1tkO/UO2bj9ZeoZc4OrdJ2px9S
         eAUEsNy5CA9BXyb3jgmnfCWbn9NSuoUrsRZ1yb7v/BpGKps+RenY3pJIcDeS/b8KZV5L
         oFzYi2ZdFzX48DlDKgKZsHelp/JCYOz9zP1M3o/s3hvH7oyfA5ujuCGKhrhc9OuaGT8e
         Z8xJQLehnxbUSvfuUCDXhG0uvGvrpL7aZayzEKRCL1dnS1endMu2lVfXuFBMKCb1W9AC
         x2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YU1p8ulCDRHuV/2STrjeEjC5+eZArWofUrYdxbS3oFg=;
        b=CcRDGE4TNAC+1wggTAwTDMiOqXoT4R7vyeGTC7X0PtFCYN7CcxWITmP8jlJbtxuSO8
         oV+Kdf0kEjgEA2gMkRqhxvasLg9vByoUE448JD32bOTXvignkv6grA0H4GCROmBJSGuI
         RkNPOT41oiHcAUD1dx4WvZbmMDEU/sUE0eh5Gg+sYsCXdCY8iy58I7dMoX7ngerFdKim
         BsrcAdZj6gLu70CBrgReIqLWj+xOEnxL+JidhH1euNRVm5461bXaY5YRBJpD0rQP0ikM
         CaiPnfJ50Bf0+vZjxw2K7A+HtMLECRMp2P2wg93mmTP42LTpLdV/hpdTpj87Rb/ncZ/1
         hn9g==
X-Gm-Message-State: APjAAAUcTurd6ZiLEhFdofuhvLoXe7/ZTEPxq+gZlyyeQFSKcpU0hWbm
        bIblkR2DnecKenHeebetV891i19yRW6qwmlwYI0=
X-Google-Smtp-Source: APXvYqyo+Y2thH/qpd/k7zH53eZOh8AWelNOLYZ33p9HcoLpX0JD5vrJ7B2++N364byeD4KQ+1RuUfz9ZiZAr7HjGiE=
X-Received: by 2002:a17:90a:850c:: with SMTP id l12mr23512535pjn.16.1575093525368;
 Fri, 29 Nov 2019 21:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-2-xiyou.wangcong@gmail.com> <d0f58734-0c1e-af9d-3437-31cf6c8a86f9@huawei.com>
In-Reply-To: <d0f58734-0c1e-af9d-3437-31cf6c8a86f9@huawei.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 29 Nov 2019 21:58:34 -0800
Message-ID: <CAM_iQpXAf8obF1-CRCGc3Fb_YmNBozcyoKQC5yuP6r9Akg6HBg@mail.gmail.com>
Subject: Re: [Patch v2 1/3] iommu: match the original algorithm
To:     John Garry <john.garry@huawei.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 6:43 AM John Garry <john.garry@huawei.com> wrote:
>
> On 29/11/2019 00:48, Cong Wang wrote:
> > The IOVA cache algorithm implemented in IOMMU code does not
> > exactly match the original algorithm described in the paper.
> >
>
> which paper?

It's in drivers/iommu/iova.c, from line 769:

 769 /*
 770  * Magazine caches for IOVA ranges.  For an introduction to magazines,
 771  * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
 772  * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
 773  * For simplicity, we use a static magazine size and don't implement the
 774  * dynamic size tuning described in the paper.
 775  */


>
> > Particularly, it doesn't need to free the loaded empty magazine
> > when trying to put it back to global depot. To make it work, we
> > have to pre-allocate magazines in the depot and only recycle them
> > when all of them are full.
> >
> > Before this patch, rcache->depot[] contains either full or
> > freed entries, after this patch, it contains either full or
> > empty (but allocated) entries.
>
> I *quickly* tested this patch and got a small performance gain.

Thanks for testing! It requires a different workload to see bigger gain,
in our case, 24 memcache.parallel servers with 120 clients.


>
> >
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > ---
> >   drivers/iommu/iova.c | 45 +++++++++++++++++++++++++++-----------------
> >   1 file changed, 28 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index 41c605b0058f..cb473ddce4cf 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -862,12 +862,16 @@ static void init_iova_rcaches(struct iova_domain *iovad)
> >       struct iova_cpu_rcache *cpu_rcache;
> >       struct iova_rcache *rcache;
> >       unsigned int cpu;
> > -     int i;
> > +     int i, j;
> >
> >       for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> >               rcache = &iovad->rcaches[i];
> >               spin_lock_init(&rcache->lock);
> >               rcache->depot_size = 0;
> > +             for (j = 0; j < MAX_GLOBAL_MAGS; ++j) {
> > +                     rcache->depot[j] = iova_magazine_alloc(GFP_KERNEL);
> > +                     WARN_ON(!rcache->depot[j]);
> > +             }
> >               rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
> >               if (WARN_ON(!rcache->cpu_rcaches))
> >                       continue;
> > @@ -900,24 +904,30 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
> >
> >       if (!iova_magazine_full(cpu_rcache->loaded)) {
> >               can_insert = true;
> > -     } else if (!iova_magazine_full(cpu_rcache->prev)) {
> > +     } else if (iova_magazine_empty(cpu_rcache->prev)) {
>
> is this change strictly necessary?

Yes, because it is what described in the paper. But it should be
functionally same because cpu_rcache->prev is either full or empty.



>
> >               swap(cpu_rcache->prev, cpu_rcache->loaded);
> >               can_insert = true;
> >       } else {
> > -             struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
> > +             spin_lock(&rcache->lock);
> > +             if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> > +                     swap(rcache->depot[rcache->depot_size], cpu_rcache->prev);
> > +                     swap(cpu_rcache->prev, cpu_rcache->loaded);
> > +                     rcache->depot_size++;
> > +                     can_insert = true;
> > +             } else {
> > +                     mag_to_free = cpu_rcache->loaded;
> > +             }
> > +             spin_unlock(&rcache->lock);
> > +
> > +             if (mag_to_free) {
> > +                     struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
> >
> > -             if (new_mag) {
> > -                     spin_lock(&rcache->lock);
> > -                     if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> > -                             rcache->depot[rcache->depot_size++] =
> > -                                             cpu_rcache->loaded;
> > +                     if (new_mag) {
> > +                             cpu_rcache->loaded = new_mag;
> > +                             can_insert = true;
> >                       } else {
> > -                             mag_to_free = cpu_rcache->loaded;
> > +                             mag_to_free = NULL;
> >                       }
> > -                     spin_unlock(&rcache->lock);
> > -
> > -                     cpu_rcache->loaded = new_mag;
> > -                     can_insert = true;
> >               }
> >       }
> >
> > @@ -963,14 +973,15 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
> >
> >       if (!iova_magazine_empty(cpu_rcache->loaded)) {
> >               has_pfn = true;
> > -     } else if (!iova_magazine_empty(cpu_rcache->prev)) {
> > +     } else if (iova_magazine_full(cpu_rcache->prev)) {
> >               swap(cpu_rcache->prev, cpu_rcache->loaded);
> >               has_pfn = true;
> >       } else {
> >               spin_lock(&rcache->lock);
> >               if (rcache->depot_size > 0) {
> > -                     iova_magazine_free(cpu_rcache->loaded);
>
> it is good to remove this from under the lock, apart from this change
>
> > -                     cpu_rcache->loaded = rcache->depot[--rcache->depot_size];
> > +                     swap(rcache->depot[rcache->depot_size - 1], cpu_rcache->prev);
> > +                     swap(cpu_rcache->prev, cpu_rcache->loaded);
> > +                     rcache->depot_size--;
>
> I'm not sure how appropriate the name "depot_size" is any longer.

I think it is still okay, because empty ones don't count. However if you
have better names, I am open to your suggestion.

Thanks.
