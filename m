Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B509CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A75D2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="auiPQb38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfFTJOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:14:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34395 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfFTJN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:13:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Tx2W3tSSz9sBp;
        Thu, 20 Jun 2019 19:13:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561022035;
        bh=3ogxtSLbOL9KRURpoi0VkKWC0IJQT7xb0iOjjqVwozw=;
        h=Date:From:To:Cc:Subject:From;
        b=auiPQb38+XA9l/L7OlInCRyw5eJ0fUnCqcnmWbUpWxYOXnqwIcgKLXhutFUX2y48J
         st+koiBYS/TTAxWioBH13lWE/PXpY/5knYrszNuyyxpqKa/01dYizLL2ABY3UzF2FO
         2k+2jlEhu6tAZa1LmR1CtU8yoyUUUDgilaTt0WD18yVNxbH+91Z3fwUn4ZdO4OQpSL
         IYVEvonOrptLldTlVDTc+QGbSyFPayKWy1JcKiWOe1vnVR5+smCrcURe+kJtJvNVvO
         GiA9V8EGZyMkOpncDBt7CkCcXwxmTd0Y03JAAlS0wL5sz0Px6WsyXEDFWwvP2HkfBp
         8E+KQTK+tbLnA==
Date:   Thu, 20 Jun 2019 19:13:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yash Shah <yash.shah@sifive.com>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20190620191348.335b011d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Nw5D.vzFc._WbxGzv9ij1SB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nw5D.vzFc._WbxGzv9ij1SB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/net/ethernet/cadence/macb_main.c:48:16: error: field 'hw' has incom=
plete type
  struct clk_hw hw;
                ^~
drivers/net/ethernet/cadence/macb_main.c:4003:21: error: variable 'fu540_c0=
00_ops' has initializer but incomplete type
 static const struct clk_ops fu540_c000_ops =3D {
                     ^~~~~~~
drivers/net/ethernet/cadence/macb_main.c:4004:3: error: 'const struct clk_o=
ps' has no member named 'recalc_rate'
  .recalc_rate =3D fu540_macb_tx_recalc_rate,
   ^~~~~~~~~~~
drivers/net/ethernet/cadence/macb_main.c:4004:17: warning: excess elements =
in struct initializer
  .recalc_rate =3D fu540_macb_tx_recalc_rate,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/cadence/macb_main.c:4004:17: note: (near initializatio=
n for 'fu540_c000_ops')
drivers/net/ethernet/cadence/macb_main.c:4005:3: error: 'const struct clk_o=
ps' has no member named 'round_rate'
  .round_rate =3D fu540_macb_tx_round_rate,
   ^~~~~~~~~~
drivers/net/ethernet/cadence/macb_main.c:4005:16: warning: excess elements =
in struct initializer
  .round_rate =3D fu540_macb_tx_round_rate,
                ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/cadence/macb_main.c:4005:16: note: (near initializatio=
n for 'fu540_c000_ops')
drivers/net/ethernet/cadence/macb_main.c:4006:3: error: 'const struct clk_o=
ps' has no member named 'set_rate'
  .set_rate =3D fu540_macb_tx_set_rate,
   ^~~~~~~~
drivers/net/ethernet/cadence/macb_main.c:4006:14: warning: excess elements =
in struct initializer
  .set_rate =3D fu540_macb_tx_set_rate,
              ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/cadence/macb_main.c:4006:14: note: (near initializatio=
n for 'fu540_c000_ops')
drivers/net/ethernet/cadence/macb_main.c: In function 'fu540_c000_clk_init':
drivers/net/ethernet/cadence/macb_main.c:4013:23: error: storage size of 'i=
nit' isn't known
  struct clk_init_data init;
                       ^~~~
drivers/net/ethernet/cadence/macb_main.c:4032:12: error: implicit declarati=
on of function 'clk_register'; did you mean 'sock_register'? [-Werror=3Dimp=
licit-function-declaration]
  *tx_clk =3D clk_register(NULL, &mgmt->hw);
            ^~~~~~~~~~~~
            sock_register
drivers/net/ethernet/cadence/macb_main.c:4013:23: warning: unused variable =
'init' [-Wunused-variable]
  struct clk_init_data init;
                       ^~~~
drivers/net/ethernet/cadence/macb_main.c: In function 'macb_probe':
drivers/net/ethernet/cadence/macb_main.c:4366:2: error: implicit declaratio=
n of function 'clk_unregister'; did you mean 'sock_unregister'? [-Werror=3D=
implicit-function-declaration]
  clk_unregister(tx_clk);
  ^~~~~~~~~~~~~~
  sock_unregister
drivers/net/ethernet/cadence/macb_main.c: At top level:
drivers/net/ethernet/cadence/macb_main.c:4003:29: error: storage size of 'f=
u540_c000_ops' isn't known
 static const struct clk_ops fu540_c000_ops =3D {
                             ^~~~~~~~~~~~~~

Caused by commit

  c218ad559020 ("macb: Add support for SiFive FU540-C000")

CONFIG_COMMON_CLK is not set for this build.

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Nw5D.vzFc._WbxGzv9ij1SB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LTkwACgkQAVBC80lX
0GwvKgf+MOyZ+jds7FH8o/xKQ20gLbF3lcZsyYEcdPy6I9IhJD1KgdIA10apJ0AJ
msoC3q8JtYTw/kLOWsEi699vDwwiYe01EYaNKG8BtUeH6YizNATgRW/W6Rjod4gK
5AhnW/Kx+9W7hyfSqCGqZ4uGvcBN/0B8SWQAKe9GDZX0U+gX4oGQ/tYwMM2q6P1u
2cU+jCnpOKL9XvbsTdB3NXJq4rV5E2sesKrVIYbM9JFdA1dyusR0I6IzK/qdDPv9
sYZ6tCPU56WhAByBEDfMyoHVSlSXGs7aL7eqAFYTGZTXEPYbHSEdWdGAG0ZQgdrX
uvrzd9xTf2KoCFUdKbQ+v4MAdfmkUg==
=DWBe
-----END PGP SIGNATURE-----

--Sig_/Nw5D.vzFc._WbxGzv9ij1SB--
