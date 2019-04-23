Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A1AC10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0642077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CbAmHiqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfDWBcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 21:32:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51693 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbfDWBcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 21:32:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44p5Xr5gJTz9s55;
        Tue, 23 Apr 2019 11:32:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555983149;
        bh=oopaeLIG+A8au8HD3JzLsgrKpzmK8fWtBQ4fQim6fEc=;
        h=Date:From:To:Cc:Subject:From;
        b=CbAmHiqH2HuFWu4V9QR2gBIDEz+ndJWZJdm8Vn0Y+g/0RxyMQ6curdJg2z/Y0X7hU
         ghP+OSYzccYg2ypSo4AHvDM14limnb2PV9tHvJvETz8rDCUZtAqYF+hPT8qxKX2IyJ
         tiuHCqvMOFimrfuScYGFeX4aysnZ5z5pSkXhiIRpQU5S1rgBOERGI1jFHX/aesRFxb
         dZCDDwPtr95R/GzIltEC2XW076aM5QerKrUufqje68DWabmgJwU6VKDnHBGNTX/urO
         /OY4BBrnss3D1FCXWMLb15m++NinzX1KPftr72Dl0LGstfVY+TlJwlaB75bYTEMpUY
         //in5gICE0T6w==
Date:   Tue, 23 Apr 2019 11:32:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20190423113227.3dd68989@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kWc9vZT6BWDaAW2K4bbmfho"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kWc9vZT6BWDaAW2K4bbmfho
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

net/socket.c: In function 'sock_ioctl':
net/socket.c:1173:10: warning: this statement may fall through [-Wimplicit-=
fallthrough=3D]
    err =3D sock->ops->gettstamp(sock, argp,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          cmd =3D=3D SIOCGSTAMP_OLD,
          ~~~~~~~~~~~~~~~~~~~~~~
          !IS_ENABLED(CONFIG_64BIT));
          ~~~~~~~~~~~~~~~~~~~~~~~~~~
net/socket.c:1176:3: note: here
   case SIOCGSTAMP_NEW:
   ^~~~

Introduced by commit

  0768e17073dc ("net: socket: implement 64-bit timestamps")

I get this warning because I am building with -Wimplicit-fallthrough
in attempt to catch new additions early.  The gcc warning can be turned
off by adding a /* fall through */ comment at the point the fall through
happens (assuming that the fall through is intentional).

--=20
Cheers,
Stephen Rothwell

--Sig_/kWc9vZT6BWDaAW2K4bbmfho
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+aysACgkQAVBC80lX
0Gx74Af9EQr/Jmy5vXkadUq194+lVw9iMcHP9/4UNQyzjA3UNIDyII2c42Rzr3W7
v68yLk2+vEDSDMKzBSCarV5MmK+3xaaiTfpLW3pVjThj4ogflYwMMftx+zbULNi5
oTcoSft8xUe7wBmGHYxyeop2/BfPK7R8l30BZ0+5wEajA1G1B10URuRd+RNYx8cJ
daXXoHDrTFKbNzkfnjDYK3ePm3g1agVed3ZZzjk3c28ronPMy/W8UVVQmk3aT1/B
DGEUpn2kWECStgzZaxG6XN4goWqatlODxkzHhnFnZR+rhc+FipYCHI37mU1mZFOD
esmZMxDnxzLdwhQmUvK0PPUAa1kq+Q==
=hDj1
-----END PGP SIGNATURE-----

--Sig_/kWc9vZT6BWDaAW2K4bbmfho--
