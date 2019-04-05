Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4BBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24BE21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lYsILg2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfDEP2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:28:39 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34953 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:28:39 -0400
Received: by mail-it1-f195.google.com with SMTP id w15so10180527itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tIZ3qm9pXjxuNhy1+AdW9XxEPkH8NHyKBuiIWXegYWw=;
        b=lYsILg2Rh1RCTpI1s5A4EqOD1CWy1qBNXu7bADpO5JAwwtMw1kwXjbVZgZap8M5wn9
         mVD//q0eBClSX7o2kYrIyefEe+PTjZclK2lgJHnS/ZEhWFIAbqWwz76gw3wKk8B4pSlH
         61Gi3kZsvfu+3HuhEN10GtoSJ6D5N0137cRUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tIZ3qm9pXjxuNhy1+AdW9XxEPkH8NHyKBuiIWXegYWw=;
        b=rbqsEIbKKMU60qUZd2OUwl0zpuj2j9VF6soQlupS/46YveNxu9zFYmDPk3M5rSvHDw
         asT/gbrBS1wYpLBfrOW3w98gzl7xGi0nSp2LtwXAfIkZm4v+Fneosbg5+a9qNg3As6kq
         T6BBHBvZmg6szzGWPpQMPBGphzdEKaR7vd+a79//GOf3se4nx8+TSXWOCZ8Y65UcQYNN
         P8kvjbgyP2guobhR+7NFOJVfSzvV0Pc6plaQMKts9Uc4t9VM2W5yn40+MfCcVg4e1Qlw
         XfnQq5L6EJtU30/CPmofq7xjbYcUCOIGJIWAESH1WgNQESRrKtiSZ6jfPReAYEYpZVM5
         SaoA==
X-Gm-Message-State: APjAAAW8aUKefcqKLgefon5a46m67oWIZ89AN++rMAZ4hUWFxwxpoUQp
        fLvtxF4+fYWp8s0U4GvB+PXHtA==
X-Google-Smtp-Source: APXvYqyEk+cLgS5S669v1x71FvVim5ngJZ5HmXOe6LnxJXXOGlBSPYJIHvL8ONxyTjnOy7AHpJMyPg==
X-Received: by 2002:a05:660c:202:: with SMTP id y2mr10682281itj.0.1554478118243;
        Fri, 05 Apr 2019 08:28:38 -0700 (PDT)
Received: from twawrzynczak.bld.corp.google.com ([2620:15c:183:200:3175:8c2d:44b6:cfea])
        by smtp.gmail.com with ESMTPSA id g1sm8493113ion.2.2019.04.05.08.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Apr 2019 08:28:37 -0700 (PDT)
From:   twawrzynczak@chromium.org
To:     Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] platform/chrome: mfd/cros_ec_debugfs: Add debugfs entry to retrieve EC uptime.
Date:   Fri,  5 Apr 2019 09:28:34 -0600
Message-Id: <20190405152834.7725-1-twawrzynczak@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325170250.2547-1-twawrzynczak@chromium.org>
References: <20190325170250.2547-1-twawrzynczak@chromium.org>
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
---
Changelist:
 - Moved uptime file from sysfs to debugfs (/sys/kernel/debug/cros_ec/uptime)
 - Fixed ordering of local variables in cros_ec_uptime_read.
Tested against ChromeOS kernel v4.14
---
 Documentation/ABI/testing/debugfs-cros-ec | 10 +++++
 drivers/platform/chrome/cros_ec_debugfs.c | 54 +++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-cros-ec

diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
new file mode 100644
index 000000000000..24b781c67a4c
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-cros-ec
@@ -0,0 +1,10 @@
+What:		/sys/kernel/debug/cros_ec/uptime
+Date:		March 2019
+KernelVersion:	5.1
+Description:
+		Read-only.
+		Reads the EC's current uptime information
+		(using EC_CMD_GET_UPTIME_INFO) and prints
+		time_since_ec_boot_ms into the file.
+		This is used for synchronizing AP host time
+		with the cros_ec log.
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 71308766e891..3ea42008a59e 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -201,6 +201,40 @@ static int cros_ec_console_log_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static ssize_t cros_ec_uptime_read(struct file *file,
+				   char __user *user_buf,
+				   size_t count,
+				   loff_t *ppos)
+{
+	struct cros_ec_debugfs *debug_info = file->private_data;
+	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
+	struct {
+		struct cros_ec_command msg;
+		struct ec_response_uptime_info resp;
+	} __packed ec_buf;
+	struct ec_response_uptime_info *resp;
+	struct cros_ec_command *msg;
+	char read_buf[32];
+	int ret;
+
+	msg = &ec_buf.msg;
+	resp = (struct ec_response_uptime_info *)msg->data;
+
+	msg->command = EC_CMD_GET_UPTIME_INFO;
+	msg->version = 0;
+	msg->insize = sizeof(*resp);
+	msg->outsize = 0;
+
+	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scnprintf(read_buf, sizeof(read_buf), "%u\n",
+			resp->time_since_ec_boot_ms);
+
+	return simple_read_from_buffer(user_buf, count, ppos, read_buf, ret);
+}
+
 static ssize_t cros_ec_pdinfo_read(struct file *file,
 				   char __user *user_buf,
 				   size_t count,
@@ -269,6 +303,13 @@ const struct file_operations cros_ec_pdinfo_fops = {
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
@@ -413,6 +454,15 @@ static int cros_ec_create_pdinfo(struct cros_ec_debugfs *debug_info)
 	return 0;
 }
 
+static int cros_ec_create_uptime(struct cros_ec_debugfs *debug_info)
+{
+	if (!debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
+				&cros_ec_uptime_fops))
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int cros_ec_debugfs_probe(struct platform_device *pd)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
@@ -442,6 +492,10 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 	if (ret)
 		goto remove_log;
 
+	ret = cros_ec_create_uptime(debug_info);
+	if (ret)
+		goto remove_log;
+
 	ec->debug_info = debug_info;
 
 	dev_set_drvdata(&pd->dev, ec);
-- 
2.20.1

