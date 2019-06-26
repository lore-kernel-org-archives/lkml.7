Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725D1C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC83208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uRtIXozc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfFZE2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 00:28:43 -0400
Received: from ozlabs.org ([203.11.71.1]:38487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfFZE2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:28:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45YVQb1WZNz9s4V;
        Wed, 26 Jun 2019 14:28:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561523319;
        bh=gFfeXbLG/ItocsX/m5ahD7HVvSfQilzaK0UbPwO26vM=;
        h=Date:From:To:Cc:Subject:From;
        b=uRtIXozcHqpFEUln+8F6aziRdUNvkRvMrhjpUI9+oPvJia24BluLTL+idPkdxgYFC
         8w11NDeIEU/ZH24mg15M0bbgyFWkj1CRVA7uvY/CxrYjGzYgA3zDWBvFdSpdaw4OUD
         N9n5pC2VKN2z8vn5fjoyXIQHXJppqX3/QE+RLII4XmbsQjyxZAxOPY9EF5Wmtqjpqf
         RPJuH8Wnhyf8Bx0QSAF5mlD3SWv9zR0n6fCLRgpyi9A0HkaOs2qJvQnClltOQw82oQ
         mueumNqT7ct5USi53zsMTsw20f72Rwgyv5zyOLXbmnR8AVceibpxES4OYy3t3WSnna
         TlBmQ762F3seQ==
Date:   Wed, 26 Jun 2019 14:28:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@canonical.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: linux-next: manual merge of the keys tree with the ecryptfs tree
Message-ID: <20190626142838.0f9bb5d6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FLu3G8RQm6nxi1B=Q=_TPaS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FLu3G8RQm6nxi1B=Q=_TPaS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the keys tree got a conflict in:

  fs/ecryptfs/keystore.c

between commit:

  29a51df0609c ("ecryptfs: remove unnessesary null check in ecryptfs_keyrin=
g_auth_tok_for_sig")

from the ecryptfs tree and commit:

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

diff --cc fs/ecryptfs/keystore.c
index 216fbe6a4837,ba382f135918..000000000000
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@@ -1611,10 -1610,10 +1611,10 @@@ int ecryptfs_keyring_auth_tok_for_sig(s
  {
  	int rc =3D 0;
 =20
- 	(*auth_tok_key) =3D request_key(&key_type_user, sig, NULL);
+ 	(*auth_tok_key) =3D request_key(&key_type_user, sig, NULL, NULL);
 -	if (!(*auth_tok_key) || IS_ERR(*auth_tok_key)) {
 +	if (IS_ERR(*auth_tok_key)) {
  		(*auth_tok_key) =3D ecryptfs_get_encrypted_key(sig);
 -		if (!(*auth_tok_key) || IS_ERR(*auth_tok_key)) {
 +		if (IS_ERR(*auth_tok_key)) {
  			printk(KERN_ERR "Could not find key with description: [%s]\n",
  			      sig);
  			rc =3D process_request_key_err(PTR_ERR(*auth_tok_key));

--Sig_/FLu3G8RQm6nxi1B=Q=_TPaS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0S9HYACgkQAVBC80lX
0GyktAgAmlOsnZ667Y1vZXSTAOUSHw1/nk9euAZz+qdTxqKuLDfaNESQBj1GmHe+
0OtNnZnxz1CmP8ISUZyotLeuM158xwu3jbij8na6/yMvP0B1J28uBvLWcKp019Zi
XEMERzWeeLuIF/sP5Xv6qUAmtVnhstAI71uiFOR0kpuKFIprhGOH/nzEY1yHV60c
jrBBzcxDDwZfq6KN8kmrG9gWad+epbyLOJ5ESkqSWKza+ggabOt6urGIyUY0QGQ3
Mn3a+aV1KEA8gooLzuceq8bUje9OyaHEt107ClAGONcrhH/TlI7aVXzzHTstotqG
sjsE4EaPH2ymlSFZKukLWQOUlaMe2A==
=7mAc
-----END PGP SIGNATURE-----

--Sig_/FLu3G8RQm6nxi1B=Q=_TPaS--
