Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81350ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542FC218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570800605;
	bh=TOFp0eQXHXIoW7xw+gE+XxPaikVyl2JgF3nYacFfDzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fv1esB7i6emD3fV5R0RBP0f0XxHFS/hi/cZqQleN279nBqPHB+wH595TJk+ZXDmJm
	 lfVpgFxJMYWPn8ugILuYLkE9Q44QnRHDru+4PJdU8IBGr3UtxzgR0kjiLJjQVlj0jF
	 W9jV9TlRItfFFlYEtSi38t7dQSvvaB0atJEQXp5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfJKNaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbfJKNaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:30:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1C7121D71;
        Fri, 11 Oct 2019 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570800601;
        bh=TOFp0eQXHXIoW7xw+gE+XxPaikVyl2JgF3nYacFfDzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oihe4dKPU4NY9oWQnTcrnYQJDSAQTp37OiUQZP+Bt2FY2R0/nHlSg8w4ibUSCwmZB
         A62NG6pQj2198wOPzxLxHcDt4UJ9UK4xGQU9Z6RQY6MPub5nZXeOJYKdeWlnakgNQV
         qh+nceAI9+za32yeyFohY9D1SWRm62i3RCqc0rBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 8/8] debugfs: remove return value of debugfs_create_x64()
Date:   Fri, 11 Oct 2019 15:29:31 +0200
Message-Id: <20191011132931.1186197-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
References: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_x64(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.txt |  4 ++--
 fs/debugfs/file.c                     |  6 +++---
 include/linux/debugfs.h               | 12 ++++--------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index fa2284ad6129..1ec4a94b6e93 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -88,8 +88,8 @@ the following functions can be used instead:
 			    struct dentry *parent, u16 *value);
     void debugfs_create_x32(const char *name, umode_t mode,
 			    struct dentry *parent, u32 *value);
-    struct dentry *debugfs_create_x64(const char *name, umode_t mode,
-				      struct dentry *parent, u64 *value);
+    void debugfs_create_x64(const char *name, umode_t mode,
+			    struct dentry *parent, u64 *value);
 
 These functions are useful as long as the developer knows the size of the
 value to be exported.  Some types can have different widths on different
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 54a0db733574..8aac1a9007c9 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -687,10 +687,10 @@ EXPORT_SYMBOL_GPL(debugfs_create_x32);
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
-struct dentry *debugfs_create_x64(const char *name, umode_t mode,
-				 struct dentry *parent, u64 *value)
+void debugfs_create_x64(const char *name, umode_t mode, struct dentry *parent,
+			u64 *value)
 {
-	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x64,
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x64,
 				   &fops_x64_ro, &fops_x64_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x64);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 25c213e9158e..c127c159d10a 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -113,8 +113,8 @@ void debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent,
 			u16 *value);
 void debugfs_create_x32(const char *name, umode_t mode, struct dentry *parent,
 			u32 *value);
-struct dentry *debugfs_create_x64(const char *name, umode_t mode,
-				  struct dentry *parent, u64 *value);
+void debugfs_create_x64(const char *name, umode_t mode, struct dentry *parent,
+			u64 *value);
 void debugfs_create_size_t(const char *name, umode_t mode,
 			   struct dentry *parent, size_t *value);
 struct dentry *debugfs_create_atomic_t(const char *name, umode_t mode,
@@ -277,12 +277,8 @@ static inline void debugfs_create_x16(const char *name, umode_t mode,
 static inline void debugfs_create_x32(const char *name, umode_t mode,
 				      struct dentry *parent, u32 *value) { }
 
-static inline struct dentry *debugfs_create_x64(const char *name, umode_t mode,
-						struct dentry *parent,
-						u64 *value)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_x64(const char *name, umode_t mode,
+				      struct dentry *parent, u64 *value) { }
 
 static inline void debugfs_create_size_t(const char *name, umode_t mode,
 					 struct dentry *parent, size_t *value)
-- 
2.23.0

