Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE024C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2082075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715050;
	bh=O8aNYSONCd7VlaHdRHMo1PFDHvchIpv3cLyN2/yf5Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SmoS4CX7bB4FrYJ5y+PbTKXPcobQe1ZO+CD4WR63VsIO1HeJ31q1W0j+HgPF3NhZZ
	 NJhyGWswkMrY6uFH282Y9MNrme29RGrBvxmgjopYUANb5dpej9h/Njg0IYMD5UPFg2
	 tYyjjUN3nwExAM/mBsxbSg7BCLex743yqUI5NzPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfC0Tat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbfC0SD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6049217F5;
        Wed, 27 Mar 2019 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709806;
        bh=O8aNYSONCd7VlaHdRHMo1PFDHvchIpv3cLyN2/yf5Ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXD+bMKJlvDkXzZZ5PETwzE7+XmQMUwi03W9U78UTp3bR9miMW46isln5oiEhQg6i
         cqkoNJ/zbHik1lm1GC7WVriVM44VOADNaH6HkJq9ywjfZpMgz6oUFIkmPakVC016H+
         DQICkSLHzICibnRYnCjnNcnRoqsJ/oeA+taO75QA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.0 048/262] f2fs: fix to check inline_xattr_size boundary correctly
Date:   Wed, 27 Mar 2019 13:58:23 -0400
Message-Id: <20190327180158.10245-48-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 500e0b28ecd3c5aade98f3c3a339d18dcb166bb6 ]

We use below condition to check inline_xattr_size boundary:

	if (!F2FS_OPTION(sbi).inline_xattr_size ||
		F2FS_OPTION(sbi).inline_xattr_size >=
				DEF_ADDRS_PER_INODE -
				F2FS_TOTAL_EXTRA_ATTR_SIZE -
				DEF_INLINE_RESERVED_SIZE -
				DEF_MIN_INLINE_SIZE)

There is there problems in that check:
- we should allow inline_xattr_size equaling to min size of inline
{data,dentry} area.
- F2FS_TOTAL_EXTRA_ATTR_SIZE and inline_xattr_size are based on
different size unit, previous one is 4 bytes, latter one is 1 bytes.
- DEF_MIN_INLINE_SIZE only indicate min size of inline data area,
however, we need to consider min size of inline dentry area as well,
minimal inline dentry should at least contain two entries: '.' and
'..', so that min inline_dentry size is 40 bytes.

.bitmap		1 * 1 = 1
.reserved	1 * 1 = 1
.dentry		11 * 2 = 22
.filename	8 * 2 = 16
total		40

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h          |  1 -
 fs/f2fs/super.c         | 13 +++++++------
 include/linux/f2fs_fs.h | 13 +++++++------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 12fabd6735dd..279bc00489cc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -456,7 +456,6 @@ struct f2fs_flush_device {
 
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
-#define DEF_MIN_INLINE_SIZE		1
 static inline int get_extra_isize(struct inode *inode);
 static inline int get_inline_xattr_addrs(struct inode *inode);
 #define MAX_INLINE_DATA(inode)	(sizeof(__le32) *			\
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 93d7427d8883..5892fa3c885f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -834,12 +834,13 @@ static int parse_options(struct super_block *sb, char *options)
 					"set with inline_xattr option");
 			return -EINVAL;
 		}
-		if (!F2FS_OPTION(sbi).inline_xattr_size ||
-			F2FS_OPTION(sbi).inline_xattr_size >=
-					DEF_ADDRS_PER_INODE -
-					F2FS_TOTAL_EXTRA_ATTR_SIZE -
-					DEF_INLINE_RESERVED_SIZE -
-					DEF_MIN_INLINE_SIZE) {
+		if (F2FS_OPTION(sbi).inline_xattr_size <
+			sizeof(struct f2fs_xattr_header) / sizeof(__le32) ||
+			F2FS_OPTION(sbi).inline_xattr_size >
+			DEF_ADDRS_PER_INODE -
+			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -
+			DEF_INLINE_RESERVED_SIZE -
+			MIN_INLINE_DENTRY_SIZE / sizeof(__le32)) {
 			f2fs_msg(sb, KERN_ERR,
 					"inline xattr size is out of range");
 			return -EINVAL;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d7711048ef93..c524ad7d31da 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -489,12 +489,12 @@ typedef __le32	f2fs_hash_t;
 
 /*
  * space utilization of regular dentry and inline dentry (w/o extra reservation)
- *		regular dentry			inline dentry
- * bitmap	1 * 27 = 27			1 * 23 = 23
- * reserved	1 * 3 = 3			1 * 7 = 7
- * dentry	11 * 214 = 2354			11 * 182 = 2002
- * filename	8 * 214 = 1712			8 * 182 = 1456
- * total	4096				3488
+ *		regular dentry		inline dentry (def)	inline dentry (min)
+ * bitmap	1 * 27 = 27		1 * 23 = 23		1 * 1 = 1
+ * reserved	1 * 3 = 3		1 * 7 = 7		1 * 1 = 1
+ * dentry	11 * 214 = 2354		11 * 182 = 2002		11 * 2 = 22
+ * filename	8 * 214 = 1712		8 * 182 = 1456		8 * 2 = 16
+ * total	4096			3488			40
  *
  * Note: there are more reserved space in inline dentry than in regular
  * dentry, when converting inline dentry we should handle this carefully.
@@ -506,6 +506,7 @@ typedef __le32	f2fs_hash_t;
 #define SIZE_OF_RESERVED	(PAGE_SIZE - ((SIZE_OF_DIR_ENTRY + \
 				F2FS_SLOT_LEN) * \
 				NR_DENTRY_IN_BLOCK + SIZE_OF_DENTRY_BITMAP))
+#define MIN_INLINE_DENTRY_SIZE		40	/* just include '.' and '..' entries */
 
 /* One directory entry slot representing F2FS_SLOT_LEN-sized file name */
 struct f2fs_dir_entry {
-- 
2.19.1

