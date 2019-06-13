Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58222C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226D421743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UKErXfoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfFMPcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:32:21 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6058 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfFMKtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:49:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d022a4c0000>; Thu, 13 Jun 2019 03:49:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 03:49:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 13 Jun 2019 03:49:49 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 10:49:48 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id D21EA428B8; Thu, 13 Jun 2019 13:49:45 +0300 (EEST)
Date:   Thu, 13 Jun 2019 13:49:45 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Prashant Gaikwad" <pgaikwad@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] clk: tegra20/30: Add custom EMC clock
 implementation
Message-ID: <20190613104945.GJ29894@pdeschrijver-desktop.Nvidia.com>
References: <20190524172353.29087-1-digetx@gmail.com>
 <20190524172353.29087-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190524172353.29087-2-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560422990; bh=Svkffrzg9Qo8t+19JaPU6eSSVSlhSnK0UJSc2PwhXqY=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=UKErXfoZX8fBeo8pJphs+pXKPN/qUdnPdhh3imY7LG5sN8OAz+LuncRLyMAgLSEdt
         wXQIkM6Juzou5eZVAnilQQl2n9g5wqfZSIVDQdCGi4j14pK3cOGRaW1tdrQyXQP75l
         s+hDhqTcpPsOTx/5fBqSWlc4eJaXuT4sOb6FgGWXzMfq3KJJYuwSZX7vMbr3BM7Ce0
         Pt5kOtXEh5OyxULRG7WwJE2owokAKwPX3txvXSjQUJZnsZbVMNtrHLh6gcCFZeP8Nf
         CXVAc4Ok5n/txeHnjhD/4sskTMEcISpcQeGRM/FRjq13Ipx3VSqlVcQ05w3BZKoGKo
         1LsvbSMAeamCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 08:23:46PM +0300, Dmitry Osipenko wrote:
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
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/Makefile          |   2 +
>  drivers/clk/tegra/clk-tegra20-emc.c | 299 ++++++++++++++++++++++++++++
>  drivers/clk/tegra/clk-tegra20.c     |  55 ++---
>  drivers/clk/tegra/clk-tegra30.c     |  38 +++-
>  drivers/clk/tegra/clk.h             |   6 +
>  include/linux/clk/tegra.h           |  14 ++
>  6 files changed, 362 insertions(+), 52 deletions(-)
>  create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
> 
> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> index 4812e45c2214..df966ca06788 100644
> --- a/drivers/clk/tegra/Makefile
> +++ b/drivers/clk/tegra/Makefile
> @@ -17,7 +17,9 @@ obj-y					+= clk-tegra-fixed.o
>  obj-y					+= clk-tegra-super-gen4.o
>  obj-$(CONFIG_TEGRA_CLK_EMC)		+= clk-emc.o
>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
> +obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= clk-tegra20-emc.o
>  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
> +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= clk-tegra20-emc.o
>  obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
>  obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
>  obj-$(CONFIG_TEGRA_CLK_DFLL)		+= clk-tegra124-dfll-fcpu.o
> diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-tegra20-emc.c
> new file mode 100644
> index 000000000000..d971b5425ce3
> --- /dev/null
> +++ b/drivers/clk/tegra/clk-tegra20-emc.c
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: GPL-2.0
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
> +static const char * const emc_parent_clk_names[] = {
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
> +	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
> +	u32 val, div;
> +
> +	val = readl_relaxed(emc->reg);
> +	div = val & CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
> +
> +	return DIV_ROUND_UP(parent_rate * 2, div + 2);
> +}
> +
> +static u8 emc_get_parent(struct clk_hw *hw)
> +{
> +	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
> +
> +	return readl_relaxed(emc->reg) >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
> +}
> +
> +static int emc_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
> +	u32 val, div;
> +
> +	val = readl_relaxed(emc->reg);
> +	val &= ~CLK_SOURCE_EMC_2X_CLK_SRC_MASK;
> +	val |= index << CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
> +
> +	div = val & CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
> +
> +	if (index == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
> +		val |= USE_PLLM_UD;
> +	else
> +		val &= ~USE_PLLM_UD;
> +
> +	if (emc->mc_same_freq)
> +		val |= MC_EMC_SAME_FREQ;
> +	else
> +		val &= ~MC_EMC_SAME_FREQ;
> +
> +	writel_relaxed(val, emc->reg);
> +

I think technically you need a fence_udelay(1) here, but in practice
this is probably not needed because you will poll some EMC register for
the frequency completion anyway. Maybe add a comment about this?

> +	return 0;
> +}
> +
> +static int emc_set_rate(struct clk_hw *hw, unsigned long rate,
> +			unsigned long parent_rate)
> +{
> +	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
> +	unsigned int index;
> +	u32 val, div;
> +
> +	div = div_frac_get(rate, parent_rate, 8, 1, 0);
> +
> +	val = readl_relaxed(emc->reg);
> +	val &= ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
> +	val |= div;
> +
> +	index = val >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
> +
> +	if (index == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
> +		val |= USE_PLLM_UD;
> +	else
> +		val &= ~USE_PLLM_UD;
> +
> +	if (emc->mc_same_freq)
> +		val |= MC_EMC_SAME_FREQ;
> +	else
> +		val &= ~MC_EMC_SAME_FREQ;
> +
> +	writel_relaxed(val, emc->reg);
> +

Same here.

> +	return 0;
> +}
> +
> +static int emc_set_rate_and_parent(struct clk_hw *hw,
> +				   unsigned long rate,
> +				   unsigned long parent_rate,
> +				   u8 index)
> +{
> +	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
> +	u32 val, div;
> +
> +	div = div_frac_get(rate, parent_rate, 8, 1, 0);
> +
> +	val = readl_relaxed(emc->reg);
> +
> +	val &= ~CLK_SOURCE_EMC_2X_CLK_SRC_MASK;
> +	val |= index << CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
> +
> +	val &= ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
> +	val |= div;
> +
> +	if (index == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
> +		val |= USE_PLLM_UD;
> +	else
> +		val &= ~USE_PLLM_UD;
> +
> +	if (emc->mc_same_freq)
> +		val |= MC_EMC_SAME_FREQ;
> +	else
> +		val &= ~MC_EMC_SAME_FREQ;
> +
> +	writel_relaxed(val, emc->reg);
> +

And here.

> +	return 0;
> +}

Peter.
