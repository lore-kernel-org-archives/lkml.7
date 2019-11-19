Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB51C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3112080F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHXhCuRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKSTdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:33:45 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44407 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfKSTdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:33:45 -0500
Received: by mail-lj1-f194.google.com with SMTP id g3so24668722ljl.11;
        Tue, 19 Nov 2019 11:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oIbly2SLu4gOmzwsxsqHZSPxb8QUBhaE2wgA4aFOnvo=;
        b=sHXhCuRvBpDMIucuw4no4MYIpU+B/n0Q8aIuSL+QdMeE0B3rDo0CWfqdkE2czfU/NH
         M1mZMAqQPjnyEFEDFt7GEmH9einf0fbHj33TCQDX1Kjr4uf0A4ZOQ9aLLQF9zG2GkQXp
         hzx+R0vmJu87Z63MBa5X+s/NFOqWGWbWCWoKsQZkym/FETF5GTRBAchobVsm0woBnl1M
         As1FnIoRh05U5Q467P/2/9N2MTNAIpf3QhlxzN9tg0sJkHTICRNmVnzho07WynuQHXU2
         nIWRAy0/qIAVLDex8ex09TMkj3enTcHq8PULxAuLx+8Qa3HmKKG0g5EuL4m94oZpCiAS
         CGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oIbly2SLu4gOmzwsxsqHZSPxb8QUBhaE2wgA4aFOnvo=;
        b=FVxjI9S2ExMeyzF7OSRI+sdRgSB1a0pru0lSOx4pfpyzpy4wvKS7KiQAlezaG2Z2yV
         Nc1IMkEfU+EIvK6cHGuvB7qxumwiR+T+we/uj72Exd2UKlM9DqkuTI9oTHPuqwOb24sx
         UlxFbmtWcEf4lOV9gKq2tf2XAlHPICblN9wPC4uCtYwK6EFOVuAuNhQLjSY9YXOFqjnS
         ZI1aStTgJ1GomVxxPPnV2UE8At+bU4lg+fOq2dIdGVL918aFJKBadw7CwlD+/JZFnnMT
         fXSXz7G9vMSf5hPU2nKFS23MNCQOM1akabJ5/o8M01YrjqwzFf04MdjqEFuwhONf2H4n
         xzTg==
X-Gm-Message-State: APjAAAVFmkXo4/R+P0+3NRhP8IpMc5/WQPYBHbzyj+SQ61BVDsXDF+VE
        dL4i2hFYuPlTubLeH8VNybPcNKZt
X-Google-Smtp-Source: APXvYqyQFQFJ0+EIwa74tLCB+6UL/xMYrolALhh9+wZThIkr2r0JCXLPxQCw0lSeKOaepZGi001SXg==
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr5533688ljo.143.1574192021622;
        Tue, 19 Nov 2019 11:33:41 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r22sm10742463lji.71.2019.11.19.11.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 11:33:40 -0800 (PST)
Subject: Re: [PATCH v1 04/17] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     allison@lohutok.net, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
 <1574146234-3871-5-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d072bd37-9628-4eb2-1706-a1f640606b8d@gmail.com>
