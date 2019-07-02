Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8388C06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 05:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA767205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 05:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JS2dzmpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGBFdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 01:33:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59941 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbfGBFdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 01:33:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45dCZ72fldz9sNC;
        Tue,  2 Jul 2019 15:33:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562045584;
        bh=Py03TsrTSqPZvsAlzC0udbst9os/bFEXC2ckL/F/Bjw=;
        h=Date:From:To:Cc:Subject:From;
        b=JS2dzmpOuYFT6WD/aV6BwCQhQARNJ9g68KsjukTbG4ezRS1JmUPSpiEbGQededdre
         sYZYtGxStP1M9eSj+HVIMe6gtOo034JlAUDsMolUgxBPxrJogzYID9nuiN+ddTUlRx
         oY/Iy9hp12fTNKFCz/D/8PdGGvLltKKQy46Un0fYHYRt2+GW/+zPpiZLQyRkQzm8EP
         gNqBkv4mQj9TsIdDuWAL177v+OHzO822OAl3IHz5t9l2UmqTfMQAySRH4oMIM/yQIU
         cuj6RhJ/2i7WmYNY+dxCGydbusAZoi6CdAsXiv8nmm2vVcdz3kfzd2gfeLrD0SVOQR
         aUHSli9aHeqnA==
Date:   Tue, 2 Jul 2019 15:33:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20190702153302.28e7948d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/txzI_x0Co6STgMd+jMsmZMm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/txzI_x0Co6STgMd+jMsmZMm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/btrfs/ctree.c: In function '__tree_mod_log_insert':
fs/btrfs/ctree.c:388:2: error: implicit declaration of function 'lockdep_as=
sert_held_exclusive'; did you mean 'lockdep_assert_held_once'? [-Werror=3Di=
mplicit-function-declaration]
  lockdep_assert_held_exclusive(&fs_info->tree_mod_log_lock);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  lockdep_assert_held_once

Caused by commit

  9ffbe8ac05db ("locking/lockdep: Rename lockdep_assert_held_exclusive() ->=
 lockdep_assert_held_write()")

interacting with commits

  84cd7723de7c ("btrfs: assert tree mod log lock in __tree_mod_log_insert")
  283d2e443505 ("btrfs: assert extent map tree lock in add_extent_mapping")

from the btrfs-kdave tree.

I have applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 2 Jul 2019 15:29:27 +1000
Subject: [PATCH] locking/lockdep: fix up for "Rename
 lockdep_assert_held_exclusive() -> lockdep_assert_held_write()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/btrfs/ctree.c      | 2 +-
 fs/btrfs/extent_map.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 99a585ede79d..9d1d0a926cb0 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -385,7 +385,7 @@ __tree_mod_log_insert(struct btrfs_fs_info *fs_info, st=
ruct tree_mod_elem *tm)
 	struct rb_node *parent =3D NULL;
 	struct tree_mod_elem *cur;
=20
-	lockdep_assert_held_exclusive(&fs_info->tree_mod_log_lock);
+	lockdep_assert_held_write(&fs_info->tree_mod_log_lock);
=20
 	tm->seq =3D btrfs_inc_tree_mod_seq(fs_info);
=20
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index a73af4159495..9d30acca55e1 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -384,7 +384,7 @@ int add_extent_mapping(struct extent_map_tree *tree,
 {
 	int ret =3D 0;
=20
-	lockdep_assert_held_exclusive(&tree->lock);
+	lockdep_assert_held_write(&tree->lock);
=20
 	ret =3D tree_insert(&tree->map, em);
 	if (ret)
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/txzI_x0Co6STgMd+jMsmZMm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0a7I4ACgkQAVBC80lX
0Gzy/gf/ZhXMQJT0gs+uX2UFL4s2ttguOUpnJ/rCXLirnhNofrUqD2EhX03nuAqg
RbZPB6AUCJos6qAcTDon/zAPiAOvNf4PpNeiSX29fqdEL2SMA+NWKaApW4hOG7Qf
BJB1V+JUMG9dxULNZ0w7e5rOBVYiGTyPMohVnR90NZBK366hiyEXhPKomSIk7HXy
pLE/bqxeUiGTuUC9CYWD+w59Cs/8MBGcx/UuWQHo4uneHbZ5d8fk5kHOVaaFBr7R
aAMGjCfo6DaYwQUf8jIK4WpBqpmaMYy3PCuNWsJBi2MbxdsDVY5Dl2benL7dazz5
h2kep/9zw2AQix05Z3NDK52bgNyo6g==
=O6jG
-----END PGP SIGNATURE-----

--Sig_/txzI_x0Co6STgMd+jMsmZMm--
