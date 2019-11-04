Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DDACA9ED4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD75620869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qCZfwWIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfKDWj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:39:29 -0500
Received: from ozlabs.org ([203.11.71.1]:41755 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729701AbfKDWj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:39:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 476SQk0J3jz9s4Y;
        Tue,  5 Nov 2019 09:39:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1572907166;
        bh=9oLJgy9YhD2/uxYf9HCCJm4CgrXLkCKAqUiXoi7Lzm0=;
        h=Date:From:To:Cc:Subject:From;
        b=qCZfwWIeGg949YF6o72C31LNMDkkKUwtcNqN0j08fNYuzB8MHGKlEqt81xEtP/0Cl
         x348o6g69/g+bLLm/5aExm0eWwK9p6oLaALBeQEsorkv7ssimIaKRSjb2N42v/uGZa
         CigtPL0tZeX5ujIFCApkB8YTTYqFgbqPwiSXkUSgqOQZl8/8T+6Wf6RK65Rd3/lx6x
         qf9973MdWppY+BRsqHewyMHrlv2pLMkrD/35CTHpjrM/F/QBiejfVuWeRG1lS4d5R7
         nIognTgoS2osyNNHgQnk+DnamR5ls4JtR/FfDrB6LpZ4paYbKztHJOnhyEqh/U7pBP
         gNWdDRx/QIJ6g==
Date:   Tue, 5 Nov 2019 09:39:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: linux-next: manual merge of the qcom tree with the arm-soc tree
Message-ID: <20191105093920.7869c1eb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N.KP0oVduH6feDqNG=/N3Wb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N.KP0oVduH6feDqNG=/N3Wb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the qcom tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  af24cb20689d ("arm64: defconfig: Enable HiSilicon ZIP controller")

from the arm-soc tree and commit:

  ca1561a3d8e4 ("arm64: defconfig: Enable Qualcomm pseudo rng")

from the qcom tree.

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
index d3a289e12c92,0de751801c98..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -750,8 -749,8 +759,9 @@@ CONFIG_QCOM_SMEM=3D
  CONFIG_QCOM_SMD_RPM=3Dy
  CONFIG_QCOM_SMP2P=3Dy
  CONFIG_QCOM_SMSM=3Dy
+ CONFIG_QCOM_SOCINFO=3Dm
  CONFIG_ARCH_R8A774A1=3Dy
 +CONFIG_ARCH_R8A774B1=3Dy
  CONFIG_ARCH_R8A774C0=3Dy
  CONFIG_ARCH_R8A7795=3Dy
  CONFIG_ARCH_R8A7796=3Dy
@@@ -861,7 -860,8 +873,9 @@@ CONFIG_NLS_ISO8859_1=3D
  CONFIG_SECURITY=3Dy
  CONFIG_CRYPTO_ECHAINIV=3Dy
  CONFIG_CRYPTO_ANSI_CPRNG=3Dy
 +CONFIG_CRYPTO_DEV_HISI_ZIP=3Dm
+ CONFIG_CRYPTO_USER_API_RNG=3Dm
+ CONFIG_CRYPTO_DEV_QCOM_RNG=3Dm
  CONFIG_DMA_CMA=3Dy
  CONFIG_CMA_SIZE_MBYTES=3D32
  CONFIG_PRINTK_TIME=3Dy

--Sig_/N.KP0oVduH6feDqNG=/N3Wb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3AqJgACgkQAVBC80lX
0GzN9gf/ZVgW42+vigalmlsEuJfUi4o5+3pp/xfkPhZCycQypHIZnNKwPQ/pZT5N
Jf5jpxWHLXA+ScZSF53P1mJtFq9Xwty4wIC0qDgworyfy69F+PPBky3nSnkUVv6I
CSdufLshzxmJd5TCMzagS1WXY96t3Qkwo9FRkMTzpaS1Y/K0wYF3hr7Rj2wYBhgy
wneGoCMNp/DtgzkWrMuC+hJIJHyBfFh8x1zhkbvNdMn9eyqTHE1oPeXPDVcP7bBF
CuxO+/26ppYpkzmIJamWJZkHo9P3KO9cCIgdGNF/0uNvSMxl9aBm53Yxw7iDOhed
QJ4IrHVT1ATczepnbej766XETAwgMQ==
=QRTI
-----END PGP SIGNATURE-----

--Sig_/N.KP0oVduH6feDqNG=/N3Wb--