Date:   Tue, 19 Nov 2019 22:33:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574146234-3871-5-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.11.2019 09:50, Sowjanya Komatineni пишет:
> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 with mux and gate for
> each of these clocks.
> 
> Currently these PMC clocks are registered by Tegra clock driver using
> clk_register_mux and clk_register_gate by passing PMC base address
> and register offsets and PMC programming for these clocks happens
> through direct PMC access by the clock driver.
> 
> With this, when PMC is in secure mode any direct PMC access from the
> non-secure world does not go through and these clocks will not be
> functional.
> 
> This patch adds these clocks registration with PMC as a clock provider
> for these clocks. clk_ops callback implementations for these clocks
> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC programming
> in secure mode and non-secure mode.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 330 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 330 insertions(+)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 7a5aab0b993b..790a6619ba32 100644
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
> @@ -108,6 +112,7 @@
>  #define PMC_WAKE2_STATUS		0x168
>  #define PMC_SW_WAKE2_STATUS		0x16c
>  
> +#define PMC_CLK_OUT_CNTRL		0x1a8
>  #define PMC_SATA_PWRGT			0x1ac
>  #define PMC_SATA_PWRGT_PLLE_IDDQ_VALUE BIT(5)
>  #define PMC_SATA_PWRGT_PLLE_IDDQ_SWCTL BIT(4)
> @@ -170,6 +175,78 @@
>  #define  TEGRA_SMC_PMC_READ	0xaa
>  #define  TEGRA_SMC_PMC_WRITE	0xbb
>  
> +struct pmc_clk_mux {
> +	struct clk_hw	hw;
> +	unsigned long	offs;
> +	u32		mask;
> +	u32		shift;
> +	/* register lock */
> +	spinlock_t	*lock;
> +};
> +
> +#define to_pmc_clk_mux(_hw) container_of(_hw, struct pmc_clk_mux, hw)
> +
> +struct pmc_clk_gate {
> +	struct clk_hw	hw;
> +	unsigned long	offs;
> +	u32		shift;
> +	/* register lock */
> +	spinlock_t	*lock;
> +};
> +
> +#define to_pmc_clk_gate(_hw) container_of(_hw, struct pmc_clk_gate, hw)
> +
> +struct pmc_clk_init_data {
> +	char *mux_name;
> +	char *gate_name;
> +	const char **parents;
> +	int num_parents;
> +	int mux_id;
> +	int gate_id;
> +	char *dev_name;
> +	u8 mux_shift;
> +	u8 gate_shift;
> +	u8 init_parent;
> +	int init_state;
> +	struct pmc_clk_mux mux;
> +	struct pmc_clk_gate gate;
> +};
> +
> +#define PMC_CLK(_num, _mux_shift, _gate_shift, _init_parent, _init_state)\
> +	{\
> +		.mux_name = "clk_out_" #_num "_mux",\
> +		.gate_name = "clk_out_" #_num,\
> +		.parents = clk_out ##_num ##_parents,\
> +		.num_parents = ARRAY_SIZE(clk_out ##_num ##_parents),\
> +		.mux_id = TEGRA_PMC_CLK_OUT_ ##_num ##_MUX,\
> +		.gate_id = TEGRA_PMC_CLK_OUT_ ##_num,\
> +		.dev_name = "extern" #_num,\
> +		.mux_shift = _mux_shift,\
> +		.gate_shift = _gate_shift,\
> +		.init_parent = _init_parent,\
> +		.init_state = _init_state,\
> +	}
> +
> +static DEFINE_SPINLOCK(clk_out_lock);
> +
> +static const char *clk_out1_parents[] = { "clk_m", "clk_m_div2",
> +	"clk_m_div4", "extern1",
> +};
> +
> +static const char *clk_out2_parents[] = { "clk_m", "clk_m_div2",
> +	"clk_m_div4", "extern2",
> +};
> +
> +static const char *clk_out3_parents[] = { "clk_m", "clk_m_div2",
> +	"clk_m_div4", "extern3",
> +};

Why these are unused?

> +static struct pmc_clk_init_data tegra_pmc_clks_data[] = {
> +	PMC_CLK(1, 6, 2, 3, 1),
> +	PMC_CLK(2, 14, 10, 0, 0),
> +	PMC_CLK(3, 22, 18, 0, 0),
> +};
> +
>  struct tegra_powergate {
>  	struct generic_pm_domain genpd;
>  	struct tegra_pmc *pmc;
> @@ -279,6 +356,9 @@ struct tegra_pmc_soc {
>  	 */
>  	const struct tegra_wake_event *wake_events;
>  	unsigned int num_wake_events;
> +
> +	struct pmc_clk_init_data *pmc_clks_data;
> +	unsigned int num_pmc_clks;
>  };
>  
>  static const char * const tegra186_reset_sources[] = {
> @@ -2299,6 +2379,241 @@ static int tegra_pmc_clk_notify_cb(struct notifier_block *nb,
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
> +	struct pmc_clk_mux *mux = to_pmc_clk_mux(hw);
> +	int num_parents = clk_hw_get_num_parents(hw);
> +	u32 val;
> +
> +	val = tegra_pmc_readl(pmc, mux->offs) >> mux->shift;
> +	val &= mux->mask;
> +
> +	if (val >= num_parents)
> +		return -EINVAL;
> +
> +	return val;
> +}
> +
> +static int pmc_clk_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct pmc_clk_mux *mux = to_pmc_clk_mux(hw);
> +	u32 val;
> +	unsigned long flags = 0;
> +
> +	spin_lock_irqsave(mux->lock, flags);
> +
> +	val = tegra_pmc_readl(pmc, mux->offs);
> +	val &= ~(mux->mask << mux->shift);
> +	val |= index << mux->shift;
> +	tegra_pmc_writel(pmc, val, mux->offs);
> +	pmc_clk_fence_udelay(mux->offs);
> +
> +	spin_unlock_irqrestore(mux->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops pmc_clk_mux_ops = {
> +	.get_parent = pmc_clk_mux_get_parent,
> +	.set_parent = pmc_clk_mux_set_parent,
> +	.determine_rate = __clk_mux_determine_rate,
> +};
> +
> +static struct clk *
> +tegra_pmc_clk_mux_register(const char *name, const char * const *parent_names,
> +			   int num_parents, unsigned long flags,
> +			   struct pmc_clk_mux *mux, unsigned long offset,
> +			   u32 shift, u32 mask, spinlock_t *lock)
> +{
> +	struct clk_init_data init;
> +
> +	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +	if (!mux)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &pmc_clk_mux_ops;
> +	init.parent_names = parent_names;
> +	init.num_parents = num_parents;
> +	init.flags = flags;
> +
> +	mux->hw.init = &init;
> +	mux->offs = offset;
> +	mux->mask = mask;
> +	mux->shift = shift;
> +	mux->lock = lock;
> +
> +	return clk_register(NULL, &mux->hw);
> +}
> +
> +static int pmc_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
> +
> +	return tegra_pmc_readl(pmc, gate->offs) & BIT(gate->shift) ? 1 : 0;
> +}
> +
> +static void pmc_clk_set_state(struct clk_hw *hw, int state)
> +{
> +	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
> +	u32 val;
> +	unsigned long flags = 0;
> +
> +	spin_lock_irqsave(gate->lock, flags);
> +
> +	val = tegra_pmc_readl(pmc, gate->offs);
> +	val = state ? (val | BIT(gate->shift)) : (val & ~BIT(gate->shift));
> +	tegra_pmc_writel(pmc, val, gate->offs);
> +	pmc_clk_fence_udelay(gate->offs);
> +
> +	spin_unlock_irqrestore(gate->lock, flags);
> +}
> +
> +static int pmc_clk_enable(struct clk_hw *hw)
> +{
> +	pmc_clk_set_state(hw, 1);
> +
> +	return 0;
> +}
> +
> +static void pmc_clk_disable(struct clk_hw *hw)
> +{
> +	pmc_clk_set_state(hw, 0);
> +}
> +
> +static const struct clk_ops pmc_clk_gate_ops = {
> +	.is_enabled = pmc_clk_is_enabled,
> +	.enable = pmc_clk_enable,
> +	.disable = pmc_clk_disable,
> +};
> +
> +static struct clk *
> +tegra_pmc_clk_gate_register(const char *name, const char *parent_name,
> +			    unsigned long flags, struct pmc_clk_gate *gate,
> +			    unsigned long offset, u32 shift, spinlock_t *lock)
> +{
> +	struct clk_init_data init;
> +
> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		return ERR_PTR(-ENOMEM);

Why *gate is a function argument?

> +
> +	init.name = name;
> +	init.ops = &pmc_clk_gate_ops;
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +	init.flags = flags;
> +
> +	gate->hw.init = &init;
> +	gate->offs = offset;
> +	gate->shift = shift;
> +	gate->lock = lock;
> +
> +	return clk_register(NULL, &gate->hw);
> +}

[snip]
