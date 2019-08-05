Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123C8C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B562070D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lqDWLVPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfHEE5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 00:57:39 -0400
Received: from ozlabs.org ([203.11.71.1]:60767 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfHEE5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 00:57:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46259X61ngz9s7T;
        Mon,  5 Aug 2019 14:57:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564981056;
        bh=Kwjsg60Bv78fkfFhCCvHJttAJaSF+wmyVAYwqKxGsLA=;
        h=Date:From:To:Cc:Subject:From;
        b=lqDWLVPHKQaChx12u4Bqeoka2q8nx70si95qJXfKKAfL5QPIIdtDa/qIYVfOWKBaI
         0mtV25IvOeSJfJq6qeqa5cH9G3HmtzKqQymzZP7xxMExPPONvW8WIfrQjEbHdEV+1z
         gS9DI/sJheBrPkK1O+T185GOX/RFf3Bhl8LdQKeyKk9z4Z1sG47kheMAC2+9iWkJbu
         BS//Hee9Zcny2zwsD1jHlm52Mfo9ft5B9wwG2hvzeAiFwPlR/5YOABt7UOf1gckLAm
         iHo6yP13PqqSmNKqdoeJDOZRcPDWRd8ZvEN0fH5urepOzbhyjYcw6eZR6wKAb4a0go
         zEFlnq56/UAgw==
Date:   Mon, 5 Aug 2019 14:57:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuhong Yuan <hslester96@gmail.com>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20190805145736.2d39f95b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xTBKpWe9v5NlxbxL4v5QvzF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xTBKpWe9v5NlxbxL4v5QvzF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (sparc64
defconfig) failed like this:

drivers/char/hw_random/n2-drv.c: In function 'n2rng_probe':
drivers/char/hw_random/n2-drv.c:771:29: error: 'pdev' undeclared (first use=
 in this function); did you mean 'cdev'?
  err =3D devm_hwrng_register(&pdev->dev, &np->hwrng);
                             ^~~~
                             cdev
drivers/char/hw_random/n2-drv.c:771:29: note: each undeclared identifier is=
 reported only once for each function it appears in

Caused by commit

  3e75241be808 ("hwrng: drivers - Use device-managed registration API")

I applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 5 Aug 2019 14:49:59 +1000
Subject: [PATCH] hwrng: fix typo in n2-drv.c

Fixes: 3e75241be808 ("hwrng: drivers - Use device-managed registration API")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/hw_random/n2-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-dr=
v.c
index 2d256b3470db..73e408146420 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -768,7 +768,7 @@ static int n2rng_probe(struct platform_device *op)
 	np->hwrng.data_read =3D n2rng_data_read;
 	np->hwrng.priv =3D (unsigned long) np;
=20
-	err =3D devm_hwrng_register(&pdev->dev, &np->hwrng);
+	err =3D devm_hwrng_register(&op->dev, &np->hwrng);
 	if (err)
 		goto out_hvapi_unregister;
=20
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/xTBKpWe9v5NlxbxL4v5QvzF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1Ht0AACgkQAVBC80lX
0GwDhQf/faKdUW5dGiwL6BcS1VWPr05Q6fkvSO3K5CPMR6kxzcHrhJzJ5cmlo/Mr
auG+eCRXImb+REsfycJ4rxfpWISb8rWSkGNfEavijVmsbnHkngPLDd2lUzf6LjVa
/ZMmdVC1z+WtXP/4HZchuCpk8VamC9RYDNbJXCXPz3tXcJ/HYpncyvqceNEGCjim
QDWKnKZQtN2DIZH2yBp+s8RHdSzFxgFjTrFg5wToB4Mx+68z/OPa8XZj6XcXXKZr
emA3V082G4UXi8pGh3X3tnAG6Y22r5vggIlsyo6gJhF60/8JVjzZGZ96xfTpFU/B
H+o9BBpus5HdVBISLDcjGLPVobRzzw==
=TF+o
-----END PGP SIGNATURE-----

--Sig_/xTBKpWe9v5NlxbxL4v5QvzF--
