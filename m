Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED83DC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 04:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC382246A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 04:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Or+xapjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfKTE1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 23:27:42 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8398 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfKTE1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 23:27:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd4c0b80000>; Tue, 19 Nov 2019 20:27:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Nov 2019 20:27:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Nov 2019 20:27:39 -0800
Received: from [10.2.175.254] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Nov
 2019 04:27:37 +0000
Subject: Re: [PATCH v1 06/17] soc: pmc: Add blink output clock registration to
 Tegra PMC
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
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
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
 <1574146234-3871-7-git-send-email-skomatineni@nvidia.com>
 <95f3e928-3e08-abbd-5617-d3570a592c06@gmail.com>
 <87dca259-1f3f-6e74-db45-411ed84afba7@nvidia.com>
 <53c70a0a-edf0-b806-1320-215affba4c28@nvidia.com>
Message-ID: <bc6eb74c-91d5-13d1-9413-5ddf9236e642@nvidia.com>
Date:   Tue, 19 Nov 2019 20:26:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <53c70a0a-edf0-b806-1320-215affba4c28@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574224056; bh=PUXStmHAuzQBwfrjLOLsguEeiGNUGprZ3slJd6+4Vhs=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Or+xapjNPYTaGjc2wUaHDp6CCB8u1fEvbEvoLJHTZ829dqzWsUWWiK2IFtUHwsKM4
         jl2RItfVLfkAs0e87Ob1hSnNlfRekVeBBLHxbvUdSVCmdxZw0Yuqo2kjjUUZBv/xtN
         jP7n07PCYATFgiAMviPMjtl3B9qDtBTLZsiSEKsmmdK/0V8+iMpty1dtki99ASdJw7
         wIbaW7jGoEf35rWu0RfH+tHTOePyzQgQnsp5wd+v5iSODQq4rbpFc3AnGFvhZdNCuO
         uhbet3s9NIcRcAePVLgl7JpbzgIm5lhvqXq23AW7AFPCl2kOm0L/xq7SWMvXwlReVz
         PA6q9lsGupbRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/19/19 6:09 PM, Sowjanya Komatineni wrote:
