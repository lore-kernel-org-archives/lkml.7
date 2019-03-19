Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C80AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFFA2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfCSKxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:53:15 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:46733 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:53:15 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 30120240006;
        Tue, 19 Mar 2019 10:53:08 +0000 (UTC)
Date:   Tue, 19 Mar 2019 11:53:07 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v8 02/15] drm/sun4i: tcon: Compute DCLK dividers based on
 format, lanes
Message-ID: <20190319105307.omowzyhqu33e3pzy@flea>
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-3-jagan@amarulasolutions.com>
 <20190311153847.oz6ruqmptaq2befn@flea>
 <CAMty3ZChz=s7gdQyX9KnsAp1t5FrpouXGK74-r0SKJ89yJN67Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w5h7eaccwffawgtl"
Content-Disposition: inline
In-Reply-To: <CAMty3ZChz=s7gdQyX9KnsAp1t5FrpouXGK74-r0SKJ89yJN67Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w5h7eaccwffawgtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2019 at 09:36:27PM +0530, Jagan Teki wrote:
> On Mon, Mar 11, 2019 at 9:08 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 07:06:24PM +0530, Jagan Teki wrote:
> > > pll-video => pll-mipi => tcon0 => tcon0-pixel-clock is the typical
> > > MIPI clock topology in Allwinner DSI controller.
> > >
> > > TCON dotclock driver is computing the desired DCLK divider based on
> > > panel pixel clock along with input DCLK min, max divider values from
> > > tcon driver and that would eventually set the pll-mipi clock rate.
> > >
> > > The current code allows the TCON clock divider to have a default 4
> > > for min, max ranges that would fail to compute the desired pll-mipi
> > > rate while supporting new panels.
> > >
> > > So, add the computation logic 'format/lanes' to dclk min and max dividers
> > > and instead of default 4. This computation logic align with Allwinner A64
> > > BSP, hoping that would work even for A33.
> >
> > Last time we discussed this, we found out that this wasn't the case,
> > even in the BSP.
>
> This was the case for BSP to compute pll-mipi not for TCON_DSI clock
> register, SUN4I_TCON0_DCLK_REG, which marked the divider 4 by default.
>
> > What compelling evidence have you found that makes you say otherwise?
>
> divider 4 isn't worked, this I would mentioned before as well.

Maybe you mentionned it before, but it's nowhere to be found in your
commit log.

> Tested this on 4 different panels, and below are the desired divider values
> and pll-mipi clock rate with respect to pixel clock frequency.
>
> - 55MHz pixel clock with 4-lane panel, and the desired DSI clock divider
>   is 6 with the output parent clock rate of 330MHz.
> - 30MHz pixel clock with 4-lane panel, and the desired DSI clock divider
>   is 6 with parent clock rate of 180MHz.
> - 27.5Mhz pixel clock with 2-lane pane, and the desired DSI clock divider
>   is 12 with the output parent clock rate of 330MHz.
> - 147MHz pixel clock with 4-lane panel, and the desired DSI clock divider
>   is 6 with the output parent clock rate of 882MHz.
>
> BSP trying to use this format/lane to compute dsi divider that in-turn
> using pll-mipi set_rate but TCON0_DCLK_REG keep constant 4.

Feel free to reply to
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/629596.html

And correct whatever is said there that isn't what is happening.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--w5h7eaccwffawgtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJDKEwAKCRDj7w1vZxhR
xbr5AQCiJXB+00l7s1Mti99Cws7LddzTZwolRvZ771IyBtL7JgD8DsVRc1k30G2W
pWr8WWorQ8oIxnGrpRrlMfKhBsi+9Aw=
=x16K
-----END PGP SIGNATURE-----

--w5h7eaccwffawgtl--
