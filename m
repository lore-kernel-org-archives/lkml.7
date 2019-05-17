Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834F0C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1972087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558131424;
	bh=Ub9ywDgQMywBRcVcnaiqdLyL6nucWm3LLTrW2H19UiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Cdbc1tddTL6n2IRLeCDl5yIJkc2XQpj8nCZ00AGlmbSJUYb37OTiz0cdQDVtbqB2O
	 nlA0l1GguQ9cRMFSMEZ2yPPGZG8iXFDanlCisa15kDZsb9efCCyO8sLVNJ6JvN7rJD
	 +iEEPPB+7oBp0UzUt5HP6ReJK0F9V+8LwhzpLyn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfEQWRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 18:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfEQWRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 18:17:03 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F802133D;
        Fri, 17 May 2019 22:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558131422;
        bh=Ub9ywDgQMywBRcVcnaiqdLyL6nucWm3LLTrW2H19UiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GlQ47fjelVwOIBUNPfQPVtZRplhCOXFbklJArqlwOt3X8cNAekcwtl4ovf9ekowFT
         rxpRgSRuXfWsJi3oreP7IxF7trBEOA8EwhrlnBkfayec6e1QgrAOOIVTLxn0iIO7Tg
         lW21oFAasHZtJPuV4K/PqeO4ZKdt5jwVfXM6iDII=
Received: by mail-qt1-f172.google.com with SMTP id f24so9770819qtk.11;
        Fri, 17 May 2019 15:17:01 -0700 (PDT)
X-Gm-Message-State: APjAAAWs12YD0TAKhS1vcYqytWDB44ZwOAv75Ufigd6cxwEK08IOrV/p
        rojSumpPCUdihhcbhu/G6G2HOGHs9kAFhtSn3Q==
X-Google-Smtp-Source: APXvYqwEyGCXsMdPpd1yKLh5mRTBHM7bqH+ylSdbW3LBM0kM6/GbLYmB3yx3l3fr7fSVgCiND3V4w1ysUhkmpeQirXM=
X-Received: by 2002:a0c:8aad:: with SMTP id 42mr48554064qvv.200.1558131421268;
 Fri, 17 May 2019 15:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190517184659.18828-1-peron.clem@gmail.com> <20190517184659.18828-2-peron.clem@gmail.com>
 <CAL_JsqKPazGn+g1zS4NMwvQZ_6GcAm0tgcOTqyQA0dz0+2dp3g@mail.gmail.com> <CAJiuCcdMxXAXYk=QpRwsvBUW0tvBVMqXvgx0Y7fAKP=ouyBnKQ@mail.gmail.com>
In-Reply-To: <CAJiuCcdMxXAXYk=QpRwsvBUW0tvBVMqXvgx0Y7fAKP=ouyBnKQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 May 2019 17:16:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJgo8NpK00ApBcdtYGW24yuqU=4EMna+r_07=dqceZyyg@mail.gmail.com>
Message-ID: <CAL_JsqJgo8NpK00ApBcdtYGW24yuqU=4EMna+r_07=dqceZyyg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] drm: panfrost: add optional bus_clock
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
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

On Fri, May 17, 2019 at 5:08 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
>
> Hi Rob,
>
> On Fri, 17 May 2019 at 22:07, Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Fri, May 17, 2019 at 1:47 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@gma=
il.com> wrote:
> > >
> > > Allwinner H6 has an ARM Mali-T720 MP2 which required a bus_clock.
> > >
> > > Add an optional bus_clock at the init of the panfrost driver.
> > >
> > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > ---
> > >  drivers/gpu/drm/panfrost/panfrost_device.c | 25 ++++++++++++++++++++=
+-
> > >  drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
> > >  2 files changed, 25 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu=
/drm/panfrost/panfrost_device.c
> > > index 3b2bced1b015..8da6e612d384 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > > @@ -44,7 +44,8 @@ static int panfrost_clk_init(struct panfrost_device=
 *pfdev)
> > >
> > >         pfdev->clock =3D devm_clk_get(pfdev->dev, NULL);
> > >         if (IS_ERR(pfdev->clock)) {
> > > -               dev_err(pfdev->dev, "get clock failed %ld\n", PTR_ERR=
(pfdev->clock));
> > > +               dev_err(pfdev->dev, "get clock failed %ld\n",
> > > +                       PTR_ERR(pfdev->clock));
> >
> > Please drop this whitespace change.
>
> Sorry, I thought it was only a mistake here, I will drop it.
> Why are they so many lines over 80 characters?

I'd guess most are prints and/or just slightly over.

> Is there a specific coding style to follow ?

Yes, but generally the 80 character thing is more a guidance. Not
having unrelated changes in a single commit is more of a hard rule.

Rob
