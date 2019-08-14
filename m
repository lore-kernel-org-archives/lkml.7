Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD46C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F29D2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eMqTOudp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfHNGIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:08:44 -0400
Received: from ozlabs.org ([203.11.71.1]:32841 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfHNGIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:08:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 467fKN60qpz9sDQ;
        Wed, 14 Aug 2019 16:08:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565762921;
        bh=HI//54gDnkRWE5izXUq7EkVdHYUA9kytY50PGDkbhMM=;
        h=Date:From:To:Cc:Subject:From;
        b=eMqTOudpTZOKxZIGLwLxKFYmj+D2zSxuP6OMEWTtmLfl/4x9BatBe38BAqHc21W6e
         aQeGV0X7uIy9JKi+Y/xnjmFrXqftJ5AlqbNPisyerBvgvwZII1zO8gxHarRdt7Q0WN
         BBp/efJEHu+Vf1Zm43y6+uLFbGHoqxgmm8hySUF968szHmtTWAv3aZ31OT2Wv2OPZK
         6NGRQgCsf0FTBc40TLpx+iYYiHz6XZ3dztpNOlGq82qbRUJNlSxvd6L4DVPMuY/N7c
         Ga1lf0xLiA/9W/bAkBNJjxnk4h+BuXlwevbD6J5ZO7R6f5wBR7rL4DT1YmDoH4fTcn
         gsPMkmluK5/cw==
Date:   Wed, 14 Aug 2019 16:08:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: linux-next: build warning after merge of the staging tree
Message-ID: <20190814160835.4aabb60a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ImpS2R4AWltIOhqc20o3n=8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ImpS2R4AWltIOhqc20o3n=8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the staging tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/iio/light/noa1305.c: In function 'noa1305_scale':
drivers/iio/light/noa1305.c:87:9: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
   *val2 =3D 77 * 4;
   ~~~~~~^~~~~~~~
drivers/iio/light/noa1305.c:88:2: note: here
  case NOA1305_INTEGR_TIME_200MS:
  ^~~~

Introduced by commit

  741172d18e8a ("iio: light: noa1305: Add support for NOA1305")

--=20
Cheers,
Stephen Rothwell

--Sig_/ImpS2R4AWltIOhqc20o3n=8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1TpWMACgkQAVBC80lX
0GxnwQf/flpd3sBx9QB5iWuBiTMmLX4oyZrOIi9FvTnhcq41CkkZZEsdUwEyc1Kv
o8gz4C268Y4lpbYsAls7WzxS7PYIFjy0B6U6QFaINX1djbYI2TTm+D0N5JIplO70
Tga5xpke/c95l2mQSYmepwtsvEVwDT3dhX40uBDUm+Z1ImG17YTpo+YvQSHbaY9j
QoYMB27FA2+EcCqsBHlRNWcyYyvOJCwOCtA6IhHYv+2sVio3Pb3hjup2/wTAKo6V
YVv5zdb9uqReH5uqO7Lym2AB/hOkSVhe9XF3cj9Goc8TwmrbZAZApq8BaKLJL2WG
vFy82b1rpUUduQZvm9t17wd6Kq9HJg==
=tjk3
-----END PGP SIGNATURE-----

--Sig_/ImpS2R4AWltIOhqc20o3n=8--
