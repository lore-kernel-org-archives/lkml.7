Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE2C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499FE23407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567179298;
	bh=0P5/A4E3ITJuLBmanZPd1xmp88+n1aduGgzUAT69uPw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G10eg3QDFf5sa7MOnk6C3lHiPeWm6A1xv1vjp/B5VY0AXeQ28DAAjveC0r86w5dAX
	 QnipmsT6yJr9rTg0n1tzh7abGM8EANKuP2t9rY1l77DHFfcXGGhLTmWG48d24vsJWl
	 XxrEPEtpcfbtQyyiUD/7ck285admqetTFHIjpqEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfH3Pe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfH3Pe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:34:57 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26EA222CE9;
        Fri, 30 Aug 2019 15:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567179296;
        bh=0P5/A4E3ITJuLBmanZPd1xmp88+n1aduGgzUAT69uPw=;
        h=From:To:Cc:Subject:Date:From;
        b=JOQ6DBCLyfEl6sGy9wdcfYMYD9p2/AH+RTWcIGCZ8cEfMR3bCAQP7a/qFxiqFfvMm
         5W3mbVu8ERCXb5lM+YQNKa4orsJKS5VUcGtivkHrwjcZtysCu3ktg+du/QAUK6xux/
         J/vCSQ2ldLBb3JyQEuxyUW5vhH7IyZblg4fqtE6A=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: convert inline_data in prior to i_size_write
Date:   Fri, 30 Aug 2019 08:34:53 -0700
Message-Id: <20190830153453.24684-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can guarantee inline_data has smaller i_size.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 08caaead6f16..a43193dd27cb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -815,14 +815,20 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (attr->ia_valid & ATTR_SIZE) {
 		loff_t old_size = i_size_read(inode);
-		bool to_smaller = (attr->ia_size <= old_size);
+
+		if (attr->ia_size > MAX_INLINE_DATA(inode)) {
+			/* should convert inline inode here */
+			err = f2fs_convert_inline_inode(inode);
+			if (err)
+				return err;
+		}
 
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		down_write(&F2FS_I(inode)->i_mmap_sem);
 
 		truncate_setsize(inode, attr->ia_size);
 
-		if (to_smaller)
+		if (attr->ia_size <= old_size)
 			err = f2fs_truncate(inode);
 		/*
 		 * do not trim all blocks after i_size if target size is
@@ -830,24 +836,11 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		 */
 		up_write(&F2FS_I(inode)->i_mmap_sem);
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-
 		if (err)
 			return err;
 
-		if (!to_smaller) {
-			/* should convert inline inode here */
-			if (!f2fs_may_inline_data(inode)) {
-				err = f2fs_convert_inline_inode(inode);
-				if (err) {
-					/* recover old i_size */
-					i_size_write(inode, old_size);
-					return err;
-				}
-			}
-			inode->i_mtime = inode->i_ctime = current_time(inode);
-		}
-
 		down_write(&F2FS_I(inode)->i_sem);
+		inode->i_mtime = inode->i_ctime = current_time(inode);
 		F2FS_I(inode)->last_disk_size = i_size_read(inode);
 		up_write(&F2FS_I(inode)->i_sem);
 	}
-- 
2.19.0.605.g01d371f741-goog

