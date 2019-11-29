Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B795DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891EE215F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfK2JuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:50:05 -0500
Received: from olimex.com ([184.105.72.32]:40203 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfK2JuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:50:05 -0500
Received: from 94.155.250.134 ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 01:49:55 -0800
Subject: Re: [linux-sunxi] [PATCH 1/3] arm64: dts: allwinner: a64: olinuxino:
 Fix eMMC supply regulator
To:     wens@kernel.org, Stefan Mavrodiev <stefan@olimex.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20191129091336.13104-1-stefan@olimex.com>
 <20191129091336.13104-2-stefan@olimex.com>
 <CAGb2v64oCx90LQScKTiHVyHLd6c7Rgs_g5L79Yr1J8kgS8-Kyg@mail.gmail.com>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <d2417767-cad0-e7d5-3f34-af07bb143e10@olimex.com>
Date:   Fri, 29 Nov 2019 11:49:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v64oCx90LQScKTiHVyHLd6c7Rgs_g5L79Yr1J8kgS8-Kyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/29/19 11:26 AM, Chen-Yu Tsai wrote:
> On Fri, Nov 29, 2019 at 5:14 PM Stefan Mavrodiev <stefan@olimex.com> wrote:
>> A64-OLinuXino-eMMC uses 1.8V for eMMC supply. This is done via a triple
>> jumper, which sets VCC-PL to either 1.8V or 3.3V. This setting is different
>> for boards with and without eMMC.
>>
>> This is not a big issue for DDR52 mode, however the eMMC will not work in
>> HS200/HS400, since these modes explicitly requires 1.8V.
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>>   arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
>> index 96ab0227e82d..7d135decbd53 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
>> @@ -14,8 +14,8 @@
>>   &mmc2 {
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&mmc2_pins>;
>> -       vmmc-supply = <&reg_dcdc1>;
>> -       vqmmc-supply = <&reg_dcdc1>;
>> +       vmmc-supply = <&reg_eldo1>;
> If I'm reading the schematics correctly, VCC on the eMMC is from 3.3V.
> This corresponds to the vmmc-supply property. So you shouldn't change it.

My bad. Don't know how I've missed that.

Stefan

>
>> +       vqmmc-supply = <&reg_eldo1>;
> vqmmc-supply is from the VCC-PC rail, which is the one you say is triple-
> jumpered. So this change makes sense.
>
> ChenYu
>
