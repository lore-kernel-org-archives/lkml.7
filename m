Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080DBC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7752067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Oxg9sk0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbgAIRSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:18:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15466 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgAIRST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:18:19 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1760480001>; Thu, 09 Jan 2020 09:18:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Jan 2020 09:18:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Jan 2020 09:18:18 -0800
Received: from [10.2.165.201] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jan
 2020 17:18:17 +0000
Subject: Re: [PATCH v7 05/21] clk: tegra: Fix Tegra PMC clock out parents
To:     Nicolas Chauvet <kwizart@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-6-git-send-email-skomatineni@nvidia.com>
 <CABr+WT=qP1BJUfzgmr4AzN18Zp-trMEStF6SQ+AH7+aYBUuUww@mail.gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <1af4584b-70ae-c439-8f8f-bbeceb3cb036@nvidia.com>
Date:   Thu, 9 Jan 2020 09:18:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CABr+WT=qP1BJUfzgmr4AzN18Zp-trMEStF6SQ+AH7+aYBUuUww@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578590280; bh=jOhKnx9g9TIFBclihu2Z+5VX5VY2h3UI9ybvBvQojao=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Oxg9sk0T9L/aCRfpgKJnxWUvdS8C0WpPqXPwPXMvSxy2sQAE3pijQ4fWoeue4ZGZD
         5oQoycnWQy+KT8z48sW4zvxopoaOYu+DNxLK9aP0fNtAUAn4FU0i8AYFeIBdHbGB6J
         ve7QJly6Tt+40AKzjunYLv2U5YH7IymCJXmbDKzGVfUMwQywVNdGNNsx9/qEFJ501B
         wyjeN/i+uDaQK9ScKkcACpdj2FT+owD/wMAr8VcwZS93/QeR3w7X+D0VtscCDSZ/e1
         gqjW6THdx4ar01v0isu5/wyV6J6MXgj3VpwphM5fZBmAFBaQD56u+EOWX/ibIx1pQl
         MqkIYklvekXxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/8/20 12:34 AM, Nicolas Chauvet wrote:
> Le mer. 8 janv. 2020 =C3=A0 05:27, Sowjanya Komatineni
> <skomatineni@nvidia.com> a =C3=A9crit :
>> Tegra PMC clock out parents are osc, osc_div2, osc_div4 and extern
>> clock.
>>
>> Clock driver is using incorrect parents clk_m, clk_m_div2, clk_m_div4
>> for PMC clocks.
>>
>> This patch fixes this.
>>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/clk/tegra/clk-tegra-pmc.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/tegra/clk-tegra-pmc.c b/drivers/clk/tegra/clk-t=
egra-pmc.c
>> index bec3e008335f..5e044ba1ae36 100644
>> --- a/drivers/clk/tegra/clk-tegra-pmc.c
>> +++ b/drivers/clk/tegra/clk-tegra-pmc.c
>> @@ -49,16 +49,16 @@ struct pmc_clk_init_data {
>>
>>   static DEFINE_SPINLOCK(clk_out_lock);
>>
>> -static const char *clk_out1_parents[] =3D { "clk_m", "clk_m_div2",
>> -       "clk_m_div4", "extern1",
>> +static const char *clk_out1_parents[] =3D { "osc", "osc_div2",
>> +       "osc_div4", "extern1",
>>   };
>>
>> -static const char *clk_out2_parents[] =3D { "clk_m", "clk_m_div2",
>> -       "clk_m_div4", "extern2",
>> +static const char *clk_out2_parents[] =3D { "osc", "osc_div2",
>> +       "osc_div4", "extern2",
>>   };
>>
>> -static const char *clk_out3_parents[] =3D { "clk_m", "clk_m_div2",
>> -       "clk_m_div4", "extern3",
>> +static const char *clk_out3_parents[] =3D { "osc", "osc_div2",
>> +       "osc_div4", "extern3",
>>   };
>>
>>   static struct pmc_clk_init_data pmc_clks[] =3D {
>> --
>> 2.7.4
> Out of curiosity, this patch touch the clk-tegra-pmc.c file which is
> later removed (by patch 11).
> Is this change made for bugfix ? Is there a stable tag missing ?
Will resend final version with stable tags for patches that should be=20
backported.
