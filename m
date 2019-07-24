Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4CAC76194
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96112229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WxtIuTUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfGXC3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:29:32 -0400
Received: from ozlabs.org ([203.11.71.1]:48703 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfGXC3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:29:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45tfS84lGxz9s4Y;
        Wed, 24 Jul 2019 12:29:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563935368;
        bh=KoKvKtBbDS7uwmpWuUeI/yYxUhlBQxlp+t/v0C2B1+s=;
        h=Date:From:To:Cc:Subject:From;
        b=WxtIuTUEn1AsI+T/krwQ7Rfg95K0BWfPsuTKh3yExjUh8UeASFaR/AprIFCVfscUz
         IF/Rpvf17SfomrMWGTer9/0IMTSJ6wD4O6qC/KB35Q97a2LpHbPtsaLZ+n+vWVta/w
         nE5bJi1rfvJVlCjrMDPvSFP50VSHiViQUBlURveaGq86B5tn9RZfmluJ5Xh7lGhHf+
         v0GdnoM8rbs38mNomNrZMWdbxk/gqA3NXP+HHEhc7TNoPDYMhvd28bXfOAWQOE7fCh
         n+C1BPVFkEz2INumSm1BvTlbkKc+o0YsqefTvpeqDvNLfrDKiKDF7ESd/rQHamrdRk
         tLIq3mch+Zm/Q==
Date:   Wed, 24 Jul 2019 12:29:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the keys tree with the afs tree
Message-ID: <20190724122928.2a27c6aa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=8T79JeaYBWiZbzZSmn87Mx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=8T79JeaYBWiZbzZSmn87Mx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the keys tree got conflicts in:

  fs/afs/security.c
  include/linux/key.h

between commit:

  dd05d852085f ("afs: Provide an RCU-capable key lookup")

from the afs tree and commit:

  f802f2b3a991 ("keys: Replace uid/gid/perm permissions checking with an AC=
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

diff --cc fs/afs/security.c
index ce9de1e6742b,8866703b2e6c..000000000000
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@@ -27,37 -27,8 +27,37 @@@ struct key *afs_request_key(struct afs_
  	_enter("{%x}", key_serial(cell->anonymous_key));
 =20
  	_debug("key %s", cell->anonymous_key->description);
 -	key =3D request_key(&key_type_rxrpc, cell->anonymous_key->description,
 -			  NULL, NULL);
 +	key =3D request_key_net(&key_type_rxrpc, cell->anonymous_key->descriptio=
n,
- 			      cell->net->net, NULL);
++			      cell->net->net, NULL, NULL);
 +	if (IS_ERR(key)) {
 +		if (PTR_ERR(key) !=3D -ENOKEY) {
 +			_leave(" =3D %ld", PTR_ERR(key));
 +			return key;
 +		}
 +
 +		/* act as anonymous user */
 +		_leave(" =3D {%x} [anon]", key_serial(cell->anonymous_key));
 +		return key_get(cell->anonymous_key);
 +	} else {
 +		/* act as authorised user */
 +		_leave(" =3D {%x} [auth]", key_serial(key));
 +		return key;
 +	}
 +}
 +
 +/*
 + * Get a key when pathwalk is in rcuwalk mode.
 + */
 +struct key *afs_request_key_rcu(struct afs_cell *cell)
 +{
 +	struct key *key;
 +
 +	_enter("{%x}", key_serial(cell->anonymous_key));
 +
 +	_debug("key %s", cell->anonymous_key->description);
 +	key =3D request_key_net_rcu(&key_type_rxrpc,
 +				  cell->anonymous_key->description,
 +				  cell->net->net);
  	if (IS_ERR(key)) {
  		if (PTR_ERR(key) !=3D -ENOKEY) {
  			_leave(" =3D %ld", PTR_ERR(key));
diff --cc include/linux/key.h
index bec10fbb2462,6fef6684501f..000000000000
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@@ -339,20 -340,8 +340,20 @@@ static inline struct key *request_key(s
   * Furthermore, it then works as wait_for_key_construction() to wait for =
the
   * completion of keys undergoing construction with a non-interruptible wa=
it.
   */
- #define request_key_net(type, description, net, callout_info) \
- 	request_key_tag(type, description, net->key_domain, callout_info);
+ #define request_key_net(type, description, net, callout_info, acl)	\
+ 	request_key_tag(type, description, net->key_domain, callout_info, acl);
 +
 +/**
 + * request_key_net_rcu - Request a key for a net namespace under RCU cond=
itions
 + * @type: Type of key.
 + * @description: The searchable description of the key.
 + * @net: The network namespace that is the key's domain of operation.
 + *
 + * As for request_key_rcu() except that only keys that operate the specif=
ied
 + * network namespace are used.
 + */
 +#define request_key_net_rcu(type, description, net) \
 +	request_key_rcu(type, description, net->key_domain);
  #endif /* CONFIG_NET */
 =20
  extern int wait_for_key_construction(struct key *key, bool intr);

--Sig_/=8T79JeaYBWiZbzZSmn87Mx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl03wogACgkQAVBC80lX
0Gyn6wf/c7oDvhwP8CsqBXBnBLj6VKAJyyfMGt4mHTvX9XtaKmKU9pog6hTaQPBm
l+QE7uqU2kQt0u7QxWly/9nPUCHazRddLVNE31n99S1AUJz1NOIo+9pngjirFaYi
pqXiIF0oRarz4RKGfWrWykVUjub5k2cpFQScdtRb89M5Ot+kYWzUpEQg7FMUq2Ge
5/+YMBgHLfJtqvCcLSFZm3o18xur73O54F9ycYX5FaOyaTnLiIS2NCFer+64pZCB
UPITJCGRAqDGRxvYO8CyzmulyFxWJ/4luzI1WWEFFWwnrIa9GzRLO8yfapmVd6V9
ovwd5bPXJO+63XQmF5L07D04pn0ClA==
=+15G
-----END PGP SIGNATURE-----

--Sig_/=8T79JeaYBWiZbzZSmn87Mx--
