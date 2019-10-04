Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44CFC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE1D20862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbfJDTH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 15:07:27 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:29192 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbfJDTH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:07:27 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 75A69A015E;
        Fri,  4 Oct 2019 21:07:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 1BbF1m7VL8Dh; Fri,  4 Oct 2019 21:07:21 +0200 (CEST)
Date:   Sat, 5 Oct 2019 05:07:13 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] usercopy structs for v5.4-rc2
Message-ID: <20191004190713.hdfv5h3dppwmz6bs@yavin.dot.cyphar.com>
References: <20191004104116.20418-1-christian.brauner@ubuntu.com>
 <CAHk-=whxf5HVdaXqL6RgHCLzb2LNn3U2n_x4GWQZroCC+evRoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ybqdhfvvxmbcd65c"
Content-Disposition: inline
In-Reply-To: <CAHk-=whxf5HVdaXqL6RgHCLzb2LNn3U2n_x4GWQZroCC+evRoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ybqdhfvvxmbcd65c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-04, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, Oct 4, 2019 at 3:42 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> >            The only separate fix we we had to apply
> > was for a warning by clang when building the tests for using the result=
 of
> > an assignment as a condition without parantheses.
>=20
> Hmm. That code is ugly, both before and after the fix.
>=20
> This just doesn't make sense for so many reasons:
>=20
>         if ((ret |=3D test(umem_src =3D=3D NULL, "kmalloc failed")))
>=20
> where the insanity comes from
>=20
>  - why "|=3D" when you know that "ret" was zero before (and it had to
> be, for the test to make sense)
>=20
>  - why do this as a single line anyway?
>=20
>  - don't do the stupid "double parenthesis" to hide a warning. Make it
> use an actual comparison if you add a layer of parentheses.

You're quite right -- I was mindlessly copying the "ret |=3D" logic the
rest of test_user_copy.c does without thinking about it. I'll include a
cleanup for it in the openat2(2) series.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ybqdhfvvxmbcd65c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZeYXQAKCRCdlLljIbnQ
EgXGAPwLt+yoG/AS/EPKRhamvIpGZEPcAdAFQfAtdZ1RgIK4IwEAsk6taEl1FsU8
WixwP71Fw/Vosc97yiFLGAUdqXLmtQo=
=o6hD
-----END PGP SIGNATURE-----

--ybqdhfvvxmbcd65c--
