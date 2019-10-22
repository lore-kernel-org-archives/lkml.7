Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7563CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F9520B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMHFSLUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbfJVSGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 14:06:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36245 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJVSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:06:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so11138734pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C57rjg6MzRUCmDbY5EjraOl4/clbYwioVc55Zqi6SCI=;
        b=DMHFSLUJy7N2hDrh4gMPJFjEcTowuAM7wxu+qWBstze/RxyphtMddCieoG2G8BvQLT
         CVKO/b/SKx0d73/DMqsv6U7JEAaJ9US7vu1ZYc9x3gtmKbskCN4Yl7+pKQxaO3fm6JtU
         hHQIgdgF3UXP0FbaHEDySS0c6cfDXD1ssbbn1RFEqoKVczoytoBToNjJzLwT9ZGrsBNA
         VciZjlyRGcubwselE2wFRGm72Pq3Ctp197cAjEQkGecq6PmUuKSVPmU4CS8y/RadYQ49
         YVVZPFQzjYEGHT1ctY7ewuHMp3DZtatRiq8kOBFMkp+UOLignpQAow/KPaCES8IKZOFY
         +zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C57rjg6MzRUCmDbY5EjraOl4/clbYwioVc55Zqi6SCI=;
        b=F1+XHu8SeHupMSI9aJGmKV/ZR6rWjQ2kFw59PzkXsU2wRp5639vsaIfvoVgfWR1Sc7
         SwDkK8vL0hleuWz52WCqmN8mgfQZ97dmf4i1PE4dMahlG6bcZfusvLrnM93hbdhdFSrl
         VzitLU+8MMtkGGw7Az9R4BQQD54cdDRPG7SvUQkRaDPlREWi04zKEFqu43x9R4PJJpD4
         Q2cwdblNkELb5Zy7MFN6V1MHxnLWfOT2EPimScGMgoaHmnpXMEJc1sSNCt7754nM+w4d
         tJSs+ebgSgJMPEvzN+BriPNZbQKgWSs0wPWZuyIIGEaKCB4wgoy7AewDLNKiwWxooZ9m
         C7ZA==
X-Gm-Message-State: APjAAAXPL0k5xQrKJT6sGzL45r7rrTcBmNG8wdOyMwdL1uTiVBp7CwiX
        oC9GQeLJQR3Z1sXyMXJ96Es=
X-Google-Smtp-Source: APXvYqysMEhD3/SyyaKuW36KVVDfT583diD8uvaZHSczVswNE5j/t6bq+P8ysn5KBPHnHiRgl/MtmQ==
X-Received: by 2002:a62:28b:: with SMTP id 133mr5653669pfc.242.1571767595328;
        Tue, 22 Oct 2019 11:06:35 -0700 (PDT)
Received: from localhost.localdomain ([42.107.68.32])
        by smtp.gmail.com with ESMTPSA id 193sm21789218pfc.59.2019.10.22.11.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 11:06:34 -0700 (PDT)
From:   Pratik Shinde <pratikshinde320@gmail.com>
To:     linux-erofs@lists.ozlabs.org, gaoxiang25@huawei.com,
        yuchao0@huawei.com
Cc:     linux-kernel@vger.kernel.org,
        Pratik Shinde <pratikshinde320@gmail.com>
Subject: [PATCH-v3] erofs: code for verifying superblock checksum of an erofs image.
Date:   Tue, 22 Oct 2019 23:36:20 +0530
Message-Id: <20191022180620.19638-1-pratikshinde320@gmail.com>
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
 fs/erofs/super.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 3 deletions(-)

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
index 0e36949..a2a638a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -9,6 +9,7 @@
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <linux/crc32c.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -46,6 +47,42 @@ void _erofs_info(struct super_block *sb, const char *function,
 	va_end(args);
 }
 
+static int erofs_validate_sb_chksum(void  *sbdata, struct super_block *sb)
+{
+	u32 disk_chksum, nblocks, crc = 0;
+	void *kaddr;
+	struct page *page;
+	struct erofs_super_block *dsb;
+	char *buf;
+	int i, ret = 0;
+
+	buf = kmalloc(EROFS_BLKSIZ, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	memcpy(buf, sbdata, EROFS_BLKSIZ);
+	dsb = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
+	disk_chksum = le32_to_cpu(dsb->checksum);
+	nblocks = le32_to_cpu(dsb->chksum_blocks);
+	dsb->checksum = 0;
+	crc = crc32c(0, buf, EROFS_BLKSIZ);
+	for (i = 1; i < nblocks; i++) {
+		page = erofs_get_meta_page(sb, i);
+		if (IS_ERR(page)) {
+			ret = PTR_ERR(page);
+			goto out;
+		}
+		kaddr = kmap_atomic(page);
+		crc = crc32c(crc, kaddr, EROFS_BLKSIZ);
+		kunmap_atomic(kaddr);
+		unlock_page(page);
+		put_page(page);
+	}
+	if (crc != disk_chksum)
+		ret = -EFSBADCRC;
+out:	kfree(buf);
+	return ret;
+}
+
 static void erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
@@ -121,6 +158,13 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 	}
 
+	if (dsb->feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM) {
+		ret = erofs_validate_sb_chksum(data, sb);
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

