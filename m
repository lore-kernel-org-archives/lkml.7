Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCABBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C9F206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfG3Lhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:37:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60277 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbfG3Lhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:37:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 39FA3802B5; Tue, 30 Jul 2019 13:37:40 +0200 (CEST)
Date:   Tue, 30 Jul 2019 13:37:51 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.2 048/215] drm/omap: dont check dispc timings for DSI
Message-ID: <20190730113751.GB21815@amd>
References: <20190729190739.971253303@linuxfoundation.org>
 <20190729190748.832081009@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <20190729190748.832081009@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-07-29 21:20:44, Greg Kroah-Hartman wrote:
> [ Upstream commit ad9df7d91b4a6e8f4b20c2bf539ac09b3b2ad6eb ]
>=20
> While most display types only forward their VM to the DISPC, this
> is not true for DSI. DSI calculates the VM for DISPC based on its
> own, but it's not identical. Actually the DSI VM is not even a valid
> DISPC VM making this check fail. Let's restore the old behaviour
> and avoid checking the DISPC VM for DSI here.
>=20
> Fixes: 7c27fa57ef31 ("drm/omap: Call dispc timings check operation direct=
ly")
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Not sure if this is good idea for stable. IIRC there's series of
patches to enable display on droid4 (etc), which is useful, but this
patch is not going to do any good on its own.

								Pavel

>  drivers/gpu/drm/omapdrm/omap_crtc.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdr=
m/omap_crtc.c
> index 8712af79a49c..4c43dd282acc 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -384,10 +384,20 @@ static enum drm_mode_status omap_crtc_mode_valid(st=
ruct drm_crtc *crtc,
>  	int r;
> =20
>  	drm_display_mode_to_videomode(mode, &vm);
> -	r =3D priv->dispc_ops->mgr_check_timings(priv->dispc, omap_crtc->channe=
l,
> -					       &vm);
> -	if (r)
> -		return r;
> +
> +	/*
> +	 * DSI might not call this, since the supplied mode is not a
> +	 * valid DISPC mode. DSI will calculate and configure the
> +	 * proper DISPC mode later.
> +	 */
> +	if (omap_crtc->pipe->output->next =3D=3D NULL ||
> +	    omap_crtc->pipe->output->next->type !=3D OMAP_DISPLAY_TYPE_DSI) {
> +		r =3D priv->dispc_ops->mgr_check_timings(priv->dispc,
> +						       omap_crtc->channel,
> +						       &vm);
> +		if (r)
> +			return r;
> +	}
> =20
>  	/* Check for bandwidth limit */
>  	if (priv->max_bandwidth) {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1ALA8ACgkQMOfwapXb+vLivwCfSxC4OWQN/14fhb5nIvRRnOS+
JMwAnix68z/VpEm39HRi2R0vnq3K7lOU
=mnTv
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
