Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F70DC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A54208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561494715;
	bh=PhNXcpudBmWa/NVa9dShnW6rshjSaaf0Do+2ljruiAI=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=ar1TD8zLZLs2WxRL47rneTItJ7AUUvqPqoIQx0aXgH+oEQOd2veSV1j49fg1bWqOI
	 EVC96RwvdHsMjubT5mIgDy28MI4l1rNvgOe5G4DYSqRsaeXeVxmNBdRg4hMNEun9mU
	 qt6hUe2jEhmAyekuiVB2hWKqIqYJQ/ADI6GVIHUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfFYUbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfFYUbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:31:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6060B208CB;
        Tue, 25 Jun 2019 20:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561494712;
        bh=PhNXcpudBmWa/NVa9dShnW6rshjSaaf0Do+2ljruiAI=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=GU5ThImRJH8AROMqBLKE+k1fn6AEaAgbB3CzxWCYNgzR0oUGpOKyPyeC11e76VA0n
         hSABmFfwS0F9YPJT85+0jvUTSx/w0bxJONeY2SqV/EBdufjAvJBQ6pW/cD++zBNnC2
         M3dCioW3RObardaTUQ1BYk0xEkjKbGRr/1V/LsjA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190620150013.13462-8-narmstrong@baylibre.com>
