Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97479C2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7834A2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfLMJfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:35:05 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:33034 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfLMJfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:35:04 -0500
Received: from [10.28.39.99] (10.28.39.99) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 13 Dec
 2019 17:35:20 +0800
Subject: Re: [PATCH v4 1/6] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20191206074052.15557-1-jian.hu@amlogic.com>
 <20191206074052.15557-2-jian.hu@amlogic.com>
 <1jblsdlvck.fsf@starbuckisacylon.baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <db7f731b-32c3-b4a6-1cab-2c34082b2c22@amlogic.com>
Date:   Fri, 13 Dec 2019 17:35:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1jblsdlvck.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.99]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/12 17:57, Jerome Brunet wrote:
> 
> On Fri 06 Dec 2019 at 08:40, Jian Hu <jian.hu@amlogic.com> wrote:
> 
>> Add the documentation to support Amlogic A1 PLL clock driver,
>> and add A1 PLL clock controller bindings.
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 59 +++++++++++++++++++
>>   include/dt-bindings/clock/a1-pll-clkc.h       | 16 +++++
>>   2 files changed, 75 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>>   create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>> new file mode 100644
>> index 000000000000..7feeef5abf1b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>> @@ -0,0 +1,59 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> 
> Rob commented on the above in v1 and it remains unaddressedOK, I will fix it in the next version.
> 
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + */
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Amlogic Meson A/C serials PLL Clock Control Unit Device Tree Bindings
>> +
>> +maintainers:
>> +  - Neil Armstrong <narmstrong@baylibre.com>
>> +  - Jerome Brunet <jbrunet@baylibre.com>
>> +  - Jian Hu <jian.hu@jian.hu.com>
>> +
>> +properties:
>> +  compatible:
>> +    - enum:
>> +        - amlogic,a1-pll-clkc
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +clocks:
>> +  minItems: 2
>> +  maxItems: 2
>> +  items:
>> +   - description: Input xtal_fixpll
>> +   - description: Input xtal_hifipll
>> +
>> +clock-names:
>> +  minItems: 2
>> +  maxItems: 2
>> +  items:
>> +     - const: xtal_fixpll
>> +     - const: xtal_hifipll
>> +
>> +required:
>> +  - compatible
>> +  - "#clock-cells"
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    clkc_pll: pll-clock-controller@7c80 {
>> +                compatible = "amlogic,a1-pll-clkc";
>> +                reg = <0 0x7c80 0 0x18c>;
>> +                #clock-cells = <1>;
>> +                clocks = <&clkc_periphs CLKID_XTAL_FIXPLL>,
>> +                         <&clkc_periphs CLKID_XTAL_HIFIPLL>;
>> +                clock-names = "xtal_fixpll", "xtal_hifipll";
>> +    };
>> diff --git a/include/dt-bindings/clock/a1-pll-clkc.h b/include/dt-bindings/clock/a1-pll-clkc.h
>> new file mode 100644
>> index 000000000000..58eae237e503
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/a1-pll-clkc.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __A1_PLL_CLKC_H
>> +#define __A1_PLL_CLKC_H
>> +
>> +#define CLKID_FIXED_PLL				1
>> +#define CLKID_FCLK_DIV2				6
>> +#define CLKID_FCLK_DIV3				7
>> +#define CLKID_FCLK_DIV5				8
>> +#define CLKID_FCLK_DIV7				9
>> +#define CLKID_HIFI_PLL				10
>> +
>> +#endif /* __A1_PLL_CLKC_H */
> 
> .
> 
