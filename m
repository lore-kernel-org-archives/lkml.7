Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EAEC33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB150207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="U8GuJADL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgAHACj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:02:39 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9136 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAHACi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 19:02:38 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e151c090000>; Tue, 07 Jan 2020 16:02:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 16:02:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 Jan 2020 16:02:35 -0800
Received: from [10.2.175.47] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 00:02:34 +0000
Subject: Re: [PATCH v6 00/19] Move PMC clocks into Tegra PMC driver
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
 <4f52bc6e-3e97-f5fb-ce20-be7b55e688ee@gmail.com>
 <d0447620-48bb-ab2a-1f5f-f8a62aa736f7@nvidia.com>
 <1e603a95-fb6b-1b8a-a0c2-9b47666da79a@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <d70a2735-ee51-be91-b930-27fa0d3b5475@nvidia.com>
Date:   Tue, 7 Jan 2020 16:02:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1e603a95-fb6b-1b8a-a0c2-9b47666da79a@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578441738; bh=a3kYPywr7Ja6bjEMsdkRdmbdRNkWoBL9z8a1eJt7xHA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=U8GuJADL1MvsclqrG+AvDjWCmvrdJb9Vzo8mgmqQvY61LxhwWZQ/2YyIfQNNVFqyv
         exCyAXrfDlgUPfscuEVK2VwU2irFgps5jiE5o8B897B1isZwjl2DJRn6EIzGdA1Rcn
         H/684TiyMoxNgJiwR/V4BPtXwrYCCettRlWoaKk9PRPi+Q93TQUmnzeO3CV3wt0X/X
         USM7fceCB2/vkT50qhzh6iFUHIODU2KAeptyFn6MIfY1Gn5mV5kCPQcmUPA6Y1aKxz
         kFokMvHoRqjrr9gWBbdWnZLhLWfdCT4Oyr3GJZemeuaTChEUL8NS9S70HJWeiiCSPc
         pgmuvak/oA+Ew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/20 3:28 PM, Dmitry Osipenko wrote:
> 08.01.2020 02:24, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 1/7/20 3:01 PM, Dmitry Osipenko wrote:
>>> Hello Sowjanya,
>>>
>>> 07.01.2020 07:13, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> This patch series moves Tegra PMC clocks from clock driver to pmc driv=
er
>>>> along with the device trees changes and audio driver which uses one of
>>>> the pmc clock for audio mclk.
>>>>
>>>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
>>>> are currently registered by Tegra clock driver using clk_regiser_mux a=
nd
>>>> clk_register_gate which performs direct Tegra PMC register access.
>>>>
>>>> When Tegra PMC is in secure mode, any access from non-secure world wil=
l
>>>> not go through.
>>>>
>>>> This patch series adds these Tegra PMC clocks and blink controls to
>>>> Tegra
>>>> PMC driver with PMC as clock provider and removes them from Tegra cloc=
k
>>>> driver.
>>>>
>>>> PMC clock clk_out_1 is dedicated for audio mclk from Tegra30 thru
>>>> Tegra210
>>>> and clock driver does inital parent configuration for it and enables
>>>> them.
>>>> But this clock should be taken care by audio driver as there is no nee=
d
>>>> to have this clock pre enabled.
>>>>
>>>> So, this series also includes patch that updates ASoC driver to take
>>>> care of parent configuration for mclk if device tree don't specify
>>>> initial parent configuration using assigned-clock-parents and controls
>>>> audio mclk enable/disable during ASoC machine startup and shutdown.
>>>>
>>>> DTs are also updated to use clk_out_1 as audio mclk rather than extern=
1.
>>>>
>>>> This series also includes a patch for mclk fallback to extern1 when
>>>> retrieving mclk fails to have this backward compatible of new DT with
>>>> old kernels.
>>>>
>>>> [v6]:=C2=A0=C2=A0=C2=A0 Changes between v5 and v6 are
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- v5 feedback
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Added ASoC machine startup and shutdown cal=
lbacks to control audio
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mclk enable/disable and removed defaul=
t mclk enable from clock
>>>> driver.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Updated tegra_asoc_utils_set_rate to disabl=
e mclk only during PLLA
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rate change and removed disabling PLLA=
 as its already taken
>>>> care by
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pll clock driver.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Removed tegra_asoc_utils_set_rate call from=
 utils_init as set_rate
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is set during machine hw_params and du=
ring utils_init mclk is
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 already in disabled state and this cau=
ses warning during mclk
>>>> disable
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in utils_set_rate.
>>>>
>>>> [v5]:=C2=A0=C2=A0=C2=A0 Changes between v4 and v5 are
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- v4 feedback
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- updated dt-binding pmc YAML schema with mor=
e description on power
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gate nodes and pad configuration state=
 nodes.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- update tegra_asoc_utils_set_rate to disable=
 audio mclk only if
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its in enable state.
>>>>
>>>> [v4]:=C2=A0=C2=A0=C2=A0 Changes between v3 and v4 are
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- v3 Feedback
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Updated clocks clk_m_div2 and clk_m_div4 as=
 osc_div2 and osc_div4.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tegra don't have clk_m_div2, clk_m_div=
