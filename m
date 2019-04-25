Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9062FC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84224206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GQxUwZUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbfDYU3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:29:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55923 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfDYU3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:29:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44qpgH6KzXz9s4V;
        Fri, 26 Apr 2019 06:28:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556224141;
        bh=4bNy0f6misiz4cLcKFQXuTQD3iB/3n2Ywk7jg9FGOiA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GQxUwZUERY46Zimg54ADdswLFsKcmImcIDoN1jAsMGeXrmCITNCcATDpY3DDQf1/E
         jfif/UqvhTJ5qVGIMqLLCBRawWGYyJyU+VQYf1R4j3cZWMu5o9lKMY5JqeSXWi+/Mh
         dHSqawMxOKOdZ4a+zMi8ROQYAgi7KSwXRvQwdInJxZjZtCH0rEDI9DIZiGAoo6EBLS
         kq8TyqSjHwP9s8F3QCizTA6bhQ8eC4njieXkKTqdYO4WtVQcYZ4lBFJo9lQICtViLU
         QNS2qrVnG17EBwaX/kCmXrFoV2jSBMh2Qm/lJP91qM91wt3cUx9RNz9fkGUUkew4nT
         tv/jQxcrxbNtQ==
Date:   Fri, 26 Apr 2019 06:28:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/siphash.c: mark expected switch fall-throughs
Message-ID: <20190426062844.09ae86e2@canb.auug.org.au>
In-Reply-To: <20190425174615.GA8544@kroah.com>
References: <20190416172720.68e8b95f@canb.auug.org.au>
        <CAHmME9rycs66KYXhxa5t5=7B9JkrotU1MMxXDFXrxqCM27ysBw@mail.gmail.com>
        <20190425174615.GA8544@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IDTGdANnc4MeaFNpiFNH384"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IDTGdANnc4MeaFNpiFNH384
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, 25 Apr 2019 19:46:15 +0200 Greg Kroah-Hartman <gregkh@linuxfoundati=
on.org> wrote:
>
> On Tue, Apr 16, 2019 at 06:03:58PM +0900, Jason A. Donenfeld wrote:
> > On Tue, Apr 16, 2019 at 4:27 PM Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote: =20
> > >
> > > In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > > where we are expecting to fall through.
> > >
> > > This patch aims to suppress up to 18 missing-break-in-switch false
> > > positives on some architectures.
> > >
> > > Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> > > Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au> =20
> >=20
> > Looks good to me, thanks for this.
> >=20
> > Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >=20
> > Perhaps Greg can take it through his tree? =20
>=20
> Me?  Ok, fine, I'll go queue it up...

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/IDTGdANnc4MeaFNpiFNH384
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzCGIUACgkQAVBC80lX
0GyVYQf+LbhEgUyPCuIJHOCBOgjxLGoXzFwnlm16SYIOUF//y0lG8QsrMM+oTWQ/
FexpW2boAespLju2oKaJBITBslFmFeXBj82S/CmAiKjAKqA87OYTxbLPcZwz4h4y
cuaHgVrIKPk2SKxs83kyK3XbzYiyfdyHn2AP0J9fQr3az8YDBXsZaUz1Ld9tUFRN
+NiaQLjVlUg+h7xgcfZKHmGEKHg1lqeGbmme1XZe+VqSsOssxqmwKAYpkXbaB3z7
XlZueGWMmGqWoyd+K1Hc4chI/oaUIvjjmMwd/Vn+1xkUe312NwCboMx0SgP7yums
flhGpzbO2C8ak5oJDPpHIWFTNFzHwQ==
=I28O
-----END PGP SIGNATURE-----

--Sig_/IDTGdANnc4MeaFNpiFNH384--
