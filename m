Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D82C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE6C206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DaMAQIUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfK0W5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:57:13 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9048 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfK0W5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:57:13 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddeff400002>; Wed, 27 Nov 2019 14:57:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 27 Nov 2019 14:57:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 27 Nov 2019 14:57:11 -0800
Received: from [10.2.169.149] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 22:57:09 +0000
Subject: Re: [PATCH v2 02/11] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <tglx@linutronix.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
 <1574830773-14892-3-git-send-email-skomatineni@nvidia.com>
 <749de44c-ec59-3cab-c02e-7b8fcb1fb9f4@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <3d1492a1-f2a5-2d56-5341-a28fcb73fe64@nvidia.com>
Date:   Wed, 27 Nov 2019 14:57:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <749de44c-ec59-3cab-c02e-7b8fcb1fb9f4@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574895425; bh=EE1xXrX7a2Y/cmzSRLixm6XfXTn0jS4zAg2V1uB4Rww=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=DaMAQIUM8EsMEFGRPoUJ5x4zJiTqD86ar1KD1zuF5+l88vjdK2UsvgbOGyWLGy6uO
         aSKIvPrkQMb8YWPpY534RlxBf7NrpADZLnCbzE3FOleOPF9hcyK+Nb+FLf1787Kp/+
         3e322DvU6sM4crJgDcsPTb36nE087K6K7UByB+KEOQkm/nw5bxcZ2hBRlHxRDIMNMi
         kcneS2N3ntmxQ/HH840wEGjo0SlW0qDckH1s25NP/kBvicxSEQr09Slp8NHqF66Q9u
         33PDBW/FsNjHak+DLFfiJ30yzhSJq4hxx7znFavvNB16B1VZJ8fbkTZE0mtJDUXye2
         psrQjJZxjf/Tw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/27/19 7:14 AM, Dmitry Osipenko wrote:
