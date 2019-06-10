Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23816C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CBA2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbfFJJhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:37:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389056AbfFJJhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:37:34 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DB295FBDEE9AA47707F5;
        Mon, 10 Jun 2019 17:37:32 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 10 Jun
 2019 17:37:23 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 2/2] staging: erofs: rename data_mapping_mode to datamode
Date:   Mon, 10 Jun 2019 17:36:40 +0800
Message-ID: <20190610093640.96705-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610093640.96705-1-gaoxiang25@huawei.com>
References: <20190610093640.96705-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

data_mapping_mode is too long as a member name of erofs_vnode,
datamode is straight-forward enough.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/inode.c    | 17 ++++++++---------
 drivers/staging/erofs/internal.h | 10 ++++------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 9520419f746c..e51348f7e838 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -22,11 +22,11 @@ static int read_inode(struct inode *inode, void *data)
 	const unsigned int advise = le16_to_cpu(v1->i_advise);
 	erofs_blk_t nblks = 0;
 
-	vi->data_mapping_mode = __inode_data_mapping(advise);
+	vi->datamode = __inode_data_mapping(advise);
 
-	if (unlikely(vi->data_mapping_mode >= EROFS_INODE_LAYOUT_MAX)) {
-		errln("unknown data mapping mode %u of nid %llu",
-		      vi->data_mapping_mode, vi->nid);
+	if (unlikely(vi->datamode >= EROFS_INODE_LAYOUT_MAX)) {
+		errln("unsupported data mapping %u of nid %llu",
+		      vi->datamode, vi->nid);
 		DBG_BUGON(1);
 		return -EIO;
 	}
@@ -63,7 +63,7 @@ static int read_inode(struct inode *inode, void *data)
 		inode->i_size = le64_to_cpu(v2->i_size);
 
 		/* total blocks for compressed files */
-		if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
+		if (is_inode_layout_compression(inode))
 			nblks = le32_to_cpu(v2->i_u.compressed_blocks);
 	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
 		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
@@ -95,7 +95,7 @@ static int read_inode(struct inode *inode, void *data)
 			sbi->build_time_nsec;
 
 		inode->i_size = le32_to_cpu(v1->i_size);
-		if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
+		if (is_inode_layout_compression(inode))
 			nblks = le32_to_cpu(v1->i_u.compressed_blocks);
 	} else {
 		errln("unsupported on-disk inode version %u of nid %llu",
@@ -127,7 +127,7 @@ static int fill_inline_data(struct inode *inode, void *data,
 {
 	struct erofs_vnode *vi = EROFS_V(inode);
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
-	int mode = vi->data_mapping_mode;
+	const int mode = vi->datamode;
 
 	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
 
@@ -299,9 +299,8 @@ int erofs_getattr(const struct path *path, struct kstat *stat,
 		  u32 request_mask, unsigned int query_flags)
 {
 	struct inode *const inode = d_inode(path->dentry);
-	struct erofs_vnode *const vi = EROFS_V(inode);
 
-	if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
+	if (is_inode_layout_compression(inode))
 		stat->attributes |= STATX_ATTR_COMPRESSED;
 
 	stat->attributes |= STATX_ATTR_IMMUTABLE;
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 911333cdeef4..6a7eb04d29b4 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -347,8 +347,7 @@ struct erofs_vnode {
 	/* atomic flags (including bitlocks) */
 	unsigned long flags;
 
-	unsigned char data_mapping_mode;
-	/* inline size in bytes */
+	unsigned char datamode;
 	unsigned char inode_isize;
 	unsigned short xattr_isize;
 
@@ -383,18 +382,17 @@ static inline unsigned long inode_datablocks(struct inode *inode)
 
 static inline bool is_inode_layout_plain(struct inode *inode)
 {
-	return EROFS_V(inode)->data_mapping_mode == EROFS_INODE_LAYOUT_PLAIN;
+	return EROFS_V(inode)->datamode == EROFS_INODE_LAYOUT_PLAIN;
 }
 
 static inline bool is_inode_layout_compression(struct inode *inode)
 {
-	return EROFS_V(inode)->data_mapping_mode ==
-					EROFS_INODE_LAYOUT_COMPRESSION;
+	return EROFS_V(inode)->datamode == EROFS_INODE_LAYOUT_COMPRESSION;
 }
 
 static inline bool is_inode_layout_inline(struct inode *inode)
 {
-	return EROFS_V(inode)->data_mapping_mode == EROFS_INODE_LAYOUT_INLINE;
+	return EROFS_V(inode)->datamode == EROFS_INODE_LAYOUT_INLINE;
 }
 
 extern const struct super_operations erofs_sops;
-- 
2.17.1

