Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2A1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C392A20828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FkeppqTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfCYXFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:05:24 -0400
Received: from ozlabs.org ([203.11.71.1]:56743 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfCYXFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:05:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Sqc137kpz9sSN;
        Tue, 26 Mar 2019 10:05:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553555121;
        bh=Ey0p2579lYqy7r6pHdpNbLPGvQjeneJaOW7V/GGza4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FkeppqTqyNic5ltkB5CsTEyD7oFzUFtscGxURTWbixlYCJgDFmGDv2vt37ij+f6M+
         sKCmNaCGyVPsWEzX8tOKXZ7/MZZDscWn50mdXgAG2Goaz+BFpIUEryjw264qWJkARm
         Bqj4fsR/K4U+VzxRiZ31Whs0t8i2mO/8ItBjwi0d1cCq5Q893SBYKrBaizplknhoiw
         QHGx5SWQzlzOti5HiinkBeabWd7nJjaPnfqeTDEsFMvh8WW7g4/xZR1WPFsVXX0QqK
         E0cphOuok6iVDDQF+DPHcE9j6d/0hss9QUifG9V6i1CYmg1KgYhz5pfOvnrrXFI+nL
         +4pvder5+hmzw==
Date:   Tue, 26 Mar 2019 10:05:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: build warning after merge of the vfs tree
Message-ID: <20190326100520.5306e2b7@canb.auug.org.au>
In-Reply-To: <20190318110050.2bf8d87b@canb.auug.org.au>
References: <20190204093334.0ccc42bb@canb.auug.org.au>
        <20190318110050.2bf8d87b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ABI=vFaqmdVjLm/7McWb+Rh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ABI=vFaqmdVjLm/7McWb+Rh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 18 Mar 2019 11:00:50 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 4 Feb 2019 09:33:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >
> > After merging the vfs tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> >=20
> > In file included from include/linux/printk.h:7,
> >                  from include/linux/kernel.h:14,
> >                  from include/linux/fs_context.h:15,
> >                  from fs/fs_parser.c:13:
> > fs/fs_parser.c: In function 'fs_validate_description':
> > include/linux/kern_levels.h:5:18: warning: format '%lu' expects argumen=
t of type 'long unsigned int', but argument 3 has type 'int' [-Wformat=3D]
> >  #define KERN_SOH "\001"  /* ASCII Start Of Header */
> >                   ^~~~~~
> > include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SO=
H'
> >  #define KERN_ERR KERN_SOH "3" /* error conditions */
> >                   ^~~~~~~~
> > include/linux/printk.h:303:9: note: in expansion of macro 'KERN_ERR'
> >   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
> >          ^~~~~~~~
> > fs/fs_parser.c:413:6: note: in expansion of macro 'pr_err'
> >       pr_err("VALIDATE %s: e[%lu] enum val for %s\n",
> >       ^~~~~~
> > fs/fs_parser.c:413:31: note: format string is defined here
> >       pr_err("VALIDATE %s: e[%lu] enum val for %s\n",
> >                              ~~^
> >                              %u
> >=20
> > Introduced by commit
> >=20
> >   f512b838c104 ("vfs: Add configuration parser helpers") =20
>=20
> We are now seeing that warning in Linus' tree :-(

I am still getting the above warning ...

--=20
Cheers,
Stephen Rothwell

--Sig_/ABI=vFaqmdVjLm/7McWb+Rh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyZXrAACgkQAVBC80lX
0GwgOQf/S4/jp7NdxfpkLPV9xLUXG7WsDxDYb9d/b54xrB9x8IE6W7OrwjG9i5+Y
1Mh3d+8L4PEzjG74Wy7V/lY2Op62+SSQkDgg3eDZ23aVayLjvRGsqDrgmz9gaETV
fDLy1//nLjmuVt4/x7qcyt7R1sEqmhg/risCakxA1BvngeKy7G3QVMZYYEHC48yH
nHvWwpb16UkLjGTMpb/q4maqb9EtKnhrlNXBTGoeJnBv/oXjTpeQ3XatjW8YIZk9
GAxG+2wkFlCG/LSytufePdxNoBtlX2wBJV/9yGqb/EP/eHWh/1zgzDHmSejwqrEQ
mIQPnlOykR02f7bYF7K/JKd01r+eSw==
=xZ4k
-----END PGP SIGNATURE-----

--Sig_/ABI=vFaqmdVjLm/7McWb+Rh--
