Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB665C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7487520679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561359419;
	bh=Wmle4DmUHAJz9qxbWxUuCO6gcEUZ8pGJ4hH7DvFoVHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0Nyw8/9sEUGrvpOCxPQWQ7xxe5jgIvbNmyxwb8Kb7uxNVevo9flUhNhEmJvwIfb78
	 7wXNRh8LP127ut8hhJaaiZi0pIa4NttKmjgJ11lrxhIhhUKbzntQei4QzKMuOf9MKp
	 eHEo/kYFSi/ivBSJio2TtWWZvxhwGSCrAWtcrTw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfFXG46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbfFXG46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:56:58 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 576DA214C6;
        Mon, 24 Jun 2019 06:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561359416;
        bh=Wmle4DmUHAJz9qxbWxUuCO6gcEUZ8pGJ4hH7DvFoVHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BZRSOZwnvbTtrhE5FdhMr78QW7zS+u3+C0+kDVKvvXlEFAAiAv1CYiZKFI/RWBEHU
         QoVnOObxJg0OyB7oKA4lV4pLeYu3bw7phQ8UCPWIM1UHlhqTZ2H/o6Yyso5RFhmLS3
         OSenBnmvuMdUNYsUcZbMIMdm0cGNQAhQZOtdbvN0=
Received: by mail-lj1-f174.google.com with SMTP id t28so11447948lje.9;
        Sun, 23 Jun 2019 23:56:56 -0700 (PDT)
X-Gm-Message-State: APjAAAWwPLU3Xh2dksv2ZowEWxqZ15csKExc5KAF7Px29UkA+E+SxTA9
        KJA0nUbdBP9Wfvc42eedj7hv+Uj5XsCXQ4BvB4I=
X-Google-Smtp-Source: APXvYqwuYsg0YtPp4HSVT4GsrVo3BqbfBMVGJw+z+cnqoCkDTdXplaaPso8EW7Ygbl0e07xoKBfuQzhZfcbiBsmYcXk=
X-Received: by 2002:a2e:12dc:: with SMTP id 89mr16648875ljs.40.1561359414533;
 Sun, 23 Jun 2019 23:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190621180208.25361-7-krzk@kernel.org> <20190622191838.29850-1-krzk@kernel.org>
 <CAGTfZH2g6E2pCEtqjfCd+PjEzjwc2AB75LXJfCeO+PcYLiLTUw@mail.gmail.com>
 <CGME20190623192007epcas4p2a3995bb00091b436562828fceb6ff790@epcas4p2.samsung.com>
 <CAJKOXPcFFY08R1H-DrrzX2BC3L8x4NPJTP7nDn9yixAvmaiF9Q@mail.gmail.com> <6edbe882-314c-85e1-4109-7c3b324dc7ab@samsung.com>
In-Reply-To: <6edbe882-314c-85e1-4109-7c3b324dc7ab@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 24 Jun 2019 08:56:43 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd6BRm+Hz363BhP8xr9dZ6jZxMQmaT7KuiEHAyZz-hDoQ@mail.gmail.com>
Message-ID: <CAJKOXPd6BRm+Hz363BhP8xr9dZ6jZxMQmaT7KuiEHAyZz-hDoQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable Panfrost and Lima drivers
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     cwchoi00@gmail.com, Catalin Marinas <catalin.marinas@arm.com>,
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
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 at 01:36, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> On 19. 6. 24. =EC=98=A4=EC=A0=84 4:16, Krzysztof Kozlowski wrote:
> > On Sun, 23 Jun 2019 at 06:31, Chanwoo Choi <cwchoi00@gmail.com> wrote:
> >>
> >> Hi Krzysztof,
> >>
> >> 2019=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 4:=
20, Krzysztof Kozlowski <krzk@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >>>
> >>> Enable support for Mali GPU with Panfrost and Lima drivers for:
> >>> 1. Samsung Exynos5433 and Exynos7 (having Mali T760),
> >>> 2. Allwiner A64 and H5 (Mali 400/450).
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>>
> >>> ---
> >>>
> >>> Changes since v1:
> >>> 1. Enable Lima driver
> >>> ---
> >>>  arch/arm64/configs/defconfig | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defcon=
fig
> >>> index fbbc065415d4..3d31611368af 100644
> >>> --- a/arch/arm64/configs/defconfig
> >>> +++ b/arch/arm64/configs/defconfig
> >>> @@ -518,6 +518,8 @@ CONFIG_DRM_HISI_HIBMC=3Dm
> >>>  CONFIG_DRM_HISI_KIRIN=3Dm
> >>>  CONFIG_DRM_MESON=3Dm
> >>>  CONFIG_DRM_PL111=3Dm
> >>> +CONFIG_DRM_LIMA=3Dm
> >>> +CONFIG_DRM_PANFROST=3Dm
> >>>  CONFIG_FB=3Dy
> >>>  CONFIG_FB_MODE_HELPERS=3Dy
> >>>  CONFIG_BACKLIGHT_GENERIC=3Dm
> >>> @@ -718,7 +720,6 @@ CONFIG_ARCH_TEGRA_194_SOC=3Dy
> >>>  CONFIG_ARCH_K3_AM6_SOC=3Dy
> >>>  CONFIG_SOC_TI=3Dy
> >>>  CONFIG_TI_SCI_PM_DOMAINS=3Dy
> >>> -CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=3Dy
> >>
> >> Exynos5433-tm2 board support the exynos-bus device which
> >> used the simple_ondmenad governor of devfreq.
> >> Why do you remove this configuration from the defconfig?
> >
> > It is selected by default by DRM_PANFROST. The difference is that
> > PANFROST selects it as module. The 'y' is chosen because of:
> >   SCSI_UFSHCD [=3Dy] && SCSI_LOWLEVEL [=3Dy] && SCSI [=3Dy] && SCSI_DMA=
 [=3Dy]
>
> When I tried to find the history of CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND
> for defconfig, the following patch[1] added this configuration.
> [1] b972ff75f2938c39e2205c23ea0e531d36b27f86
> - "arm64: defconfig: Enable UFS on msm8996"
>
> I think that this patch will affect the opration of 'USF on msm8998'.

Hi Chanwoo,

Thanks for the feedback. Unfortunately I do not see how removing a
dependency will affect that SCSI_UFSHCD. The
DEVFREQ_GOV_SIMPLE_ONDEMAND is still built in, exactly the same as
before...

Best regards,
Krzysztof
