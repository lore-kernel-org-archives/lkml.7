Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38629C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D370205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561495184;
	bh=j3KZFviB5Xle6qBDzGdMd3VNiDKlu0Os1FHRxXh+iWE=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=Uvo2wVxRhQZlygb1kXdkh9w8cJvphA+ZnZDnWrcyiaRMjwZJZ0AfAzY9++nuwMxKv
	 g/3magzLfYCMzSJI/zNTSn1F174Qxb842beNeHTLbB3hxDDAyiXE2EqXg9SBsa1oNG
	 +Isu6PBQNZP5gJyyO1e2OsAMW4tJHw6+iflt0zWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfFYUjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfFYUjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:39:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15C94205ED;
        Tue, 25 Jun 2019 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561495181;
        bh=j3KZFviB5Xle6qBDzGdMd3VNiDKlu0Os1FHRxXh+iWE=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=xUFoVMMARF1CYfZ3FYmhyNeW9XHtmic9ocPCrbnTXm90L1w97pfhFjGEWr55wLxa4
         ROSkUwmC8AKfCd63ZqTeQh1+ic2CEJIeGW/yM8H0Y67yBEdMYOnvEOkCOISqoh0h6t
         tfDb3nBB6leXGBqFZc1m+hvKt4/dzPM7a92iMM+c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1561373672-3533-1-git-send-email-abel.vesa@nxp.com>
References: <1561373672-3533-1-git-send-email-abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: imx8mm: Switch to platform driver
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 13:39:40 -0700
Message-Id: <20190625203941.15C94205ED@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-06-24 03:54:32)
> In order to make the clock provider a platform driver
> all the data and code needs to be outside of .init section.

Yes, but why are you making this change in general?

>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
[...]
> @@ -480,7 +481,7 @@ static int __init imx8mm_clocks_init(struct device_no=
de *ccm_node)
>         clks[IMX8MM_SYS_PLL2_500M] =3D imx_clk_fixed_factor("sys_pll2_500=
m", "sys_pll2_out", 1, 2);
>         clks[IMX8MM_SYS_PLL2_1000M] =3D imx_clk_fixed_factor("sys_pll2_10=
00m", "sys_pll2_out", 1, 1);
> =20
> -       np =3D ccm_node;
> +       np =3D dev->of_node;
>         base =3D of_iomap(np, 0);

If we're using platform device here it would be nice to also use
platform device APIs to map memory and request resources, etc.

>         if (WARN_ON(!base))
>                 return -ENOMEM;
> @@ -682,4 +683,19 @@ static int __init imx8mm_clocks_init(struct device_n=
ode *ccm_node)
> =20
>         return 0;
>  }
> -CLK_OF_DECLARE_DRIVER(imx8mm, "fsl,imx8mm-ccm", imx8mm_clocks_init);
> +
> +static const struct of_device_id imx8mm_clk_of_match[] =3D {
> +       { .compatible =3D "fsl,imx8mm-ccm" },
> +       { /* Sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, imx8mm_clk_of_match);
> +
> +

Nitpick: Drop the second newline.

> +static struct platform_driver imx8mm_clk_driver =3D {
> +       .probe =3D imx8mm_clocks_probe,
> +       .driver =3D {
> +               .name =3D "imx8mm-ccm",
> +               .of_match_table =3D of_match_ptr(imx8mm_clk_of_match),
> +       },
> +};
> +module_platform_driver(imx8mm_clk_driver);
