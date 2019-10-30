Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26670CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 05:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC79C20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 05:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfJ3FGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 01:06:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbfJ3FGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 01:06:13 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 04441AD359BF000244D6;
        Wed, 30 Oct 2019 13:06:11 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 30 Oct
 2019 13:06:00 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <chao@kernel.org>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <yuchao0@huawei.com>,
        "Pratik Shinde" <pratikshinde320@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v6] erofs: support superblock checksum
Date:   Wed, 30 Oct 2019 13:08:46 +0800
Message-ID: <20191030050846.175623-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030025616.GB161610@architecture4>
References: <20191030025616.GB161610@architecture4>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratik Shinde <pratikshinde320@gmail.com>

Introduce superblock checksum feature in order to
check at mounting time.

Note that the first 1024 bytes are ignore for x86
boot sectors and other oddities.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
changes since v5:
 - update commit message which was missed in v5.

 fs/erofs/Kconfig    |  1 +
 fs/erofs/erofs_fs.h |  3 ++-
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    | 36 ++++++++++++++++++++++++++++++++++--
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 9d634d3a1845..74b0aaa7114c 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -3,6 +3,7 @@
 config EROFS_FS
 	tristate "EROFS filesystem support"
 	depends on BLOCK
+	select LIBCRC32C
 	help
 	  EROFS (Enhanced Read-Only File System) is a lightweight
 	  read-only file system with modern designs (eg. page-sized
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b1ee5654750d..385fa49c7749 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -11,6 +11,8 @@
 
 #define EROFS_SUPER_OFFSET      1024
 
+#define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
+
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
  * be incompatible with this kernel version.
@@ -37,7 +39,6 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-
 	__u8 reserved2[44];
 };
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 544a453f3076..a3778f597bf6 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -85,6 +85,7 @@ struct erofs_sb_info {
 
 	u8 uuid[16];                    /* 128-bit uuid for volume */
 	u8 volume_name[16];             /* volume name */
+	u32 feature_compat;
 	u32 feature_incompat;
 
 	unsigned int mount_opt;
@@ -426,6 +427,7 @@ static inline void z_erofs_exit_zip_subsystem(void) {}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
+#define EFSBADCRC       EBADMSG         /* Bad CRC detected */
 
 #endif	/* __EROFS_INTERNAL_H */
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0e369494f2f2..2fcf44b656dd 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -9,6 +9,7 @@
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <linux/crc32c.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -46,6 +47,30 @@ void _erofs_info(struct super_block *sb, const char *function,
 	va_end(args);
 }
 
+static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
+{
+	struct erofs_super_block *dsb;
+	u32 expected_crc, crc;
+
+	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET,
+		      EROFS_BLKSIZ - EROFS_SUPER_OFFSET, GFP_KERNEL);
+	if (!dsb)
+		return -ENOMEM;
+
+	expected_crc = le32_to_cpu(dsb->checksum);
+	dsb->checksum = 0;
+	/* to allow for x86 boot sectors and other oddities. */
+	crc = crc32c(~0, dsb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
+	kfree(dsb);
+
+	if (crc != expected_crc) {
+		erofs_err(sb, "invalid checksum 0x%08x, 0x%08x expected",
+			  crc, expected_crc);
+		return -EFSBADCRC;
+	}
+	return 0;
+}
+
 static void erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
@@ -112,7 +137,7 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	sbi = EROFS_SB(sb);
 
-	data = kmap_atomic(page);
+	data = kmap(page);
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
@@ -121,6 +146,13 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 	}
 
+	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
+	if (sbi->feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM) {
+		ret = erofs_superblock_csum_verify(sb, data);
+		if (ret)
+			goto out;
+	}
+
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
@@ -155,7 +187,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 	ret = 0;
 out:
-	kunmap_atomic(data);
+	kunmap(data);
 	put_page(page);
 	return ret;
 }
-- 
2.17.1

