Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CEDC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA7B2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Oa1tNaR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfFQKvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:51:47 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11531 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfFQKvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:51:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0770c30000>; Mon, 17 Jun 2019 03:51:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 03:51:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 03:51:46 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 10:51:45 +0000
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
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <660f3645-3fa6-175c-75a6-3fcc79e972ad@nvidia.com>
Date:   Mon, 17 Jun 2019 11:51:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3e941c50-ac62-719e-aac1-7072e9a3bcd0@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560768707; bh=SgptNflpnXD1DnpgQHNTfQiFDVoOPgbP24o4RhvwUaA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Oa1tNaR+/D0beA/8ayKUethaiBYfObqF7GN9zyVeyEtQu4OX4ljLHte/5Dwd+uhXM
         pWmtYHINoX9uN3b6lvyFD0IyCpATKOoS42ZnPt7w60VkWfZy5F06CMzlsWTZztEANY
         ppeXPInYOjvBQ8jetFSykHBPZRSJJAw697CzmtmHoljopYLCiKrUsfYBAa9OXrqTb3
         hhqKx+7ypz8TcJ+h/jb6RLKSZPDO9VjHT43p7kreJb2EHbTBS+J3FcNGTQ1SngoUOu
         8jY6bpCxNriNPH9EZsm9vjtONxsQ5EvewgL/QtkLOIDDCSbIfhu9WeTdE0ue26J5SX
         hDiAwYSPHvP1w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/06/2019 17:45, Dmitry Osipenko wrote:
> 14.06.2019 18:48, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 10/06/2019 17:43, Dmitry Osipenko wrote:
>>> The of_clk structure has a period field that is set up initially by
>>> timer_of_clk_init(), that period value need to be adjusted for a case o=
f
>>> TIMER1-9 that are running at a fixed rate that doesn't match the clock'=
s
>>> rate. Note that the period value is currently used only by some of the
>>> clocksource drivers internally and hence this is just a minor cleanup
>>> change that doesn't fix anything.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/clocksource/timer-tegra.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/ti=
mer-tegra.c
>>> index 810b4e7435cf..646b3530c2d2 100644
>>> --- a/drivers/clocksource/timer-tegra.c
>>> +++ b/drivers/clocksource/timer-tegra.c
>>> @@ -71,9 +71,9 @@ static int tegra_timer_shutdown(struct clock_event_de=
vice *evt)
>>>  static int tegra_timer_set_periodic(struct clock_event_device *evt)
>>>  {
>>>  	void __iomem *reg_base =3D timer_of_base(to_timer_of(evt));
>>> +	unsigned long period =3D timer_of_period(to_timer_of(evt));
>>> =20
>>> -	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER |
>>> -		       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
>>> +	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER | (period - 1),
>>>  		       reg_base + TIMER_PTV);
>>> =20
>>>  	return 0;
>>> @@ -297,6 +297,7 @@ static int __init tegra_init_timer(struct device_no=
de *np, bool tegra20,
>>>  		cpu_to->clkevt.rating =3D rating;
>>>  		cpu_to->clkevt.cpumask =3D cpumask_of(cpu);
>>>  		cpu_to->of_base.base =3D timer_reg_base + base;
>>> +		cpu_to->of_clk.period =3D DIV_ROUND_UP(rate, HZ);
>>
>> Any reason you made this a round-up?
>=20
> That's what timer_of_clk_init() does, I assume it should be a more correc=
t variant.

Sounds to me like this should be 2 patches, because you are changing the
value. This is not just purely cleanup IMO.

Jon

--=20
nvpublic
