Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9A7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E142070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420987;
	bh=n8d6UTShe+rr8XtiSW5yvnCZrv4R4ecqNqUVJje3t94=;
	h=Date:From:To:Subject:List-ID:From;
	b=oPHiDb+hHu48yLFd0E2WLDL741NLhc4Zrdad1yM82C1NeD8ellsKS5wZP4ipE/Fvd
	 pL20ln2AW7Uqcn2/6HtOmkb28t7jOA+MMYsy502/M/M5/Zx5y4SEMFy0hTYcgBbgBq
	 1OVKZULiTGBSHTrYScfn0t88C+tnNeCQD6scePf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfKVLJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:09:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfKVLJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:09:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39A4C20721;
        Fri, 22 Nov 2019 11:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420981;
        bh=n8d6UTShe+rr8XtiSW5yvnCZrv4R4ecqNqUVJje3t94=;
        h=Date:From:To:Subject:From;
        b=F6KrkRTPrwK7LArw5ezp6ESUbO9alTqy/06CC3FgOsdXsy97jCB4ZmrC3MfkKBf7v
         pnmDrp3+372LyAl0Wloa/6NH9Z8WkGMcXlL5JZEyyzpPwwiS6BjzURId8j3ItvdLsK
         QBoQF4HeJ/aJW/Z0PTH/CsCV2LOMTBV3ehxwfLpI=
Date:   Fri, 22 Nov 2019 11:44:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: remove return value of debugfs_create_regset32()
Message-ID: <20191122104453.GA2017837@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_regset32(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.txt |  6 +++---
 fs/debugfs/file.c                     | 17 ++++-------------
 include/linux/debugfs.h               | 13 ++++++-------
 3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 93c825d38232..8e235384e5ff 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -164,9 +164,9 @@ file.
 	void __iomem *base;
     };
 
-    struct dentry *debugfs_create_regset32(const char *name, umode_t mode,
-				     struct dentry *parent,
-				     struct debugfs_regset32 *regset);
+    debugfs_create_regset32(const char *name, umode_t mode,
+			    struct dentry *parent,
+			    struct debugfs_regset32 *regset);
 
     void debugfs_print_regs32(struct seq_file *s, struct debugfs_reg32 *regs,
 			 int nregs, void __iomem *base, char *prefix);
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index a86cb0b1c69c..8dba75d40b36 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1078,21 +1078,12 @@ static const struct file_operations fops_regset32 = {
  * This function creates a file in debugfs with the given name that reports
  * the names and values of a set of 32-bit registers. If the @mode variable
  * is so set it can be read from. Writing is not supported.
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
-struct dentry *debugfs_create_regset32(const char *name, umode_t mode,
-				       struct dentry *parent,
-				       struct debugfs_regset32 *regset)
+void debugfs_create_regset32(const char *name, umode_t mode,
+			     struct dentry *parent,
+			     struct debugfs_regset32 *regset)
 {
-	return debugfs_create_file(name, mode, parent, regset, &fops_regset32);
+	debugfs_create_file(name, mode, parent, regset, &fops_regset32);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_regset32);
 
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index edcf1357b1be..9726738de814 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -127,9 +127,9 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				  struct dentry *parent,
 				  struct debugfs_blob_wrapper *blob);
 
-struct dentry *debugfs_create_regset32(const char *name, umode_t mode,
-				     struct dentry *parent,
-				     struct debugfs_regset32 *regset);
+void debugfs_create_regset32(const char *name, umode_t mode,
+			     struct dentry *parent,
+			     struct debugfs_regset32 *regset);
 
 void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
 			  int nregs, void __iomem *base, char *prefix);
@@ -300,11 +300,10 @@ static inline struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct dentry *debugfs_create_regset32(const char *name,
-				   umode_t mode, struct dentry *parent,
-				   struct debugfs_regset32 *regset)
+static inline void debugfs_create_regset32(const char *name, umode_t mode,
+					   struct dentry *parent,
+					   struct debugfs_regset32 *regset)
 {
-	return ERR_PTR(-ENODEV);
 }
 
 static inline void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
-- 
2.24.0

