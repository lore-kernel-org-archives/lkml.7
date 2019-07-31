Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0AFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C765206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlfDdsWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfGaG0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:26:19 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33355 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGaG0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:26:19 -0400
Received: by mail-yb1-f196.google.com with SMTP id c202so22718390ybf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 23:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xzym8/dUuXuGiOMMezN5bW3u98W2F4vTa3EFglwr9Xk=;
        b=RlfDdsWwTMhs4L47y3YvK1IPZw4kW+5WVucupuREnMgiVDQyq+AyL3EVp7fWh23/wG
         qABS5+Ebz42PHuy3fYI4w2XUSESBZJIykM24cdwR25y1KLutNJ8Zo72oaMmiB9RUhHkX
         B4L+kxotm1UTrBAuWrKKV/xSFhQVD+Sy5XaD50zRbR3fqgAiSb6pXERpm/Pfk1K4CH6Z
         zUh2+YiKza+gZE075cQjGveh6Iq1ud9e9wzHGkHkF5IpZyHOfQRld5tV0JxqPHI8X8TT
         2UsrEud3np2irIlQkjf1UD+qGxCiSINhcqJmspatsmCjrKglau8M5UdxGaRDnrQyIto6
         rU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xzym8/dUuXuGiOMMezN5bW3u98W2F4vTa3EFglwr9Xk=;
        b=MToa0mCx+MbUYiDCWaJQaurir82No02XQTLxq37mLSwzeQShan1M/h0QdbI1umCWj+
         GjureK1ifB/GhwSDKfPVqx67StSaHrdaQREuaL4hAHfIc8NeAvO7n5gMBz+SABm9pPmd
         KlUfMGqgpzPjKB+SzvwJOa78ahycU1CQa2WSpDKG0h6O4I3LuppJQrXeXx3iPPXkWRyS
         s333mhCbTjxwl6XxrlLPrWDESZB8KWDIBr9+rzeEWdwn/qqzM0WEIErTu+8TJrjNqr3z
         JpIlJfC+7b9IHe+FaU5eIiKlOkqlagJ8SzB/3PZdveik9PwsG78rDktsWgXrfdOrg+Ck
         aOgw==
X-Gm-Message-State: APjAAAWzJTRO1Vy71RSPikyTN5DnnRz9kW4NaXCbkxUokvUq6bWQQnNz
        G2/vT5spDkKzOpO0e77WwByOehmB+VUGEEJAe1k=
X-Google-Smtp-Source: APXvYqznqG7aFgKm5YjjvnDVVr8TB+M8SM5D/aHXde0NAfY/K2gnyHYZcnpShx7xnGA1X0yvO1v57Q8hnjSJc9s9BNQ=
X-Received: by 2002:a25:830e:: with SMTP id s14mr74917205ybk.500.1564554378800;
 Tue, 30 Jul 2019 23:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190731024533.22264-1-huangfq.daxian@gmail.com> <520bd0f7367e77ffd2e0150187f6ffb64b0e8b71.camel@perches.com>
In-Reply-To: <520bd0f7367e77ffd2e0150187f6ffb64b0e8b71.camel@perches.com>
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Date:   Wed, 31 Jul 2019 14:26:07 +0800
Message-ID: <CABXRUiSYbyb8+bsvCb_+n1kLEA_ZSFxR5D7c+qatrW9KPGmeqw@mail.gmail.com>
Subject: Re: [PATCH] drm: use trace_printk rather than printk in drm_dbg.
To:     Joe Perches <joe@perches.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> =E6=96=BC 2019=E5=B9=B47=E6=9C=8831=E6=97=A5=
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:06=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 2019-07-31 at 10:45 +0800, Fuqian Huang wrote:
> > In drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c,
> > amdgpu_ih_process calls DRM_DEBUG which calls drm_dbg and
> > finally calls printk.
> > As amdgpu_ih_process is called from an interrupt handler,
> > and interrupt handler should be short as possible.
> >
> > As printk may lead to bogging down the system or can even
> > create a live lock. printk should not be used in IRQ context.
> > Instead, trace_printk is recommended.
> > Link: https://lwn.net/Articles/365835
> []
> > diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> []
> > @@ -236,7 +236,7 @@ void drm_dbg(unsigned int category, const char *for=
mat, ...)
> >       vaf.fmt =3D format;
> >       vaf.va =3D &args;
> >
> > -     printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> > +     trace_printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> >              __builtin_return_address(0), &vaf);
> >
> >       va_end(args);
>
> This makes all 4000+ drm_dbg/DRM_DEBUG uses emit
> a trace_printk.
>
> I suggest instead you make only the interrupt uses
> use a different function and not drm_dbg.
>
> Or maybe add an in_interrupt() check like
>
>         if (in_interrupt())
>                 printk(KERN_DEBUG etc...)
>         else
>                 trace_printk(etc...)

I will send a v2 patch to fix this.
