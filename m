Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2F1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3FE218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGnk+zc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLRIaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:30:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36264 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRIaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:30:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so1145050ljg.3;
        Wed, 18 Dec 2019 00:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3n1z8XjSRaOgkjdqmxKcnHUjG4dqpHFoElyTKUSIZXs=;
        b=CGnk+zc8Kc3r2gvQGt34ssCZfA/3BV5o0SKTgFX6QLRdzjhNUTwCUkdowotgzdoKIB
         TztxVQheD/Zr2EqM9BCyY7hh53dOK8qzf7IbhKWh3nqP+3GqluRqO/9la4t6m+Mj8Y1C
         24BgWiDWMIPNgdUgxcRciT3FfOBxGkiOjbdB66A81aGq55STTSXQrYNg90+jdOJAX5RU
         Lxm4r8PGXu8awYqNAt5ZNiPK/92svBVC8a7ZDplZCOgEu2LaxJCecz2h4RNwlh4GL1N5
         qaDspbsfJ/p1WWzNvk9RSXZo4H7f5OWQZlj1Z+mjYr9c7sleHOX5po3UhifsvohDE22w
         9uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3n1z8XjSRaOgkjdqmxKcnHUjG4dqpHFoElyTKUSIZXs=;
        b=EU351u6tdG1/sXu/S+uEAmV5WubcgXAfozo36YUiKY80K16xcSlJucRmdfSowhZZij
         l2eW7VPsthkfMIwGgOfirJMBM5ZA/4X5HJJTRNFLO9GXnsUEaNfpqHHx5UcuphD39oCH
         691bZwaKsh4NxAKL1chHopK69OZjBiI/pv05yAny7IgEs4gaofP4M++jpjTSMRGrPAWF
         1My9svQSs+L1UGsDOFJ9WgsLGSNkkJR13v0QZLSDHCxUKIym4CjzTJ1H83D1R6aVP2nt
         re6dNj5NdDZgLjPpeEZuSYh0/u0eJnOPP5N6MO6nmozE6jE1uCrpHBrOAC05CE+WXps4
         01YA==
X-Gm-Message-State: APjAAAWN87I1NUVm0sYJctyB4xKBGnvOeukdOU9Z6nKfP7gvN9MJiu3q
        zaKjvzCGH83fmBAj7ybGwPJPbpur
X-Google-Smtp-Source: APXvYqwTXX6nLb3+UGvq9Pq+7fJnh7e487veQbd6ahnlhtOFCdjXmp/Xf/tXy8a/zGvb5Q5aB93+Sg==
X-Received: by 2002:a2e:b007:: with SMTP id y7mr832469ljk.215.1576657816406;
        Wed, 18 Dec 2019 00:30:16 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id w1sm674808lfe.96.2019.12.18.00.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 00:30:15 -0800 (PST)
