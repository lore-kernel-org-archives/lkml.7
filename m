Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0279C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A957420862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570126209;
	bh=sB5Ps8gXl1Clpj94aGeMy9RyrsHpbQ1qiqUJfZHEo/o=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=EEcWnG2SYeSZqeXPcDB0Canv1Lcc2/9pzVmENGraQtQoMnQt0ZNIeEv+/6Yrq9cCl
	 zyHcOphEkDCTwMe++Ao+Gx2EpZI3NmZA9P0Wz30gZUGLElLTVl5M6IR7jq+UV5hiHz
	 OePhteuPwC7DFaPH/+K6CA+531ljKqBuTYIPqmlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733299AbfJCSKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731010AbfJCSKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:10:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D6D620679;
        Thu,  3 Oct 2019 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570126207;
        bh=sB5Ps8gXl1Clpj94aGeMy9RyrsHpbQ1qiqUJfZHEo/o=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=Ee2eg6M52ngE6uPWZT6vmU/q/8MON8SHGMolIrjrhaXt99aTxP7MORkqW72JwHLWX
         GFovIgyUsk60pKR2azvezkOvf7B41KGqZjUnLOS519CJyMh4TG5KR5jR7+oAvMN6Bz
         kkI9KGZWbT0OngnPIz3kDuiyq3nk4kBfNwSfjApg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1569553244-3165-2-git-send-email-zhangqing@rock-chips.com>
