Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEF5C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12C8206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570800594;
	bh=VJjKva3BSaxXTNM5iwLyn1Wi7DiHaj644QZG8xvoUls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JdW8kjPE/9VgYgOR2IY6LkO2EpgSwDbqlneCRCd/TyIE9t7QePsof0lb8j7jOEMkr
	 /wkj9IJOToRenU7EYBIoX1PDvKqwfXqQbsmAlQ118rS3PgBTG4xHNQLhpGmKWGWHOT
	 CVEk8fWYKrNvsPieXvb0+rkMRy3F/oGODGrbjyno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfJKN3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:29:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbfJKN3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:29:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB102206A1;
        Fri, 11 Oct 2019 13:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570800590;
        bh=VJjKva3BSaxXTNM5iwLyn1Wi7DiHaj644QZG8xvoUls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3Vw3UC58nbaCb5QTm3cwhhFLitYCyV97rFn5vJe58Ww+45C8o2f8Z++xBi4zGlYw
         QEBReKjMKbuvN3vQbkM/jYSrm4yFyHpzV8w0fYphamnYD/ENGPCsuSDb2Mn3/L6eRm
         vjio6SCys/+QT3+f/bGSoP769RBKrhTGQk2tLBPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/8] debugfs: remove return value of debugfs_create_size_t()
Date:   Fri, 11 Oct 2019 15:29:27 +0200
Message-Id: <20191011132931.1186197-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
References: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_size_t(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.txt |  5 ++---
 fs/debugfs/file.c                     |  9 ++++-----
 include/linux/debugfs.h               | 13 +++++--------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 1b299ae4904d..55a5da08c71c 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -96,9 +96,8 @@ value to be exported.  Some types can have different widths on different
 architectures, though, complicating the situation somewhat.  There is a
 function meant to help out in one special case:
 
-    struct dentry *debugfs_create_size_t(const char *name, umode_t mode,
-				         struct dentry *parent, 
-					 size_t *value);
+    void debugfs_create_size_t(const char *name, umode_t mode,
+			       struct dentry *parent, size_t *value);
 
 As might be expected, this function will create a debugfs file to represent
 a variable of type size_t.
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 4c8912d7d34c..dfeda13023b3 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -721,12 +721,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_size_t_wo, NULL, debugfs_size_t_set, "%llu\n");
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
-struct dentry *debugfs_create_size_t(const char *name, umode_t mode,
-				     struct dentry *parent, size_t *value)
+void debugfs_create_size_t(const char *name, umode_t mode,
+			   struct dentry *parent, size_t *value)
 {
-	return debugfs_create_mode_unsafe(name, mode, parent, value,
-					&fops_size_t, &fops_size_t_ro,
-					&fops_size_t_wo);
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_size_t,
+				   &fops_size_t_ro, &fops_size_t_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_size_t);
 
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index b3bed4d61733..1d859bc657bd 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -115,8 +115,8 @@ struct dentry *debugfs_create_x32(const char *name, umode_t mode,
 				  struct dentry *parent, u32 *value);
 struct dentry *debugfs_create_x64(const char *name, umode_t mode,
 				  struct dentry *parent, u64 *value);
-struct dentry *debugfs_create_size_t(const char *name, umode_t mode,
-				     struct dentry *parent, size_t *value);
+void debugfs_create_size_t(const char *name, umode_t mode,
+			   struct dentry *parent, size_t *value);
 struct dentry *debugfs_create_atomic_t(const char *name, umode_t mode,
 				     struct dentry *parent, atomic_t *value);
 struct dentry *debugfs_create_bool(const char *name, umode_t mode,
@@ -296,12 +296,9 @@ static inline struct dentry *debugfs_create_x64(const char *name, umode_t mode,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct dentry *debugfs_create_size_t(const char *name, umode_t mode,
-				     struct dentry *parent,
-				     size_t *value)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_size_t(const char *name, umode_t mode,
+					 struct dentry *parent, size_t *value)
+{ }
 
 static inline struct dentry *debugfs_create_atomic_t(const char *name, umode_t mode,
 				     struct dentry *parent, atomic_t *value)
-- 
2.23.0

