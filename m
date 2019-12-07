Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F3AC2BBE2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546F424673
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WRQUx8pX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfLGT7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:59:24 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15326 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfLGT7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 14:59:23 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dec04950000>; Sat, 07 Dec 2019 11:59:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 07 Dec 2019 11:59:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 07 Dec 2019 11:59:22 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Dec
 2019 19:59:22 +0000
Received: from [10.2.171.190] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Dec 2019
 19:59:20 +0000
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
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <78644d45-2ae3-121f-99fc-0a46f205907d@nvidia.com>
Date:   Sat, 7 Dec 2019 11:59:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <288a1701-def6-d628-26bc-a305f817bdb1@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575748757; bh=N8cFqw4WsOhmPbQ9i3Ws/JDKp0jPOKAwYAQ2PfxA688=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=WRQUx8pXfXk6QqvjvcVFbQTj3OB0qpTaS+5QXYT2w2+45Ho1Pp+wppaMSmoEHQ/aO
         7OAoE85aTkp2S0iOfIJv5wopk9GS1+ScprLEZSeROxCtd48WIfMM1C5TRgkQuDpwMq
         hyp1apCpin6hTl4fWh+CYSs6sSWohYQStPaeSC59YIw6YvYSs47iNX5q9quNpxo8em
         0Upd5wM178fAm3WchbDVNMdzMd6KPWLg1ocJ3zL5QTTHC5vmX3ZGlKB/jpaHZ9+3Bb
         wucmYE1lM95AMYyJ7kW8EurJuGWqgHQerQfoZF1zhiswi2pOypN5NY44Gdz6VFtCl5
         9BmUpI3nrY4IA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/19 8:00 AM, Dmitry Osipenko wrote:
> 07.12.2019 18:53, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> 07.12.2019 18:47, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> 07.12.2019 17:28, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> 06.12.2019 05:48, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2, clk_out_3 with
>>>>> mux and gate for each of these clocks.
>>>>>
>>>>> Currently these PMC clocks are registered by Tegra clock driver using
>>>>> clk_register_mux and clk_register_gate by passing PMC base address
>>>>> and register offsets and PMC programming for these clocks happens
>>>>> through direct PMC access by the clock driver.
>>>>>
>>>>> With this, when PMC is in secure mode any direct PMC access from the
>>>>> non-secure world does not go through and these clocks will not be
>>>>> functional.
>>>>>
>>>>> This patch adds these clocks registration with PMC as a clock provide=
r
>>>>> for these clocks. clk_ops callback implementations for these clocks
>>>>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC programm=
ing
>>>>> in secure mode and non-secure mode.
>>>>>
>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>> ---
>>> [snip]
>>>
>>>>> +
>>>>> +static const struct clk_ops pmc_clk_gate_ops =3D {
>>>>> +	.is_enabled =3D pmc_clk_is_enabled,
>>>>> +	.enable =3D pmc_clk_enable,
>>>>> +	.disable =3D pmc_clk_disable,
>>>>> +};
>>>> What's the benefit of separating GATE from the MUX?
>>>>
>>>> I think it could be a single clock.
>>> According to TRM:
>>>
>>> 1. GATE and MUX are separate entities.
>>>
>>> 2. GATE is the parent of MUX (see PMC's CLK_OUT paths diagram in TRM).
>>>
>>> 3. PMC doesn't gate EXTPERIPH clock but could "force-enable" it, correc=
t?
>> 4. clk_m_div2/4 are internal PMC OSC dividers and thus these clocks
>> should belong to PMC.
> Also, it should be "osc" and not "clk_m".

I followed the same parents as it were in existing clk-tegra-pmc driver.

Yeah they are wrong and they should be from osc and not clk_m.

Will fix in next version.

