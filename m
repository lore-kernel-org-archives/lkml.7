Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7216DC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113782084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy9gdl8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfFQJgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:36:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45463 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFQJgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:36:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so9100563wre.12;
        Mon, 17 Jun 2019 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8LA6TtuR1xeLKpZJIs9hFeIavbWr08TtqjA/mqKsWzw=;
        b=Oy9gdl8c8WXIIEfTiQmdroZPGbd3+0XLq5TjtYeXWnB9xLWToIVz7tbFjkEC9wUXFC
         qwucwmPdMixMsfle+FHL8rpJuckDmFV4XAz+h3GZvYGa45G3NCdLFVQBgAe6GFrVAE0y
         0SIgg0KhXrRyEUM+M81DrY2HIwny8rN+iGRsn9hSoPXiDAvTiiZuN+88V6dLvN1Fswo5
         CC8KSu83QU29oj3JKzTf6brSqwJbmOfShFL5s0A9IaBa2hKX9DomGCSQdH1oI730BLMJ
         6bf+RMAo/zJCeMvfPmdwU+ONLXyftiKn7bJCOHfCvDjl5SUb4icu46mO3Ord+ybJXdXd
         rf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8LA6TtuR1xeLKpZJIs9hFeIavbWr08TtqjA/mqKsWzw=;
        b=ZJvMmO2wPXdEStNq+yJcrHWHG8Kr8XwMD5VXdZFdVI8UKFFnBYfX6MlH7NOKCAsRG9
         Yd8tJRxDY43poA+LXBHElCKT7VVU1PNj5hLVIyjOE2lksAKlMNCOUwM4wz75NEPshy70
         fpV7xj2D1RQLBUx40yGgMWxwC5rQuquTEJRNNbGlDiY6XbXQ7sYIuI3h8H8SmJxD4FLz
         1DfiY7xUXF/JVw2r+uD8akHKyK5Sd/Br0MCxVj9USNhJ0FdCjMjDx0D3qqTeeYdTpFEH
         KJuh7gY/p54inaUFk407srI06oOrzYecfuUnd9y5KhpnFRNPdKOFSmcpYgmhqBIADngE
         bWRA==
X-Gm-Message-State: APjAAAVVgw/6x1ACA/YkmAYkwFcUVNnpgBdXFYoMtz/inmOoJPjmQU5D
        x09UIAsUAYUz/Q2cZtwLIN8=
X-Google-Smtp-Source: APXvYqz4SHvT8sa8SGqbWFuyjw/3Sc2TWBLGeu1SV6pOYfr3z2kSw2Vh2ktNMvo4FS8qLoktx9YJaw==
X-Received: by 2002:adf:eecf:: with SMTP id a15mr1722099wrp.354.1560764157766;
        Mon, 17 Jun 2019 02:35:57 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id c4sm8929529wrt.86.2019.06.17.02.35.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 02:35:56 -0700 (PDT)
Date:   Mon, 17 Jun 2019 11:35:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] clk: tegra20/30: Add custom EMC clock
 implementation
Message-ID: <20190617093555.GB508@ulmo>
References: <20190616233551.6838-1-digetx@gmail.com>
 <20190616233551.6838-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <20190616233551.6838-2-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 02:35:42AM +0300, Dmitry Osipenko wrote:
