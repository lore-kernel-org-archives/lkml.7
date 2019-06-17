Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2482FC31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079882084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfFQOy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:54:29 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50121 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfFQOy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:54:29 -0400
Received: from localhost (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C497C240018;
        Mon, 17 Jun 2019 14:54:20 +0000 (UTC)
Date:   Mon, 17 Jun 2019 16:54:20 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 5/9] drm/sun4i: tcon_top: Register
 clock gates in probe
Message-ID: <20190617145420.e7yfrmmhdhift5id@flea>
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-6-jagan@amarulasolutions.com>
 <20190617114503.pclqsf6bo3ih47nt@flea>
 <CAGb2v66RU=m0iA9VoBiYbake+mDoiiGcd5gGGXvNCBjhY2n+Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jzvxnzdlcqa2ksrf"
Content-Disposition: inline
In-Reply-To: <CAGb2v66RU=m0iA9VoBiYbake+mDoiiGcd5gGGXvNCBjhY2n+Dw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jzvxnzdlcqa2ksrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2019 at 09:01:33PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jun 17, 2019 at 7:45 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Jun 14, 2019 at 10:13:20PM +0530, Jagan Teki wrote:
> > > TCON TOP have clock gates for TV0, TV1, dsi and right
> > > now these are register during bind call.
> > >
> > > Of which, dsi clock gate would required during DPHY probe
> > > but same can miss to get since tcon top is not bound at
> > > that time.
> > >
> > > To solve, this circular dependency move the clock gate
> > > registration from bind to probe so-that DPHY can get the
> > > dsi gate clock on time.
> >
> > It's not really clear to me what the circular dependency is?
> >
> > if you have a chain that is:
> >
> > tcon-top +-> DSI
> >          +-> D-PHY
> >
> > There's no loop, right?
>
> Looking at how the DTSI patch structures things (without going into
> whether it is correct or accurate):
>
> The D-PHY is not part of the component graph. However it requests
> the DSI gate clock from the TCON-TOP.
>
> The TCON-TOP driver, in its current form, only registers the clocks
> it provides at component bind time. Thus the D-PHY can't successfully
> probe until the TCON-TOP has been bound.
>
> The DSI interface requires the D-PHY to bind. It will return -EPROBE_DEFER
> if it cannot request it. This in turn goes into the error path of
> component_bind_all, which unbinds all previous components.
>
> So it's actually
>
>     D-PHY -> TCON-TOP -> DSI
>       ^                   |
>       |--------------------
>
> I've not checked, but I suspect there's no possibility of having other
> drivers probe (to deal with deferred probing) within component_bind_all.
> Otherwise we shouldn't run into this weird circular dependency issue.
>

Ah, yes, that makes sense. It should be cleraer in the commit log then.

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jzvxnzdlcqa2ksrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQepmwAKCRDj7w1vZxhR
xYw9AQDHLFtmVu3MFQ1SBBQaIYnHJKObnT7QFiGqQdKlvtmJPQEAnVAr+0qvuMbJ
nxfnMe/iGRf/aI9F/dseertWbl3c1AQ=
=Vhms
-----END PGP SIGNATURE-----

--jzvxnzdlcqa2ksrf--
