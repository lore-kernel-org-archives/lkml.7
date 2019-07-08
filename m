Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32406C606A1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFD320665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iPOa1yaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfGHJXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:23:52 -0400
Received: from ozlabs.org ([203.11.71.1]:47587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfGHJXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:23:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45j0Pb40jTz9sNx;
        Mon,  8 Jul 2019 19:23:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562577829;
        bh=WoJLpcljuHo/F0ZtvO6PX/LOkh76vKueq9DXlrSy+Sk=;
        h=Date:From:To:Cc:Subject:From;
        b=iPOa1yawyTjrhs6Uc3KRQl24I23tVEwMsORvoBNps/HtGDQnJMjg9fJUQaegmz6bk
         +QA8NadeVn/OqU6Gq0UFawTclYzjJPtPQJwYDFnsiLcoxWhRXTsSBe3GLnfUt6naSV
         G9QKL0ejcD+CPIe75+872wO/07vkRJfxLg1L6xtGLTC5KoYImRZGiZSefo7pfqytL1
         PWMsX9Q4T9T1/71N5RhINRw0wJtmffjnsuVLWoAYerUocLy3peuW2odxZryQ3YWRP4
         IewSAz0lqkzNJtofD1FRPfoNhtUYe8Q2DbKHxlAW3NhL42V18m8EW4rNPXG0+/Beav
         6fT0cijwmi4Rg==
Date:   Mon, 8 Jul 2019 19:23:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Nadav Amit <namit@vmware.com>
Subject: linux-next: build failure after merge of the char-misc tree
Message-ID: <20190708192345.53fce4cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gmOY+g3Rcwb.2Ufy42sw0dg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gmOY+g3Rcwb.2Ufy42sw0dg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the char-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/misc/vmw_balloon.c: In function 'vmballoon_mount':
drivers/misc/vmw_balloon.c:1736:14: error: 'simple_dname' undeclared (first=
 use in this function); did you mean 'simple_rename'?
   .d_dname =3D simple_dname,
              ^~~~~~~~~~~~
              simple_rename
drivers/misc/vmw_balloon.c:1736:14: note: each undeclared identifier is rep=
orted only once for each function it appears in
drivers/misc/vmw_balloon.c:1739:9: error: implicit declaration of function =
'mount_pseudo'; did you mean 'mount_bdev'? [-Werror=3Dimplicit-function-dec=
laration]
  return mount_pseudo(fs_type, "balloon-vmware:", NULL, &ops,
         ^~~~~~~~~~~~
         mount_bdev
drivers/misc/vmw_balloon.c:1739:9: warning: returning 'int' from a function=
 with return type 'struct dentry *' makes pointer from integer without a ca=
st [-Wint-conversion]
  return mount_pseudo(fs_type, "balloon-vmware:", NULL, &ops,
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        BALLOON_VMW_MAGIC);
        ~~~~~~~~~~~~~~~~~~

Caused by commit

  83a8afa72e9c ("vmw_balloon: Compaction support")

interacting with commits

  7e5f7bb08b8c ("unexport simple_dname()")
  8d9e46d80777 ("fold mount_pseudo_xattr() into pseudo_fs_get_tree()")

from the vfs tree.

I applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 8 Jul 2019 19:17:56 +1000
Subject: [PATCH] convert vmwballoon to use the new mount API

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/misc/vmw_balloon.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 91fa43051535..e8c0f7525f13 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/mount.h>
+#include <linux/pseudo_fs.h>
 #include <linux/balloon_compaction.h>
 #include <linux/vmw_vmci_defs.h>
 #include <linux/vmw_vmci_api.h>
@@ -1728,21 +1729,14 @@ static inline void vmballoon_debugfs_exit(struct vm=
balloon *b)
=20
 #ifdef CONFIG_BALLOON_COMPACTION
=20
-static struct dentry *vmballoon_mount(struct file_system_type *fs_type,
-				      int flags, const char *dev_name,
-				      void *data)
+static int vmballoon_init_fs_context(struct fs_context *fc)
 {
-	static const struct dentry_operations ops =3D {
-		.d_dname =3D simple_dname,
-	};
-
-	return mount_pseudo(fs_type, "balloon-vmware:", NULL, &ops,
-			    BALLOON_VMW_MAGIC);
+	return init_pseudo(fc, BALLOON_VMW_MAGIC) ? 0 : -ENOMEM;
 }
=20
 static struct file_system_type vmballoon_fs =3D {
 	.name           =3D "balloon-vmware",
-	.mount          =3D vmballoon_mount,
+	.init_fs_context          =3D vmballoon_init_fs_context,
 	.kill_sb        =3D kill_anon_super,
 };
=20
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/gmOY+g3Rcwb.2Ufy42sw0dg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jC6EACgkQAVBC80lX
0GxTegf9G11i4nX5i36O7bpMe6NcHZbERNWK80vL/coNywaOh7TdWnBeOAQk9X6Q
BtEfbHNU7dQudjdqUS+OGSoXA+qlvPK3daNRQ+YGubt+LrapK/Q3BI/Uy2LK2kGb
6LNIgdTwWE7aCALpcvGLrgM7aByk6ukGNvRNEiJG3kOMk0AnxO9gWwADIKzNqdUt
r6G1rb7yeTN+3KFvNmKBnTFFSjl0j4aRA9q7s4/hMnMFFTm9KDYD7geGuCuugQMN
PnZ8/H94VvMcnLZxvBSHlnfwmnmVMrg0od+Rp/AsvvUX8vwGmJBXN+TH/+pKb5CH
cl4CUFwD6xM0HqGsW/GafxrROu9c9A==
=21Y0
-----END PGP SIGNATURE-----

--Sig_/gmOY+g3Rcwb.2Ufy42sw0dg--
