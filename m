Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326A5C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FD1206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfK0QFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:05:08 -0500
Received: from shelob.surriel.com ([96.67.55.147]:47274 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0QFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:05:07 -0500
X-Greylist: delayed 1090 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Nov 2019 11:05:07 EST
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1iZzWm-0000RJ-Dp; Wed, 27 Nov 2019 10:46:52 -0500
Message-ID: <8aadfbebed6502f21ba91a823e118770b84e31d2.camel@surriel.com>
Subject: Re: [PATCH] x86/fpu: Don't cache access to fpu_fpregs_owner_ctx
From:   Rik van Riel <riel@surriel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Barret Rhoden <brho@google.com>,
        Josh Bleecher Snyder <josharian@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Date:   Wed, 27 Nov 2019 10:46:51 -0500
In-Reply-To: <20191127124243.u74osvlkhcmsskng@linutronix.de>
References: <c87e93c3-5f30-f242-74b7-6c7ccc91158a@google.com>
         <20191126202026.csrmjre6vn2nxq7c@linutronix.de>
         <e4d6406b-0d47-5cc5-f3a8-6d14bd90760b@google.com>
         <20191127124243.u74osvlkhcmsskng@linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6EoG3tuvdYQ7otJGjpXm"
User-Agent: Evolution 3.34.0 (3.34.0-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6EoG3tuvdYQ7otJGjpXm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-27 at 13:42 +0100, Sebastian Andrzej Siewior wrote:

> There is no Sign-off by here. Could this please be verified by the
> reporter?

Next time this is posted, feel free to add this :)

Reviewed-by: Rik van Riel <riel@surriel.com>

> diff --git a/arch/x86/include/asm/fpu/internal.h
> b/arch/x86/include/asm/fpu/internal.h
> index 4c95c365058aa..44c48e34d7994 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -509,7 +509,7 @@ static inline void
> __fpu_invalidate_fpregs_state(struct fpu *fpu)
> =20
>  static inline int fpregs_state_valid(struct fpu *fpu, unsigned int
> cpu)
>  {
> -	return fpu =3D=3D this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu
> =3D=3D fpu->last_cpu;
> +	return fpu =3D=3D this_cpu_read(fpu_fpregs_owner_ctx) && cpu =3D=3D
> fpu->last_cpu;
>  }
> =20
>  /*
--=20
All Rights Reversed.

--=-6EoG3tuvdYQ7otJGjpXm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl3emmsACgkQznnekoTE
3oPklAf6Aybc6hqvWSIYKd0KqrHtRhyW0ibGiSXziJSYChlUaFy+3zFLwjES0ONN
H8t7f0OSEINpN7OQt1LeWwCp9UHDIKqG3rv3jKdq+j/xrp7/D+4U5+cXtFlW+KIR
lauargI7DEM+eyq5ASbiE5+2565cXD8gMKK+AMNJzPiCO3vi7SPkjm2P4MqQwC9G
VUU+enJcP0WfDDaKCs5Bh2OseBAich72rXNKdiYEwMS70dUl0ofHzrj/LN+kh4OX
fWksJcOv4BZP5BksB6yw3JBtTp9y5EAfnjYAAhWAiMijKTPRJ9UVOw+o+Km2bS8O
e+Ildvuz9phtOdegUEtV8djdCzMelg==
=xB4N
-----END PGP SIGNATURE-----

--=-6EoG3tuvdYQ7otJGjpXm--

