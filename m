Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D6EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E84208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMezP4i4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfK1NZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:25:43 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46299 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1NZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:25:43 -0500
Received: by mail-lj1-f194.google.com with SMTP id e9so28489482ljp.13;
        Thu, 28 Nov 2019 05:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G/d1TkhCeblT/3d5R7NOwD7vHd7mbksNpieQKKaf2tI=;
        b=FMezP4i4ti/lGZ60nflNprU5hqRz2xlm2sII2k5g4PgjhJiwULTmlRvBZsmazyNZIL
         dhsETjDC2xrE5oiRVY4d2IedJYeMrxsIpXRZXykSYLdvp1MrLvp4emkVv3T2M/1gPiaH
         ya3zUuvhUbLEhRVpdIldAVfjUIHDe9fVdPDK02PTlm830XNS1JUJ3Ytjf3IqZBEsNE+9
         P0T3K4Nf7PqYin2iEN6tP/KGh7PXe9kXWNIsYNZYoKqqIOBz2O55rnG5jjW3zSQzsFkB
         KupkMgqX4bhlnGGrqCosi04VXIl/pUqzvoUdo5GlNxi8UcPhJ2/jg0s4uCYDcOMuSuAX
         /kUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G/d1TkhCeblT/3d5R7NOwD7vHd7mbksNpieQKKaf2tI=;
        b=YGWccmSl0LpxTIUHnDxVukof5KZ80PnoW04t/T5J5KmnUTU+uMLzT5uiDY35x2vwLQ
         y5Fuam4VtdGWwJ4jON3ucvZNp6cTqTnN5s/ag7DPKmAthK6qb4AGrr9pGQyxiep1ZQKk
         ooxdwi7cSIqAIIqtphfk334V68GsD62qHVO+e/tzkr5Y4IYz8MWHyMmlBk8c1Bb86T8p
         yeoAxw+LnYvhxZDF1EcxapLsfdvsw9I7E/Y98w10DhgywdDInUZZMobkPzohAQc1Wqvs
         d0WmD6ustnWdgMVPSnZXDcrB9S1NBfeJf1m4q6uKj1Yfu87xPlSaQ0kuiSHjlNp3Il2T
         KdFQ==
X-Gm-Message-State: APjAAAV6RW3RAzl+glcFaTDY7R2C8hcGRQ8InjLKWi3MPcRP0rIwoJgh
        SOJoEDLAYsNpn6VWaFOtVcqwO5yb
X-Google-Smtp-Source: APXvYqx9j7BiyJ0HxdpFuAkZX2e72pMr3lKSm7KZcyKygWIFPGRMNSL04xo3CPBVPznLbYNLsK8I2Q==
X-Received: by 2002:a2e:9256:: with SMTP id v22mr3856958ljg.124.1574947539559;
        Thu, 28 Nov 2019 05:25:39 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id c80sm9859720lfg.81.2019.11.28.05.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 05:25:38 -0800 (PST)
Subject: Re: [PATCH v2 02/11] soc: tegra: Add Tegra PMC clock registrations
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
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
 <1574830773-14892-3-git-send-email-skomatineni@nvidia.com>
 <749de44c-ec59-3cab-c02e-7b8fcb1fb9f4@gmail.com>
 <3d1492a1-f2a5-2d56-5341-a28fcb73fe64@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <484cb1bb-4fb2-9e71-87be-2bd5bd5b2348@gmail.com>
