Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC25C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA162084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGcrxOsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfKLLDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:03:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41623 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfKLLDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:03:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id a21so14558651edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 03:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7v/v4nr+zqzk2y/jAd0gNZ9DfjLyLFd4Z21yLnvf0Dw=;
        b=WGcrxOsczq3GVLUIOlQBv9NqR40pTHNB89f52HlTcJP/airVxcI1SbQma3s/xI/y9b
         3FzS+nvwEDIrjUz2i2JkCwft5P+/PNYXiNcxG6SeQicGHSv4apY9rtF/iOfeKgKERvGi
         49Mh+wxoUpPZaJmxb9Nw6btNQVViXnOh65IYkoGrkBwPGsVMEnTa7lGIUtfNvTF+Gn3V
         Qe6PMS86mVL8zxP5qiu8kymKk6Zx8AH19LR1tOXygo4H+xoYMcZsRW7KYCViZ0cRc+oW
         /MXLGW+zWRzqppdLzFyZg5PVEzdYx8ePWwKKIta0fJ9bjReuWFvvR2ms3JaP8Joey/fo
         0Rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7v/v4nr+zqzk2y/jAd0gNZ9DfjLyLFd4Z21yLnvf0Dw=;
        b=ct8idkxTLsYi5rZ+y+oB5rg3OeVH11+o2+gDe7pDTVtxKSZKAdbGJEjLnP6LG0sT8l
         8xopb8KL5sOjtr0chmEOWCiBVzEXrHg+Psk11lG7zGvYGcMQMo8u4kPuZdRapfzzj+22
         +dh8m0ilfSgQrgtmafQMEAvsN+A0JwaL4etN8uHEyLFCmFKLUxPxaIyQRi8fbqTfHWWN
         +ZjJs5jykXEr9IUKuJ+jKbnugyw8H2rFeXsFBS4fCo7NH4syTkgafydBZEnghoVJgT1C
         N/nw8NeybJ6HSs6qeExhb7h+8y6YUOnd09TR4ZhpgWdocpSsWauRdREDlIxq37FofUvD
         F60g==
X-Gm-Message-State: APjAAAVVTxyQ2MFEdMiG1votf+flMVo6TILRYRd7rj39X4j17bcdve14
        OqVLOffmb7N5G6iYIt1Cmy888PrRJCh7bAfyMgM=
X-Google-Smtp-Source: APXvYqyF5pycYcqNWugO2851/NH1Ih0TM/Tf5B7Bn9iBKqBF7TP/lwxHh3YlfKn//hB0aWX0AcvVEX/a2g+CgBbh4C8=
X-Received: by 2002:a17:906:f109:: with SMTP id gv9mr28018882ejb.196.1573556596349;
 Tue, 12 Nov 2019 03:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20191109075417.29808-1-hslester96@gmail.com> <20191112094031.GF23790@phenom.ffwll.local>
In-Reply-To: <20191112094031.GF23790@phenom.ffwll.local>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Tue, 12 Nov 2019 19:03:05 +0800
Message-ID: <CANhBUQ1HRe4FNWo0o18zxV2ZoANRdNd3PaTeeBZ6dG__0quDUA@mail.gmail.com>
Subject: Re: [PATCH] drm/virtgpu: fix double unregistration
To:     Chuhong Yuan <hslester96@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 5:40 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Sat, Nov 09, 2019 at 03:54:17PM +0800, Chuhong Yuan wrote:
> > drm_put_dev also calls drm_dev_unregister, so dev will be unregistered
> > twice.
> > Replace it with drm_dev_put to fix it.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
>
> Nice catch, I'll apply.
>
> Since this is so confusing, we actually have a todo to remove drm_put_dev
> completely from the codebase (and open-code it with explicit
> unregister+put). Want to do that little patch series to update the
> remaining few drivers and then remove drm_put_dev from core code?
>
> Thanks, Daniel
>

I am sorry that I have to focus on my current project in recent days.
But since this is a problem, I have written a Coccinelle script just now
to find drm_put_dev and open-code it.
I hope this helps.
The script is:

virtual patch

@ drm_put_dev depends on patch exists @
expression dev;
@@

- drm_put_dev(dev);
+ drm_dev_unregister(dev);
+ drm_dev_put(dev);

Regards,
Chuhong
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > index 0fc32fa0b3c0..fccc24e21af8 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > @@ -138,7 +138,7 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
> >
> >       drm_dev_unregister(dev);
> >       virtio_gpu_deinit(dev);
> > -     drm_put_dev(dev);
> > +     drm_dev_put(dev);
> >  }
> >
> >  static void virtio_gpu_config_changed(struct virtio_device *vdev)
> > --
> > 2.23.0
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
