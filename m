Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0F0C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C9120B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556899442;
	bh=u8nMHEbZWJcIno8b2VP0zq26Pj+DlJZJ6b1N7AkLZGs=;
	h=In-Reply-To:References:To:Cc:From:Subject:Date:List-ID:From;
	b=FXkOGzm2LA8JlZgxIpWsZ799iVcYzUwANOobNqXkmdyJ5BIi4RT8JSAVaWBoaN5oC
	 ln/RB12WYz4NGRo99o3U/vyV4wN76yfOI6S0rXMFoRs0E+jpbK4Q0v7H8ST7m4U0wk
	 /7jBqoJiGeoex8xLngmI2tLMBhTxTpgUsIdtnwgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfECQEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfECQEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:04:00 -0400
Received: from localhost (unknown [104.132.0.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EBE32087F;
        Fri,  3 May 2019 16:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556899440;
        bh=u8nMHEbZWJcIno8b2VP0zq26Pj+DlJZJ6b1N7AkLZGs=;
        h=In-Reply-To:References:To:Cc:From:Subject:Date:From;
        b=TD5d3cqye9lABfgNnSbABLKv5dC1suwdjX/scpb6aAPmD8sQ4qpHuYG/hdBsDeru7
         BWClVjMxXIJhOIA6VGsgOr+AZy2t3xgbd9ClZ8eRiulq6SFD3llwWT2Ncg+ulC4Bmy
         SRdIpHHDC2g2g5HIypFN9DW97CkTgy1i2hqmoVK8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190430143206.GA4035@embeddedor>
References: <20190430143206.GA4035@embeddedor>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: imx: clk-pllv3: mark expected switch fall-throughs
Message-ID: <155689943924.200842.14239421795559565409@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 03 May 2019 09:03:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2019-04-30 07:32:06)
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>=20
> This patch fixes the following warnings:
>=20
> drivers/clk/imx/clk-pllv3.c: In function =E2=80=98imx_clk_pllv3=E2=80=99:
> drivers/clk/imx/clk-pllv3.c:446:18: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>    pll->div_shift =3D 1;
>    ~~~~~~~~~~~~~~~^~~
> drivers/clk/imx/clk-pllv3.c:447:2: note: here
>   case IMX_PLLV3_USB:
>   ^~~~
> drivers/clk/imx/clk-pllv3.c:453:21: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>    pll->denom_offset =3D PLL_IMX7_DENOM_OFFSET;
>                      ^
> drivers/clk/imx/clk-pllv3.c:454:2: note: here
>   case IMX_PLLV3_AV:
>   ^~~~
>=20
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>=20
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Applied to clk-next

