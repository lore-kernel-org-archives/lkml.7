Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E51C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AE42077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="B0W8Q5Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLJTTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:19:35 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8902 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJTTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:19:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5defef970000>; Tue, 10 Dec 2019 11:18:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 10 Dec 2019 11:18:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 10 Dec 2019 11:18:53 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Dec
 2019 19:18:53 +0000
Received: from [10.2.174.71] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Dec
 2019 19:18:51 +0000
Subject: Re: [PATCH v3 03/15] soc: tegra: Add Tegra PMC clock registrations
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
 <b35916e1-c6ee-52ca-9111-5ae109437b6e@nvidia.com>
 <ccb715cc-c927-ea91-a26e-24d6eeeeef1a@gmail.com>
 <ee1d39d4-9a57-da9b-fce6-8130dac1d2fd@nvidia.com>
 <db3bee1e-1bfa-2f9e-9ed1-91b98554556a@gmail.com>
 <22a2f8bd-561d-f4c6-4eef-bb61095c53b2@nvidia.com>
 <5a5cfa74-66be-5c7a-04eb-88c355851c59@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <302d8483-513c-9c20-e4d4-1e24f2b317d6@nvidia.com>
Date:   Tue, 10 Dec 2019 11:18:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5a5cfa74-66be-5c7a-04eb-88c355851c59@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576005527; bh=nSHPQRJtbbzTaMMJDPqshfJCmi/GwjGhrtfnMwUJLaI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=B0W8Q5LpqO32TI3xWEwQx0LT8eQMvWgXZLszXRSbB8TBCxrSlsceBtBnkH1UOyFDQ
         mlB3aa0PLKPpV/bzhLn1+MEVDffLWKWl1lWK6UzyuvYuFjCjYtQdbS6GI8J00nRgdf
         8nJeFrvRzhlyWgIOONKA5rNPFDYabLTCmpxCAhtdTQ6trhGDJa6zRipQe97GtMbwoT
         cgcPcjuY9g+t/W1ryMF9taW7HLd2n4wI/4MeDZqdfBaYPBtBtKH1LI4gl8g3WZI8EH
         kwBMDIvyDOCOJ2be3kLnySp45FQ5pTH1uE1fcr6YNZpDpDv2dp8VUh0shZ1SzXFcPh
         sT7kcJhNaE7Hg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/19 10:30 AM, Dmitry Osipenko wrote:
> 10.12.2019 20:48, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 12/10/19 9:41 AM, Dmitry Osipenko wrote:
>>> 09.12.2019 23:46, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> On 12/9/19 12:12 PM, Dmitry Osipenko wrote:
>>>>> 08.12.2019 00:36, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>> On 12/7/19 11:59 AM, Sowjanya Komatineni wrote:
>>>>>>> On 12/7/19 8:00 AM, Dmitry Osipenko wrote:
>>>>>>>> 07.12.2019 18:53, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>>>> 07.12.2019 18:47, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>>>>> 07.12.2019 17:28, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
>>>>>>>>>>> 06.12.2019 05:48, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
>>>>>>>>>>>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2, clk_out=
_3
>>>>>>>>>>>> with
>>>>>>>>>>>> mux and gate for each of these clocks.
>>>>>>>>>>>>
>>>>>>>>>>>> Currently these PMC clocks are registered by Tegra clock drive=
r
>>>>>>>>>>>> using
>>>>>>>>>>>> clk_register_mux and clk_register_gate by passing PMC base add=
ress
>>>>>>>>>>>> and register offsets and PMC programming for these clocks happ=
ens
>>>>>>>>>>>> through direct PMC access by the clock driver.
>>>>>>>>>>>>
>>>>>>>>>>>> With this, when PMC is in secure mode any direct PMC access
>>>>>>>>>>>> from the
>>>>>>>>>>>> non-secure world does not go through and these clocks will not=
 be
