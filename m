Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC8EC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E631B20722
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TjySz6FA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLBW6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:58:42 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16200 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfLBW6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:58:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de597150001>; Mon, 02 Dec 2019 14:58:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 02 Dec 2019 14:58:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 02 Dec 2019 14:58:38 -0800
Received: from [10.2.160.125] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Dec
 2019 22:58:37 +0000
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
 <3d1492a1-f2a5-2d56-5341-a28fcb73fe64@nvidia.com>
 <484cb1bb-4fb2-9e71-87be-2bd5bd5b2348@gmail.com>
 <e4ee58aa-c421-ea4b-a37b-574fc987c7c1@nvidia.com>
 <e5da42b8-bf21-4b57-8ae6-37ce6ca4210c@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <bb4853a1-83d7-273d-50df-324570c4a4b8@nvidia.com>
Date:   Mon, 2 Dec 2019 14:58:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e5da42b8-bf21-4b57-8ae6-37ce6ca4210c@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575327510; bh=c/GyivbDczr8O8WHK5Rd8ruqQg/EBC+dBluKkb5R95w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=TjySz6FAQvYr+NmnTmYyT7AFBZ2SXqqBg4IeoaF73Jg3Eag6dCKvw8Ci9B+5PBdM9
         FqgY3TiJfB2nm5iQlKoBtKH/fk44mBbjktXKNhum+2M/CQpKGndKNQAT0C8YkO/2Ms
         NBbLb5YDI91JvhmfgwE8dbXGG/jPGglssN4eofhHf6YLGCqS6kNPVaXFPmvigwHobe
         LEzqjkX4eXoP0cKd8zwvVwoLcIGFL8sVYREvHINTYsNTB4KmRQoeXfuxtI2xMeZdzP
         5xfLhii/5wbRCKYsDoEBGI81OpERBKn3HG+uXUfHBYfm2FWFYAZOo3dDSaBX93sl6F
         B2jp0Bqxz9YRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/2/19 1:50 PM, Dmitry Osipenko wrote:
