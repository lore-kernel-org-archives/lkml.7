Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561FDC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8D924676
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576699800;
	bh=Rod+bJ2QMrojGgJqYQnIMGlsLvajxvwq+9925iKpS+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a2f0f1vnHLLKDDgPukD6zI0KO0FgjKNA9vsMwAqovZ3dOeHSOAsJQ661tqnMppDxS
	 OafCsCesXpFmDyzqfU6Ln5VYXXTyLaUCTSqlNhmJ2NvNxRfrtSAOHDxy4K8T84KaDl
	 iFrtJNS+wlzCtUJWsz9hNlLYj/nVpsgUZFV50274=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfLRUJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:09:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfLRUJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:09:49 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 030A821D7D;
        Wed, 18 Dec 2019 20:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576699789;
        bh=Rod+bJ2QMrojGgJqYQnIMGlsLvajxvwq+9925iKpS+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/xImYerBfbvNWoa9mF0Ye/pmPU3bqMMPKLjR53RlCEEdyd+kT4scluxwEVn4OTMG
         lCAyR7kgoh1+9w9UZ2lgeMvIhbqGgkHgD33R6v7uKGeJIZ0nPwQY4odbkBhgRS4TtX
         c+Xd/UcA4lO/1xzAdZnL/MT/qEBOY87ICRtrDF9s=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: don't put new_page twice in f2fs_rename
Date:   Wed, 18 Dec 2019 12:09:45 -0800
Message-Id: <20191218200947.20445-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
In-Reply-To: <20191218200947.20445-1-jaegeuk@kernel.org>
References: <20191218200947.20445-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_rename(), new_page is gone after f2fs_set_link(), but it tries
to put again when whiteout is failed and jumped to put_out_dir.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 61615ab466c2..91e7b8360d2a 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -850,7 +850,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
 	struct inode *whiteout = NULL;
-	struct page *old_dir_page;
+	struct page *old_dir_page = NULL;
 	struct page *old_page, *new_page = NULL;
 	struct f2fs_dir_entry *old_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry;
@@ -941,6 +941,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto put_out_dir;
 
 		f2fs_set_link(new_dir, new_entry, new_page, old_inode);
+		new_page = NULL;
 
 		new_inode->i_ctime = current_time(new_inode);
 		down_write(&F2FS_I(new_inode)->i_sem);
@@ -980,6 +981,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	f2fs_mark_inode_dirty_sync(old_inode, false);
 
 	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
+	old_page = NULL;
 
 	if (whiteout) {
 		set_inode_flag(whiteout, FI_INC_LINK);
@@ -1015,8 +1017,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 put_out_dir:
 	f2fs_unlock_op(sbi);
-	if (new_page)
-		f2fs_put_page(new_page, 0);
+	f2fs_put_page(new_page, 0);
 out_dir:
 	if (old_dir_entry)
 		f2fs_put_page(old_dir_page, 0);
-- 
2.24.0.525.g8f36a354ae-goog