Date:   Thu, 28 Nov 2019 16:25:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3d1492a1-f2a5-2d56-5341-a28fcb73fe64@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.11.2019 01:57, Sowjanya Komatineni пишет:
> 
> On 11/27/19 7:14 AM, Dmitry Osipenko wrote:
>> 27.11.2019 07:59, Sowjanya Komatineni пишет:
>>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2, clk_out_3 with
>>> mux and gate for each of these clocks.
>>>
>>> Currently these PMC clocks are registered by Tegra clock driver using
>>> clk_register_mux and clk_register_gate by passing PMC base address
>>> and register offsets and PMC programming for these clocks happens
>>> through direct PMC access by the clock driver.
>>>
>>> With this, when PMC is in secure mode any direct PMC access from the
>>> non-secure world does not go through and these clocks will not be
>>> functional.
>>>
>>> This patch adds these clocks registration with PMC as a clock provider
>>> for these clocks. clk_ops callback implementations for these clocks
>>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC programming
>>> in secure mode and non-secure mode.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>>   drivers/soc/tegra/pmc.c | 330
>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 330 insertions(+)
>>>
>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>> index ea0e11a09c12..a353f6d0a832 100644
>>> --- a/drivers/soc/tegra/pmc.c
>>> +++ b/drivers/soc/tegra/pmc.c
>>> @@ -13,6 +13,9 @@
>>>     #include <linux/arm-smccc.h>
>>>   #include <linux/clk.h>
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/clkdev.h>
>>> +#include <linux/clk/clk-conf.h>
>>>   #include <linux/clk/tegra.h>
>>>   #include <linux/debugfs.h>
>>>   #include <linux/delay.h>
>>> @@ -48,6 +51,7 @@
>>>   #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>>>   #include <dt-bindings/gpio/tegra186-gpio.h>
>>>   #include <dt-bindings/gpio/tegra194-gpio.h>
>>> +#include <dt-bindings/soc/tegra-pmc.h>
>>>     #define PMC_CNTRL            0x0
>>>   #define  PMC_CNTRL_INTR_POLARITY    BIT(17) /* inverts INTR
>>> polarity */
>>> @@ -100,6 +104,7 @@
>>>   #define PMC_WAKE2_STATUS        0x168
>>>   #define PMC_SW_WAKE2_STATUS        0x16c
>>>   +#define PMC_CLK_OUT_CNTRL        0x1a8
>>>   #define PMC_SENSOR_CTRL            0x1b0
>>>   #define  PMC_SENSOR_CTRL_SCRATCH_WRITE    BIT(2)
>>>   #define  PMC_SENSOR_CTRL_ENABLE_RST    BIT(1)
>>> @@ -155,6 +160,91 @@
>>>   #define  TEGRA_SMC_PMC_READ    0xaa
>>>   #define  TEGRA_SMC_PMC_WRITE    0xbb
>>>   +struct pmc_clk_mux {
>>> +    struct clk_hw    hw;
>>> +    unsigned long    offs;
>>> +    u32        mask;
>>> +    u32        shift;
>>> +};
>>> +
>>> +#define to_pmc_clk_mux(_hw) container_of(_hw, struct pmc_clk_mux, hw)
>>> +
>>> +struct pmc_clk_gate {
>>> +    struct clk_hw    hw;
>>> +    unsigned long    offs;
>>> +    u32        shift;
>>> +};
>>> +
>>> +#define to_pmc_clk_gate(_hw) container_of(_hw, struct pmc_clk_gate, hw)
>>> +
>>> +struct pmc_clk_init_data {
>>> +    char *mux_name;
>>> +    char *gate_name;
>>> +    const char **parents;
>>> +    int num_parents;
>>> +    int mux_id;
>>> +    int gate_id;
>>> +    char *dev_name;
>>> +    u8 mux_shift;
>>> +    u8 gate_shift;
>>> +    u8 init_parent_index;
>>> +    int init_state;
>>> +};
>>> +
>>> +static const char *clk_out1_parents[] = { "clk_m", "clk_m_div2",
>>> +    "clk_m_div4", "extern1",
>>> +};
>>> +
>>> +static const char *clk_out2_parents[] = { "clk_m", "clk_m_div2",
>>> +    "clk_m_div4", "extern2",
>>> +};
>>> +
>>> +static const char *clk_out3_parents[] = { "clk_m", "clk_m_div2",
>>> +    "clk_m_div4", "extern3",
>>> +};
>>> +
>>> +static struct pmc_clk_init_data tegra_pmc_clks_data[] = {
>>> +    {
>>> +        .mux_name = "clk_out_1_mux",
>>> +        .gate_name = "clk_out_1",
>>> +        .parents = clk_out1_parents,
>>> +        .num_parents = ARRAY_SIZE(clk_out1_parents),
>>> +        .mux_id = TEGRA_PMC_CLK_OUT_1_MUX,
>>> +        .gate_id = TEGRA_PMC_CLK_OUT_1,
>>> +        .dev_name = "extern1",
>>> +        .mux_shift = 6,
>>> +        .gate_shift = 2,
>>> +        .init_parent_index = 3,
>>> +        .init_state = 1,
>>> +    },
>>> +    {
>>> +        .mux_name = "clk_out_2_mux",
>>> +        .gate_name = "clk_out_2",
>>> +        .parents = clk_out2_parents,
>>> +        .num_parents = ARRAY_SIZE(clk_out2_parents),
>>> +        .mux_id = TEGRA_PMC_CLK_OUT_2_MUX,
>>> +        .gate_id = TEGRA_PMC_CLK_OUT_2,
>>> +        .dev_name = "extern2",
>>> +        .mux_shift = 14,
>>> +        .gate_shift = 10,
>>> +        .init_parent_index = 0,
>>> +        .init_state = 0,
>>> +    },
>>> +    {
>>> +        .mux_name = "clk_out_3_mux",
>>> +        .gate_name = "clk_out_3",
>>> +        .parents = clk_out3_parents,
>>> +        .num_parents = ARRAY_SIZE(clk_out3_parents),
>>> +        .mux_id = TEGRA_PMC_CLK_OUT_3_MUX,
>>> +        .gate_id = TEGRA_PMC_CLK_OUT_3,
>>> +        .dev_name = "extern3",
>>> +        .mux_shift = 22,
>>> +        .gate_shift = 18,
>>> +        .init_parent_index = 0,
>>> +        .init_state = 0,
>>> +    },
>>> +};
>>> +
>>>   struct tegra_powergate {
>>>       struct generic_pm_domain genpd;
>>>       struct tegra_pmc *pmc;
>>> @@ -254,6 +344,9 @@ struct tegra_pmc_soc {
>>>        */
>>>       const struct tegra_wake_event *wake_events;
>>>       unsigned int num_wake_events;
>>> +
>>> +    struct pmc_clk_init_data *pmc_clks_data;
>>> +    unsigned int num_pmc_clks;
>>>   };
>>>     static const char * const tegra186_reset_sources[] = {
>>> @@ -2163,6 +2256,228 @@ static int tegra_pmc_clk_notify_cb(struct
>>> notifier_block *nb,
>>>       return NOTIFY_OK;
>>>   }
>>>   +static void pmc_clk_fence_udelay(u32 offset)
>>> +{
>>> +    tegra_pmc_readl(pmc, offset);
>>> +    /* pmc clk propagation delay 2 us */
>>> +    udelay(2);
>>> +}
>>> +
>>> +static u8 pmc_clk_mux_get_parent(struct clk_hw *hw)
>>> +{
>>> +    struct pmc_clk_mux *mux = to_pmc_clk_mux(hw);
>>> +    int num_parents = clk_hw_get_num_parents(hw);
>>> +    u32 val;
>>> +
>>> +    val = tegra_pmc_readl(pmc, mux->offs) >> mux->shift;
>>> +    val &= mux->mask;
>>> +
>>> +    if (val >= num_parents)
>>> +        return -EINVAL;
>>> +
>>> +    return val;
>>> +}
>>> +
>>> +static int pmc_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>>> +{
>>> +    struct pmc_clk_mux *mux = to_pmc_clk_mux(hw);
>>> +    u32 val;
>>> +
>>> +    val = tegra_pmc_readl(pmc, mux->offs);
>>> +    val &= ~(mux->mask << mux->shift);
>>> +    val |= index << mux->shift;
>>> +    tegra_pmc_writel(pmc, val, mux->offs);
>>> +    pmc_clk_fence_udelay(mux->offs);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct clk_ops pmc_clk_mux_ops = {
>>> +    .get_parent = pmc_clk_mux_get_parent,
>>> +    .set_parent = pmc_clk_mux_set_parent,
>>> +    .determine_rate = __clk_mux_determine_rate,
>>> +};
>>> +
>>> +static struct clk *
>>> +tegra_pmc_clk_mux_register(const char *name, const char * const
>>> *parent_names,
>>> +               int num_parents, unsigned long flags,
>>> +               unsigned long offset, u32 shift, u32 mask)
>>> +{
>>> +    struct clk_init_data init;
>>> +    struct pmc_clk_mux *mux;
>>> +
>>> +    mux = kzalloc(sizeof(*mux), GFP_KERNEL);
>>> +    if (!mux)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    init.name = name;
>>> +    init.ops = &pmc_clk_mux_ops;
>>> +    init.parent_names = parent_names;
>>> +    init.num_parents = num_parents;
>>> +    init.flags = flags;
>>> +
>>> +    mux->hw.init = &init;
>>> +    mux->offs = offset;
>>> +    mux->mask = mask;
>>> +    mux->shift = shift;
>>> +
>>> +    return clk_register(NULL, &mux->hw);
>>> +}
>>> +
>>> +static int pmc_clk_is_enabled(struct clk_hw *hw)
>>> +{
>>> +    struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
>>> +
>>> +    return tegra_pmc_readl(pmc, gate->offs) & BIT(gate->shift) ? 1 : 0;
>>> +}
>>> +
>>> +static void pmc_clk_set_state(struct clk_hw *hw, int state)
>>> +{
>>> +    struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
>>> +    u32 val;
>>> +
>>> +    val = tegra_pmc_readl(pmc, gate->offs);
>>> +    val = state ? (val | BIT(gate->shift)) : (val & ~BIT(gate->shift));
>>> +    tegra_pmc_writel(pmc, val, gate->offs);
>>> +    pmc_clk_fence_udelay(gate->offs);
>>> +}
>>> +
>>> +static int pmc_clk_enable(struct clk_hw *hw)
>>> +{
>>> +    pmc_clk_set_state(hw, 1);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void pmc_clk_disable(struct clk_hw *hw)
>>> +{
>>> +    pmc_clk_set_state(hw, 0);
>>> +}
>>> +
>>> +static const struct clk_ops pmc_clk_gate_ops = {
>>> +    .is_enabled = pmc_clk_is_enabled,
>>> +    .enable = pmc_clk_enable,
>>> +    .disable = pmc_clk_disable,
>>> +};
>>> +
>>> +static struct clk *
>>> +tegra_pmc_clk_gate_register(const char *name, const char *parent_name,
>>> +                unsigned long flags, unsigned long offset,
>>> +                u32 shift)
>>> +{
>>> +    struct clk_init_data init;
>>> +    struct pmc_clk_gate *gate;
>>> +
>>> +    gate = kzalloc(sizeof(*gate), GFP_KERNEL);
>>> +    if (!gate)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    init.name = name;
>>> +    init.ops = &pmc_clk_gate_ops;
>>> +    init.parent_names = &parent_name;
>>> +    init.num_parents = 1;
>>> +    init.flags = flags;
>>> +
>>> +    gate->hw.init = &init;
>>> +    gate->offs = offset;
>>> +    gate->shift = shift;
>>> +
>>> +    return clk_register(NULL, &gate->hw);
>>> +}
>>> +
>>> +static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
>>> +                     struct device_node *np)
>>> +{
>>> +    struct clk *clkmux, *clk, *parent;
>>> +    struct clk_onecell_data *clk_data;
>>> +    unsigned int num_clks;
>>> +    int i, ret;
>>> +
>>> +    /* each pmc clock output has a mux and a gate */
>>> +    num_clks = pmc->soc->num_pmc_clks * 2;
>>> +
>>> +    if (!num_clks)
>>> +        return;
>>> +
>>> +    clk_data = kmalloc(sizeof(*clk_data), GFP_KERNEL);
>>> +    if (!clk_data)
>>> +        return;
>>> +
>>> +    clk_data->clks = kcalloc(TEGRA_PMC_CLK_MAX,
>>> sizeof(*clk_data->clks),
>>> +                 GFP_KERNEL);
>>> +    if (!clk_data->clks)
>>> +        goto free_clkdata;
>>> +
>>> +    clk_data->clk_num = num_clks;
>>> +
>>> +    for (i = 0; i < pmc->soc->num_pmc_clks; i++) {
>>> +        struct pmc_clk_init_data *data;
>>> +
>>> +        data = pmc->soc->pmc_clks_data + i;
>>> +
>>> +        clkmux = tegra_pmc_clk_mux_register(data->mux_name,
>>> +                            data->parents,
>>> +                            data->num_parents,
>>> +                            CLK_SET_RATE_NO_REPARENT |
>>> +                            CLK_SET_RATE_PARENT,
>>> +                            PMC_CLK_OUT_CNTRL,
>>> +                            data->mux_shift, 3);
>>> +        if (IS_ERR(clkmux))
>>> +            goto free_clks;
>>> +
>>> +        clk_data->clks[data->mux_id] = clkmux;
>>> +
>>> +        clk = tegra_pmc_clk_gate_register(data->gate_name,
>>> +                          data->mux_name,
>>> +                          CLK_SET_RATE_PARENT,
>>> +                          PMC_CLK_OUT_CNTRL,
>>> +                          data->gate_shift);
>>> +        if (IS_ERR(clk))
>>> +            goto free_clks;
>>> +
>>> +        clk_data->clks[data->gate_id] = clk;
>>> +
>>> +        ret = clk_set_parent(clk, clkmux);
>>> +        if (ret < 0) {
>>> +            pr_err("failed to set parent of %s to %s\n",
>>> +                   __func__, __clk_get_name(clk),
>>> +                   __clk_get_name(clkmux));
>>> +        }
>>> +
>>> +        clk_register_clkdev(clk, data->dev_name, data->gate_name);
>>> +
>>> +        /* configure initial clock parent and state */
>>> +        parent = clk_get_sys(data->gate_name,
>>> +                     data->parents[data->init_parent_index]);
>>> +        if (!IS_ERR(parent)) {
>>> +            ret = clk_set_parent(clkmux, parent);
>>> +            if (ret < 0) {
>>> +                pr_err("failed to set parent of %s to %s\n",
>>> +                       __func__, __clk_get_name(clkmux),
>>> +                       __clk_get_name(parent));
>>> +                WARN_ON(1);
>>> +            }
>>> +        }
>>> +
>>> +        if (data->init_state) {
>>> +            if (clk_prepare_enable(clk)) {
>>> +                pr_err("failed to enable %s\n", __func__,
>>> +                       __clk_get_name(clk));
>>> +                WARN_ON(1);

Alternatively you could write it like this:

	err = clk_prepare_enable(clk);

	WARN_ON(err, "failed to enable %s: %d\n",
		__clk_get_name(clk), err);

>> Should be a bit better to move the WARN_ON to the end of errors handling
>> in order to catch all possible errors:
>>
>> @@ -2510,6 +2510,7 @@ static void tegra_pmc_clock_register(struct
>> tegra_pmc *pmc,
>>          return;
>>
>>   free_clks:
>> +       WARN_ON(1);
>>          kfree(clk_data->clks);
>>   free_clkdata:
>>          kfree(clk_data);
> 
> Reason I had WARN_ON right during clk_set_parent failure is to have the
> loop continue for subsequence pmc clocks registration instead of
> terminating all pmc clocks registration.

Ah, okay. Nevertheless this WARN_ON in the end shouldn't be the least (IMO).
