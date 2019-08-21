Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6F2C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B9D2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566400825;
	bh=xn5X0H02QC9UnQmvkCaxsYaQdqhUjG5IK0khgW+BxeU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Zyuae4gW0Ikg7uJFHUn5IO2xWoBZ+eGltceoM+L2XUEfC/FdX9qnQHdDWFu7AeK1d
	 Xq5YTnR0WqzOJVV8PwzVohmZdC0YscXYuQv8tgsRctBHzVdPZosuRbkYCYKlBdO8ip
	 wxXsW5hSLEaGlFTkj0ha5bC43JlLXbIuDc8UtI00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfHUPUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfHUPUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:20:23 -0400
Received: from localhost.localdomain (unknown [180.111.132.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1A822CF7;
        Wed, 21 Aug 2019 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566400822;
        bh=xn5X0H02QC9UnQmvkCaxsYaQdqhUjG5IK0khgW+BxeU=;
        h=From:To:Cc:Subject:Date:From;
        b=bK2EaPhrFhBIZwJs7DpsIUw1wPrf+l0bUIFL1lcZPrGoDgJp7voKgDEaknNE0N34B
         xp1K8CP4qjDIPBGTidAtpAO1aoBc2Ox+vruFRYHpOl8nw09pOTeSR5RXNno4hrfXPW
         jOMPEqP0qiSjbk6DKW3VY8lq1HqvWifyqhm6wQ5c=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: introduce f2fs_match_name() for cleanup
Date:   Wed, 21 Aug 2019 23:13:34 +0800
Message-Id: <20190821151335.21312-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

This patch introduces f2fs_match_name() for cleanup.

BTW, it avoids to fallback to normal comparison once it doesn't
match casefolded name.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index dac07d17cdbd..e34c17106084 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -136,6 +136,34 @@ int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
 }
 #endif
 
+static inline bool f2fs_match_name(struct f2fs_dentry_ptr *d,
+					struct f2fs_dir_entry *de,
+					struct fscrypt_name *fname,
+					unsigned long bit_pos,
+					f2fs_hash_t namehash)
+{
+	struct inode *parent = d->inode;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(parent);
+#ifdef CONFIG_UNICODE
+	struct qstr entry;
+#endif
+
+	if (de->hash_code != namehash)
+		return false;
+
+#ifdef CONFIG_UNICODE
+	entry.name = d->filename[bit_pos];
+	entry.len = de->name_len;
+
+	if (sbi->s_encoding && IS_CASEFOLDED(parent))
+		return !f2fs_ci_compare(parent, fname->usr_fname, &entry);
+#endif
+	if (fscrypt_match_name(fname, d->filename[bit_pos],
+				le16_to_cpu(de->name_len)))
+		return true;
+	return false;
+}
+
 struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 			f2fs_hash_t namehash, int *max_slots,
 			struct f2fs_dentry_ptr *d)
@@ -143,9 +171,6 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 	struct f2fs_dir_entry *de;
 	unsigned long bit_pos = 0;
 	int max_len = 0;
-#ifdef CONFIG_UNICODE
-	struct qstr entry;
-#endif
 
 	if (max_slots)
 		*max_slots = 0;
@@ -157,28 +182,14 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 		}
 
 		de = &d->dentry[bit_pos];
-#ifdef CONFIG_UNICODE
-		entry.name = d->filename[bit_pos];
-		entry.len = de->name_len;
-#endif
 
 		if (unlikely(!de->name_len)) {
 			bit_pos++;
 			continue;
 		}
-		if (de->hash_code == namehash) {
-#ifdef CONFIG_UNICODE
-			if (F2FS_SB(d->inode->i_sb)->s_encoding &&
-					IS_CASEFOLDED(d->inode) &&
-					!f2fs_ci_compare(d->inode,
-						fname->usr_fname, &entry))
-				goto found;
 
-#endif
-			if (fscrypt_match_name(fname, d->filename[bit_pos],
-						le16_to_cpu(de->name_len)))
-				goto found;
-		}
+		if (f2fs_match_name(d, de, fname, bit_pos, namehash))
+			goto found;
 
 		if (max_slots && max_len > *max_slots)
 			*max_slots = max_len;
-- 
2.22.0

