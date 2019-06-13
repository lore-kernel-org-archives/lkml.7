Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B78C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056FC20645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AqI8F2BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfFMR56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:57:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35655 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfFMR56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:57:58 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so18952072ioo.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+C5KnlUcg5YPzZfX26R37voPkYptIXnREwPhl8gT4c=;
        b=AqI8F2BBGVu1AQ1QdKMRqGCvQpB4/wiYaeyLAwgWmgVRrgplVxSsHhYOmgrTvl8VK0
         jgocQhcA+U0TrCIdBQapKE5yLVXWO57i7ONmO7p9CsS/3OUDpJyQ6J47nj1rEv/GerpP
         4h2xArBSYHO+qkiyjyhs19XMw55shFqfIvw60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+C5KnlUcg5YPzZfX26R37voPkYptIXnREwPhl8gT4c=;
        b=VDvs/+QYDQUSMG/OPuvFEFNyBstzZN8ctMu+Z/W/TXrTWaQ9MKpepYm4PrflI01OiS
         LxjB07q+tQriixFgfHGC/57006tGscmAl51EJ6bh/b/MViQfsxCxEeiHkg/1wzwkUCaG
         atsN6B1Y3yQ18VF1XgDHBX3UX16UZQnH7sTupvLQ3n9yCS4ShV7caEe+QM5fR8z4rpTX
         GvmviiiL4rGDROhkwo1dOQFrLaEEUJhNe7XYSfOdmS/Opcw3Lf93Fjqv3S6hFSl3ll/D
         WOcgR2scIy1zF10LFHWGuA8/A9zRzLOvuCQ1rhffdVetf3MMZXgH/MEtxeqeekDY3DIJ
         jPRA==
X-Gm-Message-State: APjAAAVNY2vZoe8yn8jIFOKwRJy2/iKf9ENB7O9aAF6RcDTuET3D14E+
        F2OthWRK23/VZCd/0bHdcCOyXEToWNxwOg==
X-Google-Smtp-Source: APXvYqzKkWi7k7+kBN7kjxQzWJCjBTHLx+VRcTgTIwS7rSUvJ+bZFVTvY5WZIaZ0EsMHlqSOHPYhmw==
X-Received: by 2002:a05:6638:5:: with SMTP id z5mr18806075jao.58.1560448677432;
        Thu, 13 Jun 2019 10:57:57 -0700 (PDT)
Received: from twawrzynczak.bld.corp.google.com ([2620:15c:183:200:b018:adbe:f5f7:d86b])
        by smtp.gmail.com with ESMTPSA id k8sm491091iob.78.2019.06.13.10.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 10:57:56 -0700 (PDT)
From:   twawrzynczak@chromium.org
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6] platform/chrome: mfd/cros_ec_debugfs: Add debugfs entry to retrieve EC uptime.
Date:   Thu, 13 Jun 2019 11:57:36 -0600
Message-Id: <20190613175736.260117-1-twawrzynczak@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <b4d1a261-fb0e-77ce-8fa3-48c71eb70dce@collabora.com>
References: <b4d1a261-fb0e-77ce-8fa3-48c71eb70dce@collabora.com>
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
Sorry about that Enric, I was confused that you meant Lee's tree.  Also I
got myself confused with all the patchsets :)

Changelist from v5:
 1) Rebase on lee's for-mfd-next
Changelist from v4:
 1) Add EC_CMD_GET_UPTIME_INFO
 2) Rebase on top of 5.3
 3) Get rid of cros_ec_create_uptime
Changelist from v3:
 1) Don't check return values of debugfs_* functions.
 2) Only expose 'uptime' file if EC supports it.
---
 Documentation/ABI/testing/debugfs-cros-ec | 10 ++++
 drivers/platform/chrome/cros_ec_debugfs.c | 56 +++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-cros-ec

diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
new file mode 100644
index 000000000000..ca6f4838ee0d
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-cros-ec
@@ -0,0 +1,10 @@
+What:		/sys/kernel/debug/<cros-ec-device>/uptime
+Date:		June 2019
+KernelVersion:	5.3
+Description:
+		Read-only.
+		Reads the EC's current uptime information
+		(using EC_CMD_GET_UPTIME_INFO) and prints
+		time_since_ec_boot_ms into the file.
+		This is used for synchronizing AP host time
+		with the cros_ec log.
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 4c2a27f6a6d0..dbba007c576d 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -241,6 +241,52 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
 				       read_buf, p - read_buf);
 }
 
+static int cros_ec_get_uptime(struct cros_ec_device *ec_dev, u32 *uptime)
+{
+	struct {
+		struct cros_ec_command msg;
+		struct ec_response_uptime_info resp;
+	} __packed ec_buf;
+	struct ec_response_uptime_info *resp;
+	struct cros_ec_command *msg;
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
+	u32 uptime;
+	int ret;
+
+	ret = cros_ec_get_uptime(ec_dev, &uptime);
+	if (ret < 0)
+		return ret;
+
+	ret = scnprintf(read_buf, sizeof(read_buf), "%u\n", uptime);
+
+	return simple_read_from_buffer(user_buf, count, ppos, read_buf, ret);
+}
+
 const struct file_operations cros_ec_console_log_fops = {
 	.owner = THIS_MODULE,
 	.open = cros_ec_console_log_open,
@@ -257,6 +303,13 @@ const struct file_operations cros_ec_pdinfo_fops = {
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
@@ -408,6 +461,9 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 	debugfs_create_file("pdinfo", 0444, debug_info->dir, debug_info,
 			    &cros_ec_pdinfo_fops);
 
+	debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
+			    &cros_ec_uptime_fops);
+
 	ec->debug_info = debug_info;
 
 	dev_set_drvdata(&pd->dev, ec);
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

