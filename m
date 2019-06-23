Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB998C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 19:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03F0205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561317416;
	bh=6JDucSZw1YglZ+Kvn1XvG/d7XRm8rtQU0pYzpt6juPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D+h+p89tmihVKLFidjmljlUhAZiq+B1rjHdgvB+kGlL2zbXPzKaAaIivp6xFqu+/j
	 Q2RCPWBnSaBX6bvnRJNQo/SrTO0baeqbAbyz3AiBwiH5Pl36dORBzKlvsEj75aRO4P
	 xrekpcjpCtX1XYxP+C3uqxvC7P0yafCmA9+I6IP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfFWTQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 15:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfFWTQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 15:16:55 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C1420656;
        Sun, 23 Jun 2019 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561317413;
        bh=6JDucSZw1YglZ+Kvn1XvG/d7XRm8rtQU0pYzpt6juPQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CgPUq7sAB/XO8qNar6PVGibgQKQdya1cBTNQIzBoYgFB2qjMHS9QfbpRzqC3/m5kG
         OyWlgC3LDdCBlN053kcq+D1tj4UrG6j4U59OKjyr98+U5nfZOMojlQLAXv4nBo04+r
         H9cm5qcsA6Ct10se9Ln3/pBQK07y8eU/9hU+49eU=
Received: by mail-lf1-f51.google.com with SMTP id d11so8439863lfb.4;
        Sun, 23 Jun 2019 12:16:53 -0700 (PDT)
X-Gm-Message-State: APjAAAXCozIVeGdHOLUGfcA1aoaPtJ5J28y5hjvo/qvKUTJgFFAjBmR5
        MBVuIMcoiGJ6hccUt3p/J04obKjeEm0fHWuIXJM=
X-Google-Smtp-Source: APXvYqxXWDrgM4m579DLxJ1WTUgWjKF7XpNZeubHja/pXAlMQf3hxn+h9Y9vADetzdK8SIjDbU+EfRUwHC82D+/8Bxw=
X-Received: by 2002:ac2:5601:: with SMTP id v1mr7937600lfd.106.1561317411913;
 Sun, 23 Jun 2019 12:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190621180208.25361-7-krzk@kernel.org> <20190622191838.29850-1-krzk@kernel.org>
 <CAGTfZH2g6E2pCEtqjfCd+PjEzjwc2AB75LXJfCeO+PcYLiLTUw@mail.gmail.com>
In-Reply-To: <CAGTfZH2g6E2pCEtqjfCd+PjEzjwc2AB75LXJfCeO+PcYLiLTUw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sun, 23 Jun 2019 21:16:40 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcFFY08R1H-DrrzX2BC3L8x4NPJTP7nDn9yixAvmaiF9Q@mail.gmail.com>
Message-ID: <CAJKOXPcFFY08R1H-DrrzX2BC3L8x4NPJTP7nDn9yixAvmaiF9Q@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable Panfrost and Lima drivers
To:     cwchoi00@gmail.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2019 at 06:31, Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> Hi Krzysztof,
>
> 2019=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 4:20,=
 Krzysztof Kozlowski <krzk@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
> >
> > Enable support for Mali GPU with Panfrost and Lima drivers for:
> > 1. Samsung Exynos5433 and Exynos7 (having Mali T760),
> > 2. Allwiner A64 and H5 (Mali 400/450).
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. Enable Lima driver
> > ---
> >  arch/arm64/configs/defconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index fbbc065415d4..3d31611368af 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -518,6 +518,8 @@ CONFIG_DRM_HISI_HIBMC=3Dm
> >  CONFIG_DRM_HISI_KIRIN=3Dm
> >  CONFIG_DRM_MESON=3Dm
> >  CONFIG_DRM_PL111=3Dm
> > +CONFIG_DRM_LIMA=3Dm
> > +CONFIG_DRM_PANFROST=3Dm
> >  CONFIG_FB=3Dy
> >  CONFIG_FB_MODE_HELPERS=3Dy
> >  CONFIG_BACKLIGHT_GENERIC=3Dm
> > @@ -718,7 +720,6 @@ CONFIG_ARCH_TEGRA_194_SOC=3Dy
> >  CONFIG_ARCH_K3_AM6_SOC=3Dy
> >  CONFIG_SOC_TI=3Dy
> >  CONFIG_TI_SCI_PM_DOMAINS=3Dy
> > -CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=3Dy
>
> Exynos5433-tm2 board support the exynos-bus device which
> used the simple_ondmenad governor of devfreq.
> Why do you remove this configuration from the defconfig?

It is selected by default by DRM_PANFROST. The difference is that
PANFROST selects it as module. The 'y' is chosen because of:
  SCSI_UFSHCD [=3Dy] && SCSI_LOWLEVEL [=3Dy] && SCSI [=3Dy] && SCSI_DMA [=
=3Dy]

Best regards,
Krzysztof
