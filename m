Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBC4C4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55C8205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cp3t67y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfFYAMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:12:48 -0400
Received: from ozlabs.org ([203.11.71.1]:34719 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbfFYAMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:12:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Xmnl2h1kz9s8m;
        Tue, 25 Jun 2019 10:12:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561421565;
        bh=RF29SwNLX4Zp9qVZfkr5djvyTLxzcCy+4KGrM+1AKnI=;
        h=Date:From:To:Cc:Subject:From;
        b=cp3t67y8c8l/r4Jag48reE22yUnEvjnaaX6jknHDb6CUA0Pe9I6s5k/zeuIKGWvtU
         /OHxlSIXMtIWWQylErpcngefKTIbmU59oMrUBzLlUvHe4YlzdQ7fBCZlK6DWqns3n/
         65l+TfOGexQt8N9a2afBUe9vMjEm24kWUC+8f1WUu7vNp/UFx6CV5rD0fyWgBuUMVI
         Kz8KNehD8U76S4QvqDYgIdcdjmJt45hwMqPzKQwNnmPrPtLwju1STRZxcEDFi7c4lp
         ZsNOdm3n2THJwSlKKb45vt0SOeGrmiQItgi+itaPTkz7iv0louHkmiHiXRiEnO9laX
         +ldf8kOGAs8tg==
Date:   Tue, 25 Jun 2019 10:12:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: linux-next: manual merge of the tegra tree with the arm-soc tree
Message-ID: <20190625101242.2eb0e418@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j/50enT86+rbCHdAEI3eYmM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j/50enT86+rbCHdAEI3eYmM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tegra tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  39bab7bfb7d9 ("arm64: configs: Remove useless UEVENT_HELPER_PATH")

from the arm-soc tree and commit:

  01d6fb565b4a ("arm64: defconfig: Add Tegra194 PCIe driver")

from the tegra tree.

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
index 3fb84219817a,6a9dc67bbfac..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -192,6 -191,8 +192,7 @@@ CONFIG_PCIE_QCOM=3D
  CONFIG_PCIE_ARMADA_8K=3Dy
  CONFIG_PCIE_KIRIN=3Dy
  CONFIG_PCIE_HISI_STB=3Dy
+ CONFIG_PCIE_TEGRA194=3Dm
 -CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
  CONFIG_DEVTMPFS=3Dy
  CONFIG_DEVTMPFS_MOUNT=3Dy
  CONFIG_HISILICON_LPC=3Dy

--Sig_/j/50enT86+rbCHdAEI3eYmM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0RZvoACgkQAVBC80lX
0GyVIggAmVr73GQ81DwKSfIkq5h/1I8FVxzB15jIuKSJe868pBbsapfalgxBPqmN
mHU1B1F/pi+QOzHwu9g1aJOfVhSER4xGMmvRs7d3JMEvcuUqQUs9HTee24XnnUZr
m7ozG8h2o1D3tjs03ZlIJPKHv4UXZ2c+07y55UvazAUJdXBzSrBJOu6wg4LGtSxr
eLv338Tp9M/y86OhGpWw6C1ZLtQ7rgzD0kNnC8fM5ABdsKIl6/fs/XisCPqkCxj7
cL1/7DMD6lTqHUex6wPidEpH7gn8Db9TovLmcbO2bn6X54oIymb0x+3XgG9PMQ0/
b14+mH6qzYZNU9keacK+Nrm8fRThAg==
=ReDA
-----END PGP SIGNATURE-----

--Sig_/j/50enT86+rbCHdAEI3eYmM--
