Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA282C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0C82077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556303360;
	bh=xgtrjev1l0myncFB4+Rxefbc1PEu33mLHqZlotiEJcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LIq7cwJ7e5tlhBbLHI4xf02Czb+xr0KpDYbymtFZqGCqb4ti3dQKtKpMxjWyWSDo7
	 naJ4toZ5x5FHpRZsIgxVkS53vLGdoqSrKy+Mi4z8tLO/AankW8z/pqrvEz2lJrBFes
	 fcZQUoGsyiKYeMYCkWZKijimVp8MLBQUUO0iIeFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfDZS3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfDZS2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:28:54 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 449BA214C6;
        Fri, 26 Apr 2019 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556303333;
        bh=xgtrjev1l0myncFB4+Rxefbc1PEu33mLHqZlotiEJcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvBLan3aRLOzI/++mN09qi5Xg/iKciT/gTDSXeO0pV+JYv/jpo71hpWUB0Sk3vpi7
         Kt8OwiLPwW+q+Owr/IH/+LTlcuGeh6Rie1VbpW6VQz/kA0UAQJTxd/vyAnRywPquHo
         oGVkjD2+LF/uhRYooNxRIqV3My7ISsaRbuzGGWg8=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, gregkh@linuxfoundation.org, tj@kernel.org,
        jack@suse.cz, amir73il@gmail.com, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com, rafael@kernel.org
Subject: [PATCH 2/5] fsnotify: have fsnotify_move take a struct qstr instead of a string
Date:   Fri, 26 Apr 2019 14:28:44 -0400
Message-Id: <20190426182847.25088-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426182847.25088-1-jlayton@kernel.org>
References: <20190426182847.25088-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this, ovl_lookup_real_one can skip the strlen call.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/debugfs/inode.c       |  2 +-
 fs/namei.c               |  4 ++--
 include/linux/fsnotify.h | 11 +++++------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 37c0a025d7e8..5dbeefa69a58 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -824,7 +824,7 @@ struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
 		goto exit;
 	}
 	d_move(old_dentry, dentry);
-	fsnotify_move(d_inode(old_dir), d_inode(new_dir), old_name.name.name,
+	fsnotify_move(d_inode(old_dir), d_inode(new_dir), &old_name.name,
 		d_is_dir(old_dentry),
 		NULL, old_dentry);
 	release_dentry_name_snapshot(&old_name);
diff --git a/fs/namei.c b/fs/namei.c
index c96713077326..5ebd64b21970 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4498,10 +4498,10 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		inode_unlock(target);
 	dput(new_dentry);
 	if (!error) {
-		fsnotify_move(old_dir, new_dir, old_name.name.name, is_dir,
+		fsnotify_move(old_dir, new_dir, &old_name.name, is_dir,
 			      !(flags & RENAME_EXCHANGE) ? target : NULL, old_dentry);
 		if (flags & RENAME_EXCHANGE) {
-			fsnotify_move(new_dir, old_dir, old_dentry->d_name.name,
+			fsnotify_move(new_dir, old_dir, &old_dentry->d_name,
 				      new_is_dir, NULL, new_dentry);
 		}
 	}
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index e09cfff69bb2..2de90a7e388b 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -102,7 +102,7 @@ static inline void fsnotify_link_count(struct inode *inode)
  * fsnotify_move - file old_name at old_dir was moved to new_name at new_dir
  */
 static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
-				 const unsigned char *old_name,
+				 const struct qstr *old_name,
 				 int isdir, struct inode *target,
 				 struct dentry *moved)
 {
@@ -111,7 +111,6 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	__u32 old_dir_mask = FS_MOVED_FROM;
 	__u32 new_dir_mask = FS_MOVED_TO;
 	__u32 mask = FS_MOVE_SELF;
-	const unsigned char *new_name = moved->d_name.name;
 
 	if (old_dir == new_dir)
 		old_dir_mask |= FS_DN_RENAME;
@@ -122,10 +121,10 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 		mask |= FS_ISDIR;
 	}
 
-	fsnotify(old_dir, old_dir_mask, source, FSNOTIFY_EVENT_INODE, old_name,
-		 fs_cookie);
-	fsnotify(new_dir, new_dir_mask, source, FSNOTIFY_EVENT_INODE, new_name,
-		 fs_cookie);
+	fsnotify(old_dir, old_dir_mask, source, FSNOTIFY_EVENT_INODE,
+		 old_name->name, fs_cookie);
+	fsnotify(new_dir, new_dir_mask, source, FSNOTIFY_EVENT_INODE,
+		 moved->d_name.name, fs_cookie);
 
 	if (target)
 		fsnotify_link_count(target);
-- 
2.20.1

