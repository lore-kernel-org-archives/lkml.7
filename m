Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03B8C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC5C20659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="X/OabPC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfLDUdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:33:40 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15479 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfLDUdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:33:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de818200001>; Wed, 04 Dec 2019 12:33:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 04 Dec 2019 12:33:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 04 Dec 2019 12:33:32 -0800
Received: from [10.2.160.125] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Dec
 2019 20:33:31 +0000
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
 <bb4853a1-83d7-273d-50df-324570c4a4b8@nvidia.com>
 <bd979864-b3e8-02b1-e0b0-869ddfa8ac67@nvidia.com>
 <41508376-f30b-3761-47bf-c9c87db997dc@nvidia.com>
 <348e9382-9978-0c01-1493-4226c1cd70a3@nvidia.com>
 <74ff9e90-0969-bf53-444c-d643d342d0cb@nvidia.com>
 <f9d85789-b847-ef88-dbd0-2883a45ed9c3@gmail.com>
 <474d4b95-91af-6bfb-c110-d2d232d9b522@nvidia.com>
 <0a16d627-b0e5-eb03-5aa4-ac200bf202b1@nvidia.com>
 <f649394b-18dc-1709-3c84-cbfb37f289f3@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <a867bdae-977a-8aad-3c00-93430a739aef@nvidia.com>
Date:   Wed, 4 Dec 2019 12:33:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f649394b-18dc-1709-3c84-cbfb37f289f3@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575491616; bh=8LD4NRSno4RrYStJF4XjQTaAkviPgAfqinNFjZMK95g=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=X/OabPC1gCf+QvyYUyNypRtzNyg0ZdSAIB77a51SD26ZbK5LcEeft6Y9xQC3HPzt1
         1+aMhN63MqmCPD5Xrc6B7pA74kdMPhJY1+UD7Y3E9ONh7YEgCeMN5nfymPNv3KSO2W
         qVFbI6uJRhUTHGz992A1/nYNmWnWYqGi6s9Vzo7pXv8FHHuG/iou3OivUOjvoA3sn7
         fBYseRPQKXSCSZZxMEW05ygvIAW7QSbcmor6ZL0WPcby88MMe9vTfpGTMEJ7nxlvj6
         tIQVTHekblLhkXw+cLdLNOfD78o+jvdOHaSY74+qpAPTohbeBnYo6Eb11pZyJHZdW0
         57DKYLJZjU14g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/4/19 12:28 PM, Dmitry Osipenko wrote:
