Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB458C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65ED22408
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555424419;
	bh=IY2W6JNagtS5qvKfZZCDS1NDtJL+OzlFe6fejKbJ03Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A9sADu/FCgBQE6AJx+qc96Gx704SeEMDyNfHxTovvaY/IBdHsmuEgQaFjxFwjN9ex
	 iLPnESli+GfZHvbRjfaetDYwYlXRpJu4k6YSiF420tG9LrBKbJ+nY3RE/Hw11cn+Sq
	 wscPaV+lsh2cW2kTR4sn1GArFt+5QwKmGpu+f6NY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfDPOUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbfDPOUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:20:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E49BC223FE;
        Tue, 16 Apr 2019 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555424407;
        bh=IY2W6JNagtS5qvKfZZCDS1NDtJL+OzlFe6fejKbJ03Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YrNaqqPzy7NPDaY+M1aiyUj7p8JqsELVY7jLnf8HT2eLC7xvNY/0+KmFvpPodF3U1
         LJwBpgIbps45h5WsPAFPg/OEvUhucO0S7QNGziCARd6LDutTWd27ZSssO5k1tP2R8C
         Ma8bD8dHgWZEDuZufBmu36PynsIovhdpDSYS1CPs=
Date:   Tue, 16 Apr 2019 15:46:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: make debugfs_create_u32_array() return void
Message-ID: <20190416134655.GA21555@kroah.com>
References: <20190415082506.25610-1-ronald@innovation.ch>
 <20190415082506.25610-3-ronald@innovation.ch>
 <20190415084844.GA26101@kroah.com>
 <20190415232959.GC13033@innovation.ch>
 <20190416132925.GA17483@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416132925.GA17483@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The single user of debugfs_create_u32_array() does not care about the
return value of it, so make it return void as there is no need to do
anything with the return value.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.txt |  2 +-
 fs/debugfs/file.c                     | 13 ++++---------
 include/linux/debugfs.h               | 12 +++++-------
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 4f45f71149cb..6320e86d2294 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -168,7 +168,7 @@ byte offsets over a base for the register block.
 
 If you want to dump an u32 array in debugfs, you can create file with:
 
-    struct dentry *debugfs_create_u32_array(const char *name, umode_t mode,
+    void debugfs_create_u32_array(const char *name, umode_t mode,
 			struct dentry *parent,
 			u32 *array, u32 elements);
 
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 4fce1da7db23..2c17039c6287 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1004,24 +1004,19 @@ static const struct file_operations u32_array_fops = {
  * @array as data. If the @mode variable is so set it can be read from.
  * Writing is not supported. Seek within the file is also not supported.
  * Once array is created its size can not be changed.
- *
- * The function returns a pointer to dentry on success. If debugfs is not
- * enabled in the kernel, the value -%ENODEV will be returned.
  */
-struct dentry *debugfs_create_u32_array(const char *name, umode_t mode,
-					    struct dentry *parent,
-					    u32 *array, u32 elements)
+void debugfs_create_u32_array(const char *name, umode_t mode,
+			      struct dentry *parent, u32 *array, u32 elements)
 {
 	struct array_data *data = kmalloc(sizeof(*data), GFP_KERNEL);
 
 	if (data == NULL)
-		return NULL;
+		return;
 
 	data->array = array;
 	data->elements = elements;
 
-	return debugfs_create_file_unsafe(name, mode, parent, data,
-					&u32_array_fops);
+	debugfs_create_file_unsafe(name, mode, parent, data, &u32_array_fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u32_array);
 
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 3b0ba54cc4d5..58424eb3b329 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -133,9 +133,8 @@ struct dentry *debugfs_create_regset32(const char *name, umode_t mode,
 void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
 			  int nregs, void __iomem *base, char *prefix);
 
-struct dentry *debugfs_create_u32_array(const char *name, umode_t mode,
-					struct dentry *parent,
-					u32 *array, u32 elements);
+void debugfs_create_u32_array(const char *name, umode_t mode,
+			      struct dentry *parent, u32 *array, u32 elements);
 
 struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
 					   struct dentry *parent,
@@ -353,11 +352,10 @@ static inline bool debugfs_initialized(void)
 	return false;
 }
 
-static inline struct dentry *debugfs_create_u32_array(const char *name, umode_t mode,
-					struct dentry *parent,
-					u32 *array, u32 elements)
+static inline void debugfs_create_u32_array(const char *name, umode_t mode,
+					    struct dentry *parent, u32 *array,
+					    u32 elements)
 {
-	return ERR_PTR(-ENODEV);
 }
 
 static inline struct dentry *debugfs_create_devm_seqfile(struct device *dev,
-- 
2.21.0

