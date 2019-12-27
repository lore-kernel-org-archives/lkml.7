Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FFBC2D0DC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E0820838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0tf8yE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfL0BAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 20:00:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43098 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfL0BAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:00:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id k197so13649516pga.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 17:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWOe5wokD7PXE5eb2l014Cgkgdh+K2uUczGe6c1Zn5M=;
        b=G0tf8yE5BzwsGri54YqX9qkHwBzqAb1SlIAHjCgD1XEA9GVAb4Aai1Z7esmISMxhLw
         bS6Su/TS75k27tdZvxtBFF1JCvIRihvsk9b7vDjqAbECygQ6fxeDx6kbaBi+qEzdaCFi
         vhp1Jpdjv6GGvEY1b4C81NwDj+eX6NBZb6z6zDbFNNbseKK8wG50eQrsw1qcY2ddRqC0
         zWyGndClawbvL4oK1+78JT9P6Kvn/6VlGjnO/y+t5/K0Kw7zGBTozye30Galz/07aoiF
         5H3/qBB9olu2cgaWOMaFSnF4rhVHbFyBnGK+uyza5fqtFUnb3L+rvc76LOqtav+tObDj
         AzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWOe5wokD7PXE5eb2l014Cgkgdh+K2uUczGe6c1Zn5M=;
        b=GCM/9MBMZXgjIpLHLHzQmbhZuIURmjNPXzIIyjgZ62zfM5ChMJ4TGt3StmVJ+iqbLC
         l6VfyycMrqajrbsz7qRehvZ+Rq/uX3EsarnxBU4vdPNeD91dXZgdvP7tMG9ht1h63LQg
         SJ+lzmbVX4Ob7otad7J5N9LzZZYvdeB9ccvbK/9V3bZEvKCfVyf2diYJELfOh4Xzg7rF
         +VRV2XOOuOmNDkBpp+zcAsc91vNnKMPTEntXxdxSbQ9EeMpx0JmuJ/tKBUZQxkF5i6QC
         /cf8MePQZoIpvIsk9ZTlBJyHNpzSIy8M/DJE5gyGOdW7FC2Prb99VfnLRqacZ57a0M5B
         hT+w==
X-Gm-Message-State: APjAAAUy7qsljW9ONeg2bl3JIdk4CQTsbOAFSazirdoWrGuxwnTUtrFO
        pnTMkib6K9DT2aE0dZ0b4JE=
X-Google-Smtp-Source: APXvYqxXnYvMF50GmyIIVzf5l5l/GfR2e8sXtXBVWFxftnmTZ9bmTVmV+IDX95lRuqgGIKvs7BIYgA==
X-Received: by 2002:aa7:96c7:: with SMTP id h7mr50263431pfq.211.1577408445697;
        Thu, 26 Dec 2019 17:00:45 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id 65sm39640144pfu.140.2019.12.26.17.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 17:00:45 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Documentation: fs: Fix warnings
Date:   Thu, 26 Dec 2019 22:00:33 -0300
Message-Id: <20191227010035.854913-1-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warnings:

fs/debugfs/inode.c:423: WARNING: Inline literal start-string without end-string.
fs/debugfs/inode.c:502: WARNING: Inline literal start-string without end-string.
fs/debugfs/inode.c:534: WARNING: Inline literal start-string without end-string.
fs/debugfs/inode.c:627: WARNING: Inline literal start-string without end-string.
fs/debugfs/file.c:496: WARNING: Inline literal start-string without end-string.
fs/debugfs/file.c:502: WARNING: Inline literal start-string without end-string.
fs/debugfs/file.c:581: WARNING: Inline literal start-string without end-string.
fs/debugfs/file.c:587: WARNING: Inline literal start-string without end-string.
fs/debugfs/file.c:846: WARNING: Inline literal start-string without end-string.
fs/debugfs/file.c:852: WARNING: Inline literal start-string without end-string.
fs/debugfs/file.c:899: WARNING: Inline literal start-string without end-string.
fs/debugfs/file.c:905: WARNING: Inline literal start-string without end-string.
fs/debugfs/file.c:1091: WARNING: Inline literal start-string without end-string.
fs/debugfs/file.c:1097: WARNING: Inline literal start-string without end-string

By replacing %ERR_PTR with ERR_PTR.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 fs/debugfs/file.c  | 21 ++++++++++-----------
 fs/debugfs/inode.c |  9 ++++-----
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index dede25247b81..8be46add9105 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -496,10 +496,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u32_wo, NULL, debugfs_u32_set, "%llu\n");
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
  * returned.
  *
- * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
  * be returned.
  */
 struct dentry *debugfs_create_u32(const char *name, umode_t mode,
@@ -581,10 +581,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ulong_wo, NULL, debugfs_ulong_set, "%llu\n");
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
  * returned.
  *
- * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
  * be returned.
  */
 struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
@@ -846,10 +846,10 @@ static const struct file_operations fops_bool_wo = {
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
  * returned.
  *
- * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
  * be returned.
  */
 struct dentry *debugfs_create_bool(const char *name, umode_t mode,
@@ -899,10 +899,10 @@ static const struct file_operations fops_blob = {
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
  * returned.
  *
- * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
  * be returned.
  */
 struct dentry *debugfs_create_blob(const char *name, umode_t mode,
@@ -1091,10 +1091,10 @@ static const struct file_operations fops_regset32 = {
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
  * returned.
  *
- * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
  * be returned.
  */
 struct dentry *debugfs_create_regset32(const char *name, umode_t mode,
@@ -1158,4 +1158,3 @@ struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
 				   &debugfs_devm_entry_ops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_devm_seqfile);
-
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index f4d8df5e4714..dc6cffc4feba 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -423,7 +423,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
  * returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
@@ -502,7 +502,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_unsafe);
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
  * returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
@@ -534,7 +534,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_size);
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
  * returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
@@ -627,7 +627,7 @@ EXPORT_SYMBOL(debugfs_create_automount);
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the symbolic
  * link is to be removed (no automatic cleanup happens if your module is
- * unloaded, you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR)
+ * unloaded, you are responsible here.)  If an error occurs, ERR_PTR(-ERROR)
  * will be returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
@@ -906,4 +906,3 @@ static int __init debugfs_init(void)
 	return retval;
 }
 core_initcall(debugfs_init);
-
-- 
2.24.1

