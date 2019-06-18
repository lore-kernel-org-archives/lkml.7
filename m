Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA12C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768EB206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="n4zGH4E1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfFRIka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:40:30 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17253 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFRIk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:40:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d08a37c0000>; Tue, 18 Jun 2019 01:40:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 01:40:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 01:40:28 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 08:40:27 +0000
Subject: Re: [PATCH v2 3/6] clocksource/drivers/tegra: Set and use timer's
 period
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190610164400.11830-1-digetx@gmail.com>
 <20190610164400.11830-4-digetx@gmail.com>
 <ac8a1da8-9b82-3d5a-5fa6-0c1cc7f627f1@nvidia.com>
 <3e941c50-ac62-719e-aac1-7072e9a3bcd0@gmail.com>
 <660f3645-3fa6-175c-75a6-3fcc79e972ad@nvidia.com>
 <e0e1b708-7dd4-a58a-7906-05bf3065cbda@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b92383e6-31e4-0797-1e7a-76410ebfba6c@nvidia.com>
Date:   Tue, 18 Jun 2019 09:40:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e0e1b708-7dd4-a58a-7906-05bf3065cbda@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560847228; bh=uu8oQenvSHld2AvajCP3nExj7WMFx6UMW1gqyl1qM+I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=n4zGH4E1lK28Rylw2DnhYLMnrBo/4XoRObVPUU/3fGVC8I24FLXZQSbX4H9P2M34/
         t6CshJrpYp5zsMj/78hTsZJWoI2LTCz3zlFQWTdCic5qpTK+ecKoH//AbBLt1602Y9
         6Q68wMfO7aaQJ8bTJzT9HUDv1pcjMntqtgTU9stxJ+tBXPTv4ZROE3GSP3jLR5FK9H
         HbFCk+/2J9b5SKuRFfztLcDsRcGgQS0TmjaETJTWfY3Dgg0fUaoANubWo2TJ+PHcOG
         WPCPsN/PqedFmmd9QRVl1Wi5TnS8het9r5S5yxcZgUpL0u+eE151omPj8JLnfPayEG
         OCMZDwiJxTyPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/06/2019 15:04, Dmitry Osipenko wrote:
> 17.06.2019 13:51, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 14/06/2019 17:45, Dmitry Osipenko wrote:
>>> 14.06.2019 18:48, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>
>>>> On 10/06/2019 17:43, Dmitry Osipenko wrote:
>>>>> The of_clk structure has a period field that is set up initially by
>>>>> timer_of_clk_init(), that period value need to be adjusted for a case=
 of
>>>>> TIMER1-9 that are running at a fixed rate that doesn't match the cloc=
k's
>>>>> rate. Note that the period value is currently used only by some of th=
e
>>>>> clocksource drivers internally and hence this is just a minor cleanup
>>>>> change that doesn't fix anything.
>>>>>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>  drivers/clocksource/timer-tegra.c | 5 +++--
>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/=
timer-tegra.c
>>>>> index 810b4e7435cf..646b3530c2d2 100644
>>>>> --- a/drivers/clocksource/timer-tegra.c
>>>>> +++ b/drivers/clocksource/timer-tegra.c
>>>>> @@ -71,9 +71,9 @@ static int tegra_timer_shutdown(struct clock_event_=
device *evt)
>>>>>  static int tegra_timer_set_periodic(struct clock_event_device *evt)
>>>>>  {
>>>>>  	void __iomem *reg_base =3D timer_of_base(to_timer_of(evt));
>>>>> +	unsigned long period =3D timer_of_period(to_timer_of(evt));
>>>>> =20
>>>>> -	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER |
>>>>> -		       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
>>>>> +	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER | (period - 1),
>>>>>  		       reg_base + TIMER_PTV);
>>>>> =20
>>>>>  	return 0;
>>>>> @@ -297,6 +297,7 @@ static int __init tegra_init_timer(struct device_=
node *np, bool tegra20,
>>>>>  		cpu_to->clkevt.rating =3D rating;
>>>>>  		cpu_to->clkevt.cpumask =3D cpumask_of(cpu);
>>>>>  		cpu_to->of_base.base =3D timer_reg_base + base;
>>>>> +		cpu_to->of_clk.period =3D DIV_ROUND_UP(rate, HZ);
>>>>
>>>> Any reason you made this a round-up?
>>>
>>> That's what timer_of_clk_init() does, I assume it should be a more corr=
ect variant.
>>
>> Sounds to me like this should be 2 patches, because you are changing the
>> value. This is not just purely cleanup IMO.
>=20
> Indeed, that could be at least mentioned in the commit message. Probably =
I just
> assumed that this is such a minor change that not worth anything. A hundr=
ed of
> microseconds is hardly noticeable.
>=20
> I'm not really sure if this really worth a re-spin at this point. Jon, ar=
e you insisting?

At a minimum the changelog needs to be udpated to reflect what is going
on here. Yes it may not be a massive difference, but I prefer not to
change things without any rationale.

Cheers
Jon

--=20
nvpublic
