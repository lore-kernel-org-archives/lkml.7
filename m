Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C25C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6970420878
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556236996;
	bh=3ROU5RWM8jrkNTvPremtjm6JOJdcA3x6BEPw06kkMr4=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=pAEHvQZeaeLU//PP6WB6qdUi9ItjEEcABK8CFNtLwiMs0eIEmkEnEvi8X8o1cP8HA
	 u1eLc4mPg+JBduhjmccJKcoGgMxKpFC6sgtIuro2zDcMTUGMzRPZ9sBuVdC8Ytjtm+
	 wACGlO56XELho4Y9NTm6oYNOlpekwM0s+EDDrIdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfDZADO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfDZADO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:03:14 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBDA32084F;
        Fri, 26 Apr 2019 00:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556236992;
        bh=3ROU5RWM8jrkNTvPremtjm6JOJdcA3x6BEPw06kkMr4=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=1jazwmzYvnSTNMU2xYXN1ijAypQZmc85tlfDU5cdp7Zclb9MRo6JGjJTOUB0zF49d
         YneLQoLo32UW7wxm7MoovLq6Uv2XBc6g7RQ8QPuYW0WOmvcqIh/HWZk0BtCoERBLYF
         4aVMe6Ll+6Tbh5+iKfRfGViWg7buVHLy+JJK6ggk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1556169264-31683-2-git-send-email-Anson.Huang@nxp.com>
References: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com> <1556169264-31683-2-git-send-email-Anson.Huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: imx: disable i.mx7ulp composite clock during initialization
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Message-ID: <155623699177.15276.12577395377027956830@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 17:03:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-04-24 22:19:12)
> i.MX7ULP peripheral clock ONLY allow parent/rate to be changed
> with clock gated, however, during clock tree initialization, the
> peripheral clock could be enabled by bootloader, but the prepare
> count in clock tree is still zero, so clock core driver will allow
> parent/rate changed even with CLK_SET_RATE_GATE/CLK_SET_PARENT_GATE

That's a bug. Can you send a patch to fix the core framework code to
fail an assigned rate or parent change if those flags are set? Or is
that because the core doesn't respect these flags when they're buried in
the middle of the clk tree and some rate or parent change comes in and
affects the middle of the tree that has the flag set on it?

> set, but the change will fail due to HW NOT allow parent/rate change
> with clock enabled. It will cause clock HW status mismatch with
> clock tree info and lead to function issue. Below is an example:
>=20
> usdhc0's pcc clock value is 0xC5000000 during kernel boot up, it
> means usdhc0 clock is enabled, its parent is APLL_PFD1. In DT file,
> the usdhc0 clock settings are as below:
>=20
> assigned-clocks =3D <&pcc2 IMX7ULP_CLK_USDHC0>;
> assigned-clock-parents =3D <&scg1 IMX7ULP_CLK_NIC1_DIV>;
>=20
> when kernel boot up, the clock tree info is as below, but the usdhc0
> PCC register is still 0xC5000000, which means its parent is still
> from APLL_PFD1, which is incorrect and cause usdhc0 NOT work.
>=20
> nic1_clk       2        2        0   176000000          0     0  50000
>     usdhc0       0        0        0   176000000          0     0  50000
>=20
> After making sure the peripheral clock is disabled during clock tree
> initialization, the usdhc0 is working, and this change is necessary
> for all i.MX7ULP peripheral clocks.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-composite-7ulp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-c=
omposite-7ulp.c
> index 060f860..1a05411 100644
> --- a/drivers/clk/imx/clk-composite-7ulp.c
> +++ b/drivers/clk/imx/clk-composite-7ulp.c
> @@ -32,6 +32,7 @@ struct clk_hw *imx7ulp_clk_composite(const char *name,
>         struct clk_gate *gate =3D NULL;
>         struct clk_mux *mux =3D NULL;
>         struct clk_hw *hw;
> +       u32 val;
> =20
>         if (mux_present) {
>                 mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
> @@ -70,6 +71,18 @@ struct clk_hw *imx7ulp_clk_composite(const char *name,
>                 gate_hw =3D &gate->hw;
>                 gate->reg =3D reg;
>                 gate->bit_idx =3D PCG_CGC_SHIFT;
> +               /*
> +                * make sure clock is gated during clock tree initializat=
ion,
> +                * the HW ONLY allow clock parent/rate changed with clock=
 gated,
> +                * during clock tree initialization, clocks could be enab=
led
> +                * by bootloader, so the HW status will mismatch with clo=
ck tree
> +                * prepare count, then clock core driver will allow paren=
t/rate
> +                * change since the prepare count is zero, but HW actually
> +                * prevent the parent/rate change due to the clock is ena=
bled.
> +                */

Is it OK to forcibly gate the clk like this at init time? If so, why
can't we force the clk off when we change the rate and then restore the
on state after changing the rate? That would be more "robust" than doing
it once here. Plus then we could remove the CLK_SET_RATE_GATE flag.

> +               val =3D readl_relaxed(reg);
> +               val &=3D ~(1 << PCG_CGC_SHIFT);
> +               writel_relaxed(val, reg);
>         }
> =20
