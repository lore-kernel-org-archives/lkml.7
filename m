Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81714C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3AE2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbfDAGyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:54:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfDAGyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:54:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AB6802778B14DD5E2360;
        Mon,  1 Apr 2019 14:54:00 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 1 Apr 2019
 14:53:52 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH for-4.19 2/2] staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()
Date:   Mon, 1 Apr 2019 14:53:09 +0800
Message-ID: <20190401065309.68109-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190401065309.68109-1-gaoxiang25@huawei.com>
References: <20190401065309.68109-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 33bac912840fe64dbc15556302537dc6a17cac63 upstream.

After commit 419d6efc50e9, kernel cannot be crashed in the namei
path. However, corrupted nameoff can do harm in the process of
readdir for scenerios without dm-verity as well. Fix it now.

Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
Cc: <stable@vger.kernel.org> # 4.19+
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/dir.c | 45 ++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
index 04b84ff31d03..0a089cf5c78f 100644
--- a/drivers/staging/erofs/dir.c
+++ b/drivers/staging/erofs/dir.c
@@ -23,6 +23,21 @@ static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
 	[EROFS_FT_SYMLINK]	= DT_LNK,
 };
 
+static void debug_one_dentry(unsigned char d_type, const char *de_name,
+			     unsigned int de_namelen)
+{
+#ifdef CONFIG_EROFS_FS_DEBUG
+	/* since the on-disk name could not have the trailing '\0' */
+	unsigned char dbg_namebuf[EROFS_NAME_LEN + 1];
+
+	memcpy(dbg_namebuf, de_name, de_namelen);
+	dbg_namebuf[de_namelen] = '\0';
+
+	debugln("found dirent %s de_len %u d_type %d", dbg_namebuf,
+		de_namelen, d_type);
+#endif
+}
+
 static int erofs_fill_dentries(struct dir_context *ctx,
 	void *dentry_blk, unsigned *ofs,
 	unsigned nameoff, unsigned maxsize)
@@ -33,14 +48,10 @@ static int erofs_fill_dentries(struct dir_context *ctx,
 	de = dentry_blk + *ofs;
 	while (de < end) {
 		const char *de_name;
-		int de_namelen;
+		unsigned int de_namelen;
 		unsigned char d_type;
-#ifdef CONFIG_EROFS_FS_DEBUG
-		unsigned dbg_namelen;
-		unsigned char dbg_namebuf[EROFS_NAME_LEN];
-#endif
 
-		if (unlikely(de->file_type < EROFS_FT_MAX))
+		if (de->file_type < EROFS_FT_MAX)
 			d_type = erofs_filetype_table[de->file_type];
 		else
 			d_type = DT_UNKNOWN;
@@ -48,26 +59,20 @@ static int erofs_fill_dentries(struct dir_context *ctx,
 		nameoff = le16_to_cpu(de->nameoff);
 		de_name = (char *)dentry_blk + nameoff;
 
-		de_namelen = unlikely(de + 1 >= end) ?
-			/* last directory entry */
-			strnlen(de_name, maxsize - nameoff) :
-			le16_to_cpu(de[1].nameoff) - nameoff;
+		/* the last dirent in the block? */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
 
 		/* a corrupted entry is found */
-		if (unlikely(de_namelen < 0)) {
+		if (unlikely(nameoff + de_namelen > maxsize ||
+			     de_namelen > EROFS_NAME_LEN)) {
 			DBG_BUGON(1);
 			return -EIO;
 		}
 
-#ifdef CONFIG_EROFS_FS_DEBUG
-		dbg_namelen = min(EROFS_NAME_LEN - 1, de_namelen);
-		memcpy(dbg_namebuf, de_name, dbg_namelen);
-		dbg_namebuf[dbg_namelen] = '\0';
-
-		debugln("%s, found de_name %s de_len %d d_type %d", __func__,
-			dbg_namebuf, de_namelen, d_type);
-#endif
-
+		debug_one_dentry(d_type, de_name, de_namelen);
 		if (!dir_emit(ctx, de_name, de_namelen,
 					le64_to_cpu(de->nid), d_type))
 			/* stoped by some reason */
-- 
2.17.1

