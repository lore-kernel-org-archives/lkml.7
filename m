Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C357EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A81A20715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbK8yhq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKVSVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:21:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32859 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKVSVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:21:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so9803957wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 10:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBF8KOuIYHgX5AQUGnNEqK7fiaxXdl5FhJB4ieLAIBQ=;
        b=cbK8yhq2kYP64/yIWyLjHR86Bm3hT1aLiBeXnIQCzYeAFUjICgmjDE/+xLcEVuwLur
         Ra+nrFRsMC7eQNxqrNOW/ye6me9w8AN2fs9Ol1t2CI3debIBu3cOwcFns6VKW7hv1w6T
         I0EKwsXSeXLtljibE347FywhcNQZn5dnS8ZdMSgNIiqCpUlghNQshb5momZR8sqsFmVP
         CSolsQnF66shqbenrz4kRJoJBhOOhl2zMpB7o33pZ/HplyWDm4NR1lOTj/S/jzXNNaRT
         ubZ+tVys888vjIUDnYcEr6IlkcqAG1zcbkP3HdskGSbHagjf3R1FMIpp9eOMmFopAxzy
         CT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBF8KOuIYHgX5AQUGnNEqK7fiaxXdl5FhJB4ieLAIBQ=;
        b=ozQ6ctQst3Q8XeToxIJnR4dloWn7S+/EOscxGkEyrz4hGmqtoIEQQhcY1p6OtjdPk+
         5ZdgmfpDf0gCt3iyRMmA2tl++URmNvNGmeTnJwjIYr7U/PXeBI6qkoYCUF2QbDSksBFL
         nxovfoJEi91L9KZHBUXcD8/TJ/ypYl502ObYngSkBMHY3gt9qEFAGgeOnU3TKf9g0vSv
         lYNnGpGm4Wc5v4QEaYhE3J++cJqjyknf4B5LXcebliEtHgKn9DFkXI7cnYx3LCWgqkSG
         EleHXuuxoRL/ziSfd5dv7HBuGoMYpYY0rwIK5c7FsrAOIsfR0X4rqGB6QiFRTS5ile1E
         DTAw==
X-Gm-Message-State: APjAAAU6mi27jteLWgzc7E0wvSgEHzdymOZv7QYyVwUKI/dyX/5k6jX1
        wdOvtDZMZlkeIWflCNnKFe4Teu+bdMsi2OUN3poIwA==
X-Google-Smtp-Source: APXvYqytEwccvMir2K/ExKSR+iN9/YVslC4V3V2VCpQqnB/nAm+/+YD1Z6n6WOCTIaGw160dGdTfERASM3AumnzwiIA=
X-Received: by 2002:adf:f54c:: with SMTP id j12mr1076502wrp.40.1574446905504;
 Fri, 22 Nov 2019 10:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20191122063749.27113-1-kraxel@redhat.com> <20191122063749.27113-3-kraxel@redhat.com>
 <CAKMK7uFz3hmPT3OE8UtUQwmv+tXsjazUWT2RVHLxAq47X+EaXA@mail.gmail.com>
In-Reply-To: <CAKMK7uFz3hmPT3OE8UtUQwmv+tXsjazUWT2RVHLxAq47X+EaXA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 22 Nov 2019 13:21:33 -0500
Message-ID: <CADnq5_MvOE1Fw7-0g+Fo3Vvvu-c=Z9u+pZUEstv2cVXNKKL2=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm: share address space for dma bufs
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 4:17 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Nov 22, 2019 at 7:37 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Use the shared address space of the drm device (see drm_open() in
> > drm_file.c) for dma-bufs too.  That removes a difference betweem drm
> > device mmap vmas and dma-buf mmap vmas and fixes corner cases like
> > dropping ptes (using madvise(DONTNEED) for example) not working
> > properly.
> >
> > Also remove amdgpu driver's private dmabuf update.  It is not needed
> > any more now that we are doing this for everybody.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> But I think you want at least an ack from amd guys for double checking here.
> -Daniel

Looks correct to me.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 +---
> >  drivers/gpu/drm/drm_prime.c                 | 4 +++-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > index d5bcdfefbad6..586db4fb46bd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > @@ -361,10 +361,8 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
> >                 return ERR_PTR(-EPERM);
> >
> >         buf = drm_gem_prime_export(gobj, flags);
> > -       if (!IS_ERR(buf)) {
> > -               buf->file->f_mapping = gobj->dev->anon_inode->i_mapping;
> > +       if (!IS_ERR(buf))
> >                 buf->ops = &amdgpu_dmabuf_ops;
> > -       }
> >
> >         return buf;
> >  }
> > diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> > index a9633bd241bb..c3fc341453c0 100644
> > --- a/drivers/gpu/drm/drm_prime.c
> > +++ b/drivers/gpu/drm/drm_prime.c
> > @@ -240,6 +240,7 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv)
> >  struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
> >                                       struct dma_buf_export_info *exp_info)
> >  {
> > +       struct drm_gem_object *obj = exp_info->priv;
> >         struct dma_buf *dma_buf;
> >
> >         dma_buf = dma_buf_export(exp_info);
> > @@ -247,7 +248,8 @@ struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
> >                 return dma_buf;
> >
> >         drm_dev_get(dev);
> > -       drm_gem_object_get(exp_info->priv);
> > +       drm_gem_object_get(obj);
> > +       dma_buf->file->f_mapping = obj->dev->anon_inode->i_mapping;
> >
> >         return dma_buf;
> >  }
> > --
> > 2.18.1
> >
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
