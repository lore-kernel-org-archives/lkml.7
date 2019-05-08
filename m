Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F55AC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C4420879
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="de44/kO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfEHAFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:05:35 -0400
Received: from ozlabs.org ([203.11.71.1]:36349 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfEHAFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:05:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zGvb4CM2z9s00;
        Wed,  8 May 2019 10:05:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557273933;
        bh=oiPHLrJ1PNdtIn7Z2unJZ152OwUKHCpZpXYVThGD6G0=;
        h=Date:From:To:Cc:Subject:From;
        b=de44/kO67Isp6nkiulJukoLG7aPg9xt0BTNhM48Bk03ff0xj5f2Eh0hompS/fGJib
         Qmu82+zV5j2276qeRiKIX5ugSejhI1L4cqpZC1Ew2re3JqXxXCR9KUZPh3iyuujLL/
         I3nymZKW2K8FMhPTGa8SppkOk8svjcCAOgCsUXLlreEmB55rb3r/ODZOimf0epMMSF
         vaeFPBUTCas1GMgHJ00jYKuL/QlOn6iAjCDIM/u3nk9GWaJpopxTdjv6sO5dsfhj9I
         q1CcQIyTLNAVTBgBo8s8jPdkfQyrSv923rTl/j8Y2+kLtF/K5wf5AtbWIDOl17aG6x
         F7UUW2xHHvdsw==
Date:   Wed, 8 May 2019 10:05:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Weinberger <richard@nod.at>
Subject: linux-next: manual merge of the ubifs tree with Linus' tree
Message-ID: <20190508100525.7c24c8be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PktYFn.tjcmLyihpLR/OTUn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PktYFn.tjcmLyihpLR/OTUn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ubifs tree got a conflict in:

  fs/ubifs/auth.c

between commit:

  877b5691f27a ("crypto: shash - remove shash_desc::flags")

from Linus' tree and commit:

  f4844b35d68a ("ubifs: work around high stack usage with clang")

from the ubifs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ubifs/auth.c
index b758004085c4,3d049194afa4..000000000000
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@@ -85,12 -86,17 +84,16 @@@ int ubifs_prepare_auth_node(struct ubif
  	if (!hash)
  		return -ENOMEM;
 =20
- 	hash_desc->tfm =3D c->hash_tfm;
- 	ubifs_shash_copy_state(c, inhash, hash_desc);
+ 	{
+ 		SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
 =20
- 	err =3D crypto_shash_final(hash_desc, hash);
- 	if (err)
- 		goto out;
+ 		hash_desc->tfm =3D c->hash_tfm;
 -		hash_desc->flags =3D CRYPTO_TFM_REQ_MAY_SLEEP;
+ 		ubifs_shash_copy_state(c, inhash, hash_desc);
+=20
+ 		err =3D crypto_shash_final(hash_desc, hash);
+ 		if (err)
+ 			goto out;
+ 	}
 =20
  	err =3D ubifs_hash_calc_hmac(c, hash, auth->hmac);
  	if (err)

--Sig_/PktYFn.tjcmLyihpLR/OTUn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzSHUUACgkQAVBC80lX
0GxluAf+NFIDpqdiuZljF+G24ADeJLFbGjsnyLnKHvfZwi0xS/hCVrzhpL0NnyUo
ZtExq/OwLbnb0/BNgG5C1WlnhGrpfDE62f81N8cajNl5fuYmBsQW+9zBiokJM63J
tiWJ9Y2cwN4WAp15sQUogprh4dXOwp/dwer+Q47GvX6KOZHdXByGEjQLYBlqafg1
6a8xoIbjxmCi06vqcu3EiuF9g0PICRMPrbpTpDAPcaKFvJyXFVTFHY35dctILcQq
2QzqLIWLfQuE+DJedxdOPf/f29ofZls4Z46JihojydTUUMwymC4ANWBofzct9nWB
j+UuwyN5M5Q5+Q9pkJN496Xx/gI02g==
=gYRA
-----END PGP SIGNATURE-----

--Sig_/PktYFn.tjcmLyihpLR/OTUn--
