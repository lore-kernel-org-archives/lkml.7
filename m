Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D685CECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02892053B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570800602;
	bh=oPi7myX49bKNOUoSyfn00nC89nK4aP+QmL6g/leRf9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b2X8uWBUHVZwsVfZ7Tz2nG0SJqhyVASYFkh9u2Bb3Cv/9QotF6W5gbTTJJ3uAYrYN
	 Z/lptBi9w4wNXsYYIB/HrWgQ/gOE+mKNAxEdlPfza4bWhDoKt2dZDdmQv2bFpnxSA/
	 kd3eBN8f6QR/Rw1wyGhe42uk8XthGPuKQA1FkRoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfJKNaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbfJKN37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:29:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 168E3214E0;
        Fri, 11 Oct 2019 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570800598;
        bh=oPi7myX49bKNOUoSyfn00nC89nK4aP+QmL6g/leRf9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m988K1uMsoawQWQub+ZluLWywWKSlzTea/+v/5PBWyy7MSX/UZUFHYLGwMBd+A4/Y
         hVDmOH+E1BTxXnEQYIiA3kwfcFEdL3dmuze1ZzfXSP+dFpjJJafwTV4nfTwBG9CcNR
         U2Uqgd/v5NMK3aG98LRY1aqIvfowfoLhnBFGrlxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7/8] debugfs: remove return value of debugfs_create_x32()
Date:   Fri, 11 Oct 2019 15:29:30 +0200
Message-Id: <20191011132931.1186197-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
References: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_x32(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.txt |  4 ++--
 fs/debugfs/file.c                     |  6 +++---
 include/linux/debugfs.h               | 12 ++++--------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 674ce905b7f7..fa2284ad6129 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -86,8 +86,8 @@ the following functions can be used instead:
 			   struct dentry *parent, u8 *value);
     void debugfs_create_x16(const char *name, umode_t mode,
 			    struct dentry *parent, u16 *value);
-    struct dentry *debugfs_create_x32(const char *name, umode_t mode,
-				      struct dentry *parent, u32 *value);
+    void debugfs_create_x32(const char *name, umode_t mode,
+			    struct dentry *parent, u32 *value);
     struct dentry *debugfs_create_x64(const char *name, umode_t mode,
 				      struct dentry *parent, u64 *value);
 
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 046426db4644..54a0db733574 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -669,10 +669,10 @@ EXPORT_SYMBOL_GPL(debugfs_create_x16);
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
-struct dentry *debugfs_create_x32(const char *name, umode_t mode,
-				 struct dentry *parent, u32 *value)
+void debugfs_create_x32(const char *name, umode_t mode, struct dentry *parent,
+			u32 *value)
 {
-	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x32,
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x32,
 				   &fops_x32_ro, &fops_x32_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x32);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index d081f51defd5..25c213e9158e 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -111,8 +111,8 @@ void debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent,
 		       u8 *value);
 void debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent,
 			u16 *value);
-struct dentry *debugfs_create_x32(const char *name, umode_t mode,
-				  struct dentry *parent, u32 *value);
+void debugfs_create_x32(const char *name, umode_t mode, struct dentry *parent,
+			u32 *value);
 struct dentry *debugfs_create_x64(const char *name, umode_t mode,
 				  struct dentry *parent, u64 *value);
 void debugfs_create_size_t(const char *name, umode_t mode,
@@ -274,12 +274,8 @@ static inline void debugfs_create_x8(const char *name, umode_t mode,
 static inline void debugfs_create_x16(const char *name, umode_t mode,
 				      struct dentry *parent, u16 *value) { }
 
-static inline struct dentry *debugfs_create_x32(const char *name, umode_t mode,
-						struct dentry *parent,
-						u32 *value)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_x32(const char *name, umode_t mode,
+				      struct dentry *parent, u32 *value) { }
 
 static inline struct dentry *debugfs_create_x64(const char *name, umode_t mode,
 						struct dentry *parent,
-- 
2.23.0

