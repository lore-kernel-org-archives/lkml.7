Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF55C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7936E24654
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfLLSOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:14:47 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:56762 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfLLSOg (ORCPT
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
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D9B6E200A91;
        Thu, 12 Dec 2019 18:14:33 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 4579E20B6C; Thu, 12 Dec 2019 19:14:29 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] devtmpfs: use do_mount() instead of ksys_mount()
Date:   Thu, 12 Dec 2019 19:14:18 +0100
Message-Id: <20191212181422.31033-2-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191212181422.31033-1-linux@dominikbrodowski.net>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In devtmpfs, do_mount() can be called directly instead of complex wrapping
by ksys_mount():
- the first and third arguments are const strings in the kernel,
  and do not need to be copied over from userspace;
- the fifth argument is NULL, and therefore no page needs to be
  copied over from userspace;
- the second and fourth argument are passed through anyway.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/base/devtmpfs.c | 6 +++---
 include/linux/device.h  | 4 ++--
 init/do_mounts.c        | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 30d0523014e0..6cdbf1531238 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -359,7 +359,7 @@ static int handle_remove(const char *nodename, struct device *dev)
  * If configured, or requested by the commandline, devtmpfs will be
  * auto-mounted after the kernel mounted the root filesystem.
  */
-int devtmpfs_mount(const char *mntdir)
+int devtmpfs_mount(void)
 {
 	int err;
 
@@ -369,7 +369,7 @@ int devtmpfs_mount(const char *mntdir)
 	if (!thread)
 		return 0;
 
-	err = ksys_mount("devtmpfs", mntdir, "devtmpfs", MS_SILENT, NULL);
+	err = do_mount("devtmpfs", "dev", "devtmpfs", MS_SILENT, NULL);
 	if (err)
 		printk(KERN_INFO "devtmpfs: error mounting %i\n", err);
 	else
@@ -394,7 +394,7 @@ static int devtmpfsd(void *p)
 	*err = ksys_unshare(CLONE_NEWNS);
 	if (*err)
 		goto out;
-	*err = ksys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, NULL);
+	*err = do_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, NULL);
 	if (*err)
 		goto out;
 	ksys_chdir("/.."); /* will traverse into overmounted root */
diff --git a/include/linux/device.h b/include/linux/device.h
index e226030c1df3..96ff76731e93 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1666,11 +1666,11 @@ extern bool kill_device(struct device *dev);
 #ifdef CONFIG_DEVTMPFS
 extern int devtmpfs_create_node(struct device *dev);
 extern int devtmpfs_delete_node(struct device *dev);
-extern int devtmpfs_mount(const char *mntdir);
+extern int devtmpfs_mount(void);
 #else
 static inline int devtmpfs_create_node(struct device *dev) { return 0; }
 static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
-static inline int devtmpfs_mount(const char *mountpoint) { return 0; }
+static inline int devtmpfs_mount(void) { return 0; }
 #endif
 
 /* drivers/base/power/shutdown.c */
diff --git a/init/do_mounts.c b/init/do_mounts.c
index af9cda887a23..43f6d098c880 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -670,7 +670,7 @@ void __init prepare_namespace(void)
 
 	mount_root();
 out:
-	devtmpfs_mount("dev");
+	devtmpfs_mount();
 	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
 	ksys_chroot(".");
 }
-- 
2.24.1

