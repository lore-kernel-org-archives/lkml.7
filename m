Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF5AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FAC213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbfCVNDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:03:34 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40695 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbfCVNDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:03:30 -0400
X-Originating-IP: 90.88.33.153
Received: from localhost (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 267CCC0012;
        Fri, 22 Mar 2019 13:03:25 +0000 (UTC)
Date:   Fri, 22 Mar 2019 14:03:25 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/6] dmaengine: sun6i: Add a quirk for additional mbus
 clock
Message-ID: <20190322130325.jomwzsntzwjt6zhj@flea>
References: <20190307165829.9086-1-jernej.skrabec@siol.net>
 <20190307165829.9086-3-jernej.skrabec@siol.net>
 <20190316110753.GH5348@vkoul-mobl>
 <2451376.qVWA8nfu3q@jernej-laptop>
 <20190322125940.GE5348@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cx4t6dej4e6ikper"
Content-Disposition: inline
In-Reply-To: <20190322125940.GE5348@vkoul-mobl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cx4t6dej4e6ikper
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2019 at 06:29:40PM +0530, Vinod Koul wrote:
> On 16-03-19, 12:23, Jernej =C5=A0krabec wrote:
> > Hi!
> >
> > Dne sobota, 16. marec 2019 ob 12:07:53 CET je Vinod Koul napisal(a):
> > > On 07-03-19, 17:58, Jernej Skrabec wrote:
> > > > H6 DMA controller needs additional mbus clock to be enabled.
> > > >
> > > > Add a quirk for it and handle it accordingly.
> > > >
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > ---
> > > >
> > > >  drivers/dma/sun6i-dma.c | 23 ++++++++++++++++++++++-
> > > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > > > index 0cd13f17fc11..761555080325 100644
> > > > --- a/drivers/dma/sun6i-dma.c
> > > > +++ b/drivers/dma/sun6i-dma.c
> > > > @@ -129,6 +129,7 @@ struct sun6i_dma_config {
> > > >
> > > >  	u32 dst_burst_lengths;
> > > >  	u32 src_addr_widths;
> > > >  	u32 dst_addr_widths;
> > > >
> > > > +	bool mbus_clk;
> > > >
> > > >  };
> > > >
> > > >  /*
> > > >
> > > > @@ -182,6 +183,7 @@ struct sun6i_dma_dev {
> > > >
> > > >  	struct dma_device	slave;
> > > >  	void __iomem		*base;
> > > >  	struct clk		*clk;
> > > >
> > > > +	struct clk		*clk_mbus;
> > >
> > > So rather than have mbus_clk and then a ptr, why not use the ptr and =
use
> > > NULL value to check for..?
> > >
> >
> > I'm not sure what you mean here. clk_mbus will hold a reference to a cl=
ock
> > retrieved by devm_clk_get() so it has to be "struct clk *".
> >
> > What I'm missing here?
>
> IIRC there were two variable one clk ptr and one an integer to mark
> presence, you may be able to skip variable and use ptr..

If we're doing that, then we would effectively make it optional. That
DMA engine cannot operate without it.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--cx4t6dej4e6ikper
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJTdDgAKCRDj7w1vZxhR
xSbUAP9EeVKNwv86V4iEt039yt/IphxtO7I7GGSmGK6zrirNGAD9EwA3pUdJC38O
NIazXox9JWvWXSr0N0gbAG+dlU3cRgQ=
=8KMA
-----END PGP SIGNATURE-----

--cx4t6dej4e6ikper--
