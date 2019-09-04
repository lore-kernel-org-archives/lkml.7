Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81713C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B8322CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfIDLHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:07:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50930 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfIDLHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:07:18 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i5T84-0004L3-Iv; Wed, 04 Sep 2019 11:07:12 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     hridya@google.com
Cc:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        maco@android.com, tkjos@android.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [RESEND PATCH v3 1/2] binder: Add default binder devices through binderfs when configured
Date:   Wed,  4 Sep 2019 13:07:03 +0200
Message-Id: <20190904110704.8606-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904110704.8606-1-christian.brauner@ubuntu.com>
References: <20190808222727.132744-1-hridya@google.com>
 <20190904110704.8606-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hridya Valsaraju <hridya@google.com>

Currently, since each binderfs instance needs its own
private binder devices, every time a binderfs instance is
mounted, all the default binder devices need to be created
via the BINDER_CTL_ADD IOCTL. This patch aims to
add a solution to automatically create the default binder
devices for each binderfs instance that gets mounted.
To achieve this goal, when CONFIG_ANDROID_BINDERFS is set,
the default binder devices specified by CONFIG_ANDROID_BINDER_DEVICES
are created in each binderfs instance instead of global devices
being created by the binder driver.

Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Hridya Valsaraju <hridya@google.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/20190808222727.132744-2-hridya@google.com
---
 drivers/android/binder.c          |  5 +++--
 drivers/android/binder_internal.h |  2 ++
 drivers/android/binderfs.c        | 23 ++++++++++++++++++++---
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index dc1c83eafc22..ef2d3e582368 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -122,7 +122,7 @@ static uint32_t binder_debug_mask = BINDER_DEBUG_USER_ERROR |
 	BINDER_DEBUG_FAILED_TRANSACTION | BINDER_DEBUG_DEAD_TRANSACTION;
 module_param_named(debug_mask, binder_debug_mask, uint, 0644);
 
-static char *binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
+char *binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
 module_param_named(devices, binder_devices_param, charp, 0444);
 
 static DECLARE_WAIT_QUEUE_HEAD(binder_user_error_wait);
@@ -6131,7 +6131,8 @@ static int __init binder_init(void)
 				    &transaction_log_fops);
 	}
 
-	if (strcmp(binder_devices_param, "") != 0) {
+	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
+	    strcmp(binder_devices_param, "") != 0) {
 		/*
 		* Copy the module_parameter string, because we don't want to
 		* tokenize it in-place.
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 045b3e42d98b..fe8c745dc8e0 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -37,6 +37,8 @@ struct binder_device {
 
 extern const struct file_operations binder_fops;
 
+extern char *binder_devices_param;
+
 #ifdef CONFIG_ANDROID_BINDERFS
 extern bool is_binderfs_device(const struct inode *inode);
 #else
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index e773f45d19d9..aee46dd1be91 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -186,8 +186,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	req->major = MAJOR(binderfs_dev);
 	req->minor = minor;
 
-	ret = copy_to_user(userp, req, sizeof(*req));
-	if (ret) {
+	if (userp && copy_to_user(userp, req, sizeof(*req))) {
 		ret = -EFAULT;
 		goto err;
 	}
@@ -467,6 +466,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 	int ret;
 	struct binderfs_info *info;
 	struct inode *inode = NULL;
+	struct binderfs_device device_info = { 0 };
+	const char *name;
+	size_t len;
 
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
@@ -521,7 +523,22 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 	if (!sb->s_root)
 		return -ENOMEM;
 
-	return binderfs_binder_ctl_create(sb);
+	ret = binderfs_binder_ctl_create(sb);
+	if (ret)
+		return ret;
+
+	name = binder_devices_param;
+	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
+		strscpy(device_info.name, name, len + 1);
+		ret = binderfs_binder_device_create(inode, NULL, &device_info);
+		if (ret)
+			return ret;
+		name += len;
+		if (*name == ',')
+			name++;
+	}
+
+	return 0;
 }
 
 static struct dentry *binderfs_mount(struct file_system_type *fs_type,
-- 
2.23.0

