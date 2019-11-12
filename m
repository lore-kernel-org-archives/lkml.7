Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D35CC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5552067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKLPMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:12:03 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:50921 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKLPMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:12:01 -0500
Received: from aptenodytes (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9236924000F;
        Tue, 12 Nov 2019 15:11:57 +0000 (UTC)
Date:   Tue, 12 Nov 2019 16:11:57 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH] drm/gma500: Fixup fbdev stolen size usage evaluation
Message-ID: <20191112151157.GD4506@aptenodytes>
References: <20191107153048.843881-1-paul.kocialkowski@bootlin.com>
 <CAMeQTsYG+YvXqQqvJvsxT1h0z5zZJbdCtc5wPjUossvwidV=cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Content-Disposition: inline
In-Reply-To: <CAMeQTsYG+YvXqQqvJvsxT1h0z5zZJbdCtc5wPjUossvwidV=cA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue 12 Nov 19, 11:20, Patrik Jakobsson wrote:
> On Thu, Nov 7, 2019 at 4:30 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> >
> > psbfb_probe performs an evaluation of the required size from the stolen
> > GTT memory, but gets it wrong in two distinct ways:
> > - The resulting size must be page-size-aligned;
> > - The size to allocate is derived from the surface dimensions, not the =
fb
> >   dimensions.
> >
> > When two connectors are connected with different modes, the smallest wi=
ll
> > be stored in the fb dimensions, but the size that needs to be allocated=
 must
> > match the largest (surface) dimensions. This is what is used in the act=
ual
> > allocation code.
> >
> > Fix this by correcting the evaluation to conform to the two points abov=
e.
> > It allows correctly switching to 16bpp when one connector is e.g. 1920x=
1080
> > and the other is 1024x768.
> >
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/gma500/framebuffer.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma=
500/framebuffer.c
> > index 218f3bb15276..90237abee088 100644
> > --- a/drivers/gpu/drm/gma500/framebuffer.c
> > +++ b/drivers/gpu/drm/gma500/framebuffer.c
> > @@ -462,6 +462,7 @@ static int psbfb_probe(struct drm_fb_helper *helper,
> >                 container_of(helper, struct psb_fbdev, psb_fb_helper);
> >         struct drm_device *dev =3D psb_fbdev->psb_fb_helper.dev;
> >         struct drm_psb_private *dev_priv =3D dev->dev_private;
> > +       unsigned int fb_size;
> >         int bytespp;
> >
> >         bytespp =3D sizes->surface_bpp / 8;
> > @@ -471,8 +472,11 @@ static int psbfb_probe(struct drm_fb_helper *helpe=
r,
> >         /* If the mode will not fit in 32bit then switch to 16bit to get
> >            a console on full resolution. The X mode setting server will
> >            allocate its own 32bit GEM framebuffer */
> > -       if (ALIGN(sizes->fb_width * bytespp, 64) * sizes->fb_height >
> > -                       dev_priv->vram_stolen_size) {
> > +       fb_size =3D ALIGN(sizes->surface_width * bytespp, 64) *
> > +                 sizes->surface_height;
> > +       fb_size =3D ALIGN(fb_size, PAGE_SIZE);
> > +
> > +       if (fb_size > dev_priv->vram_stolen_size) {
>=20
> psb_gtt_alloc_range() already aligns by PAGE_SIZE for us. Looks like
> we align a couple of times extra for luck. This needs cleaning up
> instead of adding even more aligns.

I'm not sure this is really for luck. As far as I can see, we need to do it
properly for this size estimation since it's the final size that will be
allocated (and thus needs to be available in whole).

For the other times there is explicit alignment, they seem justified too:
- in psb_gem_create: it is common to pass the aligned size when creating the
  associated GEM object with drm_gem_object_init, even though it's probably=
 not
  crucial given that this is not where allocation actually happens;
- in psbfb_create: the full size is apparently only really used to memset 0
  the allocated buffer. I think this makes sense for security reasons (and =
not
  leak previous contents in the additional space required for alignment).

What strikes me however is that each call to psb_gtt_alloc_range takes the
alignment as a parameter when it's really always PAGE_SIZE, so it should
probably just be hardcoded in the call to allocate_resource.

What do you think?

> Your size calculation looks correct and indeed makes my 1024x600 +
> 1920x1080 setup actually display something, but for some reason I get
> an incorrect panning on the smaller screen and stale data on the
> surface only visible by the larger CRTC. Any idea what's going on?

I'm not seeing this immediately, but I definitely have something strange
after having printed more lines than the smallest display can handle or
scrolling, where more than the actual size of the fb is used.

Maybe this is related to using the PowerVR-accelerated fb ops, that aren't
quite ready for this use case?

I'll give it a try with psbfb_roll_ops and psbfb_unaccel_ops instead to see
if it changes something for me. Maybe it would help for you too?

I suspect that the generic implementation is already bullet-proof for these
kinds of use case.

Cheers and thanks for the feedback,

Paul

>=20
> >                  sizes->surface_bpp =3D 16;
> >                  sizes->surface_depth =3D 16;
> >          }
> > --
> > 2.23.0
> >

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl3Ky70ACgkQ3cLmz3+f
v9HgiAf/aWZMYNkuVerWPsTQ1XEZw6KXn8/J+7710cM66anDlSO9ma2boXYnGL2J
x4hlpYMgyYWwnXIVumWYUrdUWqbJSsEraIS7r2WpsmQ20C0iVwZD32zdii4tzDLc
d8h38MPemyeLDvSWCm6RK65LQeQXr9OCdH3xgsg0EiKC2/lpZL+LKc5GBdzdZY+b
vARRLKwbMQOvSabL7BM8ZuEjScODVNTBPxmDTwj+3bmsPxu5iOxTZ01wnl+cpvcf
Vjfljb5/LuHMR5NEFs3DuNNYBeV0YaKB9cs2La9pQmXI4wzQ6IGzeWn5dKFQVQbi
/o/As1R4UuIvtT7yylQSIPLJxZ+uyg==
=/nxs
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