References: <20190620150013.13462-1-narmstrong@baylibre.com> <20190620150013.13462-8-narmstrong@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC/RFT 07/14] clk: meson: g12a: add notifiers to handle cpu clock change
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        Neil Armstrong <narmstrong@baylibre.com>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 13:31:51 -0700
Message-Id: <20190625203152.6060B208CB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Armstrong (2019-06-20 08:00:06)
> In order to implement clock switching for the CLKID_CPU_CLK and
> CLKID_CPUB_CLK, notifiers are added on specific points of the
> clock tree :
>=20
> cpu_clk / cpub_clk
> |   \- cpu_clk_dyn
> |      |  \- cpu_clk_premux0
> |      |        |- cpu_clk_postmux0
> |      |        |    |- cpu_clk_dyn0_div
> |      |        |    \- xtal/fclk_div2/fclk_div3
> |      |        \- xtal/fclk_div2/fclk_div3
> |      \- cpu_clk_premux1
> |            |- cpu_clk_postmux1
> |            |    |- cpu_clk_dyn1_div
> |            |    \- xtal/fclk_div2/fclk_div3
> |            \- xtal/fclk_div2/fclk_div3
> \ sys_pll / sys1_pll
>=20
> This for each cluster, a single one for G12A, two for G12B.
>=20
> Each cpu_clk_premux1 tree is marked as read-only and CLK_SET_RATE_NO_REPA=
RENT,
> to be used as "parking" clock in a safe clock frequency.
>=20
> A notifier is added on each cpu_clk_premux0 to detech when CCF want to
> change the frequency of the cpu_clk_dyn tree.
> In this notifier, the cpu_clk_premux1 tree is configured to use the xtal
> clock and then the cpu_clk_dyn is switch to cpu_clk_premux1 while CCF
> updates the cpu_clk_premux0 tree.
>=20
> A notifier is added on each sys_pll/sys1_pll to detect when CCF wants to
> change the PLL clock source of the cpu_clk.
> In this notifier, the cpu_clk is switched to cpu_clk_dyn while CCF
> updates the sys_pll/sys1_pll frequency.
>=20
> A third small notifier is added on each cpu_clk / cpub_clk and cpu_clk_dy=
n,
> add a small delay at PRE_RATE_CHANGE/POST_RATE_CHANGE to let the other
> notofiers change propagate before changing the cpu_clk_premux0 and sys_pll
> clock trees.
>=20
> This notifier set permits switching the cpu_clk / cpub_clk without any
> glitches and using a safe parking clock while switching between sub-GHz
> clocks using the cpu_clk_dyn tree.
>=20
> This setup has been tested and validated on the Amlogic G12A and G12B
> SoCs running the arm64 cpuburn at [1] and cycling between all the possible
> cpufreq translations of each cluster and checking the final frequency usi=
ng
> the clock-measurer, script at [2].
>=20
> [1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
> [2] https://gist.github.com/superna9999/d4de964dbc0f84b7d527e1df2ddea25f
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
[...]
> @@ -418,6 +458,35 @@ static struct clk_regmap g12b_cpub_clk_premux0 =3D {
>         },
>  };
> =20
> +/* This divider uses bit 26 to take change in account */
> +static int g12b_cpub_clk_mux0_div_set_rate(struct clk_hw *hw, unsigned l=
ong rate,
> +                                         unsigned long parent_rate)
> +{
> +       struct clk_regmap *clk =3D to_clk_regmap(hw);
> +       struct clk_regmap_div_data *div =3D clk_get_regmap_div_data(clk);
> +       unsigned int val;
> +       int ret;
> +
> +       ret =3D divider_get_val(rate, parent_rate, div->table, div->width,
> +                             div->flags);
> +       if (ret < 0)
> +               return ret;
> +
> +       val =3D (unsigned int)ret << div->shift;
> +
> +       regmap_update_bits(clk->map, HHI_SYS_CPUB_CLK_CNTL,
> +                          SYS_CPU_DYN_ENABLE, SYS_CPU_DYN_ENABLE);
> +
> +       return regmap_update_bits(clk->map, div->offset,
> +                                 clk_div_mask(div->width) << div->shift =
| SYS_CPU_DYN_ENABLE, val);
> +};
> +
> +const struct clk_ops g12b_cpub_clk_mux0_div_ops =3D {

static?

> +       .recalc_rate =3D clk_regmap_div_recalc_rate,
> +       .round_rate =3D clk_regmap_div_round_rate,
> +       .set_rate =3D g12b_cpub_clk_mux0_div_set_rate,
> +};
> +
>  /* Datasheet names this field as "mux0_divn_tcnt" */
>  static struct clk_regmap g12b_cpub_clk_mux0_div =3D {
>         .data =3D &(struct clk_regmap_div_data){
[...]
> =20
> +static int g12a_cpu_clk_mux_notifier_cb(struct notifier_block *nb,
> +                                       unsigned long event, void *data)
> +{
> +       switch (event) {
> +       case POST_RATE_CHANGE:
> +       case PRE_RATE_CHANGE:
> +               /* Wait for clock propagation before/after changing the m=
ux */
> +               udelay(100);
> +               return NOTIFY_OK;
> +
> +       default:
> +               return NOTIFY_DONE;
> +       }

Maybe convert this into a if statement and then have a default return
of NOTIFY_DONE otherwise?

> +}
> +
> +struct notifier_block g12a_cpu_clk_mux_nb =3D {

static?

> +       .notifier_call =3D g12a_cpu_clk_mux_notifier_cb,
> +};
> +
> +struct g12a_cpu_clk_postmux_nb_data {
> +       struct notifier_block nb;
> +       struct clk_hw *xtal;
> +       struct clk_hw *cpu_clk_dyn;
> +       struct clk_hw *cpu_clk_postmux0;
> +       struct clk_hw *cpu_clk_postmux1;
> +       struct clk_hw *cpu_clk_premux1;
> +};
> +
> +static int g12a_cpu_clk_postmux_notifier_cb(struct notifier_block *nb,
> +                                        unsigned long event, void *data)
> +{
> +       struct g12a_cpu_clk_postmux_nb_data *nb_data =3D
> +               container_of(nb, struct g12a_cpu_clk_postmux_nb_data, nb);
> +
> +       switch (event) {
> +       case PRE_RATE_CHANGE:
> +               /*
> +                * This notifier means cpu_clk_postmux0 clock will be cha=
nged
> +                * to feed cpu_clk, this the current path :

Maybe write "this is the current path"?

