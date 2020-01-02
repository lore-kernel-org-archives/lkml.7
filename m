Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B286C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C04522525
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgABKmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:42:18 -0500
Received: from foss.arm.com ([217.140.110.172]:46078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgABKmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:42:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5FFA328;
        Thu,  2 Jan 2020 02:42:17 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7830A3F703;
        Thu,  2 Jan 2020 02:42:16 -0800 (PST)
Date:   Thu, 2 Jan 2020 10:41:58 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: R40: Add SPI controllers nodes and
 pinmuxes
Message-ID: <20200102104158.06d9baa0@donnerap.cambridge.arm.com>
In-Reply-To: <20200102095711.dkd2cnbyitz6mvyx@gilmour.lan>
References: <20200102012657.9278-1-andre.przywara@arm.com>
        <20200102012657.9278-4-andre.przywara@arm.com>
        <20200102095711.dkd2cnbyitz6mvyx@gilmour.lan>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020 10:57:11 +0100
Maxime Ripard <mripard@kernel.org> wrote:

Hi Maxime,

thanks for having a look!

> On Thu, Jan 02, 2020 at 01:26:57AM +0000, Andre Przywara wrote:
> > The Allwinner R40 SoC contains four SPI controllers, using the newer
> > sun6i design (but at the legacy addresses).
> > The controller seems to be fully compatible to the A64 one, so no driver
> > changes are necessary.
> > The first three controller can be used on two sets of pins, but SPI3 is
> > only routed to one set on Port A.
> >
> > Tested by connecting a SPI flash to a Bananapi M2 Berry on the SPI0
> > PortC header pins.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  arch/arm/boot/dts/sun8i-r40.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > index 8dcbc4465fbb..af437391dcf4 100644
> > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > @@ -418,6 +418,41 @@
> >  				bias-pull-up;
> >  			};
> >
> > +			spi0_pc_pins: spi0-pc-pins {
> > +				pins = "PC0", "PC1", "PC2", "PC23";
> > +				function = "spi0";
> > +			};
> > +
> > +			spi0_pi_pins: spi0-pi-pins {
> > +				pins = "PI10", "PI11", "PI12", "PI13", "PI14";
> > +				function = "spi0";
> > +			};  
> 
> This split doesn't really work though :/
> 
> The PC pins group has MOSI, MISO, CLK and CS0, while the PI pins group
> has CS0, CLK, MOSI, MISO and CS1.
> 
> Meaning that if a board uses a GPIO CS pin, we can't really express
> that

Does that actually work? I dimly remember checking our sunxi driver a while ago and I wasn't sure that would be functional there.

> and any board using the PI pins for its SPI bus will try to
> claim CS0 and CS1, no matter how many devices are connected on the bus
> (and if there's one, there might be something else connected to PI14).

True.

> And you can't have a board using CS1 with the PC signals either.
> 
> You should split away the CS pins into separate groups, like we're
> doing with the A20 for example.

Ah, yeah, makes sense, thanks for the pointer.
 
> And please add /omit-if-no-ref/ to those groups.

I was a bit reluctant to do this:
First there does not seem to be any good documentation about it, neither in the official DT spec nor in dtc, even though I think I understand what it does ;-)
Second it seems to break in U-Boot atm. Looks like applying your dtc patch fixes that, though. Do you know if U-Boot allows cherry-picking dtc patches? If yes, I could post your patch.

But more importantly: what are the guidelines for using this tag? I understand the desire to provide every possible pin description on one hand, but wanting to avoid having *all of them* in *each* .dtb on the other.
But how does this play along with overlays? Shouldn't at least those interface pins that are exposed on headers stay in each .dtb? Can we actually make this decision in the SoC .dtsi file?
And should there be a dtc command line option to ignore those tags, or even to apply this tag (virtually) to every node?

Cheers,
Andre.
