Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5A3C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 00:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5292623400
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 00:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kghVqH9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfICA31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 20:29:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55215 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfICA31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 20:29:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46Mnrh4nfXz9sBF;
        Tue,  3 Sep 2019 10:29:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567470564;
        bh=kRsR/fjmnRdyi+3hg0btWrEuAKdQggHirBw6zRr60Ws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kghVqH9gpZyfvRaErHT/0zN292YSTP85UTk+btTklGj1GpsB0Bnd0IDUMV5wdr1uN
         TV/Kb7Gy6o4vCWzW7FUdtkDLW5NXnJPM9v6zhBtABkecZysq2Hg3ncCFbYL0sIxltx
         SpKQzBvUEtFkcOEkE37wzkc7cj34WeAdTOySs/Y7JWJNcAbV5y/Osl+ZNfuml9t/1j
         bKWI/4U2LXAfTf/FhnTtbW2OE6hriSHDCGe2QlSsRZs4a6mpfQMp+nuIkiO0WEt9US
         aISWmHd3/BHWH5WxZYf9aVkwUI1m6u2bVwHEPmYHW4FSpQLYCkCSUfB/idEqdFOeM+
         cDT+aRCdHW8Cg==
Date:   Tue, 3 Sep 2019 10:29:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the keys tree
Message-ID: <20190903102922.0268fd2f@canb.auug.org.au>
In-Reply-To: <14616.1567468394@warthog.procyon.org.uk>
References: <20190903092121.0b817e0c@canb.auug.org.au>
        <20190902161935.78bf56f1@canb.auug.org.au>
        <20190829153116.7ffc7470@canb.auug.org.au>
        <16836.1567440079@warthog.procyon.org.uk>
        <20190903090722.556b66ba@canb.auug.org.au>
        <14616.1567468394@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k/jpeBvWwx01Wkh17hpg.qx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k/jpeBvWwx01Wkh17hpg.qx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 03 Sep 2019 00:53:14 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > > I was doing an x86_64 allmodconfig build which seems to build (all of=
?)
> > > the samples. =20
> >=20
> > Of course, this breaks our crossbuilds :-(
> >=20
> > e.g. S390 allyesconfig build:
> >=20
> > /usr/bin/ld: cannot find -lkeyutils =20
>=20
> Is it a requirement that stuff in samples/ should be able to build without
> resorting to external userspace headers?  Or, at least, those outside of =
the C
> library?

Well, this is the only samples failure in the current build ...

--=20
Cheers,
Stephen Rothwell

--Sig_/k/jpeBvWwx01Wkh17hpg.qx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1ts+IACgkQAVBC80lX
0GxFigf+L+6cUzLRMAv9GIN4LAlCEJSOdaa58XFtQtrvhvDh/MqMl6kwoxerrIFA
Hw8mYpzo7lKWg+2ZpR+l5vN3y+9hj0F7ztMVlq+NLF10FJkWm7lqhY1HY6fG60yw
wcl1vjXSFW4iZR3pIojHdFBO35xgOE0oklaP6mcHlgADBm/M7k9m5ZVb2yp+M4tm
fzl9VySBAaK8U7BYMB0VEKsEH4T6Kl3q7lY7JdG8YOFDNk9b/eizKyLCeF81z+mG
fb5E4CjE14Ut1/tDJt3LlXgEejjQgmU7tR+xsvfUoNFWma18/fcfhNou4U6LACwQ
DilYcQxT0UJDUSvUbEn05c2ddt/D9A==
=cBHe
-----END PGP SIGNATURE-----

--Sig_/k/jpeBvWwx01Wkh17hpg.qx--
