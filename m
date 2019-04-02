Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325C2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFC92084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Bv2PncYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDBXWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:22:43 -0400
Received: from ozlabs.org ([203.11.71.1]:58597 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDBXWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:22:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44YlcJ3lxMz9sSV;
        Wed,  3 Apr 2019 10:22:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554247361;
        bh=xQoog3/kUaEkPZsnGADzXcGqc9Kp5s6bW+AGa2DbZFU=;
        h=Date:From:To:Cc:Subject:From;
        b=Bv2PncYbtwYBQfDnIhMQQFJvQJjauB5tBonAu6vtfzHHMFPD9GpruU5oKCm1A+v2W
         BdONR5PmrMVrLaws34whwmXm27PA9uhnEFxrn3v1W87Ks4shtD5J0V2QX9m5SVN6pH
         sqixyVrhK7NEtnxzg4TCf/KmUXwugdkC3VSdI+MUCCzCsZefGvQhQLRUqXSlji3/Yw
         vnchALU/YALfjYng6eK+5b6PAc7TNwtbITxd6C6cUiwgJo2SPjbu29jhGmgKO2AlP3
         1wEPqX2Ao7qT9yvMCqzr2+enFssfcpm8n7MuGK1WIpRotTpa8oOUUnSlZMRgyLNnyA
         CeCP/xyKQHr4A==
Date:   Wed, 3 Apr 2019 10:22:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: linux-next: build warning after merge of the nand tree
Message-ID: <20190403102239.174fbe35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/q=JfJhV5EJO6hR.++ngTl6p"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q=JfJhV5EJO6hR.++ngTl6p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nand tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/mtd/nand/raw/ingenic/jz4725b_bch.c: In function 'jz4725b_bch_read_p=
arity':
drivers/mtd/nand/raw/ingenic/jz4725b_bch.c:147:12: warning: this statement =
may fall through [-Wimplicit-fallthrough=3D]
   dest8[2] =3D (val >> 16) & 0xff;
   ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
drivers/mtd/nand/raw/ingenic/jz4725b_bch.c:148:2: note: here
  case 2: /* fall-through */
  ^~~~
drivers/mtd/nand/raw/ingenic/jz4725b_bch.c:149:12: warning: this statement =
may fall through [-Wimplicit-fallthrough=3D]
   dest8[1] =3D (val >> 8) & 0xff;
   ~~~~~~~~~^~~~~~~~~~~~~~~~~~~
drivers/mtd/nand/raw/ingenic/jz4725b_bch.c:150:2: note: here
  case 1: /* fall-through */
  ^~~~

Introduced by commit

  acb29396f956 ("mtd: rawnand: ingenic: Add support for the JZ4725B")

I get this warning because I am building with -Wimplicit-fallthrough
in attempt to catch new additions early.  The gcc warning can be turned
off by adding a /* fall through */ comment at the point the fall through
happens (i.e. before the next case label).

--=20
Cheers,
Stephen Rothwell

--Sig_/q=JfJhV5EJO6hR.++ngTl6p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyj7r8ACgkQAVBC80lX
0Gzl1wf9F8tBlFkm/RNfUFHRI+y37bVEP4U4FPmEBApNFtOIUsIpsWzMz0g9ZOlT
o7YlySPP4CRcaT5L1w2vCOsAeA8ASVmT7q19IBdpioXblMN2NVrB381AwEwUlop8
NLKe4m8xhUHNT9bhidz79IOetiJnMow0IUDOUdg56l6pJrhR1tgraj5+DgtTH7CQ
JlWhgJQBKkSe7LwLytldW0fKDk0GZfAoxgsNULLDaNVirnlgvlqjC9Z3pxtgOF8o
046oL6tpOUtOzSupJlosNwlKcIKjudE2yJKxHjcDhNGnPgoJuoT00+YK6c8r5ogO
VKNrdMP9PIXLqikQKkQknWfZjpXXsg==
=zYtu
-----END PGP SIGNATURE-----

--Sig_/q=JfJhV5EJO6hR.++ngTl6p--
