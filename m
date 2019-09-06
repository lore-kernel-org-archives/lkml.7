Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B710C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E1F206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="O7cSTnQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392887AbfIFNLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:11:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45506 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390869AbfIFNLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:11:04 -0400
Received: by mail-oi1-f194.google.com with SMTP id v12so4840908oic.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ev36SfNlEf6PWNGJxHlI3s/lnO7unyXrg4qse6t6H1Y=;
        b=O7cSTnQX0I4DPwo6zpKvGk0Vm3gxj9OL36Kq2prSvEQS7dI61nwm4xuhznBq8mv7QJ
         AZ+sTYZIRWkkIBAE7Y4TuoMPYSIUSTW7EvigyRYyOtjBKFes2iqQ43kkExyIGptSr0ZW
         gNTvbQsbIJRH4k1SlovpUgBeThCYNFCt+pOpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ev36SfNlEf6PWNGJxHlI3s/lnO7unyXrg4qse6t6H1Y=;
        b=AoHX2w4qjzg3LUO71PHNXkOOf3CyIPu2YfDEzGilYrmGuTPWWcdMuPhw9ttZxGyo3u
         170s5DjXSKvPdrEa5ucn692gJp7Ci9iikrgpeMZCktsTscQCsfe+Ihdawcu6oWP3zhlv
         utlIdUaTHJGOum/sk4LVMejvqC0lSCvMjIhQyXXFQ9OH2xOjRd8gz0p6BaGPYUNhxTk0
         SxxZH+sd+GywjzBhajryeZMGakbSF9g31zo+nk3ncrkMsSFSinkLnlRf6ihKZ2OShv/H
         0rm6ZblsUBp01mqzXFp96wm2rOfvxXPSvtEPMCId9eEzGaBEByazv98bXtwtGr9QiD7j
         A1hg==
X-Gm-Message-State: APjAAAUiOEpNN+76WycaCSpMWIuaANZkEODidtZv/hb+tZLhouq5bHKS
        L1j37Fcs08FCg8iw8WFqEE0YZBFN3ruy2eCwu027Aw==
X-Google-Smtp-Source: APXvYqxmRFNxgvHcNL/LVYV5FNh1qBNcj2zSLrlkLuEVi0kz8/vLyP49vyiza79LNaPIq5ZnEWOh+fco9c7/hTrasD4=
X-Received: by 2002:aca:5c45:: with SMTP id q66mr5340295oib.132.1567775463282;
 Fri, 06 Sep 2019 06:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190808134417.10610-1-kraxel@redhat.com> <20190808134417.10610-6-kraxel@redhat.com>
 <20190903094859.GQ2112@phenom.ffwll.local> <20190906121318.r4nvoacazvwukuun@sirius.home.kraxel.org>
In-Reply-To: <20190906121318.r4nvoacazvwukuun@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 6 Sep 2019 15:10:52 +0200
Message-ID: <CAKMK7uHFS8uW15NMEzN92POD2hyhkvKFgePdjgL=D-noUAkq3Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/17] drm: add mmap() to drm_gem_object_funcs
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 2:13 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > I think if we do an mmap callback, it should replace all the mmap handling
> > (except the drm_gem_object_get) that drm_gem_mmap_obj does. So maybe
> > something like the below:
>
> [ snip ]
>
> > Since I remember quite a few discussions where the default vma flag
> > wrangling we're doing is seriously getting in the way of things too.
>
> Yep, makes sense.
>
> > I think even better would be if this new ->mmap hook could also be used
> > directly by the dma-buf mmap code, without having to jump through hoops
> > creating a fake file and fake vma offset and everything. I think with that
> > we'd have a really solid case to add this ->mmap hook.
>
> Looks easy on a quick glance.  So something like the patch below (quick
> sketch, not tested yet other than compiling it)?

Yup, looks good, and if it works I'm happy to smash r-b and a-b tags over this.

One thought below.