> 02.12.2019 23:09, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 11/28/19 5:25 AM, Dmitry Osipenko wrote:
>>> 28.11.2019 01:57, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> On 11/27/19 7:14 AM, Dmitry Osipenko wrote:
>>>>> 27.11.2019 07:59, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2, clk_out_3 wit=
h
>>>>>> mux and gate for each of these clocks.
>>>>>>
>>>>>> Currently these PMC clocks are registered by Tegra clock driver usin=
g
>>>>>> clk_register_mux and clk_register_gate by passing PMC base address
>>>>>> and register offsets and PMC programming for these clocks happens
>>>>>> through direct PMC access by the clock driver.
>>>>>>
>>>>>> With this, when PMC is in secure mode any direct PMC access from the
>>>>>> non-secure world does not go through and these clocks will not be
>>>>>> functional.
>>>>>>
>>>>>> This patch adds these clocks registration with PMC as a clock provid=
er
>>>>>> for these clocks. clk_ops callback implementations for these clocks
>>>>>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC
>>>>>> programming
>>>>>> in secure mode and non-secure mode.
>>>>>>
>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>> ---
>>>>>>  =C2=A0=C2=A0 drivers/soc/tegra/pmc.c | 330
>>>>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>  =C2=A0=C2=A0 1 file changed, 330 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>>>>> index ea0e11a09c12..a353f6d0a832 100644
>>>>>> --- a/drivers/soc/tegra/pmc.c
>>>>>> +++ b/drivers/soc/tegra/pmc.c
>>>>>> @@ -13,6 +13,9 @@
>>>>>>  =C2=A0=C2=A0 =C2=A0 #include <linux/arm-smccc.h>
>>>>>>  =C2=A0=C2=A0 #include <linux/clk.h>
>>>>>> +#include <linux/clk-provider.h>
>>>>>> +#include <linux/clkdev.h>
>>>>>> +#include <linux/clk/clk-conf.h>
>>>>>>  =C2=A0=C2=A0 #include <linux/clk/tegra.h>
>>>>>>  =C2=A0=C2=A0 #include <linux/debugfs.h>
>>>>>>  =C2=A0=C2=A0 #include <linux/delay.h>
>>>>>> @@ -48,6 +51,7 @@
>>>>>>  =C2=A0=C2=A0 #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>>>>>>  =C2=A0=C2=A0 #include <dt-bindings/gpio/tegra186-gpio.h>
>>>>>>  =C2=A0=C2=A0 #include <dt-bindings/gpio/tegra194-gpio.h>
>>>>>> +#include <dt-bindings/soc/tegra-pmc.h>
>>>>>>  =C2=A0=C2=A0 =C2=A0 #define PMC_CNTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0
>>>>>>  =C2=A0=C2=A0 #define=C2=A0 PMC_CNTRL_INTR_POLARITY=C2=A0=C2=A0=C2=
=A0 BIT(17) /* inverts INTR
>>>>>> polarity */
>>>>>> @@ -100,6 +104,7 @@
>>>>>>  =C2=A0=C2=A0 #define PMC_WAKE2_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x168
>>>>>>  =C2=A0=C2=A0 #define PMC_SW_WAKE2_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x16c
>>>>>>  =C2=A0=C2=A0 +#define PMC_CLK_OUT_CNTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x1a8
>>>>>>  =C2=A0=C2=A0 #define PMC_SENSOR_CTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1b0
>>>>>>  =C2=A0=C2=A0 #define=C2=A0 PMC_SENSOR_CTRL_SCRATCH_WRITE=C2=A0=C2=
=A0=C2=A0 BIT(2)
>>>>>>  =C2=A0=C2=A0 #define=C2=A0 PMC_SENSOR_CTRL_ENABLE_RST=C2=A0=C2=A0=
=C2=A0 BIT(1)
>>>>>> @@ -155,6 +160,91 @@
>>>>>>  =C2=A0=C2=A0 #define=C2=A0 TEGRA_SMC_PMC_READ=C2=A0=C2=A0=C2=A0 0xa=
a
>>>>>>  =C2=A0=C2=A0 #define=C2=A0 TEGRA_SMC_PMC_WRITE=C2=A0=C2=A0=C2=A0 0x=
bb
>>>>>>  =C2=A0=C2=A0 +struct pmc_clk_mux {
>>>>>> +=C2=A0=C2=A0=C2=A0 struct clk_hw=C2=A0=C2=A0=C2=A0 hw;
>>>>>> +=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0 offs;
>>>>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk;
>>>>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sh=
ift;
>>>>>> +};
>>>>>> +
>>>>>> +#define to_pmc_clk_mux(_hw) container_of(_hw, struct pmc_clk_mux, h=
w)
>>>>>> +
>>>>>> +struct pmc_clk_gate {
>>>>>> +=C2=A0=C2=A0=C2=A0 struct clk_hw=C2=A0=C2=A0=C2=A0 hw;
>>>>>> +=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0 offs;
>>>>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sh=
ift;
>>>>>> +};
>>>>>> +
>>>>>> +#define to_pmc_clk_gate(_hw) container_of(_hw, struct
>>>>>> pmc_clk_gate, hw)
>>>>>> +
>>>>>> +struct pmc_clk_init_data {
>>>>>> +=C2=A0=C2=A0=C2=A0 char *mux_name;
>>>>>> +=C2=A0=C2=A0=C2=A0 char *gate_name;
>>>>>> +=C2=A0=C2=A0=C2=A0 const char **parents;
>>>>>> +=C2=A0=C2=A0=C2=A0 int num_parents;
>>>>>> +=C2=A0=C2=A0=C2=A0 int mux_id;
>>>>>> +=C2=A0=C2=A0=C2=A0 int gate_id;
>>>>>> +=C2=A0=C2=A0=C2=A0 char *dev_name;
>>>>>> +=C2=A0=C2=A0=C2=A0 u8 mux_shift;
>>>>>> +=C2=A0=C2=A0=C2=A0 u8 gate_shift;
>>>>>> +=C2=A0=C2=A0=C2=A0 u8 init_parent_index;
>>>>>> +=C2=A0=C2=A0=C2=A0 int init_state;
>>>>>> +};
>>>>>> +
>>>>>> +static const char *clk_out1_parents[] =3D { "clk_m", "clk_m_div2",
>>>>>> +=C2=A0=C2=A0=C2=A0 "clk_m_div4", "extern1",
>>>>>> +};
>>>>>> +
>>>>>> +static const char *clk_out2_parents[] =3D { "clk_m", "clk_m_div2",
>>>>>> +=C2=A0=C2=A0=C2=A0 "clk_m_div4", "extern2",
>>>>>> +};
>>>>>> +
>>>>>> +static const char *clk_out3_parents[] =3D { "clk_m", "clk_m_div2",
>>>>>> +=C2=A0=C2=A0=C2=A0 "clk_m_div4", "extern3",
>>>>>> +};
>>>>>> +
>>>>>> +static struct pmc_clk_init_data tegra_pmc_clks_data[] =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_name =3D "clk_out_1=
_mux",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_name =3D "clk_out_=
1",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parents =3D clk_out1_pa=
rents,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D ARRAY_S=
IZE(clk_out1_parents),
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_id =3D TEGRA_PMC_CL=
K_OUT_1_MUX,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_id =3D TEGRA_PMC_C=
LK_OUT_1,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_name =3D "extern1",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_shift =3D 6,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_shift =3D 2,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_parent_index =3D 3=
,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_state =3D 1,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0 {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_name =3D "clk_out_2=
_mux",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_name =3D "clk_out_=
2",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parents =3D clk_out2_pa=
rents,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D ARRAY_S=
IZE(clk_out2_parents),
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_id =3D TEGRA_PMC_CL=
K_OUT_2_MUX,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_id =3D TEGRA_PMC_C=
LK_OUT_2,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_name =3D "extern2",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_shift =3D 14,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_shift =3D 10,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_parent_index =3D 0=
,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_state =3D 0,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +=C2=A0=C2=A0=C2=A0 {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_name =3D "clk_out_3=
_mux",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_name =3D "clk_out_=
3",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parents =3D clk_out3_pa=
rents,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =3D ARRAY_S=
IZE(clk_out3_parents),
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_id =3D TEGRA_PMC_CL=
K_OUT_3_MUX,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_id =3D TEGRA_PMC_C=
LK_OUT_3,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_name =3D "extern3",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_shift =3D 22,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_shift =3D 18,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_parent_index =3D 0=
,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_state =3D 0,
>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>> +};
>>>>>> +
>>>>>>  =C2=A0=C2=A0 struct tegra_powergate {
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct generic_pm_domain genpd=
;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tegra_pmc *pmc;
>>>>>> @@ -254,6 +344,9 @@ struct tegra_pmc_soc {
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct tegra_wake_event =
*wake_events;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int num_wake_events;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_init_data *pmc_clks_data;
>>>>>> +=C2=A0=C2=A0=C2=A0 unsigned int num_pmc_clks;
>>>>>>  =C2=A0=C2=A0 };
>>>>>>  =C2=A0=C2=A0 =C2=A0 static const char * const tegra186_reset_source=
s[] =3D {
>>>>>> @@ -2163,6 +2256,228 @@ static int tegra_pmc_clk_notify_cb(struct
>>>>>> notifier_block *nb,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NOTIFY_OK;
>>>>>>  =C2=A0=C2=A0 }
>>>>>>  =C2=A0=C2=A0 +static void pmc_clk_fence_udelay(u32 offset)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 tegra_pmc_readl(pmc, offset);
>>>>>> +=C2=A0=C2=A0=C2=A0 /* pmc clk propagation delay 2 us */
>>>>>> +=C2=A0=C2=A0=C2=A0 udelay(2);
>>>>>> +}
>>>>>> +
>>>>>> +static u8 pmc_clk_mux_get_parent(struct clk_hw *hw)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_mux *mux =3D to_pmc_clk_mux(hw);
>>>>>> +=C2=A0=C2=A0=C2=A0 int num_parents =3D clk_hw_get_num_parents(hw);
>>>>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 val =3D tegra_pmc_readl(pmc, mux->offs) >> mux->=
shift;
>>>>>> +=C2=A0=C2=A0=C2=A0 val &=3D mux->mask;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 if (val >=3D num_parents)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 return val;
>>>>>> +}
>>>>>> +
>>>>>> +static int pmc_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_mux *mux =3D to_pmc_clk_mux(hw);
>>>>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 val =3D tegra_pmc_readl(pmc, mux->offs);
>>>>>> +=C2=A0=C2=A0=C2=A0 val &=3D ~(mux->mask << mux->shift);
>>>>>> +=C2=A0=C2=A0=C2=A0 val |=3D index << mux->shift;
>>>>>> +=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, val, mux->offs);
>>>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_fence_udelay(mux->offs);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct clk_ops pmc_clk_mux_ops =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 .get_parent =3D pmc_clk_mux_get_parent,
>>>>>> +=C2=A0=C2=A0=C2=A0 .set_parent =3D pmc_clk_mux_set_parent,
>>>>>> +=C2=A0=C2=A0=C2=A0 .determine_rate =3D __clk_mux_determine_rate,
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk *
>>>>>> +tegra_pmc_clk_mux_register(const char *name, const char * const
>>>>>> *parent_names,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int num_parents, unsigned long flags,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unsigned long offset, u32 shift, u32 mask)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 struct clk_init_data init;
>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_mux *mux;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
>>>>>> +=C2=A0=C2=A0=C2=A0 if (!mux)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-ENOMEM);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 init.name =3D name;
>>>>>> +=C2=A0=C2=A0=C2=A0 init.ops =3D &pmc_clk_mux_ops;
>>>>>> +=C2=A0=C2=A0=C2=A0 init.parent_names =3D parent_names;
>>>>>> +=C2=A0=C2=A0=C2=A0 init.num_parents =3D num_parents;
>>>>>> +=C2=A0=C2=A0=C2=A0 init.flags =3D flags;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 mux->hw.init =3D &init;
>>>>>> +=C2=A0=C2=A0=C2=A0 mux->offs =3D offset;
>>>>>> +=C2=A0=C2=A0=C2=A0 mux->mask =3D mask;
>>>>>> +=C2=A0=C2=A0=C2=A0 mux->shift =3D shift;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 return clk_register(NULL, &mux->hw);
>>>>>> +}
>>>>>> +
>>>>>> +static int pmc_clk_is_enabled(struct clk_hw *hw)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_gate *gate =3D to_pmc_clk_gate(hw=
);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 return tegra_pmc_readl(pmc, gate->offs) & BIT(ga=
te->shift) ? 1
>>>>>> : 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void pmc_clk_set_state(struct clk_hw *hw, int state)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_gate *gate =3D to_pmc_clk_gate(hw=
);
>>>>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 val =3D tegra_pmc_readl(pmc, gate->offs);
>>>>>> +=C2=A0=C2=A0=C2=A0 val =3D state ? (val | BIT(gate->shift)) : (val =
&
>>>>>> ~BIT(gate->shift));
>>>>>> +=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, val, gate->offs);
>>>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_fence_udelay(gate->offs);
>>>>>> +}
>>>>>> +
>>>>>> +static int pmc_clk_enable(struct clk_hw *hw)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_set_state(hw, 1);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void pmc_clk_disable(struct clk_hw *hw)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_set_state(hw, 0);
>>>>>> +}
>>>>>> +
>>>>>> +static const struct clk_ops pmc_clk_gate_ops =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 .is_enabled =3D pmc_clk_is_enabled,
>>>>>> +=C2=A0=C2=A0=C2=A0 .enable =3D pmc_clk_enable,
>>>>>> +=C2=A0=C2=A0=C2=A0 .disable =3D pmc_clk_disable,
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk *
>>>>>> +tegra_pmc_clk_gate_register(const char *name, const char
>>>>>> *parent_name,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags, unsigned long offset,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 u32 shift)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 struct clk_init_data init;
>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_gate *gate;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
>>>>>> +=C2=A0=C2=A0=C2=A0 if (!gate)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-ENOMEM);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 init.name =3D name;
>>>>>> +=C2=A0=C2=A0=C2=A0 init.ops =3D &pmc_clk_gate_ops;
>>>>>> +=C2=A0=C2=A0=C2=A0 init.parent_names =3D &parent_name;
>>>>>> +=C2=A0=C2=A0=C2=A0 init.num_parents =3D 1;
>>>>>> +=C2=A0=C2=A0=C2=A0 init.flags =3D flags;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 gate->hw.init =3D &init;
>>>>>> +=C2=A0=C2=A0=C2=A0 gate->offs =3D offset;
>>>>>> +=C2=A0=C2=A0=C2=A0 gate->shift =3D shift;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 return clk_register(NULL, &gate->hw);
>>>>>> +}
>>>>>> +
>>>>>> +static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_node *=
np)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 struct clk *clkmux, *clk, *parent;
>>>>>> +=C2=A0=C2=A0=C2=A0 struct clk_onecell_data *clk_data;
>>>>>> +=C2=A0=C2=A0=C2=A0 unsigned int num_clks;
>>>>>> +=C2=A0=C2=A0=C2=A0 int i, ret;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 /* each pmc clock output has a mux and a gate */
>>>>>> +=C2=A0=C2=A0=C2=A0 num_clks =3D pmc->soc->num_pmc_clks * 2;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 if (!num_clks)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 clk_data =3D kmalloc(sizeof(*clk_data), GFP_KERN=
EL);
>>>>>> +=C2=A0=C2=A0=C2=A0 if (!clk_data)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 clk_data->clks =3D kcalloc(TEGRA_PMC_CLK_MAX,
>>>>>> sizeof(*clk_data->clks),
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
>>>>>> +=C2=A0=C2=A0=C2=A0 if (!clk_data->clks)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_clkdata;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 clk_data->clk_num =3D num_clks;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < pmc->soc->num_pmc_clks; i++) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pmc_clk_init_data=
 *data;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D pmc->soc->pmc_c=
