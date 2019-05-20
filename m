Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA6BC46470
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3272D2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mKU0+nJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfETXSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:18:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45225 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfETXSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:18:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457FFh4GMdz9s55;
        Tue, 21 May 2019 09:18:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558394329;
        bh=JYol2MzGdH9WwO5vYX2Xr7O0c8+WxkYebEOnFkhaYzk=;
        h=Date:From:To:Cc:Subject:From;
        b=mKU0+nJk4Snis4KoTcoYVl0vW/KC+Yb/TQRYbntq/QfkisQbIItSYTV9WKnKrPDrO
         vzGzVjHTv67bMdA5ht92m1UbMxQX1GZxb6bnsLHSOD+bztgyDa5R6E1JL0zYrI18UR
         ncm/+aXcnI+3tcbQFK5FJ5AVtrykqh0UIio9g3183NlGK+QejwohJF6fKk2bkFKfUD
         37qqmr4g4pmIz9lKgR+RMAySfYM+Pzo+vLSvPpZcvdBA+w20/JULb6COPbGFsKIq+B
         ekDduyVsexUKyYHV1CxtmvW18gE1C9V5iX1isxRCOfoj0EJ8Jv5KKfTBcYhOSq+sXX
         ndDCQvr92lvdg==
Date:   Tue, 21 May 2019 09:18:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: linux-next: manual merge of the sunxi tree with the imx-mxs tree
Message-ID: <20190521091830.25a6cc27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qOlJ1zMtDwGZkVziBHNfKg3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qOlJ1zMtDwGZkVziBHNfKg3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sunxi tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  4aaa1c7a05db ("arm64: defconfig: NVMEM_IMX_OCOTP=3Dy for imx8m")

from the imx-mxs tree and commit:

  296bcfa05640 ("arm64: defconfig: add allwinner sid support")

from the sunxi tree.

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
index 33fac4e62a16,f981a882c546..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -762,7 -741,7 +762,8 @@@ CONFIG_PHY_TEGRA_XUSB=3D
  CONFIG_HISI_PMU=3Dy
  CONFIG_QCOM_L2_PMU=3Dy
  CONFIG_QCOM_L3_PMU=3Dy
 +CONFIG_NVMEM_IMX_OCOTP=3Dy
+ CONFIG_NVMEM_SUNXI_SID=3Dy
  CONFIG_QCOM_QFPROM=3Dy
  CONFIG_ROCKCHIP_EFUSE=3Dy
  CONFIG_UNIPHIER_EFUSE=3Dy

--Sig_/qOlJ1zMtDwGZkVziBHNfKg3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzjNcYACgkQAVBC80lX
0Gz0Kwf9GQoooOHnEQBjKHSRnhPfmUaeVynYsAbKyrvfOZtRhDMf8lSGAdZxErpT
ULA4PyA+Dgs36+Px4/U+4tKk4mF7xXVpfwPm2oSmu4yVz+C89JkbP8W6Mkke5rgz
rUk4FvZyC3FcpbTaDenv8e/W27HAc7vOkjUvF2VDludd0AH/Z0dVtZ0gBXFf7W3g
B46zH/xdPwjrTTlsyH0zbE2p6fVizGY8ySIPyIwX2aADeKScJ6rFlt/9wTOiiFm2
Dr9i00HuEXVtZbgkikxfcku9GWcaVJgGX/xI7Im37Q/dOleyM9JqWvaSGl9qHL2X
aqLCaoNlBAXpk5XMKS7N08v+sKc0+Q==
=jz9e
-----END PGP SIGNATURE-----

--Sig_/qOlJ1zMtDwGZkVziBHNfKg3--
