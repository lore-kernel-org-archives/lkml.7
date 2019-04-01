Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D1EC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDCA2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbfDAIPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:15:32 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:32819 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDAIPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:15:32 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C5E8924000F;
        Mon,  1 Apr 2019 08:15:24 +0000 (UTC)
Date:   Mon, 1 Apr 2019 10:15:24 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 08/14] clk: sunxi-ng: v3s: add Allwinner V3 support
Message-ID: <20190401081524.bickdv7kr4kcnsgm@flea>
References: <20190312152256.35574-1-icenowy@aosc.io>
 <20190312152256.35574-9-icenowy@aosc.io>
 <20190328132721.GA32178@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jc3kve7lqqq7wqjx"
Content-Disposition: inline
In-Reply-To: <20190328132721.GA32178@bogus>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jc3kve7lqqq7wqjx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 28, 2019 at 08:27:21AM -0500, Rob Herring wrote:
> On Tue, Mar 12, 2019 at 11:22:50PM +0800, Icenowy Zheng wrote:
> > Allwinner V3 has the same main die with V3s, but with more pins wired.
> > There's a I2S bus on V3 that is not available on V3s.
> >
> > Add the V3-only peripheral's clocks and reset to the V3s CCU driver,
> > bound to a new V3 compatible string. The driver name is not changed
> > because it's part of the device tree binding (the header file name).
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c      | 225 +++++++++++++++++++++-
> >  drivers/clk/sunxi-ng/ccu-sun8i-v3s.h      |   2 +-
> >  include/dt-bindings/clock/sun8i-v3s-ccu.h |   4 +
> >  include/dt-bindings/reset/sun8i-v3s-ccu.h |   3 +
> >  4 files changed, 231 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> > index cbba04f5f761..81450ea8faa2 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> > @@ -242,6 +242,8 @@ static SUNXI_CCU_GATE(bus_codec_clk,	"bus-codec",	"apb1",
> >  		      0x068, BIT(0), 0);
> >  static SUNXI_CCU_GATE(bus_pio_clk,	"bus-pio",	"apb1",
> >  		      0x068, BIT(5), 0);
> > +static SUNXI_CCU_GATE(bus_i2s0_clk,	"bus-i2s0",	"apb1",
> > +		      0x068, BIT(12), 0);
> >
> >  static SUNXI_CCU_GATE(bus_i2c0_clk,	"bus-i2c0",	"apb2",
> >  		      0x06c, BIT(0), 0);
> > @@ -313,6 +315,11 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(spi0_clk, "spi0", mod0_default_parents, 0x0a0,
> >  				  BIT(31),	/* gate */
> >  				  0);
> >
> > +static const char * const i2s_parents[] = { "pll-audio-8x", "pll-audio-4x",
> > +					    "pll-audio-2x", "pll-audio" };
> > +static SUNXI_CCU_MUX_WITH_GATE(i2s0_clk, "i2s0", i2s_parents,
> > +			       0x0b0, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
> > +
> >  static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
> >  		      0x0cc, BIT(8), 0);
> >  static SUNXI_CCU_GATE(usb_ohci0_clk,	"usb-ohci0",	"osc24M",
> > @@ -445,6 +452,80 @@ static struct ccu_common *sun8i_v3s_ccu_clks[] = {
> >  	&mipi_csi_clk.common,
> >  };
> >
> > +static struct ccu_common *sun8i_v3_ccu_clks[] = {
>
> Seems like a bunch of duplication for just 2 differences in clocks.
> Can't you keep the definitions the same and just skip registering the
> clocks not present?

I'd rather not, this can lead to access to registers that might not be
there when the CCF will read / write that clock

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jc3kve7lqqq7wqjx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKHInAAKCRDj7w1vZxhR
xZ+WAP92QhUeKofhCPBW2R6w+MmaHaURTZ1S7Q0dQwrc7GzGIwEAnITh/XSIMAU7
l1W4aXbf1ct2/M9dDexttVTYemsRmwc=
=QvxI
-----END PGP SIGNATURE-----

--jc3kve7lqqq7wqjx--
