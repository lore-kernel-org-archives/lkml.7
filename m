Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF4FC33C99
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 20:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874D52077B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578254416;
	bh=lwYHLf05sKcCVdLUCH2JXzQ3MgAvyUcSQT+vbpbmaAo=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=kuzYRc0FJfklgbIiRNkiKw9N8KJRdyxiG685z1ReMfITWUAbRMCRyVfIJsI5hsbLl
	 /j5ITOX8MTqk4YIdeNsE2XQp2hKChFjCH9OD21MsTs+BU4O7pCADbREzTuLLhadQTQ
	 NlsQgj225/kAm0Djap3sQrgspA7uGJF2O0KF81Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgAEUAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 15:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgAEUAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 15:00:15 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4904320678;
        Sun,  5 Jan 2020 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578254414;
        bh=lwYHLf05sKcCVdLUCH2JXzQ3MgAvyUcSQT+vbpbmaAo=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=qY3aprjtZjQVCAAxDJfvnctITRhhfl5W0ouZf0avGD0xHixzPcIDUiPz9Z/NjaKPc
         8hemFhtZHD3qiDaCJW19l7J2UHnAKmuVuMLWM8RLmuJDs8w2dtAhBcn6eJjbQbK+pt
         MFTyjSeNS4WTXxnSIOfNvJfD4viwE2pPdh2dxlBE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <55183b0a7c466528361802fabef65a57f969d07b.1574922435.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com> <55183b0a7c466528361802fabef65a57f969d07b.1574922435.git.shubhrajyoti.datta@xilinx.com>
Cc:     gregkh@linuxfoundation.org, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     devel@driverdev.osuosl.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, shubhrajyoti.datta@gmail.com
Subject: Re: [PATCH v3 07/10] clk: clock-wizard: Update the fixed factor divisors
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 12:00:13 -0800
Message-Id: <20200105200014.4904320678@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting shubhrajyoti.datta@gmail.com (2019-11-27 22:36:14)
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>=20
> Update the fixed factor clock registration to register the divisors.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/clk/clk-xlnx-clock-wizard.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-c=
lock-wizard.c
> index 4c6155b..75ea745 100644
> --- a/drivers/clk/clk-xlnx-clock-wizard.c
> +++ b/drivers/clk/clk-xlnx-clock-wizard.c
> @@ -491,9 +491,11 @@ static int clk_wzrd_probe(struct platform_device *pd=
ev)
>         u32 reg, reg_f, mult;
>         unsigned long rate;
>         const char *clk_name;
> +       void __iomem *ctrl_reg;
>         struct clk_wzrd *clk_wzrd;
>         struct resource *mem;
>         int outputs;
> +       unsigned long flags =3D 0;
>         struct device_node *np =3D pdev->dev.of_node;
> =20
>         clk_wzrd =3D devm_kzalloc(&pdev->dev, sizeof(*clk_wzrd), GFP_KERN=
EL);
> @@ -564,19 +566,22 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
>                 goto err_disable_clk;
>         }
> =20
> -       /* register div */
> -       reg =3D (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
> -                       WZRD_DIVCLK_DIVIDE_MASK) >> WZRD_DIVCLK_DIVIDE_SH=
IFT;
> +       outputs =3D of_property_count_strings(np, "clock-output-names");
> +       if (outputs =3D=3D 1)
> +               flags =3D CLK_SET_RATE_PARENT;

What does the number of clk outputs have to do with the ability to
change the rate of a parent clk? The commit text doesn't inform me of
what this is for either. Please help us understand.

>         clk_name =3D kasprintf(GFP_KERNEL, "%s_mul_div", dev_name(&pdev->=
dev));
>         if (!clk_name) {
>                 ret =3D -ENOMEM;
>                 goto err_rm_int_clk;
>         }
> =20
