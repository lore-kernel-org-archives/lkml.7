Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC37C432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 03:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5652068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 03:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf9gX9S3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLDDm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 22:42:26 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:44818 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfLDDmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 22:42:25 -0500
Received: by mail-il1-f193.google.com with SMTP id z12so5327157iln.11;
        Tue, 03 Dec 2019 19:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExIWnawdKF70agAdo5JVD422cp6pCtZ9lw7kUZGa1FU=;
        b=Cf9gX9S3qrLYmV7m/6SHzqliu6YENpTGUyUE4pX1i7bs8EJlZxtNPkQ5dzY98CQjsM
         Fum1blKgKPNts6/635cpTig9uePC1/vFL6y8M6jVhtZ5d6kmWnw6NFdFY1dEGWTqBjgL
         md1E2i7PTA5dM+JV+Zy9ske5zDyEeGl57Wr/xoFdu5tmEhef2j63pfBGPc59EWhZ6ZvQ
         4lYQtrQ/rCsCMxVNEwUrw4hlVIRoOQF2bYaCW9CMCMhbjeU3pYjq+Fwj+uQNCe5FglIo
         aNSKif3Dp7/wF8AQjgNzfSTPv997Pwj75MX8FUJALQMu1LVGJtUHXJ7CKXAYseFIYGd+
         AzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExIWnawdKF70agAdo5JVD422cp6pCtZ9lw7kUZGa1FU=;
        b=i9a2mywLxACurB1P5j9wOQTz34wUJRD+lmjj7GdD74iAKALlNzSBe6JIPIlm9Qy7Vs
         PAsLY4zoOkMf+zNQ5651frpInY5UZ5ryvIIbeVYDl/OGU9V6rHnY94wsLe0hRRFWbd7f
         ibEhlexoH5Mntjq+e3QLsVAzw4NlMNFzy4DQPJcmWhPpWfl7PF+MD9JAbAUcEtrynlMW
         azOk5+/gKt3S0xT0PMqgmc/4uz6xHTUzlvyDDxQoDcYxsGkQNDGj13JGZ+wg0ZlxZR4R
         pTbOPn1pstanngR91lo31ijpFijU5AgwIHZl6OZNl6F7zUmUUwxUFwtp2gzywSNFHqj6
         47sw==
X-Gm-Message-State: APjAAAW5rX5LkBp1nM+3E6AAomqteaQ6Hg796vyFbo3GFYX4TNHB1LFY
        dBbbppZK6dAHrVkYjmj0+lREj5RZbmaW18ijjL4=
X-Google-Smtp-Source: APXvYqyxQ5jL8sVwLhQNqvFEVB6V+hXobWVcBj6xjKMw4Rz99e0kASbdfNa05PQQF4hckZkfqLCxmT7mOOeoFFlzuoU=
X-Received: by 2002:a05:6e02:c2c:: with SMTP id q12mr1620093ilg.205.1575430944433;
 Tue, 03 Dec 2019 19:42:24 -0800 (PST)
MIME-Version: 1.0
References: <20191129234108.12732-1-aford173@gmail.com> <3dff516c16dbb8c654293e16c49b4c59d29fd707.camel@pengutronix.de>
 <CAHCN7x+LLBci7BJNGHkoGK7Ljgn0NbVJKitv9vR+vonrO9r2tg@mail.gmail.com>
In-Reply-To: <CAHCN7x+LLBci7BJNGHkoGK7Ljgn0NbVJKitv9vR+vonrO9r2tg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 3 Dec 2019 21:42:13 -0600
Message-ID: <CAHCN7xLZt4QVZgH9zwZYprmmYyhVN=d7zc9-PUPdknOErwPX2g@mail.gmail.com>
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

On Mon, Dec 2, 2019 at 9:17 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Mon, Dec 2, 2019 at 8:28 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> >
> > On Fri, 2019-11-29 at 17:41 -0600, Adam Ford wrote:
> > > The technical reference manual for both the i.MX8MQ and i.MX8M Mini
> > > appear to show the same register definitions and locations for the
> > > General Power Controller (GPC).
> > >
> > > This patch expands the table of compatible SoC's to include
> > > the i.MX8m Mini
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> > > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > > index b0dffb06c05d..67c54cbb6c81 100644
> > > --- a/drivers/soc/imx/gpcv2.c
> > > +++ b/drivers/soc/imx/gpcv2.c
> > > @@ -641,6 +641,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
> > >  static const struct of_device_id imx_gpcv2_dt_ids[] = {
> > >       { .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
> > >       { .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
> > > +     { .compatible = "fsl,imx8mm-gpc", .data = &imx8m_pgc_domain_data, },
> >
> > According to the 5.2.5.1 "PGC power domains" chapters in both the i.MX
> > 8M Dual/8M QuadLite/8M Quad and i.MX 8M Mini Applications Processor
> > Reference Manuals (Rev.1), the two SoCs have a different list of power
> > domains:
>
> Shoot.  I needed to go further down in the table.  I stopped after the
> first four.
>
> Sorry for the noise.
>
> adam
> >
> > i.MX8MQ:
> >         PGC_C0
> >         PGC_C1
> >         PGC_C2
> >         PGC_C3
> >         PGC_SCU
> >         PGC_MF
> >         PGC_OTG1
> >         PGC_OTG2
> >         PGC_PCIE
> >         PGC_MIPI
> >         PGC_DDR1
> >         PGC_DDR2
> >         PGC_VPU
> >         PGC_GPU
> >         PGC_HDMI
> >         PGC_DISP
> >         PGC_MIPI_CSI1
> >         PGC_MIPI_CSI2
> >         PGC_PCIE2
> >
> > i.MX8MM:
> >         PGC_C0
> >         PGC_C1
> >         PGC_C2
> >         PGC_C3
> >         PGC_SCU
> >         PGC_NOC
> >         PGC_PCIE
> >         PGC_OTG1
> >         PGC_OTG2
> >         PGC_DDR1
> >         PGC_DISPMIX
> >         GPC_MIPI
> >         PGC_GPUMIX
> >         PGC_GPU_3D
> >         PGC_GPU_2D
> >         PGC_VPUMIX
> >         PGC_VPU_G1
> >         PGC_VPU_G2
> >         PGC_VPU_H1
Philipp,

Thanks for reviewing it and catching my mistake.

I went though the datasheet more thoroughly, and I think I have the
table correct for the i.MX8M Mini.  With that and a small tweak to the
OTG nodes, I was able to use USB OTG1 and OTG2 ports.

I am going to submit a V2 fix tomorrow after I clean it up.  I'll do a
multi-part series where part 1 is the GPC, part 2 will be the OTG
updates, and if I get more peripherals working, I'll add them as
additional parts to the series.

adam
> >
> > regards
> > Philipp
> >