> A proper External Memory Controller clock rounding and parent selection
> functionality is required by the EMC drivers. It is not available using
> the generic clock implementation, hence add a custom one. The clock rate
> rounding shall be done by the EMC drivers because they have information
> about available memory timings, so the drivers will have to register a
> callback that will round the requested rate. EMC clock users won't be able
> to request EMC clock by getting -EPROBE_DEFER until EMC driver is probed
> and the callback is set up. The functionality is somewhat similar to the
> clk-emc.c which serves Tegra124+ SoC's, the later HW generations support
> more parent clock sources and the HW configuration and integration with
> the EMC drivers differs a tad from the older gens, hence it's not really
> worth to try to squash everything into a single source file.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/Makefile          |   2 +
>  drivers/clk/tegra/clk-tegra20-emc.c | 305 ++++++++++++++++++++++++++++
>  drivers/clk/tegra/clk-tegra20.c     |  55 ++---
>  drivers/clk/tegra/clk-tegra30.c     |  38 +++-
>  drivers/clk/tegra/clk.h             |   6 +
>  include/linux/clk/tegra.h           |  14 ++
>  6 files changed, 368 insertions(+), 52 deletions(-)
>  create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
>=20
> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> index 4812e45c2214..df966ca06788 100644
> --- a/drivers/clk/tegra/Makefile
> +++ b/drivers/clk/tegra/Makefile
> @@ -17,7 +17,9 @@ obj-y					+=3D clk-tegra-fixed.o
>  obj-y					+=3D clk-tegra-super-gen4.o
>  obj-$(CONFIG_TEGRA_CLK_EMC)		+=3D clk-emc.o
>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         +=3D clk-tegra20.o
> +obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+=3D clk-tegra20-emc.o
>  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         +=3D clk-tegra30.o
> +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+=3D clk-tegra20-emc.o
>  obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+=3D clk-tegra114.o
>  obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D clk-tegra124.o
>  obj-$(CONFIG_TEGRA_CLK_DFLL)		+=3D clk-tegra124-dfll-fcpu.o
> diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-=
tegra20-emc.c
> new file mode 100644
> index 000000000000..b7f64ad5c04c
> --- /dev/null
> +++ b/drivers/clk/tegra/clk-tegra20-emc.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0

Perhaps you want to add copyright information here? Part of this is
copied from other drivers, so keep that copyright intact. But there's
also quite a bit of new code here, so also make sure to add yourself.

> +
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk/tegra.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +
> +#include "clk.h"
> +
> +#define CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK	GENMASK(7, 0)
> +#define CLK_SOURCE_EMC_2X_CLK_SRC_MASK		GENMASK(31, 30)
> +#define CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT		30
> +
> +#define MC_EMC_SAME_FREQ	BIT(16)
> +#define USE_PLLM_UD		BIT(29)
> +
> +#define EMC_SRC_PLL_M		0
> +#define EMC_SRC_PLL_C		1
> +#define EMC_SRC_PLL_P		2
> +#define EMC_SRC_CLK_M		3
> +
> +static const char * const emc_parent_clk_names[] =3D {
> +	"pll_m", "pll_c", "pll_p", "clk_m",
> +};
> +
> +struct tegra_clk_emc {
> +	struct clk_hw hw;
> +	void __iomem *reg;
> +	bool mc_same_freq;
> +	bool want_low_jitter;
> +
> +	tegra20_clk_emc_round_cb *round_cb;
> +	void *cb_arg;
> +};
> +
> +static inline struct tegra_clk_emc *to_tegra_clk_emc(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct tegra_clk_emc, hw);
> +}
> +
> +static unsigned long emc_recalc_rate(struct clk_hw *hw,
> +				     unsigned long parent_rate)
> +{
> +	struct tegra_clk_emc *emc =3D to_tegra_clk_emc(hw);
> +	u32 val, div;
> +
> +	val =3D readl_relaxed(emc->reg);
> +	div =3D val & CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
> +
> +	return DIV_ROUND_UP(parent_rate * 2, div + 2);
> +}
> +
> +static u8 emc_get_parent(struct clk_hw *hw)
> +{
> +	struct tegra_clk_emc *emc =3D to_tegra_clk_emc(hw);
> +
> +	return readl_relaxed(emc->reg) >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
> +}
> +
> +static int emc_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct tegra_clk_emc *emc =3D to_tegra_clk_emc(hw);
> +	u32 val, div;
> +
> +	val =3D readl_relaxed(emc->reg);
> +	val &=3D ~CLK_SOURCE_EMC_2X_CLK_SRC_MASK;
> +	val |=3D index << CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
> +
> +	div =3D val & CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
> +
> +	if (index =3D=3D EMC_SRC_PLL_M && div =3D=3D 0 && emc->want_low_jitter)
> +		val |=3D USE_PLLM_UD;
> +	else
> +		val &=3D ~USE_PLLM_UD;
> +
> +	if (emc->mc_same_freq)
> +		val |=3D MC_EMC_SAME_FREQ;
> +	else
> +		val &=3D ~MC_EMC_SAME_FREQ;
> +
> +	writel_relaxed(val, emc->reg);
> +
> +	fence_udelay(1, emc->reg);
> +
> +	return 0;
> +}
> +
> +static int emc_set_rate(struct clk_hw *hw, unsigned long rate,
> +			unsigned long parent_rate)
> +{
> +	struct tegra_clk_emc *emc =3D to_tegra_clk_emc(hw);
> +	unsigned int index;
> +	u32 val, div;
> +
> +	div =3D div_frac_get(rate, parent_rate, 8, 1, 0);
> +
> +	val =3D readl_relaxed(emc->reg);
> +	val &=3D ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
> +	val |=3D div;
> +
> +	index =3D val >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
> +
> +	if (index =3D=3D EMC_SRC_PLL_M && div =3D=3D 0 && emc->want_low_jitter)
> +		val |=3D USE_PLLM_UD;
> +	else
> +		val &=3D ~USE_PLLM_UD;
> +
> +	if (emc->mc_same_freq)
> +		val |=3D MC_EMC_SAME_FREQ;
> +	else
> +		val &=3D ~MC_EMC_SAME_FREQ;
> +
> +	writel_relaxed(val, emc->reg);
> +
> +	fence_udelay(1, emc->reg);
> +
> +	return 0;
> +}
> +
> +static int emc_set_rate_and_parent(struct clk_hw *hw,
> +				   unsigned long rate,
> +				   unsigned long parent_rate,
> +				   u8 index)
> +{
> +	struct tegra_clk_emc *emc =3D to_tegra_clk_emc(hw);
> +	u32 val, div;
> +
> +	div =3D div_frac_get(rate, parent_rate, 8, 1, 0);
> +
> +	val =3D readl_relaxed(emc->reg);
> +
> +	val &=3D ~CLK_SOURCE_EMC_2X_CLK_SRC_MASK;
> +	val |=3D index << CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
> +
> +	val &=3D ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
> +	val |=3D div;
> +
> +	if (index =3D=3D EMC_SRC_PLL_M && div =3D=3D 0 && emc->want_low_jitter)
> +		val |=3D USE_PLLM_UD;
> +	else
> +		val &=3D ~USE_PLLM_UD;
> +
> +	if (emc->mc_same_freq)
> +		val |=3D MC_EMC_SAME_FREQ;
> +	else
> +		val &=3D ~MC_EMC_SAME_FREQ;
> +
> +	writel_relaxed(val, emc->reg);
> +
> +	fence_udelay(1, emc->reg);
> +
> +	return 0;
> +}
> +
> +static int emc_determine_rate(struct clk_hw *hw, struct clk_rate_request=
 *req)