> cheers,
>   Gerd
>
> From c13b30d776fb593a03473fa3bc93baf470cba728 Mon Sep 17 00:00:00 2001
> From: Gerd Hoffmann <kraxel@redhat.com>
> Date: Wed, 19 Jun 2019 14:26:51 +0200
> Subject: [PATCH] drm: add mmap() to drm_gem_object_funcs
>
> drm_gem_object_funcs->vm_ops alone can't handle everything which needs
> to be done for mmap(), tweaking vm_flags for example.  So add a new
> mmap() callback to drm_gem_object_funcs where this code can go to.
>
> Note that the vm_ops field is not used in case the mmap callback is
> presnt, it is expected that the callback sets vma->vm_ops instead.
>
> drm_gem_mmap_obj() will use the new callback for object specific mmap
> setup.  With this in place the need for driver-speific fops->mmap
> callbacks goes away, drm_gem_mmap can be hooked instead.
>
> drm_gem_prime_mmap() will use the new callback too to just mmap gem
> objects directly instead of jumping though loops to make
> drm_gem_object_lookup() and fops->mmap work.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem.h       | 14 ++++++++++++++
>  drivers/gpu/drm/drm_gem.c   | 26 +++++++++++++++++---------
>  drivers/gpu/drm/drm_prime.c |  9 +++++++++
>  3 files changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 6aaba14f5972..e71f75a2ab57 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -150,6 +150,20 @@ struct drm_gem_object_funcs {
>          */
>         void (*vunmap)(struct drm_gem_object *obj, void *vaddr);
>
> +       /**
> +        * @mmap:
> +        *
> +        * Handle mmap() of the gem object, setup vma accordingly.
> +        *
> +        * This callback is optional.
> +        *
> +        * The callback is used by by both drm_gem_mmap_obj() and
> +        * drm_gem_prime_mmap().  When @mmap is present @vm_ops is not
> +        * used, the @mmap callback must set vma->vm_ops instead.
> +        *
> +        */
> +       int (*mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);
> +
>         /**
>          * @vm_ops:
>          *
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 6854f5867d51..aabde003ac4a 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1099,22 +1099,30 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
>                      struct vm_area_struct *vma)
>  {
>         struct drm_device *dev = obj->dev;
> +       int ret;
>
>         /* Check for valid size. */
>         if (obj_size < vma->vm_end - vma->vm_start)
>                 return -EINVAL;
>
> -       if (obj->funcs && obj->funcs->vm_ops)
> -               vma->vm_ops = obj->funcs->vm_ops;
> -       else if (dev->driver->gem_vm_ops)
> -               vma->vm_ops = dev->driver->gem_vm_ops;
> -       else
> -               return -EINVAL;
> +       if (obj->funcs && obj->funcs->mmap) {
> +               ret = obj->funcs->mmap(obj, vma);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               if (obj->funcs && obj->funcs->vm_ops)
> +                       vma->vm_ops = obj->funcs->vm_ops;
> +               else if (dev->driver->gem_vm_ops)
> +                       vma->vm_ops = dev->driver->gem_vm_ops;
> +               else
> +                       return -EINVAL;
> +
> +               vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
> +               vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> +               vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
> +       }

Totally unrelated discussion around HMM lead me to a bit a chase, and
realizing that we probably want a

    WARN_ON(!(vma->vm_flags & VM_SPECIAL));

here, to make sure drivers set at least one of the "this is a special
vma, don't try to treat it like pagecache/anon memory". Just to be on
the safe side. Maybe we also want to keep the entire vma->vm_flags
assignment in the common code, but at least the WARN_ON would be a
good check I think. Maybe also check for VM_DONTEXPAND while at it
(that would also break things badly if it's not set). VM_DONTDUMP I
think is leftover from when drm drivers exposed register mmaps to
userspace.

Anyway, just some detail questions, I think this looks real good.

Thanks, Daniel

> -       vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
>         vma->vm_private_data = obj;
> -       vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> -       vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>
>         /* Take a ref for this mapping of the object, so that the fault
>          * handler can dereference the mmap offset's pointer to the object.
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 0a2316e0e812..0814211b0f3f 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -713,6 +713,15 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>         struct file *fil;
>         int ret;
>
> +       if (obj->funcs && obj->funcs->mmap) {
> +               ret = obj->funcs->mmap(obj, vma);
> +               if (ret)
> +                       return ret;
> +               vma->vm_private_data = obj;
> +               drm_gem_object_get(obj);
> +               return 0;
> +       }
> +
>         priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>         fil = kzalloc(sizeof(*fil), GFP_KERNEL);
>         if (!priv || !fil) {
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
