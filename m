Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A503BC4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7037C206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fzQ1ADNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfFYADo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:03:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37437 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfFYADn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:03:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XmbJ1K0Cz9s3l;
        Tue, 25 Jun 2019 10:03:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561421020;
        bh=uxYIaPA9Islapamk5gE3dQb+BvPV85TXC7/AYf6Ybrw=;
        h=Date:From:To:Cc:Subject:From;
        b=fzQ1ADNOhGg2RdorKsEf1hdVUwI6MmArO7Z7j0IzEXiy/dmJs2DxkOMtDpnYBI/E8
         3Hxuaq9BpUBtN7HQvP/8nh7uK4hItmJtDCP8lzrJWxYxvdCKPmCjhdUAw8kFr4zoBL
         G+/9+Y+5Q4Fe+M1piesfl24xXnnbGEDOamfB3HuV3+SHKp46xRVe175ut6ujvlfSxt
         nVYSeucWeKbfvqxi9BsyjoQqwbiynBe/TeiJqZ5meNI1tnM0lQl+flVj2WMYHmvQuk
         +kPxuS46Jvo8guSCNV0orat0I1C6opIQkjEXkrfAxnoUuIBA7jlceeOgQK6yZfKFDh
         xJgqAMMCC0YJw==
Date:   Tue, 25 Jun 2019 10:03:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>
Subject: linux-next: manual merge of the samsung-krzk tree with the arm-soc
 tree
Message-ID: <20190625100339.6d7c1bd9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4YZKzyDAPHNnn/eu/Wz9c4q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4YZKzyDAPHNnn/eu/Wz9c4q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the samsung-krzk tree got a conflict in:

  arch/arm/mach-exynos/Makefile

between commit:

  3fe1ee40b2a2 ("ARM: use arch_extension directive instead of arch argument=
")

from the arm-soc tree and commit:

  24d2c73ff28b ("ARM: exynos: Only build MCPM support if used")

from the samsung-krzk tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/mach-exynos/Makefile
index 5ccf9d7e58d4,5abf3db23912..000000000000
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@@ -14,5 -14,9 +14,5 @@@ obj-$(CONFIG_PM_SLEEP)		+=3D suspend.
 =20
  obj-$(CONFIG_SMP)		+=3D platsmp.o headsmp.o
 =20
- obj-$(CONFIG_MCPM)		+=3D mcpm-exynos.o
 -plus_sec :=3D $(call as-instr,.arch_extension sec,+sec)
 -AFLAGS_exynos-smc.o		:=3D-Wa,-march=3Darmv7-a$(plus_sec)
 -AFLAGS_sleep.o			:=3D-Wa,-march=3Darmv7-a$(plus_sec)
 -
+ obj-$(CONFIG_EXYNOS_MCPM)	+=3D mcpm-exynos.o
  CFLAGS_mcpm-exynos.o		+=3D -march=3Darmv7-a

--Sig_/4YZKzyDAPHNnn/eu/Wz9c4q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0RZNsACgkQAVBC80lX
0Gzlnwf9GTpkLoUj3f/7R596jf/Jd1cry48ctgJ+Ykd28zaHeYs0U3MLbgpM8mKg
RPHDp1mnmJO1KfJQrs4Pb3j+EirGFIWzZe1IjU/86g/Ysz6n7KmUtpyw9y5D/yPk
TChuM2ycVT0vNwRntFrnHkT9AbbWqo9UUN5agkqLaRbryqGpQDdtlFXkYO7CdGRw
8d2lrDf4h94RZ1FIHjKDvOKUuHLF2Bz/TBmrq2ucMnB53VDPQtD6abCP0V9vRiGQ
Ew4FaFZWlcD4w5YcRMRRmTgZoqa8H8duGmTzhmPcwMiQ/+T8N5uyPaBESHMri3At
mpPyg0TmQVhNKtKU5qgRjc5KLeLHkQ==
=UYiD
-----END PGP SIGNATURE-----

--Sig_/4YZKzyDAPHNnn/eu/Wz9c4q--