lks_data + i;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkmux =3D tegra_pmc_clk=
_mux_register(data->mux_name,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data->parents,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data->num_parents,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 CLK_SET_RATE_NO_REPARENT |
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 CLK_SET_RATE_PARENT,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 PMC_CLK_OUT_CNTRL,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data->mux_shift, 3);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(clkmux))
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
goto free_clks;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_data->clks[data->mux=
_id] =3D clkmux;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk =3D tegra_pmc_clk_ga=
te_register(data->gate_name,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 data->mux_name,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CLK_SET_RATE_PARENT,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 PMC_CLK_OUT_CNTRL,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 data->gate_shift);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(clk))
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
goto free_clks;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_data->clks[data->gat=
e_id] =3D clk;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D clk_set_parent(c=
lk, clkmux);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
pr_err("failed to set parent of %s to %s\n",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, __clk_get_name(clk),
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __clk_get_name(clkmux));
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_register_clkdev(clk,=
 data->dev_name, data->gate_name);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* configure initial clo=
ck parent and state */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent =3D clk_get_sys(d=
ata->gate_name,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->parents[data->=
init_parent_index]);
> Couldn't the default parent be defined using "assigned clock" in a
> device-tree? Please see "Assigned clock parents and rates" in the doc.
>
> https://www.kernel.org/doc/Documentation/devicetree/bindings/clock/clock-=
bindings.txt
>
> Then you could simply use of_clk_set_defaults(pmc->dev->of_node, true).

