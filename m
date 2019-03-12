Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B834C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FC0206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="ZHgdPwJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCLMyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:54:55 -0400
Received: from node.akkea.ca ([192.155.83.177]:33434 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLMyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:54:54 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 823C24E204B; Tue, 12 Mar 2019 12:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552395293; bh=tTlVlQzSLUl6E+1inAycfOEEy/2Ca9BsNgxZZ1gnPMw=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=ZHgdPwJHF5DlgaVepiagUqEmhv88k40Raiyze11TQ1UEXuLcvp+oZJ4PZh8I+PzGp
         zgIlyobUjfD5FcN+QwmOR7wjeMAu1Mk7ZsbK+s3YP4yt/FAC/rsSwCgMQXBKUIzubt
         4H8e2FjJqzIIPRwwnQ0Z23m6xrl5hGDMZVxlEDhs=
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] arm64: dts: fsl: imx8mq: enable the thermal management  unit (TMU)
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Mar 2019 05:54:53 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, daniel.baluta@nxp.com,
        agx@sigxcpu.org, dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <CAHQ1cqEHr1mB2EH3-fJPrYa+nkcWPPjmCTjSt-XsDnJp-SCf+w@mail.gmail.com>
References: <20190311213124.29325-1-angus@akkea.ca>
 <CAHQ1cqEHr1mB2EH3-fJPrYa+nkcWPPjmCTjSt-XsDnJp-SCf+w@mail.gmail.com>
Message-ID: <6c12636f6ff8aa6109e48ee4b4e7e41f@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-11 19:35, Andrey Smirnov wrote:
> On Mon, Mar 11, 2019 at 2:35 PM Angus Ainslie (Purism) <angus@akkea.ca> 
> wrote:
>> 
>> These are the TMU nodes from the NXP vendor kernel
>> 
> 
> Hey Angus,
> 
> TMU block supports multiple thermal zones and vendor kernel doesn't
> really account for that (see below). Latest version of the driver in
> thermal tree now actually supports that feature (mulit-sensor), so I
> think the code in DT should reflect that as well. I recently submitted
> a series adding HWMON integration for TMU
> (https://lore.kernel.org/lkml/20190222200508.26325-1-andrew.smirnov@gmail.com/T/#u)
> and this is my take on this patch:
> 
> https://github.com/ndreys/linux/commit/09931e3d60af0a74377307b433db97da1be31570
> 
> All of the code there is up for grabs, if you feel like using it.

Thanks, I would prefer to use the multi sensor code but I assumed it 
wasn't in yet so I followed

Documentation/devicetree/bindings/thermal/qoriq-thermal.txt

I'll try some testing with the DT fragment you suggested.

> 
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 83 
>> +++++++++++++++++++++++
>>  1 file changed, 83 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi 
>> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> index 9155bd4784eb..087620c6e17f 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> @@ -8,6 +8,7 @@
>>  #include <dt-bindings/power/imx8mq-power.h>
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/thermal/thermal.h>
>>  #include "imx8mq-pinfunc.h"
>> 
>>  / {
>> @@ -89,6 +90,7 @@
>>                         reg = <0x0>;
>>                         enable-method = "psci";
>>                         next-level-cache = <&A53_L2>;
>> +                       #cooling-cells = <2>;
>>                 };
>> 
>>                 A53_1: cpu@1 {
>> @@ -210,6 +212,87 @@
>>                                 #interrupt-cells = <2>;
>>                         };
>> 
>> +                       tmu: tmu@30260000 {
>> +                               compatible = "fsl,imx8mq-tmu";
>> +                               reg = <0x30260000 0x10000>;
>> +                               interrupt = <GIC_SPI 49 
>> IRQ_TYPE_LEVEL_HIGH>;
>> +                               little-endian;
>> +                               fsl,tmu-range = <0xb0000 0xa0026 
>> 0x80048 0x70061>;
>> +                               fsl,tmu-calibration = <0x00000000 
>> 0x00000023
>> +                                                      0x00000001 
>> 0x00000029
>> +                                                      0x00000002 
>> 0x0000002f
>> +                                                      0x00000003 
>> 0x00000035
>> +                                                      0x00000004 
>> 0x0000003d
>> +                                                      0x00000005 
>> 0x00000043
>> +                                                      0x00000006 
>> 0x0000004b
>> +                                                      0x00000007 
>> 0x00000051
>> +                                                      0x00000008 
>> 0x00000057
>> +                                                      0x00000009 
>> 0x0000005f
>> +                                                      0x0000000a 
>> 0x00000067
>> +                                                      0x0000000b 
>> 0x0000006f
>> +
>> +                                                      0x00010000 
>> 0x0000001b
>> +                                                      0x00010001 
>> 0x00000023
>> +                                                      0x00010002 
>> 0x0000002b
>> +                                                      0x00010003 
>> 0x00000033
>> +                                                      0x00010004 
>> 0x0000003b
>> +                                                      0x00010005 
>> 0x00000043
>> +                                                      0x00010006 
>> 0x0000004b
>> +                                                      0x00010007 
>> 0x00000055
>> +                                                      0x00010008 
>> 0x0000005d
>> +                                                      0x00010009 
>> 0x00000067
>> +                                                      0x0001000a 
>> 0x00000070
>> +
>> +                                                      0x00020000 
>> 0x00000017
>> +                                                      0x00020001 
>> 0x00000023
>> +                                                      0x00020002 
>> 0x0000002d
>> +                                                      0x00020003 
>> 0x00000037
>> +                                                      0x00020004 
>> 0x00000041
>> +                                                      0x00020005 
>> 0x0000004b
>> +                                                      0x00020006 
>> 0x00000057
>> +                                                      0x00020007 
>> 0x00000063
>> +                                                      0x00020008 
>> 0x0000006f
>> +
>> +                                                      0x00030000 
>> 0x00000015
>> +                                                      0x00030001 
>> 0x00000021
>> +                                                      0x00030002 
>> 0x0000002d
>> +                                                      0x00030003 
>> 0x00000039
>> +                                                      0x00030004 
>> 0x00000045
>> +                                                      0x00030005 
>> 0x00000053
>> +                                                      0x00030006 
>> 0x0000005f
>> +                                                      0x00030007 
>> 0x00000071>;
>> +                               #thermal-sensor-cells =  <0>;
> 
> As per #thermal-sensor-cells must be 1 (see
> Documentation/devicetree/bindings/thermal/qoriq-thermal.txt), since as
> I mentioned above there are multiple thermal zones (CPU, GPU, VPU).

Thanks I missed that bringing it over.

Angus Ainslie

> 
>> +                       };
>> +
>> +                       thermal-zones {
>> +                               cpu-thermal {
>> +                                       polling-delay-passive = <250>;
>> +                                       polling-delay = <2000>;
>> +                                       thermal-sensors = <&tmu>;
> 
> Ditto.
> 
> Thanks,
> Andrey Smirnov

