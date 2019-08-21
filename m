Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD6C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E8D214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfHUO0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:26:10 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60788 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfHUO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:26:10 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i0RYv-0004aN-BG; Wed, 21 Aug 2019 10:26:09 -0400
Message-ID: <7d3d50666ced8fb27d0964fa51e78fcbd0aec82e.camel@surriel.com>
Subject: Re: Pointer magic in mm_init_cpumask()
From:   Rik van Riel <riel@surriel.com>
To:     Siarhei Liakh <sliakh.lkml@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 21 Aug 2019 10:26:08 -0400
In-Reply-To: <CALBuU529+=+Xmsccc3AU2R0tSOCJtMQx=yMGDHopc3=tO3uM3Q@mail.gmail.com>
References: <CALBuU529+=+Xmsccc3AU2R0tSOCJtMQx=yMGDHopc3=tO3uM3Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-k3HbeHCDITjKCpsf2FRY"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k3HbeHCDITjKCpsf2FRY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-21 at 09:13 -0400, Siarhei Liakh wrote:

> If mm_cpumask() is not safe, then at the very least the following has
> to be fixed:
> $ grep -rIn 'cpumask_clear(mm_cpumask(' *
> arch/powerpc/include/asm/tlb.h:69:    cpumask_clear(mm_cpumask(mm));
> arch/sparc/mm/init_64.c:857:        cpumask_clear(mm_cpumask(mm));
> arch/ia64/include/asm/mmu_context.h:92:        cpumask_clear(mm_cpuma
> sk(mm));
> arch/csky/mm/asid.c:126:    cpumask_clear(mm_cpumask(mm));
> arch/arm/mm/context.c:233:    cpumask_clear(mm_cpumask(mm));
>=20
> Otherwise, mm_init_cpumask() can be simplified down to
> cpumask_clear(mm_cpumask(mm)).
> What do you think?

That looks like a nice cleanup.

I do not see why it would not work, but I suppose
that should be tested :)

--=20
All Rights Reversed.

--=-k3HbeHCDITjKCpsf2FRY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1dVIEACgkQznnekoTE
3oNGSQf/Xbkuz6NK2iPNQsSsPRCz2ie4Qkxq6sQYeD+pD4f6YHog0GOGWTFFrAIT
FShUqfjcu5OgYAAuhifsZn9k9WjYeME+HSQON8we3IjyeAP05r5yE25TrvQgVc6l
5CrEle71a7go8l+f5ZcCB/gUJHZdRjaD+aJ3RIEPPwZ/O2YYofcGpHb4kHeFOABX
sxI8y9waEIQJlUBzOdIHuUajxyCh6W2zr0s7aM590iqGsFBbvvrKxQMK5F8HUbhP
ahi8PNbsO9bz3vLvVpKN9jzkJd5CviMCLO1oFN8cYvOjLfdKDo8BAQ2ddMJhQXej
4+pdaB4mVtUuTReDC/hMDQaiBcqbxg==
=sAMJ
-----END PGP SIGNATURE-----

--=-k3HbeHCDITjKCpsf2FRY--

