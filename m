Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F428C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194D0206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfHMLIK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 07:08:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33990 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfHMLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 07:08:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id q4so8714330qtp.1;
        Tue, 13 Aug 2019 04:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HIB1FeBMw0kT4n5nY36MOBb0YBcd6Z0mN5e+AnqNyZE=;
        b=Q1pNtWm9MySi0GsL8tUlHO3WqXtgAR2LGls4H1Rt9LTiEml8z9Hm/2s773AjHRBknF
         17SOHd5/LTRnudOc1zqfML1XFS2M8zmDksKe3+HjyD18GYN17XHg53UTXh0ZVlw7xH61
         UzEkiC4v9Etkj3/I0dIBnNz4+qt3+S5AYI7HNRnGR23hCgscSzx+R7lrogyojCmUrXvA
         TgYYaqEbuPOCDF10X3Uz5jkQubzeexU/Cy0ibakKlGNqdxFevTkSMAStf7ZazFtOZsJm
         AbQo4w938wkGdGMlxvOgBAHGXoa2oxVVF4HHoTmEYdFB4yjFX0XVGQ+wN9ykMCDObMg+
         aMyw==
X-Gm-Message-State: APjAAAWuFt8vNJCHvBR0BlxV0oiHO4yZ1tQZWmztezbdZGEdICGhcPmj
        vaIPsoRVLLuR0KTWfAIrBTEiERdOVpOARylvIdo=
X-Google-Smtp-Source: APXvYqx/nZIPgpCg9fJQAkQukfWpNlMRwI/isdIkz0cHDQdJwM+9xSo+AwlCQhvXJshxqmstDvAO0AUSd3UXwUs7kpw=
X-Received: by 2002:ad4:53cb:: with SMTP id k11mr1250357qvv.93.1565694488565;
 Tue, 13 Aug 2019 04:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565367567.git.agx@sigxcpu.org> <e0562d8bb4098dc4cdb4023b41fb75b312be22a5.1565367567.git.agx@sigxcpu.org>
 <CAK8P3a3Vrd+sttJrQwD-jA9p_egG4x-hc41eGK8H-_aVm-uoYw@mail.gmail.com> <20190813101057.GB10751@bogon.m.sigxcpu.org>
In-Reply-To: <20190813101057.GB10751@bogon.m.sigxcpu.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 13 Aug 2019 13:07:52 +0200
Message-ID: <CAK8P3a1q9G8VKgNKh+6khzoW3bFTVR_Zorygy=Qqsq-PYzM4=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: imx8mq: add imx8mq iomux-gpr field defines
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:10 PM Guido Günther <agx@sigxcpu.org> wrote:
> On Tue, Aug 13, 2019 at 10:08:44AM +0200, Arnd Bergmann wrote:
> > On Fri, Aug 9, 2019 at 6:24 PM Guido Günther <agx@sigxcpu.org> wrote:
> > >
> > > This adds all the gpr registers and the define needed for selecting
> > > the input source in the imx-nwl drm bridge.
> > >
> > > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > > +
> > > +#define IOMUXC_GPR0    0x00
> > > +#define IOMUXC_GPR1    0x04
> > > +#define IOMUXC_GPR2    0x08
> > > +#define IOMUXC_GPR3    0x0c
> > > +#define IOMUXC_GPR4    0x10
> > > +#define IOMUXC_GPR5    0x14
> > > +#define IOMUXC_GPR6    0x18
> > > +#define IOMUXC_GPR7    0x1c
> > (more of the same)
> >
> > huh?
>
> These are the names from the imx8MQ reference manual (general purpose
> registers, they lump together all sorts of things), it's the same on
> imx6/imx7):
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mfd/syscon/imx7-iomuxc-gpr.h
>
> > > +/* i.MX8Mq iomux gpr register field defines */
> > > +#define IMX8MQ_GPR13_MIPI_MUX_SEL              BIT(2)
> >
> > I think this define should probably be local to the pinctrl driver, to
> > ensure that no other drivers fiddle with the registers manually.
>
> The purpose of these bits is for a driver to fiddle with them to select
> the input source. Similar on imx7 it's already used for e.g. the phy
> refclk in the pci controller:
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-imx6.c#n638

That one should likely use either the clk interface or the phy
interface instead.

> The GPRs are not about pad configuration but gather all sorts of things
> (section 8.2.4 of the imx8mq reference manual): pcie setup, dsi related
> bits so I don't think this should be done via a pinctrl
> driver. Should we handle that differently than on imx6/7?

It would be nice to fix the existing code as well, but for the moment,
I only think we should not add more of that.

Generally speaking, we can use syscon to do random things that don't
have a subsystem of their own, but we should not use it to do things
that have an existing driver framework like pinctrl, clock, reset, phy
etc.

       Arnd