Subject: Re: [PATCH v4 06/19] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-7-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <87b2b266-e4a9-9a7a-2336-6ec57d7c4d1d@gmail.com>
Date:   Wed, 18 Dec 2019 11:30:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576613046-17159-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2019 23:03, Sowjanya Komatineni пишет:
> Tegra PMC has clk_out_1, clk_out_2, and clk_out_3 clocks and currently
> these PMC clocks are registered by Tegra clock driver with each clock as
> separate mux and gate clocks using clk_register_mux and clk_register_gate
> by passing PMC base address and register offsets and PMC programming for
> these clocks happens through direct PMC access by the clock driver.
> 
> With this, when PMC is in secure mode any direct PMC access from the
> non-secure world does not go through and these clocks will not be
> functional.
> 
> This patch adds these PMC clocks registration to pmc driver with PMC as
> a clock provider and registers each clock as single clock.
> 
> clk_ops callback implementations for these clocks uses tegra_pmc_readl and
> tegra_pmc_writel which supports PMC programming in both secure mode and
> non-secure mode.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 248 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 248 insertions(+)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index ea0e11a09c12..6d65194a6e71 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -13,6 +13,9 @@
>  
>  #include <linux/arm-smccc.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk/clk-conf.h>
>  #include <linux/clk/tegra.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> @@ -48,6 +51,7 @@
>  #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>  #include <dt-bindings/gpio/tegra186-gpio.h>
>  #include <dt-bindings/gpio/tegra194-gpio.h>
> +#include <dt-bindings/soc/tegra-pmc.h>
>  
>  #define PMC_CNTRL			0x0
>  #define  PMC_CNTRL_INTR_POLARITY	BIT(17) /* inverts INTR polarity */
> @@ -100,6 +104,7 @@
>  #define PMC_WAKE2_STATUS		0x168
>  #define PMC_SW_WAKE2_STATUS		0x16c
>  
> +#define PMC_CLK_OUT_CNTRL		0x1a8
>  #define PMC_SENSOR_CTRL			0x1b0
>  #define  PMC_SENSOR_CTRL_SCRATCH_WRITE	BIT(2)
>  #define  PMC_SENSOR_CTRL_ENABLE_RST	BIT(1)
> @@ -155,6 +160,64 @@
>  #define  TEGRA_SMC_PMC_READ	0xaa
>  #define  TEGRA_SMC_PMC_WRITE	0xbb
>  
> +struct pmc_clk {
> +	struct clk_hw	hw;
> +	unsigned long	offs;
> +	u32		mux_mask;
> +	u32		mux_shift;
> +	u32		gate_shift;
> +};
> +
> +#define to_pmc_clk(_hw) container_of(_hw, struct pmc_clk, hw)
> +
> +struct pmc_clk_init_data {
> +	char *name;
> +	const char *const *parents;
> +	int num_parents;
> +	int clk_id;
> +	u8 mux_shift;
> +	u8 gate_shift;
> +};
> +
> +static const char * const clk_out1_parents[] = { "osc", "osc_div2",
> +	"osc_div4", "extern1",
> +};
> +
> +static const char * const clk_out2_parents[] = { "osc", "osc_div2",
> +	"osc_div4", "extern2",
> +};
> +
> +static const char * const clk_out3_parents[] = { "osc", "osc_div2",
> +	"osc_div4", "extern3",
> +};
> +
> +static const struct pmc_clk_init_data tegra_pmc_clks_data[] = {
> +	{
> +		.name = "clk_out_1",
> +		.parents = clk_out1_parents,
> +		.num_parents = ARRAY_SIZE(clk_out1_parents),
> +		.clk_id = TEGRA_PMC_CLK_OUT_1,

> +		.mux_shift = 6,
> +		.gate_shift = 2,

I'd replace these with a single .shift, given that mux_shift =
gate_shift + 4 for all clocks.

> +	},
> +	{
> +		.name = "clk_out_2",
> +		.parents = clk_out2_parents,
> +		.num_parents = ARRAY_SIZE(clk_out2_parents),
> +		.clk_id = TEGRA_PMC_CLK_OUT_2,
> +		.mux_shift = 14,
> +		.gate_shift = 10,
> +	},
> +	{
> +		.name = "clk_out_3",
> +		.parents = clk_out3_parents,
> +		.num_parents = ARRAY_SIZE(clk_out3_parents),
> +		.clk_id = TEGRA_PMC_CLK_OUT_3,
> +		.mux_shift = 22,
> +		.gate_shift = 18,
> +	},
> +};
> +
>  struct tegra_powergate {
>  	struct generic_pm_domain genpd;
>  	struct tegra_pmc *pmc;
> @@ -254,6 +317,9 @@ struct tegra_pmc_soc {
>  	 */
>  	const struct tegra_wake_event *wake_events;
>  	unsigned int num_wake_events;
> +
> +	const struct pmc_clk_init_data *pmc_clks_data;
> +	unsigned int num_pmc_clks;
>  };
>  
>  static const char * const tegra186_reset_sources[] = {
> @@ -2163,6 +2229,173 @@ static int tegra_pmc_clk_notify_cb(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> +static void pmc_clk_fence_udelay(u32 offset)
> +{
> +	tegra_pmc_readl(pmc, offset);
> +	/* pmc clk propagation delay 2 us */
> +	udelay(2);
> +}
> +
> +static u8 pmc_clk_mux_get_parent(struct clk_hw *hw)
> +{
> +	struct pmc_clk *clk = to_pmc_clk(hw);
> +	u32 val;
> +
> +	val = tegra_pmc_readl(pmc, clk->offs) >> clk->mux_shift;
> +	val &= clk->mux_mask;
> +
> +	return val;
> +}
> +
> +static int pmc_clk_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct pmc_clk *clk = to_pmc_clk(hw);
> +	u32 val;
> +
> +	val = tegra_pmc_readl(pmc, clk->offs);
> +	val &= ~(clk->mux_mask << clk->mux_shift);
> +	val |= index << clk->mux_shift;
> +	tegra_pmc_writel(pmc, val, clk->offs);
> +	pmc_clk_fence_udelay(clk->offs);
> +
> +	return 0;
> +}
> +
> +static int pmc_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct pmc_clk *clk = to_pmc_clk(hw);
> +
> +	return tegra_pmc_readl(pmc, clk->offs) & BIT(clk->gate_shift) ? 1 : 0;
> +}
> +
> +static void pmc_clk_set_state(unsigned long offs, u32 shift, int state)
> +{
> +	u32 val;
> +
> +	val = tegra_pmc_readl(pmc, offs);
> +	val = state ? (val | BIT(shift)) : (val & ~BIT(shift));
> +	tegra_pmc_writel(pmc, val, offs);
> +	pmc_clk_fence_udelay(offs);
> +}
> +
> +static int pmc_clk_enable(struct clk_hw *hw)
> +{
> +	struct pmc_clk *clk = to_pmc_clk(hw);
> +
> +	pmc_clk_set_state(clk->offs, clk->gate_shift, 1);
> +
> +	return 0;
> +}
> +
> +static void pmc_clk_disable(struct clk_hw *hw)
> +{
> +	struct pmc_clk *clk = to_pmc_clk(hw);
> +
> +	pmc_clk_set_state(clk->offs, clk->gate_shift, 0);
> +}
> +
> +static const struct clk_ops pmc_clk_ops = {
> +	.get_parent = pmc_clk_mux_get_parent,
> +	.set_parent = pmc_clk_mux_set_parent,
> +	.determine_rate = __clk_mux_determine_rate,
> +	.is_enabled = pmc_clk_is_enabled,
> +	.enable = pmc_clk_enable,
> +	.disable = pmc_clk_disable,
> +};
> +
> +static struct clk *
> +tegra_pmc_clk_out_register(const struct pmc_clk_init_data *data,
> +			   unsigned long offset)
> +{
> +	struct clk_init_data init;
> +	struct pmc_clk *pmc_clk;
> +
> +	pmc_clk = kzalloc(sizeof(*pmc_clk), GFP_KERNEL);
> +	if (!pmc_clk)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = data->name;
> +	init.ops = &pmc_clk_ops;
> +	init.parent_names = data->parents;
> +	init.num_parents = data->num_parents;
> +	init.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT |
> +		     CLK_SET_PARENT_GATE;
> +
> +	pmc_clk->hw.init = &init;
> +	pmc_clk->offs = offset;
> +	pmc_clk->mux_mask = 3;

If mux_mask is a constant value, perhaps will be better to replace the
variable with a literal?

#define PMC_CLK_OUT_MUX_MASK	GENMASK(1, 0)

> +	pmc_clk->mux_shift = data->mux_shift;
> +	pmc_clk->gate_shift = data->gate_shift;
> +
> +	return clk_register(NULL, &pmc_clk->hw);
> +}
> +
> +static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
> +				     struct device_node *np)
> +{
> +	struct clk *clk;
> +	struct clk_onecell_data *clk_data;
> +	unsigned int num_clks;
> +	int i, err = -ENOMEM;
> +
> +	num_clks = pmc->soc->num_pmc_clks;
> +
> +	if (!num_clks)
> +		return;
> +
> +	clk_data = kmalloc(sizeof(*clk_data), GFP_KERNEL);
> +	if (!clk_data)
> +		goto err_clk;

What about devm_kmalloc, devm_kcalloc?

> +	clk_data->clks = kcalloc(TEGRA_PMC_CLK_MAX, sizeof(*clk_data->clks),
> +				 GFP_KERNEL);
> +	if (!clk_data->clks)
> +		goto free_clkdata;
> +
> +	clk_data->clk_num = TEGRA_PMC_CLK_MAX;
> +
> +	for (i = 0; i < TEGRA_PMC_CLK_MAX; i++)
> +		clk_data->clks[i] = ERR_PTR(-ENOENT);
> +
> +	for (i = 0; i < pmc->soc->num_pmc_clks; i++) {
> +		const struct pmc_clk_init_data *data;
> +
> +		data = pmc->soc->pmc_clks_data + i;
> +
> +		clk = tegra_pmc_clk_out_register(data, PMC_CLK_OUT_CNTRL);> +		if (IS_ERR(clk)) {
> +			dev_err(pmc->dev,
> +				"unable to register %s\n", data->name);
> +			err = PTR_ERR(clk);
Error codes in a message could be useful.

		err = PTR_ERR_OR_ZERO(clk);
		if (err)
			dev_err(pmc->dev, "unable to register %s: %d\n",
				data->name, err);

> +			goto free_clks;
> +		}

-		clk_data->clks[data->clk_id] = clk;

> +		err = clk_register_clkdev(clk, data->name, NULL);
> +		if (err) {
> +			dev_err(pmc->dev,
> +				"unable to register %s clock lookup\n",
> +				data->name);

			dev_err(pmc->dev,
				"unable to register %s clock lookup: %d\n",
				data->name, err);

> +			goto free_clks;
> +		}

I'd move the assignment here for a bit more consistency.

+		clk_data->clks[data->clk_id] = clk;

> +	}
> +
> +	err = of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
> +	if (err) {
> +		dev_err(pmc->dev, "failed to add pmc clk provider\n");
> +		goto free_clks;
> +	}

[snip]
