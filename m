Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69C9C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A112068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfLIN60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:58:26 -0500
Received: from foss.arm.com ([217.140.110.172]:33168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbfLIN6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:58:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7696328;
        Mon,  9 Dec 2019 05:58:24 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFE123F718;
        Mon,  9 Dec 2019 05:58:22 -0800 (PST)
Subject: Re: [RFCv1 0/8] RK3399 clean shutdown issue
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Schultz <d.schultz@phytec.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <20191206184536.2507-1-linux.amoon@gmail.com>
 <724aa7db-3838-16f9-d344-1789ae2a5746@arm.com>
 <CAMdYzYoZY5gau=DGtPhk9CPV_WcyM4wjR9o+rPyaQfOzoy2Y=Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f7ac4ff0-5c32-9bb3-1547-ec7ac80bf38d@arm.com>
Date:   Mon, 9 Dec 2019 13:58:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMdYzYoZY5gau=DGtPhk9CPV_WcyM4wjR9o+rPyaQfOzoy2Y=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2019 1:37 pm, Peter Geis wrote:
> On Mon, Dec 9, 2019 at 8:29 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 06/12/2019 6:45 pm, Anand Moon wrote:
>>> Most of the RK3399 SBC boards do not perform clean
>>> shutdown and clean reboot.
>>
>> FWIW reboot problems on RK3399 have been tracked down to issues in
>> upstream ATF, and are unrelated to the PMIC.
>>
>>> These patches try to help resolve the issue with proper
>>> shutdown by turning off the PMIC.
>>
>> As mentioned elsewhere[1], although this is what the BSP kernel seems to
>> do, and in practice it's unlikely to matter for the majority of devboard
>> users like you and me, I still feel a bit uncomfortable with this
>> solution for systems using ATF as in principle the secure world might
>> want to know about orderly shutdowns, and this effectively makes every
>> shutdown an unexpected power loss from secure software's point of view.
>>
>> Robin.
> 
> Since ATF is operating completely in volatile memory, and shouldn't be
> touching hardware once it passes off control to the kernel anyways,
> what is the harm of pulling the rug out from under it?
> If this idea is to prevent issues in the future, such as if ATF does
> gain the ability to preempt hardware control, then at that time ATF
> will need to be able to handle actually powering off devices using the
> same functionality.

It's not ATF itself I'm concerned about, but arbitrary Secure EL1 
payloads. In theory, a TEE might want to do something like cycle keys or 
log events in a TPM (or just encrypted in an external SPI flash), or 
scrub secure DRAM for cold boot protection. I'm pretty sure none of us 
are running such a thing on our boards today, but an upstream solution 
really wants to be robust for the general case.

> But as we discussed previously, ATF doesn't have this capability, so
> in this case any board without a dedicated power-off gpio will be
> unable to power off at all.
> Also it seems that giving ATF this functionality, with the current
> state of ATF, would be cost prohibitive.
> 
> I personally feel that allowing the kernel to do this is a solution to
> the problem we have now.

Sure - I do like your cool idea of using a custom reboot reason to 
handle a 'trusted' poweroff in the U-Boot SPL - but in the meantime 
anything would be a practical improvement over the current situation. I 
reckon this other patch[1] (this seems to be a popular issue all of a 
sudden!) looks like the neatest interim step.

Robin.

[1] 
http://lists.infradead.org/pipermail/linux-rockchip/2019-December/028245.html

>>> For reference
>>> RK805 PMCI data sheet:
>>> [0] http://rockchip.fr/RK805%20datasheet%20V1.3.pdf
>>> RK808 PMIC data sheet:
>>> [1] http://rockchip.fr/RK808%20datasheet%20V1.4.pdf
>>> RK817 PMIC data sheet:
>>> [2] http://rockchip.fr/RK817%20datasheet%20V1.01.pdf
>>> RK818 PMIC data sheet:
>>> [3] http://rockchip.fr/RK818%20datasheet%20V1.0.pdf
>>>
>>> Reboot issue:
>>> My guess is that we need to some proper sequence of
>>> setting to PMCI to perform clean.
>>>
>>> If you have any input please share them.
>>>
>>> Tested on SBC
>>> Rock960 Model A
>>> Odroid N1
>>> Rock64
>>>
>>> -Anand Moon
>>>
>>> Anand Moon (8):
>>>     mfd: rk808: Refactor shutdown functions
>>>     mfd: rk808: use syscore for RK805 PMIC shutdown
>>>     mfd: rk808: use syscore for RK808 PMIC shutdown
>>>     mfd: rk808: use syscore for RK818 PMIC shutdown
>>>     mfd: rk808: cleanup unused function pointer
>>>     mfd: rk808: use common syscore for all PMCI for clean shutdown
>>>     arm64: rockchip: drop unused field from rk8xx i2c node
>>>     arm: rockchip: drop unused field from rk8xx i2c node
>>>
>>>    arch/arm/boot/dts/rk3036-kylin.dts            |   1 -
>>>    arch/arm/boot/dts/rk3188-px3-evb.dts          |   1 -
>>>    arch/arm/boot/dts/rk3288-evb-rk808.dts        |   1 -
>>>    arch/arm/boot/dts/rk3288-phycore-som.dtsi     |   1 -
>>>    arch/arm/boot/dts/rk3288-popmetal.dts         |   1 -
>>>    arch/arm/boot/dts/rk3288-tinker.dtsi          |   1 -
>>>    arch/arm/boot/dts/rk3288-veyron.dtsi          |   1 -
>>>    arch/arm/boot/dts/rk3288-vyasa.dts            |   1 -
>>>    arch/arm/boot/dts/rv1108-elgin-r1.dts         |   1 -
>>>    arch/arm/boot/dts/rv1108-evb.dts              |   1 -
>>>    arch/arm64/boot/dts/rockchip/px30-evb.dts     |   1 -
>>>    arch/arm64/boot/dts/rockchip/rk3328-a1.dts    |   1 -
>>>    arch/arm64/boot/dts/rockchip/rk3328-evb.dts   |   1 -
>>>    .../arm64/boot/dts/rockchip/rk3328-roc-cc.dts |   1 -
>>>    .../arm64/boot/dts/rockchip/rk3328-rock64.dts |   1 -
>>>    .../boot/dts/rockchip/rk3368-geekbox.dts      |   1 -
>>>    arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi |   1 -
>>>    .../boot/dts/rockchip/rk3368-px5-evb.dts      |   1 -
>>>    .../boot/dts/rockchip/rk3399-firefly.dts      |   1 -
>>>    .../boot/dts/rockchip/rk3399-hugsun-x99.dts   |   1 -
>>>    .../boot/dts/rockchip/rk3399-khadas-edge.dtsi |   1 -
>>>    .../boot/dts/rockchip/rk3399-leez-p710.dts    |   1 -
>>>    .../boot/dts/rockchip/rk3399-nanopi4.dtsi     |   1 -
>>>    .../boot/dts/rockchip/rk3399-orangepi.dts     |   1 -
>>>    arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi |   1 -
>>>    .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |   1 -
>>>    .../boot/dts/rockchip/rk3399-rock-pi-4.dts    |   1 -
>>>    .../boot/dts/rockchip/rk3399-rock960.dtsi     |   1 -
>>>    .../boot/dts/rockchip/rk3399-rockpro64.dts    |   1 -
>>>    .../boot/dts/rockchip/rk3399-sapphire.dtsi    |   1 -
>>>    drivers/mfd/rk808.c                           | 144 +++++-------------
>>>    include/linux/mfd/rk808.h                     |   2 -
>>>    32 files changed, 42 insertions(+), 134 deletions(-)
>>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
