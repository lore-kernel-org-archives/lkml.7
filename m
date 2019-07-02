Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A90C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C5820673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MyF13COg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfGCBip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:38:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35408 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCBip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:38:45 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so983863ioo.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6suCIUcpnxYWLx0u7rAt8YHu7DyHRein/0Ku8MDeQrw=;
        b=MyF13COg8Z9CREi9V7uwtNZ+RQgUSogpyqwer+wxMaRNlPvmTJ3LJUiyv1bRH2HNg4
         UdgEbOWphL591zLtGdaR5I4Nw4e1exGSG3CgmWGSsfGiRRfTC+NEd9mUTlTTIUs2/NJT
         WoMG2zeqsWqlC36tyRgV6MVFaOJ16SDyDjBSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6suCIUcpnxYWLx0u7rAt8YHu7DyHRein/0Ku8MDeQrw=;
        b=umceEBeWRpWtgTwzq/V/mB9gTzxufegaYM1roJg1UrQE8ekJbnbPazi97sjoKVEGhn
         kUvW013YuigEvMMYZ6chUtG+Y+JvIR9KSzphzd0d88zVJzQgRiljVOTqIKtyz/2m+LCF
         /0BCFVc8Kp8I5Fgl3qa6hFrZq8upj0Hd8TfGDOf/4wVj9fqJzfhE7odaxfi9kV+JmOGv
         ZjaWHs3BrsRsStDBmrVwXTLYWYLiLw8GhSnp3gRG5hM9w/P4IVlIrzb7wQJiOu5aFiqO
         OK0XhuhwR9+Bg8hdA7locCdviEJuLoucAl6Gu+OuAY56R1643gvJADKnKGyDb8AdsJEL
         tcnA==
X-Gm-Message-State: APjAAAUfOy7De9oQ91a1Eqj8nkYDKvL1dBMhIlhnk6WOvRq2URwt0ovN
        VIn+CBV+XfJ37gaEy6VA6hsiDHWpaSk=
X-Google-Smtp-Source: APXvYqxpp+RbiG4RcZlcjAd1nMPu+AxAuSfrv1D4ATudL59rLZmxlsIEaF2BrujpyBWLPbafH9nQdA==
X-Received: by 2002:a02:ba14:: with SMTP id z20mr36289734jan.14.1562098479416;
        Tue, 02 Jul 2019 13:14:39 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id y17sm13118250ioa.40.2019.07.02.13.14.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 13:14:38 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id h6so40207718ioh.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 13:14:37 -0700 (PDT)
X-Received: by 2002:a02:aa1d:: with SMTP id r29mr15652512jam.127.1562098477589;
 Tue, 02 Jul 2019 13:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190621211346.1324-1-ezequiel@collabora.com> <3c68bf286d8b75ac339df0eab43d276667e073c2.camel@collabora.com>
In-Reply-To: <3c68bf286d8b75ac339df0eab43d276667e073c2.camel@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Jul 2019 13:14:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UK3bpyvvFQtsvUtWHun_bfxb25R0bLyg=WJz+yHz5kvg@mail.gmail.com>
Message-ID: <CAD=FV=UK3bpyvvFQtsvUtWHun_bfxb25R0bLyg=WJz+yHz5kvg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] RK3288 Gamma LUT
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 2, 2019 at 4:26 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Hi Heiko,
>
> On Fri, 2019-06-21 at 18:13 -0300, Ezequiel Garcia wrote:
> > Let's support Gamma LUT configuration on RK3288 SoCs.
> >
> > In order to do so, this series adds a new and optional
> > address resource.
> >
> > A separate address resource is required because on this RK3288,
> > the LUT address is after the MMU address, which is requested
> > by the iommu driver. This prevents the DRM driver
> > from requesting an entire register space.
> >
> > The current implementation works for RGB 10-bit tables, as that
> > is what seems to work on RK3288.
> >
> > This has been tested on a Rock2 Square board, using
> > a hacked 'modetest' tool, with legacy and atomic APIs.
> >
> > Thanks,
> > Eze
> >
> > Changes from v1:
> > * drop explicit linear LUT after finding a proper
> >   way to disable gamma correction.
> > * avoid setting gamma is the CRTC is not active.
> > * s/int/unsigned int as suggested by Jacopo.
> > * only enable color management and set gamma size
> >   if gamma LUT is supported, suggested by Doug.
> > * drop the reg-names usage, and instead just use indexed reg
> >   specifiers, suggested by Doug.
> >
> > Changes from RFC:
> > * Request (an optional) address resource for the LUT.
> > * Add devicetree changes.
> > * Drop support for RK3399, which doesn't seem to work
> >   out of the box and needs more research.
> > * Support pass-thru setting when GAMMA_LUT is NULL.
> > * Add a check for the gamma size, as suggested by Ilia.
> > * Move gamma setting to atomic_commit_tail, as pointed
> >   out by Jacopo/Laurent, is the correct way.
> >
> > Ezequiel Garcia (3):
> >   dt-bindings: display: rockchip: document VOP gamma LUT address
> >   drm/rockchip: Add optional support for CRTC gamma LUT
> >   ARM: dts: rockchip: Add RK3288 VOP gamma LUT address
> >
> >  .../display/rockchip/rockchip-vop.txt         |   6 +-
> >  arch/arm/boot/dts/rk3288.dtsi                 |   4 +-
> >  drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |   3 +
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c   | 114 ++++++++++++++++++
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.h   |   7 ++
> >  drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |   2 +
> >  6 files changed, 133 insertions(+), 3 deletions(-)

I will note that I can confirm that the "gamma_test" app present on
Chrome OS can be shown to work with this series, both on eDP and HDMI.
I see a nice shiny RGB pattern on the screen.  Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>
