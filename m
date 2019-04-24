Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CAFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9F3218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbfDXOio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:38:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39384 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbfDXOim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:38:42 -0400
Received: by mail-io1-f67.google.com with SMTP id c3so8515537iok.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUjd3I/imgFM0Dl6RAFqvaSeyJDo8VeI6BeroLur4kk=;
        b=SyS8wuG5JD26GZ3UYfPINk5SUX+UeXk/sq2Sd2Ls5yJVAisNpFXBob0ceRpbju7Ajq
         OVr4ULooJHWNus9l8SSj33XWNOgokDpNzjpLI7JH3OiSHSkQNQ1Smi0xl6Ij9hz0vvhE
         buhxatYAeRW/waJlsptwuWn0Cpd2kvmx2Phj0CgCRDIIgthWTFTQpsKcQOKbbLRSnvar
         wvzl8sz1GRqUkbdgfo+IC+I+uSez0//3Awfmw5WmHPaKQpeKcOZMmrt38WiacI6i0HD9
         Verd3K+LhCHH1GhErSodhlcfm947d0ONvRG0g/FJV0PHz1jgc/S2UUIHE0MPHop4J4HJ
         T0NA==
X-Gm-Message-State: APjAAAU2msEyxiqqvagIiVRSZ5RdfzRi4drc8agVpmAj74rMo8HJ7MnM
        ViQpbQwybSAwsblEV/ApO8BBTGRNSlcAQqh6q58=
X-Google-Smtp-Source: APXvYqwuPK5PIGPz2tokPgsUHB6cUDSMNgwlMRF71TvZ6Pi3lHdOUcbPlUGB/R/qn3IF7gkKkJpFetuzFGT3pdi40Ys=
X-Received: by 2002:a5d:984a:: with SMTP id p10mr21448918ios.217.1556116721514;
 Wed, 24 Apr 2019 07:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190424131355.62817-1-tomeu.vizoso@collabora.com> <20190424132019.GS9857@phenom.ffwll.local>
In-Reply-To: <20190424132019.GS9857@phenom.ffwll.local>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Wed, 24 Apr 2019 16:38:29 +0200
Message-ID: <CAAObsKAnCt2wfip6QsJy0fXyq1mNr02oghUO9qt_OC_EQh6q_A@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Add sanity checks to submit IOCTL
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 at 15:20, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Apr 24, 2019 at 03:13:53PM +0200, Tomeu Vizoso wrote:
> > So userspace can get feedback on any error conditions, instead of going
> > ahead and things breaking later.
> >
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> Bonus: some igts to exercise these corner cases. It helps a lot with uapi
> review and testing.

I'm rebasing that igt branch as we speak :)

Tomeu

> -Daniel
>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_drv.c | 35 +++++++++++++++++--------
> >  1 file changed, 24 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index c06af78ab833..0f2863cb8077 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -172,13 +172,27 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
> >  {
> >       struct panfrost_device *pfdev = dev->dev_private;
> >       struct drm_panfrost_submit *args = data;
> > -     struct drm_syncobj *sync_out;
> > +     struct drm_syncobj *sync_out = NULL;
> >       struct panfrost_job *job;
> >       int ret = 0;
> >
> > +     if (!args->jc)
> > +             return -EINVAL;
> > +
> > +     if (args->requirements && args->requirements != PANFROST_JD_REQ_FS)
> > +             return -EINVAL;
> > +
> > +     if (args->out_sync > 0) {
> > +             sync_out = drm_syncobj_find(file, args->out_sync);
> > +             if (!sync_out)
> > +                     return -ENODEV;
> > +     }
> > +
> >       job = kzalloc(sizeof(*job), GFP_KERNEL);
> > -     if (!job)
> > -             return -ENOMEM;
> > +     if (!job) {
> > +             ret = -ENOMEM;
> > +             goto fail_out_sync;
> > +     }
> >
> >       kref_init(&job->refcount);
> >
> > @@ -190,25 +204,24 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
> >
> >       ret = panfrost_copy_in_sync(dev, file, args, job);
> >       if (ret)
> > -             goto fail;
> > +             goto fail_job;
> >
> >       ret = panfrost_lookup_bos(dev, file, args, job);
> >       if (ret)
> > -             goto fail;
> > +             goto fail_job;
> >
> >       ret = panfrost_job_push(job);
> >       if (ret)
> > -             goto fail;
> > +             goto fail_job;
> >
> >       /* Update the return sync object for the job */
> > -     sync_out = drm_syncobj_find(file, args->out_sync);
> > -     if (sync_out) {
> > +     if (sync_out)
> >               drm_syncobj_replace_fence(sync_out, job->render_done_fence);
> > -             drm_syncobj_put(sync_out);
> > -     }
> >
> > -fail:
> > +fail_job:
> >       panfrost_job_put(job);
> > +fail_out_sync:
> > +     drm_syncobj_put(sync_out);
> >
> >       return ret;
> >  }
> > --
> > 2.20.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
