Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D619EC32756
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDC6216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVRbzD5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfHFSku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:40:50 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:46886 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfHFSkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:40:40 -0400
Received: by mail-qt1-f202.google.com with SMTP id k31so79898327qte.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3gHpNPP1fnGrZAV26eEJQxjBXqWlw2vn3cK+N4C2Azg=;
        b=aVRbzD5JDu0Fk13cbLAGvxnSJ47je+XwmMOS2Ygv0A6wpqI52paQJaZsXOvsEQJUGz
         BUNrVTEi3/pqNeI+In/GrDkR+SRbMBIzJggCVu60OsO1w4Z5CizfoyBtVsRZ3fibcnxI
         NJSklHKSZKTI8YNGSleyYy3ZQT8gOpVBH+ZNGzskWO5eWS0ZOla8yCKyba65CXAW7wBo
         egVYNnN7h9MwoPdvup7KeQXwDfxIcHCXioCLu1YwI50Wf0aO5UEXQYLSjA6kyZh9S4Mn
         e4O53EGYazUQW6JWQZfCm3Bffma6vJQnbKtySiQ2NqInvVeM1lFieFawaOsHO+MtUl+0
         XjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3gHpNPP1fnGrZAV26eEJQxjBXqWlw2vn3cK+N4C2Azg=;
        b=SXO3kLHyXnXjDrQeluy1WpB2LjcT2kpcLWXeRrApK3tWiFpvOba3z5PUOhzXwYhx0q
         Hui66TI+5/gOZCXtZBjyZHb0EyWJbAGk8oEfBRE7ZHdAoL440MmxP7iuo/7uQQhasX6A
         RN26p/gYiXKdWhKsdVk859Psnvyw5Vj1Rwyg/YC+jURSUH0FQ9X4t51dYuLjT7I2xs5u
         utnYbuo8mcKtItTSE0TKeK7dnM7z2ZjGgqPuSaHPtqxGDJSnJ4//oCs1KluE1gXlQ0Rl
         l1Ik+f1zMAk7X3siiOtB83pHFLCrpm/G1ormOcSgg1lTn0t0l0oEN9zgp2QPG5SxSb40
         ITjA==
X-Gm-Message-State: APjAAAVGFfhkocp5X0Td2hSj+CIWGjniM5/GmDRt5jfsL/pO0R/WDQTj
        9UT5BvnCMHnmiuVYUT59blrlSH3vMLw=
X-Google-Smtp-Source: APXvYqyGwrwx9UimhQcaVkY91plBBeSj6QGmB3xoFdLBqmShltNYoD/THqgcEHQ4tOcwptByKBkbhdpCiH0=
X-Received: by 2002:ac8:541a:: with SMTP id b26mr4433733qtq.229.1565116839255;
 Tue, 06 Aug 2019 11:40:39 -0700 (PDT)
Date:   Tue,  6 Aug 2019 11:40:05 -0700
In-Reply-To: <20190806184007.60739-1-hridya@google.com>
Message-Id: <20190806184007.60739-2-hridya@google.com>
Mime-Version: 1.0
References: <20190806184007.60739-1-hridya@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v2 1/2] binder: Add default binder devices through binderfs
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

 drivers/android/binder.c          |  5 +++--
 drivers/android/binder_internal.h |  2 ++
 drivers/android/binderfs.c        | 25 ++++++++++++++++++++++---
 3 files changed, 27 insertions(+), 5 deletions(-)

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
index e773f45d19d9..886b4e0f482f 100644
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
@@ -521,7 +523,24 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
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
+
+	}
+
+	return 0;
+
 }
 
 static struct dentry *binderfs_mount(struct file_system_type *fs_type,
-- 
2.22.0.770.g0f2c4a37fd-goog

