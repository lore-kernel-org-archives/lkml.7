Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEDEC04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF50121537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Zkuwnwu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfENAPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 20:15:30 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55695 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfENAPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 20:15:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 452yrG4nxCz9s5c;
        Tue, 14 May 2019 10:15:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557792927;
        bh=Ju2KVg9gRdQiFgMiTbNmDphCWR7FUhZJIv9FZ8DHNPI=;
        h=Date:From:To:Cc:Subject:From;
        b=Zkuwnwu4tf2hR09XjfJcH2vxmW9yMJpaRUdEm7/IbPSVjiEIidqOHlLCo79+aafby
         pgVr7UMWASdbFavxN2AtovsuX3JjaXGMEhZ2pRmkrsixGd0Fwr8rbzbNDlds2BwEbv
         nqwpDAV8Ifm4nmBys25ae1rj0355vq6BHt2oT7DncKGqg68BDuacpdE7h+waiMDMUr
         rKMrofJTi91uaO3sQj21M/GRlUw7q7Bf7KZbRLpr6zLKyMF8q+GC6jJrDdcCcvSwVq
         KP5TaTf10x0yVcka5enbyHxEkDeqrK2y3g26SzEjGLt1nCdP68sGytOBSAN20jgcDo
         lAAOFx/ibfVUA==
Date:   Tue, 14 May 2019 10:15:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Tyler Hicks <tyhicks@canonical.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the ecryptfs tree
Message-ID: <20190514100910.6996d2f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GsNMvU2qEo9mMflr5OjEJ0k"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GsNMvU2qEo9mMflr5OjEJ0k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I don't know why this suddenly appeared after mergeing the ecryptfs tree
since nothin has changed in that tree for some time (and nothing in that
tree seems relevant).

After merging the ecryptfs tree, today's linux-next build (x86_64
allmodconfig) failed like this:

scripts/Makefile.modpost:112: target '.tmp_versions/asix.mod' doesn't match=
 the target pattern
scripts/Makefile.modpost:113: warning: overriding recipe for target '.tmp_v=
ersions/asix.mod'
scripts/Makefile.modpost:100: warning: ignoring old recipe for target '.tmp=
_versions/asix.mod'
scripts/Makefile.modpost:127: target '.tmp_versions/asix.mod' doesn't match=
 the target pattern
scripts/Makefile.modpost:128: warning: overriding recipe for target '.tmp_v=
ersions/asix.mod'
scripts/Makefile.modpost:113: warning: ignoring old recipe for target '.tmp=
_versions/asix.mod'
make[2]: Circular .tmp_versions/asix.mod <- __modpost dependency dropped.
Binary file .tmp_versions/asix.mod matches: No such file or directory
make[2]: *** [scripts/Makefile.modpost:91: __modpost] Error 1
make[1]: *** [Makefile:1290: modules] Error 2

The only clue I can see is that asix.o gets built in two separate
directories (drivers/net/{phy,usb}).

I have the following files in the object directory:

./.tmp_versions/asix.mod
./drivers/net/usb/asix.ko
./drivers/net/usb/asix.mod.o
./drivers/net/usb/asix.o
./drivers/net/usb/asix_common.o
./drivers/net/usb/asix_devices.o
./drivers/net/usb/.asix.ko.cmd
./drivers/net/usb/.asix.mod.o.cmd
./drivers/net/usb/.asix.o.cmd
./drivers/net/usb/asix.mod.c
./drivers/net/usb/.asix_common.o.cmd
./drivers/net/usb/.asix_devices.o.cmd
./drivers/net/phy/asix.ko
./drivers/net/phy/asix.o
./drivers/net/phy/.asix.ko.cmd
./drivers/net/phy/.asix.mod.o.cmd
./drivers/net/phy/asix.mod.o
./drivers/net/phy/asix.mod.c
./drivers/net/phy/.asix.o.cmd

./.tmp_versions/asix.mod

Looks like this:

------------------------------------------
drivers/net/phy/asix.ko
drivers/net/phy/asix.o


------------------------------------------

What you can't see above are the 256 NUL bytes at the end of the file
(followed by a NL).

This is from a -j 80 build.  Surely there is a race condition here if the
file in .tmp_versions is only named for the base name of the module and
we have 2 modules with the same base name.

I removed that file and redid the build and it succeeded.

Mind you, I have no itdea why this file was begin rebuilt, the merge
only touched these files:

fs/ecryptfs/crypto.c
fs/ecryptfs/keystore.c

Puzzled ... :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/GsNMvU2qEo9mMflr5OjEJ0k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzaCJYACgkQAVBC80lX
0GwlwQf9Gj9wz73uyo5re6z+nQHohC1vGzloekz15OIqF5RmdKpSqIF99rFJYE2k
1O6LUj+zVLOPN2h6NBFMX7XHRw4I5h7IXPp7VVTiVcptnsalQ12Ehjv9N+tZaNII
PMX6oZdNDAG9GtwShSKuUGHLMiFVvhf1TNyDfmCSRT72KytN6/eYchSDkqGNOBUi
rSu2+4aytF6UE8WHcf7EUmG0kfoN3bUCsKvrQe3KyHyo+b9fcbI9Fsisv/rUuI6m
Q8NRE25pzrL49YFLiZG506gyUBsorBHdT1wp+Qo1A1MtHwI2439Zuv5el7QLSVll
jsaBXyrZvpJ/3dC6UFwJza/3vx1fag==
=Cwco
-----END PGP SIGNATURE-----

--Sig_/GsNMvU2qEo9mMflr5OjEJ0k--