4 and they should actually
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be osc_div2 and osc_div4 clocks from o=
sc pads.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Fixed PMC clock parents to use osc, osc_div=
2, osc_div4.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Register each PMC clock as single clock rat=
her than separate
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux and gate clocks.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Update ASoC utils to use resource managed A=
PIs rather than
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 using clk_get and clk_put.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Updated device tree and ASoC driver to use =
clk_out_1 instead of
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_out_1_mux as PMC clocks are regist=
ered as single clock.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Update clock driver init_table to not enabl=
e audio related clocks
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as ASoC utils will do audio clock enab=
les.
>>>>
>>>> [v3]:=C2=A0=C2=A0=C2=A0 Changes between v2 and v3 are
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Removes set parent of clk_out_1_mux to exte=
rn1 and enabling
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extern1 from the clock driver.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Doesn't enable clk_out_1 and blink by defau=
lt in pmc driver
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Updates ASoC driver to take care of audio m=
clk parent
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 configuration incase if device tree do=
n't specify assigned
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock parent properties and enables mc=
lk using both clk_out_1
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and extern1.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- updates all device trees using extern1 as m=
clk in sound node
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to use clk_out_1 from pmc.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- patch for YAML format pmc dt-binding
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Includes v2 feedback
>>>>
>>>> [v2]:=C2=A0=C2=A0=C2=A0 Changes between v1 and v2 are
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- v2 includes patches for adding clk_out_1, c=
lk_out_2, clk_out_3,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blink controls to Tegra PMC driver and=
 removing clk-tegra-pmc.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- feedback related to pmc clocks in Tegra PMC=
 driver from v1
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Removed patches for WB0 PLLM overrides and =
PLLE IDDQ PMC
>>>> programming
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 by the clock driver using helper funct=
ions from Tegra PMC.
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Note:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To use helper functions from PMC drive=
r, PMC early init need to
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 happen prior to using helper functions=
 and these helper
>>>> functions are
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for PLLM Override and PLLE IDDQ progra=
mming in PMC during
>>>> PLLM/PLLE
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock registration which happen in clo=
ck_init prior to Tegra PMC
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 probe.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Moving PLLM/PLLE clocks registration t=
o happen after Tegra PMC
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 impacts other clocks EMC, MC and corre=
sponding tegra_emc_init and
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra_mc_init.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This implementation of configuring PMC=
 registers thru helper
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 functions in clock driver needs proper=
 changes across PMC, Clock,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EMC and MC inits to have it work acros=
s all Tegra platforms.
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Currently PLLM Override is not enabled=
 in the bootloader so proper
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 patches for this fix will be taken car=
e separately.
>>>>
>>>> [v1]:=C2=A0=C2=A0=C2=A0 v1 includes patches for below fixes.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- adding clk_out_1, clk_out_2, clk_out_3, bli=
nk controls to Tegra
>>>> PMC
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver and removing clk-tegra-pmc.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- updated clock provider from tegra_car to pm=
c in the device tree
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra210-smaug.dts that uses clk_out_2=
.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Added helper functions in PMC driver for WB=
0 PLLM overrides and
>>>> PLLE
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IDDQ programming to use by clock drive=
r and updated clock
>>>> driver to
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use these helper functions and removed=
 direct PMC access from
>>>> clock
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver and all pmc base address refere=
nces in clock driver.
>>>>
>>>>
>>>>
>>>>
>>>> Sowjanya Komatineni (19):
>>>>  =C2=A0=C2=A0 dt-bindings: clock: tegra: Change CLK_M_DIV to OSC_DIV c=
locks
>>>>  =C2=A0=C2=A0 clk: tegra: Change CLK_M_DIV clocks to OSC_DIV clocks
>>>>  =C2=A0=C2=A0 clk: tegra: Fix Tegra PMC clock out parents
>>>>  =C2=A0=C2=A0 dt-bindings: tegra: Convert Tegra PMC bindings to YAML
>>>>  =C2=A0=C2=A0 dt-bindings: soc: tegra-pmc: Add Tegra PMC clock binding=
s
>>>>  =C2=A0=C2=A0 soc: tegra: Add Tegra PMC clocks registration into PMC d=
river
>>>>  =C2=A0=C2=A0 dt-bindings: soc: tegra-pmc: Add id for Tegra PMC 32KHz =
blink clock
>>>>  =C2=A0=C2=A0 soc: tegra: Add support for 32KHz blink clock
>>>>  =C2=A0=C2=A0 clk: tegra: Remove tegra_pmc_clk_init along with clk ids
>>>>  =C2=A0=C2=A0 dt-bindings: clock: tegra: Remove pmc clock ids from clo=
ck
>>>> dt-bindings
>>>>  =C2=A0=C2=A0 ASoC: tegra: Use device managed resource APIs to get the=
 clock
