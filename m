Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDE7C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCC22133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfFNLQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:16:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60942 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfFNLQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:16:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 41F9C283E20
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: [PATCH 1/3] platform/chrome: cros_ec_debugfs: Add debugfs entry to retrieve EC uptime
Date:   Fri, 14 Jun 2019 13:15:49 +0200
Message-Id: <20190614111551.28686-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Wawrzynczak <twawrzynczak@chromium.org>

The new debugfs entry 'uptime' is being made available to userspace so that
a userspace daemon can synchronize EC logs with host time.

Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
[rework based on Tim's first approach]
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Hi Tim,

Sorry for beating around the bush a bit. I did a small rework of the
latest patch you sent and now is more close to the first versions you
sent. I was spinning around the idea if we should expose the attribute
when the command is supported or not and I ended with the conclusion,
however, I think makes sense for sysfs attributes, but I'd prefer
simplicity in the code for debugfs, at the end, if we try to read a file
for a non supported command we will get an error which is also useful
debug information.

Could you recheck that the patch still works and that I didn't break
anything, please?

Cheers,
~ Enric

 Documentation/ABI/testing/debugfs-cros-ec |  8 +++++
 drivers/platform/chrome/cros_ec_debugfs.c | 38 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-cros-ec

diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
new file mode 100644
index 000000000000..c91da2d374aa
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-cros-ec
@@ -0,0 +1,8 @@
+What:		/sys/kernel/debug/<cros-ec-device>/uptime
+Date:		June 2019
+KernelVersion:	5.3
+Description:
+		A u32 providing the time since EC booted in ms. This is
+		is used for synchronizing the AP host time with the EC
+		log. An error is returned if the command is not supported
+		by the EC or there is a communication problem.
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 4578eb3e0731..970ba13df9a1 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -241,6 +241,34 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
 				       read_buf, p - read_buf);
 }
 
+static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct cros_ec_debugfs *debug_info = file->private_data;
+	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
+	struct {
+		struct cros_ec_command cmd;
+		struct ec_response_uptime_info resp;
+	} __packed msg = {};
+	struct ec_response_uptime_info *resp;
+	char read_buf[32];
+	int ret;
+
+	resp = (struct ec_response_uptime_info *)&msg.resp;
+
+	msg.cmd.command = EC_CMD_GET_UPTIME_INFO;
+	msg.cmd.insize = sizeof(*resp);
+
+	ret = cros_ec_cmd_xfer_status(ec_dev, &msg.cmd);
+	if (ret < 0)
+		return ret;
+
+	ret = scnprintf(read_buf, sizeof(read_buf), "%u\n",
+			resp->time_since_ec_boot_ms);
+
+	return simple_read_from_buffer(user_buf, count, ppos, read_buf, ret);
+}
+
 static const struct file_operations cros_ec_console_log_fops = {
 	.owner = THIS_MODULE,
 	.open = cros_ec_console_log_open,
@@ -257,6 +285,13 @@ static const struct file_operations cros_ec_pdinfo_fops = {
 	.llseek = default_llseek,
 };
 
+const struct file_operations cros_ec_uptime_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = cros_ec_uptime_read,
+	.llseek = default_llseek,
+};
+
 static int ec_read_version_supported(struct cros_ec_dev *ec)
 {
 	struct ec_params_get_cmd_versions_v1 *params;
@@ -408,6 +443,9 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 	debugfs_create_file("pdinfo", 0444, debug_info->dir, debug_info,
 			    &cros_ec_pdinfo_fops);
 
+	debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
+			    &cros_ec_uptime_fops);
+
 	ec->debug_info = debug_info;
 
 	dev_set_drvdata(&pd->dev, ec);
-- 
2.20.1

