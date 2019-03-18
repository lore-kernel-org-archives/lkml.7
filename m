Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68286C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C4C20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q3s//JOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfCRAwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:52:16 -0400
Received: from ozlabs.org ([203.11.71.1]:35645 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfCRAwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 20:52:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44MyM11DtMz9s6w;
        Mon, 18 Mar 2019 11:52:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552870333;
        bh=Y+2Sv1UFPTzMCHzlU3ziXlO6vm4Tn6et3XjHKjERJFo=;
        h=Date:From:To:Cc:Subject:From;
        b=Q3s//JOhgJ5IP8gh1o6lfwUAq9ujg1yJXsNX5Wpx6tWTQRkgVgcceaTyEuidlW2Sv
         kjmrlBcjDEMHbhK783ib2AGI91tI6wqyMVN4S1O/s3Et8+gOKdPswL1f2D85a13gs+
         EyIzgqvttYO278OMoKU5F8wV31c7W3Pf4tcl4xl7ZoDfvCLTLuFBX8eMYWlke+bahg
         CAuUnMH/CGHUkODxka4/PVAbOWoe96YYpVmZqmO+WoknDUlJKra09wazaUr4HtSw0m
         dvnemQbI3AhLcRSEaacim+Kxn7K0vYw5zub8cdC5UoKZHRTtNXB9vNFwkZ1g3/jRla
         OQlVY1g5oTvAA==
Date:   Mon, 18 Mar 2019 11:52:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Walker <dwalker@fifo99.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: linux-next: manual merge of the cisco tree with Linus' tree
Message-ID: <20190318115212.4366cba6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UDxm_gPL_/+mDSzZrjY/C=5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UDxm_gPL_/+mDSzZrjY/C=5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cisco tree got a conflict in:

  arch/powerpc/configs/skiroot_defconfig

between commit:

  805bf3b75529 ("powerpc/configs: Sync skiroot defconfig")

from Linus' tree and commit:

  5d4514a9c291 ("powerpc: convert config files to generic cmdline")

from the cisco tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/configs/skiroot_defconfig
index 5ba131c30f6b,bf31334efbce..000000000000
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@@ -48,14 -40,22 +43,26 @@@ CONFIG_HZ_100=3D
  CONFIG_KEXEC=3Dy
  CONFIG_IRQ_ALL_CPUS=3Dy
  CONFIG_NUMA=3Dy
 +# CONFIG_COMPACTION is not set
 +# CONFIG_MIGRATION is not set
  CONFIG_PPC_64K_PAGES=3Dy
  CONFIG_SCHED_SMT=3Dy
 +CONFIG_CMDLINE_BOOL=3Dy
- CONFIG_CMDLINE=3D"console=3Dtty0 console=3Dhvc0 ipr.fast_reboot=3D1 quiet"
++CONFIG_CMDLINE_PREPEND=3D"console=3Dtty0 console=3Dhvc0 ipr.fast_reboot=
=3D1 quiet"
  # CONFIG_SECCOMP is not set
  # CONFIG_PPC_MEM_KEYS is not set
+ CONFIG_JUMP_LABEL=3Dy
+ CONFIG_STRICT_KERNEL_RWX=3Dy
+ CONFIG_MODULES=3Dy
+ CONFIG_MODULE_UNLOAD=3Dy
+ CONFIG_MODULE_SIG=3Dy
+ CONFIG_MODULE_SIG_FORCE=3Dy
+ CONFIG_MODULE_SIG_SHA512=3Dy
+ CONFIG_PARTITION_ADVANCED=3Dy
+ # CONFIG_IOSCHED_DEADLINE is not set
+ # CONFIG_COMPACTION is not set
+ # CONFIG_MIGRATION is not set
+ # CONFIG_BOUNCE is not set
  CONFIG_NET=3Dy
  CONFIG_PACKET=3Dy
  CONFIG_UNIX=3Dy
@@@ -164,9 -159,9 +170,10 @@@ CONFIG_MLX4_EN=3D
  # CONFIG_MLX4_CORE_GEN2 is not set
  CONFIG_MLX5_CORE=3Dm
  # CONFIG_NET_VENDOR_MICREL is not set
 +# CONFIG_NET_VENDOR_MICROSEMI is not set
  CONFIG_MYRI10GE=3Dm
  # CONFIG_NET_VENDOR_NATSEMI is not set
+ CONFIG_S2IO=3Dm
  # CONFIG_NET_VENDOR_NETRONOME is not set
  # CONFIG_NET_VENDOR_NI is not set
  # CONFIG_NET_VENDOR_NVIDIA is not set

--Sig_/UDxm_gPL_/+mDSzZrjY/C=5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyO67wACgkQAVBC80lX
0GxDWQgAimEZUBsc6tPc1R+N5rDTy61f1EIQ438+iJ9DKKBeA+ypdw82+sH2GW1l
9GxZrNThvcBk2IpHfi+m/O5pxybsLo2iwi1Yja8is5cajYnK4B7WEChl8sueZLO1
14u3phSkBx3JvXTHANBiSc97PB147xsrzriqX+7x+e2wpRgO/G7dZygEb+U1aoMR
TGSCD/4d7OvRfQI6wjW55Os138JTJdW1Bxz55kzLul/djepKX1KV/A/dB+dbvYna
hDZsdieQA+uOb5rgX95VLYL7cvYcuNkdFRNz3zoIjyPOovYxWkWTm5yNHH8Qz5Jd
apfPlYoQ23owP6gnqnHdWjxr0kNClg==
=in6C
-----END PGP SIGNATURE-----

--Sig_/UDxm_gPL_/+mDSzZrjY/C=5--