Yes, of_clk_add_provider() does of_clk_set_defaults which sets based on=20
assigned parents and clock rates.

This need device tree to specify assigned clock parent properties. Will=20
update device tree and remove init parent from the driver.

>
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(parent)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D clk_set_parent(clkmux, parent);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (ret < 0) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("failed to set parent of %s to %s\n",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__=
, __clk_get_name(clkmux),
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __clk_ge=
t_name(parent));
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(1);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->init_state) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (clk_prepare_enable(clk)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("failed to enable %s\n", __func__,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __clk_ge=
t_name(clk));
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(1);
>>> Alternatively you could write it like this:
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0err =3D clk_prepare_enable(clk);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0WARN_ON(err, "failed to enable %s: %d\n",
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __clk_get_name(clk), err);
>>>
>>>>> Should be a bit better to move the WARN_ON to the end of errors
>>>>> handling
>>>>> in order to catch all possible errors:
>>>>>
>>>>> @@ -2510,6 +2510,7 @@ static void tegra_pmc_clock_register(struct
>>>>> tegra_pmc *pmc,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>>
>>>>>  =C2=A0=C2=A0 free_clks:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(1);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(clk_dat=
a->clks);
>>>>>  =C2=A0=C2=A0 free_clkdata:
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(clk_dat=
a);
>>>> Reason I had WARN_ON right during clk_set_parent failure is to have th=
e
>>>> loop continue for subsequence pmc clocks registration instead of
>>>> terminating all pmc clocks registration.
>>> Ah, okay. Nevertheless this WARN_ON in the end shouldn't be the least
>>> (IMO).
>> Hi Dmitry, Just want to be clear on the above comment. Are you
>> suggesting to add additional WARN_ON at the end?
> Yes, it was my suggestion.
>
>> Thought WARN_ON right during corresponding clock failure with warn
>> message showing clock names will be clear and also other clocks still
>> should be registered.
>>
>> To add additional WARN_ON at the end need to track status of each clock
>> and use that to as warn condition.
> You could add a warning/error message to every point of failure.
>
> Primarily, it is important not to miss a error. Secondarily, it is
> important to make diagnostic message meaningful.
>
> Realistically, I doubt that this chunk of code will ever fail once it is
> known to work well. So it will be nice to have a more detailed
> diagnostics (just in a case), but it shouldn't be a must.

OK, Will add additional WARN message "failed registering PMC clocks" at=20
the end.

