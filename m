Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F0AC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED760205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rnmCSXI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfECAVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:21:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42289 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfECAVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:21:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44wCTt58BYz9s6w;
        Fri,  3 May 2019 10:21:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556842866;
        bh=iB2kFXGtEnOSbwiR9xeXR4mCwyLISyBZiA2Ze3gRu8Q=;
        h=Date:From:To:Cc:Subject:From;
        b=rnmCSXI9cMUnLeXno9pURgO/Biwsc2t2Xp1DQ+jJe4DbYzI6fvntgfij8LyCJqnGm
         EGgYkPkFnlCRnmRrj3CKW1QcGqD6CXSYpNt0axmFEuEMcBAaZO7mf4gosWC0aVhojS
         Z3oRP8Ag0OTmkkFBMr7zocO+EsQB9G4jsZnZ+XgDRkzpFmv6QjyA2tqWaikgNChSb5
         NBXV+LpPkwnzgP+rTnqcKJN6KQX5RGDybhcXyQS6F8N6JcRS4gRUmT9a56DFlHTEwr
         +hQBvdQfltw5TS+Y1ZIsadXmkdmB2Q5t8A9vzN89nMODiZn0+gFgI0hJe5IPF2axEM
         i+fnX/+B+R8DQ==
Date:   Fri, 3 May 2019 10:21:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: linux-next: build warning after merge of the btrfs-kdave tree
Message-ID: <20190503102105.13578cc9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K4F6Rk6H_h3u9KOnGG440l4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K4F6Rk6H_h3u9KOnGG440l4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

After merging the btrfs-kdave tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

fs/btrfs/props.c: In function 'inherit_props':
fs/btrfs/props.c:389:4: warning: 'num_bytes' may be used uninitialized in t=
his function [-Wmaybe-uninitialized]
    btrfs_block_rsv_release(fs_info, trans->block_rsv,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      num_bytes);
      ~~~~~~~~~~

Probably introduced by commit

  b835a4a3faec ("btrfs: use the existing reserved items for our first prop =
for inheritance")

Looks like a false positive to me.

--=20
Cheers,
Stephen Rothwell

--Sig_/K4F6Rk6H_h3u9KOnGG440l4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzLiXEACgkQAVBC80lX
0GzPiAgAkCD5vW0p2Wllg6dt5AOJU2az/iQDy4SvSYz2JLvLvpOUnOpHs9YU+A9F
mrWb8vkCUNq8ZJq79dHE3ICdlo9JsqHNfz1SOHTUc4uh4P7Dc5AUeO5kxFq8elm6
GC+5XlfRPpMlMAlGeQbplcAYUdq//cZOfRUHXADQSlS8/cZmjVzFfdXuUwha4qDg
YuVIwEvs55573nvbH1T+a2QzYYatmiNIJlglzbHLoDgdKSiy1hbev1EYOT+CNiJu
zCiHWaiinNyb8QeZwAJ+qBvJmjq56Md7i0CVY2pLLHSU6qkw4plGQCWNL9h+ctjr
/wyP92ilqxutPot/OButB7m0Zzs6mA==
=wCvO
-----END PGP SIGNATURE-----

--Sig_/K4F6Rk6H_h3u9KOnGG440l4--
