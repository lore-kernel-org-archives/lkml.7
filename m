Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48AFC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 15:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1C52186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 15:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIKBplXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfGSPEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 11:04:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46119 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSPEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 11:04:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so34800055edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2/Dk2h3VtRtpKEYNTLoFv9y8SCMtDA0mX1ON9McDAxU=;
        b=LIKBplXRAWWluVZjmlGO+RFdgPMEFB1SZiGGuN29eKqCWRhMudg9nG+zgdj25EEILX
         1rwgX5ujfBV4SjE5F6ICNBFuCaUSXiLjCyhqlgwJ6qz6Q3Ct1z6keOIJPOQIdUbwDS+0
         PdDF7wQ96pf8GqTeMvx1U7rOJnF/TFCEJpB/JgVYXLcHj517bqAtNC/wbNKkEOHwznBo
         V8WZiVKbHH/FxWj/EMKYRJ3tI56yJEyJfQ0yDrE/NspTQt8dHa3DiQR2e/BDjyL5nPKN
         dCJowEYVFEWlAgo43ZqutPHx2Uma7eJyw0dfiXYeU+mGVmg8WCdXXWKgiqIwwej/6Y6x
         BOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/Dk2h3VtRtpKEYNTLoFv9y8SCMtDA0mX1ON9McDAxU=;
        b=toLG07zpxIiBK/zqJArWbH1/4y5xQuik/XV+ShJ75caNXp0K8dSNQl0jODR0dY8I7h
         raLcIKG4heYroSl+YoY2qIUmWCWVzU8KzZL2GjhrwW3xxRAuJmpygeROQ3JJ2U8f5Brb
         WeYyLLdNxeFJDLd0pNaUFV2MgV5AuT/y2Xafc/tQRvt9oU+NA2bctB+9M+ogIXlVa7WB
         qrIfU5MScJX3Q1H0h2pM1Qk0IP6XEKwnt6mtRY53AY3ocEJWpE0Udsaw64Omzqc/m4f4
         jOcuKGYMfgDdVVNdW8aYFNqeGaB0KaXwokCaOHDmm5QHZrduHvMO4TUDuo6H6S/Ua+Si
         4yeA==
X-Gm-Message-State: APjAAAU6dr2KSh4miMNY8eervT1iX3ARbGrvExqGI+WNTE/0lKD67Bca
        5ao4L7O5ZUj5A/RbTtIRLIa/PmpOpFttn8Sm1x4=
X-Google-Smtp-Source: APXvYqy3AfEghQMcXF9VOwRQhc99W/f1B3Sr0Ahbjqamx/d9/eLK0MRlwOFZqBcUvcmk5DpgHTia3heGjRaNq1+9/qo=
X-Received: by 2002:a50:8bfd:: with SMTP id n58mr46428179edn.272.1563548651767;
 Fri, 19 Jul 2019 08:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190716164221.15436-1-robdclark@gmail.com> <20190716164221.15436-2-robdclark@gmail.com>
 <20190719090949.GG15868@phenom.ffwll.local>
In-Reply-To: <20190719090949.GG15868@phenom.ffwll.local>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 19 Jul 2019 08:04:00 -0700
Message-ID: <CAF6AEGt=ks93F=hYGEy-+PUDTsXA2Wp+DwhGYLFraJ5jZmRKtA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/vgem: use normal cached mmap'ings
To:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Imre Deak <imre.deak@intel.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 2:09 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Jul 16, 2019 at 09:42:15AM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Since there is no real device associated with vgem, it is impossible to
> > end up with appropriate dev->dma_ops, meaning that we have no way to
> > invalidate the shmem pages allocated by vgem.  So, at least on platforms
> > without drm_cflush_pages(), we end up with corruption when cache lines
> > from previous usage of vgem bo pages get evicted to memory.
> >
> > The only sane option is to use cached mappings.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > Possibly we could dma_sync_*_for_{device,cpu}() on dmabuf attach/detach,
> > although the ->gem_prime_{pin,unpin}() API isn't quite ideal for that as
> > it is.  And that doesn't really help for drivers that don't attach/
> > detach for each use.
> >
> > But AFAICT vgem is mainly used for dmabuf testing, so maybe we don't
> > need to care too much about use of cached mmap'ings.
>
> Isn't this going to horribly break testing buffer sharing with SoC
> devices? I'd assume they all expect writecombining mode to make sure stuff
> is coherent?
>
> Also could we get away with this by simply extending drm_cflush_pages for
> those arm platforms where we do have a clflush instruction? Yes I know
> that'll get people screaming, I'll shrug :-)
>
> If all we need patch 1/2 for is this vgem patch then the auditing needed for
> patch 1 doesn't look appealing ...

I think we should go w/ the simpler approach in that keeps WC (but
kinda relies on an implementation detail of dma-mapping, ie.
dev->dma_ops==NULL => dma_direct

IMO the first patch in this series is probably a thing we should try
to do somehow, it is a bit rude that core helpers are forcing WC.  But
not sure about how to land that smoothly.  Perhaps something worth
adding to the TODO list at any rate.

BR,
-R

> -Daniel
>
> >
> >  drivers/gpu/drm/vgem/vgem_drv.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> > index 11a8f99ba18c..ccf0c3fbd586 100644
> > --- a/drivers/gpu/drm/vgem/vgem_drv.c
> > +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> > @@ -259,9 +259,6 @@ static int vgem_mmap(struct file *filp, struct vm_area_struct *vma)
> >       if (ret)
> >               return ret;
> >
> > -     /* Keep the WC mmaping set by drm_gem_mmap() but our pages
> > -      * are ordinary and not special.
> > -      */
> >       vma->vm_flags = flags | VM_DONTEXPAND | VM_DONTDUMP;
> >       return 0;
> >  }
> > @@ -382,7 +379,7 @@ static void *vgem_prime_vmap(struct drm_gem_object *obj)
> >       if (IS_ERR(pages))
> >               return NULL;
> >
> > -     return vmap(pages, n_pages, 0, pgprot_writecombine(PAGE_KERNEL));
> > +     return vmap(pages, n_pages, 0, PAGE_KERNEL);
> >  }
> >
> >  static void vgem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
> > @@ -411,7 +408,7 @@ static int vgem_prime_mmap(struct drm_gem_object *obj,
> >       fput(vma->vm_file);
> >       vma->vm_file = get_file(obj->filp);
> >       vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
> > -     vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> > +     vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> >
> >       return 0;
> >  }
> > --
> > 2.21.0
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