> 04.12.2019 23:08, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 12/4/19 8:02 AM, Sowjanya Komatineni wrote:
>>> On 12/4/19 5:39 AM, Dmitry Osipenko wrote:
>>>> 03.12.2019 19:45, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> On 12/2/19 4:07 PM, Sowjanya Komatineni wrote:
>>>>>> On 12/2/19 3:14 PM, Sowjanya Komatineni wrote:
>>>>>>> On 12/2/19 3:10 PM, Sowjanya Komatineni wrote:
>>>>>>>> On 12/2/19 2:58 PM, Sowjanya Komatineni wrote:
>>>>>>>>> On 12/2/19 1:50 PM, Dmitry Osipenko wrote:
>>>>>>>>>> 02.12.2019 23:09, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
>>>>>>>>>>> On 11/28/19 5:25 AM, Dmitry Osipenko wrote:
>>>>>>>>>>>> 28.11.2019 01:57, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
>>>>>>>>>>>>> On 11/27/19 7:14 AM, Dmitry Osipenko wrote:
>>>>>>>>>>>>>> 27.11.2019 07:59, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=
=B5=D1=82:
>>>>>>>>>>>>>>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2,
>>>>>>>>>>>>>>> clk_out_3 with
>>>>>>>>>>>>>>> mux and gate for each of these clocks.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Currently these PMC clocks are registered by Tegra clock
>>>>>>>>>>>>>>> driver using
>>>>>>>>>>>>>>> clk_register_mux and clk_register_gate by passing PMC base
>>>>>>>>>>>>>>> address
>>>>>>>>>>>>>>> and register offsets and PMC programming for these clocks
>>>>>>>>>>>>>>> happens
>>>>>>>>>>>>>>> through direct PMC access by the clock driver.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> With this, when PMC is in secure mode any direct PMC access
>>>>>>>>>>>>>>> from the
>>>>>>>>>>>>>>> non-secure world does not go through and these clocks will
>>>>>>>>>>>>>>> not be
>>>>>>>>>>>>>>> functional.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> This patch adds these clocks registration with PMC as a clo=
ck
>>>>>>>>>>>>>>> provider
>>>>>>>>>>>>>>> for these clocks. clk_ops callback implementations for thes=
e
>>>>>>>>>>>>>>> clocks
>>>>>>>>>>>>>>> uses tegra_pmc_readl and tegra_pmc_writel which supports PM=
C
>>>>>>>>>>>>>>> programming
>>>>>>>>>>>>>>> in secure mode and non-secure mode.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 drivers/soc/tegra/pmc.c | 330
>>>>>>>>>>>>>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 1 file changed, 330 insertions(+)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> diff --git a/drivers/soc/tegra/pmc.c
>>>>>>>>>>>>>>> b/drivers/soc/tegra/pmc.c
>>>>>>>>>>>>>>> index ea0e11a09c12..a353f6d0a832 100644
>>>>>>>>>>>>>>> --- a/drivers/soc/tegra/pmc.c
>>>>>>>>>>>>>>> +++ b/drivers/soc/tegra/pmc.c
>>>>>>>>>>>>>>> @@ -13,6 +13,9 @@
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 #include <linux/arm-smccc.=
h>
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #include <linux/clk.h>
>>>>>>>>>>>>>>> +#include <linux/clk-provider.h>
>>>>>>>>>>>>>>> +#include <linux/clkdev.h>
>>>>>>>>>>>>>>> +#include <linux/clk/clk-conf.h>
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #include <linux/clk/tegra.h>
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #include <linux/debugfs.h>
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #include <linux/delay.h>
>>>>>>>>>>>>>>> @@ -48,6 +51,7 @@
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #include <dt-bindings/pinctrl/pin=
ctrl-tegra-io-pad.h>
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #include <dt-bindings/gpio/tegra1=
86-gpio.h>
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #include <dt-bindings/gpio/tegra1=
94-gpio.h>
>>>>>>>>>>>>>>> +#include <dt-bindings/soc/tegra-pmc.h>
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 #define PMC_CNTRL=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #define=C2=A0 PMC_CNTRL_INTR_POLA=
RITY BIT(17) /* inverts INTR
>>>>>>>>>>>>>>> polarity */
>>>>>>>>>>>>>>> @@ -100,6 +104,7 @@
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #define PMC_WAKE2_STATUS=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x168
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #define PMC_SW_WAKE2_STATUS 0x16c
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 +#define PMC_CLK_OUT_CNTRL 0x1a8
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #define PMC_SENSOR_CTRL 0x1b0
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #define PMC_SENSOR_CTRL_SCRATCH_W=
RITE BIT(2)
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #define=C2=A0 PMC_SENSOR_CTRL_ENA=
BLE_RST BIT(1)
>>>>>>>>>>>>>>> @@ -155,6 +160,91 @@
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #define=C2=A0 TEGRA_SMC_PMC_READ=
=C2=A0=C2=A0=C2=A0 0xaa
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #define=C2=A0 TEGRA_SMC_PMC_WRITE=
=C2=A0=C2=A0=C2=A0 0xbb
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 +struct pmc_clk_mux {
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct clk_hw=C2=A0=C2=A0=C2=A0 hw;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0 offs;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 mask;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 shift;
>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +#define to_pmc_clk_mux(_hw) container_of(_hw, struct
>>>>>>>>>>>>>>> pmc_clk_mux, hw)
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +struct pmc_clk_gate {
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct clk_hw=C2=A0=C2=A0=C2=A0 hw;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0 offs;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 shift;
>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +#define to_pmc_clk_gate(_hw) container_of(_hw, struct
>>>>>>>>>>>>>>> pmc_clk_gate, hw)
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +struct pmc_clk_init_data {
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 char *mux_name;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 char *gate_name;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 const char **parents;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 int num_parents;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 int mux_id;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 int gate_id;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 char *dev_name;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u8 mux_shift;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u8 gate_shift;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u8 init_parent_index;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 int init_state;
>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static const char *clk_out1_parents[] =3D { "clk_m",
>>>>>>>>>>>>>>> "clk_m_div2",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 "clk_m_div4", "extern1",
>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static const char *clk_out2_parents[] =3D { "clk_m",
>>>>>>>>>>>>>>> "clk_m_div2",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 "clk_m_div4", "extern2",
>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static const char *clk_out3_parents[] =3D { "clk_m",
>>>>>>>>>>>>>>> "clk_m_div2",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 "clk_m_div4", "extern3",
>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static struct pmc_clk_init_data tegra_pmc_clks_data[] =3D =
{
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 {
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_name =3D "=
clk_out_1_mux",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_name =3D =
"clk_out_1",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parents =3D cl=
k_out1_parents,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =
=3D ARRAY_SIZE(clk_out1_parents),
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_id =3D TEG=
RA_PMC_CLK_OUT_1_MUX,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_id =3D TE=
GRA_PMC_CLK_OUT_1,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_name =3D "=
extern1",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_shift =3D =
6,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_shift =3D=
 2,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_parent_in=
dex =3D 3,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_state =3D=
 1,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 {
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_name =3D "=
clk_out_2_mux",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_name =3D =
"clk_out_2",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parents =3D cl=
k_out2_parents,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =
=3D ARRAY_SIZE(clk_out2_parents),
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_id =3D TEG=
RA_PMC_CLK_OUT_2_MUX,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_id =3D TE=
GRA_PMC_CLK_OUT_2,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_name =3D "=
extern2",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_shift =3D =
14,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_shift =3D=
 10,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_parent_in=
dex =3D 0,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_state =3D=
 0,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 {
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_name =3D "=
clk_out_3_mux",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_name =3D =
"clk_out_3",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parents =3D cl=
k_out3_parents,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_parents =
=3D ARRAY_SIZE(clk_out3_parents),
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_id =3D TEG=
RA_PMC_CLK_OUT_3_MUX,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_id =3D TE=
GRA_PMC_CLK_OUT_3,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_name =3D "=
extern3",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mux_shift =3D =
22,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gate_shift =3D=
 18,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_parent_in=
dex =3D 0,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_state =3D=
 0,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 struct tegra_powergate {
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ge=
neric_pm_domain genpd;
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct te=
gra_pmc *pmc;
>>>>>>>>>>>>>>> @@ -254,6 +344,9 @@ struct tegra_pmc_soc {
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const str=
uct tegra_wake_event *wake_events;
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned =
int num_wake_events;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_init_data *pmc_clks_data=
;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 unsigned int num_pmc_clks;
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 };
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 static const char * const =
tegra186_reset_sources[] =3D {
>>>>>>>>>>>>>>> @@ -2163,6 +2256,228 @@ static int
>>>>>>>>>>>>>>> tegra_pmc_clk_notify_cb(struct
>>>>>>>>>>>>>>> notifier_block *nb,
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NO=
TIFY_OK;
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 +static void pmc_clk_fence_udelay=
(u32 offset)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 tegra_pmc_readl(pmc, offset);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 /* pmc clk propagation delay 2 us */
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 udelay(2);
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static u8 pmc_clk_mux_get_parent(struct clk_hw *hw)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_mux *mux =3D to_pmc_clk_=
mux(hw);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 int num_parents =3D clk_hw_get_num_pare=
nts(hw);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 val =3D tegra_pmc_readl(pmc, mux->offs)=
 >> mux->shift;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 val &=3D mux->mask;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (val >=3D num_parents)
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 return val;
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static int pmc_clk_mux_set_parent(struct clk_hw *hw, u8
>>>>>>>>>>>>>>> index)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_mux *mux =3D to_pmc_clk_=
mux(hw);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 val =3D tegra_pmc_readl(pmc, mux->offs)=
;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 val &=3D ~(mux->mask << mux->shift);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 val |=3D index << mux->shift;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, val, mux->offs);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_fence_udelay(mux->offs);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static const struct clk_ops pmc_clk_mux_ops =3D {
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 .get_parent =3D pmc_clk_mux_get_parent,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 .set_parent =3D pmc_clk_mux_set_parent,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 .determine_rate =3D __clk_mux_determine=
_rate,
>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static struct clk *
>>>>>>>>>>>>>>> +tegra_pmc_clk_mux_register(const char *name, const char *
>>>>>>>>>>>>>>> const
>>>>>>>>>>>>>>> *parent_names,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_parents, unsigned long flags,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long offset, u32 shift, u32 mask)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct clk_init_data init;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_mux *mux;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 mux =3D kzalloc(sizeof(*mux), GFP_KERNE=
L);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (!mux)
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(=
-ENOMEM);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 init.name =3D name;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 init.ops =3D &pmc_clk_mux_ops;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 init.parent_names =3D parent_names;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 init.num_parents =3D num_parents;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 init.flags =3D flags;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 mux->hw.init =3D &init;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 mux->offs =3D offset;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 mux->mask =3D mask;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 mux->shift =3D shift;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 return clk_register(NULL, &mux->hw);
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static int pmc_clk_is_enabled(struct clk_hw *hw)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_gate *gate =3D to_pmc_cl=
k_gate(hw);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 return tegra_pmc_readl(pmc, gate->offs)=
 &
>>>>>>>>>>>>>>> BIT(gate->shift) ? 1
>>>>>>>>>>>>>>> : 0;
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static void pmc_clk_set_state(struct clk_hw *hw, int state=
)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_gate *gate =3D to_pmc_cl=
k_gate(hw);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 val;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 val =3D tegra_pmc_readl(pmc, gate->offs=
);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 val =3D state ? (val | BIT(gate->shift)=
) : (val &
>>>>>>>>>>>>>>> ~BIT(gate->shift));
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 tegra_pmc_writel(pmc, val, gate->offs);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_fence_udelay(gate->offs);
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static int pmc_clk_enable(struct clk_hw *hw)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_set_state(hw, 1);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static void pmc_clk_disable(struct clk_hw *hw)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 pmc_clk_set_state(hw, 0);
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static const struct clk_ops pmc_clk_gate_ops =3D {
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 .is_enabled =3D pmc_clk_is_enabled,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 .enable =3D pmc_clk_enable,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 .disable =3D pmc_clk_disable,
>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static struct clk *
>>>>>>>>>>>>>>> +tegra_pmc_clk_gate_register(const char *name, const char
>>>>>>>>>>>>>>> *parent_name,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags, unsigned long offset=
,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 shift)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct clk_init_data init;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct pmc_clk_gate *gate;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 gate =3D kzalloc(sizeof(*gate), GFP_KER=
NEL);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (!gate)
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(=
-ENOMEM);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 init.name =3D name;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 init.ops =3D &pmc_clk_gate_ops;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 init.parent_names =3D &parent_name;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 init.num_parents =3D 1;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 init.flags =3D flags;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 gate->hw.init =3D &init;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 gate->offs =3D offset;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 gate->shift =3D shift;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 return clk_register(NULL, &gate->hw);
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +static void tegra_pmc_clock_register(struct tegra_pmc *pmc=
,
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct devi=
ce_node *np)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct clk *clkmux, *clk, *parent;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct clk_onecell_data *clk_data;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 unsigned int num_clks;
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 int i, ret;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 /* each pmc clock output has a mux and =
a gate */
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 num_clks =3D pmc->soc->num_pmc_clks * 2=
;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (!num_clks)
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 clk_data =3D kmalloc(sizeof(*clk_data),=
 GFP_KERNEL);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (!clk_data)
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 clk_data->clks =3D kcalloc(TEGRA_PMC_CL=
K_MAX,
>>>>>>>>>>>>>>> sizeof(*clk_data->clks),
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (!clk_data->clks)
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_clkda=
ta;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 clk_data->clk_num =3D num_clks;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < pmc->soc->num_pmc_clk=
s; i++) {
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pmc_clk_=
init_data *data;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D pmc->s=
oc->pmc_clks_data + i;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkmux =3D tegr=
a_pmc_clk_mux_register(data->mux_name,
>>>>>>>>>>>>>>> + data->parents,
>>>>>>>>>>>>>>> + data->num_parents,
>>>>>>>>>>>>>>> + CLK_SET_RATE_NO_REPARENT |
>>>>>>>>>>>>>>> + CLK_SET_RATE_PARENT,
>>>>>>>>>>>>>>> + PMC_CLK_OUT_CNTRL,
>>>>>>>>>>>>>>> + data->mux_shift, 3);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(clkm=
ux))
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto free_clks;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> + clk_data->clks[data->mux_id] =3D clkmux;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk =3D tegra_p=
mc_clk_gate_register(data->gate_name,
>>>>>>>>>>>>>>> + data->mux_name,
>>>>>>>>>>>>>>> + CLK_SET_RATE_PARENT,
>>>>>>>>>>>>>>> + PMC_CLK_OUT_CNTRL,
>>>>>>>>>>>>>>> + data->gate_shift);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(clk)=
)
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto free_clks;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> + clk_data->clks[data->gate_id] =3D clk;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D clk_set=
_parent(clk, clkmux);
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 pr_err("failed to set parent of %s to %s\n",
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, __clk_get_nam=
e(clk),
>>>>>>>>>>>>>>> + __clk_get_name(clkmux));
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_register_cl=
kdev(clk, data->dev_name,
>>>>>>>>>>>>>>> data->gate_name);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* configure in=
itial clock parent and state */
>>>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent =3D clk_=
get_sys(data->gate_name,
>>>>>>>>>>>>>>> + data->parents[data->init_parent_index]);
>>>>>>>>>> Couldn't the default parent be defined using "assigned clock" in=
 a
>>>>>>>>>> device-tree? Please see "Assigned clock parents and rates" in th=
e
>>>>>>>>>> doc.
>>>>>>>>>>
>>>>>>>>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/clo=
ck/clock-bindings.txt
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Then you could simply use of_clk_set_defaults(pmc->dev->of_node,
>>>>>>>>>> true).
>>>>>>>>> Yes, of_clk_add_provider() does of_clk_set_defaults which sets
>>>>>>>>> based on assigned parents and clock rates.
>>>>>>>>>
>>>>>>>>> This need device tree to specify assigned clock parent properties=
.
>>>>>>>>> Will update device tree and remove init parent from the driver.
>>>>>>>>>
>>>>>>>> assigned-clock properties should be set in consumer node of these
>>>>>>>> clocks and currently these clocks are not used yet.
>>>>>>>>
>>>>>>>> So will just remove init parent from driver and when these clocks
>>>>>>>> are used device tree can be updated in corresponding consumer node
>>>>>>>> with these properties.
>>>>>>>>
>>>>>>> How about default ON/OFF init state for the clocks? I see
>>>>>>> assigned-clock properties for parent and rate only.
>>>>>>>
>>>>>>> But based on existing clock-tegra-pmc driver, I see clk_out_1 is
>>>>>>> default enabled with extern1 parent for T30 thru T210 platforms.
>>>>>>>
>>>>>>> Peter/Thierry, What was the reason we enable clk_out_1 right from t=
he
>>>>>>> clock registration?
>>>>>>>
>>>>>> clk_out_1 is for audio and its not required to be enabled during the
>>>>>> boot and audio driver can enable/disable it.
>>>>>>
>>>>>> same with blink 32khz which is used for WIFI. WIFI driver can
>>>>>> enable/disable during power up/down sequence and technically as per
>>>>>> design we dont need to have it always on right from the boot.
>>>>>>
>>>>>> So can remove out clocks init states from driver once thierry also
>>>>>> agree on this.
>>>>>>
>>>>> Hi Dmitry,
>>>>>
>>>>> Looking at audio driver, it doesn't take care of mclk which is from
>>>>> clk_out_1 and expects mclk to be always on.
>>>>>
>>>>> So probably we should have this init state enables in pmc driver for
>>>>> 32Khz and clk_out's to not break existing functionality.
>>>> Hello Sowjanya,
>>>>
>>>> IIUC, it's a bug in the device-trees and sound's MCLK actually should =
be
>>>> set to CLK_OUT_1 of PMC instead of CaR's EXTPERIPH1. If that's the cas=
e,
>>>> then the device-trees need to be fixed.
>>> OK, will have this in v3
>> Actually if we change mclk to use clk_out_1, then it will break with old
>> device trees.
>>
>> Currently clk_out_1 parent is set to extern1 as init state by the clock
>> driver and device tree for sound node is using extern1 as mclk works and
>> extern1 itself has enable and disable. But yes implementation wise, its
>> incorrect as mclk should really be clk_out_1.
>>
>> Now, with moving clk_out_1 to tegra PMC, pmc is the clock provider and
>> if we now change the device tree to use CLK_OUT_1 as mclk then it will
>> break old device tree.
> There souldn't be any problem with enabling CLK_OUT_1 by the audio
> driver itself (in the code) if an old device-tree is detected.
>
> 	clk_out_1 =3D clk_get(dev, "clk_out_1");
> 	clk_set_parent(clk_out_1, clk_extern1);
> 	...
> 	data->clk_cdev1 =3D clk_out_1;
>
> Maybe it will be even better to compare clocks for detection of an older =
DT:
>
> 	if (tegra_get_chip_id() > TEGRA20 &&
> 	    clk_is_match(data->clk_cdev1, clk_extern1)) {
> 	...
>
we can do parent init in audio driver which is not an issue.

But I was saying we can keep extern1 as mclk in device tree instead of=20
changing to clk_out_1 from pmc as it will break old device tree becasue=20
we moved clk_out_1 from clock driver to pmc driver.

once we do init parent in audio driver, we still can use extern1 as mclk=20
in device tree.

mclk -> clk_out_1 -> extern1 -> plla_out0 -> plla

with init of clk_out_1 parent to extern1, mclk can use extern1 handle=20
for rate/enable/disable clk operations

>>>>> Regarding using assigned-clock properties for init parent and removin=
g
>>>>> init parent from driver, it also needs consumer node in device tree t=
o
>>>>> be updated to specify assigned-clock properties for default/init
>>>>> parent.
>>>>>
>>>>> This breaks device tree ABI as prior Tegra210 supports audio driver.
>>>> So it's the sound node which should have had the assigned clocks in
>>>> device-tree in order to define route for the audio MCLK clock from CaR
>>>> to PMC.
>>>>
>>>> Given that the audio clocks configuration is the same for all of the
>>>> currently supported boards, I think it will be better to remove the
>>>> entire audio clocks initialization from the clk drivers and move it al=
l
>>>> to the audio driver. It could be something like this:
>>>>
>>>> int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct device *dev)
>>>> {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0...
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0if (!of_find_property(dev->of_node, "assigned=
-clock-parents",
>>>> NULL) &&
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra_get_chip_id() > TEGR=
A20) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_extern1 =3D clk_get(de=
v, "extern1");
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_set_parent(clk_extern1=
, clk_pll_a_out0);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_put(data->clk_cdev1);
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->clk_cdev1 =3D clk_ou=
t_1;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0}
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0...
>>>>
>>>> So now the old device-trees will cointinue to work and new could have
>>>> the assigned-clocks and set MCLK to CLK_OUT_1.
>>>>
>>>> [snip]
>>> Will update clk-tegra, pmc and audio driver to move init state
>>> configuration for extern1 and clk_out_1 into audio driver and will use
>>> assigned clock properties in device tree.
>>>
