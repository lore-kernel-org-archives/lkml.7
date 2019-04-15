Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501F2C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187C6205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfDOUsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:48:20 -0400
Received: from anholt.net ([50.246.234.109]:44846 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfDOUsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:48:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id F2E6910A3364;
        Mon, 15 Apr 2019 13:48:19 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id vIg3rMpIs9MB; Mon, 15 Apr 2019 13:48:18 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 771F710A28B9;
        Mon, 15 Apr 2019 13:48:18 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 00F6E2FE36FA; Mon, 15 Apr 2019 13:48:17 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v5 3/4] drm/vc4: Check for the binner bo before handling OOM interrupt
In-Reply-To: <20190415123908.28986-4-paul.kocialkowski@bootlin.com>
References: <20190415123908.28986-1-paul.kocialkowski@bootlin.com> <20190415123908.28986-4-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Mon, 15 Apr 2019 13:48:17 -0700
Message-ID: <87v9zf806m.fsf@anholt.net>
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

> Since the OOM interrupt directly deals with the binner bo, it doesn't
> make sense to try and handle it without a binner buffer registered.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/vc4/vc4_irq.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
> index ffd0a4388752..723dc86b4511 100644
> --- a/drivers/gpu/drm/vc4/vc4_irq.c
> +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> @@ -64,6 +64,9 @@ vc4_overflow_mem_work(struct work_struct *work)
>  	struct vc4_exec_info *exec;
>  	unsigned long irqflags;
>=20=20
> +	if (!bo)
> +		return;
> +
>  	bin_bo_slot =3D vc4_v3d_get_bin_slot(vc4);
>  	if (bin_bo_slot < 0) {
>  		DRM_ERROR("Couldn't allocate binner overflow mem\n");
> --=20
> 2.21.0

I don't think this is going to be race-free.  You're checking outside of
a lock, then proceeding to use it even if (in patch 4) the bin BO was in
the process of being freed during the file close path.  Can we put all
of the overflow process here under the same lock as freeing?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAly07hEACgkQtdYpNtH8
nug2+g/4614GuqjaPx2Vu1J/r59QRYQ2lPkiZ3ACaiaE1JFaj791OQzOuqrIwL99
mjckKZzFkBdzhvaaWzlwlbKVzAzHvSK8XQDEIzzXJ9H5JCNoVonB2B9DEWo8Qdxu
q0KutEA1hvJYsg/EGHoeklTRrQ80nsGcP6yYdJXp5zcZ/vPnRBTtawqHRRqRIjVs
7b0WTzNiu4F+U3NB4qN4hRFrlYfCjMJjmny7jkUFqFCjpedsnHa2TIyFrns19Wdu
7ylPzjb9k0b7cFyJzJqYUDPiVtOjzFVUhAAnYiu57s7kXUYDaaCMGcLLhmv2z6gK
XFQGWy3NJE01JvtqtXrAZXdyZpxDSLuYEr+RUsJJEm8Yslqz//4mIxcZqTiNxFPI
j8ScXOOPgavNVWXJKwihTUz3XCvHTTzuSS09eVvAEGfYwtSKHnezz6YkYL724/WM
G5j9ZtnnyWrwccSR8m0h0Uduh21h9YI9T5GYVSoGxc/ALE9FjZ/pJ95Dx2yN/+/A
ILxPVTBTCw2f8DCLbAVNZucmcDnS/cbF8n6TAiCcVtAlQesekf8uL6shXKLbzbBf
S40Kl/ObnrdEV/3cftP2NeDDADXuADQsC7D0ScPTGyAnQFVwecD6aiHs+tMipUc8
w28zMXVH99f/ZxzD8fRJR0UQHLARJf38CWnZCgAR2Gjp67IFHw==
=3Rpc
-----END PGP SIGNATURE-----
--=-=-=--
