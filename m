Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A938C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701A22171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kJhTcifz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfGIALL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:11:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47151 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGIALK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:11:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jN5R4kKxz9sMr;
        Tue,  9 Jul 2019 10:11:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562631067;
        bh=wpx2irDwW5+A4fwIwvCwROCOPBiqH99jd5wcbrP3dTk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kJhTcifzJjKf2Ac16nM8dGyNv3fy4szVWWWueL9h2BY1JDSbs5IORH3vSHutUi32J
         4T3pc51TQ9pFq9iqGOybOERVaw6AXnPu6cFtQicBEuPpFFYwtZ/wDkmj3gDPj3UrfO
         dDLJC+fXejH6N+w+RNkY83JjP1yU4CupiIlyOkFvu7haauN+Sf57alzXd4POrqwRv+
         lOnc0Utpm7tsWcthMMb6mc1+jROJvi+ie3hAjiGJ65xEvXmEPcFYXjq3hl+hEYsRrh
         ymbqC0XhPti02IL7gKzSEsVx3mX78fpDrXtIYhtaNMwv+57DOZa0YzNaSNU0SsmcKF
         XiiQLKwB6f2bw==
Date:   Tue, 9 Jul 2019 10:11:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the keys tree with the integrity
 tree
Message-ID: <20190709101107.0754b26c@canb.auug.org.au>
In-Reply-To: <20190626143333.7ee527ca@canb.auug.org.au>
References: <20190626143333.7ee527ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KbtJCZGIIH=5V6pKkYuzgHs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KbtJCZGIIH=5V6pKkYuzgHs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 26 Jun 2019 14:33:33 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the keys tree got a conflict in:
>=20
>   security/integrity/digsig.c
>=20
> between commit:
>=20
>   8c655784e2cf ("integrity: Fix __integrity_init_keyring() section mismat=
ch")
>=20
> from the integrity tree and commit:
>=20
>   79512db59dc8 ("keys: Replace uid/gid/perm permissions checking with an =
ACL")
>=20
> from the keys tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc security/integrity/digsig.c
> index 868ade3e8970,e432900c00b9..000000000000
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@@ -69,9 -70,8 +70,9 @@@ int integrity_digsig_verify(const unsig
>   	return -EOPNOTSUPP;
>   }
>  =20
>  -static int __integrity_init_keyring(const unsigned int id, struct key_a=
cl *acl,
>  -				    struct key_restriction *restriction)
>  +static int __init __integrity_init_keyring(const unsigned int id,
> - 					   key_perm_t perm,
> ++					   struct key_acl *acl,
>  +					   struct key_restriction *restriction)
>   {
>   	const struct cred *cred =3D current_cred();
>   	int err =3D 0;

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/KbtJCZGIIH=5V6pKkYuzgHs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j25sACgkQAVBC80lX
0GwWTwf/eW9EhsHg+4ROjz89YntEN+CT4XpTKCq516Wb3ZRdPQx6ZBECkh4pW+1M
j+pa4aZR036zZ55mdD1MkHRiP0LJ7DBQaVKhov9gxb9ZKhffTN65SsGf4ZkdmXaM
s4Gr2Smh0MzuWuviS5/+ImAJBl0H13h5jRzSPBl58YN6NrWueFtaj7zEBIbA8wYF
B/O0jKYtTVhTmyCWke/zpbR4aeZ/QWjoVYvOJeLTXSIreLkatr2NZWTrh44Qeemi
RR1aJfM676G/AaDeYIDJyJFaui4fZ8izj2hx/xhOSuTJ8PGVbrLnYc29yjxrPbNz
scpB4G10CtWNxmFcw0hucM/r6nMWmA==
=/oWY
-----END PGP SIGNATURE-----

--Sig_/KbtJCZGIIH=5V6pKkYuzgHs--