> +{
> +	struct tegra_clk_emc *emc =3D to_tegra_clk_emc(hw);
> +	struct clk_hw *parent_hw;
> +	unsigned long divided_rate;
> +	unsigned long parent_rate;
> +	unsigned int i;
> +	long emc_rate;
> +	int div;
> +
> +	emc_rate =3D emc->round_cb(req->rate, req->min_rate, req->max_rate,
> +				 emc->cb_arg);
> +	if (emc_rate < 0)
> +		return emc_rate;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(emc_parent_clk_names); i++) {
> +		parent_hw =3D clk_hw_get_parent_by_index(hw, i);
> +
> +		if (req->best_parent_hw =3D=3D parent_hw)
> +			parent_rate =3D req->best_parent_rate;
> +		else
> +			parent_rate =3D clk_hw_get_rate(parent_hw);
> +
> +		if (emc_rate > parent_rate)
> +			continue;
> +
> +		div =3D div_frac_get(emc_rate, parent_rate, 8, 1, 0);
> +		divided_rate =3D DIV_ROUND_UP(parent_rate * 2, div + 2);
> +
> +		if (divided_rate !=3D emc_rate)
> +			continue;
> +
> +		req->best_parent_rate =3D parent_rate;
> +		req->best_parent_hw =3D parent_hw;
> +		req->rate =3D emc_rate;
> +		break;
> +	}
> +
> +	if (i =3D=3D ARRAY_SIZE(emc_parent_clk_names)) {
> +		pr_err_once("%s: can't find parent for rate %lu emc_rate %lu\n",
> +			    __func__, req->rate, emc_rate);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops tegra_clk_emc_ops =3D {
> +	.recalc_rate =3D emc_recalc_rate,
> +	.get_parent =3D emc_get_parent,
> +	.set_parent =3D emc_set_parent,
> +	.set_rate =3D emc_set_rate,
> +	.set_rate_and_parent =3D emc_set_rate_and_parent,
> +	.determine_rate =3D emc_determine_rate,
> +};
> +
> +void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_=
cb,
> +					void *cb_arg)
> +{
> +	struct clk *clk =3D __clk_lookup("emc");
> +	struct tegra_clk_emc *emc;
> +	struct clk_hw *hw;
> +
> +	if (clk) {
> +		hw =3D __clk_get_hw(clk);
> +		emc =3D to_tegra_clk_emc(hw);
> +
> +		emc->round_cb =3D round_cb;
> +		emc->cb_arg =3D cb_arg;
> +	}
> +}
> +
> +bool tegra20_clk_emc_driver_available(struct clk_hw *emc_hw)
> +{
> +	return to_tegra_clk_emc(emc_hw)->round_cb !=3D NULL;
> +}
> +
> +struct clk *tegra20_clk_register_emc(void __iomem *ioaddr)
> +{
> +	struct tegra_clk_emc *emc;
> +	struct clk_init_data init;
> +	struct clk *clk;
> +
> +	emc =3D kzalloc(sizeof(*emc), GFP_KERNEL);
> +	if (!emc)
> +		return NULL;
> +
> +	init.name =3D "emc";
> +	init.ops =3D &tegra_clk_emc_ops;
> +	init.flags =3D CLK_IS_CRITICAL;
> +	init.parent_names =3D emc_parent_clk_names;
> +	init.num_parents =3D ARRAY_SIZE(emc_parent_clk_names);
> +
> +	emc->reg =3D ioaddr;
> +	emc->hw.init =3D &init;
> +
> +	clk =3D clk_register(NULL, &emc->hw);
> +	if (IS_ERR(clk)) {
> +		kfree(emc);
> +		return NULL;
> +	}
> +
> +	return clk;
> +}
> +
> +void tegra30_clk_set_emc_round_callback(tegra30_clk_emc_round_cb *round_=
cb,
> +					void *cb_arg)
> +{
> +	tegra20_clk_set_emc_round_callback(round_cb, cb_arg);
> +}
> +
> +bool tegra30_clk_emc_driver_available(struct clk_hw *emc_hw)
> +{
> +	return tegra20_clk_emc_driver_available(emc_hw);
> +}

