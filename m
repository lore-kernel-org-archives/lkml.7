Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0777EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD115206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="meu/51KZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDCD4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:56:19 -0400
Received: from ozlabs.org ([203.11.71.1]:44983 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfDCD4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:56:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Ysh01KQMz9sQr;
        Wed,  3 Apr 2019 14:56:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554263776;
        bh=+2xwzZPGa4KVFSWAGCXJHQJ2M7jVQHCVhlgaAf7WSbw=;
        h=Date:From:To:Cc:Subject:From;
        b=meu/51KZWzmpgpj8dLRV1jDLO+ttCIzFS1S4k1PkBeljoNb+iFeUfyrZWiMJ7F+q+
         uAvPZrFx3r1Y5Y/ljyB3Xr0k4a1sjwkZLpe3qbC20RaCDUwLOl5BpA72nraCtT5Fpe
         zgX0cTyFKhpN1peEIiP9hmRevXAulHXcqlwjpmEzDsmdGEbWBjpXXsdLLmyc5g4/yU
         1fsRVZi5Hd5PCWUzCTKsPSxa8BpNFLOHQlMwao/TLrLAWIZIm781FjCPccKZkyMuX+
         XSuuzlXm5ggFsmxzERcojoJrAw1nz2Xnct2kyR4gNnhlUS7NUhLjdovwvzYYHaU9ib
         Be0Jq2i0k7w1Q==
Date:   Wed, 3 Apr 2019 14:56:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bo YU <tsu.yubo@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Message-ID: <20190403145609.6eda97b6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gxB=TXMfBxrY66HzfwAUM+9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gxB=TXMfBxrY66HzfwAUM+9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  drivers/misc/fastrpc.c

between commit:

  01b76c32e3f3 ("misc: fastrpc: add checked value for dma_set_mask")

from the char-misc.current tree and commit:

  977e6c8d1d18 ("misc: fastrpc: use correct spinlock variant")

from the char-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/misc/fastrpc.c
index 36d0d5c9cfba,c4cc8e53243d..000000000000
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@@ -1184,7 -1314,7 +1314,8 @@@ static int fastrpc_cb_probe(struct plat
  	struct fastrpc_session_ctx *sess;
  	struct device *dev =3D &pdev->dev;
  	int i, sessions =3D 0;
 +	int rc;
+ 	unsigned long flags;
 =20
  	cctx =3D dev_get_drvdata(dev->parent);
  	if (!cctx)
@@@ -1213,12 -1343,8 +1344,12 @@@
  		}
  	}
  	cctx->sesscount++;
- 	spin_unlock(&cctx->lock);
+ 	spin_unlock_irqrestore(&cctx->lock, flags);
 -	dma_set_mask(dev, DMA_BIT_MASK(32));
 +	rc =3D dma_set_mask(dev, DMA_BIT_MASK(32));
 +	if (rc) {
 +		dev_err(dev, "32-bit DMA enable failed\n");
 +		return rc;
 +	}
 =20
  	return 0;
  }

--Sig_/gxB=TXMfBxrY66HzfwAUM+9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlykLtkACgkQAVBC80lX
0GyKbwf9ErnX9S9iWSwFKLKN1YP9PUcc+x1F8fi7P6yYSRo57abnbzak42lY2FiF
oRFJtyoScgTDcT9MAEH3krTrd+kMuH9jnxrY02tgJKvwARdnl7DSg9NgsmuT5xEC
NKf593+S0/O9Ci0EBblKs9qeoMUqa9omRD3H9i29JSkBrge5bqL8X31mECnMrrYE
Vvos26+JDiV394tFlWuYcrzPEEBSmXC8ZXC+axFWYgQ4T9o5PZzcGfO7GDkEYGqO
kMMqP1VLsYS4CC5QQQrtEYoN/L7d58iJeQHTTVBYyNmD/HtdH+uVHZ8/q2cDZYZA
UXCAjlDwy5kVIIVOOnt7s5yn/FlLag==
=iI9P
-----END PGP SIGNATURE-----

--Sig_/gxB=TXMfBxrY66HzfwAUM+9--
