Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FEBC32774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52E72146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfI0GIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:08:37 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:34453 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfI0GIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:08:36 -0400
Received: from [10.28.19.114] (10.28.19.114) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 27 Sep
 2019 14:08:34 +0800
Subject: Re: [PATCH 1/2] dt-bindings: clock: meson: add A1 clock controller
 bindings
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1569411888-98116-1-git-send-email-jian.hu@amlogic.com>
 <1569411888-98116-2-git-send-email-jian.hu@amlogic.com>
 <1j4l10motk.fsf@starbuckisacylon.baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <d9b23872-3d6f-ddb0-d44b-174fb2984232@amlogic.com>
Date:   Fri, 27 Sep 2019 14:08:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1j4l10motk.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.19.114]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jerome

Thank you for review.

On 2019/9/25 22:29, Jerome Brunet wrote:
> On Wed 25 Sep 2019 at 19:44, Jian Hu <jian.hu@amlogic.com> wrote:
> 
> In addition to the comment expressed by Stephen on patch 2
> 
got it.
>> Add the documentation to support Amlogic A1 clock driver,
>> and add A1 clock controller bindings.
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>   .../devicetree/bindings/clock/amlogic,a1-clkc.yaml |  65 +++++++++++++
>>   include/dt-bindings/clock/a1-clkc.h                | 102 +++++++++++++++++++++
>>   2 files changed, 167 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>>   create mode 100644 include/dt-bindings/clock/a1-clkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>> new file mode 100644
>> index 0000000..f012eb2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>> @@ -0,0 +1,65 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + */
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/clock/amlogic,a1-clkc.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Amlogic Meson A1 Clock Control Unit Device Tree Bindings
>> +
>> +maintainers:
>> +  - Neil Armstrong <narmstrong@baylibre.com>
>> +  - Jerome Brunet <jbrunet@baylibre.com>
>> +  - Jian Hu <jian.hu@jian.hu.com>
>> +
>> +properties:
>> +  compatible:
>> +    - enum:
>> +        - amlogic,a1-clkc
>> +
>> +  reg:
>> +    minItems: 1
>> +    maxItems: 3
>> +    items:
>> +      - description: peripheral registers
>> +      - description: cpu registers
>> +      - description: pll registers
>> +
>> +  reg-names:
>> +    items:
>> +      - const: peripheral
>> +      - const: pll
>> +      - const: cpu
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    items:
>> +      - description: Input Oscillator (usually at 24MHz)
>> +
>> +  clock-names:
>> +    maxItems: 1
>> +    items:
>> +      - const: xtal
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - clocks
>> +  - clock-names
>> +  - "#clock-cells"
>> +
>> +examples:
>> +  - |
>> +    clkc: clock-controller {
>> +        compatible = "amlogic,a1-clkc";
>> +        reg = <0x0 0xfe000800 0x0 0x100>,
>> +              <0x0 0xfe007c00 0x0 0x21c>,
>> +              <0x0 0xfd000080 0x0 0x20>;
>> +        reg-names = "peripheral", "pll", "cpu";
> 
> I'm sorry but I don't agree with this. You are trying to regroup several
> controllers into one with this, and it is not OK
> 
> By the looks of it there are 3 different controllers, including one you
> did not implement in the driver.
> 
Yes, In A1, the clock registers include three regions.

I agree with your opinion. I will implement the two clock drivers of 
peripheral and plls first in PATCH V2. And CPU clock driver will be sent 
after the patches are merged.

>> +        clocks = <&xtal;
>> +        clock-names = "xtal";
>> +        #clock-cells = <1>;
> 
> .
> 