>
> On 11/19/19 2:13 PM, Sowjanya Komatineni wrote:
>>
>> On 11/19/19 11:34 AM, Dmitry Osipenko wrote:
>>> 19.11.2019 09:50, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> Tegra PMC has blink control to output 32 Khz clock out to Tegra
>>>> blink pin. Blink pad DPD state and enable controls are part of
>>>> Tegra PMC register space.
>>>>
>>>> Currently Tegra clock driver registers blink control by passing
>>>> PMC address and register offset to clk_register_gate which performs
>>>> direct PMC access during clk_ops and with this when PMC is in secure
>>>> mode, any access from non-secure world does not go through.
>>>>
>>>> This patch adds blink control registration to the Tegra PMC driver
>>>> using PMC specific clock gate operations that use tegra_pmc_readl
>>>> and tegra_pmc_writel to support both secure mode and non-secure
>>>> mode PMC register access.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>>> =C2=A0 drivers/soc/tegra/pmc.c | 42=20
>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>> =C2=A0 1 file changed, 42 insertions(+)
>>>>
>>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>>> index 790a6619ba32..095e89c7fa3f 100644
>>>> --- a/drivers/soc/tegra/pmc.c
>>>> +++ b/drivers/soc/tegra/pmc.c
>>>> @@ -61,12 +61,15 @@
>>>> =C2=A0 #define=C2=A0 PMC_CNTRL_SYSCLK_OE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BIT(11) /* system clock=20
>>>> enable */
>>>> =C2=A0 #define=C2=A0 PMC_CNTRL_SYSCLK_POLARITY=C2=A0=C2=A0=C2=A0 BIT(1=
0) /* sys clk polarity */
>>>> =C2=A0 #define=C2=A0 PMC_CNTRL_PWRREQ_POLARITY=C2=A0=C2=A0=C2=A0 BIT(8=
)
>>>> +#define=C2=A0 PMC_CNTRL_BLINK_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 BIT(7)
>>>> =C2=A0 #define=C2=A0 PMC_CNTRL_MAIN_RST=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BIT(4)
>>>> =C2=A0 =C2=A0 #define PMC_WAKE_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0c
>>>> =C2=A0 #define PMC_WAKE_LEVEL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x10
>>>> =C2=A0 #define PMC_WAKE_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x14
>>>> =C2=A0 #define PMC_SW_WAKE_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x18
>>>> +#define PMC_DPD_PADS_ORIDE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0x1c
>>>> +#define=C2=A0 PMC_DPD_PADS_ORIDE_BLINK=C2=A0=C2=A0=C2=A0 BIT(20)
>>>> =C2=A0 =C2=A0 #define DPD_SAMPLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x020
>>>> =C2=A0 #define=C2=A0 DPD_SAMPLE_ENABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BIT(0)
>>>> @@ -79,6 +82,7 @@
>>>> =C2=A0 =C2=A0 #define PWRGATE_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x38
>>>> =C2=A0 +#define TEGRA210_PMC_BLINK_TIMER=C2=A0=C2=A0=C2=A0 0x40
>>>> =C2=A0 #define PMC_IMPL_E_33V_PWR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x40
>>>> =C2=A0 =C2=A0 #define PMC_PWR_DET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x48
>>>> @@ -247,6 +251,9 @@ static struct pmc_clk_init_data=20
>>>> tegra_pmc_clks_data[] =3D {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PMC_CLK(3, 22, 18, 0, 0),
>>>> =C2=A0 };
>>>> =C2=A0 +static struct pmc_clk_gate blink_override;
>>>> +static struct pmc_clk_gate blink;
>>>> +
>>>> =C2=A0 struct tegra_powergate {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct generic_pm_domain genpd;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tegra_pmc *pmc;
>>>> @@ -359,6 +366,7 @@ struct tegra_pmc_soc {
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pmc_clk_init_data *pmc_cl=
ks_data;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int num_pmc_clks;
>>>> +=C2=A0=C2=A0=C2=A0 bool has_blink_output;
>>>> =C2=A0 };
>>>> =C2=A0 =C2=A0 static const char * const tegra186_reset_sources[] =3D {
>>>> @@ -2530,6 +2538,9 @@ static void tegra_pmc_clock_register(struct=20
>>>> tegra_pmc *pmc,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* each pmc clock output has a mux and =
a gate */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_clks =3D pmc->soc->num_pmc_clks * 2=
;
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (pmc->soc->has_blink_output)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_clks +=3D 1;
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!num_clks)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>> =C2=A0 @@ -2604,6 +2615,30 @@ static void=20
>>>> tegra_pmc_clock_register(struct tegra_pmc *pmc,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (pmc->soc->has_blink_output) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, 0x0,=
 TEGRA210_PMC_BLINK_TIMER);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkgate =3D tegra_pmc_clk_=
gate_register("blink_override",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk_32k",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, &blink_override,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 PMC_DPD_PADS_ORIDE,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PMC_DPD_PADS_ORIDE_BLINK,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(clkgate))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to free_clks;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkgate =3D tegra_pmc_clk_=
gate_register("blink",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "blink_override",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, &blink,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PMC_CNTRL,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PMC_CNTRL_BLINK_EN,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(clkgate))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to free_clks;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_data->clks[TEGRA_PMC_C=
LK_BLINK] =3D clkgate;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_register_clkdev(clkgat=
e, "blink", NULL);
>>> Tegra20 has pmc->soc->num_pmc_clks =3D 0 and thus num_clks =3D 1, while
>>> TEGRA_PMC_CLK_BLINK =3D 6.
>>>
>>> BTW, Tegra30 doesn't boot. I'll try again v2.
>>>
>>> Please fix it all in v2. Compile-test all patches and make at least a
>>> boot-test where possible.
>>>
>>> [snip]
>>
>> looks like blink output should be enabled during boot for Tegra20 and=20
>> Tegra30 platforms.
>>
>> Will add init state for blink output in V2. Will compile for old=20
>> Tegra's as well and will try boot-test.
>>
> Hi Thierry,
>
> With implementation of PMC helper functions for PLLM overrides and=20
> PLLE IDDQ PMC programming to use in clock driver during registering=20
> PLLM, need tegra_pmc_early_init to happen prior to tegra_clk_init as=20
> all helper functions have to use tegra_pmc_soc for flags and pmc=20
> register offset.
>
> Any suggestion?
>
>
I think using CLK_OF_DECLARE_DRIVER and add clock driver probe for=20
registering PLLM related clocks should work as by them both initial=20
clock inits and pmc early init happens and then during clock driver=20
probe PLLM gets registered.

