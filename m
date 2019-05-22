Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F340C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA7621479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NzlaNQxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfEVBnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:43:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55029 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfEVBnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:43:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457wPt4ff2z9sML;
        Wed, 22 May 2019 11:43:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558489395;
        bh=/+vz4nyDleFR9w+Hc2JgILnEclzB5fhZ1TMcpt7nMLc=;
        h=Date:From:To:Cc:Subject:From;
        b=NzlaNQxfZDbuzW2V0v/SA5EW2KjWk6/MA6vUlKMZ7+Ffdjx0GRAdxoeqNJ96/V38D
         ksUT+chBsH9lhp/g6nyQT17W6nn61xKne89IC+jnbN6RJcr0xUQ5fYCZ0zSvXZfDkx
         wx4lsXm7NFTuvbxWoPFzxs/GVpFwNk5D50+65WB/FBx9BCYAEe1YN0/QmDzQtLvZHH
         kHx9YR+x1ePVbQGgkgPNxFCLj8JH+o6CwKCdcd74X6xKdizSHD3T5Yvc4Ns8E873Wr
         J4aUYEOxDxIWP3snYrxQFTDwnPgC0/zPKmHuA69wOMnCp1YvAvsteZ/oMzFKFyYIEz
         3k3cTg5CBTU9g==
Date:   Wed, 22 May 2019 11:43:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: linux-next: manual merge of the akpm-current tree with the pidfd
 tree
Message-ID: <20190522114314.515b410d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//JxyEEp0Z.6I8p35=DwmN0Z"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//JxyEEp0Z.6I8p35=DwmN0Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  kernel/pid.c

between commit:

  99e9da7f2796 ("pid: add pidfd_open()")

from the pidfd tree and commit:

  51c59c914840 ("kernel/pid.c: convert struct pid:count to refcount_t")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/pid.c
index 39181ccca846,b59681973dd6..000000000000
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@@ -37,8 -36,7 +37,8 @@@
  #include <linux/init_task.h>
  #include <linux/syscalls.h>
  #include <linux/proc_ns.h>
- #include <linux/proc_fs.h>
+ #include <linux/refcount.h>
 +#include <linux/sched/signal.h>
  #include <linux/sched/task.h>
  #include <linux/idr.h>
 =20

--Sig_//JxyEEp0Z.6I8p35=DwmN0Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzkqTIACgkQAVBC80lX
0GwcpAf8CwUenbm91eZ9ojHHXKB7XVoDgK8/TZpdnunIufJ/z8HiIogMBKznAmvp
vqq/cgMC1AckNHQd8I552BV0pXIp2GeW05agg5+yPbaM0asQt4+J+xaclpTpQ6n6
WTwZMVbgLLB9Z/enOekSqhRxcxdVljql9K5UDXmA6FmKdTaBgP8B3N+yQomTltL0
jU2R699n1YzczNhBrvfKQinp7lUz/oQsH9nJ+hb6uE5m1D1P8RoT60z9XA5DUUBU
ffcvid2in48ZtVVg3cFY5rd4G28a/dmJDfe9U6oqrX9c1Ue9RfDZK619DlO4+xEf
e4WtD6zhML3q+bOVxBeO9nQrp/6d2w==
=Rsmk
-----END PGP SIGNATURE-----

--Sig_//JxyEEp0Z.6I8p35=DwmN0Z--
