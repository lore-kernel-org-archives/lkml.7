Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C28C06516
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D282189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S0mHu2gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfGDJEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:04:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbfGDJEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:04:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fX8V3wTgz9sBp;
        Thu,  4 Jul 2019 19:03:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562231038;
        bh=4F5VbdQ8LxgHXvyCHlKP/f3feYzrTEdhPQQacF2QWj8=;
        h=Date:From:To:Cc:Subject:From;
        b=S0mHu2gtcJbfIMKWwaFkgnhjhcHz02w1Hr8cWh4vaX6tgu+NGg36wGuvfIlf3q5x8
         XKKld1sOZsegdgT5Ge1gDKSLu0EA/pHJA6D7lyfWPLXGRlAAq6siatJpGHGK5xv300
         zRpSoj6zcI/YD/qRZ/xqBOHoa0xlEp7dT8Hfy3CVIE0BQkN2q5B8HOnJSaeft9TJYT
         wsOw2TOjzda4/Q3yUVLax97W0zJ4bWgDWPkSVHQ6qqaHd9DYgCiLQ2upfwH1KnfzUi
         uxRyf1I32XXbnPmZEkfDyOZDf0nUX/VfGRaJknwkc1YaJWNhnjU4bAwkQzX6lEgKuK
         Lrhpoc4BHCjyA==
Date:   Thu, 4 Jul 2019 19:03:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lianbo Jiang <lijiang@redhat.com>,
        Borislav Petkov <bp@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the hmm tree with the tip tree
Message-ID: <20190704190352.417a34d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FsU1qz/e8tTG=VLC8SCgpPF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FsU1qz/e8tTG=VLC8SCgpPF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the hmm tree got a conflict in:

  include/linux/ioport.h

between commit:

  ae9e13d621d6 ("x86/e820, ioport: Add a new I/O resource descriptor IORES_=
DESC_RESERVED")
  5da04cc86d12 ("x86/mm: Rework ioremap resource mapping determination")

from the tip tree and commit:

  25b2995a35b6 ("mm: remove MEMORY_DEVICE_PUBLIC support")

from the hmm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/ioport.h
index 5db386cfc2d4,a02b290ca08a..000000000000
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@@ -133,16 -132,6 +133,15 @@@ enum=20
  	IORES_DESC_PERSISTENT_MEMORY		=3D 4,
  	IORES_DESC_PERSISTENT_MEMORY_LEGACY	=3D 5,
  	IORES_DESC_DEVICE_PRIVATE_MEMORY	=3D 6,
- 	IORES_DESC_DEVICE_PUBLIC_MEMORY		=3D 7,
- 	IORES_DESC_RESERVED			=3D 8,
++	IORES_DESC_RESERVED			=3D 7,
 +};
 +
 +/*
 + * Flags controlling ioremap() behavior.
 + */
 +enum {
 +	IORES_MAP_SYSTEM_RAM		=3D BIT(0),
 +	IORES_MAP_ENCRYPTED		=3D BIT(1),
  };
 =20
  /* helpers to define resources */

--Sig_/FsU1qz/e8tTG=VLC8SCgpPF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0dwPgACgkQAVBC80lX
0GzXGQf9GHUhRhvPVf1qf8emX2ighzE9niFgBa4mP1dtrTgBIBGsY9syVLScaL+s
7C2H6nBBDYh/tMd+sRJWba9Zyz0eXkHZfQ96PGCky+sciXsAAqINV7XoeBQRcQh/
fFiTPavyFU6mmayIH6ppAQzkIoL8c27UDqOA8S1zQqaaLd4Wnk9zlpGgokjMoOou
DE20SVf5jzOWcXUoVUA6QZpxkolqEoaSMMEPseeOeNj8iW42L78KZVUG9CRR9pHc
9FU+J6LhlkDqENu2oejbBVxcnYgRCYizEu4meW2bHUgvn4aCanidJIUyks5hVJjv
KEQU/h1yQYhwxTCK9jCll9QSeHwh8w==
=zKbc
-----END PGP SIGNATURE-----

--Sig_/FsU1qz/e8tTG=VLC8SCgpPF--
