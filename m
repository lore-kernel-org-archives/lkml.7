Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E21AC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613A62070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BDYqmbmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKWQhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 11:37:07 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:64650 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfKWQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 11:37:07 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id xANGaggd001459;
        Sun, 24 Nov 2019 01:36:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com xANGaggd001459
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574527004;
        bh=jrbt1QEkqhIaRtOZNi98ujxsBHB0idjKNS+OyxTL/hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDYqmbmUPVGJzTgpMrQnm6OkUxml0x363j/ZXGqrAKwcLKCYBEdZRzgXJ6ySGL6uM
         rC81yfmHUcDn4d9S1xt8bp3gZJcDIJosZk+J3SWnefHZ4rmETRFd3QLJxrgArb6PCK
         GN12pDFuuTZDuLpiJBg+BWsIQoQ3BQLfMVnxCGgN41bsDYFZhg0aw0l+r6dNIFjEfF
         xCFqVDKJcJTMHDE+7iXWdZR7WxnnS4JdI7tfAWL2m+uzZIMU9DjbjVjRr9tX89rK1z
         GBO9GzVNS1gNCMNlBwzO6p4VS/m7lXTtYhvQRxfnAG/XfGaWSR5DM2zMOkwjcEWWLE
         oDeG3SVYKSOXA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] debugfs: remove modular code
Date:   Sun, 24 Nov 2019 01:36:33 +0900
Message-Id: <20191123163633.27227-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123163633.27227-1-yamada.masahiro@socionext.com>
References: <20191123163633.27227-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compilation of the code in fs/debugfs/ is controlled by
CONFIG_DEBUG_FS, which is a bool type option. Hence it is never
compiled as a module.

Remove meaningless modular code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 fs/debugfs/file.c  | 3 ---
 fs/debugfs/inode.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 87846aad594b..46e55037c0f9 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -9,7 +9,6 @@
  *  See Documentation/filesystems/ for more details.
  */
 
-#include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
 #include <linux/pagemap.h>
@@ -1005,7 +1004,6 @@ static int u32_array_release(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations u32_array_fops = {
-	.owner	 = THIS_MODULE,
 	.open	 = u32_array_open,
 	.release = u32_array_release,
 	.read	 = u32_array_read,
@@ -1149,7 +1147,6 @@ static int debugfs_devm_entry_open(struct inode *inode, struct file *f)
 }
 
 static const struct file_operations debugfs_devm_entry_ops = {
-	.owner = THIS_MODULE,
 	.open = debugfs_devm_entry_open,
 	.release = single_release,
 	.read = seq_read,
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 7b975dbb2bb4..f3478f7caab6 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -12,7 +12,6 @@
 
 #define pr_fmt(fmt)	"debugfs: " fmt
 
-#include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
@@ -270,12 +269,10 @@ static struct dentry *debug_mount(struct file_system_type *fs_type,
 }
 
 static struct file_system_type debug_fs_type = {
-	.owner =	THIS_MODULE,
 	.name =		"debugfs",
 	.mount =	debug_mount,
 	.kill_sb =	kill_litter_super,
 };
-MODULE_ALIAS_FS("debugfs");
 
 /**
  * debugfs_lookup() - look up an existing debugfs file
-- 
2.17.1