> 27.11.2019 07:59, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2, clk_out_3 with
>> mux and gate for each of these clocks.
>>
>> Currently these PMC clocks are registered by Tegra clock driver using
>> clk_register_mux and clk_register_gate by passing PMC base address
>> and register offsets and PMC programming for these clocks happens
>> through direct PMC access by the clock driver.
>>
>> With this, when PMC is in secure mode any direct PMC access from the
>> non-secure world does not go through and these clocks will not be
>> functional.
>>
>> This patch adds these clocks registration with PMC as a clock provider
>> for these clocks. clk_ops callback implementations for these clocks
>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC programming
>> in secure mode and non-secure mode.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/soc/tegra/pmc.c | 330 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   1 file changed, 330 insertions(+)
>>
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index ea0e11a09c12..a353f6d0a832 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -13,6 +13,9 @@
>>  =20
>>   #include <linux/arm-smccc.h>
>>   #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/clk/clk-conf.h>
>>   #include <linux/clk/tegra.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/delay.h>
>> @@ -48,6 +51,7 @@
>>   #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>>   #include <dt-bindings/gpio/tegra186-gpio.h>
>>   #include <dt-bindings/gpio/tegra194-gpio.h>
>> +#include <dt-bindings/soc/tegra-pmc.h>
>>  =20
>>   #define PMC_CNTRL			0x0
>>   #define  PMC_CNTRL_INTR_POLARITY	BIT(17) /* inverts INTR polarity */
>> @@ -100,6 +104,7 @@
>>   #define PMC_WAKE2_STATUS		0x168
>>   #define PMC_SW_WAKE2_STATUS		0x16c
>>  =20
>> +#define PMC_CLK_OUT_CNTRL		0x1a8
>>   #define PMC_SENSOR_CTRL			0x1b0
>>   #define  PMC_SENSOR_CTRL_SCRATCH_WRITE	BIT(2)
>>   #define  PMC_SENSOR_CTRL_ENABLE_RST	BIT(1)
>> @@ -155,6 +160,91 @@
>>   #define  TEGRA_SMC_PMC_READ	0xaa
>>   #define  TEGRA_SMC_PMC_WRITE	0xbb
>>  =20
>> +struct pmc_clk_mux {
>> +	struct clk_hw	hw;
>> +	unsigned long	offs;
>> +	u32		mask;
>> +	u32		shift;
>> +};
>> +
>> +#define to_pmc_clk_mux(_hw) container_of(_hw, struct pmc_clk_mux, hw)
>> +
>> +struct pmc_clk_gate {
>> +	struct clk_hw	hw;
>> +	unsigned long	offs;
>> +	u32		shift;
>> +};
>> +
>> +#define to_pmc_clk_gate(_hw) container_of(_hw, struct pmc_clk_gate, hw)
>> +
>> +struct pmc_clk_init_data {
>> +	char *mux_name;
>> +	char *gate_name;
>> +	const char **parents;
>> +	int num_parents;
>> +	int mux_id;
>> +	int gate_id;
>> +	char *dev_name;
>> +	u8 mux_shift;
>> +	u8 gate_shift;
>> +	u8 init_parent_index;
>> +	int init_state;
>> +};
>> +
>> +static const char *clk_out1_parents[] =3D { "clk_m", "clk_m_div2",
>> +	"clk_m_div4", "extern1",
>> +};
>> +
>> +static const char *clk_out2_parents[] =3D { "clk_m", "clk_m_div2",
>> +	"clk_m_div4", "extern2",
>> +};
>> +
>> +static const char *clk_out3_parents[] =3D { "clk_m", "clk_m_div2",
>> +	"clk_m_div4", "extern3",
>> +};
>> +
>> +static struct pmc_clk_init_data tegra_pmc_clks_data[] =3D {
>> +	{
>> +		.mux_name =3D "clk_out_1_mux",
>> +		.gate_name =3D "clk_out_1",
>> +		.parents =3D clk_out1_parents,
>> +		.num_parents =3D ARRAY_SIZE(clk_out1_parents),
>> +		.mux_id =3D TEGRA_PMC_CLK_OUT_1_MUX,
>> +		.gate_id =3D TEGRA_PMC_CLK_OUT_1,
>> +		.dev_name =3D "extern1",
>> +		.mux_shift =3D 6,
>> +		.gate_shift =3D 2,
>> +		.init_parent_index =3D 3,
>> +		.init_state =3D 1,
>> +	},
>> +	{
>> +		.mux_name =3D "clk_out_2_mux",
>> +		.gate_name =3D "clk_out_2",
>> +		.parents =3D clk_out2_parents,
>> +		.num_parents =3D ARRAY_SIZE(clk_out2_parents),
>> +		.mux_id =3D TEGRA_PMC_CLK_OUT_2_MUX,
>> +		.gate_id =3D TEGRA_PMC_CLK_OUT_2,
>> +		.dev_name =3D "extern2",
>> +		.mux_shift =3D 14,
>> +		.gate_shift =3D 10,
>> +		.init_parent_index =3D 0,
>> +		.init_state =3D 0,
>> +	},
>> +	{
>> +		.mux_name =3D "clk_out_3_mux",
>> +		.gate_name =3D "clk_out_3",
>> +		.parents =3D clk_out3_parents,
>> +		.num_parents =3D ARRAY_SIZE(clk_out3_parents),
>> +		.mux_id =3D TEGRA_PMC_CLK_OUT_3_MUX,
>> +		.gate_id =3D TEGRA_PMC_CLK_OUT_3,
>> +		.dev_name =3D "extern3",
>> +		.mux_shift =3D 22,
>> +		.gate_shift =3D 18,
>> +		.init_parent_index =3D 0,
>> +		.init_state =3D 0,
>> +	},
>> +};
>> +
>>   struct tegra_powergate {
>>   	struct generic_pm_domain genpd;
>>   	struct tegra_pmc *pmc;
>> @@ -254,6 +344,9 @@ struct tegra_pmc_soc {
>>   	 */
>>   	const struct tegra_wake_event *wake_events;
>>   	unsigned int num_wake_events;
>> +
>> +	struct pmc_clk_init_data *pmc_clks_data;
>> +	unsigned int num_pmc_clks;
>>   };
>>  =20
>>   static const char * const tegra186_reset_sources[] =3D {
>> @@ -2163,6 +2256,228 @@ static int tegra_pmc_clk_notify_cb(struct notifi=
er_block *nb,
>>   	return NOTIFY_OK;
>>   }
>>  =20
>> +static void pmc_clk_fence_udelay(u32 offset)
>> +{
>> +	tegra_pmc_readl(pmc, offset);
>> +	/* pmc clk propagation delay 2 us */
>> +	udelay(2);
>> +}
>> +
>> +static u8 pmc_clk_mux_get_parent(struct clk_hw *hw)
>> +{
>> +	struct pmc_clk_mux *mux =3D to_pmc_clk_mux(hw);
>> +	int num_parents =3D clk_hw_get_num_parents(hw);
>> +	u32 val;
>> +
>> +	val =3D tegra_pmc_readl(pmc, mux->offs) >> mux->shift;
>> +	val &=3D mux->mask;
>> +
>> +	if (val >=3D num_parents)
>> +		return -EINVAL;
>> +
>> +	return val;
>> +}
>> +
>> +static int pmc_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>> +{
>> +	struct pmc_clk_mux *mux =3D to_pmc_clk_mux(hw);
>> +	u32 val;
>> +
>> +	val =3D tegra_pmc_readl(pmc, mux->offs);
>> +	val &=3D ~(mux->mask << mux->shift);
>> +	val |=3D index << mux->shift;
>> +	tegra_pmc_writel(pmc, val, mux->offs);
>> +	pmc_clk_fence_udelay(mux->offs);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct clk_ops pmc_clk_mux_ops =3D {
>> +	.get_parent =3D pmc_clk_mux_get_parent,
>> +	.set_parent =3D pmc_clk_mux_set_parent,
>> +	.determine_rate =3D __clk_mux_determine_rate,
>> +};
>> +
>> +static struct clk *
>> +tegra_pmc_clk_mux_register(const char *name, const char * const *parent=
_names,
>> +			   int num_parents, unsigned long flags,
>> +			   unsigned long offset, u32 shift, u32 mask)
>> +{
>> +	struct clk_init_data init;
>> +	struct pmc_clk_mux *mux;
>> +
>> +	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
>> +	if (!mux)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	init.name =3D name;
>> +	init.ops =3D &pmc_clk_mux_ops;
>> +	init.parent_names =3D parent_names;
>> +	init.num_parents =3D num_parents;
>> +	init.flags =3D flags;
>> +
>> +	mux->hw.init =3D &init;
>> +	mux->offs =3D offset;
>> +	mux->mask =3D mask;
>> +	mux->shift =3D shift;
>> +
>> +	return clk_register(NULL, &mux->hw);
>> +}
>> +
>> +static int pmc_clk_is_enabled(struct clk_hw *hw)
>> +{
>> +	struct pmc_clk_gate *gate =3D to_pmc_clk_gate(hw);
>> +
>> +	return tegra_pmc_readl(pmc, gate->offs) & BIT(gate->shift) ? 1 : 0;
>> +}
>> +
>> +static void pmc_clk_set_state(struct clk_hw *hw, int state)
>> +{
>> +	struct pmc_clk_gate *gate =3D to_pmc_clk_gate(hw);
>> +	u32 val;
>> +
>> +	val =3D tegra_pmc_readl(pmc, gate->offs);
>> +	val =3D state ? (val | BIT(gate->shift)) : (val & ~BIT(gate->shift));
>> +	tegra_pmc_writel(pmc, val, gate->offs);
>> +	pmc_clk_fence_udelay(gate->offs);
>> +}
>> +
>> +static int pmc_clk_enable(struct clk_hw *hw)
>> +{
>> +	pmc_clk_set_state(hw, 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static void pmc_clk_disable(struct clk_hw *hw)
>> +{
>> +	pmc_clk_set_state(hw, 0);
>> +}
>> +
>> +static const struct clk_ops pmc_clk_gate_ops =3D {
>> +	.is_enabled =3D pmc_clk_is_enabled,
>> +	.enable =3D pmc_clk_enable,
>> +	.disable =3D pmc_clk_disable,
>> +};
>> +
>> +static struct clk *
>> +tegra_pmc_clk_gate_register(const char *name, const char *parent_name,
>> +			    unsigned long flags, unsigned long offset,
>> +			    u32 shift)
>> +{
>> +	struct clk_init_data init;
>> +	struct pmc_clk_gate *gate;
>> +
>> +	gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
>> +	if (!gate)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	init.name =3D name;
>> +	init.ops =3D &pmc_clk_gate_ops;
>> +	init.parent_names =3D &parent_name;
>> +	init.num_parents =3D 1;
>> +	init.flags =3D flags;
>> +
>> +	gate->hw.init =3D &init;
>> +	gate->offs =3D offset;
>> +	gate->shift =3D shift;
>> +
>> +	return clk_register(NULL, &gate->hw);
>> +}
>> +
>> +static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
>> +				     struct device_node *np)
>> +{
>> +	struct clk *clkmux, *clk, *parent;
>> +	struct clk_onecell_data *clk_data;
>> +	unsigned int num_clks;
>> +	int i, ret;
>> +
>> +	/* each pmc clock output has a mux and a gate */
>> +	num_clks =3D pmc->soc->num_pmc_clks * 2;
>> +
>> +	if (!num_clks)
>> +		return;
>> +
>> +	clk_data =3D kmalloc(sizeof(*clk_data), GFP_KERNEL);
>> +	if (!clk_data)
>> +		return;
>> +
>> +	clk_data->clks =3D kcalloc(TEGRA_PMC_CLK_MAX, sizeof(*clk_data->clks),
>> +				 GFP_KERNEL);
>> +	if (!clk_data->clks)
>> +		goto free_clkdata;
>> +
>> +	clk_data->clk_num =3D num_clks;
>> +
>> +	for (i =3D 0; i < pmc->soc->num_pmc_clks; i++) {
>> +		struct pmc_clk_init_data *data;
>> +
>> +		data =3D pmc->soc->pmc_clks_data + i;
>> +
>> +		clkmux =3D tegra_pmc_clk_mux_register(data->mux_name,
>> +						    data->parents,
>> +						    data->num_parents,
>> +						    CLK_SET_RATE_NO_REPARENT |
>> +						    CLK_SET_RATE_PARENT,
>> +						    PMC_CLK_OUT_CNTRL,
>> +						    data->mux_shift, 3);
>> +		if (IS_ERR(clkmux))
>> +			goto free_clks;
>> +
>> +		clk_data->clks[data->mux_id] =3D clkmux;
>> +
>> +		clk =3D tegra_pmc_clk_gate_register(data->gate_name,
>> +						  data->mux_name,
>> +						  CLK_SET_RATE_PARENT,
>> +						  PMC_CLK_OUT_CNTRL,
>> +						  data->gate_shift);
>> +		if (IS_ERR(clk))
>> +			goto free_clks;
>> +
>> +		clk_data->clks[data->gate_id] =3D clk;
>> +
>> +		ret =3D clk_set_parent(clk, clkmux);
>> +		if (ret < 0) {
>> +			pr_err("failed to set parent of %s to %s\n",
>> +			       __func__, __clk_get_name(clk),
>> +			       __clk_get_name(clkmux));
>> +		}
>> +
>> +		clk_register_clkdev(clk, data->dev_name, data->gate_name);
>> +
>> +		/* configure initial clock parent and state */
>> +		parent =3D clk_get_sys(data->gate_name,
>> +				     data->parents[data->init_parent_index]);
>> +		if (!IS_ERR(parent)) {
>> +			ret =3D clk_set_parent(clkmux, parent);
>> +			if (ret < 0) {
>> +				pr_err("failed to set parent of %s to %s\n",
>> +				       __func__, __clk_get_name(clkmux),
>> +				       __clk_get_name(parent));
>> +				WARN_ON(1);
>> +			}
>> +		}
>> +
>> +		if (data->init_state) {
>> +			if (clk_prepare_enable(clk)) {
>> +				pr_err("failed to enable %s\n", __func__,
>> +				       __clk_get_name(clk));
>> +				WARN_ON(1);
> Should be a bit better to move the WARN_ON to the end of errors handling
> in order to catch all possible errors:
>
> @@ -2510,6 +2510,7 @@ static void tegra_pmc_clock_register(struct
> tegra_pmc *pmc,
>          return;
>
>   free_clks:
> +       WARN_ON(1);
>          kfree(clk_data->clks);
>   free_clkdata:
>          kfree(clk_data);

Reason I had WARN_ON right during clk_set_parent failure is to have the=20
loop continue for subsequence pmc clocks registration instead of=20
terminating all pmc clocks registration.

