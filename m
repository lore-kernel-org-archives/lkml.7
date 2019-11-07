Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27B6FC6195
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EC02178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389239AbfKGORr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:17:47 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:45399 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfKGORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:17:47 -0500
X-Originating-IP: 86.206.246.123
Received: from aptenodytes (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A33A624001B;
        Thu,  7 Nov 2019 14:17:44 +0000 (UTC)
Date:   Thu, 7 Nov 2019 15:17:44 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        James Hilliard <james.hilliard1@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] drm/gma500: Add missing call to allow enabling
 vblank on psb/cdv
Message-ID: <20191107141744.GB670369@aptenodytes>
References: <20191106094400.445834-1-paul.kocialkowski@bootlin.com>
 <20191106094400.445834-2-paul.kocialkowski@bootlin.com>
 <CAMeQTsa+tYWAA5vkChqDvEiFmbjFzNp804fD6J4GfLgHUBho9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <CAMeQTsa+tYWAA5vkChqDvEiFmbjFzNp804fD6J4GfLgHUBho9g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed 06 Nov 19, 16:23, Patrik Jakobsson wrote:
> On Wed, Nov 6, 2019 at 10:44 AM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> >
> > This adds a missing call to drm_crtc_vblank_on to the common DPMS helper
> > (used by poulsbo and cedartrail), which is called in the CRTC enable pa=
th.
> >
> > With that call, it becomes possible to enable vblank when needed.
> > It is already balanced by a drm_crtc_vblank_off call in the helper.
> >
> > Other platforms (oaktrail and medfield) use a dedicated DPMS helper that
> > does not have the proper vblank on/off hooks. They are not added in this
> > commit due to lack of hardware to test it with.
> >
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> Don't think we ever found a need for having vblanks enabled... until
> now. I'll have a look if something can be done for Oaktrail since I
> have hw.

Neat, thanks!

IIRC the DPMS paths that don't use gma_crtc_dpms also lack the proper
drm_crtc_vblank_on/off calls so that's probably something to start with :)

Thanks for the review on these patches. I may have more fixes coming up.

Cheers,

Paul

> Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
>=20
> > ---
> >  drivers/gpu/drm/gma500/gma_display.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma=
500/gma_display.c
> > index e20ccb5d10fd..bc07ae2a9a1d 100644
> > --- a/drivers/gpu/drm/gma500/gma_display.c
> > +++ b/drivers/gpu/drm/gma500/gma_display.c
> > @@ -255,6 +255,8 @@ void gma_crtc_dpms(struct drm_crtc *crtc, int mode)
> >                 /* Give the overlay scaler a chance to enable
> >                  * if it's on this pipe */
> >                 /* psb_intel_crtc_dpms_video(crtc, true); TODO */
> > +
> > +               drm_crtc_vblank_on(crtc);
> >                 break;
> >         case DRM_MODE_DPMS_OFF:
> >                 if (!gma_crtc->active)
> > --
> > 2.23.0
> >

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl3EJ4gACgkQ3cLmz3+f
v9GwJQf/QwXxGs4rMmGo6OEb5ANamqku11L7Y9q7skGBuOlJkiiOmnYbJnCZdlv3
n4MCuPA58PX+w7tWIiOFS5MW1mb5YPE2Lg6Sjf5uTozOP+L+DGd8XLXNeXxJEzqU
RctwrXzJDYqvq373QrGhoiU1VpExNj7VmODMAdDV3q8VVwxrTn0iPBIKiK5fbWcj
E6VYKx7QQi2dpwgQSRrWikfERDWKJ2kUYmYv08cx2fYO0imp20N0H8mbXENx0zVY
FjPJYkRi2A7VZ7GbYkxtCMbYvLs1nasK8lIFl8r87b+Q6AOOfraWEqj95yzbcjOp
DCLAxU8JQmCTY3D1jNRh48GnwWU28g==
=Oy6L
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
