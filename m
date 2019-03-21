Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B6CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC111218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfCUXMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:12:38 -0400
Received: from anholt.net ([50.246.234.109]:44206 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfCUXMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:12:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 58CE810A2EF3;
        Thu, 21 Mar 2019 16:12:37 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Zrj8IXPU5QOk; Thu, 21 Mar 2019 16:12:35 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E4B5210A2D7D;
        Thu, 21 Mar 2019 16:12:35 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 849D42FE4653; Thu, 21 Mar 2019 16:12:35 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/file: Rehabilitate the firstopen hook for non-legacy drivers
In-Reply-To: <82618ee8c2a2380a62b1fb894e5c35c602e20f3d.camel@bootlin.com>
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com> <20190320154809.14823-2-paul.kocialkowski@bootlin.com> <87zhpph4c2.fsf@anholt.net> <82618ee8c2a2380a62b1fb894e5c35c602e20f3d.camel@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Mar 2019 16:12:35 -0700
Message-ID: <87sgvfsty4.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> Hi,
>
> Le mercredi 20 mars 2019 =C3=A0 09:56 -0700, Eric Anholt a =C3=A9crit :
>> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
>>=20
>> > The firstopen DRM driver hook was initially used to perform hardware
>> > initialization, which is now considered legacy. Only a single user of
>> > firstopen remains at this point (savage).
>> >=20
>> > In some specific cases, non-legacy drivers may also need to implement
>> > these hooks. For instance on VC4, we need to allocate a 16 MiB buffer
>> > for the GPU. Because it's not required for fbcon, it's a waste to
>> > allocate it before userspace starts using the DRM device.
>> >=20
>> > Using firstopen and lastclose for this allocation seems like the best
>> > fit, so re-habilitate the hook to allow it to be called for non-legacy
>> > drivers.
>> >=20
>> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> > ---
>> >  drivers/gpu/drm/drm_file.c | 3 +--
>> >  include/drm/drm_drv.h      | 2 +-
>> >  2 files changed, 2 insertions(+), 3 deletions(-)
>> >=20
>> > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>> > index b1838a41ad43..c011b5cbfb6b 100644
>> > --- a/drivers/gpu/drm/drm_file.c
>> > +++ b/drivers/gpu/drm/drm_file.c
>> > @@ -266,8 +266,7 @@ static int drm_setup(struct drm_device * dev)
>> >  {
>> >  	int ret;
>> >=20=20
>> > -	if (dev->driver->firstopen &&
>> > -	    drm_core_check_feature(dev, DRIVER_LEGACY)) {
>> > +	if (dev->driver->firstopen) {
>> >  		ret =3D dev->driver->firstopen(dev);
>> >  		if (ret !=3D 0)
>> >  			return ret;
>> > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
>> > index ca46a45a9cce..aa14607e54d4 100644
>> > --- a/include/drm/drm_drv.h
>> > +++ b/include/drm/drm_drv.h
>> > @@ -236,7 +236,7 @@ struct drm_driver {
>> >  	 * to set/unset the VT into raw mode.
>> >  	 *
>> >  	 * Legacy drivers initialize the hardware in the @firstopen callback,
>> > -	 * which isn't even called for modern drivers.
>> > +	 * modern drivers can use it for other purposes only.
>> >  	 */
>> >  	void (*lastclose) (struct drm_device *);
>>=20
>> Our usage in vc4 is not very different from what we called "hardware
>> initialization" in other devices.  I would rather just delete this
>> sentence entirely.
>
> Sounds good to me!

With the delete, the series is:

Reviewed-by: Eric Anholt <eric@anholt.net>

but hopefully someone other than a vc4 developer (danvet?) can make the
call on whether undeprecating firstopen/lastclose for this is
reasonable.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyUGmMACgkQtdYpNtH8
nugJug/9HVg/4wD2hjoWSTZlnGDMTJuC8f3Gsrf7lJlHG4NL/Vqnj4XkEw0rI3AM
LvQOQb5ZcZpyxuWoOECPOsxvMoARctwRaUlKYH3oeR3u7hKjbXdQ1XKO65bDS2VU
ovOyQmpemMk0NF4G1eTXZGL0YNZzM/GPBBADuQhtxBHHnst0jbBo6/l2RhTsbv1j
vBhdgLzTVNfmoAZ3WW44BIBs2pY5nQNaPlKOGfS+IaK8U5SQLElyHvoNvB148Hth
XSasMDfYSJbkDCrgUf0xaOz/jl/EISiZ8rdtbRn3nGM3xZrr08M4oyqealXdYXgQ
brdNATCrlzG0RFAu74wUqDk+Iq212kbByzQMOfoh2j7qyJ0rjbbFzTB1/wc1O3tj
E6Hd34g5M6hyvMm7PEq480eBJSSB+t6eBeZeJ6aIWa6wfaYHmbE503HLIL2E9Hug
Jbu3pmc7dYTOzWVV1Qa5DULmdx1dOcXSpZ+h+IwDvy2Z1sUGnpYd98r5GtiKdDAn
X8Uko9TWAAOa74X0llwZCcRw0FhyDt+3vLp4QfX4SjGgUK9JHg11R1lmNgafgZsm
6gi6e1cURGX0oZqY6htUMamE9oVnwHpf8Tm7Lu9+IM2aJlx08ypK0Z393SesWDQ+
O6RSXH/V+2C5ILPbU2u9VsCeVvmfF/Z2bxqYyaE9BOggaE2IiNE=
=UG4z
-----END PGP SIGNATURE-----
--=-=-=--