>>>>  =C2=A0=C2=A0 ASoC: tegra: Add audio mclk configuration
>>>>  =C2=A0=C2=A0 ASoC: tegra: Add fallback implementation for audio mclk
>>>>  =C2=A0=C2=A0 clk: tegra: Remove audio related clock enables from init=
_table
>>>>  =C2=A0=C2=A0 ARM: dts: tegra: Add clock-cells property to pmc
>>>>  =C2=A0=C2=A0 arm64: tegra: Add clock-cells property to Tegra PMC node
>>>>  =C2=A0=C2=A0 ARM: tegra: Update sound node clocks in device tree
>>>>  =C2=A0=C2=A0 arm64: tegra: smaug: Change clk_out_2 provider to pmc
>>>>  =C2=A0=C2=A0 ASoC: nau8825: change Tegra clk_out_2 provider from tegr=
a_car to pmc
>>>>
>>>>  =C2=A0 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 300
>>>> -----------------
>>>>  =C2=A0 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0 | 354
>>>> +++++++++++++++++++++
>>>>  =C2=A0 .../devicetree/bindings/sound/nau8825.txt=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra114-dalmore.dts=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra114.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra124-apalis.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra124-jetson-tk1.dts=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra124-nyan.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
8 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra124-venice2.dts=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra124.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra20.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra30-apalis.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra30-beaver.dts=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
8 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra30-cardhu.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra30-colibri.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>>>>  =C2=A0 arch/arm/boot/dts/tegra30.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>>>>  =C2=A0 arch/arm64/boot/dts/nvidia/tegra132.dtsi=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>>>>  =C2=A0 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>>  =C2=A0 arch/arm64/boot/dts/nvidia/tegra210.dtsi=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
>>>>  =C2=A0 drivers/clk/tegra/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
>>>>  =C2=A0 drivers/clk/tegra/clk-id.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +-
>>>>  =C2=A0 drivers/clk/tegra/clk-tegra-fixed.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 32 =
+-
>>>>  =C2=A0 drivers/clk/tegra/clk-tegra-pmc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 122 -------
>>>>  =C2=A0 drivers/clk/tegra/clk-tegra114.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 41 +--
>>>>  =C2=A0 drivers/clk/tegra/clk-tegra124.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 46 +--
>>>>  =C2=A0 drivers/clk/tegra/clk-tegra20.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 9 +-
>>>>  =C2=A0 drivers/clk/tegra/clk-tegra210.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 30 +-
>>>>  =C2=A0 drivers/clk/tegra/clk-tegra30.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 31 +-
>>>>  =C2=A0 drivers/clk/tegra/clk.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
>>>>  =C2=A0 drivers/soc/tegra/pmc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 352
>>>> ++++++++++++++++++++
>>>>  =C2=A0 include/dt-bindings/clock/tegra114-car.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +-
>>>>  =C2=A0 include/dt-bindings/clock/tegra124-car-common.h=C2=A0=C2=A0=C2=
=A0 |=C2=A0 18 +-
>>>>  =C2=A0 include/dt-bindings/clock/tegra20-car.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>>  =C2=A0 include/dt-bindings/clock/tegra210-car.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +-
>>>>  =C2=A0 include/dt-bindings/clock/tegra30-car.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +-
>>>>  =C2=A0 include/dt-bindings/soc/tegra-pmc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 =
+
>>>>  =C2=A0 sound/soc/tegra/tegra_alc5632.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 28 +-
>>>>  =C2=A0 sound/soc/tegra/tegra_asoc_utils.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 125=
 ++++----
>>>>  =C2=A0 sound/soc/tegra/tegra_asoc_utils.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 3 +-
>>>>  =C2=A0 sound/soc/tegra/tegra_max98090.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 43 ++-
>>>>  =C2=A0 sound/soc/tegra/tegra_rt5640.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 43 ++-
>>>>  =C2=A0 sound/soc/tegra/tegra_rt5677.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 28 +-
>>>>  =C2=A0 sound/soc/tegra/tegra_sgtl5000.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 28 +-
>>>>  =C2=A0 sound/soc/tegra/tegra_wm8753.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 43 ++-
>>>>  =C2=A0 sound/soc/tegra/tegra_wm8903.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 43 ++-
>>>>  =C2=A0 sound/soc/tegra/tegra_wm9712.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>>>>  =C2=A0 sound/soc/tegra/trimslice.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 39 ++-
>>>>  =C2=A0 49 files changed, 1192 insertions(+), 777 deletions(-)
>>>>  =C2=A0 delete mode 100644
>>>> Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>>>>  =C2=A0 create mode 100644
>>>> Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
>>>>  =C2=A0 delete mode 100644 drivers/clk/tegra/clk-tegra-pmc.c
>>>>  =C2=A0 create mode 100644 include/dt-bindings/soc/tegra-pmc.h
>>>>
>>> I briefly looked through the patches and tested them in all possible
>>> configurations. For now everything looks and works well.
>>>
>>> You could add this to all patches:
>>>
>>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> Thanks Dmitry
> Actually, it will be more accurate if you will add my t-b only to the
> T20/30 patches. I only looked through the T114+ patches without testing
> them, thanks.

Most of patches has changes to t20 through t210.

Just to be clear, do you meant to add Tested-by to patches 6, 8, 11, 12,=20
13 and Reviewed-by tag to all patches?

