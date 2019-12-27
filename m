Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1066EC2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 21:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF24920838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 21:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lTrdhLtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfL0VUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 16:20:02 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17303 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL0VUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 16:20:02 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0675740000>; Fri, 27 Dec 2019 13:19:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 27 Dec 2019 13:20:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 27 Dec 2019 13:20:01 -0800
Received: from [10.2.173.37] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Dec
 2019 21:20:00 +0000
Subject: Re: [PATCH v5 12/19] ASoC: tegra: Add initial parent configuration
 for audio mclk
To:     Dmitry Osipenko <digetx@gmail.com>, Mark Brown <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-13-git-send-email-skomatineni@nvidia.com>
 <a6567ff1-7bc2-3ca5-1200-92a63eb44ddb@gmail.com>
 <20191225175736.GC27497@sirena.org.uk>
 <856d8a92-0c24-6722-952c-06b86c706e97@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <dbbce994-27f5-d949-078d-05646100e6be@nvidia.com>
Date:   Fri, 27 Dec 2019 13:19:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <856d8a92-0c24-6722-952c-06b86c706e97@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577481588; bh=jZvV6hBkMM5Yr4UvEkRndXiGnt0j3d2GsRy1bKw+1ZQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=lTrdhLtUMlsmPRtO7bEC9eQVmtszFNAjGEyoJHTAOJ8YDvmYcui+mjFF69f9bWcC+
         OFQ8IWLdsk5RdSDVMkbHkx3KCe21Zq1G3HJaZ6TohE2lccvfrJOKWKs36P0OJ9603T
         Y0WTQ8Ys+blXlqceLQWV0xhIYxm32fNGilkLjhgbH6sjl2BVQHuTSySSt6X+GyUNmC
         taUJ70fgL3aFAIdXl4XNC8/guhno7Q130wn/idkaoNsIF4nC1Mt8ECvC5tFjhFkqiC
         qQWB+vY/2FO9+hSliRute35To65/jV2jle+TCNQ95EpycJWV4rZXedCxHvlM2Tlxzz
         LPRkQ7BA/Beyg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/27/19 6:56 AM, Dmitry Osipenko wrote:
> 25.12.2019 20:57, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On Mon, Dec 23, 2019 at 12:14:34AM +0300, Dmitry Osipenko wrote:
>>> 21.12.2019 01:26, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
>>>> through Tegra210 and currently Tegra clock driver does initial parent
>>>> configuration for audio mclk "clk_out_1" and enables them by default.
>> Please delete unneeded context from mails when replying.  Doing this
>> makes it much easier to find your reply in the message, helping ensure
>> it won't be missed by people scrolling through the irrelevant quoted
>> material.
> Ok
>
>>>> -	clk_disable_unprepare(data->clk_cdev1);
>>>> -	clk_disable_unprepare(data->clk_pll_a_out0);
>>>> -	clk_disable_unprepare(data->clk_pll_a);
>>>> +	if (__clk_is_enabled(data->clk_cdev1))
>>>> +		clk_disable_unprepare(data->clk_cdev1);
>>> The root of the problem is that you removed clocks enabling from
>>> tegra_asoc_utils_init().
currently, audio mclk and its parent clocks enabling are from clock=20
driver init and not from tegra_asoc_utils_init.
>>> I'm not sure why clocks should be disabled during the rate-changing,
>>> probably this action is not really needed.
>> I know nothing about this particular device but this is not that
>> unusual a restriction for audio hardware, you often can't
>> robustly reconfigure the clocking for a device while it's active
>> due to issues in the hardware.  You often see issues with FIFOs
>> glitching or state machines getting stuck.  This may not be an
>> issue here but if it's something that's documented as a
>> requirement it's probably good to pay attention.
> I don't know details about that hardware either, maybe it is simply not
> safe to change PLL_A rate dynamically and then CLK_SET_RATE_GATE could
> be used.
>
> If nobody knows for sure, then will be better to keep
> tegra_asoc_utils_set_rate() unchanged.
plla rate change through tegra_asoc_utils_set_rate() happens only when=20
there is not active playback or record corresponding to this sound device.

So, I don't see reason for disabling clock during rate change and not=20
sure why we had this from the beginning.

Thierry/Sameer,

Can you please comment?

Yes, we can use CLK_SET_RATE_GATE for PLLA and remove clock disabling=20
before rate change.

