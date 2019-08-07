Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D49BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C00D22305
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="eufME0A1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbfHGSrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:47:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38264 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389360AbfHGSrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:47:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so108494410oth.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3GxMdQgJ16JYM6vB9EqrOMBguT7ZpbwaC2gFsJYblY=;
        b=eufME0A1waHaRExGiJHdT+bpIpihtaHYpBR1S379jGewd0U+Nt66U62LNva1+eZKmu
         dhy9pkKzSiX3YZhVm29ptFSIyBc9Y+KnM3g54IwyRgUpFlNR3nZhM4VXnbG2uBy1zBFV
         nKr26w6ffs+NE6K7g1U5MxcWnDwNmXhcoKU5rHdq7KGHSgy0NS2q5OLROhpdNqxicJ7A
         nR0Y2nywQGDNILibe7GM19qh275ev59HXQR5ieMatT6CC257JjLV53yo6QaYKhXIebDW
         LbLROTSOvx0EAQM7DBPCTCsnUDDTtIUa1KL4qhkROxa+QLttpESgrtP/pw7SxNnTfnyE
         BuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3GxMdQgJ16JYM6vB9EqrOMBguT7ZpbwaC2gFsJYblY=;
        b=tfYXPtqYq1jaCXfn6dhhvU2j5t2GWCq9BIdokGTtfCldrbnqa3LEhfoCMJSDXvH7zo
         NsjDlwHsJNuhzxxWPjfSL2RZJhJfhllerhK868EhHnltDVfOf0kjZZlhbJHXHVDdFOQs
         5JrBKkxMZyaLiM38Wn19lXyz4BobJM/LCYu9EE+oZXADoMUcn761dVlXGbu7gRAHRxI+
         9H64iQ4+NaoOS88Ejtdi0zdEmDOoyZ422yFHH4x/CG3HYmOWnOwFfcsPEAtJNgCxRRet
         gY3o5jHd7LNaj6VOavoHqg8qqIdcSDvTL2/AERFtQUxYpvbvByV+aPE/o8+6ia2DRFri
         2XaQ==
X-Gm-Message-State: APjAAAVX5Jl7iFQgLMDOca7y7ogE08rLU8Tab5GPNd9OZjRkPg7cmLMl
        rX658FIC2yW1vxCzU69wASvHQ5iQ6qa+PixVviL9iA==
X-Google-Smtp-Source: APXvYqx9iyAol+nPIwV+xm+JH3PQpbIYdFfNm3nAIBIucjDzbmxREKqG7SEfBZVZpdTmNeOyHJgfGURXESCs2jM413Q=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr916746oii.0.1565203653206;
 Wed, 07 Aug 2019 11:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190806160554.14046-1-hch@lst.de> <20190806160554.14046-5-hch@lst.de>
 <20190807174548.GJ1571@mellanox.com>
In-Reply-To: <20190807174548.GJ1571@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 7 Aug 2019 11:47:22 -0700
Message-ID: <CAPcyv4hPCuHBLhSJgZZEh0CbuuJNPLFDA3f-79FX5uVOO0yubA@mail.gmail.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 10:45 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Tue, Aug 06, 2019 at 07:05:42PM +0300, Christoph Hellwig wrote:
> > There is only a single place where the pgmap is passed over a function
> > call, so replace it with local variables in the places where we deal
> > with the pgmap.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >  mm/hmm.c | 62 ++++++++++++++++++++++++--------------------------------
> >  1 file changed, 27 insertions(+), 35 deletions(-)
> >
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 9a908902e4cc..d66fa29b42e0 100644
> > +++ b/mm/hmm.c
> > @@ -278,7 +278,6 @@ EXPORT_SYMBOL(hmm_mirror_unregister);
> >
> >  struct hmm_vma_walk {
> >       struct hmm_range        *range;
> > -     struct dev_pagemap      *pgmap;
> >       unsigned long           last;
> >       unsigned int            flags;
> >  };
> > @@ -475,6 +474,7 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >       struct hmm_vma_walk *hmm_vma_walk = walk->private;
> >       struct hmm_range *range = hmm_vma_walk->range;
> > +     struct dev_pagemap *pgmap = NULL;
> >       unsigned long pfn, npages, i;
> >       bool fault, write_fault;
> >       uint64_t cpu_flags;
> > @@ -490,17 +490,14 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
> >       pfn = pmd_pfn(pmd) + pte_index(addr);
> >       for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
> >               if (pmd_devmap(pmd)) {
> > -                     hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
> > -                                           hmm_vma_walk->pgmap);
> > -                     if (unlikely(!hmm_vma_walk->pgmap))
> > +                     pgmap = get_dev_pagemap(pfn, pgmap);
> > +                     if (unlikely(!pgmap))
> >                               return -EBUSY;
>
> Unrelated to this patch, but what is the point of getting checking
> that the pgmap exists for the page and then immediately releasing it?
> This code has this pattern in several places.
>
> It feels racy

