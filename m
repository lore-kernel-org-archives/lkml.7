Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C53C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6D92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfCTQ4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:56:51 -0400
Received: from anholt.net ([50.246.234.109]:34632 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfCTQ4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:56:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 94D5B10A2EE3;
        Wed, 20 Mar 2019 09:56:50 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id j5GBNwkULtEM; Wed, 20 Mar 2019 09:56:49 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 19DA510A2E9D;
        Wed, 20 Mar 2019 09:56:49 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id A3C0F2FE4653; Wed, 20 Mar 2019 09:56:48 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/file: Rehabilitate the firstopen hook for non-legacy drivers
In-Reply-To: <20190320154809.14823-2-paul.kocialkowski@bootlin.com>
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com> <20190320154809.14823-2-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 20 Mar 2019 09:56:45 -0700
Message-ID: <87zhpph4c2.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> The firstopen DRM driver hook was initially used to perform hardware
> initialization, which is now considered legacy. Only a single user of
> firstopen remains at this point (savage).
>
> In some specific cases, non-legacy drivers may also need to implement
> these hooks. For instance on VC4, we need to allocate a 16 MiB buffer
> for the GPU. Because it's not required for fbcon, it's a waste to
> allocate it before userspace starts using the DRM device.
>
> Using firstopen and lastclose for this allocation seems like the best
> fit, so re-habilitate the hook to allow it to be called for non-legacy
> drivers.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/drm_file.c | 3 +--
>  include/drm/drm_drv.h      | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index b1838a41ad43..c011b5cbfb6b 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -266,8 +266,7 @@ static int drm_setup(struct drm_device * dev)
>  {
>  	int ret;
>=20=20
> -	if (dev->driver->firstopen &&
> -	    drm_core_check_feature(dev, DRIVER_LEGACY)) {
> +	if (dev->driver->firstopen) {
>  		ret =3D dev->driver->firstopen(dev);
>  		if (ret !=3D 0)
>  			return ret;
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index ca46a45a9cce..aa14607e54d4 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -236,7 +236,7 @@ struct drm_driver {
>  	 * to set/unset the VT into raw mode.
>  	 *
>  	 * Legacy drivers initialize the hardware in the @firstopen callback,
> -	 * which isn't even called for modern drivers.
> +	 * modern drivers can use it for other purposes only.
>  	 */
>  	void (*lastclose) (struct drm_device *);

Our usage in vc4 is not very different from what we called "hardware
initialization" in other devices.  I would rather just delete this
sentence entirely.

The only alternative I can think of to using a firstopen/lastclose-style
allocation for this would be to allocate the bin bo on the first
(non-dumb?) V3D BO allocation and refcount those to free the binner.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyScM0ACgkQtdYpNtH8
nugXdBAAqeJen5dW0cJEUJfdGcNykhWS8fCDegYx5D1IHRSC20FtJuEoEJouqhN5
c93b6+WzetYIi3KNhB7Hz2xWiI0UtDREd7yT+M+5HAeFo7FW3JYquPJVeD7NS8hu
IpoJpGD2RDjyLbpp8H8nbWD2qIgZKvYtK155fp3CORM+t7RfPRFFV8bavCDWdhpH
CG2IGbyhK0CD6dUM4inlEXCVHxWsVr9Zdy4prmzMohY2wSky0fE3LcE3Ls7jDply
fz9G/oK8jQ49lXLG1owZnH9zBeVlgJrV6ZMEv5mxICYKT7ko5Wi57mvWqUR+3iBW
arZMtWG03FT0qkcW3/LuDtGDojFVjE2DnEwc9DOh64WcE0+2v7HMyKRsqbFVahUL
RKJ/rCev4mnIHTBEDoFtwr4+MaQT0jIPXkPRZ3XbwBjVti4Z5jdrWCLP5upnGFCT
KK7mobXfSVh8c2u1wenfAamDqTVXSaONCw/DqDD5oJbVPuq3e7JLTY6OMmAgW0Ib
lLdO+tSRarHOA4UYvh1Zx1pQKp/mLL77DeGYB5Z4HLjwfymS0A/J8Na11ADqUmEw
IULBhO4HWYbq5CpgAvtg07L6NSFkzQv/C6bNKhNM2uxhbgtt6YGLTPF7qVhAlqhB
SRsxE22UKPDVAy6zsoZXve4ogBOSkc/Xz43urLiNRE7d+fIkRCY=
=4MEm
-----END PGP SIGNATURE-----
--=-=-=--
