Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E33C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F702087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYUgiQf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfEQWIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 18:08:35 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44363 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfEQWIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 18:08:35 -0400
Received: by mail-yw1-f67.google.com with SMTP id e74so3308370ywe.11;
        Fri, 17 May 2019 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jft35/5eu7LfpLWAoZ01uRn8po613JLoj7AyHoG1GXA=;
        b=NYUgiQf/XO3wfHvPfBK9JqBrKKj3Wmowkwt6/vjOgQkCDK/v6jvW0oo1OZnPmZfOd6
         gXIM2YU1dxM65gHmFxomQBCOUKQV3zVEh6vSfVBe+5Nw1XhNUuyzAv724hOrXXhgW8Cn
         VQkWNIdZVzet1VOC/zC6hyJHTH5bUEGREk5GN72T5tLuAz7M2PAc55Z2kxM6tQ5SMraJ
         VZtkn8qK6YLUjTu/4tr0kcNDMPH4zIjSprh5Iy1oYW+ZozjdEZzHGQPDCltQ3I55Bt0/
         elMkVF9psPDUj7MHeBzCfsRcjwvVTi/HiUpy5OLdflq0g+ead+zvm2UIv6NzBHoYmvym
         E5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jft35/5eu7LfpLWAoZ01uRn8po613JLoj7AyHoG1GXA=;
        b=HJG6RYc+r+RNFn+I7tG9g6zkSw2rH97d0ZQVNv69347sZnDdq/wLtiiOg34eDtPE4L
         Iu7pII45kz3vUZ9YGeICGU7w9I1L+JPdfOOqMxXPZwhvzdjxC1es6wFKgdbOyIQxQBI1
         KWP1kJpBeK50XBC6XemOtChkPufKVMqyBCfU5D2Fkue/h+Jl74lRdEs+AbO1iLLNrm/k
         hEk99Xs/WIWMa54zLkQn97gC5NBBhveP+yNDVUPkIhyYdCnnY8YzItrB7B/PhxRlMwgW
         01ubhrExSQC35D0MYzwBdxfOy5K/7U9zllooLFylTi1/jTze5ytYdHo5oeKeVcJyrQ91
         cEqQ==
X-Gm-Message-State: APjAAAUKFASb3mV1kbz5CRF0a277Xhm0rmFazvEbMszG4CbdwkIOtY/T
        NxoWOBFTwrbv8LVKUA49seFTaGN2M6d/SMi+W90=
X-Google-Smtp-Source: APXvYqxcSNmzU/oyHvSUYVr+deObwpxqKqFM5P2fsb0esZnQS0M5F0CXJpjeTYUlAVM4uj0CwId57+uwvLalM45wrhw=
X-Received: by 2002:a81:9a4b:: with SMTP id r72mr5190935ywg.422.1558130914303;
 Fri, 17 May 2019 15:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190517184659.18828-1-peron.clem@gmail.com> <20190517184659.18828-2-peron.clem@gmail.com>
 <CAL_JsqKPazGn+g1zS4NMwvQZ_6GcAm0tgcOTqyQA0dz0+2dp3g@mail.gmail.com>
In-Reply-To: <CAL_JsqKPazGn+g1zS4NMwvQZ_6GcAm0tgcOTqyQA0dz0+2dp3g@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 18 May 2019 00:08:22 +0200
Message-ID: <CAJiuCcdMxXAXYk=QpRwsvBUW0tvBVMqXvgx0Y7fAKP=ouyBnKQ@mail.gmail.com>
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

Hi Rob,

On Fri, 17 May 2019 at 22:07, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, May 17, 2019 at 1:47 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail=
.com> wrote:
> >
> > Allwinner H6 has an ARM Mali-T720 MP2 which required a bus_clock.
> >
> > Add an optional bus_clock at the init of the panfrost driver.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 25 +++++++++++++++++++++-
> >  drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
> >  2 files changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/d=
rm/panfrost/panfrost_device.c
> > index 3b2bced1b015..8da6e612d384 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -44,7 +44,8 @@ static int panfrost_clk_init(struct panfrost_device *=
pfdev)
> >
> >         pfdev->clock =3D devm_clk_get(pfdev->dev, NULL);
> >         if (IS_ERR(pfdev->clock)) {
> > -               dev_err(pfdev->dev, "get clock failed %ld\n", PTR_ERR(p=
fdev->clock));
> > +               dev_err(pfdev->dev, "get clock failed %ld\n",
> > +                       PTR_ERR(pfdev->clock));
>
> Please drop this whitespace change.

Sorry, I thought it was only a mistake here, I will drop it.
Why are they so many lines over 80 characters?
Is there a specific coding style to follow ?

Thanks,
Clement

>
> >                 return PTR_ERR(pfdev->clock);
> >         }
> >
