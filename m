Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322F6C33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D78206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZNR7SZJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgAHG3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:29:06 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15810 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgAHG3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:29:06 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1576800002>; Tue, 07 Jan 2020 22:28:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 22:29:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 22:29:05 -0800
Received: from [10.24.44.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 06:28:59 +0000
Subject: Re: [PATCH v7 15/21] ASoC: tegra: Add fallback implementation for
 audio mclk
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <josephl@nvidia.com>, <daniel.lezcano@linaro.org>,
        <mmaddireddy@nvidia.com>, <markz@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-16-git-send-email-skomatineni@nvidia.com>
 <f3f550a2-c6e0-7a78-5c83-da3e54dab309@nvidia.com>
 <d7ac6135-73b0-1087-dafa-4df558a06ef4@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <a3c5293b-9ed4-3266-f792-38b980e54b1e@nvidia.com>
Date:   Wed, 8 Jan 2020 11:58:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <d7ac6135-73b0-1087-dafa-4df558a06ef4@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578464897; bh=OHhIle+XKX/LTcA5mmunIMXF7a5LS6VUkkqyvI0+XNg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=ZNR7SZJgFRYaRAx4eRFJT2uN5zQzJqxtOI2lcGNIlSwFBmAEIBNAWOaBMHMhyLs39
         AYBer1uvKCm9U/ZUrwjhcjhAATw3Je5U+v7ubgsWf+mEAd9sC3SBG6IY/bvaXTTlra
         Vc8vOpPasi+ZKzgw+3nhm0VZmYV5OZ89xt3Vi6as2nlt5/CIiMlhzhJrtlEn4eKsLC
         eMObyYS7kHlRN6oTWH8yCSmnodXewyv7fsEDrzsrdBD0JAVIUwrqV6+iqhkiQcVzIP
         hlLgZOiOtDl28knHeiGM7iEYvRGtjq9YyY403f4bVVEsdJ3TjVaSBrNbnU6TDZnUJ3
         nXcH7t0bhalBQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/8/2020 11:18 AM, Sowjanya Komatineni wrote:
>
> On 1/7/20 9:34 PM, Sameer Pujar wrote:
>>
>> On 1/8/2020 9:55 AM, Sowjanya Komatineni wrote:
>>> mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
>>> are moved to Tegra PMC driver with pmc as clock provider and using pmc
>>> clock ids.
>>>
>>> New device tree uses clk_out_1 from pmc clock provider.
>>>
>>> So, this patch adds implementation for mclk fallback to extern1 when
>>> retrieving mclk returns -ENOENT to be backward compatible of new device
>>> tree with older kernels.
>>>
>>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>> =C2=A0 sound/soc/tegra/tegra_asoc_utils.c | 11 ++++++++++-
>>> =C2=A0 1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c=20
>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>> index 9cfebef74870..9a5f81039491 100644
>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>> @@ -183,7 +183,16 @@ int tegra_asoc_utils_init(struct=20
>>> tegra_asoc_utils_data *data,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->clk_cdev1 =3D devm_clk_get(dev, "m=
clk");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(data->clk_cdev1)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->de=
v, "Can't retrieve clk cdev1\n");
>>
>> This error print can be moved inside below if, when this actually=20
>> meant to be an error condition.
>>
> Want to show error even if mclk retrieval returns ENOENT to clearly=20
> indicate mclk does not exist along with message of falling back to=20
> extern1.

Yes, but falling back essentially means 'mclk' is not available and=20
fallback print is not an error.
Not a major issue though, you can consider updating. Otherwise LGTM.

>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(data->clk_cd=
ev1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PTR_ERR(data->clk_cdev1=
) !=3D -ENOENT)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn PTR_ERR(data->clk_cdev1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Fall back to extern1 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->clk_cdev1 =3D devm_cl=
k_get(dev, "extern1");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(data->clk_cdev1)=
) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev=
_err(data->dev, "Can't retrieve clk extern1\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn PTR_ERR(data->clk_cdev1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Falling=
 back to extern1\n");
>>
>> This can be a info print?
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
