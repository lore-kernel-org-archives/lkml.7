Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD75C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9139620717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Wzmf6jB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfLRPun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:50:43 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11604 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfLRPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:50:43 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dfa4ac70000>; Wed, 18 Dec 2019 07:50:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 18 Dec 2019 07:50:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 18 Dec 2019 07:50:40 -0800
Received: from [10.2.164.84] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 15:50:39 +0000
Subject: Re: [PATCH v4 06/19] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-7-git-send-email-skomatineni@nvidia.com>
 <87b2b266-e4a9-9a7a-2336-6ec57d7c4d1d@gmail.com>
 <55a56c3d-3fac-cc77-46ae-acf5de77d262@gmail.com>
 <e4588ae6-8f9a-e4cb-3fd0-aba80a3689dc@nvidia.com>
Message-ID: <c02c873f-cf56-bee9-b4e7-9caff23b1a9d@nvidia.com>
Date:   Wed, 18 Dec 2019 07:50:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e4588ae6-8f9a-e4cb-3fd0-aba80a3689dc@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576684231; bh=8RZN2HQ4hYB8EJfw8DildVTGAnf77fJ+1CFrILTRxJg=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Wzmf6jB/MkEbb/ikMS5ZzJYZNVxsWNrpKz+zem5cIqJksyadk6/AgMBVwagcWvm2V
         7OpZbh7qk4c4PRklp3kTJ9enc9WacKZkJm24Hq5EJMeX9IxrbA+Ut2SlgJZ8IA9BJ+
         Z/cUdsBz56jQwTy9solp8nlCNTYov1zoBZU8W0ijv9P9En6eGE75OM37Mqqsb8psjM
         xhWPcQP8AjaMAs7udpWXGn/NXIeiCgqMhb6qpTM+fvg7q3nQObiK9CL1U8DqqWlwi8
         caR94ihnaB3tV9i2ejmXxRt3ythQTaFhSt1u3ba9bATAgsNM6h2SAqeqOUmoiKR9Ll
         ltJV0bIgCbYBg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/18/19 7:46 AM, Sowjanya Komatineni wrote:
