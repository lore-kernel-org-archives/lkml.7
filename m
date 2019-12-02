Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAB3C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3E620717
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbQcHztO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLBPSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:18:15 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:38576 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfLBPSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:18:14 -0500
Received: by mail-il1-f195.google.com with SMTP id u17so33756442ilq.5;
        Mon, 02 Dec 2019 07:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UjeogKFi5KS3aQSbHG8R3fUmgd8lYS9MSCQDuVh2WvE=;
        b=lbQcHztOV2MzGE2/KhjJZaflYVbeXHPQxAJNZCKuilOJpGS/AL+QfBLYWsf5g0pPuQ
         R1tdBxUr12jiCk5jhml3Brom5a+22HYlwD0V6DMGhXnD9QzJVKjqICeUZNhtI+DRQr50
         zFAPz/L8DspLaKgjY+erR0pVe+6clAiGBomgAeaSmEpbXd4aGFX4GhZDvKBkVaU/V7hi
         dcbzHUG6JGUNBo5tPspZRAywNzIq5UlWSt/+PGhtOv2kVuLGbXg7XdoHwa2e+RmE6xkN
         bXeNX0iCQQ2HqrH5+JcIyNmi9SDrX6s7dUElLZvO2F7sxdqMBHoWfvPGO9qUuhlEfSgV
         09Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjeogKFi5KS3aQSbHG8R3fUmgd8lYS9MSCQDuVh2WvE=;
        b=ZQNnpmgjRKCiODpScXr92QNL+LpyhXE/6CV6ctseQLA0bPXVz8vQj/UK/n5IN0rLeS
         0da7BCbs0otPFWyEdG9mEOmg3L0FkdLpAWgl1flGW1FbslzO3LYopQWrnJPo3tIiFFD0
         XM/yfuOP8H353hdIdXV09bYoyTWbXKOdtiGArshAS2/XZxSp+cYYorbBdNtFhIXrUqYz
         +Ev11TdTGJU2YYKznqoksn3AWdrLRP9SOJvaVtU2GCbAXz9S2kBans9jp8xajnCTp4hm
         l/HUfxrRerNdqb1DK+dVfCm4dJnLvfAOD5gpAOS6CIY3zMOfCPH/nZmcHcjZxr0CBMQm
         pNKg==
X-Gm-Message-State: APjAAAWXkTr7G3uckLhE/TEdNBcsS8sEvPJjm0YKDmK6kkDZTbVTimsF
        F8ymJnfJ0SEGCcktesMLrk1JCI+ZFPW3QGIDll0=
X-Google-Smtp-Source: APXvYqwcnblataYwOUw2bbo0E9yr/M4cASJ9KZg0wuqkBi3i3JEubcxY6cy5v/gLNt/N/fKvvHvkkA2vlVSHpYRwLX0=
X-Received: by 2002:a92:1547:: with SMTP id v68mr24633087ilk.58.1575299892254;
 Mon, 02 Dec 2019 07:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20191129234108.12732-1-aford173@gmail.com> <3dff516c16dbb8c654293e16c49b4c59d29fd707.camel@pengutronix.de>
In-Reply-To: <3dff516c16dbb8c654293e16c49b4c59d29fd707.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 2 Dec 2019 09:17:59 -0600
Message-ID: <CAHCN7x+LLBci7BJNGHkoGK7Ljgn0NbVJKitv9vR+vonrO9r2tg@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: imx: gpcv2: Add support for imx8mm
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 8:28 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Fri, 2019-11-29 at 17:41 -0600, Adam Ford wrote:
> > The technical reference manual for both the i.MX8MQ and i.MX8M Mini
> > appear to show the same register definitions and locations for the
> > General Power Controller (GPC).
> >
> > This patch expands the table of compatible SoC's to include
> > the i.MX8m Mini
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > index b0dffb06c05d..67c54cbb6c81 100644
> > --- a/drivers/soc/imx/gpcv2.c
> > +++ b/drivers/soc/imx/gpcv2.c
> > @@ -641,6 +641,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
> >  static const struct of_device_id imx_gpcv2_dt_ids[] = {
> >       { .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
> >       { .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
> > +     { .compatible = "fsl,imx8mm-gpc", .data = &imx8m_pgc_domain_data, },
>
> According to the 5.2.5.1 "PGC power domains" chapters in both the i.MX
> 8M Dual/8M QuadLite/8M Quad and i.MX 8M Mini Applications Processor
> Reference Manuals (Rev.1), the two SoCs have a different list of power
> domains:

Shoot.  I needed to go further down in the table.  I stopped after the
first four.

Sorry for the noise.

adam
>
> i.MX8MQ:
>         PGC_C0
>         PGC_C1
>         PGC_C2
>         PGC_C3
>         PGC_SCU
>         PGC_MF
>         PGC_OTG1
>         PGC_OTG2
>         PGC_PCIE
>         PGC_MIPI
>         PGC_DDR1
>         PGC_DDR2
>         PGC_VPU
>         PGC_GPU
>         PGC_HDMI
>         PGC_DISP
>         PGC_MIPI_CSI1
>         PGC_MIPI_CSI2
>         PGC_PCIE2
>
> i.MX8MM:
>         PGC_C0
>         PGC_C1
>         PGC_C2
>         PGC_C3
>         PGC_SCU
>         PGC_NOC
>         PGC_PCIE
>         PGC_OTG1
>         PGC_OTG2
>         PGC_DDR1
>         PGC_DISPMIX
>         GPC_MIPI
>         PGC_GPUMIX
>         PGC_GPU_3D
>         PGC_GPU_2D
>         PGC_VPUMIX
>         PGC_VPU_G1
>         PGC_VPU_G2
>         PGC_VPU_H1
>
> regards
> Philipp
>
