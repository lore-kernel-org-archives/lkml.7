Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C53DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305BD20658
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="VFxT5Ht5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKNArt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:47:49 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43203 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKNArt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:47:49 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so3639232oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JM0dXEnMbhhl1OhBMrYQPa4kYdncN1u/Wddm5L/nHXY=;
        b=VFxT5Ht5WgclaogJt6FVDC9JnKcmVgOsS3Bzjz9RF7QJJNV/Xb1fHXe7C2P1cE8g1D
         NpiOedzfyNJBGjBn9IjMkX9VHTvoVZxFShBn/UZsMRN9mruaoPwn6CeF14i5gGZXnGjb
         EnokZzTGgPWLWltVH47ExnvwD8zOROPLm8ofoCDYhZDLgnVfJ9kyjvTWcD9XVG5pDQwC
         ELVfd7BB+s6Ix1tO+6nLC/EgJgB9kVCKsrLY6njjiUXymYwObN2N7qb7PyIXTgoVQU5I
         9u75Zl776E9b2e/VLB2WSX47ps086nsiXLTbMUdjJNptpUrDmVdlNZdMQuMQj5KM944e
         UAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JM0dXEnMbhhl1OhBMrYQPa4kYdncN1u/Wddm5L/nHXY=;
        b=f5dXwWyHh0Y78YQ+VT4zuBIE0vGPDNYrULY8pkkLW6MIFcv7um8RR9EMJvXkjSWBbo
         3Srxn9hrYDHa3txC4LbZLW2RxRLqaU4LIhwdBI67XM0TnflwdsC4ascmNbyTUQOIUnHf
         igkKM89W+SYRHDflC4fwNY8fFGuHbzO/6I3YZAn2bd9cY0aDzxJ+BgZ9OpLd9kAAM2/p
         bF1LSpJ+CYR5NxenZmZk8GRmcjTP0uzxNSiHgsxb7a3Em4+4hAA+SsnFeQzbvjHqDgH5
         O63DafR0Vh46o9oRTIuzqAW9YomOW8z0u7jz+OJsA2tgITHklpzzQ4TfHud0SUTZG+Xa
         KQ+Q==
X-Gm-Message-State: APjAAAW4nIltdBPs5umfhZAQpBjqIPYV7qnrWp73aHVNpxsOBMwnWyqo
        GnjL/Es/ITAaOniU6bvUvWMoZmAviNjQBFGmFOvZzQ==
X-Google-Smtp-Source: APXvYqxao2KBp8k4m1dwk99bHg4ow0Xhti2qQb0KE7VmDCDH1hUUcHJ0mFCvmDLVnPJgQ4jBH5R1W8RgJYKPFWsifvA=
X-Received: by 2002:aca:3d84:: with SMTP id k126mr1206841oia.70.1573692468621;
 Wed, 13 Nov 2019 16:47:48 -0800 (PST)
MIME-Version: 1.0
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
 <913133b7-58d8-9645-fc89-c2819825e1ee@nvidia.com>
In-Reply-To: <913133b7-58d8-9645-fc89-c2819825e1ee@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Nov 2019 16:47:38 -0800
Message-ID: <CAPcyv4hK1hkDn9WohRn4F8JkAOBu94jzOJtU+43PP2qSX77Fqg@mail.gmail.com>
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs ->page_free()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 4:42 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 11/13/19 4:07 PM, Dan Williams wrote:
> > After the removal of the device-public infrastructure there are only 2
> > ->page_free() call backs in the kernel. One of those is a device-privat=
e
> > callback in the nouveau driver, the other is a generic wakeup needed in
> > the DAX case. In the hopes that all ->page_free() callbacks can be
> > migrated to common core kernel functionality, move the device-private
> > specific actions in __put_devmap_managed_page() under the
> > is_device_private_page() conditional, including the ->page_free()
> > callback. For the other page types just open-code the generic wakeup.
> >
> > Yes, the wakeup is only needed in the MEMORY_DEVICE_FSDAX case, but it
> > does no harm in the MEMORY_DEVICE_DEVDAX and MEMORY_DEVICE_PCI_P2PDMA
> > case.
> >
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Hi John,
> >
> > This applies on top of today's linux-next and passes my nvdimm unit
> > tests. That testing noticed that devmap_managed_enable_get() needed a
> > small fixup as well.
>
> Got it. This will appear in the next posted version of my "mm/gup: track
> dma-pinned pages: FOLL_PIN, FOLL_LONGTERM" patchset.

Thanks!

>
>
> >
> >   drivers/nvdimm/pmem.c |    6 ------
> >   mm/memremap.c         |   22 ++++++++++++----------
> >   2 files changed, 12 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index f9f76f6ba07b..21db1ce8c0ae 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -338,13 +338,7 @@ static void pmem_release_disk(void *__pmem)
> >       put_disk(pmem->disk);
> >   }
> >
> > -static void pmem_pagemap_page_free(struct page *page)
> > -{
> > -     wake_up_var(&page->_refcount);
> > -}
> > -
> >   static const struct dev_pagemap_ops fsdax_pagemap_ops =3D {
> > -     .page_free              =3D pmem_pagemap_page_free,
> >       .kill                   =3D pmem_pagemap_kill,
> >       .cleanup                =3D pmem_pagemap_cleanup,
> >   };
> > diff --git a/mm/memremap.c b/mm/memremap.c
> > index 022e78e68ea0..6e6f3d6fdb73 100644
> > --- a/mm/memremap.c
> > +++ b/mm/memremap.c
> > @@ -27,7 +27,8 @@ static void devmap_managed_enable_put(void)
> >
> >   static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
> >   {
> > -     if (!pgmap->ops || !pgmap->ops->page_free) {
> > +     if (!pgmap->ops || (pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE
> > +                             && !pgmap->ops->page_free)) {
>
>
> OK, so only MEMORY_DEVICE_PRIVATE has .page_free ops. That looks
> correct to me, based on looking at the .page_free setters--I
> only see Nouveau setting it.

Correct. The FSDAX case still needs to enable the 'devmap_managed_key'
static key, but other than that the core will handle all the follow-on
details.
