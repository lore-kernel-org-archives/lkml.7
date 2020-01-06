Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190F8C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3F92072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfbOUFac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgAFK6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:58:02 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42316 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFK6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:58:01 -0500
Received: by mail-vs1-f67.google.com with SMTP id b79so31356330vsd.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 02:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iz48PIJknU2j/A4zRHc/Rgg36rOPCVo1fXVtuRuysh0=;
        b=RfbOUFacPPh2IC/QVAVcCcFV4ZIDaLQYpHmb1lF3qUmFz3qo7AOG5AtHg1TtJFXdke
         yLnJwxHe/6VGC/9EXUxJ+QjepIhJviuughwTLnXtgZ3DU8xg/sH8qXnZQqDPtCk06FFV
         BLWCwLB2l+8h1R1mncjklU5vwAryEVaF5tko/JFGnX3k5K8e+qY6P9/R5w2FsmczJyRj
         +9h5v5qZMABAbDKRBWy/Z2aKq8tDVTwYsPcJpRpJV4xFtOE/9DA5j6jI9BquVLv1jGWk
         ADKFJYxXEDqxJqm600HrfHOcQUwLyff0bhoKrC8uCW0b7lLlnFj4nYl+3au9/QLXXfQa
         q5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iz48PIJknU2j/A4zRHc/Rgg36rOPCVo1fXVtuRuysh0=;
        b=HmhWx1eJxbMftEfOU6/qoq7+cjHj0SSBnnQFiIVvzRdDbuwI2mfNPgKL4ja8XMAQwM
         YzbsCqR8mpDHIRqcuourKvkdJSV/iE4qTzFCnGmo8Z66Lg+OCIPM6zKofQu+fYAdGGBj
         KqCKLevO/J4CoM3Adk6fQ+YA/YghjD4C/5DBsVRHBuR/Rfjrq1GIIS02YaMgqLeakRfr
         AjOI2PSvHLPDCQNM5pEJVbRPEzi2kONQ/LyVnNMhSwGJC64MsKveiSTQJnJgrZZovcmC
         5vaNgjFgFMkdPfgoT25rD0N3u9wV4jrlGOyS0124sf0k+QrKLfFifiyLdLFx73UR9QRe
         T8EA==
X-Gm-Message-State: APjAAAWs2AiGB6lqz+RBJbsQaMpI8HshZvJowdVbJBzoG/i5mwhof3K/
        l0PDlsr8q9QXtJLMvrCvBev/I2rFE9Y9TldoZ7A=
X-Google-Smtp-Source: APXvYqzZYEYA6D40qqN8qfRYSNveoTvP+3l+AWVJQQU5FusthP8LMTWjWcFH4nhlUSEsQov459UNeISOmykUZ+o87LE=
X-Received: by 2002:a05:6102:535:: with SMTP id m21mr51039090vsa.95.1578308280617;
 Mon, 06 Jan 2020 02:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
 <20200102100230.420009-3-christian.gmeiner@gmail.com> <5cd1dc11df43d86d9db0dc2520de9b2e839ea7cc.camel@pengutronix.de>
In-Reply-To: <5cd1dc11df43d86d9db0dc2520de9b2e839ea7cc.camel@pengutronix.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 6 Jan 2020 11:57:49 +0100
Message-ID: <CAH9NwWddNNc+2rRsntm+_eYF0S9uwC0kTszpPysbzmkc4dNuNA@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/etnaviv: determine product, customer and eco id
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas

Am Mo., 6. Jan. 2020 um 11:03 Uhr schrieb Lucas Stach <l.stach@pengutronix.de>:
>
> On Do, 2020-01-02 at 11:02 +0100, Christian Gmeiner wrote:
> > They will be used for extended HWDB support. The eco id logic was taken
> > from galcore kernel driver sources.
> >
> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 17 +++++++++++++++++
> >  drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  6 +++---
> >  2 files changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > index d47d1a8e0219..253301be9e95 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > @@ -321,6 +321,18 @@ static void etnaviv_hw_specs(struct etnaviv_gpu *gpu)
> >               gpu->identity.varyings_count -= 1;
> >  }
> >
> > +static void etnaviv_hw_eco_id(struct etnaviv_gpu *gpu)
> > +{
> > +     const u32 chipDate = gpu_read(gpu, VIVS_HI_CHIP_DATE);
> > +     gpu->identity.eco_id = gpu_read(gpu, VIVS_HI_CHIP_ECO_ID);
> > +
> > +     if (etnaviv_is_model_rev(gpu, GC1000, 0x5037) && (chipDate == 0x20120617))
> > +             gpu->identity.eco_id = 1;
> > +
> > +     if (etnaviv_is_model_rev(gpu, GC320, 0x5303) && (chipDate == 0x20140511))
> > +             gpu->identity.eco_id = 1;
>
> I'm not sure if those two checks warrant a separate function. Maybe
> just place them besides the other ID fixups?
>

This is almost a 1:1 copy of _GetEcoID(..) but will try to move the fixups.


> > +}
> > +
> >  static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
> >  {
> >       u32 chipIdentity;
> > @@ -362,6 +374,8 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
> >                       }
> >               }
> >
> > +             gpu->identity.product_id = gpu_read(gpu, VIVS_HI_CHIP_PRODUCT_ID);
> > +
> >               /*
> >                * NXP likes to call the GPU on the i.MX6QP GC2000+, but in
> >                * reality it's just a re-branded GC3000. We can identify this
> > @@ -375,6 +389,9 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
> >               }
> >       }
> >
> > +     etnaviv_hw_eco_id(gpu);
> > +     gpu->identity.customer_id = gpu_read(gpu, VIVS_HI_CHIP_CUSTOMER_ID);
>
> I don't like this scattering of identity register reads. Please move
> all of those reads to the else clause where we currently read
> model/rev. I doubt that the customer ID register is available on the
> really early cores, that only have the VIVS_HI_CHIP_IDENTITY register.
>

There is feature bit for it: chipMinorFeatures5_HAS_PRODUCTID
Will change the code to make use of it. Shall I still put it in the
else clause then?

--
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
