Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C60C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166C12068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfLINx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:53:59 -0500
Received: from gloria.sntech.de ([185.11.138.130]:45280 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfLINx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:53:58 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ieJU1-0000ns-B0; Mon, 09 Dec 2019 14:53:53 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Schultz <d.schultz@phytec.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [RFCv1 0/8] RK3399 clean shutdown issue
Date:   Mon, 09 Dec 2019 14:53:52 +0100
Message-ID: <8087758.JvhXzBlCRf@diego>
In-Reply-To: <CAMdYzYoZY5gau=DGtPhk9CPV_WcyM4wjR9o+rPyaQfOzoy2Y=Q@mail.gmail.com>
References: <20191206184536.2507-1-linux.amoon@gmail.com> <724aa7db-3838-16f9-d344-1789ae2a5746@arm.com> <CAMdYzYoZY5gau=DGtPhk9CPV_WcyM4wjR9o+rPyaQfOzoy2Y=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Montag, 9. Dezember 2019, 14:37:28 CET schrieb Peter Geis:
> On Mon, Dec 9, 2019 at 8:29 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 06/12/2019 6:45 pm, Anand Moon wrote:
> > > Most of the RK3399 SBC boards do not perform clean
> > > shutdown and clean reboot.
> >
> > FWIW reboot problems on RK3399 have been tracked down to issues in
> > upstream ATF, and are unrelated to the PMIC.
> >
> > > These patches try to help resolve the issue with proper
> > > shutdown by turning off the PMIC.
> >
> > As mentioned elsewhere[1], although this is what the BSP kernel seems to
> > do, and in practice it's unlikely to matter for the majority of devboard
> > users like you and me, I still feel a bit uncomfortable with this
> > solution for systems using ATF as in principle the secure world might
> > want to know about orderly shutdowns, and this effectively makes every
> > shutdown an unexpected power loss from secure software's point of view.
> >
> > Robin.
> 
> Since ATF is operating completely in volatile memory, and shouldn't be
> touching hardware once it passes off control to the kernel anyways,
> what is the harm of pulling the rug out from under it?

Secure-world doesn't end with ATF :-)

There can also be an instance of OP-TEE or another TEE on top and they
often actually do secure storage encrypted onto the hosts mass storage
(see kernel's optee module).


> If this idea is to prevent issues in the future, such as if ATF does
> gain the ability to preempt hardware control, then at that time ATF
> will need to be able to handle actually powering off devices using the
> same functionality.
> 
> But as we discussed previously, ATF doesn't have this capability, so
> in this case any board without a dedicated power-off gpio will be
> unable to power off at all.
> Also it seems that giving ATF this functionality, with the current
> state of ATF, would be cost prohibitive.
> 
> I personally feel that allowing the kernel to do this is a solution to
> the problem we have now.

For the rest I guess I'll just point to Robin's text and Ack under your
system-power-controller patch ;-)

Heiko


> > [1]
> > http://lists.infradead.org/pipermail/linux-rockchip/2019-December/028183.html
> >
> > > For reference
> > > RK805 PMCI data sheet:
> > > [0] http://rockchip.fr/RK805%20datasheet%20V1.3.pdf
> > > RK808 PMIC data sheet:
> > > [1] http://rockchip.fr/RK808%20datasheet%20V1.4.pdf
> > > RK817 PMIC data sheet:
> > > [2] http://rockchip.fr/RK817%20datasheet%20V1.01.pdf
> > > RK818 PMIC data sheet:
> > > [3] http://rockchip.fr/RK818%20datasheet%20V1.0.pdf
> > >
> > > Reboot issue:
> > > My guess is that we need to some proper sequence of
> > > setting to PMCI to perform clean.
> > >
> > > If you have any input please share them.
> > >
> > > Tested on SBC
> > > Rock960 Model A
> > > Odroid N1
> > > Rock64
> > >
> > > -Anand Moon
> > >
> > > Anand Moon (8):
> > >    mfd: rk808: Refactor shutdown functions
> > >    mfd: rk808: use syscore for RK805 PMIC shutdown
> > >    mfd: rk808: use syscore for RK808 PMIC shutdown
> > >    mfd: rk808: use syscore for RK818 PMIC shutdown
> > >    mfd: rk808: cleanup unused function pointer
> > >    mfd: rk808: use common syscore for all PMCI for clean shutdown
> > >    arm64: rockchip: drop unused field from rk8xx i2c node
> > >    arm: rockchip: drop unused field from rk8xx i2c node
> > >
> > >   arch/arm/boot/dts/rk3036-kylin.dts            |   1 -
> > >   arch/arm/boot/dts/rk3188-px3-evb.dts          |   1 -
> > >   arch/arm/boot/dts/rk3288-evb-rk808.dts        |   1 -
> > >   arch/arm/boot/dts/rk3288-phycore-som.dtsi     |   1 -
> > >   arch/arm/boot/dts/rk3288-popmetal.dts         |   1 -
> > >   arch/arm/boot/dts/rk3288-tinker.dtsi          |   1 -
> > >   arch/arm/boot/dts/rk3288-veyron.dtsi          |   1 -
> > >   arch/arm/boot/dts/rk3288-vyasa.dts            |   1 -
> > >   arch/arm/boot/dts/rv1108-elgin-r1.dts         |   1 -
> > >   arch/arm/boot/dts/rv1108-evb.dts              |   1 -
> > >   arch/arm64/boot/dts/rockchip/px30-evb.dts     |   1 -
> > >   arch/arm64/boot/dts/rockchip/rk3328-a1.dts    |   1 -
> > >   arch/arm64/boot/dts/rockchip/rk3328-evb.dts   |   1 -
> > >   .../arm64/boot/dts/rockchip/rk3328-roc-cc.dts |   1 -
> > >   .../arm64/boot/dts/rockchip/rk3328-rock64.dts |   1 -
> > >   .../boot/dts/rockchip/rk3368-geekbox.dts      |   1 -
> > >   arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi |   1 -
> > >   .../boot/dts/rockchip/rk3368-px5-evb.dts      |   1 -
> > >   .../boot/dts/rockchip/rk3399-firefly.dts      |   1 -
> > >   .../boot/dts/rockchip/rk3399-hugsun-x99.dts   |   1 -
> > >   .../boot/dts/rockchip/rk3399-khadas-edge.dtsi |   1 -
> > >   .../boot/dts/rockchip/rk3399-leez-p710.dts    |   1 -
> > >   .../boot/dts/rockchip/rk3399-nanopi4.dtsi     |   1 -
> > >   .../boot/dts/rockchip/rk3399-orangepi.dts     |   1 -
> > >   arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi |   1 -
> > >   .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |   1 -
> > >   .../boot/dts/rockchip/rk3399-rock-pi-4.dts    |   1 -
> > >   .../boot/dts/rockchip/rk3399-rock960.dtsi     |   1 -
> > >   .../boot/dts/rockchip/rk3399-rockpro64.dts    |   1 -
> > >   .../boot/dts/rockchip/rk3399-sapphire.dtsi    |   1 -
> > >   drivers/mfd/rk808.c                           | 144 +++++-------------
> > >   include/linux/mfd/rk808.h                     |   2 -
> > >   32 files changed, 42 insertions(+), 134 deletions(-)
> > >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 




