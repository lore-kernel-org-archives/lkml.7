Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA04BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770892086D
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptV9anfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbfJVPkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:40:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43567 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbfJVPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:40:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so10880775pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+0awgcrU0T0gJr+sSnKtP3Vx7pwyrZ4ja7Mttfvl/RM=;
        b=ptV9anfs6GPxZoupqgTAdWXbToAEdpkjso3HaFKaHa87FGi+1V9TCAfkSJBHlxcDl4
         KZ/BGcCqnStgrkx4RojbK921FbE80nYktDJMw1d1TfC2I7WMFECpNFfOqliYL/sqqygc
         o89ONML8Vgzkeu5Jk/23T2PUEJPIl/o3xv0Iq0huanxL+DlJvVHLopetTpNMZCmuEdPI
         sdjQwc/PZL5aHdSkDfBpCSQPjoWPF8k5h/RBsKoh+2alue0colVNMdmB+gipEu1Jqk6J
         XU7WDAZ+pe85eRf//yjQEke8MnXe45cdn06w4/gqgN1lTUX/QeEy6hdmLZnWCjz979KY
         MYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+0awgcrU0T0gJr+sSnKtP3Vx7pwyrZ4ja7Mttfvl/RM=;
        b=kSVfBtyjNwkQ0JE3r/W5LmClNijirupOIryLyM9onRvBQjwMiEmal6JHEguouQpCqV
         KE2c7ujCroFYQLpg6ymyU5JaXi7PmKNIxQ17JlfvrCD8EEz0XTLa2yC/bsZTGF1qJrs4
         aqvTq4+KFbuE9Hw0WKwCucTeOLe24w3zeQXixYqEg5y+nJ51g79Mj6VtQaN6JnoLeqrQ
         wvUFRxCNGOebYKiuNiTwKYKB+Sn1nBZxviFKObs6ElnnTP/UkMU8c8gAKVluECMs/gZN
         4u8aEgoOesb/oc4sntIDqn/QM7dnltIu8CG70AyGEat07T8HOvcD+9M2E5KjMBmSjBhP
         N3Kg==
X-Gm-Message-State: APjAAAWXXnTVaf9g+lZ4GWwDYs5kiayK8/COUdaQqxq8qwcnBHzMV/xx
        BX8SfH2Ia4UQloXs3hbpstlfZi+Pxl6qAg==
X-Google-Smtp-Source: APXvYqyhOzqPkG9SY667uXj7vH84dggmUhKFAaW+1vl+BwIHPrCdFqxt+lrxu5e11Q/329BPT36VxA==
X-Received: by 2002:a62:ae06:: with SMTP id q6mr5021963pff.96.1571758810041;
        Tue, 22 Oct 2019 08:40:10 -0700 (PDT)
Received: from localhost.localdomain ([42.107.68.84])
        by smtp.gmail.com with ESMTPSA id j10sm19681856pfn.128.2019.10.22.08.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 08:40:09 -0700 (PDT)
From:   Pratik Shinde <pratikshinde320@gmail.com>
To:     linux-erofs@lists.ozlabs.org, gaoxiang25@huawei.com,
        yuchao0@huawei.com
Cc:     linux-kernel@vger.kernel.org,
        Pratik Shinde <pratikshinde320@gmail.com>
Subject: [PATCH-v2] erofs: code for verifying superblock checksum of an erofs image.
Date:   Tue, 22 Oct 2019 21:09:56 +0530
Message-Id: <20191022153956.16867-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for kernel side changes of checksum feature.Used kernel's
crc32c library for calculating the checksum.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 fs/erofs/erofs_fs.h |  5 +++--
 fs/erofs/internal.h |  3 ++-
 fs/erofs/super.c    | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b1ee565..4d8097a 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -17,6 +17,7 @@
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
+#define EROFS_FEATURE_COMPAT_SB_CHKSUM 		0x00000001
 
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
index 544a453..cec27ca 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -86,7 +86,7 @@ struct erofs_sb_info {
 	u8 uuid[16];                    /* 128-bit uuid for volume */
 	u8 volume_name[16];             /* volume name */
 	u32 feature_incompat;
-
+	u32 feature_compat;
 	unsigned int mount_opt;
 };
 
@@ -426,6 +426,7 @@ static inline void z_erofs_exit_zip_subsystem(void) {}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
+#define EFSBADCRC	EBADMSG		/* Bad crc found */
 
 #endif	/* __EROFS_INTERNAL_H */
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0e36949..9cda72d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -9,6 +9,7 @@
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <linux/crc32c.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -46,6 +47,31 @@ void _erofs_info(struct super_block *sb, const char *function,
 	va_end(args);
 }
 
+static int erofs_validate_sb_chksum(struct erofs_super_block *dsb,
+				       struct super_block *sb)
+{
+	u32 disk_chksum, nblocks, crc = 0;
+	void *kaddr;
+	struct page *page;
+	int i;
+
+	disk_chksum = le32_to_cpu(dsb->checksum);
+	nblocks = le32_to_cpu(dsb->chksum_blocks);
+	dsb->checksum = 0;
+	for (i = 0; i < nblocks; i++) {
+		page = erofs_get_meta_page(sb, i);
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+		kaddr = kmap(page);
+		crc = crc32c(crc, kaddr, EROFS_BLKSIZ);
+		kunmap(page);
+		unlock_page(page);
+	}
+	if (crc != disk_chksum)
+		return -EFSBADCRC;
+	return 0;
+}
+
 static void erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
@@ -121,6 +147,13 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 	}
 
+	if (dsb->feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM) {
+		ret = erofs_validate_sb_chksum(dsb, sb);
+		if (ret < 0) {
+			erofs_err(sb, "super block checksum incorrect");
+			goto out;
+		}
+	}
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
-- 
2.9.3

