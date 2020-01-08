Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A7FC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5AB206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kRZyLZAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAHBNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:13:44 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2018 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgAHBNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:13:44 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e152cb50000>; Tue, 07 Jan 2020 17:13:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 17:13:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 17:13:43 -0800
Received: from [10.2.175.47] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 01:13:42 +0000
Subject: Re: [PATCH v6 06/19] soc: tegra: Add Tegra PMC clocks registration
 into PMC driver
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1578370458-3686-1-git-send-email-skomatineni@nvidia.com>
 <1578370458-3686-7-git-send-email-skomatineni@nvidia.com>
 <b37d1be0-affc-a0c7-157a-140b141ca155@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <5b11d228-1894-e052-f740-3a050bb35b6f@nvidia.com>
Date:   Tue, 7 Jan 2020 17:13:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b37d1be0-affc-a0c7-157a-140b141ca155@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578446005; bh=czqak03I8wVN+sOkdYFnWRgHfGjKJTCcV+nbIBWcpRw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=kRZyLZAYHd4buYr0Ek+AywBSLcYhyZLkiTM2318NEwV8CxAj6LE8sBsdszQCRMedH
         0QwCQirl+VNREOgGlFi6/zeDIJcK6+9/N2PaKxBsnjlZ05mseQ1KB1PYr5/EUTpOOM
         bxenoSDeTWStCgKoeJUECDmKEo+OsxhBUXKvKu3l5dTz6QH86/y+tHxq1pxnbhHTJ5
         vWkepxdghSUIAfpHxUrZSZPq1HtbAmuTsOM2Abmtg50YU9sUQqmvu1X2d3IjXynRJE
         5z06kP5iiz6bjMtwj4Thn2A6/yY0FgPorai48tAVln20Fie3efFk61P8MpH3kRyxKY
         wH16naeZ8XD2g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/20 5:00 PM, Dmitry Osipenko wrote:
> 07.01.2020 07:14, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Tegra PMC has clk_out_1, clk_out_2, and clk_out_3 clocks and currently
>> these PMC clocks are registered by Tegra clock driver with each clock as
>> separate mux and gate clocks using clk_register_mux and clk_register_gat=
e
>> by passing PMC base address and register offsets and PMC programming for
>> these clocks happens through direct PMC access by the clock driver.
>>
>> With this, when PMC is in secure mode any direct PMC access from the
>> non-secure world does not go through and these clocks will not be
>> functional.
>>
>> This patch adds these PMC clocks registration to pmc driver with PMC as
>> a clock provider and registers each clock as single clock.
>>
>> clk_ops callback implementations for these clocks uses tegra_pmc_readl a=
nd
>> tegra_pmc_writel which supports PMC programming in both secure mode and
>> non-secure mode.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/soc/tegra/pmc.c | 242 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   1 file changed, 242 insertions(+)
>>
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index 1699dda6b393..2b1a709c3cb7 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -13,9 +13,13 @@
>>  =20
>>   #include <linux/arm-smccc.h>
>>   #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/clk/clk-conf.h>
>>   #include <linux/clk/tegra.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/delay.h>
>> +#include <linux/device.h>
>>   #include <linux/err.h>
>>   #include <linux/export.h>
>>   #include <linux/init.h>
>> @@ -48,6 +52,7 @@
>>   #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>>   #include <dt-bindings/gpio/tegra186-gpio.h>
>>   #include <dt-bindings/gpio/tegra194-gpio.h>
>> +#include <dt-bindings/soc/tegra-pmc.h>
>>  =20
>>   #define PMC_CNTRL			0x0
>>   #define  PMC_CNTRL_INTR_POLARITY	BIT(17) /* inverts INTR polarity */
>> @@ -100,6 +105,8 @@
>>   #define PMC_WAKE2_STATUS		0x168
>>   #define PMC_SW_WAKE2_STATUS		0x16c
>>  =20
>> +#define PMC_CLK_OUT_CNTRL		0x1a8
>> +#define  PMC_CLK_OUT_MUX_MASK		GENMASK(1, 0)
>>   #define PMC_SENSOR_CTRL			0x1b0
>>   #define  PMC_SENSOR_CTRL_SCRATCH_WRITE	BIT(2)
>>   #define  PMC_SENSOR_CTRL_ENABLE_RST	BIT(1)
>> @@ -155,6 +162,63 @@
>>   #define  TEGRA_SMC_PMC_READ	0xaa
>>   #define  TEGRA_SMC_PMC_WRITE	0xbb
>>  =20
>> +struct pmc_clk {
>> +	struct clk_hw	hw;
>> +	unsigned long	offs;
>> +	u32		mux_shift;
>> +	u32		force_en_shift;
>> +};
>> +
>> +#define to_pmc_clk(_hw) container_of(_hw, struct pmc_clk, hw)
>> +
>> +struct pmc_clk_init_data {
>> +	char *name;
>> +	const char *const *parents;
>> +	int num_parents;
>> +	int clk_id;
>> +	u8 mux_shift;
>> +	u8 force_en_shift;
>> +};
>> +
>> +static const char * const clk_out1_parents[] =3D { "osc", "osc_div2",
>> +	"osc_div4", "extern1",
>> +};
>> +
>> +static const char * const clk_out2_parents[] =3D { "osc", "osc_div2",
>> +	"osc_div4", "extern2",
>> +};
>> +
>> +static const char * const clk_out3_parents[] =3D { "osc", "osc_div2",
>> +	"osc_div4", "extern3",
>> +};
> There is no way to specify "osc" as a parent clock in a device-tree
> because there is no DT ID assigned to the OSC in the CaR driver, should
> this be fixed?
Yes, we need DT ID for OSC. Will add.
