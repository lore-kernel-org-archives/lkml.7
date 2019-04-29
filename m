Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170E6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A2E217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nAG4llwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfD2Xt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 19:49:26 -0400
Received: from ozlabs.org ([203.11.71.1]:54069 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbfD2Xt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:49:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tLwg6Ft6z9s3Z;
        Tue, 30 Apr 2019 09:49:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556581763;
        bh=AmGnZ5frKGr/a9AEnQOUBXUPKwzH9/aZh2OD0hC2sjk=;
        h=Date:From:To:Cc:Subject:From;
        b=nAG4llwXRsZFMd7XGZZ2auR/BHLZSot9ddHphGAHtaXzS2tCSaM2vbBIKmCvnmHSK
         Nr5c9OiCrqAzxBkfs4GaW9D5Khx1tPZmNhbVQUA7HYJcRx3LDZGikL+3sw1KuCg0JY
         PVL2hS9EELtsq8TkufQuq+QBrPpV2xQCtwCCJ09FMGtRNST2yQmzXxk0CMsTja3vu9
         zwhrDZfsN0BjMH9f5upJ5mQMSDVDna8hBE8I7QtUL8gBnksMX74GRgAhN5i1WZt+6D
         w1LFHAF7dkbed6hnuMyFFaJT/3YTC166cnBeMOrPk3zhaBLOd7kSlS+wiJC0gAOBzI
         QUesxSvbv5kqA==
Date:   Tue, 30 Apr 2019 09:49:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20190430094923.10e3be32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Iw_hvswPpXbdgI0hpBQL2t2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Iw_hvswPpXbdgI0hpBQL2t2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  7b0d021fbe41 ("arm64: defconfig: enable PCIE_ALTERA")

from the arm-soc tree and commit:

  2b4fd225df89 ("arm64: defconfig: Enable CONFIG_SPI_IMX")

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
index 5392c12ef3b7,eb31c20e9914..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -357,7 -365,7 +358,8 @@@ CONFIG_SPI=3D
  CONFIG_SPI_ARMADA_3700=3Dy
  CONFIG_SPI_BCM2835=3Dm
  CONFIG_SPI_BCM2835AUX=3Dm
 +CONFIG_SPI_NXP_FLEXSPI=3Dy
+ CONFIG_SPI_IMX=3Dy
  CONFIG_SPI_MESON_SPICC=3Dm
  CONFIG_SPI_MESON_SPIFC=3Dm
  CONFIG_SPI_ORION=3Dy

--Sig_/Iw_hvswPpXbdgI0hpBQL2t2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzHjYMACgkQAVBC80lX
0GxmfAgAno8fSN5vL9ATAuhtSUMt2B01kxbRiVjVC235N2aFwLRx3mvgQqoyPzW4
XVB5OPdHOcHW+fIM/pIQ2G85MqBph0KpQWhfYOoIIMNc9Ct5NkxSkLwtzPBhGddy
js+lV+iAt1fYRDOO8cKHUMznrYct7QkrGD+ToUf/kMCqCbfmEY6Jsxmk3Hw4nquO
WBgexu3qBJcxvQK7vwBrqSuoVkKTTJ7e/uZc1IFNYhDuZiGzLZO2ByLfkONiQ6/F
wqdqdLABU7htcBgAiQRxcca3PRWBpOovTfuvBfuYCxPgp3CFauNkV7KU5Oj3NoNZ
Ocj3qmNWhJ6fLm4xToHcMcXOv9q6Vw==
=QgVM
-----END PGP SIGNATURE-----

--Sig_/Iw_hvswPpXbdgI0hpBQL2t2--
