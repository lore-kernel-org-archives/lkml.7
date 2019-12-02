Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C2CC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEAE20718
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SItZfW0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfLBSsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:48:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13156 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfLBSsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:48:13 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de55c360000>; Mon, 02 Dec 2019 10:47:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 02 Dec 2019 10:47:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 02 Dec 2019 10:47:31 -0800
Received: from [10.110.103.72] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Dec
 2019 18:47:30 +0000
Subject: Re: [PATCH v2 00/11] Move PMC clocks into Tegra PMC driver
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <mperttunen@nvidia.com>, <sboyd@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
 <79e7bd6a-f138-1e7d-6e0b-435adde3b3e5@gmail.com>
 <04b093fe-5eff-1ad2-9a8a-7674dcb2318a@nvidia.com>
 <ebcce0df-bb7a-2f24-cfbc-daaf3ac6bb4f@nvidia.com>
 <45058e6b-244e-8926-584d-297452873612@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <8afb28cd-a90c-fbc2-1053-70cf6c282057@nvidia.com>
Date:   Mon, 2 Dec 2019 10:47:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <45058e6b-244e-8926-584d-297452873612@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575312438; bh=CHAlviqBQHYGThcNJQKlAWx4Yyq6z2eTR+nIne0O7mo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=SItZfW0yZYRl2taLyxzNuuYEDYBgqAuNzyglraMsnuP+asHFUiN1+DJpsOXbdynP6
         6Ca1bA6UvcyJQvByLC7N1rRfZ8Izv1uJA+1RJMmEU36zpbyw1Q6H4zRIyX5KLGfg2j
         4k5MDSfJJ1TGAwe698WcAv77XHJ+owF2AHTtNOVrlDcXIJ4y/Jy1jvy4bdoWv6eyjE
         A5apg00aL9sa9EkAe/raSDFsHG2aZqJ1myrx5yKVUl6Pk6MHfrft1ZQCDUQQV+4n/5
         ITMQUpS1kVR9HCuyp8GqKvT2wQG7FlQRlosJj/oLfNmtH0gtc7uK+/aYSQx7cPRQlW
         78xxSHhFG2HHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/19 5:06 AM, Dmitry Osipenko wrote:
> 28.11.2019 00:38, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 11/27/19 9:02 AM, Sowjanya Komatineni wrote:
>>> On 11/27/19 6:31 AM, Dmitry Osipenko wrote:
>>>> 27.11.2019 07:59, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls whic=
h
>>>>> are currently registered by Tegra clock driver using clk_regiser_mux
>>>>> and
>>>>> clk_register_gate which performs direct Tegra PMC register access.
>>>>>
>>>>> When Tegra PMC is in secure mode, any access from non-secure world wi=
ll
>>>>> not go through.
>>>>>
>>>>> This patch series adds these Tegra PMC clocks and blink controls to
>>>>> Tegra
>>>>> PMC driver with PMC as clock provider and removed them from Tegra clo=
ck
>>>>> driver. This also adds PMC specific clock id's to use in device tree
>>>>> and
>>>>> removed clock ids of PMC clock from Tegra clock driver.
>>>>>
>>>>> This series also includes patch to update clock provider from tegra_c=
ar
>>>>> to pmc in the device tree tegra210-smaug.dts that uses clk_out_2
>>>>> from PMC.
>>>>>
>>>>> [v2]:=C2=A0=C2=A0=C2=A0 Changes between v1 and v2 are
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- v2 includes patches for adding clk_out_1, =
clk_out_2, clk_out_3,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blink controls to Tegra PMC driver an=
d removing clk-tegra-pmc.
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- feedback related to pmc clocks in Tegra PM=
C driver from v1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0- Removed patches for WB0 PLLM overrides and=
 PLLE IDDQ PMC
