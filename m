Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D879BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F1621479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lcs3eiyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389689AbfDRQpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:45:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39450 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388299AbfDRQpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:45:39 -0400
Received: by mail-io1-f68.google.com with SMTP id e13so2417722ioq.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mptKACXQhQgDUMyPlZCGnxz/gjpJxP41cGsb1cPqYVU=;
        b=Lcs3eiyyFcEA+V7To6sBQ/lWb9+JMWUzg+x2FuCrrKcXLqDRDZ4SCbwoo0jCNJUxcy
         r/muKC+QFHFa9DxsOpWq3Vptal9b+dsyg1dZQLHdAlomBlGfZUty3pGmWv3eBuSpi3HP
         wbhNXyM3LuuvjCsN4XPG3bhF6awdSl+cn5sRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mptKACXQhQgDUMyPlZCGnxz/gjpJxP41cGsb1cPqYVU=;
        b=NMznEUvKcS1z05krVlATaf8GwBRVH13RRt+rnrZ8XV83muIwyy99ZYN8iwiIR0j8VV
         VFXKjjyhjRJZDomsQjnfBAAO2SkwSaci/2c8wq9gM1rQUfjPyKJregWT101g6p1n2jUy
         AcKUzzV33fy5X0NL2YN2PGLqbw/3EuLLJTuCpd4v+W4IZqjhJB0pm6otVKtyvaXOiO4A
         eu8HLb/kwh7hx0iDlIaw0KtXwz97YjdAND4ud/BJgjm0rTXJM9UPSBxGpDiDHQzZEnR7
         nIjgcg10PySwuhO40XaldszpEyq0KR83g+uLtd4yalAgusYKVXH+Huv0W0cTc1u8qgYQ
         HMNg==
X-Gm-Message-State: APjAAAUp+f9BgFQgrlShXbF8a42lSN5XP0r0BPToLYiyqa96jmwzGEkj
        WtU9Id5cWpeVyf8XaeORay115w==
X-Google-Smtp-Source: APXvYqwCtLeMVtDKFDBrnlxw1rWMgT85G7R0ICO3Vh5OkBfwELpGrTz30+KU2WcJzeOzKqERsYEQfg==
X-Received: by 2002:a6b:4910:: with SMTP id u16mr30438463iob.150.1555605937967;
        Thu, 18 Apr 2019 09:45:37 -0700 (PDT)
Received: from twawrzynczak.bld.corp.google.com ([2620:15c:183:200:3175:8c2d:44b6:cfea])
        by smtp.gmail.com with ESMTPSA id c92sm1149186itd.26.2019.04.18.09.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Apr 2019 09:45:37 -0700 (PDT)
From:   Tim Wawrzynczak <twawrzynczak@chromium.org>
To:     Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v4] platform/chrome: mfd/cros_ec_debugfs: Add debugfs entry to retrieve EC uptime.
Date:   Thu, 18 Apr 2019 10:45:35 -0600
Message-Id: <20190418164535.258319-1-twawrzynczak@chromium.org>
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

