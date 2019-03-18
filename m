Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5352CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1102086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ECQMl1qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfCRAA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:00:57 -0400
Received: from ozlabs.org ([203.11.71.1]:39847 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfCRAA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 20:00:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44MxCq233fz9s71;
        Mon, 18 Mar 2019 11:00:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552867255;
        bh=ExCjEOsmZ4/aq7q0P/kin9B1ShkLgJhoIee92y7l8ak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ECQMl1qe/cX8whmfBFL0+GTB6Y9arvmqUSvJgUZYrsdbVY9XY79RWVpnEzo5IHHSI
         UCx8FnZ7KGQKUB6EqsY7btDkwvR104WZcssew+Yj7tsEeou7AENVE1OIHojttTY4A8
         kEn2xcSzw4eV9uqcZc/kkT6c6EsJL09J/5ivx79LaAcPmW9lccqoRcXFyM5ohIREN0
         i+ab9fQxWi2E4pMp7eIE98M+vzzJHBWV2U+Yahin8Gz2PzR1Q2IgyUqFz+1xBQZINH
         GD1LWaHTqStorxPCpZ6bTpQXHIo5tc5M2hh9SgOENrF6VElNxo+o25feMe9wDEQM+O
         CMAXojgg1MiQw==
Date:   Mon, 18 Mar 2019 11:00:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: build warning after merge of the vfs tree
Message-ID: <20190318110050.2bf8d87b@canb.auug.org.au>
In-Reply-To: <20190204093334.0ccc42bb@canb.auug.org.au>
References: <20190204093334.0ccc42bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/F1JYpB8UULc1V+hLNijIqJf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F1JYpB8UULc1V+hLNijIqJf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 4 Feb 2019 09:33:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the vfs tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> In file included from include/linux/printk.h:7,
>                  from include/linux/kernel.h:14,
>                  from include/linux/fs_context.h:15,
>                  from fs/fs_parser.c:13:
> fs/fs_parser.c: In function 'fs_validate_description':
> include/linux/kern_levels.h:5:18: warning: format '%lu' expects argument =
of type 'long unsigned int', but argument 3 has type 'int' [-Wformat=3D]
>  #define KERN_SOH "\001"  /* ASCII Start Of Header */
>                   ^~~~~~
> include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
>  #define KERN_ERR KERN_SOH "3" /* error conditions */
>                   ^~~~~~~~
> include/linux/printk.h:303:9: note: in expansion of macro 'KERN_ERR'
>   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>          ^~~~~~~~
> fs/fs_parser.c:413:6: note: in expansion of macro 'pr_err'
>       pr_err("VALIDATE %s: e[%lu] enum val for %s\n",
>       ^~~~~~
> fs/fs_parser.c:413:31: note: format string is defined here
>       pr_err("VALIDATE %s: e[%lu] enum val for %s\n",
>                              ~~^
>                              %u
>=20
> Introduced by commit
>=20
>   f512b838c104 ("vfs: Add configuration parser helpers")

We are now seeing that warning in Linus' tree :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/F1JYpB8UULc1V+hLNijIqJf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyO37IACgkQAVBC80lX
0GwxgQf8CMu4EwT6LxSYySpGZwl1cX3aYR6kiH3T93SSmVghkk5WRT0tMxgfUT2X
WQVCt1+wb3j6mit76kr/yoZxr25exNUL3C+XjShG2ehN3AdQ3C7pTYttLhXpa4G6
VrPStTLm15MinIOL0hiPLpY3h0pSUzX9vLBqdS6E1D4lvjL1as3VV+FHtWxCqqv7
7QSto0oaE7s2UB0nJPdjt/wl4TJJYVukypvvvmk00GLtfXufwr+Uk42PUMtY9vJ4
DZhFiUGEcH274bARIqWdjP9Oy5O903d7lukLBCknBn/Y0cOxeLEduHJhurrDC1WQ
7bBZQoE8zZ1IaHh8wSpZN5jrRtOvvw==
=86Mr
-----END PGP SIGNATURE-----

--Sig_/F1JYpB8UULc1V+hLNijIqJf--
