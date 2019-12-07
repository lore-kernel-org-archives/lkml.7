Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF75C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 21:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099C824677
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 21:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RGkgLXTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLGVgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 16:36:46 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17051 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfLGVgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 16:36:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dec1b650000>; Sat, 07 Dec 2019 13:36:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 07 Dec 2019 13:36:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 07 Dec 2019 13:36:44 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Dec
 2019 21:36:41 +0000
Received: from [10.2.171.190] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Dec 2019
 21:36:39 +0000
Subject: Re: [PATCH v3 03/15] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
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
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alexios.zavras@intel.com>, <alsa-devel@alsa-project.org>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-4-git-send-email-skomatineni@nvidia.com>
 <7cf4ff77-2f33-4ee5-0e09-5aa6aef3e8be@gmail.com>
 <ad3a6743-4b36-fa25-9cc7-72803038ecc5@gmail.com>
 <dc7a057a-0bed-0e6f-0987-edcfec47f867@gmail.com>
 <288a1701-def6-d628-26bc-a305f817bdb1@gmail.com>
 <78644d45-2ae3-121f-99fc-0a46f205907d@nvidia.com>
Message-ID: <b35916e1-c6ee-52ca-9111-5ae109437b6e@nvidia.com>
Date:   Sat, 7 Dec 2019 13:36:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <78644d45-2ae3-121f-99fc-0a46f205907d@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575754599; bh=cnd0L8QMxX0KA6A+dNMO1BMHMk2Pp5YayeRWdRICX20=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=RGkgLXTgzk1pPP+qKWMNtWsV++9Y6kgHYj4+nsAPcsgyRf6FIwWYz5K/P/5B/v4FY
         SaLwq3W4D4AInw3Zv5tLe6nnixjQakvd31kE63qDyD+YLkLsKeiW3hu2TIImEZ01SC
         z7d2VA1AmmmuGQfHO8JTMC89xQS2LnjxKlHBsEKPoMUmgOwNj6ZcXjlObajS5a9HQT
         rCzo0Jd4Cu+6i2pv43bkW02L0cEy04OMf18+6qw98WvJHexQFLHQrOrK2RyI8Y3mQK
         1tRNQrdkR/vlo2xcY7rnTTJHTvmrAwpJUUXrMXtchypM2qOdCrNYQL8V7I44LHZJuo
         7aXsj+9AleNWw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/19 11:59 AM, Sowjanya Komatineni wrote:
>
> On 12/7/19 8:00 AM, Dmitry Osipenko wrote:
>> 07.12.2019 18:53, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> 07.12.2019 18:47, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> 07.12.2019 17:28, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> 06.12.2019 05:48, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2, clk_out_3=20
>>>>>> with
>>>>>> mux and gate for each of these clocks.
>>>>>>
>>>>>> Currently these PMC clocks are registered by Tegra clock driver=20
>>>>>> using
>>>>>> clk_register_mux and clk_register_gate by passing PMC base address
>>>>>> and register offsets and PMC programming for these clocks happens
>>>>>> through direct PMC access by the clock driver.
>>>>>>
>>>>>> With this, when PMC is in secure mode any direct PMC access from the
>>>>>> non-secure world does not go through and these clocks will not be
>>>>>> functional.
>>>>>>
>>>>>> This patch adds these clocks registration with PMC as a clock=20
>>>>>> provider
>>>>>> for these clocks. clk_ops callback implementations for these clocks
>>>>>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC=20
>>>>>> programming
>>>>>> in secure mode and non-secure mode.
>>>>>>
>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>> ---
>>>> [snip]
>>>>
>>>>>> +
>>>>>> +static const struct clk_ops pmc_clk_gate_ops =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0 .is_enabled =3D pmc_clk_is_enabled,
>>>>>> +=C2=A0=C2=A0=C2=A0 .enable =3D pmc_clk_enable,
>>>>>> +=C2=A0=C2=A0=C2=A0 .disable =3D pmc_clk_disable,
>>>>>> +};
>>>>> What's the benefit of separating GATE from the MUX?
>>>>>
>>>>> I think it could be a single clock.
>>>> According to TRM:
>>>>
>>>> 1. GATE and MUX are separate entities.
>>>>
>>>> 2. GATE is the parent of MUX (see PMC's CLK_OUT paths diagram in TRM).
>>>>
>>>> 3. PMC doesn't gate EXTPERIPH clock but could "force-enable" it,=20
>>>> correct?

Was following existing clk-tegra-pmc as I am not sure of reason for=20
having these clocks registered as separate mux and gate clocks.

Yes, PMC clocks can be registered as single clock and can use clk_ops=20
for set/get parent and enable/disable.

enable/disable of PMC clocks is for force-enable to force the clock to=20
run regardless of ACCEPT_REQ or INVERT_REQ.

>>> 4. clk_m_div2/4 are internal PMC OSC dividers and thus these clocks
>>> should belong to PMC.
>> Also, it should be "osc" and not "clk_m".
>
> I followed the same parents as it were in existing clk-tegra-pmc driver.
>
> Yeah they are wrong and they should be from osc and not clk_m.
>
> Will fix in next version.
>
