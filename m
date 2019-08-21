Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A98C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCE12339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566400830;
	bh=9/75u3Tvm7n34viu09eAdOl3V9lhc9uG6Rxa1n05bT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u9vQ0J66Tl+TQ9K5Cg7VOsDSJYfEG7NJrU0P0CLqt9Ui50h03kvq2q3ioKHvA7YVp
	 u0cFd+1/FA7oyP+IvVA4lcVkHjOyxqeaYCNW4rmKfnxOOL+cDcYOD6NTOOl8g5JPOE
	 BkyRT/3pQWrnd988GUKUyUyjoaVWSrlsARPO49WQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfHUPU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfHUPUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:20:25 -0400
Received: from localhost.localdomain (unknown [180.111.132.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 511DF22DD3;
        Wed, 21 Aug 2019 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566400824;
        bh=9/75u3Tvm7n34viu09eAdOl3V9lhc9uG6Rxa1n05bT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bycgHQ+ZC/zGBc1mzQ6vqFT1gg42d40dW6R5OO/PHwzq1wPRurESaiqjSLy1zvAFB
         5LZQhnI0dhW0/jdEEGrAC8DO+1STTTsfnpiiS7s23Iq8R6AAhWfohFbkBihJ0F52IR
         XBrNLazBumveD69/bckbYeX6DDwFqL40+rzhonM0=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: optimize case-insensitive lookups
Date:   Wed, 21 Aug 2019 23:13:35 +0800
Message-Id: <20190821151335.21312-2-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821151335.21312-1-chao@kernel.org>
References: <20190821151335.21312-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

This patch ports below casefold enhancement patch from ext4 to f2fs

commit 3ae72562ad91 ("ext4: optimize case-insensitive lookups")

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++------
 fs/f2fs/f2fs.h |  3 ++-
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index e34c17106084..7498b789518a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -112,13 +112,17 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
  * doesn't match or less than zero on error.
  */
 int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
-		    const struct qstr *entry)
+				const struct qstr *entry, bool quick)
 {
 	const struct f2fs_sb_info *sbi = F2FS_SB(parent->i_sb);
 	const struct unicode_map *um = sbi->s_encoding;
 	int ret;
 
-	ret = utf8_strncasecmp(um, name, entry);
+	if (quick)
+		ret = utf8_strncasecmp_folded(um, name, entry);
+	else
+		ret = utf8_strncasecmp(um, name, entry);
+
 	if (ret < 0) {
 		/* Handle invalid character sequence as either an error
 		 * or as an opaque byte sequence.
@@ -134,11 +138,36 @@ int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
 
 	return ret;
 }
+
+void f2fs_fname_setup_ci_filename(struct inode *dir,
+					const struct qstr *iname,
+					struct fscrypt_str *cf_name)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
+
+	if (!IS_CASEFOLDED(dir)) {
+		cf_name->name = NULL;
+		return;
+	}
+
+	cf_name->name = f2fs_kmalloc(sbi, F2FS_NAME_LEN, GFP_NOFS);
+	if (!cf_name->name)
+		return;
+
+	cf_name->len = utf8_casefold(sbi->s_encoding,
+					iname, cf_name->name,
+					F2FS_NAME_LEN);
+	if (cf_name->len <= 0) {
+		kvfree(cf_name->name);
+		cf_name->name = NULL;
+	}
+}
 #endif
 
 static inline bool f2fs_match_name(struct f2fs_dentry_ptr *d,
 					struct f2fs_dir_entry *de,
 					struct fscrypt_name *fname,
+					struct fscrypt_str *cf_str,
 					unsigned long bit_pos,
 					f2fs_hash_t namehash)
 {
@@ -155,8 +184,15 @@ static inline bool f2fs_match_name(struct f2fs_dentry_ptr *d,
 	entry.name = d->filename[bit_pos];
 	entry.len = de->name_len;
 
-	if (sbi->s_encoding && IS_CASEFOLDED(parent))
-		return !f2fs_ci_compare(parent, fname->usr_fname, &entry);
+	if (sbi->s_encoding && IS_CASEFOLDED(parent)) {
+		if (cf_str->name) {
+			struct qstr cf = {.name = cf_str->name,
+					  .len = cf_str->len};
+			return !f2fs_ci_compare(parent, &cf, &entry, true);
+		}
+		return !f2fs_ci_compare(parent, fname->usr_fname, &entry,
+					false);
+	}
 #endif
 	if (fscrypt_match_name(fname, d->filename[bit_pos],
 				le16_to_cpu(de->name_len)))
@@ -169,9 +205,14 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 			struct f2fs_dentry_ptr *d)
 {
 	struct f2fs_dir_entry *de;
+	struct fscrypt_str cf_str = { .name = NULL, .len = 0 };
 	unsigned long bit_pos = 0;
 	int max_len = 0;
 
+#ifdef CONFIG_UNICODE
+	f2fs_fname_setup_ci_filename(d->inode, fname->usr_fname, &cf_str);
+#endif
+
 	if (max_slots)
 		*max_slots = 0;
 	while (bit_pos < d->max) {
@@ -188,7 +229,7 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 			continue;
 		}
 
-		if (f2fs_match_name(d, de, fname, bit_pos, namehash))
+		if (f2fs_match_name(d, de, fname, &cf_str, bit_pos, namehash))
 			goto found;
 
 		if (max_slots && max_len > *max_slots)
@@ -202,6 +243,10 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 found:
 	if (max_slots && max_len > *max_slots)
 		*max_slots = max_len;
+
+#ifdef CONFIG_UNICODE
+	kvfree(cf_str.name);
+#endif
 	return de;
 }
 
@@ -1025,7 +1070,7 @@ static int f2fs_d_compare(const struct dentry *dentry, unsigned int len,
 		return memcmp(str, name, len);
 	}
 
-	return f2fs_ci_compare(dentry->d_parent->d_inode, name, &qstr);
+	return f2fs_ci_compare(dentry->d_parent->d_inode, name, &qstr, false);
 }
 
 static int f2fs_d_hash(const struct dentry *dentry, struct qstr *str)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2d0cab0cd620..52174aae3299 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2951,7 +2951,8 @@ struct dentry *f2fs_get_parent(struct dentry *child);
 
 extern int f2fs_ci_compare(const struct inode *parent,
 			   const struct qstr *name,
-			   const struct qstr *entry);
+			   const struct qstr *entry,
+			   bool quick);
 
 /*
  * dir.c
-- 
2.22.0