>
> On 12/18/19 12:35 AM, Dmitry Osipenko wrote:
>> 18.12.2019 11:30, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> 17.12.2019 23:03, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> Tegra PMC has clk_out_1, clk_out_2, and clk_out_3 clocks and currently
>>>> these PMC clocks are registered by Tegra clock driver with each=20
>>>> clock as
>>>> separate mux and gate clocks using clk_register_mux and=20
>>>> clk_register_gate
>>>> by passing PMC base address and register offsets and PMC=20
>>>> programming for
>>>> these clocks happens through direct PMC access by the clock driver.
>>>>
>>>> With this, when PMC is in secure mode any direct PMC access from the
>>>> non-secure world does not go through and these clocks will not be
>>>> functional.
>>>>
>>>> This patch adds these PMC clocks registration to pmc driver with=20
>>>> PMC as
>>>> a clock provider and registers each clock as single clock.
>>>>
>>>> clk_ops callback implementations for these clocks uses=20
>>>> tegra_pmc_readl and
>>>> tegra_pmc_writel which supports PMC programming in both secure mode=20
>>>> and
>>>> non-secure mode.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>>> =C2=A0 drivers/soc/tegra/pmc.c | 248=20
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>> =C2=A0 1 file changed, 248 insertions(+)
>>>>
>>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>>> index ea0e11a09c12..6d65194a6e71 100644
>>>> --- a/drivers/soc/tegra/pmc.c
>>>> +++ b/drivers/soc/tegra/pmc.c
>>>> @@ -13,6 +13,9 @@
>>>> =C2=A0 =C2=A0 #include <linux/arm-smccc.h>
>>>> =C2=A0 #include <linux/clk.h>
>>>> +#include <linux/clk-provider.h>
>>>> +#include <linux/clkdev.h>
>>>> +#include <linux/clk/clk-conf.h>
>>>> =C2=A0 #include <linux/clk/tegra.h>
>>>> =C2=A0 #include <linux/debugfs.h>
>>>> =C2=A0 #include <linux/delay.h>
>>>> @@ -48,6 +51,7 @@
>>>> =C2=A0 #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>>>> =C2=A0 #include <dt-bindings/gpio/tegra186-gpio.h>
>>>> =C2=A0 #include <dt-bindings/gpio/tegra194-gpio.h>
>>>> +#include <dt-bindings/soc/tegra-pmc.h>
>>>> =C2=A0 =C2=A0 #define PMC_CNTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0
>>>> =C2=A0 #define=C2=A0 PMC_CNTRL_INTR_POLARITY=C2=A0=C2=A0=C2=A0 BIT(17)=
 /* inverts INTR=20
>>>> polarity */
>>>> @@ -100,6 +104,7 @@
>>>> =C2=A0 #define PMC_WAKE2_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x168
>>>> =C2=A0 #define PMC_SW_WAKE2_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x16c
>>>> =C2=A0 +#define PMC_CLK_OUT_CNTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1a8
>>>> =C2=A0 #define PMC_SENSOR_CTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1b0
>>>> =C2=A0 #define=C2=A0 PMC_SENSOR_CTRL_SCRATCH_WRITE=C2=A0=C2=A0=C2=A0 B=
IT(2)
>>>> =C2=A0 #define=C2=A0 PMC_SENSOR_CTRL_ENABLE_RST=C2=A0=C2=A0=C2=A0 BIT(=
1)
>>>> @@ -155,6 +160,64 @@
>>>> =C2=A0 #define=C2=A0 TEGRA_SMC_PMC_READ=C2=A0=C2=A0=C2=A0 0xaa
>>>> =C2=A0 #define=C2=A0 TEGRA_SMC_PMC_WRITE=C2=A0=C2=A0=C2=A0 0xbb
>>>> =C2=A0 +struct pmc_clk {
>>>> +=C2=A0=C2=A0=C2=A0 struct clk_hw=C2=A0=C2=A0=C2=A0 hw;
>>>> +=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0 offs;
>>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux_=
mask;
>>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux_=
shift;
>>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gate=
_shift;
>>>> +};
>>>> +
>>>> +#define to_pmc_clk(_hw) container_of(_hw, struct pmc_clk, hw)
>>>> +
>>>> +struct pmc_clk_init_data {
>>>> +=C2=A0=C2=A0=C2=A0 char *name;
>>>> +=C2=A0=C2=A0=C2=A0 const char *const *parents;
>>>> +=C2=A0=C2=A0=C2=A0 int num_parents;
>>>> +=C2=A0=C2=A0=C2=A0 int clk_id;
>>>> +=C2=A0=C2=A0=C2=A0 u8 mux_shift;
>>>> +=C2=A0=C2=A0=C2=A0 u8 gate_shift;
>>>> +};
>>>> +
>>>> +static const char * const clk_out1_parents[] =3D { "osc", "osc_div2",
>>>> +=C2=A0=C2=A0=C2=A0 "osc_div4", "extern1",
>>>> +};
>>>> +
>>>> +static const char * const clk_out2_parents[] =3D { "osc", "osc_div2",
>>>> +=C2=A0=C2=A0=C2=A0 "osc_div4", "extern2",
>>>> +};
>>>> +
>>>> +static const char * const clk_out3_parents[] =3D { "osc", "osc_div2",
>>>> +=C2=A0=C2=A0=C2=A0 "osc_div4", "extern3",
>>>> +};
>>>> +
>>>> +static const struct pmc_clk_init_data tegra_pmc_clks_data[] =3D {
>>>> +=C2=A0=C2=A0=C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "clk_out_1",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parents =3D clk_out1_pare=
nts,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D ARRAY_SIZ=
E(clk_out1_parents),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .clk_id =3D TEGRA_PMC_CLK_=
OUT_1,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_shift =3D 6,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_shift =3D 2,
>>> I'd replace these with a single .shift, given that mux_shift =3D
>>> gate_shift + 4 for all clocks.
>>>
>>>> +=C2=A0=C2=A0=C2=A0 },
>>>> +=C2=A0=C2=A0=C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "clk_out_2",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parents =3D clk_out2_pare=
nts,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D ARRAY_SIZ=
E(clk_out2_parents),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .clk_id =3D TEGRA_PMC_CLK_=
OUT_2,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_shift =3D 14,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_shift =3D 10,
>>>> +=C2=A0=C2=A0=C2=A0 },
>>>> +=C2=A0=C2=A0=C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "clk_out_3",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parents =3D clk_out3_pare=
nts,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D ARRAY_SIZ=
E(clk_out3_parents),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .clk_id =3D TEGRA_PMC_CLK_=
OUT_3,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_shift =3D 22,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_shift =3D 18,
>>>> +=C2=A0=C2=A0=C2=A0 },
>>>> +};
>>>> +
>>>> =C2=A0 struct tegra_powergate {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct generic_pm_domain genpd;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tegra_pmc *pmc;
>>>> @@ -254,6 +317,9 @@ struct tegra_pmc_soc {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct tegra_wake_event *wake_eve=
nts;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int num_wake_events;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 const struct pmc_clk_init_data *pmc_clks_data;
>>>> +=C2=A0=C2=A0=C2=A0 unsigned int num_pmc_clks;
>>>> =C2=A0 };
>>>> =C2=A0 =C2=A0 static const char * const tegra186_reset_sources[] =3D {
>>>> @@ -2163,6 +2229,173 @@ static int tegra_pmc_clk_notify_cb(struct=20
>>>> notifier_block *nb,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NOTIFY_OK;
>>>> =C2=A0 }
>>>> =C2=A0 +static void pmc_clk_fence_udelay(u32 offset)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 tegra_pmc_readl(pmc, offset);
>>>> +=C2=A0=C2=A0=C2=A0 /* pmc clk propagation delay 2 us */
>>>> +=C2=A0=C2=A0=C2=A0 udelay(2);
>>>> +}
>>>> +
>>>> +static u8 pmc_clk_mux_get_parent(struct clk_hw *hw)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk *clk =3D to_pmc_clk(hw);
>>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 val =3D tegra_pmc_readl(pmc, clk->offs) >> clk->mu=
x_shift;
>>>> +=C2=A0=C2=A0=C2=A0 val &=3D clk->mux_mask;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return val;
>>>> +}
>>>> +
>>>> +static int pmc_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk *clk =3D to_pmc_clk(hw);
>>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 val =3D tegra_pmc_readl(pmc, clk->offs);
>>>> +=C2=A0=C2=A0=C2=A0 val &=3D ~(clk->mux_mask << clk->mux_shift);
>>>> +=C2=A0=C2=A0=C2=A0 val |=3D index << clk->mux_shift;
>>>> +=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, val, clk->offs);
>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_fence_udelay(clk->offs);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +
>>>> +static int pmc_clk_is_enabled(struct clk_hw *hw)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk *clk =3D to_pmc_clk(hw);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return tegra_pmc_readl(pmc, clk->offs) & BIT(clk->=
gate_shift)=20
>>>> ? 1 : 0;
>>>> +}
>>>> +
>>>> +static void pmc_clk_set_state(unsigned long offs, u32 shift, int=20
>>>> state)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 val =3D tegra_pmc_readl(pmc, offs);
>>>> +=C2=A0=C2=A0=C2=A0 val =3D state ? (val | BIT(shift)) : (val & ~BIT(s=
hift));
>>>> +=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, val, offs);
>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_fence_udelay(offs);
>>>> +}
>>>> +
>>>> +static int pmc_clk_enable(struct clk_hw *hw)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk *clk =3D to_pmc_clk(hw);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_set_state(clk->offs, clk->gate_shift, 1);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +
>>>> +static void pmc_clk_disable(struct clk_hw *hw)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk *clk =3D to_pmc_clk(hw);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_set_state(clk->offs, clk->gate_shift, 0);
>>>> +}
>>>> +
>>>> +static const struct clk_ops pmc_clk_ops =3D {
>>>> +=C2=A0=C2=A0=C2=A0 .get_parent =3D pmc_clk_mux_get_parent,
>>>> +=C2=A0=C2=A0=C2=A0 .set_parent =3D pmc_clk_mux_set_parent,
>>>> +=C2=A0=C2=A0=C2=A0 .determine_rate =3D __clk_mux_determine_rate,
>>>> +=C2=A0=C2=A0=C2=A0 .is_enabled =3D pmc_clk_is_enabled,
>>>> +=C2=A0=C2=A0=C2=A0 .enable =3D pmc_clk_enable,
>>>> +=C2=A0=C2=A0=C2=A0 .disable =3D pmc_clk_disable,
>>>> +};
>>>> +
>>>> +static struct clk *
>>>> +tegra_pmc_clk_out_register(const struct pmc_clk_init_data *data,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 unsigned long offset)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct clk_init_data init;
>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk *pmc_clk;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk =3D kzalloc(sizeof(*pmc_clk), GFP_KERNEL);
>>>> +=C2=A0=C2=A0=C2=A0 if (!pmc_clk)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-ENOMEM);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 init.name =3D data->name;
>>>> +=C2=A0=C2=A0=C2=A0 init.ops =3D &pmc_clk_ops;
>>>> +=C2=A0=C2=A0=C2=A0 init.parent_names =3D data->parents;
>>>> +=C2=A0=C2=A0=C2=A0 init.num_parents =3D data->num_parents;
>>>> +=C2=A0=C2=A0=C2=A0 init.flags =3D CLK_SET_RATE_NO_REPARENT | CLK_SET_=
RATE_PARENT |
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 CLK_SET_PARENT_GATE;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk->hw.init =3D &init;
>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk->offs =3D offset;
>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk->mux_mask =3D 3;
>>> If mux_mask is a constant value, perhaps will be better to replace the
>>> variable with a literal?
>>>
>>> #define PMC_CLK_OUT_MUX_MASK=C2=A0=C2=A0=C2=A0 GENMASK(1, 0)
>> Maybe even:
>>
>> #define PMC_CLK_OUT_MUX_MASK(c)=C2=A0=C2=A0=C2=A0 GENMASK(c->shift + 1, =
c->shift)
>>
>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk->mux_shift =3D data->mux_shift;
>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk->gate_shift =3D data->gate_shift;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return clk_register(NULL, &pmc_clk->hw);
>>>> +}
>>>> +
>>>> +static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_node *np)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct clk *clk;
>>>> +=C2=A0=C2=A0=C2=A0 struct clk_onecell_data *clk_data;
>>>> +=C2=A0=C2=A0=C2=A0 unsigned int num_clks;
>>>> +=C2=A0=C2=A0=C2=A0 int i, err =3D -ENOMEM;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 num_clks =3D pmc->soc->num_pmc_clks;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!num_clks)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 clk_data =3D kmalloc(sizeof(*clk_data), GFP_KERNEL=
);
>>>> +=C2=A0=C2=A0=C2=A0 if (!clk_data)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_clk;
>>> What about devm_kmalloc, devm_kcalloc?
>>>
>>>> +=C2=A0=C2=A0=C2=A0 clk_data->clks =3D kcalloc(TEGRA_PMC_CLK_MAX,=20
>>>> sizeof(*clk_data->clks),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
>>>> +=C2=A0=C2=A0=C2=A0 if (!clk_data->clks)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_clkdata;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 clk_data->clk_num =3D TEGRA_PMC_CLK_MAX;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < TEGRA_PMC_CLK_MAX; i++)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_data->clks[i] =3D ERR_=
PTR(-ENOENT);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < pmc->soc->num_pmc_clks; i++) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct pmc_clk_init_=
data *data;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D pmc->soc->pmc_clk=
s_data + i;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk =3D tegra_pmc_clk_out_=
register(data,=20
>>>> PMC_CLK_OUT_CNTRL);> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (I=
S_ERR(clk)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_err(pmc->dev,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "unable to register %s\n", data->name);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
r =3D PTR_ERR(clk);
>>> Error codes in a message could be useful.
>
> Added error code at end of clock register along with WARN message to=20
> have it common to show warning with error code for all errors=20
> including kmalloc and kcalloc.
>
Sure, With devm_kmalloc and devm_kcalloc, will move error code along=20
with message and do return right at point of errors.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D PTR_ERR_OR_ZERO(clk)=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_=
err(pmc->dev, "unable to register %s: %d\n",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data->name, err);
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to free_clks;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_data->clks[data->clk_id=
] =3D clk;
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_register_clkde=
v(clk, data->name, NULL);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_err(pmc->dev,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "unable to register %s clock lookup\n",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data->name);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_=
err(pmc->dev,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "unable to register %s clock lookup: %d\n",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data->name, err);
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to free_clks;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> I'd move the assignment here for a bit more consistency.
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_data->clks[data->clk_id=
] =3D clk;
>>>
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 err =3D of_clk_add_provider(np, of_clk_src_onecell=
_get, clk_data);
>>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(pmc->dev, "failed =
to add pmc clk provider\n");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_clks;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>> [snip]
>>>
>
