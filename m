Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8335BC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5712A2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oTEwwP8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfHSETV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 00:19:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46695 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfHSETU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:19:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id z51so363441edz.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbyYLzisYNN1lRqh22A2VNalz6OnIhJsVCaofVl30Uk=;
        b=oTEwwP8bcyoAr7TAwnNcsjRWloPJDG5n5a1SrS1Dpa+L2D0Z7bIuW3Jd6HdaCxwwrb
         0+1yFPtCH70cPViosaWFtE2QDWI57k+pzDwmSyAEQHUiiTvB6FJaQBmFuJePHt0pLH8s
         vUkWcmr/j5oLTVY+LULR6SVUJVsBcHVJw3b/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbyYLzisYNN1lRqh22A2VNalz6OnIhJsVCaofVl30Uk=;
        b=sWZzcyiIrU3wNG+DWAxfH3UTlKuKdDsssbaEkMnPFxEn9vw127PIyFkEC1Yo3H9FTZ
         d8Nm1Tc163mCwquuJ1sgYFZTqRtjY2cpM+ULv7Da8xhuE7AIFF4OzLO3t4P0aCEBTMTA
         FS0FGiJDDnWe/VadhzwNhIgmw6GWvmC9IxfYL/OkooV33eI3MByz1vdSnHYMXzbMSVt+
         D+8N7xZzeQB1khzfL6eRjiSaLHLB10u7T6JGLaGqh+dCnMleKMg5HGANPACTq6jghE4Y
         qPuBm9Pmz6m/K8GXdTqujtq8bOeNDpUlQRZVNaWoA8+ut3EyaRrwtQYaOon0Tqhy8S5p
         owLQ==
X-Gm-Message-State: APjAAAVJj4pv6ZuRQQt9fBhBbu/WJzlFzzR1pzedSWG2vrOOY4dGK5q1
        4S0jx8/3PkzuWsi9kPg8/ardXm/zdfGTyQ==
X-Google-Smtp-Source: APXvYqynP1j05aqTn+aIGLWeBYoCg3UJ7ukIlXOVoQCK8Hd2KZGgF8aNlX5WLZwrtWpZ8OUCKzjEXA==
X-Received: by 2002:a50:d654:: with SMTP id c20mr23255221edj.206.1566188357622;
        Sun, 18 Aug 2019 21:19:17 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id n24sm1212971ejz.5.2019.08.18.21.19.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2019 21:19:16 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id p74so322648wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:19:16 -0700 (PDT)
X-Received: by 2002:a1c:cf88:: with SMTP id f130mr8561253wmg.10.1566188356079;
 Sun, 18 Aug 2019 21:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190725030602.GA13200@hari-Inspiron-1545> <20190725135007.33dc2cd3@collabora.com>
 <CAAFQd5AOCCoN1F=_WqQaMrttjotpNo7pc8irhkLQNy9C=WjC1A@mail.gmail.com>
In-Reply-To: <CAAFQd5AOCCoN1F=_WqQaMrttjotpNo7pc8irhkLQNy9C=WjC1A@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 19 Aug 2019 13:19:04 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D=5=2B_y1=z-+6O9R0ibijtmr4iff+xUGzNc8S1vEveQ@mail.gmail.com>
Message-ID: <CAAFQd5D=5=2B_y1=z-+6O9R0ibijtmr4iff+xUGzNc8S1vEveQ@mail.gmail.com>
Subject: Re: [PATCH] staging: media: hantro: Remove call to memset after dma_alloc_coherent
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        ZhiChao Yu <zhichao.yu@rock-chips.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 1:17 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Hans,
>
> On Thu, Jul 25, 2019 at 8:50 PM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Thu, 25 Jul 2019 08:36:02 +0530
> > Hariprasad Kelam <hariprasad.kelam@gmail.com> wrote:
> >
> > > fix below issue reported by coccicheck
> > > /drivers/staging/media/hantro/hantro_vp8.c:149:16-34: WARNING:
> > > dma_alloc_coherent use in aux_buf -> cpu already zeroes out memory,  so
> > > memset is not needed
> > >
> > > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> >
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> >
> > > ---
> > >  drivers/staging/media/hantro/hantro_vp8.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/media/hantro/hantro_vp8.c b/drivers/staging/media/hantro/hantro_vp8.c
> > > index 66c4533..363ddda 100644
> > > --- a/drivers/staging/media/hantro/hantro_vp8.c
> > > +++ b/drivers/staging/media/hantro/hantro_vp8.c
> > > @@ -151,8 +151,6 @@ int hantro_vp8_dec_init(struct hantro_ctx *ctx)
> > >       if (!aux_buf->cpu)
> > >               return -ENOMEM;
> > >
> > > -     memset(aux_buf->cpu, 0, aux_buf->size);
> > > -
> > >       /*
> > >        * Allocate probability table buffer,
> > >        * total 1208 bytes, 4K page is far enough.
> >
>
> Is this something you will pick to your tree?

Ah, sorry, this is already applied. Not sure why searching for it the
first time didn't show anything. I guess I need to start repeating my
searches by default. Sorry for the noise.

Best regards,
Tomasz