>>>>> programming
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 by the clock driver using helper func=
tions from Tegra PMC.
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Note:
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To use helper functions from PMC driv=
er, PMC early init need to
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 happen prior to using helper function=
s and these helper
>>>>> functions are
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for PLLM Override and PLLE IDDQ progr=
amming in PMC during
>>>>> PLLM/PLLE
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock registration which happen in cl=
ock_init prior to Tegra PMC
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 probe.
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Moving PLLM/PLLE clocks registration =
to happen after Tegra PMC
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 impacts other clocks EMC, MC and corr=
esponding tegra_emc_init and
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra_mc_init.
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This implementation of configuring PM=
C registers thru helper
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 functions in clock driver needs prope=
r changes across PMC, Clock,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EMC and MC inits to have it work acro=
ss all Tegra platforms.
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Currently PLLM Override is not enable=
d in the bootloader so
>>>>> proper
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 patches for this fix will be taken ca=
re separately.
>>>> Hello Sowjanya,
>>>>
>>>> Could you please clarify what do you mean by "PLLM Override not enable=
d
>>>> in bootloader"?
>>>>
>>>> There is T124 Nyan Big Chromebook which is supported in upstream kerne=
l,
>>>> it has PLLM Override set by bootloader. I also have T30 Nexus 7 tablet
>>>> which has the PLLM Override set by bootloader as well. It's not clear =
to
>>>> me whether this patch series is supposed to break these devices. If th=
e
>>>> breakage is the case here, then I'm afraid you can't postpone supporti=
ng
>>>> the PLLM Override and a full-featured implementation is needed.
>>> Hi Dmitry,
>>>
>>> Secure boot currently is enabled only on Tegra210 and Tegra210
>>> bootloader doesn't enable PLLM override.
>>>
>>> So PLLM override/PLLE IDDQ being in clock driver currently will not
>>> break on any of existing Tegra platforms.
>>>
>>>> I briefly tried to test this series on T30 and this time it doesn't ha=
ng
>>>> on boot, but somehow WiFi MMC card detection is broken. AFAIK, the WiF=
i
>>>> chip uses the Blink clock source and the clock should be enabled by th=
e
>>>> MMC core because this is how DT part looks like:
>>>>
>>>> brcm_wifi_pwrseq: wifi-pwrseq {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "mmc-pwrseq-simple";
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0clocks =3D <&pmc TEGRA_PMC_CLK_BLINK>;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0clock-names =3D "ext_clock";
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0reset-gpios =3D=C2=A0 <&gpio TEGRA_GPIO(D, 3)=
 GPIO_ACTIVE_LOW>;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0post-power-on-delay-ms =3D <300>;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0power-off-delay-us =3D <300>;
>>>> };
>>>>
>>>> BTW, I=C2=A0 tried this series on a T20 device which also uses the Bli=
nk
>>>> clock for WiFi card and it works. So looks like this patchset has some
>>>> problem in regards to the T30 PMC clocks implementation.
>>>>
>>>> [snip]
>>> Blink init state is set to true for both Tegra20 and Tegra30 and all
>>> go through the same blink programming sequence.
>>>
>>> Will try to add more debug messages to dump registers and will test
>>> blink through device tree on T30 and will get back...
>>>
>>>
>> define value for BLINK uses BIT macro instead of just position. Will fix
>> this in v3.
> Thanks, will try v3 once it will be ready.
>
> I took a look through the T20 board's schematics and seems it doesn't
> use the Blink clock for the WiFi, instead it uses 32k source directly
> from PMU. While T30 board schematics tells that  32k comes out from the
> Tegra chip.
>
> BTW, I'm curious what's the reason for having Blink clock always-ON on
> T20/30, any insights? Looks like it's just some relic from old clk
> driver and it should be safe to drop the always-ON.

T30 cardhu uses 32K from Tegra to WIFI but its only needed to be on=20
during WIFI power up sequence and not required to be on during boot.

I had it enabled as existing clock driver enables it default and dont=20
want to break things if it was left ON intentionally.

Peter/Thierry, Any reason 32K from Blink is enabled to be ON during=20
clock init for T20/T30 in clock-tegra-pmc driver?

Based on the design T30 uses this for WIFI and WIFI driver should be=20
handling this clock enable/disable during power up/down sequence,

so we don't have to enable it default during boot right?

