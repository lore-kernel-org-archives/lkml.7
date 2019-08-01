Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8223C32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD16206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZXPrbN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbfHAWgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:36:15 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45500 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfHAWgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:36:13 -0400
Received: by mail-pl1-f201.google.com with SMTP id y9so40449815plp.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Q8S6sBR/EDTcEWov03yTX8vEHgSrUzDM01pDpuH2jZ4=;
        b=YZXPrbN9uObA2Jl9VVSGXgNRzykbiYE/fs3pbhidBME76TTmSarWpnZSQ7X39+F0ou
         JQrTvb04xQ5Gm8Qi8/VnonZDdBHAcK18MS6OB1B1I2DDdpElnw/XadvEnYkhB3fP4fED
         P1MayVzSWMK7kHsemKAJcqLiJcVX1tiOwUd0bH5JcJ+BuPKe9EScjjUfwqLlz9AGusBv
         qUotVh40xOGoZ0cE3Mc5sAywuKAyxKW8IB86IRZ1q27lTgt3ZLlTlnVgcLmiuPoY1oy4
         bArhkyIxr6RrYMdGPs/QqFS7QK+mrnqI49Lpu+vysV5/CacoHP4/qbk0Au7lU8ed4mdF
         Y38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Q8S6sBR/EDTcEWov03yTX8vEHgSrUzDM01pDpuH2jZ4=;
        b=Fqjq3QIcFcGbvBz0Za2DrT3H74AzszgeyzTJyEj+JyggQWxpPKJN/pcnP7y9oxQ9QL
         7zQRMype+0jMq1al7xP9/7L+8kSUEa2lj9v9KB7+0w/gFYYrLnDTaoOCATgXs1i1wO1R
         7FQt6rD4Ciu7+nfEuVloLWBnzs8G/MDtFhihTfMI51tC8A2Djs/I+9IsXgHFmsBOOS8C
         sTT/O6kPQMneSmyZV5HryhNIzLbU9MJuBxZI3JhTHizr4xjueuEoXIX4ONnQFEtQuSei
         rvfbxeEA9kNazNyE1MoNAHy3YDpTU4+sZEjZSnoQyrxvajFQvVteFhIlRlx8ENVGYRVB
         gV3w==
X-Gm-Message-State: APjAAAUc9E4nmIZUKne1E9mpGAomtH9L+TtwwgrGEg+JciV/QrkX4UaB
        il7KRCedBpi4Cl88TCauT5Iqoip6PVQ=
X-Google-Smtp-Source: APXvYqxoB79TCfX3OovycYkRN4gWxwtMQhOboagfCQrm1BcM75QPCFwXBpt41q4AHDtMjnKrmor0xtsHznw=
X-Received: by 2002:a63:3147:: with SMTP id x68mr58481466pgx.212.1564698971325;
 Thu, 01 Aug 2019 15:36:11 -0700 (PDT)
Date:   Thu,  1 Aug 2019 15:35:56 -0700
Message-Id: <20190801223556.209184-1-hridya@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH] Add default binder devices through binderfs when configured
From:   Hridya Valsaraju <hridya@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_ANDROID_BINDERFS is set, the default binder devices
specified by CONFIG_ANDROID_BINDER_DEVICES are created in each
binderfs instance instead of global devices being created by
the binder driver.

Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Hridya Valsaraju <hridya@google.com>
---
 drivers/android/binder.c   |  3 ++-
 drivers/android/binderfs.c | 46 ++++++++++++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 466b6a7f8ab7..65a99ac26711 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6279,7 +6279,8 @@ static int __init binder_init(void)
 				    &transaction_log_fops);
 	}
 
-	if (strcmp(binder_devices_param, "") != 0) {
+	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
+	    strcmp(binder_devices_param, "") != 0) {
 		/*
 		* Copy the module_parameter string, because we don't want to
 		* tokenize it in-place.
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index e773f45d19d9..9f5ed50ffd70 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -48,6 +48,10 @@ static dev_t binderfs_dev;
 static DEFINE_MUTEX(binderfs_minors_mutex);
 static DEFINE_IDA(binderfs_minors);
 
+static char *binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
+module_param_named(devices, binder_devices_param, charp, 0444);
+MODULE_PARM_DESC(devices, "Binder devices to be created by default");
+
 /**
  * binderfs_mount_opts - mount options for binderfs
  * @max: maximum number of allocatable binderfs binder devices
@@ -135,7 +139,6 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 #else
 	bool use_reserve = true;
 #endif
-
 	/* Reserve new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
 	if (++info->device_count <= info->mount_opts.max)
@@ -186,8 +189,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	req->major = MAJOR(binderfs_dev);
 	req->minor = minor;
 
-	ret = copy_to_user(userp, req, sizeof(*req));
-	if (ret) {
+	if (userp && copy_to_user(userp, req, sizeof(*req))) {
 		ret = -EFAULT;
 		goto err;
 	}
@@ -467,6 +469,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 	int ret;
 	struct binderfs_info *info;
 	struct inode *inode = NULL;
+	struct binderfs_device device_info = { 0 };
+	const char *name;
+	size_t len;
 
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
@@ -521,7 +526,28 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 	if (!sb->s_root)
 		return -ENOMEM;
 
-	return binderfs_binder_ctl_create(sb);
+	ret = binderfs_binder_ctl_create(sb);
+	if (ret)
+		return ret;
+
+	name = binder_devices_param;
+	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
+		/*
+		 * init_binderfs() has already checked that the length of
+		 * device_name_entry->name is not greater than device_info.name.
+		 */
+		strscpy(device_info.name, name, len + 1);
+		ret = binderfs_binder_device_create(inode, NULL, &device_info);
+		if (ret)
+			return ret;
+		name += len;
+		if (*name == ',')
+			name++;
+
+	}
+
+	return 0;
+
 }
 
 static struct dentry *binderfs_mount(struct file_system_type *fs_type,
@@ -553,6 +579,18 @@ static struct file_system_type binder_fs_type = {
 int __init init_binderfs(void)
 {
 	int ret;
+	const char *name;
+	size_t len;
+
+	/* Verify that the default binderfs device names are valid. */
+	name = binder_devices_param;
+	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
+		if (len > BINDERFS_MAX_NAME)
+			return -E2BIG;
+		name += len;
+		if (*name == ',')
+			name++;
+	}
 
 	/* Allocate new major number for binderfs. */
 	ret = alloc_chrdev_region(&binderfs_dev, 0, BINDERFS_MAX_MINOR,
-- 
2.22.0.770.g0f2c4a37fd-goog

