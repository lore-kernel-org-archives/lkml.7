Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269CDC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25592085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfEAPJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:09:56 -0400
Received: from gloria.sntech.de ([185.11.138.130]:42722 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEAPJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:09:56 -0400
Received: from [195.37.15.138] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hLqrj-000435-PA; Wed, 01 May 2019 17:09:47 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [DO NOT MERGE] [PATCH 2/2] arm64: rockchip: rk3399: nanopc-t4: Enable FriendlyELEC HD702E eDP panel
Date:   Wed, 01 May 2019 17:09:46 +0200
Message-ID: <59905981.qcSMt8CUfq@phil>
In-Reply-To: <CAMty3ZBdko3+p6SoKYH-Mwism-Qnp3F5u7JV8YQTHzNP8A5kEg@mail.gmail.com>
References: <20190501121448.3812-1-jagan@amarulasolutions.com> <cc16498b-71f8-04ce-44d1-25417fd64757@arm.com> <CAMty3ZBdko3+p6SoKYH-Mwism-Qnp3F5u7JV8YQTHzNP8A5kEg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 1. Mai 2019, 16:09:46 CEST schrieb Jagan Teki:
> On Wed, May 1, 2019 at 6:17 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 01/05/2019 13:14, Jagan Teki wrote:
> > > FriendlyELEC HD702E is one of optional LCD panel for
> > > NanoPC T4 eDP interface.
> > >
> > > It features 800x1280 resolutions, with built in GT9271 captive
> > > touchscreen and adjustable backlight via PWM.
> > >
> > > eDP panel connections are:
> > > - VCC3V3_SYS: 3.3V panel power supply
> > > - GPIO4_C2: PWM0_BL pin
> > > - GPIO4_D5_LCD_BL_EN: Backlight enable pin
> > > - VCC12V0_SYS: 12V backlight power supply
> > > - Touchscreen connected via I2C4
> > > - GPIO1_C4_TP_INT: touchscreen interrupt pin
> > > - GPIO1_B5_TP_RST: touchscreen reset pin
> > >
> > > Add support for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Note: we need to disable hdmi-cec pinctrl to work with
> > > edp-hpd since both share same pin, otherwise we can
> > > encounter below error during bootup
> > > [    1.047726] rockchip-pinctrl pinctrl: pin gpio4-23 already requested by ff940000.hdmi; cannot claim for ff970000.edp
> > > [    1.048655] rockchip-pinctrl pinctrl: pin-151 (ff970000.edp) status -22
> > > [    1.049235] rockchip-pinctrl pinctrl: could not request pin 151 (gpio4-23) from group edp-hpd  on device rockchip-pinctrl
> > > [    1.050191] rockchip-dp ff970000.edp: Error applying setting, reverse things back
> > > [    1.050867] rockchip-dp: probe of ff970000.edp failed with error -22
> >
> > Hmm, AFAICS that pin is exclusively wired to the HDMI connector and not
> > used for the eDP interface, so really it's the fault of rk3399.dtsi for
> > trying to claim it unconditionally. Ideally we'd pull those pinctrl
> > properties out into the board DTs which do actually need them, but the
> > quick and easy approach would be to add some "/delete-property/ ..."
> > workarounds to the &edp node here.
> 
> Thought that initially, but the same pin shared between HDMI CEC and
> eDP hotplug with different bit function to enable.
> 
> gpio4c7_sel
> GPIO4C[7] iomux select
> 2'b00: gpio
> 2'b01: hdmi_cecinout
> 2'b10: edp_hotplug
> 2'b11: reserved
> 
> GPIO4_C7/HDMI_CECINOUT/EDP_HOTPLUG is the shared pin, which is
> available in any nanopc-t4 as well in rk3399 datasheet, look like it's
> an SoC pin that driver hotplug to eDP and ie same reason is pinmux in
> rk3399.dtsi.

Yes the pin of the soc is shared between those functions, so you'll
have to check the schematics of your board where this pin is going
to.

If you check the schematics [0] page 11, GPIO4_C7's signal is named HDMI_CEC
and on page 18 you can see that it goes as expected to the cec-pin of the
hdmi connector. 

So the Nanopc-T4 should only select the cec signal.


Heiko
[0] http://wiki.friendlyarm.com/wiki/images/f/f4/NanoPC-T4-1802-Schematic.pdf



