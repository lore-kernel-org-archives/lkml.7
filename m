Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9170EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63997217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfCNRXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:23:15 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:53174 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfCNRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:23:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 06E4C1802DF6C;
        Thu, 14 Mar 2019 18:16:18 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-fscrypt@vger.kernel.org, jaegeuk@kernel.org, tytso@mit.edu,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paullawrence@google.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/4] ubifs: Simplify fscrypt_get_encryption_info() error handling
Date:   Thu, 14 Mar 2019 18:15:58 +0100
Message-Id: <20190314171559.27584-4-richard@nod.at>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190314171559.27584-1-richard@nod.at>
References: <CAJfpegvX4ANfso-Jn1zaB+m4Q_0eK9i-+MCJ+sTH5QzD3PZFMQ@mail.gmail.com>
 <20190314171559.27584-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fscrypt_get_encryption_info() does not return -ENOKEY,
there is no need to handle this case.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 5767b373a8ff..b0cb913697c5 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -526,7 +526,7 @@ static int ubifs_readdir(struct file *file, struct di=
r_context *ctx)
=20
 	if (encrypted) {
 		err =3D fscrypt_get_encryption_info(dir);
-		if (err && err !=3D -ENOKEY)
+		if (err)
 			return err;
=20
 		err =3D fscrypt_fname_alloc_buffer(dir, UBIFS_MAX_NLEN, &fstr);
@@ -794,7 +794,7 @@ static int ubifs_unlink(struct inode *dir, struct den=
try *dentry)
=20
 	if (ubifs_crypt_is_encrypted(dir)) {
 		err =3D fscrypt_get_encryption_info(dir);
-		if (err && err !=3D -ENOKEY)
+		if (err)
 			return err;
 	}
=20
@@ -904,7 +904,7 @@ static int ubifs_rmdir(struct inode *dir, struct dent=
ry *dentry)
=20
 	if (ubifs_crypt_is_encrypted(dir)) {
 		err =3D fscrypt_get_encryption_info(dir);
-		if (err && err !=3D -ENOKEY)
+		if (err)
 			return err;
 	}
=20
--=20
2.21.0

