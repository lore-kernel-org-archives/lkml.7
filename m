Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84ACC2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 21:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFB920828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 21:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lyV65YVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfL0Vcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 16:32:50 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18458 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL0Vct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 16:32:49 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e06785b0000>; Fri, 27 Dec 2019 13:32:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 27 Dec 2019 13:32:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 27 Dec 2019 13:32:48 -0800
Received: from [10.2.173.37] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Dec
 2019 21:32:47 +0000
Subject: Re: [PATCH v5 18/19] arm64: tegra: smaug: Change clk_out_2 provider
 to pmc
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-19-git-send-email-skomatineni@nvidia.com>
 <2f85578e-8552-9e2e-9f67-355b24d6b99f@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <68d648e0-522e-ec8a-5ec5-c6c7881a87f1@nvidia.com>
Date:   Fri, 27 Dec 2019 13:32:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2f85578e-8552-9e2e-9f67-355b24d6b99f@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577482331; bh=lcYXcBZQaSAW8fHaCP/hEyVwyTZTQ7gv4dWK5g2V1J4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=lyV65YVe3LHNqcjjg4U70LyxBPtRmZteGaWNeySMLe66D9o0RoS5UkR/TAA3N2ALF
         zBxWsif/3ii1ZqEzKLdqJX/AWMDsC4I3OI8Mamgm58ROVQ/2jC3E/6GQxDWayvnk2n
         /hKxHR2dHBwJQcikysFzgyC3ns/oMfY3XAGJVF0s+if/hcIiXntWdkEFLkJB/z1kcY
         wwyLYetWnntTLqpeZEc4p4cC7zppT3kBIcYclq05Ww1XGWQe0yLetJR0Pgui5BwdAH
         v4KTK43Bb+hDqCsovq/P5xRBhkDuZbx7MNI2zjkC0hm4rf+jIflJivJC+k8Fvg/W5o
         OfkUkh8jpy73A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/22/19 2:00 PM, Dmitry Osipenko wrote:
> 21.12.2019 01:27, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> clk_out_2 is one of the clocks from Tegra PMC block and Tegra PMC
>> clocks are moved from clock driver to pmc driver with pmc as clock
>> provider and using pmc clock ids.
>>
>> This patch changes clk_out_2 provider to pmc and uses corresponding
>> pmc clock id for clk_out_2.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/=
boot/dts/nvidia/tegra210-smaug.dts
>> index 72c7a04ac1df..2faab6390552 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>> @@ -1592,7 +1592,7 @@
>>   			reg =3D <0x1a>;
>>   			interrupt-parent =3D <&gpio>;
>>   			interrupts =3D <TEGRA_GPIO(E, 6) IRQ_TYPE_LEVEL_LOW>;
>> -			clocks =3D <&tegra_car TEGRA210_CLK_CLK_OUT_2>;
>> +			clocks =3D <&tegra_pmc TEGRA_PMC_CLK_OUT_2>;
>>   			clock-names =3D "mclk";
>>  =20
>>   			nuvoton,jkdet-enable;
>>
> Isn't "assigned-clocks" needed here?

from existing device tree and clock driver init table clk_out_2 is from=20
clk_m and not using extperiph2.

So to have same clock configuration, didnt added assigned-clocks as=20
default clk_out_2 parent is clk_m

