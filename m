Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BEDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0162084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eMTreho7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfB1WLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:11:01 -0500
Received: from ozlabs.org ([203.11.71.1]:44021 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbfB1WLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:11:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 449RZl1qNrz9s21;
        Fri,  1 Mar 2019 09:10:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551391857;
        bh=JfhMBRYTeiYsngjhcj/mj4LC3XudjTO9u5KUgjYOuFY=;
        h=Date:From:To:Cc:Subject:From;
        b=eMTreho7AZjveAZj+eyfLHKAhqgHx5Q5kzAvMEHmnde5xYmKT1eitgIIXy3cGfYSN
         KeDczTj7M2pwNziQqtXna4DKMMxU0lhZRKvcLSY8V7m9agFHPArzL6xK5/KK+86Rvp
         a4V5YgLF3RDuWxPxDbPsLCRQ5tW3cFf/tdm+R0+a6hnGxpcYKszdGMc9zzwsxTil4l
         l0gZTUZKzMkkyy83cbEJS8/zXfsbgHEinvHdMc5sb72H+aYHxYaZZaU/9am56p2sEo
         CP9H9vRtc7OsAs2Zxd77NrFDkR2fLfU5UCJI04YS3fxVe11A7CB6u3Yh3assLNozU2
         H7VMTVWj4TedQ==
Date:   Fri, 1 Mar 2019 09:10:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: linux-next: manual merge of the arm-soc tree with the arm64 tree
Message-ID: <20190301091036.3e97bb49@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lVj6wEX+FD+wCcNo7a/JAd4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lVj6wEX+FD+wCcNo7a/JAd4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm64/Kconfig.platforms

between commit:

  a29c78234942 ("arm64: Kconfig.platforms: fix warning unmet direct depende=
ncies")

from the arm64 tree and commits:

  67b9282387c5 ("arm64: imx8mq: select GPCv2 irqchip driver")
  84a2ab25b12d ("arm64: imx8mq: select PM support")

from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/Kconfig.platforms
index d4faca775d9c,c5f6a57f16b8..000000000000
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@@ -145,7 -151,11 +151,11 @@@ config ARCH_MVEB
  config ARCH_MXC
  	bool "ARMv8 based NXP i.MX SoC family"
  	select ARM64_ERRATUM_843419
 -	select ARM64_ERRATUM_845719
 +	select ARM64_ERRATUM_845719 if COMPAT
+ 	select IMX_GPCV2
+ 	select IMX_GPCV2_PM_DOMAINS
+ 	select PM
+ 	select PM_GENERIC_DOMAINS
  	help
  	  This enables support for the ARMv8 based SoCs in the
  	  NXP i.MX family.

--Sig_/lVj6wEX+FD+wCcNo7a/JAd4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx4XFwACgkQAVBC80lX
0Gznfgf8DIjovuZDGFZh8hmY2fdHQaQlzKcNA5XA8IkH1VgWOiUJ/jC1S7LrMdfK
zaAnMCoSrzrie9q0DTdzmXWGNJ1DWoGaz2oueMSdsM/BLaGMJl6c6pCGSEyBaQmI
1Qm9R+RDv0XT+4zZwUDXb16zJeuMSEj+wsIohh9Y03RVDbwEn/FYZWxRLqB8IgWs
LNoaMajIk6m5zUTOAJ9NpG1xG8n4eSW2Hj2xqVILF/TRhtdDC5jD6qf+TqZ1/pzT
gAU33Q+HKpS6WF5OopqZlqmzGG3+xQSjG+aj3cxQoO+xu0Hj7rVuxXZ3lOtai+iG
2X0iX+vV4EkEXke6vTtkc7AiV2jXvg==
=p2P5
-----END PGP SIGNATURE-----

--Sig_/lVj6wEX+FD+wCcNo7a/JAd4--
