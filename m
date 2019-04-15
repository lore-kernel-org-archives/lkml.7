Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154A2C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D8520693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="j23PWFH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfDOIZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:25:15 -0400
Received: from chill.innovation.ch ([216.218.245.220]:38686 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOIZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:25:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 7B4CF64013A;
        Mon, 15 Apr 2019 01:25:13 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Authentication-Results: chill.innovation.ch (amavisd-new);
        dkim=pass (2048-bit key) header.d=innovation.ch
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id JmRhaa1G1ekS; Mon, 15 Apr 2019 01:25:11 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 17554640114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1555316711;
        bh=3suh9rJpoi70Csao4xcrZzEU5iMCUawx/vWPGrLpONw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j23PWFH8NEQQhechZtFXtXLo0vDmZAIktxwPHr1UC6pq5tYBbfHBw9IPf0QdBafA1
         p779HAgBERNnWdkgX5Xqsp/OLCnfd1AWRd1VcBYsWUPWHlir8IjdtkkdEvDvXLVTMZ
         bcnoT2FXI1Cy4V3aIr7Qe6DBv9uu3rvU/AEbN0BeEk5RDhT/41+DMFYNShmMOOIVGu
         xUQE/y/DOQF0Fe6yHTP9/zShMEPqNgxvm76FlMZOyiiT4AqQ+S6qf3zp+v9RK+Fo+A
         UsSnjYDjQHRH8mka8ck/JJf2dx+2r1SrGJstMUtop8+JCRRSROJcX3d7LYcx8YaKUK
         Q3foyV0uq/YOA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] debugfs: update documented return values of debugfs helpers
Date:   Mon, 15 Apr 2019 01:25:05 -0700
Message-Id: <20190415082506.25610-2-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415082506.25610-1-ronald@innovation.ch>
References: <20190415082506.25610-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ff9fb72bc077 ("debugfs: return error values, not NULL")
these helper functions do not return NULL anymore (with the exception
of debugfs_create_u32_array()).

Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 Documentation/filesystems/debugfs.txt | 16 +++---
 fs/debugfs/file.c                     | 77 ++++++++++++---------------
 2 files changed, 44 insertions(+), 49 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 4f45f71149cb..4a0a9c3f4af6 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -31,10 +31,10 @@ This call, if successful, will make a directory called name underneath the
 indicated parent directory.  If parent is NULL, the directory will be
 created in the debugfs root.  On success, the return value is a struct
 dentry pointer which can be used to create files in the directory (and to
-clean it up at the end).  A NULL return value indicates that something went
-wrong.  If ERR_PTR(-ENODEV) is returned, that is an indication that the
-kernel has been built without debugfs support and none of the functions
-described below will work.
+clean it up at the end).  An ERR_PTR(-ERROR) return value indicates that
+something went wrong.  If ERR_PTR(-ENODEV) is returned, that is an
+indication that the kernel has been built without debugfs support and none
+of the functions described below will work.
 
 The most general way to create a file within a debugfs directory is with:
 
@@ -48,8 +48,9 @@ should hold the file, data will be stored in the i_private field of the
 resulting inode structure, and fops is a set of file operations which
 implement the file's behavior.  At a minimum, the read() and/or write()
 operations should be provided; others can be included as needed.  Again,
-the return value will be a dentry pointer to the created file, NULL for
-error, or ERR_PTR(-ENODEV) if debugfs support is missing.
+the return value will be a dentry pointer to the created file,
+ERR_PTR(-ERROR) on error, or ERR_PTR(-ENODEV) if debugfs support is
+missing.
 
 Create a file with an initial size, the following function can be used
 instead:
@@ -214,7 +215,8 @@ can be removed with:
 
     void debugfs_remove(struct dentry *dentry);
 
