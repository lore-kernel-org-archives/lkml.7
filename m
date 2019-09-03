Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31995C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122F122CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfICIQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:16:19 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:17438 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfICIQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:16:18 -0400
Received: from [10.18.29.226] (10.18.29.226) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 3 Sep
 2019 16:16:57 +0800
Subject: Re: [PATCH 4/4] arm64: dts: add support for A1 based Amlogic AD401
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
References: <1567493475-75451-1-git-send-email-jianxin.pan@amlogic.com>
 <1567493475-75451-5-git-send-email-jianxin.pan@amlogic.com>
 <97a462d6-d98e-f778-96d5-bacd4801df6b@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <f06ab4c9-4b86-3b6f-062d-b5fe365bcd10@amlogic.com>
Date:   Tue, 3 Sep 2019 16:16:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <97a462d6-d98e-f778-96d5-bacd4801df6b@baylibre.com>
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

Hi Neil,

Thanks for your time.
Please see my comments below.

On 2019/9/3 15:42, Neil Armstrong wrote:
> Hi,
> 
> On 03/09/2019 08:51, Jianxin Pan wrote:
>> Add basic support for the Amlogic A1 based Amlogic AD401 board:
>> which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
[...]
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +	memory@0 {
>> +		device_type = "memory";
>> +		linux,usable-memory = <0x0 0x0 0x0 0x8000000>;
> 
> I'll prefer usage of reg, it's handled the same but linux,usable-memory
> is not documented.
> 
OK, I will fix it in the next version. Thanks for your review.
>> +	};
>> +};
>> +
>> +&uart_AO_B {
>> +	status = "okay";
>> +	/*pinctrl-0 = <&uart_ao_a_pins>;*/
>> +	/*pinctrl-names = "default";*/
> 
> Please remove these lines instead of commenting them.
> 
OK, I will fix it in the next version.
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> new file mode 100644
>> index 00000000..b98d648
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> @@ -0,0 +1,121 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
[...]
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
> 
> Isn't there secmon reserved memory ?
> 
A1 uses internal SRAM as secmon memory.
And there is no secmon reserved memory in ddr side.
>> +
>> +		linux,cma {
>> +			compatible = "shared-dma-pool";
>> +			reusable;
>> +			size = <0x0 0x800000>;
[...]
>>
> 
> Thanks,
> Neil
> 
> .
> 