References: <1569553244-3165-1-git-send-email-zhangqing@rock-chips.com> <1569553244-3165-2-git-send-email-zhangqing@rock-chips.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v3 1/5] clk: rockchip: Add supprot to limit input rate for fractional divider
User-Agent: alot/0.8.1
Date:   Thu, 03 Oct 2019 11:10:06 -0700
Message-Id: <20191003181007.4D6D620679@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elaine Zhang (2019-09-26 20:00:40)
> diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-p=
x30.c
> index 3a501896b280..6c2f53dc73b6 100644
> --- a/drivers/clk/rockchip/clk-px30.c
> +++ b/drivers/clk/rockchip/clk-px30.c
> @@ -13,6 +13,7 @@
>  #include "clk.h"
> =20
>  #define PX30_GRF_SOC_STATUS0           0x480
> +#define PX30_FRAC_MAX_PRATE            600000000
> =20
>  enum px30_plls {
>         apll, dpll, cpll, npll, apll_b_h, apll_b_l,
> @@ -420,7 +421,7 @@ enum px30_pmu_plls {
>         COMPOSITE_FRACMUX(0, "dclk_vopb_frac", "dclk_vopb_src", CLK_SET_R=
ATE_PARENT,
>                         PX30_CLKSEL_CON(6), 0,
>                         PX30_CLKGATE_CON(2), 3, GFLAGS,
> -                       &px30_dclk_vopb_fracmux),
> +                       &px30_dclk_vopb_fracmux, 0),
>         GATE(DCLK_VOPB, "dclk_vopb", "dclk_vopb_mux", CLK_SET_RATE_PARENT,
>                         PX30_CLKGATE_CON(2), 4, GFLAGS),
>         COMPOSITE(0, "dclk_vopl_src", mux_npll_cpll_p, 0,
> @@ -429,7 +430,7 @@ enum px30_pmu_plls {
>         COMPOSITE_FRACMUX(0, "dclk_vopl_frac", "dclk_vopl_src", CLK_SET_R=
ATE_PARENT,
>                         PX30_CLKSEL_CON(9), 0,
>                         PX30_CLKGATE_CON(2), 7, GFLAGS,
> -                       &px30_dclk_vopl_fracmux),
> +                       &px30_dclk_vopl_fracmux, 0),
>         GATE(DCLK_VOPL, "dclk_vopl", "dclk_vopl_mux", CLK_SET_RATE_PARENT,
>                         PX30_CLKGATE_CON(2), 8, GFLAGS),
> =20
> @@ -555,7 +556,7 @@ enum px30_pmu_plls {
>         COMPOSITE_FRACMUX(0, "clk_pdm_frac", "clk_pdm_src", CLK_SET_RATE_=
PARENT,

Can you make a new macro COMPOSITE_FRACMUX_PRATE or something that
passes in another argument so that we don't have to change the users
of this macro when they don't care?

>                         PX30_CLKSEL_CON(27), 0,
>                         PX30_CLKGATE_CON(9), 10, GFLAGS,
> -                       &px30_pdm_fracmux),
> +                       &px30_pdm_fracmux, PX30_FRAC_MAX_PRATE),
>         GATE(SCLK_PDM, "clk_pdm", "clk_pdm_mux", CLK_SET_RATE_PARENT,
>                         PX30_CLKGATE_CON(9), 11, GFLAGS),
> =20
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk=
-rk3399.c
> index ce1d2446f142..bda5d50c5319 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -13,6 +13,12 @@
>  #include <dt-bindings/clock/rk3399-cru.h>
>  #include "clk.h"
> =20
> +#define RK3399_I2S_FRAC_MAX_PRATE       800000000
> +#define RK3399_UART_FRAC_MAX_PRATE     800000000
> +#define RK3399_SPDIF_FRAC_MAX_PRATE    600000000
> +#define RK3399_VOP_FRAC_MAX_PRATE      600000000
> +#define RK3399_WIFI_FRAC_MAX_PRATE     600000000

Is the "max rate" really just the frequency of the parent? If so, why
can't round_rate() on the parent figure out what that value is and only
provide that frequency?

> +
>  enum rk3399_plls {
>         lpll, bpll, dpll, cpll, gpll, npll, vpll,
>  };
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 546e810c3560..fac5a4a3f5c3 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -184,12 +184,26 @@ static void rockchip_fractional_approximation(struc=
t clk_hw *hw,
>         unsigned long p_rate, p_parent_rate;
>         struct clk_hw *p_parent;
>         unsigned long scale;
> +       u32 div;

Why u32 instead of unsigned long?

> =20
>         p_rate =3D clk_hw_get_rate(clk_hw_get_parent(hw));
> -       if ((rate * 20 > p_rate) && (p_rate % rate !=3D 0)) {
> +       if (((rate * 20 > p_rate) && (p_rate % rate !=3D 0)) ||
> +           (fd->max_prate && fd->max_prate < p_rate)) {
>                 p_parent =3D clk_hw_get_parent(clk_hw_get_parent(hw));
>                 p_parent_rate =3D clk_hw_get_rate(p_parent);
>                 *parent_rate =3D p_parent_rate;
> +               if (fd->max_prate && p_parent_rate > fd->max_prate) {
> +                       div =3D DIV_ROUND_UP(p_parent_rate, fd->max_prate=
);
> +                       *parent_rate =3D p_parent_rate / div;
> +               }
> +
> +               if (*parent_rate < rate * 20) {

20 seems very magical.

> +                       pr_err("%s parent_rate(%ld) is low than rate(%ld)=
*20, fractional div is not allowed\n",

s/low/lower/?

> +                              clk_hw_get_name(hw), *parent_rate, rate);
> +                       *m =3D 0;
> +                       *n =3D 1;
> +                       return;
> +               }
>         }
> =20
>         /*
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 2ae7604783dd..30993c0630a3 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -624,6 +624,7 @@ struct clk_hw *clk_hw_register_fixed_factor(struct de=
vice *dev,
>   * @mwidth:    width of the numerator bit field
>   * @nshift:    shift to the denominator bit field
>   * @nwidth:    width of the denominator bit field
> + * @max_parent:        the maximum frequency of fractional divider paren=
t clock

This doesn't match the name of the member.

>   * @lock:      register lock
>   *
>   * Clock with adjustable fractional divider affecting its output frequen=
cy.
> @@ -647,6 +648,7 @@ struct clk_fractional_divider {
>         u8              nwidth;
>         u32             nmask;
>         u8              flags;
> +       unsigned long   max_prate;


