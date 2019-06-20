Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A0EC48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4A120B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="n0wy6jRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbfFTDkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 23:40:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33711 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfFTDkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 23:40:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Tndb0ldyz9s5c;
        Thu, 20 Jun 2019 13:40:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561002019;
        bh=ijQQ/4hkRUFtbJUgDcYaDhiOsBEP0Efq/bskoYEG12Y=;
        h=Date:From:To:Cc:Subject:From;
        b=n0wy6jRU4JCZGzsxf26nBPvz6BDhgbSKcJ+Gg1nP2P90VEArPyM3wu/XeYHHVEPf3
         LFPdULcb+ta6X24fWXCj0/9XPoIbGl2HXC63zLCtp0eUi8McjMBTEP8mK6BqkwaUe5
         pXnRBXLshl93coKbdRtlI6Xa58+oKDki7CUy1AK1ewqKK/9NUgxbxECx7NDKfVZU9P
         3AzN5QfXH3LAvWDDgwLYdp807X53XzDLQmfcOdlzyo1at4/fZZZWa0HhVTQlVgQTHL
         bu7ZXAC8svXJYuUoWmSOZIAYOYVefqR0WQD+pnCCYIxd+cXJ0PzLYz7EvrzEjq4UDf
         xyRwohMiQLv5A==
Date:   Thu, 20 Jun 2019 13:40:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the apparmor tree with Linus' tree
Message-ID: <20190620134018.65643fb4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ut7DIwlQ/N/iXsRrEEQCLxe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ut7DIwlQ/N/iXsRrEEQCLxe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the apparmor tree got a conflict in:

  security/apparmor/include/policy.h

between commit:

  23375b13f98c ("apparmor: fix PROFILE_MEDIATES for untrusted input")

from Linus' tree and commit:

  06c13f554a71 ("apparmor: re-introduce a variant of PROFILE_MEDIATES_SAFE")

from the apparmor tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/apparmor/include/policy.h
index b5b4b8190e65,9af2114e1bf0..000000000000
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@@ -213,14 -217,13 +213,22 @@@ static inline struct aa_profile *aa_get
  	return labels_profile(aa_get_newest_label(&p->label));
  }
 =20
 -#define PROFILE_MEDIATES(P, T)  ((P)->policy.start[(unsigned char) (T)])
 +static inline unsigned int PROFILE_MEDIATES(struct aa_profile *profile,
 +					    unsigned char class)
 +{
 +	if (class <=3D AA_CLASS_LAST)
 +		return profile->policy.start[class];
 +	else
 +		return aa_dfa_match_len(profile->policy.dfa,
 +					profile->policy.start[0], &class, 1);
++}
++
+ /* safe version of POLICY_MEDIATES for full range input */
+ static inline unsigned int PROFILE_MEDIATES_SAFE(struct aa_profile *profi=
le,
+ 						 unsigned char class)
+ {
+ 	return aa_dfa_match_len(profile->policy.dfa,
+ 				profile->policy.start[0], &class, 1);
  }
 =20
  static inline unsigned int PROFILE_MEDIATES_AF(struct aa_profile *profile,

--Sig_/Ut7DIwlQ/N/iXsRrEEQCLxe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LACIACgkQAVBC80lX
0GwYxQf+M5q0qDZ3fyje66FFL8gwuVZj/ABU9yF0q1k+LFSzBNQTgahuYHur2Scq
k0CScgHTVcRwTQk3jhy9mnrLF62m2+7wQJPVql1cg5KozFsDoFC3O3wMxNlPiSwQ
XfB4hSAiSFRSsoy/1y8N/0oHqJ+acLbDbAPCIqDPaMtYaonWnUJVQaBXSgdq6Wvr
D3J993FtmHFA/1r0EsD3LcuiZwVzIltccO1J7iutQrJ2tzcLxy38X5MbJfkHU9JY
RHecA3/gt4PanS6sGE4gZwKzi22/ksSFa8VKFj+Vn2Rrn2hDbgqQEqlEZfQdkB4e
G+7k7ruoRyf6jTqJBt6tVIhCP2KxjQ==
=gGun
-----END PGP SIGNATURE-----

--Sig_/Ut7DIwlQ/N/iXsRrEEQCLxe--