>>>>>>>>>>>> functional.
>>>>>>>>>>>>
>>>>>>>>>>>> This patch adds these clocks registration with PMC as a clock
>>>>>>>>>>>> provider
>>>>>>>>>>>> for these clocks. clk_ops callback implementations for these
>>>>>>>>>>>> clocks
>>>>>>>>>>>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC
>>>>>>>>>>>> programming
>>>>>>>>>>>> in secure mode and non-secure mode.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>>>>>>>> ---
>>>>>>>>>> [snip]
>>>>>>>>>>
>>>>>>>>>>>> +
>>>>>>>>>>>> +static const struct clk_ops pmc_clk_gate_ops =3D {
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 .is_enabled =3D pmc_clk_is_enabled,
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 .enable =3D pmc_clk_enable,
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 .disable =3D pmc_clk_disable,
>>>>>>>>>>>> +};
>>>>>>>>>>> What's the benefit of separating GATE from the MUX?
>>>>>>>>>>>
>>>>>>>>>>> I think it could be a single clock.
>>>>>>>>>> According to TRM:
>>>>>>>>>>
>>>>>>>>>> 1. GATE and MUX are separate entities.
>>>>>>>>>>
>>>>>>>>>> 2. GATE is the parent of MUX (see PMC's CLK_OUT paths diagram in
>>>>>>>>>> TRM).
>>>>>>>>>>
>>>>>>>>>> 3. PMC doesn't gate EXTPERIPH clock but could "force-enable" it,
>>>>>>>>>> correct?
>>>>>> Was following existing clk-tegra-pmc as I am not sure of reason for
>>>>>> having these clocks registered as separate mux and gate clocks.
>>>>>>
>>>>>> Yes, PMC clocks can be registered as single clock and can use clk_op=
s
>>>>>> for set/get parent and enable/disable.
>>>>>>
>>>>>> enable/disable of PMC clocks is for force-enable to force the clock =
to
>>>>>> run regardless of ACCEPT_REQ or INVERT_REQ.
>>>>>>
>>>>>>>>> 4. clk_m_div2/4 are internal PMC OSC dividers and thus these cloc=
ks
>>>>>>>>> should belong to PMC.
>>>>>>>> Also, it should be "osc" and not "clk_m".
>>>>>>> I followed the same parents as it were in existing clk-tegra-pmc
>>>>>>> driver.
>>>>>>>
>>>>>>> Yeah they are wrong and they should be from osc and not clk_m.
>>>>>>>
>>>>>>> Will fix in next version.
>>>>>>>
>>>>> Could you please describe the full EXTPERIPH clock topology and how t=
he
>>>>> pinmux configuration is related to it all?
>>>>>
>>>>> What is internal to the Tegra chip and what are the external outputs?
>>>>>
>>>>> Is it possible to bypass PMC on T30+ for the EXTPERIPH clocks?
>>>> PMC CLK1/2/3 possible sources are OSC_DIV1, OSC_DIV2, OSC_DIV4,
>>>> EXTPERIPH from CAR.
>>>>
>>>> OSC_DIV1/2/4 are with internal dividers at the OSC Pads
>>>>
>>>> EXTPERIPH is from CAR and it has reset and enable controls along with
>>>> clock source selections to choose one of the PLLA_OUT0, CLK_S,
>>>> PLLP_OUT0, CLK_M, PLLE_OUT0
>>> Are you sure that EXTPERIPH has a reset? What will it reset? Why it's
>>> not documented in TRM?
>> Yes, Extperiph1/2/3 has RST part of CAR RST_DEVICES_V bits 24/25/26
> Are these bits not documented in a public TRMs? I checked
> T30/114/124/210 TRMs and CLK_RST_CONTROLLER_RST_DEVICES_V_0 doesn't have
> those bits in the docs.
>
Yeah these bits are missing in all Tegra TRM docs. Will request for=20
having EXTPERIPH reset bits to be updated in TRM...
>>>> So, PMC CLK1/2/4 possible parents are OSC_DIV1, OSC_DIV2, OSC_DIV4, EX=
TERN.
>>>>
>>>>
>>>> CLK1/2/3 also has Pinmux to route EXTPERIPH output on to these pins.
>>> Could you please clarify what are "these" pins? Perhaps you meant the
>>> EXTERN pin of PMC?
>> By CLK1/2/3 pins, I am referring to CLK_OUT_1/2/3 pins from Tegra
> I see now what you meant, thanks.
>
> [snip}
