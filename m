Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CD7C47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 03:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C953821835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 03:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfJHDUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 23:20:04 -0400
Received: from regular1.263xmail.com ([211.150.70.197]:57864 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbfJHDUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 23:20:03 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Oct 2019 23:20:02 EDT
Received: from localhost (unknown [192.168.165.252])
        by regular1.263xmail.com (Postfix) with ESMTP id 8722E5EB;
        Tue,  8 Oct 2019 11:12:21 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost (unknown [183.57.25.242])
        by smtp.263.net (postfix) whith ESMTP id P628T140409852389120S1570504336050683_;
        Tue, 08 Oct 2019 11:12:20 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <05ed1e03424721773edf294b718993ad>
X-RL-SENDER: djw@t-chip.com.cn
X-SENDER: djw@t-chip.com.cn
X-LOGIN-NAME: djw@t-chip.com.cn
X-FST-TO: jagan@amarulasolutions.com
X-SENDER-IP: 183.57.25.242
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   djw@t-chip.com.cn
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Da Xue <da@lessconfused.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list\:ARM\/Rockchip SoC..." 
        <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Akash Gajjar <akash@openedev.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/6] arm64: dts: rockchip: Fix rk3399-roc-pc pwm2 pin
Organization: Firefly Team
References: <20190919052822.10403-1-jagan@amarulasolutions.com>
        <20190919052822.10403-2-jagan@amarulasolutions.com>
        <6797961.eJj5WIFbM9@phil>
        <CAMty3ZDKaywoPxCSD-5N2pLjtGmZ-dZ7ZgUOJqiB1V_9rfR26A@mail.gmail.com>
Date:   Tue, 08 Oct 2019 11:11:10 +0800
In-Reply-To: <CAMty3ZDKaywoPxCSD-5N2pLjtGmZ-dZ7ZgUOJqiB1V_9rfR26A@mail.gmail.com>
        (Jagan Teki's message of "Tue, 1 Oct 2019 15:56:14 +0530")
Message-ID: <87eezolynl.fsf@archiso.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jagan Teki <jagan@amarulasolutions.com> writes:

> Hi Heiko,
>
> On Mon, Sep 30, 2019 at 2:51 AM Heiko Stuebner <heiko@sntech.de> wrote:
>>
>> Hi Jagan,
>>
>> Am Donnerstag, 19. September 2019, 07:28:17 CEST schrieb Jagan Teki:
>> > ROC-PC is not able to boot linux console if PWM2_d is
>> > unattached to any pinctrl logic.
>> >
>> > To be precise the linux boot hang with last logs as,
>> > ...
>> > .....
>> > [    0.003367] Console: colour dummy device 80x25
>> > [    0.003788] printk: console [tty0] enabled
>> > [    0.004178] printk: bootconsole [uart8250] disabled
>> >
>> > In ROC-PC the PWM2_d pin is connected to LOG_DVS_PWM of
>> > VDD_LOG. So, for normal working operations this needs to
>> > active and pull-down.
>> >
>> > This patch fix, by attaching pinctrl active and pull-down
>> > the pwm2.
>>
>> This looks highly dubious on first glance. The pwm subsystem nor
>> the Rockchip pwm driver do not do any pinctrl handling.
>>
>> So I don't really see where that "active" pinctrl state is supposed
>> to come from.
>>
>> Comparing with the pwm driver in the vendor tree I see that there
>> is such a state defined there. But that code there also looks strange
>> as that driver never again leaves this active state after entering it.
>>
>> Also for example all the Gru devices run with quite a number of pwm-
>> regulators without needing additional fiddling with the pwm itself, so
>> I don't really see why that should be different here.
>
> I deed, I was supposed to think the same. but the vendor kernel dts
> from firefly do follow the pwm2 pinctrl [1]. I wouldn't find any
> information other than this vensor information, ie one of the reason I
> have marked "Levin Du" who initially supported this board.
>
> One, think I have seen was this pinctrl active fixed the boot hang.
> any inputs from would be very helpful.
>
> Levin Du, any inputs?
>
> [1] https://github.com/FireflyTeam/kernel/blob/stable-4.4-rk3399-linux/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi#L1184
>

A grep of the `pwm2` shows that there's such block in rk3399-nanopi4.dtsi:

    &pwm2 {
            pinctrl-names = "active";
            pinctrl-0 = <&pwm2_pin_pull_down>;
            status = "okay";
    };

But last time I checked, using the mainline U-Boot (the roc-rk3399-pc is
in mainline now) with mainline linux v5.2-rc7, no such setting is
necessary, and the board boots happily.

I cannot find the use of "active" pinctrl state in the
`drivers/pwm/pwm-rockchip.c`. If the pinctrl state needs to be setup as
default, the `pinctrl-names` needs to be "default" or "init" (see
`drivers/base/pinctrl.c`) .

Jagan, what version of board do you use? I checked with
"ROC-RK3399-PC-V1.0-A 2018-07-12". 

Thanks

--
Levin Du


