Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E7C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14D12070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfDOVfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:35:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46972 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDOVfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:35:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2F669263BB8
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, twawrzynczak@chromium.org,
        bleung@chromium.org, groeck@chromium.org, kernel@collabora.com,
        dtor@chromium.org
Subject: [PATCH] platform/chrome: cros_ec_debugfs: Use cros_ec_cmd_xfer_status helper
Date:   Mon, 15 Apr 2019 23:35:06 +0200
Message-Id: <20190415213506.27472-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes use of cros_ec_cmd_xfer_status() instead of
cros_ec_cmd_xfer() so we can remove some redundant code.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_debugfs.c | 30 ++++++-----------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index a712508e4646..0bd163723548 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -72,15 +72,9 @@ static void cros_ec_console_log_work(struct work_struct *__work)
 	int buf_space;
 	int ret;
 
-	ret = cros_ec_cmd_xfer(ec->ec_dev, &snapshot_msg);
-	if (ret < 0) {
-		dev_err(ec->dev, "EC communication failed\n");
-		goto resched;
-	}
-	if (snapshot_msg.result != EC_RES_SUCCESS) {
-		dev_err(ec->dev, "EC failed to snapshot the console log\n");
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, &snapshot_msg);
+	if (ret < 0)
 		goto resched;
-	}
 
 	/* Loop until we have read everything, or there's an error. */
 	mutex_lock(&debug_info->log_mutex);
@@ -95,16 +89,10 @@ static void cros_ec_console_log_work(struct work_struct *__work)
 
 		memset(read_params, '\0', sizeof(*read_params));
 		read_params->subcmd = CONSOLE_READ_RECENT;
-		ret = cros_ec_cmd_xfer(ec->ec_dev, debug_info->read_msg);
-		if (ret < 0) {
-			dev_err(ec->dev, "EC communication failed\n");
-			break;
-		}
-		if (debug_info->read_msg->result != EC_RES_SUCCESS) {
-			dev_err(ec->dev,
-				"EC failed to read the console log\n");
+		ret = cros_ec_cmd_xfer_status(ec->ec_dev,
+					      debug_info->read_msg);
+		if (ret < 0)
 			break;
-		}
 
 		/* If the buffer is empty, we're done here. */
 		if (ret == 0 || ec_buffer[0] == '\0')
@@ -290,9 +278,8 @@ static int ec_read_version_supported(struct cros_ec_dev *ec)
 	params->cmd = EC_CMD_CONSOLE_READ;
 	response = (struct ec_response_get_cmd_versions *)msg->data;
 
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg) >= 0 &&
-		msg->result == EC_RES_SUCCESS &&
-		(response->version_mask & EC_VER_MASK(1));
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg) >= 0 &&
+	      response->version_mask & EC_VER_MASK(1);
 
 	kfree(msg);
 
@@ -372,9 +359,8 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 	msg->command = EC_CMD_GET_PANIC_INFO;
 	msg->insize = insize;
 
-	ret = cros_ec_cmd_xfer(ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
 	if (ret < 0) {
-		dev_warn(debug_info->ec->dev, "Cannot read panicinfo.\n");
 		ret = 0;
 		goto free;
 	}
-- 
2.20.1

