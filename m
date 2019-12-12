Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51737C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3597421556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfLLSOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:14:37 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:56756 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbfLLSOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:14:36 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id DB169200A94;
        Thu, 12 Dec 2019 18:14:33 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 62F5D20B70; Thu, 12 Dec 2019 19:14:30 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] init: use do_mount() instead of ksys_mount()
Date:   Thu, 12 Dec 2019 19:14:20 +0100
Message-Id: <20191212181422.31033-4-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191212181422.31033-1-linux@dominikbrodowski.net>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prepare_namespace(), do_mount() can be used instead of ksys_mount()
as the first and third argument are const strings in the kernel, the
second and fourth argument are passed through anyway, and the fifth
argument is NULL.

In do_mount_root(), ksys_mount() is called with the first and third
argument being already kernelspace strings, which do not need to be
copied over from userspace to kernelspace (again). The second and
fourth arguments are passed through to do_mount() anyway. The fifth
argument, while already residing in kernelspace, needs to be put into
a page of its own. Then, do_mount() can be used instead of
ksys_mount().

Once this is done, there are no in-kernel users to ksys_mount() left,
which can therefore be removed.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/namespace.c           | 10 ++--------
 include/linux/syscalls.h |  2 --
 init/do_mounts.c         | 28 ++++++++++++++++++++++------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2fd0c8bcb8c1..be601d3a8008 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3325,8 +3325,8 @@ struct dentry *mount_subtree(struct vfsmount *m, const char *name)
 }
 EXPORT_SYMBOL(mount_subtree);
 
-int ksys_mount(const char __user *dev_name, const char __user *dir_name,
-	       const char __user *type, unsigned long flags, void __user *data)
+SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
+		char __user *, type, unsigned long, flags, void __user *, data)
 {
 	int ret;
 	char *kernel_type;
@@ -3359,12 +3359,6 @@ int ksys_mount(const char __user *dev_name, const char __user *dir_name,
 	return ret;
 }
 
-SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
-		char __user *, type, unsigned long, flags, void __user *, data)
-{
-	return ksys_mount(dev_name, dir_name, type, flags, data);
-}
-
 /*
  * Create a kernel mount representation for a new, prepared superblock
  * (specified by fs_fd) and attach to an open_tree-like file descriptor.
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index d0391cc2dae9..5262b7a76d39 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1231,8 +1231,6 @@ asmlinkage long sys_ni_syscall(void);
  * the ksys_xyzyyz() functions prototyped below.
  */
 
-int ksys_mount(const char __user *dev_name, const char __user *dir_name,
-	       const char __user *type, unsigned long flags, void __user *data);
 int ksys_umount(char __user *name, int flags);
 int ksys_dup(unsigned int fildes);
 int ksys_chroot(const char __user *filename);
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 43f6d098c880..f55cbd9cb818 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -387,12 +387,25 @@ static void __init get_fs_names(char *page)
 	*s = '\0';
 }
 
-static int __init do_mount_root(char *name, char *fs, int flags, void *data)
+static int __init do_mount_root(const char *name, const char *fs,
+				 const int flags, const void *data)
 {
 	struct super_block *s;
-	int err = ksys_mount(name, "/root", fs, flags, data);
-	if (err)
-		return err;
+	char *data_page;
+	struct page *p;
+	int ret;
+
+	/* do_mount() requires a full page as fifth argument */
+	p = alloc_page(GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	data_page = page_address(p);
+	strncpy(data_page, data, PAGE_SIZE - 1);
+
+	ret = do_mount(name, "/root", fs, flags, data_page);
+	if (ret)
+		goto out;
 
 	ksys_chdir("/root");
 	s = current->fs->pwd.dentry->d_sb;
@@ -402,7 +415,10 @@ static int __init do_mount_root(char *name, char *fs, int flags, void *data)
 	       s->s_type->name,
 	       sb_rdonly(s) ? " readonly" : "",
 	       MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
-	return 0;
+
+out:
+	put_page(p);
+	return ret;
 }
 
 void __init mount_block_root(char *name, int flags)
@@ -671,7 +687,7 @@ void __init prepare_namespace(void)
 	mount_root();
 out:
 	devtmpfs_mount();
-	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
+	do_mount(".", "/", NULL, MS_MOVE, NULL);
 	ksys_chroot(".");
 }
 
-- 
2.24.1

