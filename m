Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D64EC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FFB218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UQTBP2Ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfFQGGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 02:06:41 -0400
Received: from ozlabs.org ([203.11.71.1]:55559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfFQGGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:06:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45S11n6X6bz9sBr;
        Mon, 17 Jun 2019 16:06:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560751599;
        bh=62pesImsmPdn3v0yKHcFLa/KA3fGklp7Xf2iXTBgdbw=;
        h=Date:From:To:Cc:Subject:From;
        b=UQTBP2MaPeoNxMEWs/Hi/hRvGCcHSj9rLyV6rbKIAfbWN3qmbjjgFtF/fxYU7bRrk
         LajdILJXBWYsY9SIBeKx8TcoPGLyjhUj4G1vd3mg955tT4oFk+CdHBI40EKv7NbCFG
         +sK0riEXos+A+M2I/ox+XuKkvd58Bxvp3SJbp5x49EbWXxKz7jzjFXtUQtLn3j1VI3
         dCsFD7Hd2LAeSnjwpqui4IhLyYYQZ+V/Yq8q9tbcakd2EMIG4JU090K6JZ8mYVVZW5
         ysWdPZ+sgZMpQFqN60e2i1gZ/gDSpM0lP4/3BQngj1g1QSmp5r99odSF/GbwC8ksmN
         m5r4nP5IXBQkg==
Date:   Mon, 17 Jun 2019 16:06:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Herrmann <aherrmann@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: linux-next: manual merge of the cgroup tree with Linus' tree
Message-ID: <20190617160635.30927c7a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/75/LhSlo7K=CdgqKqU+8OgH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/75/LhSlo7K=CdgqKqU+8OgH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cgroup tree got a conflict in:

  Documentation/cgroup-v1/blkio-controller.rst

between commit:

  fb5772cbfe48 ("blkio-controller.txt: Remove references to CFQ")

from Linus' tree and commit:

  99c8b231ae6c ("docs: cgroup-v1: convert docs to ReST and rename to *.rst")

from the cgroup tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/cgroup-v1/blkio-controller.rst
index d1a1b7bdd03a,2c1b907afc14..000000000000
--- a/Documentation/cgroup-v1/blkio-controller.rst
+++ b/Documentation/cgroup-v1/blkio-controller.rst
@@@ -15,15 -19,71 +17,18 @@@ level logical devices like device mappe
 =20
  HOWTO
  =3D=3D=3D=3D=3D
 -Proportional Weight division of bandwidth
 ------------------------------------------
 -You can do a very simple testing of running two dd threads in two differe=
nt
 -cgroups. Here is what you can do.
 -
 -- Enable Block IO controller::
 -
 -	CONFIG_BLK_CGROUP=3Dy
 -
 -- Enable group scheduling in CFQ:
 -
 -
 -	CONFIG_CFQ_GROUP_IOSCHED=3Dy
 -
 -- Compile and boot into kernel and mount IO controller (blkio); see
 -  cgroups.txt, Why are cgroups needed?.
 -
 -  ::
 -
 -	mount -t tmpfs cgroup_root /sys/fs/cgroup
 -	mkdir /sys/fs/cgroup/blkio
 -	mount -t cgroup -o blkio none /sys/fs/cgroup/blkio
 -
 -- Create two cgroups::
 -
 -	mkdir -p /sys/fs/cgroup/blkio/test1/ /sys/fs/cgroup/blkio/test2
 -
 -- Set weights of group test1 and test2::
 -
 -	echo 1000 > /sys/fs/cgroup/blkio/test1/blkio.weight
 -	echo 500 > /sys/fs/cgroup/blkio/test2/blkio.weight
 -
 -- Create two same size files (say 512MB each) on same disk (file1, file2)=
 and
 -  launch two dd threads in different cgroup to read those files::
 -
 -	sync
 -	echo 3 > /proc/sys/vm/drop_caches
 -
 -	dd if=3D/mnt/sdb/zerofile1 of=3D/dev/null &
 -	echo $! > /sys/fs/cgroup/blkio/test1/tasks
 -	cat /sys/fs/cgroup/blkio/test1/tasks
 -
 -	dd if=3D/mnt/sdb/zerofile2 of=3D/dev/null &
 -	echo $! > /sys/fs/cgroup/blkio/test2/tasks
 -	cat /sys/fs/cgroup/blkio/test2/tasks
 -
 -- At macro level, first dd should finish first. To get more precise data,=
 keep
 -  on looking at (with the help of script), at blkio.disk_time and
 -  blkio.disk_sectors files of both test1 and test2 groups. This will tell=
 how
 -  much disk time (in milliseconds), each group got and how many sectors e=
ach
 -  group dispatched to the disk. We provide fairness in terms of disk time=
, so
 -  ideally io.disk_time of cgroups should be in proportion to the weight.
 -
  Throttling/Upper Limit policy
  -----------------------------
- - Enable Block IO controller
+ - Enable Block IO controller::
+=20
  	CONFIG_BLK_CGROUP=3Dy
 =20
- - Enable throttling in block layer
+ - Enable throttling in block layer::
+=20
  	CONFIG_BLK_DEV_THROTTLING=3Dy
 =20
- - Mount blkio controller (see cgroups.txt, Why are cgroups needed?)
+ - Mount blkio controller (see cgroups.txt, Why are cgroups needed?)::
+=20
          mount -t cgroup -o blkio none /sys/fs/cgroup/blkio
 =20
  - Specify a bandwidth rate on particular device for root group. The format

--Sig_/75/LhSlo7K=CdgqKqU+8OgH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0HLesACgkQAVBC80lX
0Gw8qQf9G8plcsmc+zHiVZHe5bUyFfU4eKBvh0ZSiay9FqoZ65t6hXCveZKH33NO
k7ClPwc0qm06HNCHIGbrG2sg6bgyPMif+Hr3BtcpWt9MNPGV7FPljd0zBhuUhnIY
ON5fsTdBVQ7RNKbCPXH0sUcTa8hifOpDflr7kv9310M9uUQ/nSbcPLVm3Gu7P1Pc
rVuWhLjw2pqR1aOcf/e4Y34BwPv5rC0CGICCInlUR00DnhZpdBeZ3CU/I2+qNbnX
qjoc2Z9YO94wNNOumG7pXidbG1+MNcyD/ENgvKj/Bq+9kXSOtp81vFpyHN4ptq2j
p7xxfkkVEeG7U30yFan6D68neTIohg==
=+T49
-----END PGP SIGNATURE-----

--Sig_/75/LhSlo7K=CdgqKqU+8OgH--