-The dentry value can be NULL, in which case nothing will be removed.
+The dentry value can be NULL or an error value, in which case nothing will
+be removed.
 
 Once upon a time, debugfs users were required to remember the dentry
 pointer for every debugfs file they created so that all files could be
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 4fce1da7db23..ddd708b09fa1 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -394,12 +394,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u8_wo, NULL, debugfs_u8_set, "%llu\n");
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
- * If debugfs is not enabled in the kernel, the value -%ENODEV will be
- * returned.  It is not wise to check for this value, but rather, check for
- * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
- * code.
+ * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * be returned.
  */
 struct dentry *debugfs_create_u8(const char *name, umode_t mode,
 				 struct dentry *parent, u8 *value)
@@ -440,12 +439,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u16_wo, NULL, debugfs_u16_set, "%llu\n");
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
- * If debugfs is not enabled in the kernel, the value -%ENODEV will be
- * returned.  It is not wise to check for this value, but rather, check for
- * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
- * code.
+ * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * be returned.
  */
 struct dentry *debugfs_create_u16(const char *name, umode_t mode,
 				  struct dentry *parent, u16 *value)
@@ -486,12 +484,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u32_wo, NULL, debugfs_u32_set, "%llu\n");
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
- * If debugfs is not enabled in the kernel, the value -%ENODEV will be
- * returned.  It is not wise to check for this value, but rather, check for
- * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
- * code.
+ * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * be returned.
  */
 struct dentry *debugfs_create_u32(const char *name, umode_t mode,
 				 struct dentry *parent, u32 *value)
@@ -533,12 +530,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
- * If debugfs is not enabled in the kernel, the value -%ENODEV will be
- * returned.  It is not wise to check for this value, but rather, check for
- * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
- * code.
+ * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * be returned.
  */
 struct dentry *debugfs_create_u64(const char *name, umode_t mode,
 				 struct dentry *parent, u64 *value)
@@ -582,12 +578,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ulong_wo, NULL, debugfs_ulong_set, "%llu\n");
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
- * If debugfs is not enabled in the kernel, the value -%ENODEV will be
- * returned.  It is not wise to check for this value, but rather, check for
- * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
- * code.
+ * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * be returned.
  */
 struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
 				    struct dentry *parent, unsigned long *value)
@@ -850,12 +845,11 @@ static const struct file_operations fops_bool_wo = {
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
- * If debugfs is not enabled in the kernel, the value -%ENODEV will be
- * returned.  It is not wise to check for this value, but rather, check for
- * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
- * code.
+ * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * be returned.
  */
 struct dentry *debugfs_create_bool(const char *name, umode_t mode,
 				   struct dentry *parent, bool *value)
@@ -904,12 +898,11 @@ static const struct file_operations fops_blob = {
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
- * If debugfs is not enabled in the kernel, the value -%ENODEV will be
- * returned.  It is not wise to check for this value, but rather, check for
- * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
- * code.
+ * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * be returned.
  */
 struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				   struct dentry *parent,
@@ -1005,8 +998,9 @@ static const struct file_operations u32_array_fops = {
  * Writing is not supported. Seek within the file is also not supported.
  * Once array is created its size can not be changed.
  *
- * The function returns a pointer to dentry on success. If debugfs is not
- * enabled in the kernel, the value -%ENODEV will be returned.
+ * The function returns a pointer to dentry on success. If an error occurs,
+ * %ERR_PTR(-ERROR) or NULL will be returned. If debugfs is not enabled in
+ * the kernel, the value %ERR_PTR(-ENODEV) will be returned.
  */
 struct dentry *debugfs_create_u32_array(const char *name, umode_t mode,
 					    struct dentry *parent,
@@ -1102,12 +1096,11 @@ static const struct file_operations fops_regset32 = {
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
- * If debugfs is not enabled in the kernel, the value -%ENODEV will be
- * returned.  It is not wise to check for this value, but rather, check for
- * %NULL or !%NULL instead as to eliminate the need for #ifdef in the calling
- * code.
+ * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
+ * be returned.
  */
 struct dentry *debugfs_create_regset32(const char *name, umode_t mode,
 				       struct dentry *parent,
-- 
2.20.1

