Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07354C004C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 00:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C3E2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 00:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="o4cGyJL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfEFAoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 20:44:01 -0400
Received: from ozlabs.org ([203.11.71.1]:54777 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbfEFAoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 20:44:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44y3rt3ZLdz9s5c;
        Mon,  6 May 2019 10:43:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557103438;
        bh=DYb/Fo3rjzecDmRVo0EIW0NUlwZY2ddNIQj5kmZs1zU=;
        h=Date:From:To:Cc:Subject:From;
        b=o4cGyJL1ukGbDwOItQk5jX4tjemmtFswpvQVUdeBR0g+7WnbPQIxmGOe+EIpFBpoW
         ztSFCxMdg2EMM4sYd8KacbiqbHS0tOrodoHZIB2vcAm1cjnrPawBXlQ+DT5Tl2p/DZ
         wh7oBa5LKdlRA4O/0HvosSzdpJC9soggYVptkzf9CGe4yCoW+JAicRrlUlC4/kEYuG
         6bK+ygZpW928ln3U+JIl6rp7FyL1YM0YT1EywhPMhkb5On8fSxt5jUkWx7Ouhtxekb
         FSS5qxcZnbEvXBY9wHPKmg4M40DjkN+BeJQRKDkoVWTAboickXzxZmifH76xD3zY6k
         LAO0OQqTC2NjA==
Date:   Mon, 6 May 2019 10:43:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20190506104357.18e10955@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4A5VfpcTk.9FVkm=94W1xPA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4A5VfpcTk.9FVkm=94W1xPA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the imx-mxs tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  7b0d021fbe41 ("arm64: defconfig: enable PCIE_ALTERA")

from the arm-soc tree and commit:

  a9aa2a812255 ("arm64: defconfig: Enable CONFIG_SPI_IMX")

from the imx-mxs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/configs/defconfig
index 5392c12ef3b7,979a95c915b6..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -357,7 -365,7 +358,8 @@@ CONFIG_SPI=3D
  CONFIG_SPI_ARMADA_3700=3Dy
  CONFIG_SPI_BCM2835=3Dm
  CONFIG_SPI_BCM2835AUX=3Dm
+ CONFIG_SPI_IMX=3Dm
 +CONFIG_SPI_NXP_FLEXSPI=3Dy
  CONFIG_SPI_MESON_SPICC=3Dm
  CONFIG_SPI_MESON_SPIFC=3Dm
  CONFIG_SPI_ORION=3Dy

--Sig_/4A5VfpcTk.9FVkm=94W1xPA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzPg00ACgkQAVBC80lX
0GzWQAf+IyIw7MKo75hxmAy5MsACq8sprZgHHDKKUik/Jdxj9t8Z/Ji47L8c6tEA
v4OyB5zWxmAUL6D03p19K/xTKSCoBtTCb/LOOl1w+Z0PP5FAuu/ySAdz9OuVp88V
mSfL9OJmTpsvoISDzXnY51TWGUGWe7yXQ0cvI2OSkocPQrRlwvPT2ppYIsx/TFtp
iQRUC7RzBFMLAbJbAok/tBQ8pYSsnty3bzKHeNLAibTi0BkKx89pkOz7DbHtl/ti
fOJqdZvtZJRVuA83ZkvInRrCdGbKyYu0wxepZhI4B2nxXl96ElQR0t89EZC0z1Rl
9Jyul/AKnX00dB9VOcuZxsTgvZW1TA==
=aEht
-----END PGP SIGNATURE-----

--Sig_/4A5VfpcTk.9FVkm=94W1xPA--
