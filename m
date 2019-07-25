Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D49C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB93822BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfGYVdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:33:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39940 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfGYVdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:33:41 -0400
Received: from d57e23da.static.ziggozakelijk.nl ([213.126.35.218] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hqlMn-00029f-Ju; Thu, 25 Jul 2019 23:33:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] Revert "ARM: dts: rockchip: add startup delay to rk3288-veyron panel-regulators"
Date:   Thu, 25 Jul 2019 23:33:36 +0200
Message-ID: <3386344.sHu1S4gNag@phil>
In-Reply-To: <CAD=FV=UhNfhVG422=huthFSptoV4FXED=xPtArO2KkyNb1U3Xw@mail.gmail.com>
References: <20190620182056.61552-1-dianders@chromium.org> <CAD=FV=Wi21Emjg7CpCJfSRiKr_EisR20UO1tbPjAeJzdJNbSVw@mail.gmail.com> <CAD=FV=UhNfhVG422=huthFSptoV4FXED=xPtArO2KkyNb1U3Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 3. Juli 2019, 06:54:58 CEST schrieb Doug Anderson:
> Hi,
> 
> On Thu, Jun 20, 2019 at 1:31 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Jun 20, 2019 at 11:21 AM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > This reverts commit 1f45e8c6d0161f044d679f242fe7514e2625af4a.
> > >
> > > This 100 ms mystery delay is not on downstream kernels and no longer
> > > seems needed on upstream kernels either [1].  Presumably something in the
> > > meantime has made things better.  A few possibilities for patches that
> > > have landed in the meantime that could have made this better are
> > > commit 3157694d8c7f ("pwm-backlight: Add support for PWM delays
> > > proprieties."), commit 5fb5caee92ba ("pwm-backlight: Enable/disable
> > > the PWM before/after LCD enable toggle."), and commit 6d5922dd0d60
> > > ("ARM: dts: rockchip: set PWM delay backlight settings for Veyron")
> > >
> > > Let's revert and get our 100 ms back.
> > >
> > > [1] https://lkml.kernel.org/r/2226970.BAPq4liE1j@diego
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 1 -
> > >  arch/arm/boot/dts/rk3288-veyron-jerry.dts  | 1 -
> > >  arch/arm/boot/dts/rk3288-veyron-minnie.dts | 1 -
> > >  arch/arm/boot/dts/rk3288-veyron-speedy.dts | 1 -
> > >  4 files changed, 4 deletions(-)
> >
> > Maybe wait before applying.  I've been running reboot tests now with
> > this patch applied (among others) and with enough reboots I managed to
> > see:
> >
> > [    5.682418] rockchip-dp ff970000.dp: eDP link training failed (-5)
> >
> > I'll see if I can confirm that it's this patch and why things are
> > different compared to downstream.
> 
> OK, I finally got back to this and confirmed:
> 
> 1. The above error is actually somewhat harmless.  The eDP failure
> will be retried automatically despite the scary message.  Specifically
> see the loop in analogix_dp_bridge_enable().  I confirmed that after
> seeing the error the screen came up just fine (I looked at the screen
> in two actual instances but I believe it's pretty much always fine).
> 
> 2. I haven't seen any evidence that the eDP link training happens any
> more often with this revert in place.  Specifically, I see the same
> message in the logs (at what appears to be the same rate) with or
> without this revert.
> 
> 3. Probably the link-training failures here are the same ones we
> debugged for PSR for rk3399-gru-kevin that we fixed by making the eDP
> PCLK rate exactly 24 MHz.  See <https://crrev.com/c/433393> for
> details.  On rk3399-gru-kevin it was super important to resolve the
> root cause of these errors because we had PSR (which meant we were
> constantly taking to the eDP controller).  On rk3288-veyron devices
> with no PSR the retry should be a fine solution and it doesn't seem
> like a good idea to fully rejigger our clock plan to fix the root
> cause.
> 
> 
> NOTE: I saw _one_ case on rk3288-veyron-minnie where the screen looked
> wonky at bootup and I saw the eDP link training error in the logs.
> That's what originally made me cautious.  I haven't been able to
> reproduce this, but presumably I just got super unlucky in that one
> case.  I've left devices rebooting all day at work and haven't seen
> the wonky screen since then.
> 
> 
> Summary: I think this revert is just fine.

it looks like by picking Matthias' cleanups of the veyron displays
first I broke this patch. I guess we just need to remove the
	startup-delay-us = <100000>;
from the panel_regulator in the new rk3288-veyron-edp.dtsi ?


Heiko


