Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7927AC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE8F2176D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qNnAtmCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfLGTfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:35:22 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3590 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfLGTfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 14:35:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5debfef30000>; Sat, 07 Dec 2019 11:35:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 07 Dec 2019 11:35:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 07 Dec 2019 11:35:20 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Dec
 2019 19:35:20 +0000
Received: from [10.2.171.190] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Dec 2019
 19:35:18 +0000
Subject: Re: [PATCH v3 06/15] clk: tegra: Remove tegra_pmc_clk_init along with
 clk ids
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
 <1575600535-26877-7-git-send-email-skomatineni@nvidia.com>
 <3880aa15-c47a-5ab2-dd39-e8a47f6a3d6a@gmail.com>
 <e342a6e7-f213-53b4-1388-23cf61cf6fbb@gmail.com>
 <5938df22-2474-3950-fc33-3e19cbf3da9c@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <c81ccd45-781e-0fce-4f20-65281b8c6119@nvidia.com>
Date:   Sat, 7 Dec 2019 11:35:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5938df22-2474-3950-fc33-3e19cbf3da9c@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575747315; bh=1Ya/CJUQcm/EZA7RBmptW1I45EPwRTjSK1PLRr84L9w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=qNnAtmCZaD7/TaWT3tGDvs+UpjNleA405v5ssZiJme+pxj11GYfLJXunBz7CpwDog
         wvk54G4R4u9JO9bBOB2KnED27BZP5JIYUjfXwhzBiINO9QDmBYwFBPsVh5gF4xXpKq
         MamKyUfyZ6tYUntHh4bi/kddEkP2emMXeXWnbNwBiaozhv+2601DokFnLrngEXg9rW
         zBGZg0u9XjXOhf5LHUyw9M0LLDE9lm49NG4fb2mtAhyYnOijISDDYUJaIVXkFpEn9A
         FrFZS5bVkI2q28X5bojvwqbGXNFCNtFkZcsI8dztG97Zj/+VHcDO5IWEgOHWuqECR9
         xVCHIxTKVSJzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/19 7:04 AM, Dmitry Osipenko wrote:
> 07.12.2019 17:43, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> 07.12.2019 17:33, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> 06.12.2019 05:48, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> Current Tegra clock driver registers PMC clocks clk_out_1, clk_out_2,
>>>> clk_out_3 and blink output in tegra_pmc_init() which does direct Tegra
>>>> PMC access during clk_ops and these PMC register read and write access
>>>> will not happen when PMC is in secure mode.
>>>>
>>>> Any direct PMC register access from non-secure world will not go
>>>> through and all the PMC clocks and blink control are done in Tegra PMC
>>>> driver with PMC as clock provider.
>>>>
>>>> This patch removes tegra_pmc_clk_init along with corresponding clk ids
>>>> from Tegra clock driver.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>> [snip]
>>>
>>>> @@ -1230,9 +1222,6 @@ static struct tegra_clk_init_table init_table[] =
__initdata =3D {
>>>>   	{ TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 1 },
>>>>   	{ TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 1 },
>>>>   	{ TEGRA30_CLK_EXTERN1, TEGRA30_CLK_PLL_A_OUT0, 0, 1 },
>>> Perhaps these clocks do not need to be always-enabled?
>>>
>>> [snip]
>>>
>> Also, EXTERN1 parent configuration should be moved to the audio
>> driver/device-tree as well.
> Ah, I missed that it's done in the patch #10.
Yes its done in Patch#10
>
>> Maybe it even makes sense to move the whole configuration, including
>> PLLA. I don't see why clk driver need to do something for the audio driv=
er.

Current ASoC driver already takes care of PLLA rate and enables.

So PLLA init can be removed from clock driver too. I didn't went through=20
complete audio driver to be confident to remove this.

But PLLA is needed for i2s clock also and currently I2S driver takes=20
care of only I2S clock rate using PLLA as parent set by clock driver and=20
clock driver enables PLLA earlier to have it ready by the time both I2S=20
driver and ASoC driver .

