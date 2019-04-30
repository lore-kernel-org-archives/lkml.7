Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB16C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5504121734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556648211;
	bh=KUP9To48LBrL/wSVFz97QuNsX4v6nv2LPPjDnJTFTzs=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=GUOB0lhOfkaKYWxkDVpEBg7DXirs/xSvGr/dRG47a9wpN+zvYinDwNIFXb7khwiHa
	 8laRGVqO48VEH73W4j1/YPC9CkS4om0lsZk7InGqU8r0N4tTvPcD3mwnKYMc2QaPbY
	 bhFUyzKXJxOvC8V5mxL9dMbOY+9yo/rgXfYNTZLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfD3SQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfD3SQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:16:49 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAC4020854;
        Tue, 30 Apr 2019 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556648209;
        bh=KUP9To48LBrL/wSVFz97QuNsX4v6nv2LPPjDnJTFTzs=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=RfQo/QhbXFzOkMCGW4mgeoJJ9DWbf6F9XwqhCTWMsjWOf8pNLcXWWgD4iJwX7UGsU
         9zZ88Iiz+XS/r2ZYMvemxxajdMosAmc40YHvq6AEnpoCRpN3lxYzUgo1BfrT/c5u40
         6Sz3plrXV89dJ/2NRKfMCWBbeuDZPORX7av8ZeEU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1556589033-6080-1-git-send-email-Anson.Huang@nxp.com>
References: <1556589033-6080-1-git-send-email-Anson.Huang@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: imx: pllv3: Fix fall through build warning
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Message-ID: <155664820799.168659.12393223246835475198@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 30 Apr 2019 11:16:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-04-29 18:55:18)
> Fix below fall through build warning:
>=20
> drivers/clk/imx/clk-pllv3.c:453:21: warning:
> this statement may fall through [-Wimplicit-fallthrough=3D]
>=20
>    pll->denom_offset =3D PLL_IMX7_DENOM_OFFSET;
>                      ^
> drivers/clk/imx/clk-pllv3.c:454:2: note: here
>   case IMX_PLLV3_AV:
>   ^~~~
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Gustavo says there are two warnings. Please compile test with the right
options, add Reported-by tags when you get bug reports from someone, and
add a Fixes tag and then resend.

>  drivers/clk/imx/clk-pllv3.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index e892b9a..fbe4fe0 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -451,6 +451,7 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, c=
onst char *name,
>         case IMX_PLLV3_AV_IMX7:
>                 pll->num_offset =3D PLL_IMX7_NUM_OFFSET;
>                 pll->denom_offset =3D PLL_IMX7_DENOM_OFFSET;
> +               /* fall through */
>         case IMX_PLLV3_AV:
>                 ops =3D &clk_pllv3_av_ops;
>                 break;
