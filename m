Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD012C41514
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901BC22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfIDLHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:07:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50931 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfIDLHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:07:17 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i5T85-0004L3-6b; Wed, 04 Sep 2019 11:07:13 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     hridya@google.com
Cc:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        maco@android.com, tkjos@android.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [RESEND PATCH v3 2/2] binder: Validate the default binderfs device names.
Date:   Wed,  4 Sep 2019 13:07:04 +0200
Message-Id: <20190904110704.8606-3-christian.brauner@ubuntu.com>
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

Length of a binderfs device name cannot exceed BINDERFS_MAX_NAME.
This patch adds a check in binderfs_init() to ensure the same
for the default binder devices that will be created in every
binderfs instance.

Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Hridya Valsaraju <hridya@google.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/20190808222727.132744-3-hridya@google.com
---
 drivers/android/binderfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index aee46dd1be91..55c5adb87585 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -570,6 +570,18 @@ static struct file_system_type binder_fs_type = {
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
2.23.0

