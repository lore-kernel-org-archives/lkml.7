Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA33CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3893217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDHPFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:05:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45962 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfDHPFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:05:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AB3BF282078
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, twawrzynczak@chromium.org,
        bleung@chromium.org, groeck@chromium.org, kernel@collabora.com,
        dtor@chromium.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] platform/chrome: cros_ec_debugfs: no need to check return value of debugfs_create functions
Date:   Mon,  8 Apr 2019 17:05:38 +0200
Message-Id: <20190408150538.8115-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_debugfs.c | 35 ++++-------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index f0de1991b688..a712508e4646 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -337,12 +337,8 @@ static int cros_ec_create_console_log(struct cros_ec_debugfs *debug_info)
 	mutex_init(&debug_info->log_mutex);
 	init_waitqueue_head(&debug_info->log_wq);
 
-	if (!debugfs_create_file("console_log",
-				 S_IFREG | 0444,
-				 debug_info->dir,
-				 debug_info,
-				 &cros_ec_console_log_fops))
-		return -ENOMEM;
+	debugfs_create_file("console_log", S_IFREG | 0444, debug_info->dir,
+			    debug_info, &cros_ec_console_log_fops);
 
 	INIT_DELAYED_WORK(&debug_info->log_poll_work,
 			  cros_ec_console_log_work);
@@ -390,13 +386,8 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 	debug_info->panicinfo_blob.data = msg->data;
 	debug_info->panicinfo_blob.size = ret;
 
-	if (!debugfs_create_blob("panicinfo",
-				 S_IFREG | 0444,
-				 debug_info->dir,
-				 &debug_info->panicinfo_blob)) {
-		ret = -ENOMEM;
-		goto free;
-	}
+	debugfs_create_blob("panicinfo", S_IFREG | 0444, debug_info->dir,
+			    &debug_info->panicinfo_blob);
 
 	return 0;
 
@@ -405,15 +396,6 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 	return ret;
 }
 
-static int cros_ec_create_pdinfo(struct cros_ec_debugfs *debug_info)
-{
-	if (!debugfs_create_file("pdinfo", 0444, debug_info->dir, debug_info,
-				 &cros_ec_pdinfo_fops))
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int cros_ec_debugfs_probe(struct platform_device *pd)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
@@ -428,8 +410,6 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 
 	debug_info->ec = ec;
 	debug_info->dir = debugfs_create_dir(name, NULL);
-	if (!debug_info->dir)
-		return -ENOMEM;
 
 	ret = cros_ec_create_panicinfo(debug_info);
 	if (ret)
@@ -439,9 +419,8 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 	if (ret)
 		goto remove_debugfs;
 
-	ret = cros_ec_create_pdinfo(debug_info);
-	if (ret)
-		goto remove_log;
+	debugfs_create_file("pdinfo", 0444, debug_info->dir, debug_info,
+			    &cros_ec_pdinfo_fops);
 
 	ec->debug_info = debug_info;
 
@@ -449,8 +428,6 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 
 	return 0;
 
-remove_log:
-	cros_ec_cleanup_console_log(debug_info);
 remove_debugfs:
 	debugfs_remove_recursive(debug_info->dir);
 	return ret;
-- 
2.20.1

