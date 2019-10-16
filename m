Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC73FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5BA20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571231016;
	bh=Z78ULDNnjtEHNfa2EEEaBAQoxzgGn7F8+ZBCCPNh2bA=;
	h=Date:From:To:Subject:List-ID:From;
	b=EGRnD1hamk0WUBImNf8hBIX7LjNeOXJrFGlEapvY1xQcla/oUj4w+mfrciIdHC9yu
	 OMGgs32rCoRT11UuXfBf5iMNRCVs6dQm2xFKi+5uPGDT+u2vLuDUgYjk+KCUDiCi2C
	 er4eD49R/gzlJMdkmPs4aQm5I4VGgJThXVyb8p3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393429AbfJPNDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393419AbfJPNDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:03:34 -0400
Received: from localhost (unknown [209.136.236.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E3E20854;
        Wed, 16 Oct 2019 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571231013;
        bh=Z78ULDNnjtEHNfa2EEEaBAQoxzgGn7F8+ZBCCPNh2bA=;
        h=Date:From:To:Subject:From;
        b=as7Kgd0bcsCi4b5BilhFTktF2yFC+9pGXXSIfHekPmFnSXe699KOKNz2vZkcwRwPi
         KbelPulV4tBFxWyWNaNloq15lHx+lVKGKZXtAmKQDlgoLjy9u5arQTsx4BBzzzDEEz
         2bX0JK6sBihEvJ6UenKjRa6K3MAusIDW3LckNRRs=
Date:   Wed, 16 Oct 2019 06:03:32 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: remove return value of debugfs_create_atomic_t()
Message-ID: <20191016130332.GA28240@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_atomic_t(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.txt |  4 ++--
 fs/debugfs/file.c                     |  9 ++++-----
 include/linux/debugfs.h               | 13 ++++++-------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 4a7a477a73d3..b8e544f84a34 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -113,8 +113,8 @@ lower-case values, or 1 or 0.  Any other input will be silently ignored.
 
 Also, atomic_t values can be placed in debugfs with:
 
-    struct dentry *debugfs_create_atomic_t(const char *name, umode_t mode,
-				struct dentry *parent, atomic_t *value)
+    void debugfs_create_atomic_t(const char *name, umode_t mode,
+				 struct dentry *parent, atomic_t *value)
 
 A read of this file will get atomic_t values, and a write of this file
 will set atomic_t values.
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 803b5aab31fc..a86cb0b1c69c 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -748,12 +748,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic_t_wo, NULL, debugfs_atomic_t_set,
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
-struct dentry *debugfs_create_atomic_t(const char *name, umode_t mode,
-				 struct dentry *parent, atomic_t *value)
+void debugfs_create_atomic_t(const char *name, umode_t mode,
+			     struct dentry *parent, atomic_t *value)
 {
-	return debugfs_create_mode_unsafe(name, mode, parent, value,
-					&fops_atomic_t, &fops_atomic_t_ro,
-					&fops_atomic_t_wo);
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_atomic_t,
+				   &fops_atomic_t_ro, &fops_atomic_t_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_atomic_t);
 
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 578c35ecdab9..1bd7e1772534 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -117,8 +117,8 @@ void debugfs_create_x64(const char *name, umode_t mode, struct dentry *parent,
 			u64 *value);
 void debugfs_create_size_t(const char *name, umode_t mode,
 			   struct dentry *parent, size_t *value);
-struct dentry *debugfs_create_atomic_t(const char *name, umode_t mode,
-				     struct dentry *parent, atomic_t *value);
+void debugfs_create_atomic_t(const char *name, umode_t mode,
+			     struct dentry *parent, atomic_t *value);
 struct dentry *debugfs_create_bool(const char *name, umode_t mode,
 				  struct dentry *parent, bool *value);
 
@@ -280,11 +280,10 @@ static inline void debugfs_create_size_t(const char *name, umode_t mode,
 					 struct dentry *parent, size_t *value)
 { }
 
-static inline struct dentry *debugfs_create_atomic_t(const char *name, umode_t mode,
-				     struct dentry *parent, atomic_t *value)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_atomic_t(const char *name, umode_t mode,
+					   struct dentry *parent,
+					   atomic_t *value)
+{ }
 
 static inline struct dentry *debugfs_create_bool(const char *name, umode_t mode,
 						 struct dentry *parent,
-- 
2.23.0

