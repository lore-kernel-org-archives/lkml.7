Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB993C4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 01:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D52206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 01:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfFYBZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 21:25:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:58304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729374AbfFYBZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 21:25:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6C1AAE2C;
        Tue, 25 Jun 2019 01:25:30 +0000 (UTC)
Subject: Re: [PATCH] csky: dts: Add NationalChip GX6605S
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
References: <20190625002829.17409-1-afaerber@suse.de>
 <CAJF2gTTnhTQK-mOyC+e8U8xrDwaoDUACb1R_zQfDCKwdKzc96w@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <a27255d3-e21c-787d-c510-359d72f53a1c@suse.de>
Date:   Tue, 25 Jun 2019 03:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTTnhTQK-mOyC+e8U8xrDwaoDUACb1R_zQfDCKwdKzc96w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.06.19 um 02:45 schrieb Guo Ren:
> Thx for the patch. No need seperate part into dtsi,

Sorry, I know from many arm contributions that using a .dtsi is the
right thing here. It logically separates the chip from the board, even
if there's only one evaluation board currently. Think about set-top
boxes that someone might author a .dts for - they should be able to
reuse the .dtsi for the SoC rather than copy it.

> just follow:
> https://lore.kernel.org/linux-csky/1561376581-19568-1-git-send-email-guoren@kernel.org/T/#u

Thanks for that pointer! I still think my node names are cleaner and
also the structure of keeping clocks and gpio users outside of /soc. I
see the value you use is 27 MHz, will try it tomorrow. I see you use
nice KEY_ constants, whereas I just took the raw values from the dtb.

I notice that your patch doesn't have any Copyright header, how should I
credit you in the resulting combined patch? I would then also add your
SoB from the patch you linked to.

More comments inline...

> On Tue, Jun 25, 2019 at 8:28 AM Andreas Färber <afaerber@suse.de> wrote:
>>
>> Add Device Trees for NationalChip GX6605S SoC (based on CK610 CPU) and its
>> dev board. GxLoader expects as filename gx6605s.dtb, so keep that.
>> The bootargs are prepared to boot from USB and to output to serial.
>>
>> Compatibles for the SoC and board are left out for now.
>>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  arch/csky/boot/dts/gx6605s.dts  | 104 ++++++++++++++++++++++++++++++++++++++++
>>  arch/csky/boot/dts/gx6605s.dtsi |  82 +++++++++++++++++++++++++++++++
>>  2 files changed, 186 insertions(+)
>>  create mode 100644 arch/csky/boot/dts/gx6605s.dts
>>  create mode 100644 arch/csky/boot/dts/gx6605s.dtsi
>>
>> diff --git a/arch/csky/boot/dts/gx6605s.dts b/arch/csky/boot/dts/gx6605s.dts
>> new file mode 100644
>> index 000000000000..f7511024ec6f
>> --- /dev/null
>> +++ b/arch/csky/boot/dts/gx6605s.dts
[...]
>> +       leds {
>> +               compatible = "gpio-leds";
>> +
>> +               led0 {
>> +                       label = "led10";

I forgot to align the numbering here. The label matches the GPIO and
what is printed on the board.

>> +                       gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
>> +                       linux,default-trigger = "heartbeat";

This green one stops blinking and stays on.

>> +               };
>> +
>> +               led1 {
>> +                       label = "led11";
>> +                       gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
>> +                       linux,default-trigger = "timer";

This red one keeps blinking after the panic.

>> +               };
>> +
>> +               led2 {
>> +                       label = "led12";
>> +                       gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
>> +                       linux,default-trigger = "default-on";
>> +               };
>> +
>> +               led3 {
>> +                       label = "led13";
>> +                       gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
>> +                       linux,default-trigger = "default-on";

These two remain off. So I wonder whether the GPIO polarity is wrong?
In the example usb.img the gpio-leds module is not loaded by default, so
maybe it wasn't noticed before?

Also, many arm boards use more complex LED labels with multiple parts
separated by colon, like "boardname:name:function" or so.

>> +               };
>> +       };
[...]
>> diff --git a/arch/csky/boot/dts/gx6605s.dtsi b/arch/csky/boot/dts/gx6605s.dtsi
>> new file mode 100644
>> index 000000000000..956af5674add
>> --- /dev/null
>> +++ b/arch/csky/boot/dts/gx6605s.dtsi
>> @@ -0,0 +1,82 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause */
>> +/*
>> + * NationalChip GX6605S SoC
>> + *
>> + * Copyright (c) 2019 Andreas Färber
>> + */
>> +
>> +/ {
>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +
>> +       cpus {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               cpu0: cpu@0 {
>> +                       device_type = "cpu";
>> +                       compatible = "csky,ck610";
>> +                       reg = <0>;
>> +               };
>> +       };
>> +
>> +       soc {
>> +               compatible = "simple-bus";
>> +               interrupt-parent = <&intc>;
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges;
>> +
>> +               timer0: timer@20a000 {
>> +                       compatible = "csky,gx6605s-timer";

The reason I left out the compatible for the SoC/board is that it looks
unclean to me that you're using a "csky," vendor prefix for interrupt
controller and timer instead of a new "nationalchip," prefix for the SoC
vendor. Did I miss some reasoning for that, or did that slip through
patch review?

Being the first board we'd need to create a new YAML file to document
them, I assume. Not sure what the best scope (=name) would be here.

>> +                       reg = <0x0020a000 0x400>;
>> +                       clocks = <&dummy_apb_clk>;
>> +                       interrupts = <10>;
>> +               };
[...]
>> +               intc: interrupt-controller@500000 {
>> +                       compatible = "csky,gx6605s-intc";

Here's the other SoC compatible.

>> +                       reg = <0x00500000 0x400>;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <1>;
>> +               };
[snip]

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
