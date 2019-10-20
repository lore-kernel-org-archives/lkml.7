Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0397BCA9EAE
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D136220869
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wjk/GMBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfJTT2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 15:28:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41952 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfJTT2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 15:28:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so6943136pfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nR5/PUycvY3vVFKY1gw3WwFO6bJ14K3sXYLBVXSi9VY=;
        b=Wjk/GMBQLsHEzT2/w1aDaC/FhEwRz5PVMC+wyOxAnn+YhUDJzFix/mmNmDYxsOIygj
         Z5U1v2OphFon6mejTVenFgy4cfkeY3YzrbtTE2WBn8KzgvPyUc9Uao66q7JI6B6SMHaL
         xcmH0FWJB6Px8d5ILH9yeEWdKP9+EE8BMifIxZ+VAei9LRX5dfpeo7YD04u1RAIeN0bp
         zlcPXLnkL4vezEXbBewAZXmjPUuRkiMKSw2QNrNWuwXFvnbh16tXx+Szyu7jNoq2FC8d
         DbOkKX3nuSZ8OwHwUO2gGq1UICUFEbf0JGCiLPaQtWOK70WqId6DZFbFULBAANvKDhvz
         zDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nR5/PUycvY3vVFKY1gw3WwFO6bJ14K3sXYLBVXSi9VY=;
        b=Ad7956s8ZnwbNOlPSqjOE7kgobNOANwLrULguzP6sEoCTjcOYApSCvjAv5FUCydVAS
         xovcAL0rWevkQn/Jq6pM+B8DBEVAqr7p+edmhsiaCxIgFJmqxcoHTZ5VY2Cxt1lrnKID
         ISxx6bbxI2Bz+gfZ7TadN8FXrxs2HeTSGpWsJErgjdmuuGunJm01Fgh6LxPjvqT5/zYa
         moq1nSTUZxKtZTzaNnBbl0mor2ifVzYcSsZW3+ElXpJjI9Yv5m7tGmyxP+k/tuUtAnG0
         eGHYHfAP+IOnoAvIfD3KUkpOw6obSFaaWgBSBLPd93b0Avl/T6FDtAVln60xYwYXGJs9
         6RoA==
X-Gm-Message-State: APjAAAVXrb6ly+esOAJxj1PviEYuNFCtqynGPHhjW7rym5pUhqzwInu6
        LYCdYY6N7N74g4Cu4r7ASNo=
X-Google-Smtp-Source: APXvYqwp7wjSNWzeTWuX/bI6akg2I4lMGylDNLvJ0EkJJHQpeuRn8Aza+tyzcHjom9yq8uEbMs2mOA==
X-Received: by 2002:a17:90a:d588:: with SMTP id v8mr23905743pju.51.1571599729521;
        Sun, 20 Oct 2019 12:28:49 -0700 (PDT)
Received: from localhost.localdomain ([103.97.240.176])
        by smtp.gmail.com with ESMTPSA id p88sm12494994pjp.22.2019.10.20.12.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 12:28:48 -0700 (PDT)
From:   Pratik Shinde <pratikshinde320@gmail.com>
To:     linux-erofs@lists.ozlabs.org, gaoxiang25@huawei.com,
        yuchao0@huawei.com
Cc:     linux-kernel@vger.kernel.org,
        Pratik Shinde <pratikshinde320@gmail.com>
Subject: [PATCH] erofs: code for verifying superblock checksum of an erofs image.
Date:   Mon, 21 Oct 2019 00:58:28 +0530
Message-Id: <20191020192828.10772-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for kernel side changes of checksum feature.I used kernel's
crc32c library for calculating the checksum.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 fs/erofs/erofs_fs.h |  5 +++--
 fs/erofs/internal.h |  2 +-
 fs/erofs/super.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b1ee565..bab5506 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -17,6 +17,7 @@
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
+#define EROFS_FEATURE_SB_CHKSUM 0x0001
 
 /* 128-byte erofs on-disk super block */
 struct erofs_super_block {
@@ -37,8 +38,8 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-
-	__u8 reserved2[44];
+	__le32 chksum_blocks;	/* number of blocks used for checksum */
+	__u8 reserved2[40];
 };
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 544a453..cd3af45 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -86,7 +86,7 @@ struct erofs_sb_info {
 	u8 uuid[16];                    /* 128-bit uuid for volume */
 	u8 volume_name[16];             /* volume name */
 	u32 feature_incompat;
-
+	u32 features;
 	unsigned int mount_opt;
 };
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0e36949..94e1d6a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -9,6 +9,7 @@
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <linux/crc32c.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -46,6 +47,45 @@ void _erofs_info(struct super_block *sb, const char *function,
 	va_end(args);
 }
 
+static int erofs_validate_sb_chksum(struct erofs_super_block *dsb,
+				       struct super_block *sb)
+{
+	u32 disk_chksum = le32_to_cpu(dsb->checksum);
+	u32 nblocks = le32_to_cpu(dsb->chksum_blocks);
+	u32 crc;
+	struct erofs_super_block *dsb2;
+	char *buf;
+	unsigned int off = 0;
+	void *kaddr;
+	struct page *page;
+	int i, ret = -EINVAL;
+
+	buf = kmalloc(nblocks * EROFS_BLKSIZ, GFP_KERNEL);
+	if (!buf)
+		goto out;
+	for (i = 0; i < nblocks; i++) {
+		page = erofs_get_meta_page(sb, i);
+		if (IS_ERR(page))
+			goto out;
+		kaddr = kmap_atomic(page);
+		(void) memcpy(buf + off, kaddr, EROFS_BLKSIZ);
+		kunmap_atomic(kaddr);
+		unlock_page(page);
+		/* first page will be released by erofs_read_superblock */
+		if (i != 0)
+			put_page(page);
+		off += EROFS_BLKSIZ;
+	}
+	dsb2 = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
+	dsb2->checksum = 0;
+	crc = crc32c(0, buf, nblocks * EROFS_BLKSIZ);
+	if (crc != disk_chksum)
+		goto out;
+	ret = 0;
+out:	kfree(buf);
+	return ret;
+}
+
 static void erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
@@ -109,18 +149,20 @@ static int erofs_read_superblock(struct super_block *sb)
 		erofs_err(sb, "cannot read erofs superblock");
 		return PTR_ERR(page);
 	}
-
 	sbi = EROFS_SB(sb);
-
 	data = kmap_atomic(page);
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
-
 	ret = -EINVAL;
 	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
 		erofs_err(sb, "cannot find valid erofs superblock");
 		goto out;
 	}
-
+	if (dsb->feature_compat & EROFS_FEATURE_SB_CHKSUM) {
+		if (erofs_validate_sb_chksum(dsb, sb)) {
+			erofs_err(sb, "super block checksum incorrect");
+			goto out;
+		}
+	}
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
-- 
2.9.3

