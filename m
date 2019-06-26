Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE3CC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47189208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gGTTMbeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfFZEdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 00:33:37 -0400
Received: from ozlabs.org ([203.11.71.1]:59323 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfFZEdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:33:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45YVXF5TgTz9s4V;
        Wed, 26 Jun 2019 14:33:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561523613;
        bh=GnKZEBSZpJW2XWCODba6I/alezaYiCwHX7DTAsgReQ4=;
        h=Date:From:To:Cc:Subject:From;
        b=gGTTMbeA9SOHI94p5sI2zKkhh8ykhyOFENgn3IXPJ2ZVLRpYDSEeY1N05g0fosvxm
         BSOY1Tyh3FrCmTporKikJBh25YHPaNuWOM+sVQSaZJJtJ6ZO6s1F5kQQdg3OFNowMi
         TA3PSwU3z4D7K0b7QpYJ4b0i2CjHNafwlRdioflXlw+5i9iQ2oLcNOBSIAs6hyNF7U
         oEn/QuIN1nTF7KkjMrrA1yj+Ikd/IeBjROsxSdMdqONqVZTPzOYUQ4Jmhyjt3J4j0e
         5zfD6+HJOipU3ymGw12yb0O8xl0LiUExxrmnHzWzGZrAlElhZJViYjf7p6Vay7NWa/
         ET1cpYe1RE8xg==
Date:   Wed, 26 Jun 2019 14:33:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the keys tree with the integrity tree
Message-ID: <20190626143333.7ee527ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AzL_04kP1980wy1=bN/TNtr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AzL_04kP1980wy1=bN/TNtr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the keys tree got a conflict in:

  security/integrity/digsig.c

between commit:

  8c655784e2cf ("integrity: Fix __integrity_init_keyring() section mismatch=
")

from the integrity tree and commit:

  79512db59dc8 ("keys: Replace uid/gid/perm permissions checking with an AC=
L")

from the keys tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/integrity/digsig.c
index 868ade3e8970,e432900c00b9..000000000000
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@@ -69,9 -70,8 +70,9 @@@ int integrity_digsig_verify(const unsig
  	return -EOPNOTSUPP;
  }
 =20
 -static int __integrity_init_keyring(const unsigned int id, struct key_acl=
 *acl,
 -				    struct key_restriction *restriction)
 +static int __init __integrity_init_keyring(const unsigned int id,
- 					   key_perm_t perm,
++					   struct key_acl *acl,
 +					   struct key_restriction *restriction)
  {
  	const struct cred *cred =3D current_cred();
  	int err =3D 0;

--Sig_/AzL_04kP1980wy1=bN/TNtr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0S9Z0ACgkQAVBC80lX
0GxLyQf7BkYLYN+hcxGgNyEap6vda6zNXLzt17WnCAgbaSTJ2GE6/Z2DbUZ1Z9/F
ggLO0oP/e/PY2KLpYnqzMplFK7ZwL3+oe5gHfaUSbF1rAAIxNBpUXq+59UgDvMOP
F1mL4REEuNTn9IMH+glG9veKkxVFkQTpIK+IfXz/EcgrkXgadgacw7k+PUVVVjg2
CPKec0kFccjv88nlQdEUZENWai4rPCjSrrw9+ypKvnT56+OLHQcTPgDL40uxdBlN
W5aMrOIHBnJ8hIC1AiUwEpOmwzr4gRE85YKCyseCcT4T4977SfosiVnP/klUNzqB
M3nNmr2gSOMIvbLqDOgvo6WBfRxH4w==
=9B8o
-----END PGP SIGNATURE-----

--Sig_/AzL_04kP1980wy1=bN/TNtr--
