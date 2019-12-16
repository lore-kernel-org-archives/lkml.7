Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC63C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0AE206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfLPPse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32900 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbfLPPsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 6F214260667
Date:   Mon, 16 Dec 2019 10:48:03 -0500
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     yuq825@gmail.com, dri-devel@lists.freedesktop.org,
        lima@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, tomeu.vizoso@collabora.com,
        robh@kernel.org, steven.price@arm.com,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, wens@csie.org
Subject: Re: [RFC v1 0/1] drm: lima: devfreq and cooling device support
Message-ID: <20191216154803.GA3921@kevin>
References: <20191215211223.1451499-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20191215211223.1451499-1-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If so much code is being duplicated over, I'm wondering if it makes
sense for us to move some of the common devfreq code to core DRM
helpers?

On Sun, Dec 15, 2019 at 10:12:22PM +0100, Martin Blumenstingl wrote:
> This is my attempt at adding devfreq (and cooling device) support to
> the lima driver.
> I didn't have much time to do in-depth testing. However, I'm sending
> this out early because there are many SoCs with Mali-400/450 GPU so
> I want to avoid duplicating the work with somebody else.
>=20
> The code is derived from panfrost_devfreq.c which is why I kept the
> Collabora copyright in lima_devfreq.c. Please let me know if I should
> drop this or how I can make it more clear that I "borrowed" the code
> from panfrost.
>=20
> I am seeking comments in two general areas:
> - regarding the integration into the existing lima code
> - for the actual devfreq code (I had to adapt the panfrost code
>   slightly, because lima uses a bus and a GPU/core clock)
>=20
> My own TODO list includes "more" testing on various Amlogic SoCs.
> So far I have tested this on Meson8b and Meson8m2 (which both have a
> GPU OPP table defined). However, I still need to test this on a GXL
> board (which is currently missing the GPU OPP table).
>=20
>=20
> Martin Blumenstingl (1):
>   drm/lima: Add optional devfreq support
>=20
>  drivers/gpu/drm/lima/Kconfig        |   1 +
>  drivers/gpu/drm/lima/Makefile       |   3 +-
>  drivers/gpu/drm/lima/lima_devfreq.c | 162 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/lima/lima_devfreq.h |  15 +++
>  drivers/gpu/drm/lima/lima_device.c  |   4 +
>  drivers/gpu/drm/lima/lima_device.h  |  11 ++
>  drivers/gpu/drm/lima/lima_drv.c     |  14 ++-
>  drivers/gpu/drm/lima/lima_sched.c   |   7 ++
>  drivers/gpu/drm/lima/lima_sched.h   |   3 +
>  9 files changed, 217 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/lima/lima_devfreq.c
>  create mode 100644 drivers/gpu/drm/lima/lima_devfreq.h
>=20
> --=20
> 2.24.1
>=20

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl33py4ACgkQ/v5QWgr1
WA0Caw/8DBkpxsfWejzUF5wK7xq5rkmaLL+RmwJzt9xgNwWgsJ8p2XWt+hgzJSAr
hNy9KVAEE62SXJHfpziY9CEkQycM+b7cQASYGf2q8/C2XNYfZHv80N8SZv1Gaqmh
NzCfRSsfgc1BvPjbiKu0E1gdsX4RxlB3TXQV0dmSYbOSQ6yyHaYHgrEImW8HVblc
/xkW7pOSkBs9ZdQKMFETaKJlQ6iQvkvUUlaywl2rBO4PvidyCVp5TXgRIYUQzXY/
ls7vy/jU8eWchvp9hlztfssMGtE20BcQeASrHjkKfRUWsaSKt0g9Wh17jbIMf/fj
BfGKqV+KwkKuMDUubvp7EBaJkwxAG8pTr1jv7+QdxOdm/KVnKMu1NSl2DJmTl8Fa
o9mIdlNQCoMJo+TG6i92JuHMZ5VL11NBm6uazi1iJIH8KEYg8UPnePbQttHnDnZq
DqTpy9w0r+T3zu9AH5pQjZCXCcKK+oV4qCTBK5zGe3UtcPigssiTVo912VsGEbb/
Y8LPtySaWSjCI/hfgz4M9ENfrmNX4yqvIewZnAMMPj6vv5sslfRBBGKBCoCtqcQx
T9Iy3c57pp9B/Prrc1llotEuqyd2Mi7mws7gSPfGZXaTC/TPNKCikvph39wdRPdp
WP+lq3rH1n5kMcc3D09p62TZGuaO0uiHmUgxshzPQa3FxXsHqZo=
=QSX1
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
