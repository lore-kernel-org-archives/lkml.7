Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81133C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F8020854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gZ9iy+qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfCSGMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:12:39 -0400
Received: from ozlabs.org ([203.11.71.1]:47093 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCSGMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:12:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NjQ749QLz9s9T;
        Tue, 19 Mar 2019 17:12:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552975956;
        bh=lhxd9eZ+3cyBXE5oIgmZabAmB76q/AgdDulmdaaI620=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gZ9iy+qk7tpQU5d/WyXgAAB1RD70eGzx6dPK+KBYXDuuk7ZDyEnR9sY1W+ufhZ8qB
         MLNKpN/Uuugdb4q3INz688b3m2l2XZ207aVpNPSrSCAcg8L21oyT34eLNwQu/GkR+p
         2GFe7WpiLWoGcsuHcAluUiYZSB79Sb8w1B72u+8kbybaQzHdkl2yN5Pt/phw2TSf2T
         nnDCjuM+0bpGW5eznA6YJ2y/2fCLKQLPd/5L5cmQ1t0Z93ZqKE/jN2QsQBS6v24xip
         2/ht4EPNNBnXXAyyQC7oIszJDPNLJ7SdI5h93ZQIP497ZD8A/deVHac8hXODiogvhi
         kEYxlfiR9v9yA==
Date:   Tue, 19 Mar 2019 17:12:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [GIT PULL] Driver core patches for 5.1-rc1
Message-ID: <20190319171230.780c0771@canb.auug.org.au>
In-Reply-To: <CAHk-=wjT+pPxi8favCu9V5ZtGZuTZybLuwnwtNLspFPmKgr42g@mail.gmail.com>
References: <20190306103350.GA10570@kroah.com>
        <CAHk-=wjT+pPxi8favCu9V5ZtGZuTZybLuwnwtNLspFPmKgr42g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/u=QOXxHPloGUhoTq+7gFMqj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u=QOXxHPloGUhoTq+7gFMqj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, 6 Mar 2019 15:47:11 -0800 Linus Torvalds <torvalds@linux-foundation=
.org> wrote:
>
> This is very funky, but that commit generates a new warning in a
> totally unrelated area:
>=20
>   drivers/iio/adc/qcom-pm8xxx-xoadc.c: In function =E2=80=98pm8xxx_xoadc_=
probe=E2=80=99:
>   drivers/iio/adc/qcom-pm8xxx-xoadc.c:633:8: warning: =E2=80=98ch=E2=80=
=99 may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>     ret =3D pm8xxx_read_channel_rsv(adc, ch, AMUX_RSV4,
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>              &read_nomux_rsv4, true);
>              ~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/iio/adc/qcom-pm8xxx-xoadc.c:426:27: note: =E2=80=98ch=E2=80=99 =
was declared here
>     struct pm8xxx_chan_info *ch;
>                              ^~
>=20
> I wonder why this wasn't seen in linux-next?

It is possible I missed it because I am currently building with
-Wimplicit-fallthrough to help Kees and co with their attempt at making
that a "normal" build flag for the kernel.  Unfortunately it generates
a few hundred warnings still.

--=20
Cheers,
Stephen Rothwell

--Sig_/u=QOXxHPloGUhoTq+7gFMqj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyQiE4ACgkQAVBC80lX
0Gyf4Qf+L1XpYEcBhhNRFnqf8sKLYi1+84xOTNBjFiGE0+oIQEZukOMDiUVqkwKm
irocJFR0BOUyW4bPyyKusAUhBGIHSSvYGHx60onkF4hW1FmfdbFWZ/jnNQjYTKar
qkb1pnjVBsLhsqT2O3GgIeGYtuLCwpE+V1xc7h8Ovr1h894T8pgCd/8rnfZArTCc
XU/IxlI0wOyVssSImJ4ifG2asd5o+cPQWREusYwz2vsSJ/QKAATegiGwDxvqtF0p
4TLI1MZ08aFHNTp+hwg0NUdivmr4eNziUnP2+NlPJnc2pcCLAGzW2Y5UmNsyxSqq
oF8ck1hqt3Y5Sv0KYUPSYlnzHyADVg==
=s12a
-----END PGP SIGNATURE-----

--Sig_/u=QOXxHPloGUhoTq+7gFMqj--
