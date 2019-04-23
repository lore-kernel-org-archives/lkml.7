Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4085C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C285120449
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="J55KO8AR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfDWXbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:31:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44595 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfDWXbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:31:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pfpy3FDXz9s55;
        Wed, 24 Apr 2019 09:31:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556062299;
        bh=qyyDPmBiPSqeiEIc6GrgoOJM3kVmnM4p6j5larPx4N0=;
        h=Date:From:To:Cc:Subject:From;
        b=J55KO8ARXxy8Uu5HxuurqDGOrAY9CKCWhC/IKnXHKkYoCBput4kaGa0Haf/PMDyIH
         VCRclpaYB2cF0Rb+JPFAOvKjp6U9Nyx402WCZcnG6GVBzknKN0mEAeRua1TGYi30uW
         jTD77HwXLXo46uJvSE0k4kjt8V5DiOINXEENFlyuLqaCLVo8qkCkFgnMiJMb0/KD7T
         RXcsTIzjBNkEBeUyGpBVaS8fuPwoKN2TsrGR7eF/NX/R/LKJaiZgM3Wz+c44NW85PP
         3Q0mTBqswSFrvzcDrM7Jy8PHU6asG0+WxuGh9ZNdoyXjGjScl9jKPohFK5WWYVUmEm
         RGoRgZt1EECwQ==
Date:   Wed, 24 Apr 2019 09:31:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: linux-next: manual merge of the rockchip tree with the amlogic tree
Message-ID: <20190424093137.241407fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/atGx+6m8WlmrfbYda2zvk7q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/atGx+6m8WlmrfbYda2zvk7q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rockchip tree got a conflict in:

  arch/arm/configs/multi_v7_defconfig

between commit:

  029da5e5266c ("ARM: multi_v7_defconfig: enable the Amlogic Meson ADC and =
eFuse drivers")

from the amlogic tree and commit:

  366391f04177 ("ARM: multi_v7_defconfig: Enable missing drivers for suppor=
ted Chromebooks")

from the rockchip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/configs/multi_v7_defconfig
index 1fd4b8fcce2e,d160ac4bad21..000000000000
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@@ -984,7 -989,7 +994,8 @@@ CONFIG_PHY_UNIPHIER_USB2=3D
  CONFIG_OMAP_USB2=3Dy
  CONFIG_TI_PIPE3=3Dy
  CONFIG_TWL4030_USB=3Dm
 +CONFIG_MESON_MX_EFUSE=3Dm
+ CONFIG_ROCKCHIP_EFUSE=3Dm
  CONFIG_NVMEM_IMX_OCOTP=3Dy
  CONFIG_NVMEM_SUNXI_SID=3Dy
  CONFIG_NVMEM_VF610_OCOTP=3Dy

--Sig_/atGx+6m8WlmrfbYda2zvk7q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/oFkACgkQAVBC80lX
0GyW5gf8D0GjQLjDCeC/nhESyvTmBIJ/wHVMtSbyCOlXWeIw4lmBKm8G5V7W89aM
+qbuiWPBIIJlvzaQSAmJxAbWvsoTJaeQ8fS7+O6wUa5FaW4lOOLqx1cDArquFxBf
5suwz1g/gKRJdcCGiFx1P6blwiK4NcgBCAjd1V5+RF01xBSINJew3Z+MY09aJKWY
9F4CUMG0lFjJ3CpRcPnDwIKHPmHyVN/KX/eXzGSRUBTARWcIQ8zUnx95B7mUffL+
8GZp2wcswn/9i5bpW4zw/Z6mH0j9ISA0qg/w4hO19hsAkthcs3SgG4+WKZDSbOLb
yLR+gcTy+5UwwDBFrSMyYIuf6PFOuA==
=W1vu
-----END PGP SIGNATURE-----

--Sig_/atGx+6m8WlmrfbYda2zvk7q--
