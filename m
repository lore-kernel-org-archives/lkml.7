Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722B4C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 14:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BA020833
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 14:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdfBwGcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfEROp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 10:45:28 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42752 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfEROp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 10:45:28 -0400
Received: by mail-yb1-f194.google.com with SMTP id a21so3838208ybg.9;
        Sat, 18 May 2019 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=77OQ/lkmsml6JIGkNy6mI1RRxZHIM2FsvrIfk0LDVxY=;
        b=AdfBwGcWiRp4t6iFzrle+NFQHOHvRbIYZrm7PG3CY9l5UcF25lNq5vlnLeAfP2591b
         G/yZTVDvUCuwq4ZxuLok25gP1xkPMFYYLWfKQ1D9Ehx09f3Lhk6tXhAU3tQNo083NFB8
         qnyP08CcF7XzMcjiJclm7q90np3/pNgT8uzZYfUzrqk6hfmiYU292fvtjB5dyI2OHe86
         4GGnQgRt88WUNSzckjwnDrhZlDw8p47U/U1Idw1JUZ0BjkFWXKO5HM9IUQsLOkKeXyrT
         rr809uMQ85jA3zuC2J0S6ZMZJ4KwFrgUE/dPyY8t8Eo+S/Z9710uagbZD2xSt4Cp5RP2
         WJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=77OQ/lkmsml6JIGkNy6mI1RRxZHIM2FsvrIfk0LDVxY=;
        b=LQFCN3kcByUkb+li26Gj4cswAl49delbDK4OC33UN47mlk6c4e7wS4wMOKl4SAN9ED
         DKPSvxTtpNCfWpIHhrpMgCWeEYNeSTtDbm/nAgy+ANf22lBJfcibP0wfX4LJCGCRlCp6
         pQUgiFyuSPfAZCN65yfEtg4iWtVN6H9fmp8qoFvnTqkcSN/77OsvHylvjVxRh/Kekbwl
         /Z/RC06zVSkPefv+agEKwlSE8p8tnAicCb9S6NCi/Uos+MHt5czLR0rJhk7cLX9Yyx8m
         O+rqljijDjJ/Mw3yxmFUcUiYPRalxEaykoXLKFlnaD06GVrLlZtDgJn8ve8IvURnUc96
         J0bQ==
X-Gm-Message-State: APjAAAW/BT86biHLmpVTD/S2UVwkLbRNy3cxV0F7FFSvfUIXEyAfADKi
        jxa+BgAdOJ7YHaDkmNNt+p0odO5mCEENXA/JJxi1ZVlhXCM=
X-Google-Smtp-Source: APXvYqz8Ud0fDXY9JxGkS+dy5NJLMTqLdeb9pIIxVKprfYnVIb0d0/+pRo/C+qYP+AaKVJMDPptDy2GlVYMckN6N6oE=
X-Received: by 2002:a25:b10f:: with SMTP id g15mr10782445ybj.82.1558190727257;
 Sat, 18 May 2019 07:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190517184659.18828-1-peron.clem@gmail.com> <20190517184659.18828-2-peron.clem@gmail.com>
 <CAL_JsqKPazGn+g1zS4NMwvQZ_6GcAm0tgcOTqyQA0dz0+2dp3g@mail.gmail.com>
 <CAJiuCcdMxXAXYk=QpRwsvBUW0tvBVMqXvgx0Y7fAKP=ouyBnKQ@mail.gmail.com> <CAL_JsqJgo8NpK00ApBcdtYGW24yuqU=4EMna+r_07=dqceZyyg@mail.gmail.com>
In-Reply-To: <CAL_JsqJgo8NpK00ApBcdtYGW24yuqU=4EMna+r_07=dqceZyyg@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 18 May 2019 16:45:10 +0200
Message-ID: <CAJiuCcfjEqS8BdYdwD22W4hhD27TTs7DPsiEErF_Xt+5Gdkewg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] drm: panfrost: add optional bus_clock
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 18 May 2019 at 00:17, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, May 17, 2019 at 5:08 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail=
.com> wrote:
> >
> > Hi Rob,
> >
> > On Fri, 17 May 2019 at 22:07, Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Fri, May 17, 2019 at 1:47 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@g=
mail.com> wrote:
> > > >
> > > > Allwinner H6 has an ARM Mali-T720 MP2 which required a bus_clock.
> > > >
> > > > Add an optional bus_clock at the init of the panfrost driver.
> > > >
> > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/panfrost/panfrost_device.c | 25 ++++++++++++++++++=
+++-
> > > >  drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
> > > >  2 files changed, 25 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/g=
pu/drm/panfrost/panfrost_device.c
> > > > index 3b2bced1b015..8da6e612d384 100644
> > > > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > @@ -44,7 +44,8 @@ static int panfrost_clk_init(struct panfrost_devi=
ce *pfdev)
> > > >
> > > >         pfdev->clock =3D devm_clk_get(pfdev->dev, NULL);
> > > >         if (IS_ERR(pfdev->clock)) {
> > > > -               dev_err(pfdev->dev, "get clock failed %ld\n", PTR_E=
RR(pfdev->clock));
> > > > +               dev_err(pfdev->dev, "get clock failed %ld\n",
> > > > +                       PTR_ERR(pfdev->clock));
> > >
> > > Please drop this whitespace change.
> >
> > Sorry, I thought it was only a mistake here, I will drop it.
> > Why are they so many lines over 80 characters?
>
> I'd guess most are prints and/or just slightly over.
>
> > Is there a specific coding style to follow ?
>
> Yes, but generally the 80 character thing is more a guidance. Not
> having unrelated changes in a single commit is more of a hard rule.

Ok, thanks for the clarification.

Cl=C3=A9ment

>
> Rob
