Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D48C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E50207FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578376121;
	bh=beZTMdPPp2jWXKQD6/STikDCgpcO/mLfQp5aGJ6sHDA=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=MQlFoqoeDWgR7aSN1KwCj+E4qshG1uWTKlKhCgmrQXKUTQ9f8izDy8nXyC2DLx55L
	 irM4eak1yOxHg9FNJNDbkpoCSosQCzcDtrwvrXLO1xYQiB2hQNBmVbg1A3ctfD2ioK
	 CcFPvZ3sV7hcPuyPsw8JzKETWcuuwd8Bj9l/GIao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgAGFsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 00:48:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbgAGFsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 00:48:38 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB91F2075A;
        Tue,  7 Jan 2020 05:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578376118;
        bh=beZTMdPPp2jWXKQD6/STikDCgpcO/mLfQp5aGJ6sHDA=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=0KJuvIpRECR8mMSN2IPjzGA8Eb9Brsh2PCM9vpxD4VvkEKcDGjRjrTtGr82l9Nxn0
         8iJu+48oEGB06egRUxZxTVQfzjidP+aoFy4Wynsoxxbvcy9hgYWNsbpFaguyqOaxEb
         0FZJlrzoAV2GjB3lTdTh8PFNMZ2FjSKJXvto5y4I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191205115734.6987-1-mike.looijmans@topic.nl>
References: <20191205115734.6987-1-mike.looijmans@topic.nl>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Mike Looijmans <mike.looijmans@topic.nl>
To:     Mike Looijmans <mike.looijmans@topic.nl>, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk, clk-si5341: Support multiple input ports
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 21:48:37 -0800
Message-Id: <20200107054837.DB91F2075A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2019-12-05 03:57:34)
> The Si5341 and Si5340 have multiple input clock options. So far, the driv=
er
> only supported the XTAL input, this adds support for the three external
> clock inputs as well.
>=20
> If the clock chip is't programmed at boot, the driver will default to the

isn't

> XTAL input as before. If there is no "xtal" clock input available, it will
> pick the first connected input (e.g. "in0") as the input clock for the PL=
L.
> One can use clock-assigned-parents to select a particular clock as input.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

> diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
> index 6e780c2a9e6b..f7dba7698083 100644
> --- a/drivers/clk/clk-si5341.c
> +++ b/drivers/clk/clk-si5341.c
> @@ -4,7 +4,6 @@
>   * Copyright (C) 2019 Topic Embedded Products
>   * Author: Mike Looijmans <mike.looijmans@topic.nl>
>   */
> -
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>

I think we can do without this hunk.

> @@ -390,7 +410,112 @@ static unsigned long si5341_clk_recalc_rate(struct =
clk_hw *hw,
>         return (unsigned long)res;
>  }
> =20
> +static int si5341_clk_get_selected_input(struct clk_si5341 *data)
> +{
> +       int err;
> +       u32 val;
> +
> +       err =3D regmap_read(data->regmap, SI5341_IN_SEL, &val);
> +       if (err < 0)
> +               return err;
> +
> +       return (val & SI5341_IN_SEL_MASK) >> SI5341_IN_SEL_SHIFT;
> +}
> +
> +static unsigned char si5341_clk_get_parent(struct clk_hw *hw)

Please use u8 for now.

> +{
> +       struct clk_si5341 *data =3D to_clk_si5341(hw);
> +       int res =3D si5341_clk_get_selected_input(data);
> +
> +       if (res < 0)
> +               return 0; /* Apparently we cannot report errors */

For now this is the case. I'll rekick the series to convert this API to
a function that returns clk_hw pointers.
=20
> +
> +       return res;
> +}
> +
[...]
> @@ -985,7 +1110,8 @@ static const struct regmap_range si5341_regmap_volat=
ile_range[] =3D {
>         regmap_reg_range(0x000C, 0x0012), /* Status */
>         regmap_reg_range(0x001C, 0x001E), /* reset, finc/fdec */
>         regmap_reg_range(0x00E2, 0x00FE), /* NVM, interrupts, device read=
y */
> -       /* Update bits for synth config */
> +       /* Update bits for P divider and synth config */
> +       regmap_reg_range(SI5341_PX_UPD, SI5341_PX_UPD),
>         regmap_reg_range(SI5341_SYNTH_N_UPD(0), SI5341_SYNTH_N_UPD(0)),
>         regmap_reg_range(SI5341_SYNTH_N_UPD(1), SI5341_SYNTH_N_UPD(1)),
>         regmap_reg_range(SI5341_SYNTH_N_UPD(2), SI5341_SYNTH_N_UPD(2)),
> @@ -1122,6 +1248,7 @@ static int si5341_initialize_pll(struct clk_si5341 =
*data)
>         struct device_node *np =3D data->i2c_client->dev.of_node;
>         u32 m_num =3D 0;
>         u32 m_den =3D 0;
> +       int sel;
> =20
>         if (of_property_read_u32(np, "silabs,pll-m-num", &m_num)) {
>                 dev_err(&data->i2c_client->dev,
> @@ -1135,7 +1262,11 @@ static int si5341_initialize_pll(struct clk_si5341=
 *data)
>         if (!m_num || !m_den) {
>                 dev_err(&data->i2c_client->dev,
>                         "PLL configuration invalid, assume 14GHz\n");
> -               m_den =3D clk_get_rate(data->pxtal) / 10;
> +               sel =3D si5341_clk_get_selected_input(data);
> +               if (sel < 0)
> +                       return sel;
> +
> +               m_den =3D clk_get_rate(data->input_clk[sel]) / 10;
>                 m_num =3D 1400000000;
>         }
> =20
> @@ -1143,11 +1274,52 @@ static int si5341_initialize_pll(struct clk_si534=
1 *data)
>                         SI5341_PLL_M_NUM, m_num, m_den);
>  }
> =20
> +static int si5341_clk_select_active_input(struct clk_si5341 *data)
> +{
> +       int res;
> +       int err;
> +       int i;
> +
> +       res =3D si5341_clk_get_selected_input(data);
> +       if (res < 0)
> +               return res;
> +
> +       /* If the current register setting is invalid, pick the first inp=
ut */
> +       if (!data->input_clk[res]) {
> +               dev_dbg(&data->i2c_client->dev,
> +                       "Input %d not connected, rerouting\n", res);
> +               res =3D -ENODEV;
> +               for (i =3D 0; i < SI5341_NUM_INPUTS; ++i) {
> +                       if (data->input_clk[i]) {
> +                               res =3D i;
> +                               break;
> +                       }
> +               }
> +               if (res < 0) {

What if res is =3D=3D SI5341_NUM_INPUTS?

> +                       dev_err(&data->i2c_client->dev,
> +                               "No clock input available\n");
> +                       return res;
> +               }
> +       }
> +
> +       /* Make sure the selected clock is also enabled and routed */
> +       err =3D si5341_clk_reparent(data, res);
> +       if (err < 0)
> +               return err;
> +
> +       err =3D clk_prepare_enable(data->input_clk[res]);

Is it possible to do this setup and configuration stuff when the clk is
prepared by something? Maybe I've asked this before but I'd prefer that
this driver is a clk provider and not a clk consumer. If some default
setup needs to be done, preferably do that via direct register writes or
by calling the clk_ops functions directly instead of going through the
framework, preferably before registering the clks to the framework.

> +       if (err < 0)
> +               return err;
> +
> +       return res;
> +}
> +
