Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0357DC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45E420644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfG2Gw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:52:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfG2Gw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:52:26 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 11FA1FD40DBE7A999088;
        Mon, 29 Jul 2019 14:52:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:18 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 04/22] staging: erofs: keep up erofs_fs.h with erofs-outofstaging patchset
Date:   Mon, 29 Jul 2019 14:51:41 +0800
Message-ID: <20190729065159.62378-5-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729065159.62378-1-gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main change is to reserve all checksums except for superblock,
since it's more useful to do block-based verity for read-only fs.

Some comments change as well, which is minor.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/erofs_fs.h | 39 ++++++++++++++++----------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index 9cd749d56920..e82e833985e4 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -96,7 +96,7 @@ struct erofs_inode_v1 {
 /* 20 */__le32 i_ino;           /* only used for 32-bit stat compatibility */
 /* 24 */__le16 i_uid;
 /* 26 */__le16 i_gid;
-/* 28 */__le32 i_checksum;
+/* 28 */__le32 i_reserved2;
 } __packed;
 
 /* 32 bytes on-disk inode */
@@ -105,14 +105,14 @@ struct erofs_inode_v1 {
 #define EROFS_INODE_LAYOUT_V2   1
 
 struct erofs_inode_v2 {
-	__le16 i_advise;
+/*  0 */__le16 i_advise;
 
-	/* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
-	__le16 i_xattr_icount;
-	__le16 i_mode;
-	__le16 i_reserved;      /* 8 bytes */
-	__le64 i_size;          /* 16 bytes */
-	union {
+/* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
+/*  2 */__le16 i_xattr_icount;
+/*  4 */__le16 i_mode;
+/*  6 */__le16 i_reserved;
+/*  8 */__le64 i_size;
+/* 16 */union {
 		/* file total compressed blocks for data mapping 1 */
 		__le32 compressed_blocks;
 		__le32 raw_blkaddr;
@@ -122,16 +122,15 @@ struct erofs_inode_v2 {
 	} i_u __packed;
 
 	/* only used for 32-bit stat compatibility */
-	__le32 i_ino;           /* 24 bytes */
-
-	__le32 i_uid;
-	__le32 i_gid;
-	__le64 i_ctime;         /* 32 bytes */
-	__le32 i_ctime_nsec;
-	__le32 i_nlink;
-	__u8   i_reserved2[12];
-	__le32 i_checksum;      /* 64 bytes */
-} __packed;
+/* 20 */__le32 i_ino;
+
+/* 24 */__le32 i_uid;
+/* 28 */__le32 i_gid;
+/* 32 */__le64 i_ctime;
+/* 40 */__le32 i_ctime_nsec;
+/* 44 */__le32 i_nlink;
+/* 48 */__u8   i_reserved2[16];
+} __packed;                     /* 64 bytes */
 
 #define EROFS_MAX_SHARED_XATTRS         (128)
 /* h_shared_count between 129 ... 255 are special # */
@@ -149,9 +148,9 @@ struct erofs_inode_v2 {
  * for read-only fs, no need to introduce h_refcount
  */
 struct erofs_xattr_ibody_header {
-	__le32 h_checksum;
+	__le32 h_reserved;
 	__u8   h_shared_count;
-	__u8   h_reserved[7];
+	__u8   h_reserved2[7];
 	__le32 h_shared_xattrs[0];      /* shared xattr id array */
 } __packed;
 
-- 
2.17.1