Agree, not sure what the intent is here. The only other reason call
get_dev_pagemap() is to just check in general if the pfn is indeed
owned by some ZONE_DEVICE instance, but if the intent is to make sure
the device is still attached/enabled that check is invalidated at
put_dev_pagemap().

If it's the former case, validating ZONE_DEVICE pfns, I imagine we can
do something cheaper with a helper that is on the order of the same
cost as pfn_valid(). I.e. replace PTE_DEVMAP with a mem_section flag
or something similar.

>
> >               }
> >               pfns[i] = hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
> >       }
> > -     if (hmm_vma_walk->pgmap) {
> > -             put_dev_pagemap(hmm_vma_walk->pgmap);
> > -             hmm_vma_walk->pgmap = NULL;
>
> Putting the value in the hmm_vma_walk would have made some sense to me
> if the pgmap was not set to NULL all over the place. Then the most
> xa_loads would be eliminated, as I would expect the pgmap tends to be
> mostly uniform for these use cases.
>
> Is there some reason the pgmap ref can't be held across
> faulting/sleeping? ie like below.

No restriction on holding refs over faulting / sleeping.

>
> Anyhow, I looked over this pretty carefully and the change looks
> functionally OK, I just don't know why the code is like this in the
> first place.
>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
>
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 9a908902e4cc38..4e30128c23a505 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -497,10 +497,6 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
>                 }
>                 pfns[i] = hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
>         }
> -       if (hmm_vma_walk->pgmap) {
> -               put_dev_pagemap(hmm_vma_walk->pgmap);
> -               hmm_vma_walk->pgmap = NULL;
> -       }
>         hmm_vma_walk->last = end;
>         return 0;
>  #else
> @@ -604,10 +600,6 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>         return 0;
>
>  fault:
> -       if (hmm_vma_walk->pgmap) {
> -               put_dev_pagemap(hmm_vma_walk->pgmap);
> -               hmm_vma_walk->pgmap = NULL;
> -       }
>         pte_unmap(ptep);
>         /* Fault any virtual address we were asked to fault */
>         return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
> @@ -690,16 +682,6 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>                         return r;
>                 }
>         }
> -       if (hmm_vma_walk->pgmap) {
> -               /*
> -                * We do put_dev_pagemap() here and not in hmm_vma_handle_pte()
> -                * so that we can leverage get_dev_pagemap() optimization which
> -                * will not re-take a reference on a pgmap if we already have
> -                * one.
> -                */
> -               put_dev_pagemap(hmm_vma_walk->pgmap);
> -               hmm_vma_walk->pgmap = NULL;
> -       }
>         pte_unmap(ptep - 1);
>
>         hmm_vma_walk->last = addr;
> @@ -751,10 +733,6 @@ static int hmm_vma_walk_pud(pud_t *pudp,
>                         pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
>                                   cpu_flags;
>                 }
> -               if (hmm_vma_walk->pgmap) {
> -                       put_dev_pagemap(hmm_vma_walk->pgmap);
> -                       hmm_vma_walk->pgmap = NULL;
> -               }
>                 hmm_vma_walk->last = end;
>                 return 0;
>         }
> @@ -1026,6 +1004,14 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
>                         /* Keep trying while the range is valid. */
>                 } while (ret == -EBUSY && range->valid);
>
> +               /*
> +                * We do put_dev_pagemap() here so that we can leverage
> +                * get_dev_pagemap() optimization which will not re-take a
> +                * reference on a pgmap if we already have one.
> +                */
> +               if (hmm_vma_walk->pgmap)
> +                       put_dev_pagemap(hmm_vma_walk->pgmap);
> +

Seems ok, but only if the caller is guaranteeing that the range does
not span outside of a single pagemap instance. If that guarantee is
met why not just have the caller pass in a pinned pagemap? If that
guarantee is not met, then I think we're back to your race concern.
