Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A77C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 06:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16C120715
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 06:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfLBGBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 01:01:22 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:20041 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfLBGBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 01:01:21 -0500
Received: from [10.28.39.99] (10.28.39.99) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 2 Dec
 2019 14:01:47 +0800
Subject: Re: [PATCH v3 0/7] add Amlogic A1 clock controller driver
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
References: <20191129144605.182774-1-jian.hu@amlogic.com>
 <1jwobi7lcy.fsf@starbuckisacylon.baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <63d776af-6ded-02d2-cc34-1b3733e2625b@amlogic.com>
Date:   Mon, 2 Dec 2019 14:01:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1jwobi7lcy.fsf@starbuckisacylon.baylibre.com>
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



On 2019/11/29 23:28, Jerome Brunet wrote:
> 
> On Fri 29 Nov 2019 at 15:45, Jian Hu <jian.hu@amlogic.com> wrote:
> 
>> add support for Amlogic A1 clock driver, the clock includes
>> three parts: peripheral clocks, pll clocks, CPU clocks.
>> sys pll and CPU clocks will be sent in next patch.
>>
>> Changes since v1 at [2]:
> 
> v2 or v1 ??
It is v2 here, I will fix it in next version.
> 
>> -add probe function for A1
>> -seperate the clock driver into two patch
>> -change some clock flags and ops
>> -add support for a1 PLL ops
>> -add A1 clock node
>>
>> Changes since v1 at [1]:
>> -place A1 config alphabetically
>> -add actual reason for RO ops, CLK_IS_CRITICAL, CLK_IGNORE_UNUSED
>> -separate the driver into two driver: peripheral and pll driver
>> -delete CLK_IGNORE_UNUSED flag for pwm b/c/d/e/f clock, dsp clock
>> -delete the change in Kconfig.platforms, address to Kevin alone
>> -remove the useless comments
>> -modify the meson pll driver to support A1 PLLs
>>
>> [1] https://lkml.kernel.org/r/1569411888-98116-1-git-send-email-jian.hu@amlogic.com
>> [2] https://lkml.kernel.org/r/1571382865-41978-1-git-send-email-jian.hu@amlogic.com
>>
>> Jian Hu (7):
>>    dt-bindings: clock: meson: add A1 PLL clock controller bindings
>>    clk: meson: add support for A1 PLL clock ops
>>    clk: meson: eeclk: refactor eeclk common driver to support A1
>>    clk: meson: a1: add support for Amlogic A1 PLL clock driver
>>    dt-bindings: clock: meson: add A1 peripheral clock controller bindings
>>    clk: meson: a1: add support for Amlogic A1 Peripheral clock driver
>>    arm64: dts: meson: add A1 PLL and periphs clock controller
> 
> The arm64 is for the DT maintainer. Please send it separately after this
> series is applied (if it gets applied)
> 
>> Please fix the underlying issue, then you can post your series again.
> 
> This was a comment on your v2. Did you fix the orphan/ordering issue ?

> If you did, you probably should mention it here.
Yes, I have fixed it in A1 periphs driver, not fixed it in CCF.
I have realised a probe function for A1 periphs driver, Not using the 
common probe interface in meson-eeclk.c. Skip registering xtal_fixedpll 
and xtal_hifipll clocks when register all periphs clocks. And after the 
provider registration. Registering xtal_fixedpll and xtal_hifipll clock 
alone.

I will add some comments here about orphan issue.

And I have noticed you have fixed it in CCF,  I will update the A1 
periphs driver, drop the probe function in the next vertion.
Could I send the v4 after your patch 'clk: walk orphan list on clock 
provider registration' is applied? Or I can send v4 based on your patch now.

> If you did not, I'm probably not going to review this further until you do.
> 
>>
>>   .../bindings/clock/amlogic,a1-clkc.yaml       |   70 +
>>   .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   56 +
>>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   26 +
>>   drivers/clk/meson/Kconfig                     |   20 +
>>   drivers/clk/meson/Makefile                    |    2 +
>>   drivers/clk/meson/a1-pll.c                    |  334 +++
>>   drivers/clk/meson/a1-pll.h                    |   56 +
>>   drivers/clk/meson/a1.c                        | 2309 +++++++++++++++++
>>   drivers/clk/meson/a1.h                        |  120 +
>>   drivers/clk/meson/clk-pll.c                   |   21 +
>>   drivers/clk/meson/clk-pll.h                   |    1 +
>>   drivers/clk/meson/meson-eeclk.c               |   59 +-
>>   drivers/clk/meson/meson-eeclk.h               |    2 +
>>   drivers/clk/meson/parm.h                      |    1 +
>>   include/dt-bindings/clock/a1-clkc.h           |   98 +
>>   include/dt-bindings/clock/a1-pll-clkc.h       |   16 +
>>   16 files changed, 3181 insertions(+), 10 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>>   create mode 100644 drivers/clk/meson/a1-pll.c
>>   create mode 100644 drivers/clk/meson/a1-pll.h
>>   create mode 100644 drivers/clk/meson/a1.c
>>   create mode 100644 drivers/clk/meson/a1.h
>>   create mode 100644 include/dt-bindings/clock/a1-clkc.h
>>   create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
> 
> .
> 
