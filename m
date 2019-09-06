Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C032CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82522081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbfIFF6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 01:58:17 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:6635 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbfIFF6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:58:17 -0400
Received: from [10.18.29.226] (10.18.29.226) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 6 Sep
 2019 13:59:06 +0800
Subject: Re: [PATCH v2 4/4] arm64: dts: add support for A1 based Amlogic AD401
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
References: <1567667251-33466-1-git-send-email-jianxin.pan@amlogic.com>
 <1567667251-33466-5-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCBSmW4y-Dz7EkJMV8HOU4k6Z0G-K6T77XnVrHyubaSsdg@mail.gmail.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <be032a85-b60d-f7f0-8404-b27784d809df@amlogic.com>
Date:   Fri, 6 Sep 2019 13:59:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBSmW4y-Dz7EkJMV8HOU4k6Z0G-K6T77XnVrHyubaSsdg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.226]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks for the review, we really appreciate your time.
Please see my comments below.

On 2019/9/6 4:15, Martin Blumenstingl wrote:
> Hi Jianxin,
> 
> (it's great to see that you and your team are upstreaming this early)
> 
> On Thu, Sep 5, 2019 at 9:08 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> [...]
>> +       memory@0 {
>> +               device_type = "memory";
>> +               reg = <0x0 0x0 0x0 0x8000000>;
>> +               /*linux,usable-memory = <0x0 0x0 0x0 0x8000000>;*/
> why do we need that comment here (I don't understand it - why doesn't
> the "reg" property cover this)?
> I replaced "linux,usable-memory" with reg, but forgot to remove this comment line. 
I will remove this line in the next version. Thank you.
>> +       };
>> +};
>> +
>> +&uart_AO_B {
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> new file mode 100644
>> index 00000000..4d476ac
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> @@ -0,0 +1,122 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +       compatible = "amlogic,a1";
>> +
>> +       interrupt-parent = <&gic>;
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +
>> +       cpus {
>> +               #address-cells = <0x2>;
>> +               #size-cells = <0x0>;
> only now I notice that all our other .dtsi also use hex values
> (instead of decimal as just a few lines above) here
> do you know if there is a particular reason for this?
> 
I just copied from the previous series, and didn't notice the difference before.> [...]
>> +               uart_AO_B: serial@fe002000 {
>> +                       compatible = "amlogic,meson-gx-uart",
>> +                                    "amlogic,meson-ao-uart";
>> +                                    reg = <0x0 0xfe002000 0x0 0x18>;
> the indentation of the "reg" property is off here
OK, I will fix it.
> 
> also I'm a bit surprised to see no busses (like aobus, cbus, periphs, ...) here
> aren't there any busses defined in the A1 SoC implementation or are
> were you planning to add them later?
>Unlike previous series,there is no Cortex-M3 AO CPU in A1, and there is no AO/EE power domain.
Most of the registers are on the apb_32b bus.  aobus, cbus and periphs are not used in A1.
> 
> Martin
> 
> .
> 

