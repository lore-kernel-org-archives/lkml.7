Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC1AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743A720879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XMwu/OM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDHVJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:09:53 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36730 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfDHVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:09:52 -0400
Received: by mail-it1-f196.google.com with SMTP id y10so1536228itc.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mptKACXQhQgDUMyPlZCGnxz/gjpJxP41cGsb1cPqYVU=;
        b=XMwu/OM3C30WusJ5IRy0a755wR5/hGFHKy+PE1wc+s8sN7UBIBHHwNQffv/DsuqUDh
         gWVLhyCeqFQMMTcvJQipnqLEhmGLuujc4fWgfQZSOBYqoKAAmwMdHqTGf4nzayA8Gebt
         D3UT5auR8UoaTHPmfRftp7sXiC41DoJUWuoHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mptKACXQhQgDUMyPlZCGnxz/gjpJxP41cGsb1cPqYVU=;
        b=NtAlzd287ya/pTLnr8m68BbfnAtLyVaXE0PQP2TJmnwXuRIiYT8m9V8rxhCj98N529
         GyJ8WbFALAT3/2NL7rnYTHztcncJbjKnGxaWivJaQ4Q2jg/ut/0z9OshxW0KnGSM+6Sh
         h/2VjBkEQ2HfBnpqWwAo5GjPtO7NBHnCluRQxoi7VPqVNE+iwokHPHUZDqjHtu1xez6+
         ENwS+IwH0eEw8VSX47lGTZtmtwYOSDPCP1XuJeWfAVmDxtd/ZEAEQ+wLMNwnC73B3Sf5
         IcRR4Q//LJ8mDxulZJm/FPg76f6oKpDwXUJD6/yhSVrrVHa6Yxl+dHpenilD8Gwsh1NX
         Cnvg==
X-Gm-Message-State: APjAAAUUQOeKxG1ssPiq3+XZPoI3241QOVzfnki2UDWOEYQhd1WrbuD7
        /ApT9uOFI3AZcAdEgcE0mHo+m87FSn5TFQ==
X-Google-Smtp-Source: APXvYqyjQd2bHKrXkGFwW5NyekIFO41yE1xnVCvh3pa7GXrAlJCXt96QQmsCBUWrkmHYNMbW/XV1DQ==
X-Received: by 2002:a02:6553:: with SMTP id u80mr22998491jab.51.1554757791468;
        Mon, 08 Apr 2019 14:09:51 -0700 (PDT)
Received: from twawrzynczak.bld.corp.google.com ([2620:15c:183:200:3175:8c2d:44b6:cfea])
        by smtp.gmail.com with ESMTPSA id e27sm13339122ioc.14.2019.04.08.14.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 14:09:50 -0700 (PDT)
From:   Tim Wawrzynczak <twawrzynczak@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: [PATCH v4] platform/chrome: mfd/cros_ec_debugfs: Add debugfs entry to retrieve EC uptime.
Date:   Mon,  8 Apr 2019 15:09:47 -0600
Message-Id: <20190408210947.150095-1-twawrzynczak@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327182040.112651-1-twawrzynczak@chromium.org>
References: <20190327182040.112651-1-twawrzynczak@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new debugfs entry 'uptime' is being made available to userspace so that
a userspace daemon can synchronize EC logs with host time.

Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
---
Enric, AFAIK only the cros_ec supports the 'uptime' command for now.
And yes, the file does need to be seekable; the userspace daemon that
consumes the file keeps the file open and seeks back to the beginning
to get the latest uptime value.
Based on your second response to v3, I kept the separate 'create_uptime'
function b/c of the logic for checking support for the uptime command.
Let me know if you'd like me to move all of that logic into _probe.

Changelist from v3:
 1) Don't check return values of debugfs_* functions.
 2) Only expose 'uptime' file if EC supports it.
---
 Documentation/ABI/testing/debugfs-cros-ec | 10 +++
 drivers/platform/chrome/cros_ec_debugfs.c | 78 +++++++++++++++++++++++
 2 files changed, 88 insertions(+)
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
index 71308766e891..226545a2150b 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -201,6 +201,50 @@ static int cros_ec_console_log_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int cros_ec_get_uptime(struct cros_ec_device *ec_dev, u32 *uptime)
+{
+	struct {
+		struct cros_ec_command msg;
+		struct ec_response_uptime_info resp;
+	} __packed ec_buf;
+	struct ec_response_uptime_info *resp;
+	struct cros_ec_command *msg;
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
+	*uptime = resp->time_since_ec_boot_ms;
+	return 0;
+}
+
+static ssize_t cros_ec_uptime_read(struct file *file,
+				   char __user *user_buf,
+				   size_t count,
+				   loff_t *ppos)
+{
+	struct cros_ec_debugfs *debug_info = file->private_data;
+	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
+	char read_buf[32];
+	int ret;
+	u32 uptime;
+
+	ret = cros_ec_get_uptime(ec_dev, &uptime);
+	if (ret < 0)
+		return ret;
+
+	ret = scnprintf(read_buf, sizeof(read_buf), "%u\n", uptime);
+	return simple_read_from_buffer(user_buf, count, ppos, read_buf, ret);
+}
+
 static ssize_t cros_ec_pdinfo_read(struct file *file,
 				   char __user *user_buf,
 				   size_t count,
@@ -269,6 +313,13 @@ const struct file_operations cros_ec_pdinfo_fops = {
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
@@ -413,6 +464,29 @@ static int cros_ec_create_pdinfo(struct cros_ec_debugfs *debug_info)
 	return 0;
 }
 
+static int cros_ec_create_uptime(struct cros_ec_debugfs *debug_info)
+{
+	struct cros_ec_debugfs *debug_info = file->private_data;
+	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
+	u32 uptime;
+	int ret;
+
+	/*
+	 * If the EC does not support the uptime command, which is
+	 * indicated by xfer_status() returning -EINVAL, then no
+	 * debugfs entry will be created.
+	 */
+	ret = cros_ec_get_uptime(ec_dev, &uptime);
+
+	if (ret == -EINVAL)
+		return supported;
+
+	debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
+			&cros_ec_uptime_fops);
+
+	return 0;
+}
+
 static int cros_ec_debugfs_probe(struct platform_device *pd)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
@@ -442,6 +516,10 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
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

