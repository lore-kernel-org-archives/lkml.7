Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFBEC4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 15:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0054A20867
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 15:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZao3rZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfJEPMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 11:12:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36178 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfJEPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 11:12:19 -0400
Received: by mail-qk1-f194.google.com with SMTP id y189so8697685qkc.3;
        Sat, 05 Oct 2019 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZkU1nwMPxx3l5vRolVMN1HMMcU6424u8M+B1Z8ZKR6U=;
        b=iZao3rZRmHTqHn5Thi4VJZ6EAlJ5X02uBmJ6cKTQGIDNOlLA4xvNWilW83PzgGyY2R
         jXXPeqrdKWCzz5Kb/Yyw5G+H1XrnPSXIJad+YC1iKj3iLiMUmDta7q0XMXFtalZYvDfD
         ijuKvLZwffbZnrJnKypSbJe+Y+sme967HvQRH/kFtZqYRbc3Kq+lpcVi/SHrs71/ylh1
         f6CBhz2t9w+JsjDssXuDPtWm+fBYYtnLV/gz3sWNDPo94Nw0LiGzVxeLZBZt3QXYgBsL
         oXuPpc9nLHqXkZs3jo+ZZSPyiMJ+zAUPnjFeE5z2+NFRV/4NeZgjQlA5+3x6OMGdh/7L
         4n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZkU1nwMPxx3l5vRolVMN1HMMcU6424u8M+B1Z8ZKR6U=;
        b=iekf9lcyqJas4Av90pwEK9lXbNkmcMYf20LUo5wMKemPvhBkTg9zG/IaaGbxUIMyKj
         h6UDIzK5H0HqS0jKZIEHbVdm9s0uDA1nvXyz6VKTS5UjDxUjt2YC5SqQf1FH5pHAzyF3
         YVFhTYP6AWY52DPGfwsruatQaZUuvWD8pOXlGmSy6r/FxvjmspYYTl/AbRBzVduiaQi4
         YTOZJCzd9cZQn2yb2w0iEarsWTzKLtlb67VjOVNx6paiXGg6AKpy+uD2AmwA2A00Y3Dz
         6RAyVFeTC40VJ7+5f2MoZtnhZQEtWP/61LgucW9sKLy5vsJ5JSFAsyh+Yrj1AElm23eS
         gApA==
X-Gm-Message-State: APjAAAUhjyvuT3fsH560s6Gvq65QuMKVvtu5bwdf+Ai/EeuvAOxQpeBG
        J+6MivMZzPh4Zx0vPxxT0j6Gw+6btFiGIoT5gU0=
X-Google-Smtp-Source: APXvYqyhv+e5AhbFRavmdvZfXY0A8BgW4saHVRfI5klCI+EE5RQk0Y0f/rXvq450pt3BhGKDa+9pvifA5oeMNvhL2nY=
X-Received: by 2002:a37:515:: with SMTP id 21mr15535656qkf.87.1570288338452;
 Sat, 05 Oct 2019 08:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190730172340.14037-1-digetx@gmail.com> <20190730172340.14037-3-digetx@gmail.com>
In-Reply-To: <20190730172340.14037-3-digetx@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 5 Oct 2019 11:12:07 -0400
Message-ID: <CAMdYzYq8YvzOnLnTbt5-=cBC8BGXN1pZnpPmcHyitGRs467zfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: tegra: Use WFE for power-gating on Tegra30
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ouya (tegra30) hard locks when the emc clock drops below 400mhz.
Discovered while testing the devfreq and emc drivers.
This patch resolves that issue.

Tested-by: Peter Geis <pgwipeout@gmail.com>

On Tue, Jul 30, 2019 at 2:10 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Turned out that WFI doesn't work reliably on Tegra30 as a trigger for
> the power-gating, it causes CPU hang under some circumstances like having
> memory controller running of PLLP. The TRM doc states that WFI should be
> used for the Big-Little "Cluster Switch", while WFE for the power-gating.
> Hence let's use the WFE for CPU0 power-gating, like it is done for the
> power-gating of a secondary cores. This fixes CPU hang after entering LP2
> with memory running off PLLP.
>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/sleep-tegra30.S |  4 +++-
>  drivers/soc/tegra/flowctrl.c        | 19 +++++++++++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
> index 6c28395d8c75..17f7a2a6a494 100644
> --- a/arch/arm/mach-tegra/sleep-tegra30.S
> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
> @@ -683,10 +683,12 @@ tegra30_enter_sleep:
>         dsb
>         ldr     r0, [r6, r2] /* memory barrier */
>
> +       cmp     r10, #TEGRA30
>  halted:
>         isb
>         dsb
> -       wfi     /* CPU should be power gated here */
> +       wfine   /* CPU should be power gated here */
> +       wfeeq
>
>         /* !!!FIXME!!! Implement halt failure handler */
>         b       halted
> diff --git a/drivers/soc/tegra/flowctrl.c b/drivers/soc/tegra/flowctrl.c
> index b6bdeef33db1..eb96a3086d6d 100644
> --- a/drivers/soc/tegra/flowctrl.c
> +++ b/drivers/soc/tegra/flowctrl.c
> @@ -91,8 +91,23 @@ void flowctrl_cpu_suspend_enter(unsigned int cpuid)
>                 reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
>                 /* clear wfi bitmap */
>                 reg &= ~TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP;
> -               /* pwr gating on wfi */
> -               reg |= TEGRA30_FLOW_CTRL_CSR_WFI_CPU0 << cpuid;
> +
> +               if (tegra_get_chip_id() == TEGRA30) {
> +                       /*
> +                        * The wfi doesn't work well on Tegra30 because
> +                        * CPU hangs under some odd circumstances after
> +                        * power-gating (like memory running off PLLP),
> +                        * hence use wfe that is working perfectly fine.
> +                        * Note that Tegra30 TRM doc clearly stands that
> +                        * wfi should be used for the "Cluster Switching",
> +                        * while wfe for the power-gating, just like it
> +                        * is done on Tegra20.
> +                        */
> +                       reg |= TEGRA20_FLOW_CTRL_CSR_WFE_CPU0 << cpuid;
> +               } else {
> +                       /* pwr gating on wfi */
> +                       reg |= TEGRA30_FLOW_CTRL_CSR_WFI_CPU0 << cpuid;
> +               }
>                 break;
>         }
>         reg |= FLOW_CTRL_CSR_INTR_FLAG;                 /* clear intr flag */
> --
> 2.22.0
>
