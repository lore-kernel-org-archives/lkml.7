Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D631BC28EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 23:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDE1206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 23:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L3+4xlHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfFFXGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 19:06:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfFFXGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 19:06:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Kh9J1MNJz9s7h;
        Fri,  7 Jun 2019 09:06:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559862373;
        bh=pLn2a/qW8IdhhMvswPDoSSBPx38lhu9GUG7Gp8C0eWM=;
        h=Date:From:To:Cc:Subject:From;
        b=L3+4xlHFrYI5lg8BiLW3lssC2pO0jQZa0fR4wIEHc2D++7DCuMmYC1AslPXKMNMv4
         2IrSWPF7uTH0gq5x9BRIlf1T5w9in3bdDEF1qgDYP1iusgx//wnSVyayosKSsa/U2q
         O4CrNSBQkIt9pSZWMOee9s+iQJdwUAJssZtPk57tAntrd9ZJJbtPOBYRX5nMI4SJir
         OrEy8IeEKfjOR4hM5FUEMjqwN9VWRdy+hWko24C2+B6HeLVDcoAWf+ibV/mWWKNY7t
         nXdUK1T4j1WLfzJNYlDVXPOmYyijLkKJRrAWgbb1HhbbJgcn2xX/vobZDPiFChEcmr
         m9GGccMIsxhJA==
Date:   Fri, 7 Jun 2019 09:06:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: linux-next: manual merge of the sunxi tree with the imx-xms tree
Message-ID: <20190607090606.75fd6e85@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JYebIKNd66KgcYw8U3+oRV/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JYebIKNd66KgcYw8U3+oRV/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sunxi tree got a conflict in:

  arch/arm64/configs/defconfig

between commits:

  0a64ef2d28d1 ("arm64: defconfig: NVMEM_IMX_OCOTP=3Dy for imx8m")
  c6b1ccce88ae ("defconfig: arm64: enable i.MX8 SCU octop driver")

from the imx-xms tree and commit:

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
index fa5752a950eb,0dc34e0d4cbc..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -426,8 -420,8 +426,9 @@@ CONFIG_UNIPHIER_THERMAL=3D
  CONFIG_WATCHDOG=3Dy
  CONFIG_ARM_SP805_WATCHDOG=3Dy
  CONFIG_S3C2410_WATCHDOG=3Dy
+ CONFIG_SUNXI_WATCHDOG=3Dm
  CONFIG_IMX2_WDT=3Dy
 +CONFIG_IMX_SC_WDT=3Dm
  CONFIG_MESON_GXBB_WATCHDOG=3Dm
  CONFIG_MESON_WATCHDOG=3Dm
  CONFIG_RENESAS_WDT=3Dy
@@@ -757,8 -742,7 +758,9 @@@ CONFIG_PHY_TEGRA_XUSB=3D
  CONFIG_HISI_PMU=3Dy
  CONFIG_QCOM_L2_PMU=3Dy
  CONFIG_QCOM_L3_PMU=3Dy
 +CONFIG_NVMEM_IMX_OCOTP=3Dy
 +CONFIG_NVMEM_IMX_OCOTP_SCU=3Dy
+ CONFIG_NVMEM_SUNXI_SID=3Dy
  CONFIG_QCOM_QFPROM=3Dy
  CONFIG_ROCKCHIP_EFUSE=3Dy
  CONFIG_UNIPHIER_EFUSE=3Dy

--Sig_/JYebIKNd66KgcYw8U3+oRV/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz5nF4ACgkQAVBC80lX
0Gymagf/TJX0zbjTN+3mkVwUolL4X25gDXnE5kOTjese1KsQTve0hXl7zmTfSfCS
7c7IrcdTVyIiSJVEbV0XstsM9gRXQB0SJ0n8maAxV2efC3xT0j+p8X0hjX1Y+Tdm
KZwtfmUpRF4RydEpQ5oVPvuSUWcflevTrZoLMKuYjjGZcsMQjfURBHX2smDnCRlY
ladjjq6ew/htBgwXjSgILj56nDW/GN6eadmY4WhXkCs1TTNCXkK2xDbDz9D97TDw
aR+Dw8YJAd3opm6xa6bPuq+JE5EIDSGs08R7PnIDJWRazEz55tSK/ujfMgpwyaMm
uBNROA758bKOJcYUqQw02YC4K8ML/A==
=+iG3
-----END PGP SIGNATURE-----

--Sig_/JYebIKNd66KgcYw8U3+oRV/--
