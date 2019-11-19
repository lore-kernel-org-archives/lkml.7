Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2B9C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851B920674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WvTUAjIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfKSWOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:14:32 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6791 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfKSWOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:14:32 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd469430000>; Tue, 19 Nov 2019 14:14:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Nov 2019 14:14:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Nov 2019 14:14:30 -0800
Received: from [10.2.175.254] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 22:14:28 +0000
Subject: Re: [PATCH v1 06/17] soc: pmc: Add blink output clock registration to
 Tegra PMC
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
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <87dca259-1f3f-6e74-db45-411ed84afba7@nvidia.com>
Date:   Tue, 19 Nov 2019 14:13:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <95f3e928-3e08-abbd-5617-d3570a592c06@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574201667; bh=zfnrwuF7fwDfmzMCOkWaY3fHjm2PBHMW5dwbrnuC3m4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=WvTUAjIZl7UIF6EoPZroqn8VeKqtzlqK80UriHzo6JoKow1rqIx4y6SBOxx6tkoA/
         urtL5ZcxvztrQ799D+xyIwLflxL9TrWEYtIeFmf/k+AqQvRIxw0QiQEix5iHm0OKL2
         Ydu1RIZFuP1IM5VRP/gmGtqD8j/uYodaT3A7dWLUV1bXce5LfWrYStd8QRUAaS2Cuk
         lft8HBO86sFJqjrvltFcya+0DHFqeGdSbRR4a9vos8Ak5Vw6sWng16Eh17SG88WOwD
         BF7GGrGYW4okdCfz5+UjkrjsoBbBwh7tSuIgmkJPpXjpxC9/iOkkLhE1IoZCs8NaL9
         8ay23xXwM9rwA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/19/19 11:34 AM, Dmitry Osipenko wrote:
> 19.11.2019 09:50, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Tegra PMC has blink control to output 32 Khz clock out to Tegra
>> blink pin. Blink pad DPD state and enable controls are part of
>> Tegra PMC register space.
>>
>> Currently Tegra clock driver registers blink control by passing
>> PMC address and register offset to clk_register_gate which performs
>> direct PMC access during clk_ops and with this when PMC is in secure
>> mode, any access from non-secure world does not go through.
>>
>> This patch adds blink control registration to the Tegra PMC driver
>> using PMC specific clock gate operations that use tegra_pmc_readl
>> and tegra_pmc_writel to support both secure mode and non-secure
>> mode PMC register access.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/soc/tegra/pmc.c | 42 +++++++++++++++++++++++++++++++++++++++++=
+
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index 790a6619ba32..095e89c7fa3f 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -61,12 +61,15 @@
>>   #define  PMC_CNTRL_SYSCLK_OE		BIT(11) /* system clock enable */
>>   #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
>>   #define  PMC_CNTRL_PWRREQ_POLARITY	BIT(8)
>> +#define  PMC_CNTRL_BLINK_EN		BIT(7)
>>   #define  PMC_CNTRL_MAIN_RST		BIT(4)
>>  =20
>>   #define PMC_WAKE_MASK			0x0c
>>   #define PMC_WAKE_LEVEL			0x10
>>   #define PMC_WAKE_STATUS			0x14
>>   #define PMC_SW_WAKE_STATUS		0x18
>> +#define PMC_DPD_PADS_ORIDE		0x1c
>> +#define  PMC_DPD_PADS_ORIDE_BLINK	BIT(20)
>>  =20
>>   #define DPD_SAMPLE			0x020
>>   #define  DPD_SAMPLE_ENABLE		BIT(0)
>> @@ -79,6 +82,7 @@
>>  =20
>>   #define PWRGATE_STATUS			0x38
>>  =20
>> +#define TEGRA210_PMC_BLINK_TIMER	0x40
>>   #define PMC_IMPL_E_33V_PWR		0x40
>>  =20
>>   #define PMC_PWR_DET			0x48
>> @@ -247,6 +251,9 @@ static struct pmc_clk_init_data tegra_pmc_clks_data[=
] =3D {
>>   	PMC_CLK(3, 22, 18, 0, 0),
>>   };
>>  =20
>> +static struct pmc_clk_gate blink_override;
>> +static struct pmc_clk_gate blink;
>> +
>>   struct tegra_powergate {
>>   	struct generic_pm_domain genpd;
>>   	struct tegra_pmc *pmc;
>> @@ -359,6 +366,7 @@ struct tegra_pmc_soc {
>>  =20
>>   	struct pmc_clk_init_data *pmc_clks_data;
>>   	unsigned int num_pmc_clks;
>> +	bool has_blink_output;
>>   };
>>  =20
>>   static const char * const tegra186_reset_sources[] =3D {
>> @@ -2530,6 +2538,9 @@ static void tegra_pmc_clock_register(struct tegra_=
pmc *pmc,
>>   	/* each pmc clock output has a mux and a gate */
>>   	num_clks =3D pmc->soc->num_pmc_clks * 2;
>>  =20
>> +	if (pmc->soc->has_blink_output)
>> +		num_clks +=3D 1;
>> +
>>   	if (!num_clks)
>>   		return;
>>  =20
>> @@ -2604,6 +2615,30 @@ static void tegra_pmc_clock_register(struct tegra=
_pmc *pmc,
>>   		}
>>   	}
>>  =20
>> +	if (pmc->soc->has_blink_output) {
>> +		tegra_pmc_writel(pmc, 0x0, TEGRA210_PMC_BLINK_TIMER);
>> +		clkgate =3D tegra_pmc_clk_gate_register("blink_override",
>> +						      "clk_32k",
>> +						      0, &blink_override,
>> +					      PMC_DPD_PADS_ORIDE,
>> +						      PMC_DPD_PADS_ORIDE_BLINK,
>> +						      NULL);
>> +		if (IS_ERR(clkgate))
>> +			goto free_clks;
>> +
>> +		clkgate =3D tegra_pmc_clk_gate_register("blink",
>> +						      "blink_override",
>> +						      0, &blink,
>> +						      PMC_CNTRL,
>> +						      PMC_CNTRL_BLINK_EN,
>> +						      NULL);
>> +		if (IS_ERR(clkgate))
>> +			goto free_clks;
>> +
>> +		clk_data->clks[TEGRA_PMC_CLK_BLINK] =3D clkgate;
>> +		clk_register_clkdev(clkgate, "blink", NULL);
> Tegra20 has pmc->soc->num_pmc_clks =3D 0 and thus num_clks =3D 1, while
> TEGRA_PMC_CLK_BLINK =3D 6.
>
> BTW, Tegra30 doesn't boot. I'll try again v2.
>
> Please fix it all in v2. Compile-test all patches and make at least a
> boot-test where possible.
>
> [snip]

looks like blink output should be enabled during boot for Tegra20 and=20
Tegra30 platforms.

Will add init state for blink output in V2. Will compile for old Tegra's=20
as well and will try boot-test.

