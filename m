Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74069ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E78421E6F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570800598;
	bh=mfFXkUfC4sgs4i3sQJ/iXGTLn/gQxySqej98EcH3bLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VLIebiYR4wAPuIkSU2Vuyhn/TQHudjGGvhoUpHKYgYhy9xGxlkz/Vq2ciZcEBaKhE
	 pzGjluIYA2XByEBPmMH5aRq5CveIWVINEN/hJZuq3jPtno3HecsgfcoDH+CD2Z275o
	 nHnvzfm/9a1YdnSTILRkEgLrfEk1sWVCr9K6f9ZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfJKN34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbfJKN3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:29:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EDD42053B;
        Fri, 11 Oct 2019 13:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570800593;
        bh=mfFXkUfC4sgs4i3sQJ/iXGTLn/gQxySqej98EcH3bLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBQh/DZlJK8t6I9SMAaWFNrXfQLIaSTCkRht7uqCf9GrAlfD9pzyUSulTUYKc6YcA
         PPhMIqli+uDVNSaubY4vQqIMes2F38/D2lMOIF+f3Ua9PpJLldjWAQbJblWbcZSvB9
         cqs15dRAO3dX55vQksNFk+2njgtGaqFVxg86iEPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5/8] debugfs: remove return value of debugfs_create_x8()
Date:   Fri, 11 Oct 2019 15:29:28 +0200
Message-Id: <20191011132931.1186197-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
References: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_x8(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.txt |  4 ++--
 fs/debugfs/file.c                     |  6 +++---
 include/linux/debugfs.h               | 12 ++++--------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 55a5da08c71c..2c4ea9b73572 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -82,8 +82,8 @@ file should not be written to, simply set the mode bits accordingly.  The
 values in these files are in decimal; if hexadecimal is more appropriate,
 the following functions can be used instead:
 
-    struct dentry *debugfs_create_x8(const char *name, umode_t mode,
-				     struct dentry *parent, u8 *value);
+    void debugfs_create_x8(const char *name, umode_t mode,
+			   struct dentry *parent, u8 *value);
     struct dentry *debugfs_create_x16(const char *name, umode_t mode,
 				      struct dentry *parent, u16 *value);
     struct dentry *debugfs_create_x32(const char *name, umode_t mode,
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index dfeda13023b3..693c9336b040 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -633,10 +633,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_x64_wo, NULL, debugfs_u64_set, "0x%016llx\n");
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
-struct dentry *debugfs_create_x8(const char *name, umode_t mode,
-				 struct dentry *parent, u8 *value)
+void debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent,
+		       u8 *value)
 {
-	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x8,
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x8,
 				   &fops_x8_ro, &fops_x8_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x8);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 1d859bc657bd..70d38dc6b151 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -107,8 +107,8 @@ void debugfs_create_u64(const char *name, umode_t mode, struct dentry *parent,
 			u64 *value);
 struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
 				    struct dentry *parent, unsigned long *value);
-struct dentry *debugfs_create_x8(const char *name, umode_t mode,
-				 struct dentry *parent, u8 *value);
+void debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent,
+		       u8 *value);
 struct dentry *debugfs_create_x16(const char *name, umode_t mode,
 				  struct dentry *parent, u16 *value);
 struct dentry *debugfs_create_x32(const char *name, umode_t mode,
@@ -268,12 +268,8 @@ static inline struct dentry *debugfs_create_ulong(const char *name,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct dentry *debugfs_create_x8(const char *name, umode_t mode,
-					       struct dentry *parent,
-					       u8 *value)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_x8(const char *name, umode_t mode,
+				     struct dentry *parent, u8 *value) { }
 
 static inline struct dentry *debugfs_create_x16(const char *name, umode_t mode,
 						struct dentry *parent,
-- 
2.23.0

