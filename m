Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154DBC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54012075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbfEWUzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:55:03 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:35473 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387529AbfEWUzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:55:02 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2EBF5FF803;
        Thu, 23 May 2019 20:54:51 +0000 (UTC)
Date:   Thu, 23 May 2019 22:54:50 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64-oceanic-5205-5inmfd: Enable
 CAN
Message-ID: <20190523205450.bwccpvehpiugogbs@flea>
References: <20190418141658.10868-1-jagan@amarulasolutions.com>
 <20190418145641.q23tupopz2czjzc5@flea>
 <CAOf5uwn8CtRs8cx0KC-bxNoRP4TiDrHi8F83QfjsZhueLDYFJg@mail.gmail.com>
 <20190521081001.zjq3gnlvyuyexz6m@flea>
 <CAOf5uwnhXjur=2NezCydaCxP5d33S+AwdD9WTDtp2EUJr4UTgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf5uwnhXjur=2NezCydaCxP5d33S+AwdD9WTDtp2EUJr4UTgg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Tue, May 21, 2019 at 01:08:09PM +0200, Michael Nazzareno Trimarchi wrote:
> On Tue, May 21, 2019 at 10:10 AM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Tue, May 21, 2019 at 08:47:02AM +0200, Michael Nazzareno Trimarchi wrote:
> > > > > +     };
> > > > > +
> > > > >  };
> > > > >
> > > > >  &ehci0 {
> > > > > @@ -77,6 +95,31 @@
> > > > >       status = "okay";
> > > > >  };
> > > > >
> > > > > +&pio {
> > > > > +     can_pins: can-pins {
> > > > > +             pins = "PD6",                   /* RX_BUF1_CAN0 */
> > > > > +                    "PD7";                   /* RX_BUF0_CAN0 */
> > > > > +             function = "gpio_in";
> > > > > +     };
> > > > > +};
> > > >
> > > > That isn't needed. What are they used for, you're not tying them to
> > > > anything?
> > >
> > > Mux of their function is correct. They are connected in the schematics
> > > but not used right now.
> >
> > Then describe the whole thing or don't?
> >
>
> Ok
>
> > And that's kind of missing my point. If that pin group isn't related
> > to any device, the pin muxing will not be changed. So that group, in
> > itself, has strictly no effect.
> >
> > Moreover, you don't need a pin group in the first place to mux pins in
> > GPIOs, the GPIO API will make sure that is the case when you request
> > it.
>
> This is correct on sunxi. Is this valid for sunxi or in general in
> all the SoC?

IIRC, it happens on all the SoCs that have a shared GPIO/pinctrl
driver.

> Anyway make sense to have pins configured and place in the right
> state, just suppose if the booting stage is wrong or anything that
> make those pins in the wrong configuration

It would be a bug in the pinctrl / GPIO code that would need to be
fixed.

> >
> > > I can garantee that kernel wlll always configurred in the right way
> > > and if I want I can export in userspace
> > > for debug purpose
>
> Correct if you start to use it but if you want them right configured
> the right place is in the default state e/o initstate if this can be
> a problem of the hardware

What problem do you have exactly?

> Default state: the state the pinctrl handle shall be put
>  *      into as default, usually this means the pins are up and ready to
>  *      be used by the device driver. This state is commonly used by
>  *      hogs to configure muxing and pins at boot, and also as a state
>  *      to go into when returning from sleep and idle in
>  *      .pm_runtime_resume() or ordinary .resume() for example.
>
> Now the pins are connected to the canbus as should be and they are
> configured and usually put in the right state.

As soon as you call gpio_get, the pins will be configured properly.

And, pinctrl shouldn't allow that configuration (gpio_get + a pinctrl
node for GPIOs) in our case. We do on most SoCs (all but the H6) for
historical reasons, but this creates other bugs that we can't really
fix right now. Still, we're slowly removing all of those pinctrl
nodes, so it's not really to add new ones.

> +               compatible = "microchip,mcp2515";
> +               reg = <0>;
> +               spi-max-frequency = <10000000>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&can_pins>;
>
> >
> > Yes, because the API does it, not your change
>
> Do you prefer to drop the pinmux? or update the commit message

Drop the pinctrl group

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
