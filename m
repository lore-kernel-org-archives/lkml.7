Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAB4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31949214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijU38H5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404848AbfHHW1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:27:47 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45075 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404609AbfHHW1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:27:47 -0400
Received: by mail-pl1-f201.google.com with SMTP id y9so56272698plp.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Gg8nHdywARqj4NfIjRfnVnITGpTVJRTSlVwGVid0Qko=;
        b=ijU38H5kf5gPrtFLsVxbQKfJV+WB9zN4OKWEFpdOF99YKzidgPnA3zkMBd4K8IkvjC
         fqru1IJuLAmGAH+rl5s2E2irvjFeeg/y1hk+eOeDvqxrPXtz9ZwiE96E3trFp/3xCfIA
         3M1WynnVATUMgi8dK0mY4H44CrRXdZXHwjdBX68mrx6XYumjQCa4OKjjpnSnnOgN9F+z
         RG0B2UmoA6gdrhwn8iJpNnInXxPz3CkxYoEHmQCpMZI4Ijr0CWmclYLQzVjqzxOOwrJj
         HjEs6n4IlU/rgQDlnktw9GzWpe2AMJ8UcnbiSXn8DlOgYWjnz5dy4pb4qu6qvGkoUx1r
         A/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gg8nHdywARqj4NfIjRfnVnITGpTVJRTSlVwGVid0Qko=;
        b=iJOAAjvR/aI5Pr7dAtrmiDE3APcqCzjVzlUbjbC/4xf7APcXr249z8uVwXdN9HjbCB
         KG4GzPoMB15tE1S+8qVsKN2zdywNiY1wwkC1Ypj6IaBGIh/oeU7t1/8zHJl7IJ1CuKAI
         q6UFf5LbWmKurq/27XsvS6FUrogrIzALfynH37XljDv7LorAVA0PwD8VrLWtcj9sMhxp
         FgeBOHFXHzf4IBHmHjXxUh+hg9MiC3PUM2dR4CX65BLsSaiQffHYNBIvmAr/Vd+MPd2z
         qo+X9GTs5HbWaEXetKpxAvluOx54eSxTSRwbxkktjKr8ClcqKxnV6EgYEde7PrbXwCqX
         bynA==
X-Gm-Message-State: APjAAAVznRl5TwIkbpIk8OPDqBfk8xOWvjZ9y31e+W4/p9cwgrw0cNqo
        TtmxtvzwZ1d8/khoRgCar/6r+X/OL40=
X-Google-Smtp-Source: APXvYqx6pc8AZYRIy2S2wR703wxN2Gqx0htVtO5Ct/fs0PSgsxmOGzaRIrPBwEeB/GN6lOSy0S/4Lc4qKDE=
X-Received: by 2002:a65:5a44:: with SMTP id z4mr14811850pgs.41.1565303266166;
 Thu, 08 Aug 2019 15:27:46 -0700 (PDT)
Date:   Thu,  8 Aug 2019 15:27:25 -0700
In-Reply-To: <20190808222727.132744-1-hridya@google.com>
Message-Id: <20190808222727.132744-2-hridya@google.com>
Mime-Version: 1.0
References: <20190808222727.132744-1-hridya@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v3 1/2] binder: Add default binder devices through binderfs
 when configured
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
---

Changes in v2:
- Updated commit message as per Greg Kroah-Hartman.
- Removed new module parameter creation as per Greg
  Kroah-Hartman/Christian Brauner.
- Refactored device name length check into a new patch as per Greg Kroah-Hartman.

Changes in v3:
-Removed unnecessary empty lines as per Dan Carpenter.

 drivers/android/binder.c          |  5 +++--
 drivers/android/binder_internal.h |  2 ++
 drivers/android/binderfs.c        | 23 ++++++++++++++++++++---
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 466b6a7f8ab7..ca6b21a53321 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -123,7 +123,7 @@ static uint32_t binder_debug_mask = BINDER_DEBUG_USER_ERROR |
 	BINDER_DEBUG_FAILED_TRANSACTION | BINDER_DEBUG_DEAD_TRANSACTION;
 module_param_named(debug_mask, binder_debug_mask, uint, 0644);
 
-static char *binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
+char *binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
 module_param_named(devices, binder_devices_param, charp, 0444);
 
 static DECLARE_WAIT_QUEUE_HEAD(binder_user_error_wait);
@@ -6279,7 +6279,8 @@ static int __init binder_init(void)
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
2.22.0.770.g0f2c4a37fd-goog

