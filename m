Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152C3C73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1043208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK7AxUoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfGIUaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:30:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39363 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfGIUaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:30:46 -0400
Received: by mail-oi1-f195.google.com with SMTP id m202so16396772oig.6;
        Tue, 09 Jul 2019 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzzhMIXkgjfY/3I8xNBuuzFKRaBW4WRzScdd/5mOmm8=;
        b=TK7AxUoPJ8Dp1bYwsCGbWOtglqsnbxpl+OsqficcEvLFcPrjduzrCyRFvtBGl1xr73
         qURoStNeMzxVIVm64zwh5TFdq9AsSUWUj4nLs77NBb97lBuPc+5RvLDo5bHdmHZEQdLM
         4BnivVI511PHSv6rb+gjX8zyi7OdBkFdHfR6lbALcvKx78W4lbNaoN59XlHuicbt7fbC
         slWnOxT4/3CPXM+Y8ob087puyLO3iPxUyWSzk8xl01WIq+U7kVDtqZ2LkxKZbcTznKwM
         d2mtxvLQtrnqSJ5YGcaVN7ZkU1jUK+MfLwg0qAkIym8QIVHlF9B+Nq/SflEE8mkVq7Cn
         uDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzzhMIXkgjfY/3I8xNBuuzFKRaBW4WRzScdd/5mOmm8=;
        b=ZKj4/q9wzaxTMWesDc5NLXcIqtKna/Y6U9xY0waVKgiXai+1ODSMkvE8IMFF+HQ3BJ
         DH1xlpZohq4tB3WvUzO1Y/dbLeE6aQwHc0OA5w+ksGMU5ici7suG0Fde9FMr/yPfFSwb
         FPPeqp8M7N4gksgu8dWZ74PxOh7RZZv5xaUDy7WCK8Jvrqri2uiE+lFQv3ngWUhrZqFN
         gTOsAxuDg+7F8Y6A9Dd9b737gjk0Pb0GsdoM2hHE6c6kLdCEkZM4PNYxz6vTced7ijSV
         5nakoKmXe+Kv6nZb5xVXXnajH2tc83D8BiJcXuLBwYnh/AL/7W2x6xhIJK4CoSnbPXXg
         8eIA==
X-Gm-Message-State: APjAAAW9A5tsipHMrjspk6GRAzgvFb8Ij+DAOtxPPvfwCRr9+35IklCd
        XcJL/FKMZGepbxSH5RoUbGgGuaESHbjzyC0GdA4=
X-Google-Smtp-Source: APXvYqxcnttgFG+ExJVZtKNgY/nJZ0LcoVm1wiyk2wRS4arEWWVemvY2rYVYYkQOuT1IpF4ima0OhtnS4WB0PchMdxE=
X-Received: by 2002:aca:b208:: with SMTP id b8mr1217173oif.98.1562704244691;
 Tue, 09 Jul 2019 13:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190605120237.ekmytfxcwbjaqy3x@flea> <E1hYsvP-0000PY-Pz@stardust.g4.wien.funkfeuer.at>
 <20190607062802.m5wslx3imiqooq5a@flea> <CGME20190607094103epcas1p4babbb11ec050974a62f2af79bc64d752@epcas1p4.samsung.com>
 <20190607094030.GA12373@lst.de> <66707fcc-b48e-02d3-5ed7-6b7e77d53266@samsung.com>
 <20190612152022.c3cfhp4cauhzhfyr@flea> <bb2c2c00-b46e-1984-088f-861ac8952331@samsung.com>
 <20190701095842.fvganvycce2cy7jn@flea> <CA+E=qVdsYV2Bxk245=Myq=otd7-7WHzUnSJN8_1dciAzvSOG8g@mail.gmail.com>
 <20190709085532.cdqv7whuesrjs64c@flea>
In-Reply-To: <20190709085532.cdqv7whuesrjs64c@flea>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 9 Jul 2019 13:30:18 -0700
Message-ID: <CA+E=qVdz4vfU3rtTTKjYdM+4UA+=FWheJfWOMaDtFMnWQ1rHbw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345 bridge
 on Teres-I
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>, Torsten Duwe <duwe@lst.de>,
        Harald Geyer <harald@ccbib.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 1:55 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Jul 08, 2019 at 05:49:21PM -0700, Vasily Khoruzhick wrote:
> > > > Maybe instead of edp-connector one would introduce integrator's specific
> > > > connector, for example with compatible "olimex,teres-edp-connector"
> > > > which should follow edp abstract connector rules? This will be at least
> > > > consistent with below presentation[1] - eDP requirements depends on
> > > > integrator. Then if olimex has standard way of dealing with panels
> > > > present in olimex/teres platforms the driver would then create
> > > > drm_panel/drm_connector/drm_bridge(?) according to these rules, I guess.
> > > > Anyway it still looks fishy for me :), maybe because I am not
> > > > familiarized with details of these platforms.
> > >
> > > That makes sense yes
> >
> > Actually, it makes no sense at all. Current implementation for anx6345
> > driver works fine as is with any panel specified assuming panel delays
> > are long enough for connected panel. It just doesn't use panel timings
> > from the driver. Creating a platform driver for connector itself looks
> > redundant since it can't be reused, it doesn't describe actual
> > hardware and it's just defeats purpose of DT by introducing
> > board-specific code.
>
> I'm not sure where you got the idea that the purpose of DT is to not
> have any board-specific code.

I believe DT was an attempt to move to declarative approach for
describing hardware. Yes, we have different compatibles for different
devices but they're specific to particular device rather than
particular board. Device interconnection is described in DT along with
some properties rather than in board-specific C-file. Introducing
board-specific compatible for a connector isn't looking right to me.

> It's perfectly fine to have some, that's even why there's a compatible
> assigned to each and every board.
>
> What the DT is about is allowing us to have a generic behaviour that
> we can detect: we can have a given behaviour for a given board, and a
> separate one for another one, and this will be evaluated at runtime.
>
> This is *exactly* what this is about: we can have a compatible that
> sets a given, more specific, behaviour (olimex,teres-edp-connector)
> while saying that this is compatible with the generic behaviour
> (edp-connector). That way, any OS will know what quirk to apply if
> needed, and if not that it can use the generic behaviour.
>
> And we could create a generic driver, for the generic behaviour if
> needed.
>
> > There's another issue: if we introduce edp-connector we'll have to
> > specify power up delays somewhere (in dts? or in platform driver?), so
> > edp-connector doesn't really solve the issue of multiple panels with
> > same motherboard.
>
> And that's what that compatible is about :)

Sorry, I fail to see how it would be different from using existing
panels infrastructure and different panels compatibles. I think Rob's
idea was to introduce generic edp-connector. If we can't make it
generic then let's use panel infrastructure.

> > I'd say DT overlays should be preferred solution here, not another
> > connector binding.
>
> Overlays are a way to apply a device tree dynamically. It's orthogonal
> to the binding.

It isn't orthogonal to original problem though.

> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
