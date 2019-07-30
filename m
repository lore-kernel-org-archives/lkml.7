Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA24C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925B0206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A9DF8nat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbfG3CbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:31:05 -0400
Received: from ozlabs.org ([203.11.71.1]:55741 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730983AbfG3CbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:31:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45yLC71Kk8z9s8m;
        Tue, 30 Jul 2019 12:30:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564453859;
        bh=z4v0JCS58MHFvgEhRgTB4IMjS5Og2vWkb3qkjrAaSTY=;
        h=Date:From:To:Cc:Subject:From;
        b=A9DF8nat5eJ5dwEVyz9TneA2i/FXwyd046rTjpj5ZrOUzqV183w05sycXDlwcH1ey
         KDHiUk5H3442TZmGs9oEtnmuQAD+kUNPlf3F2nK2j+gdBIoi6BbTdepO1n5vEB6s/n
         PKzXoxdWE1uf5/U5l7FhaW/ZNm0yMSAFal7N6weMGJsOUEDHAAwGFClyjvRPD1/Cuo
         wJilWQcLGaSqbx71QgQGTtb7AkaC+uYicPiMlXzt8Clvs9vsT4FnUWfke7460ppCTW
         /wiUkAmxhAJzavoouMk3cgHEoXP3qRoJV+mXXceK4nlVo3cH9m8+1Tjzh9bzxCV7En
         1q9rWUFS39IHA==
Date:   Tue, 30 Jul 2019 12:30:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warnings after merge of the keys tree
Message-ID: <20190730123042.1f17cdd4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M2=CJBp9oFdhZAfgX7jrZgk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M2=CJBp9oFdhZAfgX7jrZgk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the keys tree, today's linux-next build (x86_64
allmodconfig) produced these warnings:

In file included from include/linux/keyctl.h:11,
                 from include/linux/key.h:35,
                 from include/linux/cred.h:13,
                 from fs/verity/signature.c:10:
fs/verity/signature.c: In function 'fsverity_init_signature':
include/uapi/linux/keyctl.h:52:24: warning: passing argument 5 of 'keyring_=
alloc' makes pointer from integer without a cast [-Wint-conversion]
 #define KEY_POS_SEARCH 0x08000000 /* possessor can find a key in search / =
search a keyring */
                        ^
fs/verity/signature.c:140:25: note: in expansion of macro 'KEY_POS_SEARCH'
         current_cred(), KEY_POS_SEARCH |
                         ^~~~~~~~~~~~~~
In file included from include/linux/cred.h:13,
                 from fs/verity/signature.c:10:
include/linux/key.h:386:20: note: expected 'struct key_acl *' but argument =
is of type 'int'
 extern struct key *keyring_alloc(const char *description, kuid_t uid, kgid=
_t gid,
                    ^~~~~~~~~~~~~

Caused by commit

  f802f2b3a991 ("keys: Replace uid/gid/perm permissions checking with an AC=
L")

interacting with commit

  318ce3c7b2ff ("fs-verity: support builtin file signatures")

from the fsverity tree.

(Have I mentioned that I have API changes? ;-))

I have applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 30 Jul 2019 12:13:38 +1000
Subject: [PATCH] fsverity: merge fix for keyring_alloc API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/verity/signature.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index c8b255232de5..a7aac30c56ae 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -131,15 +131,26 @@ static inline int __init fsverity_sysctl_init(void)
 }
 #endif /* !CONFIG_SYSCTL */
=20
+static struct key_acl fsverity_acl =3D {
+	.usage	=3D REFCOUNT_INIT(1),
+	.possessor_viewable =3D true,
+	.nr_ace	=3D 2,
+	.aces =3D {
+		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_JOIN |
+				  KEY_ACE_INVAL),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_WRITE |
+			      KEY_ACE_CLEAR | KEY_ACE_SEARCH |
+			      KEY_ACE_SET_SECURITY | KEY_ACE_REVOKE),
+	}
+};
+
 int __init fsverity_init_signature(void)
 {
 	struct key *ring;
 	int err;
=20
 	ring =3D keyring_alloc(".fs-verity", KUIDT_INIT(0), KGIDT_INIT(0),
-			     current_cred(), KEY_POS_SEARCH |
-				KEY_USR_VIEW | KEY_USR_READ | KEY_USR_WRITE |
-				KEY_USR_SEARCH | KEY_USR_SETATTR,
+			     current_cred(), &fsverity_acl,
 			     KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(ring))
 		return PTR_ERR(ring);
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/M2=CJBp9oFdhZAfgX7jrZgk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0/q9IACgkQAVBC80lX
0Gy2fwf7Bw/v1qRHrP001IkgRGwCkUTGj7uNtJkZzlEm2/COKldcxF8Lw0HYrG/P
3I/pPCjnHfo2EjDlG42Rm7LsjxsBoDvjz+hDGnD6nBRf4kexfoDq/gx7xnhlXLYH
9izMIQEaFtSWHdvTmeWb6P+7UA44cXK3kaA2eEZ/3mwi+/xUOtGaYXmVO9/cupyb
kLRbR2EcYMtipuJPpj3ywzFX5+5x8DYdn+qt+PfCg+yEqZTj5PdpiOFri686y5Pb
xrsMfONrI5rZA0FtfVbGxt/GPe+FvrD6qI8YsCjFF43iU6PruO35zVRhup7k/SP+
U6Jab3fiMgDItTX58+Zdi10i0iO9QQ==
=Z7gH
-----END PGP SIGNATURE-----

--Sig_/M2=CJBp9oFdhZAfgX7jrZgk--
