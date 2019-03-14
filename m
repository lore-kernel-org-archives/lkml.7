Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AE0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3308B2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfCNRXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:23:14 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:53164 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfCNRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:23:13 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Mar 2019 13:23:12 EDT
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id A4EC818013763;
        Thu, 14 Mar 2019 18:16:20 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-fscrypt@vger.kernel.org, jaegeuk@kernel.org, tytso@mit.edu,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paullawrence@google.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/4] fscrypt: Implement FS_CFLG_OWN_D_OPS
Date:   Thu, 14 Mar 2019 18:15:56 +0100
Message-Id: <20190314171559.27584-2-richard@nod.at>
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

If a filesystem sets FS_CFLG_OWN_D_OPS it manages dentry operations
itself and fscrypt is not allowed to set them.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/crypto/hooks.c       | 4 +++-
 include/linux/fscrypt.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 56debb1fcf5e..3ec925405fbe 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -107,7 +107,9 @@ int __fscrypt_prepare_lookup(struct inode *dir, struc=
t dentry *dentry)
 		spin_unlock(&dentry->d_lock);
 	}
=20
-	d_set_d_op(dentry, &fscrypt_d_ops);
+	if ((dir->i_sb->s_cop->flags & FS_CFLG_OWN_D_OPS) =3D=3D 0)
+		d_set_d_op(dentry, &fscrypt_d_ops);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index e5194fc3983e..7139a110ac4f 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -48,6 +48,7 @@ struct fscrypt_name {
  * fscrypt superblock flags
  */
 #define FS_CFLG_OWN_PAGES (1U << 1)
+#define FS_CFLG_OWN_D_OPS (1U << 2)
=20
 /*
  * crypto operations for filesystems
--=20
2.21.0

