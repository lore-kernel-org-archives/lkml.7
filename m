Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA458ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4664206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570800585;
	bh=2xVg8WZJhs5+s3ZMhkDKhZRyTqPWpCVOQiJwXn6B+U0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0pUQXebo8QcPrwAu/lX8bIP1v+nZEZDF1Uq4h2QB/MMtNDJRnXdxo6V15plGZ+I+W
	 bJP7Ma01V0fSHXkFI8nBviWmxc33+zVcBkkF01d3y4lE/Ff0/wS2ho1WVj+LbfJwt3
	 JBbbv1XWx9w/yaCFaQ4iDy62cceDWW6M76c4T2BE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfJKN3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728084AbfJKN3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:29:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBECE206A1;
        Fri, 11 Oct 2019 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570800582;
        bh=2xVg8WZJhs5+s3ZMhkDKhZRyTqPWpCVOQiJwXn6B+U0=;
        h=From:To:Cc:Subject:Date:From;
        b=DxG3vMFTedPyrRMXO6fg5S70gI7mub6sUMaFzOIl6QB9v1GX33rZmRsZ092nC5qnz
         FAuE4CBCkSiKHFxbhtewc5r5iUneoge85fcZV/DL/45d+c9kKu9RRFqQImCc0WCZ5H
         14LS45fiWyGHTS59wP0siceGdMCOYKhA1NCrH1mM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/8] debugfs: remove return value of debugfs_create_u8()
Date:   Fri, 11 Oct 2019 15:29:24 +0200
Message-Id: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_u8(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.txt |  4 ++--
 fs/debugfs/file.c                     | 15 +++------------
 include/linux/debugfs.h               | 12 ++++--------
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 9e27c843d00e..c146f18eb8ac 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -68,8 +68,8 @@ actually necessary; the debugfs code provides a number of helper functions
 for simple situations.  Files containing a single integer value can be
 created with any of:
 
-    struct dentry *debugfs_create_u8(const char *name, umode_t mode,
-				     struct dentry *parent, u8 *value);
+    void debugfs_create_u8(const char *name, umode_t mode,
+			   struct dentry *parent, u8 *value);
     struct dentry *debugfs_create_u16(const char *name, umode_t mode,
 				      struct dentry *parent, u16 *value);
     struct dentry *debugfs_create_u32(const char *name, umode_t mode,
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 87846aad594b..2d5d9a0a6f57 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -420,20 +420,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u8_wo, NULL, debugfs_u8_set, "%llu\n");
  * This function creates a file in debugfs with the given name that
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
- *
- * This function will return a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the debugfs_remove() function when the file is
- * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
- * returned.
- *
- * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
- * be returned.
  */
-struct dentry *debugfs_create_u8(const char *name, umode_t mode,
-				 struct dentry *parent, u8 *value)
+void debugfs_create_u8(const char *name, umode_t mode, struct dentry *parent,
+		       u8 *value)
 {
-	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u8,
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u8,
 				   &fops_u8_ro, &fops_u8_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u8);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 58424eb3b329..8e071f599245 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -97,8 +97,8 @@ ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
 struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
                 struct dentry *new_dir, const char *new_name);
 
-struct dentry *debugfs_create_u8(const char *name, umode_t mode,
-				 struct dentry *parent, u8 *value);
+void debugfs_create_u8(const char *name, umode_t mode, struct dentry *parent,
+		       u8 *value);
 struct dentry *debugfs_create_u16(const char *name, umode_t mode,
 				  struct dentry *parent, u16 *value);
 struct dentry *debugfs_create_u32(const char *name, umode_t mode,
@@ -244,12 +244,8 @@ static inline struct dentry *debugfs_rename(struct dentry *old_dir, struct dentr
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct dentry *debugfs_create_u8(const char *name, umode_t mode,
-					       struct dentry *parent,
-					       u8 *value)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_u8(const char *name, umode_t mode,
+				     struct dentry *parent, u8 *value) { }
 
 static inline struct dentry *debugfs_create_u16(const char *name, umode_t mode,
 						struct dentry *parent,
-- 
2.23.0

