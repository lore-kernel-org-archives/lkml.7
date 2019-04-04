Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05425C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3542082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dDghTr1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDDCdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:33:39 -0400
Received: from ozlabs.org ([203.11.71.1]:53605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDDCdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:33:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44ZRp66N9Rz9sSW;
        Thu,  4 Apr 2019 13:33:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554345216;
        bh=gBGpPY53adum+ySqcQg91tpyKBMB7s+oko9+jpuDpzo=;
        h=Date:From:To:Cc:Subject:From;
        b=dDghTr1KnzQFDbQmWN3QEuT9HjkHtU0uVNEwsvqzE9JKEzLHf5SawfES2ZcbDxM1Z
         hG4IidYni+wywB7o4uQ+oCy7kpL71W6n8jLvXPe2eZxCbQgpclxDGylh3V36OgDxBz
         jQ+x2U0+IsHZNFT43gzccN0TJMvRGmugqwyzYa7iL9GefjyPbTIhddoixluTDrXRNm
         aFKMOV7grdSqU/7U4gssGKjz9FVUdtjsDWd6fW65sSWJFCwat8J5etnOsgqUlXofl8
         OImkbIRuNYv9QSJy834B2swTRMBh6hp8R7XsdEyF7sGzGzUXD5jxtMGj9NkjFx+C7r
         eBCT9QHo9BowA==
Date:   Thu, 4 Apr 2019 13:33:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Stefan Roese <sr@denx.de>
Subject: linux-next: manual merge of the staging tree with the spi tree
Message-ID: <20190404133317.56500903@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AqdhqQ7YcD9z6.=F1JwP81R"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AqdhqQ7YcD9z6.=F1JwP81R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/spi/spi-mt7621.c

between commit:

  cbd66c626e16 ("spi: mt7621: Move SPI driver out of staging")

from the spi tree and commit:

  18f0e249da67 ("staging: mt7621-spi: Remove parentheses")

from the staging tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/spi/spi-mt7621.c
index ae836114ee3d,0e0e67280b00..000000000000
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@@ -305,8 -301,8 +303,8 @@@ static int mt7621_spi_setup(struct spi_
  	struct mt7621_spi *rs =3D spidev_to_mt7621_spi(spi);
 =20
  	if ((spi->max_speed_hz =3D=3D 0) ||
 -		(spi->max_speed_hz > (rs->sys_freq / 2)))
 +	    (spi->max_speed_hz > (rs->sys_freq / 2)))
- 		spi->max_speed_hz =3D (rs->sys_freq / 2);
+ 		spi->max_speed_hz =3D rs->sys_freq / 2;
 =20
  	if (spi->max_speed_hz < (rs->sys_freq / 4097)) {
  		dev_err(&spi->dev, "setup: requested speed is too low %d Hz\n",

--Sig_/AqdhqQ7YcD9z6.=F1JwP81R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlylbO0ACgkQAVBC80lX
0Gx6Igf+K2YKTdU37c54sj8H7yIHR+NLJGaQWmWw0Nh4eEYs8dhI4RlT3znViScu
V3GEOo1xJXOtTuN61IlPwFMnIHiUdpCFqid9bjf3IC6b9eM33JhCNf7oVSZSCW/P
Sbky67qdms3cNPyLogcTuDpy+0L1ZO5X5zRNRXB7fxEQ+MUZqzNoZ6bfCsiVC8KL
5DnmC+lKsxS0aVKNZWgi3xnRDCoZKwlT1Oxw4Wxp8XQCQ5Y5Y5GLTwYh1l++7m3i
kNJnDBfa8IuPAic5rtO5b4Zv/BVmE9IkNN6KgOQkl5lhD7Mdwz0Mo6f1xpAqqJ1y
b3CpMnwsJn5IjpvlaqlZrnPP4FKm/Q==
=mtkn
-----END PGP SIGNATURE-----

--Sig_/AqdhqQ7YcD9z6.=F1JwP81R--
