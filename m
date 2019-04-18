Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3187EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D7121479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jas9PT7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbfDRQov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:44:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46475 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388388AbfDRQov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:44:51 -0400
Received: by mail-io1-f67.google.com with SMTP id p23so2382106iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mptKACXQhQgDUMyPlZCGnxz/gjpJxP41cGsb1cPqYVU=;
        b=Jas9PT7hRyxdXVOrAwhsvVbuZB04g9Z9xXlLTgglV+UCs12tYcgeTH6adJhAKAfCd2
         lVPvCz3e7j0DEzqo5dDdlq4TuCtgbEHTqPhAtH080DR/kc8OfXuLI8seB45BFcqUdbOy
         oqBG/Fl+fXDnjPvrMFrgDxoJbdlxlYWBx6Pls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mptKACXQhQgDUMyPlZCGnxz/gjpJxP41cGsb1cPqYVU=;
        b=D1gsFm8zaXLs62jo88kSf0akY48n8FhJQIEUJds6EyoUCfHmY7imMrU7R5kyiJM4Oz
         Wd3E5tbZ0bc9ywWH7Hjv7YfHVqKotNPv6jFDCU41T4+mJHQ5jOYfkvWurtZ2R9kHnv5M
         uLLE3SWtmKw19VHh3sqhRGZkbRPU/Ox8tF+epjwf/wklKQ9+S3OjANaJqPBp3flSlyk9
         Q8LNqPwuGNRiNtm03MKOjo++Hq4VXEys39ha8GRqMvQBnTHb5j608oDVHiFnnEKRedDk
         7SGfd3ma9I1qb2NNKlyjRWsZsSj70zLeNwqSo4J3s9JdklDCMS0elIbTydShzii6L/8F
         RYPw==
X-Gm-Message-State: APjAAAWAeMa3IEZHC+gPV4mqQRVpzXMGraLJw6UCnzQ+PULqfc0ws7HA
        Y7VM2eFGTORGF5FYuMYZqOqbsw==
X-Google-Smtp-Source: APXvYqyUx8YAWvoQTmsRRjnuReKrsKe/WE3JTCO052uWpp2AKqOqpyogSnE72AKdNgYbS9m7kA583A==
X-Received: by 2002:a5d:9cd5:: with SMTP id w21mr5012126iow.298.1555605889928;
        Thu, 18 Apr 2019 09:44:49 -0700 (PDT)
Received: from twawrzynczak.bld.corp.google.com ([2620:15c:183:200:3175:8c2d:44b6:cfea])
        by smtp.gmail.com with ESMTPSA id u26sm851675iob.78.2019.04.18.09.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Apr 2019 09:44:49 -0700 (PDT)
From:   Tim Wawrzynczak <twawrzynczak@chromium.org>
To:     Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     EnricBalletboiSerraenric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v4] platform/chrome: mfd/cros_ec_debugfs: Add debugfs entry to retrieve EC uptime.
Date:   Thu, 18 Apr 2019 10:44:44 -0600
Message-Id: <20190418164444.258107-1-twawrzynczak@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325170250.2547-1-twawrzynczak@chromium.org>
References: <20190325170250.2547-1-twawrzynczak@chromium.org>
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

