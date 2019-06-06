Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762F8C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 23:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB2420B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 23:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FtwT/aVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfFFXNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 19:13:17 -0400
Received: from ozlabs.org ([203.11.71.1]:55483 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfFFXNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 19:13:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45KhKQ2MJfz9s7h;
        Fri,  7 Jun 2019 09:13:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559862794;
        bh=5t2oQc6s+V43RQb10WwGr/fOTSIUUuBYwks8rlJztTU=;
        h=Date:From:To:Cc:Subject:From;
        b=FtwT/aVYHwYEVJjH/XYZAn+00QxuGkmS6g9kGAYH5ObQBfZcgzSaW85LBI7n22Q66
         zmBpd7bCyJ6Edx49ZHGW27v64TpDwZFtoRrbGyyNrGAxJC8JQLihv3m07ffwjzONOU
         ijcIBCRwSkga7RYZWZQxIdstoqPKd6tdN4K62EtZkIMlXiCfYvAH1QTkM0ZhT0LAtg
         my82gMJ/6u/FaAQ2Mjxa2AGTRKmJGObYmpiNrK9HVO4WkoGppb74FoyESxJ61NWsbn
         4pXOerOWoJfqYugUFa4CmsTAKnTyKp5+OMp+GchTV4ouATt6VGPc2Qbf5pQhwW1qTE
         5VQrkr/CUkS3w==
Date:   Fri, 7 Jun 2019 09:13:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: linux-next: manual merge of the clk tree with Linus' tree
Message-ID: <20190607091309.7410c584@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/93V4mXoVrrmFNr+q3NtUspS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/93V4mXoVrrmFNr+q3NtUspS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the clk tree got a conflict in:

  drivers/clk/bcm/Kconfig

between commit:

  ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig")

from Linus' tree and commit:

  5d59f12a19e6 ("clk: bcm: Make BCM2835 clock drivers selectable")

from the clk tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/clk/bcm/Kconfig
index 29ee7b776cd4,0eb281d597fc..000000000000
--- a/drivers/clk/bcm/Kconfig
+++ b/drivers/clk/bcm/Kconfig
@@@ -1,4 -1,12 +1,14 @@@
 +# SPDX-License-Identifier: GPL-2.0-only
++
+ config CLK_BCM2835
+ 	bool "Broadcom BCM2835 clock support"
+ 	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
+ 	depends on COMMON_CLK
+ 	default ARCH_BCM2835 || ARCH_BRCMSTB
+ 	help
+ 	  Enable common clock framework support for Broadcom BCM2835
+ 	  SoCs.
+=20
  config CLK_BCM_63XX
  	bool "Broadcom BCM63xx clock support"
  	depends on ARCH_BCM_63XX || COMPILE_TEST

--Sig_/93V4mXoVrrmFNr+q3NtUspS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz5ngUACgkQAVBC80lX
0GyQDgf+LGuzQdp70VRYdrIcUfsg5dDLlS6YY4xflac7gVJXy3w+W+P4XGCxF+nB
eP6fYlHmATP5yJMA2nmukpX/2unUHcDhrbKKo0hMZenhrkJsjRevNuHG/GuerjbJ
gicOJR80/VtaFy7fIFPKp2eUfppPqL5MSV7MFZ3k+4/ITT9qcZHCuECxLVVOdZ30
NAlqNEfKJbA+VGDZ5nt437kMdqy7IoLVJQt1OaVI0ecHambPCCHQrFP/N4Vx6/3d
+XkWRvQSJNzRl7yUNWdHtcLEPtpqtvQW3bN69Cyp2JnQlrzHrs5i+U2S/KnoLekG
XoN0VqiOa1pZK7StmVf14E5aq/2LRA==
=q05B
-----END PGP SIGNATURE-----

--Sig_/93V4mXoVrrmFNr+q3NtUspS--