Do we really need to make this distinction? Do you have any work in
progress patches that would need to override these Tegra30 specific bits
by code that's not the same as the Tegra20 variant? I don't see why you
would want to duplicate this if there's no use to it. Or perhaps I'm
missing something?

> +
> +struct clk *tegra30_clk_register_emc(void __iomem *ioaddr)
> +{
> +	struct tegra_clk_emc *emc;
> +	struct clk_hw *hw;
> +	struct clk *clk;
> +
> +	clk =3D tegra20_clk_register_emc(ioaddr);
> +	if (!clk)
> +		return NULL;
> +
> +	hw =3D __clk_get_hw(clk);
> +	emc =3D to_tegra_clk_emc(hw);
> +	emc->want_low_jitter =3D true;
> +
> +	return clk;
> +}
> +
> +int tegra30_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same)
> +{
> +	struct tegra_clk_emc *emc;
> +	struct clk_hw *hw;
> +
> +	if (emc_clk) {
> +		hw =3D __clk_get_hw(emc_clk);
> +		emc =3D to_tegra_clk_emc(hw);
> +		emc->mc_same_freq =3D same;
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegr=
a20.c
> index bcd871134f45..f937a0f35afb 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -130,8 +130,6 @@ static struct cpu_clk_suspend_context {
>  static void __iomem *clk_base;
>  static void __iomem *pmc_base;
> =20
> -static DEFINE_SPINLOCK(emc_lock);
> -
>  #define TEGRA_INIT_DATA_MUX(_name, _parents, _offset,	\
>  			    _clk_num, _gate_flags, _clk_id)	\
>  	TEGRA_INIT_DATA(_name, NULL, NULL, _parents, _offset,	\
> @@ -760,7 +758,6 @@ static const char *pwm_parents[] =3D { "pll_p", "pll_=
c", "audio", "clk_m",
>  static const char *mux_pllpcm_clkm[] =3D { "pll_p", "pll_c", "pll_m", "c=
lk_m" };
>  static const char *mux_pllpdc_clkm[] =3D { "pll_p", "pll_d_out0", "pll_c=
",
>  					 "clk_m" };
> -static const char *mux_pllmcp_clkm[] =3D { "pll_m", "pll_c", "pll_p", "c=
lk_m" };
> =20
>  static struct tegra_periph_init_data tegra_periph_clk_list[] =3D {
>  	TEGRA_INIT_DATA_MUX("i2s1", i2s1_parents,     CLK_SOURCE_I2S1,   11, TE=
GRA_PERIPH_ON_APB, TEGRA20_CLK_I2S1),
> @@ -787,41 +784,6 @@ static struct tegra_periph_init_data tegra_periph_no=
div_clk_list[] =3D {
>  	TEGRA_INIT_DATA_NODIV("disp2",	mux_pllpdc_clkm, CLK_SOURCE_DISP2, 30, 2=
, 26,  0, TEGRA20_CLK_DISP2),
>  };
> =20
> -static void __init tegra20_emc_clk_init(void)
> -{
> -	const u32 use_pllm_ud =3D BIT(29);
> -	struct clk *clk;
> -	u32 emc_reg;
> -
> -	clk =3D clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
> -			       ARRAY_SIZE(mux_pllmcp_clkm),
> -			       CLK_SET_RATE_NO_REPARENT,
> -			       clk_base + CLK_SOURCE_EMC,
> -			       30, 2, 0, &emc_lock);
> -
> -	clk =3D tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EM=
C,
> -				    &emc_lock);
> -	clks[TEGRA20_CLK_MC] =3D clk;
> -
> -	/* un-divided pll_m_out0 is currently unsupported */
> -	emc_reg =3D readl_relaxed(clk_base + CLK_SOURCE_EMC);
> -	if (emc_reg & use_pllm_ud) {
> -		pr_err("%s: un-divided PllM_out0 used as clock source\n",
> -		       __func__);
> -		return;
> -	}
> -
> -	/*
> -	 * Note that 'emc_mux' source and 'emc' rate shouldn't be changed at
> -	 * the same time due to a HW bug, this won't happen because we're
> -	 * defining 'emc_mux' and 'emc' as distinct clocks.
> -	 */
> -	clk =3D tegra_clk_register_divider("emc", "emc_mux",
> -				clk_base + CLK_SOURCE_EMC, CLK_IS_CRITICAL,
> -				TEGRA_DIVIDER_INT, 0, 8, 1, &emc_lock);
> -	clks[TEGRA20_CLK_EMC] =3D clk;
> -}
> -
>  static void __init tegra20_periph_clk_init(void)
>  {
>  	struct tegra_periph_init_data *data;
> @@ -835,7 +797,13 @@ static void __init tegra20_periph_clk_init(void)
>  	clks[TEGRA20_CLK_AC97] =3D clk;
> =20
>  	/* emc */
> -	tegra20_emc_clk_init();
> +	clk =3D tegra20_clk_register_emc(clk_base + CLK_SOURCE_EMC);
> +
> +	clks[TEGRA20_CLK_EMC] =3D clk;
> +
> +	clk =3D tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC,
> +				    NULL);
> +	clks[TEGRA20_CLK_MC] =3D clk;
> =20
>  	/* dsi */
>  	clk =3D tegra_clk_register_periph_gate("dsi", "pll_d", 0, clk_base, 0,
> @@ -1115,6 +1083,8 @@ static struct clk *tegra20_clk_src_onecell_get(stru=
ct of_phandle_args *clkspec,
>  	if (IS_ERR(clk))
>  		return clk;
> =20
> +	hw =3D __clk_get_hw(clk);
> +
>  	/*
>  	 * Tegra20 CDEV1 and CDEV2 clocks are a bit special case, their parent
>  	 * clock is created by the pinctrl driver. It is possible for clk user
> @@ -1124,13 +1094,16 @@ static struct clk *tegra20_clk_src_onecell_get(st=
ruct of_phandle_args *clkspec,
>  	 */
>  	if (clkspec->args[0] =3D=3D TEGRA20_CLK_CDEV1 ||
>  	    clkspec->args[0] =3D=3D TEGRA20_CLK_CDEV2) {
> -		hw =3D __clk_get_hw(clk);
> -
>  		parent_hw =3D clk_hw_get_parent(hw);
>  		if (!parent_hw)
>  			return ERR_PTR(-EPROBE_DEFER);
>  	}
> =20
> +	if (clkspec->args[0] =3D=3D TEGRA20_CLK_EMC) {
> +		if (!tegra20_clk_emc_driver_available(hw))
> +			return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
>  	return clk;
>  }
> =20
> diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegr=
a30.c
> index 7b4c6a488527..fab075808c20 100644
> --- a/drivers/clk/tegra/clk-tegra30.c
> +++ b/drivers/clk/tegra/clk-tegra30.c
> @@ -151,7 +151,6 @@ static unsigned long input_freq;
> =20
>  static DEFINE_SPINLOCK(cml_lock);
>  static DEFINE_SPINLOCK(pll_d_lock);
> -static DEFINE_SPINLOCK(emc_lock);
> =20
>  #define TEGRA_INIT_DATA_MUX(_name, _parents, _offset,	\
>  			    _clk_num, _gate_flags, _clk_id)	\
> @@ -808,7 +807,7 @@ static struct tegra_clk tegra30_clks[tegra_clk_max] _=
_initdata =3D {
>  	[tegra_clk_pll_a] =3D { .dt_id =3D TEGRA30_CLK_PLL_A, .present =3D true=
 },
>  	[tegra_clk_pll_a_out0] =3D { .dt_id =3D TEGRA30_CLK_PLL_A_OUT0, .presen=
t =3D true },
>  	[tegra_clk_cec] =3D { .dt_id =3D TEGRA30_CLK_CEC, .present =3D true },
> -	[tegra_clk_emc] =3D { .dt_id =3D TEGRA30_CLK_EMC, .present =3D true },
> +	[tegra_clk_emc] =3D { .dt_id =3D TEGRA30_CLK_EMC, .present =3D false },
>  };
> =20
>  static const char *pll_e_parents[] =3D { "pll_ref", "pll_p" };
> @@ -995,7 +994,6 @@ static void __init tegra30_super_clk_init(void)
>  static const char *mux_pllacp_clkm[] =3D { "pll_a_out0", "unused", "pll_=
p",
>  					 "clk_m" };
>  static const char *mux_pllpcm_clkm[] =3D { "pll_p", "pll_c", "pll_m", "c=
lk_m" };
> -static const char *mux_pllmcp_clkm[] =3D { "pll_m", "pll_c", "pll_p", "c=
lk_m" };
>  static const char *spdif_out_parents[] =3D { "pll_a_out0", "spdif_2x", "=
pll_p",
>  					   "clk_m" };
>  static const char *mux_pllmcpa[] =3D { "pll_m", "pll_c", "pll_p", "pll_a=
_out0" };
> @@ -1044,14 +1042,12 @@ static void __init tegra30_periph_clk_init(void)
>  	clks[TEGRA30_CLK_AFI] =3D clk;
> =20
>  	/* emc */
> -	clk =3D clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
> -			       ARRAY_SIZE(mux_pllmcp_clkm),
> -			       CLK_SET_RATE_NO_REPARENT,
> -			       clk_base + CLK_SOURCE_EMC,
> -			       30, 2, 0, &emc_lock);
> +	clk =3D tegra30_clk_register_emc(clk_base + CLK_SOURCE_EMC);
> +
> +	clks[TEGRA30_CLK_EMC] =3D clk;
> =20
> -	clk =3D tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EM=
C,
> -				    &emc_lock);
> +	clk =3D tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC,
> +				    NULL);
>  	clks[TEGRA30_CLK_MC] =3D clk;
> =20
>  	/* cml0 */
> @@ -1302,6 +1298,26 @@ static struct tegra_audio_clk_info tegra30_audio_p=
lls[] =3D {
>  	{ "pll_a", &pll_a_params, tegra_clk_pll_a, "pll_p_out1" },
>  };
> =20
> +static struct clk *tegra30_clk_src_onecell_get(struct of_phandle_args *c=
lkspec,
> +					       void *data)
> +{
> +	struct clk_hw *hw;
> +	struct clk *clk;
> +
> +	clk =3D of_clk_src_onecell_get(clkspec, data);
> +	if (IS_ERR(clk))
> +		return clk;
> +
> +	hw =3D __clk_get_hw(clk);
> +
> +	if (clkspec->args[0] =3D=3D TEGRA30_CLK_EMC) {
> +		if (!tegra30_clk_emc_driver_available(hw))
> +			return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	return clk;
> +}
> +
>  static void __init tegra30_clock_init(struct device_node *np)
>  {
>  	struct device_node *node;
> @@ -1345,7 +1361,7 @@ static void __init tegra30_clock_init(struct device=
_node *np)
> =20
>  	tegra_init_dup_clks(tegra_clk_duplicates, clks, TEGRA30_CLK_CLK_MAX);
> =20
> -	tegra_add_of_provider(np, of_clk_src_onecell_get);
> +	tegra_add_of_provider(np, tegra30_clk_src_onecell_get);
>  	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
> =20
>  	tegra_clk_apply_init_table =3D tegra30_clock_apply_init_table;
> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> index 905bf1096558..1eb2ec20e343 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -838,4 +838,10 @@ int div_frac_get(unsigned long rate, unsigned parent=
_rate, u8 width,
>  		udelay(delay);		\
>  	} while (0)
> =20
> +bool tegra20_clk_emc_driver_available(struct clk_hw *emc_hw);
> +struct clk *tegra20_clk_register_emc(void __iomem *ioaddr);
> +
> +bool tegra30_clk_emc_driver_available(struct clk_hw *emc_hw);
> +struct clk *tegra30_clk_register_emc(void __iomem *ioaddr);
> +
>  #endif /* TEGRA_CLK_H */
> diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
> index b8aef62cc3f5..8546e28aa518 100644
> --- a/include/linux/clk/tegra.h
> +++ b/include/linux/clk/tegra.h
> @@ -119,4 +119,18 @@ extern void tegra210_put_utmipll_in_iddq(void);
>  extern void tegra210_put_utmipll_out_iddq(void);
>  extern int tegra210_clk_handle_mbist_war(unsigned int id);
> =20
> +struct clk;
> +
> +typedef long (tegra20_clk_emc_round_cb)(unsigned long rate,
> +					unsigned long min_rate,
> +					unsigned long max_rate,
> +					void *arg);
> +#define tegra30_clk_emc_round_cb	tegra20_clk_emc_round_cb

Again, I don't see any advantage in quirky things like this. It seems to
me like the only reason why this exists is so that Tegra30 code doesn't
have to call functions that start with a tegra20_ prefix. However, we
already have code that does similar things elsewhere, so I think this
can be considered "common" practice. No need for this duplication.

Again, if I'm missing something please let me know. Might be worth
noting why this is done in a code comment or the commit message.

Thierry

> +
> +void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_=
cb,
> +					void *cb_arg);
> +void tegra30_clk_set_emc_round_callback(tegra30_clk_emc_round_cb *round_=
cb,
> +					void *cb_arg);
> +int tegra30_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same);
> +
>  #endif /* __LINUX_CLK_TEGRA_H_ */
> --=20
> 2.22.0
>=20

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0HXvgACgkQ3SOs138+
s6GkQQ/9Hp6bskUgDD3zgcMatvuhVEaYsBKxVbXYdv+5tWTtNcm+udnmsPheA5uh
2YDD1u+ki0hmnkLganS++e+ZJDGv+Pe3GN4ZG57iwO4Z7zeejwCNeTF/nTrh2N1Z
asI6zrWapm4rpGY7yd+mdUMgh8A0zM9Zb13Lczp4OjNzp3jdYtKkU+9qpzuHxmnW
cVJ4Rt0nHGJiA5rRnk4y8Z7bOGGMpkvGGEmSSBTawjmkGEDneCel0BA0ZnblqxYP
jsN2hrkrpJUZzKRSzCF6RK+5iDcTuaAyKML+RRRuHIr50yi170ReVnZ7d7A7tCAu
jsH9OtUbv0dGrJ7StQzLmV/aS8Id9Lh0SirySi9lR2N6hADOB1jhGQfJ7ZkQxZ0E
1cWKsEtVSkW3VeKsF71xilh2cuPH70emAjsBMr3sMdRiO+2ZjQO8+5hEE/txri4U
zfzFUz8Eoe0Zc+kzjV2zw7uNu0AgL/e720W6DnisCqIgEVnNSGiR7QGjtz12T3Tm
QKYF6w8JplRt8wFDU8r6B4Z2/LYJ/rl/tND9t26d9mc2EFe06BgrNHv1bdeyCmGF
Oc0YoTuKpiv7HdvjcJ1T7etIo0StPt+zFkLt2ibcyuMVUDVqp6CxUOdXzuQok3M8
P4I6+S68JVkjyBZfbfEJpXmJklZbS3OOaB25RpjlHZ8LrujnRqo=
=5Su3
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
