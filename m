Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3819EC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C92324CF1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anmolsarma-in.20150623.gappssmtp.com header.i=@anmolsarma-in.20150623.gappssmtp.com header.b="yZZr6/nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfFCPOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:14:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45087 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbfFCPOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:14:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id x7so6118933plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anmolsarma-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vh8QxY/2eU+MfTlkrwtovUOL/D1P2VcUf2erRfP82cY=;
        b=yZZr6/nr9vkqfmkjjdK1uR7KFZ3AMWpppOqzo9C9M32PmkKnn6saqWgctwYKYjzTpx
         8RWsqfeSrvmO8GCxJ0pfojSWVqEBdhwjIKu8D1enJ0lCm1hn3VFgReH89XnWcgbBaxmp
         L3hpfGOlRoQEWlE53vr+rqN30EyYteo6pDOzNMdDN5ICaVejxhoy68DLHk7ZMN81Kh/h
         FxPo2WGOf5V6XnHXn5jS/+Zat0a6gYTN2quApMDkB+RX68Zr7Rck0VI+ZYZb6RSzb+Le
         +Yvzir+ryhQWVmcWWFYiJvuVGyuThRt1ZLWg2O6R39V1R+5v1PiJndF2Di4RYVDkuHIz
         Xnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vh8QxY/2eU+MfTlkrwtovUOL/D1P2VcUf2erRfP82cY=;
        b=CntzhnSJui7yMGXpDgocDkewmxoet7HWXzX4RPDKXu+zaIh1K+z8IhavGOQpEQyUWP
         5nh44fq2Qar0D+kNN87mcjOJA5lw4EUh6akjlorTkyR6djycdPhHbLvRslK6YsP3wIM1
         aKsHmPfXM6aVc23yAIaF1uWYf7m9fKQelUN2NBLBqzhqtnkYqTCsBkNCTZv74+CtRuAX
         daxUVtlSXTD/IGmkhBCTXAnsFaZyvs/UNXbgVOSR7JG0SfryVwRJOgyNW6JFNfvJcC2b
         wIaPmSQ7ME70aP/BiKrJeT0Wop1CH/wkclxrC7e7UVUS+2HCDjE7MCxqwAgdt/6s1qPB
         rMPw==
X-Gm-Message-State: APjAAAXzH9sIVsuCVVobbjxe9jbT4So5C5tp2hS2rCA1fD8zWptNPCjv
        jXmBMDLedW8PyJUXJrC9kCSZ9HuA6EM=
X-Google-Smtp-Source: APXvYqxVjZt/iW4xJLSbfWc9jsq1qM0z8MTGZnQ6UBLvK8vDS3W571PkyUEC2Nn4RbJVbcaw0Jc9FA==
X-Received: by 2002:a17:902:363:: with SMTP id 90mr30305076pld.131.1559574890142;
        Mon, 03 Jun 2019 08:14:50 -0700 (PDT)
Received: from localhost.localdomain ([1.39.185.36])
        by smtp.gmail.com with ESMTPSA id n66sm4754916pfn.52.2019.06.03.08.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 08:14:49 -0700 (PDT)
From:   Anmol Sarma <me@anmolsarma.in>
X-Google-Original-From: Anmol Sarma
Cc:     Anmol Sarma <me@anmolsarma.in>, Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] jfs: Add statx support
Date:   Mon,  3 Jun 2019 20:42:27 +0530
Message-Id: <20190603151227.6110-1-me@anmolsarma.in>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anmol Sarma <me@anmolsarma.in>

Return inode creation time and stx_attributes flags

Signed-off-by: Anmol Sarma <me@anmolsarma.in>
---
 fs/jfs/file.c      | 24 ++++++++++++++++++++++++
 fs/jfs/jfs_inode.h |  2 ++
 fs/jfs/namei.c     |  1 +
 fs/jfs/symlink.c   |  2 ++
 4 files changed, 29 insertions(+)

diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 36665fd37095..dedd27591836 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -23,6 +23,7 @@
 #include <linux/quotaops.h>
 #include "jfs_incore.h"
 #include "jfs_inode.h"
+#include "jfs_dinode.h"
 #include "jfs_dmap.h"
 #include "jfs_txnmgr.h"
 #include "jfs_xattr.h"
@@ -139,8 +140,31 @@ int jfs_setattr(struct dentry *dentry, struct iattr *iattr)
 	return rc;
 }
 
+int jfs_getattr(const struct path *path, struct kstat *stat, u32 request_mask,
+		unsigned int query_flags)
+{
+	struct inode *inode = d_inode(path->dentry);
+	struct jfs_inode_info *j_inode = JFS_IP(inode);
+	uint ji_flags = j_inode->mode2;
+
+	stat->result_mask |= STATX_BTIME;
+	stat->btime.tv_sec = j_inode->otime;
+	stat->btime.tv_nsec = 0;
+
+	if (ji_flags & JFS_APPEND_FL)
+		stat->attributes |= STATX_ATTR_APPEND;
+	if (ji_flags & JFS_IMMUTABLE_FL)
+		stat->attributes |= STATX_ATTR_IMMUTABLE;
+
+	stat->attributes_mask |= STATX_ATTR_APPEND | STATX_ATTR_IMMUTABLE;
+
+	generic_fillattr(inode, stat);
+	return 0;
+}
+
 const struct inode_operations jfs_file_inode_operations = {
 	.listxattr	= jfs_listxattr,
+	.getattr	= jfs_getattr,
 	.setattr	= jfs_setattr,
 #ifdef CONFIG_JFS_POSIX_ACL
 	.get_acl	= jfs_get_acl,
diff --git a/fs/jfs/jfs_inode.h b/fs/jfs/jfs_inode.h
index 7b0b3a40788f..e8279a4cb7f7 100644
--- a/fs/jfs/jfs_inode.h
+++ b/fs/jfs/jfs_inode.h
@@ -39,6 +39,8 @@ extern struct dentry *jfs_fh_to_parent(struct super_block *sb, struct fid *fid,
 	int fh_len, int fh_type);
 extern void jfs_set_inode_flags(struct inode *);
 extern int jfs_get_block(struct inode *, sector_t, struct buffer_head *, int);
+extern int jfs_getattr(const struct path *path, struct kstat *stat,
+		       u32 request_mask, unsigned int query_flags);
 extern int jfs_setattr(struct dentry *, struct iattr *);
 
 extern const struct address_space_operations jfs_aops;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index fa719a1553b6..8070c25f7551 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1533,6 +1533,7 @@ const struct inode_operations jfs_dir_inode_operations = {
 	.mknod		= jfs_mknod,
 	.rename		= jfs_rename,
 	.listxattr	= jfs_listxattr,
+	.getattr	= jfs_getattr,
 	.setattr	= jfs_setattr,
 #ifdef CONFIG_JFS_POSIX_ACL
 	.get_acl	= jfs_get_acl,
diff --git a/fs/jfs/symlink.c b/fs/jfs/symlink.c
index 38320607993e..858e9de8ff74 100644
--- a/fs/jfs/symlink.c
+++ b/fs/jfs/symlink.c
@@ -23,12 +23,14 @@
 
 const struct inode_operations jfs_fast_symlink_inode_operations = {
 	.get_link	= simple_get_link,
+	.getattr	= jfs_getattr,
 	.setattr	= jfs_setattr,
 	.listxattr	= jfs_listxattr,
 };
 
 const struct inode_operations jfs_symlink_inode_operations = {
 	.get_link	= page_get_link,
+	.getattr	= jfs_getattr,
 	.setattr	= jfs_setattr,
 	.listxattr	= jfs_listxattr,
 };
-- 
2.17.1

