Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075D3C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EA42133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SrSjbIyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfDJBVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:21:43 -0400
Received: from ozlabs.org ([203.11.71.1]:55041 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfDJBVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:21:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44f5wN1T3wz9sTW;
        Wed, 10 Apr 2019 11:21:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554859301;
        bh=6/2hNvLOUauTgc08/B5+mizMfmGRpIuWIU+zAd90e8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SrSjbIyMSAQwKUe5Hfapu35jXML/tTJXPag+ZrDDt9xSpSpUOdPmeDz3VUpuOBk1c
         x27nGKI+Az1vhs73jFrWEsOdwDqTP1/I/ihYNTyqG0TiLHTEUHFnZuXZbP8jDAibqX
         a8b3J5KK5XDWBoX00y9dhEYPVu5qfs0qx0jv69UAPbavjU5dSfqufA27yyIplGOhBa
         3k4B0YGLhoS1usRgsFR4YRLo/6yVE8/cbpj9H8ThCv5iCUgiAsxnSWul/GAC15SJ4d
         UkDizo1SXY6U4PWVPdZ++/9af/qvHo/bJqxordiavXMXS0+1K+Mlw54Hk/CtqdeXGP
         NxFDBqzr2dhUw==
Date:   Wed, 10 Apr 2019 11:21:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20190410112138.178aa7bd@canb.auug.org.au>
In-Reply-To: <20190409162749.7eb6656f@canb.auug.org.au>
References: <20190409162749.7eb6656f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YMm6ymw/H5cdz.xhM=FcdLi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YMm6ymw/H5cdz.xhM=FcdLi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 9 Apr 2019 16:27:49 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the scsi-mkp tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>=20
> drivers/scsi/qla2xxx/tcm_qla2xxx.c: In function 'tcm_qla2xxx_init_lport':
> drivers/scsi/qla2xxx/tcm_qla2xxx.c:1614:3: error: implicit declaration of=
 function 'vzalloc'; did you mean 'kvzalloc'? [-Werror=3Dimplicit-function-=
declaration]
>    vzalloc(array_size(65536,
>    ^~~~~~~
>    kvzalloc
> drivers/scsi/qla2xxx/tcm_qla2xxx.c:1613:26: warning: assignment to 'struc=
t tcm_qla2xxx_fc_loopid *' from 'int' makes pointer from integer without a =
cast [-Wint-conversion]
>   lport->lport_loopid_map =3D
>                           ^
> drivers/scsi/qla2xxx/tcm_qla2xxx.c: In function 'tcm_qla2xxx_make_lport':
> drivers/scsi/qla2xxx/tcm_qla2xxx.c:1677:2: error: implicit declaration of=
 function 'vfree'; did you mean 'kvfree'? [-Werror=3Dimplicit-function-decl=
aration]
>   vfree(lport->lport_loopid_map);
>   ^~~~~
>   kvfree
>=20
> Caused by commit
>=20
>   523c106ad4b1 ("scsi: tcm_qla2xxx: Minimize #include directives")
>=20
> I have reverted that commit for today.

This has now migrated to the scsi tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/YMm6ymw/H5cdz.xhM=FcdLi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlytRSIACgkQAVBC80lX
0Gx91Qf+Idg8Pb9uQjgxBCmoy4xSSwoBb0GBPLAP/lsrd8046RB7kKYfVEKl8Afw
czePqWwhD60OfAaa503jraRGPAnlcyCTNwTF6s6egB15O1l9PV9Ma1TSOkyakr9V
M0xbP5PnL9hFAgzcOsNhzSwa8DrhDtwKbYTqOclIi+oyVGGiHzNu29CdFlusp9fW
zcHjOodxM7dmepKThK0cDnzdSylQ9ptFdSStn+Qklbvwp5ktehVcpzpZ9OetHCyj
v1r38A67HDfsYbBF2kZK/FLAkRsB2Tj8R3h0avFbMzXJDg3Po7MFsDmS957Oy9W/
XIpPiu7iakivgRBuK591d5aE9LbeLA==
=YKcB
-----END PGP SIGNATURE-----

--Sig_/YMm6ymw/H5cdz.xhM=FcdLi--
