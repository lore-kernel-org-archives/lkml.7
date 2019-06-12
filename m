Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF96EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EAF208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nDeHh56m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438697AbfFLNBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:01:25 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11597 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfFLNBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:01:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d00f7a30000>; Wed, 12 Jun 2019 06:01:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 12 Jun 2019 06:01:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 12 Jun 2019 06:01:23 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun
 2019 13:01:20 +0000
Subject: Re: [PATCH v2 2/2] arm64: tegra: enable ACONNECT, ADMA and AGIC
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1560243406-2535-1-git-send-email-spujar@nvidia.com>
 <1560243406-2535-2-git-send-email-spujar@nvidia.com>
 <4e017e97-8a05-c1fe-2cd9-b985e79d02a1@nvidia.com>
 <ce8e26f7-4ed0-a5a4-821b-fdfa3a7e334e@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <30df3490-a263-233f-3775-b719d76e3302@nvidia.com>
Date:   Wed, 12 Jun 2019 14:01:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ce8e26f7-4ed0-a5a4-821b-fdfa3a7e334e@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560344483; bh=oRSaZa+z8x59FaePK5OgeOnhuVgVITrwS1FdynC0pJw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nDeHh56mcqsDMxPewUbdbPzu4W58C+581cSMs5kpY1bJiOUW2QlxueNtxt/plWUKe
         pfNZyZUAxlUzA5MrLTM9ma5nKgG+g/9TPhMARXInwRQigOuNL7f60ra4TNqenK1hln
         yUQieNeDmh7DNSCjugJ5o2iz2HMjMA0DJbKG5WXhFzM8Nt1+Hh0ybxmKH9vEQ/4Uiw
         8x0EcKrc2ho+I8ZXXxfiiy3gX3y2MRAdcPpELa8bYOv2DTjoDm2AyyBh9F72skBunp
         2cKtQx8CO2OKGlLsfyw7n+yKSNTIQwWKnhrNlm11kWIuIq1y3vMKenIDasj+CJ/lEh
         argdfBwLuWWWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/06/2019 13:44, Sameer Pujar wrote:
>=20
> On 6/12/2019 6:07 PM, Jon Hunter wrote:
>>
>> On 11/06/2019 09:56, Sameer Pujar wrote:
>>> Enable ACONNECT, ADMA and AGIC devices for following platforms
>>> =C2=A0=C2=A0 * Jetson TX2
>>> =C2=A0=C2=A0 * Jetson Xavier
>>>
>>> Verified driver probe path and devices get registered fine.
>>>
>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>> ---
>>> =C2=A0 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 12 ++++++++=
++++
>>> =C2=A0 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 12 ++++++++=
++++
>>> =C2=A0 2 files changed, 24 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
>>> b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
>>> index 5102de1..b818355 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
>>> @@ -298,4 +298,16 @@
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 vin-supply =3D <&vdd_5v0_sys>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0 aconnect@2a41000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-controller@2930000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sta=
tus =3D "okay";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 agic@2a41000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sta=
tus =3D "okay";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0 };
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>>> b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>>> index 6e6df65..d1cc028 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>>> @@ -167,4 +167,16 @@
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 };
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0 aconnect@2a41000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-controller@2930000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sta=
tus =3D "okay";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 agic@2a41000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sta=
tus =3D "okay";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0 };
>>>
>> I believe that I have already ACK'ed this, so please include for the
>> next revision.
> There is a small change related to dma node.
> Will include ACK in the next revision.

OK. I had assumed there was no change. Ah the 'dma-controller' name!

Usually you should list the changes for each revision under the '---'
beneath the signed-off line so people can see if there are any changes.

Cheers
Jon

--=20
nvpublic
