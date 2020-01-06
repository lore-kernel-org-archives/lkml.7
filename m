Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB1CC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9602071A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/3kQwdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAFLka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 06:40:30 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40501 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFLk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:40:29 -0500
Received: by mail-ua1-f68.google.com with SMTP id z24so11585782uam.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 03:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQQaQG+AfXGj+Me2z6DyEv2JkQjyKmIl3bRQbolFe1o=;
        b=p/3kQwdYgtdlg1Os6Dci9lDS2z6w0R6zDWSmBg6T5FzjjaAEGbtILr2ByFyBtXlu2X
         y1ZPwJgJZPcy8SS3iwlNTITYTOoYCk9KgIPsW/ZxexHYLQxyQYbX8CzMsCY4JmFWvsjl
         wr2stfKPxV+k+JXteIJ+iVb3/JcICbol7ToO+0ZSMRuQImeLHX+i+/lpVLeSBwPv7auj
         Hk4WdSrOD5Yk0bXiytAgx/zpUwqOocgksGqpPr9DQXKWDtO6H1R06z2Tc5Y5q/6C/rZw
         WRuL+A2cY/lPMhGNjeHdGUG/GgaWynnKuOnRXcKHKGkR/6iMld/AQMsHAn+cpB6bSiZr
         WczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQQaQG+AfXGj+Me2z6DyEv2JkQjyKmIl3bRQbolFe1o=;
        b=j8EWa9m6r/O1KAVzBX4vQQRNX2GIMr3fnBrRczELKSaw/TstCMakH6rj1bZmy0DmqG
         rpNQonaPBbfjHHJ/IqyKBd2NsI3nrwcgJAWg45WJ9RnmbPQ/S/DZ6mWPsxcD1PL2uuBT
         qrnLkIAZfUNoVjul1ZfrD6v4nJx3lVXdLWPwUzkGou8PM4L7+LoKCu0Xy8PwF1+nNxKP
         mLU2i6nuagmE7PUNa0FG7pt67ObiB8nabZ9a4Yu5IdMsLSV4nSKFJeIlqvUcm52E7n5C
         NY6S07QveBe7M1IKCkCfgPaNsly155TJKyMMijwcSVmEslfL2PMf/+zJ9wpQVhua39U3
         R8tA==
X-Gm-Message-State: APjAAAVRwNfDOAuz8ulLm2dLkGgIvK9mb2jxHVOvxYa1UCpudVbetySW
        a6nThQknN35Tm8CPgtEce1nq+AfLYE5XrIojFR4=
X-Google-Smtp-Source: APXvYqyARdYJ0Kv1+Q19Ys5V5NIUzl/nDmV8rlIGXvTTdimxNf06lz1HDqT5HBc5YnWk46mVryIwSq7M5NQ1lRFYgao=
X-Received: by 2002:ab0:74ce:: with SMTP id f14mr58376764uaq.118.1578310828234;
 Mon, 06 Jan 2020 03:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
 <20200102100230.420009-3-christian.gmeiner@gmail.com> <5cd1dc11df43d86d9db0dc2520de9b2e839ea7cc.camel@pengutronix.de>
 <CAH9NwWddNNc+2rRsntm+_eYF0S9uwC0kTszpPysbzmkc4dNuNA@mail.gmail.com> <191213c32908a217cf78590464c9b9519865f3e0.camel@pengutronix.de>
In-Reply-To: <191213c32908a217cf78590464c9b9519865f3e0.camel@pengutronix.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 6 Jan 2020 12:40:18 +0100
Message-ID: <CAH9NwWc-M2TvPGnDY5d_aWxrtrb+SZZOObd9KSAAzN+K7WMpOg@mail.gmail.com>
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

Am Mo., 6. Jan. 2020 um 12:22 Uhr schrieb Lucas Stach <l.stach@pengutronix.de>:
>
> On Mo, 2020-01-06 at 11:57 +0100, Christian Gmeiner wrote:
> > Hi Lucas
> >
> > Am Mo., 6. Jan. 2020 um 11:03 Uhr schrieb Lucas Stach <l.stach@pengutronix.de>:
> > > On Do, 2020-01-02 at 11:02 +0100, Christian Gmeiner wrote:
> > > > They will be used for extended HWDB support. The eco id logic was taken
> > > > from galcore kernel driver sources.
> > > >
> > > > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 17 +++++++++++++++++
> > > >  drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  6 +++---
> > > >  2 files changed, 20 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > > > index d47d1a8e0219..253301be9e95 100644
> > > > --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > > > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > > > @@ -321,6 +321,18 @@ static void etnaviv_hw_specs(struct etnaviv_gpu *gpu)
> > > >               gpu->identity.varyings_count -= 1;
> > > >  }
> > > >
> > > > +static void etnaviv_hw_eco_id(struct etnaviv_gpu *gpu)
> > > > +{
> > > > +     const u32 chipDate = gpu_read(gpu, VIVS_HI_CHIP_DATE);
> > > > +     gpu->identity.eco_id = gpu_read(gpu, VIVS_HI_CHIP_ECO_ID);
> > > > +
> > > > +     if (etnaviv_is_model_rev(gpu, GC1000, 0x5037) && (chipDate == 0x20120617))
> > > > +             gpu->identity.eco_id = 1;
> > > > +
> > > > +     if (etnaviv_is_model_rev(gpu, GC320, 0x5303) && (chipDate == 0x20140511))
> > > > +             gpu->identity.eco_id = 1;
> > >
> > > I'm not sure if those two checks warrant a separate function. Maybe
> > > just place them besides the other ID fixups?
> > >
> >
> > This is almost a 1:1 copy of _GetEcoID(..) but will try to move the fixups.
> >
> >
> > > > +}
> > > > +
> > > >  static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
> > > >  {
> > > >       u32 chipIdentity;
> > > > @@ -362,6 +374,8 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
> > > >                       }
> > > >               }
> > > >
> > > > +             gpu->identity.product_id = gpu_read(gpu, VIVS_HI_CHIP_PRODUCT_ID);
> > > > +
> > > >               /*
> > > >                * NXP likes to call the GPU on the i.MX6QP GC2000+, but in
> > > >                * reality it's just a re-branded GC3000. We can identify this
> > > > @@ -375,6 +389,9 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
> > > >               }
> > > >       }
> > > >
> > > > +     etnaviv_hw_eco_id(gpu);
> > > > +     gpu->identity.customer_id = gpu_read(gpu, VIVS_HI_CHIP_CUSTOMER_ID);
> > >
> > > I don't like this scattering of identity register reads. Please move
> > > all of those reads to the else clause where we currently read
> > > model/rev. I doubt that the customer ID register is available on the
> > > really early cores, that only have the VIVS_HI_CHIP_IDENTITY register.
> > >
> >
> > There is feature bit for it: chipMinorFeatures5_HAS_PRODUCTID
> > Will change the code to make use of it. Shall I still put it in the
> > else clause then?
>
> If there's a feature bit we need to move the read toward the end of the
> function, as we currently read the features as the last step in the
> hw_identify.
>
> But then I'm not sure if the HAS_PRODUCTID feature bit is correct. At
> least wumpus' gpus_comparison says that none of the known <= GC3000
> cores has it set, which seems... suspicious.
>

Hmm... what if I just mimic what is done here?
https://github.com/etnaviv/vivante_kernel_drivers/blob/master/imx8_v6.2.3.129602/hal/kernel/arch/gc_hal_kernel_hardware.c#L220

Unconditionally read the product id at the end of the else clause. The
same is done in the stm32 galcore kernel driver.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
