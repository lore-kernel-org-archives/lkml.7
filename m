Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17857CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65212084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406752AbfJWPdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:33:16 -0400
Received: from sauhun.de ([88.99.104.3]:45324 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403853AbfJWPdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:33:16 -0400
Received: from localhost (p54B33207.dip0.t-ipconnect.de [84.179.50.7])
        by pokefinder.org (Postfix) with ESMTPSA id 367582C001C;
        Wed, 23 Oct 2019 17:33:14 +0200 (CEST)
Date:   Wed, 23 Oct 2019 17:33:13 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
Message-ID: <20191023153313.GB5153@kunai>
References: <20191018131338.11713-1-hslester96@gmail.com>
 <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 04:32:49PM +0200, Ulf Hansson wrote:
> On Fri, 18 Oct 2019 at 15:13, Chuhong Yuan <hslester96@gmail.com> wrote:
> >
> > renesas_sdhi_probe misses checks for pinctrl_lookup_state and may miss
> > failures.
> > Add checks for them to fix the problem.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/mmc/host/renesas_sdhi_core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/re=
nesas_sdhi_core.c
> > index d4ada5cca2d1..dc5ad6632df3 100644
> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > @@ -694,8 +694,13 @@ int renesas_sdhi_probe(struct platform_device *pde=
v,
> >         if (!IS_ERR(priv->pinctrl)) {
> >                 priv->pins_default =3D pinctrl_lookup_state(priv->pinct=
rl,
> >                                                 PINCTRL_STATE_DEFAULT);
> > +               if (IS_ERR(priv->pins_default))
> > +                       return PTR_ERR(priv->pins_default);
> > +
> >                 priv->pins_uhs =3D pinctrl_lookup_state(priv->pinctrl,
> >                                                 "state_uhs");
> > +               if (IS_ERR(priv->pins_uhs))
> > +                       return PTR_ERR(priv->pins_uhs);
> >         }
>=20
> This looks correct to me, as I guess if there is a pinctrl specified
> for device node of the controller, it means that it should be used!?
>=20
> I understand that this is only used for those variants that supports
> UHS-I via the renesas_sdhi_start_signal_voltage_switch(). Wolfram, is
> this fine you think?

Well, I don't like to bail out because this error is not fatal for basic
operations. How about releasing priv->pinctrl again with an additional
warning that pinctrl settings are broken and will prevent 1.8v modes?

Opinions?


--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2wcrkACgkQFA3kzBSg
KbYLrA//c8zF4HqJkaFNFIInZh0QWFD/4DVtK/SARs7eE/Ccf0DEE3hKk8WxvZAQ
r21YVOhBw/dPlgog4xF0zBZZ2B4KIptDyJRZPVj/ZVoFBFrA1w+hu4HlUtiJMr79
apZNpwlhSkxTYfO6PEo4wuFuGmoLRA6qj+PJDeFb9uAWdxMUTU26KVwa6jZBAbE6
Hzfzvs4OXZGoawXSxfzY9IkwtHKR8CWaB8FpcdUSN88wwWVMopejAVMr2zUrOeec
6E6/mjT29Qut+rBl0SUcZZyy/9ZKsAsrslFOU8YLAMknHAonz0NYO+6XKu26qRhH
wHgv6/6htzpeFJh8f8wbQ4aRdeRuCJFFvcAd1bqeTrWJ5sFq1MYFMRJs38bFgs1J
AbWD5BBSC2nIGhHGXt9dHv7hxl4SDE+JCZu+VNjbdJOYqbGlNBMGyMXfZ2ZjPNS1
Z8cwz4l6KModx+s4sqM0BkSbn/uLzlCtmVHN7s/lLs0FMXOG4NQkKZwgowu6cKJX
/PzXcT4N3Roswar2c5sncYHMPvTYNkknmp2T9qXQ3XELHZsb9f5xgONyzxNjwap1
K2H1ZCuoTrJMpi7NNQwmG5NovFEcAOQ7qlRlCE2ITBniH4XFeduveigSntXnioEE
K5RKUqi+9gOjU9+BbXxLSzo8OCrF+6o+psCNCUWdVQHbnTgtKsw=
=S45A
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
