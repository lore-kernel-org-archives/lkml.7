Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9630FC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700A52053B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570800591;
	bh=s9Lnz55OyncGfdyGMjQLbALt1yjzFIgzbenA45U8yVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o+CQ+wFwJF/yOriM/0B2urdI+/zb09mKBVwvpRt//UaayQfGiA0h9C6KRClc4N0oB
	 QHB8fVtZgpuBUJRl0zV0wdb2GVxjAV6ZvxaMQ0Io5d6/PiQSfq8FgunzDwYQ1p69GR
	 a+PARDgDRa6Af7p9dtnDm9ZY/YHrqckF9xCTUWNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfJKN3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728392AbfJKN3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:29:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45C002089F;
        Fri, 11 Oct 2019 13:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570800587;
        bh=s9Lnz55OyncGfdyGMjQLbALt1yjzFIgzbenA45U8yVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwy4noBfdxog9i2ATaFNQ5Z0RT1SZ7D4kM5xARWmBVPd5ahOeRdWJ4TUI6lOO5IqR
         21lK1dUWnUAZ7BUVxKsVB9yyvYdrdScCEiDILeoCDYn2ehCSKpt2O6w/kTMSrt7dtt
         uutOXmhW4Rb3knsTj7sJ5BE9H3YpbiRjLBLPe7ug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/8] debugfs: remove return value of debugfs_create_u64()
Date:   Fri, 11 Oct 2019 15:29:26 +0200
Message-Id: <20191011132931.1186197-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
References: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_u64(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.txt |  4 ++--
 fs/debugfs/file.c                     | 15 +++------------
 include/linux/debugfs.h               | 12 ++++--------
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 6abcf41fbd37..1b299ae4904d 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -74,8 +74,8 @@ created with any of:
 			    struct dentry *parent, u16 *value);
     struct dentry *debugfs_create_u32(const char *name, umode_t mode,
 				      struct dentry *parent, u32 *value);
-    struct dentry *debugfs_create_u64(const char *name, umode_t mode,
-				      struct dentry *parent, u64 *value);
+    void debugfs_create_u64(const char *name, umode_t mode,
+			    struct dentry *parent, u64 *value);
 
 These files support both reading and writing the given value; if a specific
 file should not be written to, simply set the mode bits accordingly.  The
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 8091a7ef3589..4c8912d7d34c 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -538,20 +538,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
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
-struct dentry *debugfs_create_u64(const char *name, umode_t mode,
-				 struct dentry *parent, u64 *value)
+void debugfs_create_u64(const char *name, umode_t mode, struct dentry *parent,
+			u64 *value)
 {
-	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u64,
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u64,
 				   &fops_u64_ro, &fops_u64_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u64);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index c83a33a76b6c..b3bed4d61733 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -103,8 +103,8 @@ void debugfs_create_u16(const char *name, umode_t mode, struct dentry *parent,
 			u16 *value);
 struct dentry *debugfs_create_u32(const char *name, umode_t mode,
 				  struct dentry *parent, u32 *value);
-struct dentry *debugfs_create_u64(const char *name, umode_t mode,
-				  struct dentry *parent, u64 *value);
+void debugfs_create_u64(const char *name, umode_t mode, struct dentry *parent,
+			u64 *value);
 struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
 				    struct dentry *parent, unsigned long *value);
 struct dentry *debugfs_create_x8(const char *name, umode_t mode,
@@ -257,12 +257,8 @@ static inline struct dentry *debugfs_create_u32(const char *name, umode_t mode,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct dentry *debugfs_create_u64(const char *name, umode_t mode,
-						struct dentry *parent,
-						u64 *value)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_u64(const char *name, umode_t mode,
+				      struct dentry *parent, u64 *value) { }
 
 static inline struct dentry *debugfs_create_ulong(const char *name,
 						umode_t mode,
-- 
2.23.0

