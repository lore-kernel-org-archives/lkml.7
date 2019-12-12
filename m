Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73551C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D7521556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfLLSOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:14:37 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:56768 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbfLLSOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:14:35 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D572F200A83;
        Thu, 12 Dec 2019 18:14:33 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id D5CE020B72; Thu, 12 Dec 2019 19:14:30 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] init: unify opening /dev/console as stdin/stdout/stderr
Date:   Thu, 12 Dec 2019 19:14:21 +0100
Message-Id: <20191212181422.31033-5-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191212181422.31033-1-linux@dominikbrodowski.net>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the two instances where /dev/console is opened as
stdin/stdout/stderr.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/initrd.h  |  2 ++
 init/do_mounts_initrd.c |  5 +----
 init/main.c             | 17 ++++++++++++-----
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index d77fe34fb00a..aa5914355728 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -28,3 +28,5 @@ extern unsigned int real_root_dev;
 
 extern char __initramfs_start[];
 extern unsigned long __initramfs_size;
+
+void console_on_rootfs(void);
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 3bf7b74153ab..dab8b1151b56 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -48,10 +48,7 @@ early_param("initrd", early_initrd);
 static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 {
 	ksys_unshare(CLONE_FS | CLONE_FILES);
-	/* stdin/stdout/stderr for /linuxrc */
-	ksys_open("/dev/console", O_RDWR, 0);
-	ksys_dup(0);
-	ksys_dup(0);
+	console_on_rootfs();
 	/* move initrd over / and chdir/chroot in initrd root */
 	ksys_chdir("/root");
 	do_mount(".", "/", NULL, MS_MOVE, NULL);
diff --git a/init/main.c b/init/main.c
index 91f6ebb30ef0..2cd736059416 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1155,6 +1155,17 @@ static int __ref kernel_init(void *unused)
 	      "See Linux Documentation/admin-guide/init.rst for guidance.");
 }
 
+void console_on_rootfs(void)
+{
+	/* Open the /dev/console as stdin, this should never fail */
+	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
+		pr_err("Warning: unable to open an initial console.\n");
+
+	/* create stdout/stderr */
+	(void) ksys_dup(0);
+	(void) ksys_dup(0);
+}
+
 static noinline void __init kernel_init_freeable(void)
 {
 	/*
@@ -1190,12 +1201,8 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
-	/* Open the /dev/console on the rootfs, this should never fail */
-	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
-		pr_err("Warning: unable to open an initial console.\n");
+	console_on_rootfs();
 
-	(void) ksys_dup(0);
-	(void) ksys_dup(0);
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
-- 
2.24.1

