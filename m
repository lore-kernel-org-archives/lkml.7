Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A44C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBF820830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h4zzeMZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfCDAyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:54:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33275 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfCDAyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:54:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so1716575pfd.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 16:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLPQ4soph4vxPlH+wbj1lca5XYhfxI+OtP5XJZcYUfc=;
        b=h4zzeMZJ5t3OL7t9OsPIjJe29QHtx1xPUJBKoeKSDSCplvLUzgt5ycvJzN4k1vQkei
         c1pZpNLsSIb8LjkN30PQQeQe3CbvQLscstMcQZgb0bdLvA1yMrIBU46rr/fFIjQhpjI6
         lindm/Lw+L4RxoFqJHv03uFWCzBor6tBU7Jzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLPQ4soph4vxPlH+wbj1lca5XYhfxI+OtP5XJZcYUfc=;
        b=Q+SLaefCy/FXPqHxWJNVRoMGMSS0HtIuFwFQPzGii/VJCSxLDVG+gT1kCuZlv6lbRp
         YCybQjmcM0IT91ted0lGPa2aB+eDXod9bIlvKLih8/bM7ZnG0DxtG2jn5QMZ7LlQoFuQ
         KIef9pDbx5knoqbf1wqA8E3jIDW/LxK1W66x2Cye+b2O3G/MwQYQ/iA7tMOC9t/PbIVg
         KH88X5tu2YNhdbeX9d/ww67icblnWIXOCpkV0WHZhAS+cDqb3hO7M5VluwH36SDkQ45W
         /YMK7uffuUeo5qg8l8EXfEs+lNZh4GA6c/+bZAjzNNKOs91+aDjkYECnNhoqKiRoGcpd
         1NBQ==
X-Gm-Message-State: APjAAAXQ8ElwQDwoUwM2YM+dXiTKJrMoKDSP6rvxSQafD9QeGWvbc5J9
        GFEaXw4g4TiZoNtFTNAdSLrxgxLoCJw=
X-Google-Smtp-Source: AHgI3IaHAHjYkBVEYrC7Gn0JfEhk1qTw/X1biSPQGEXJaIM49RxaNs/gYQe3fgQqW4wbV0c9ylODzw==
X-Received: by 2002:a62:3990:: with SMTP id u16mr17437485pfj.80.1551660862833;
        Sun, 03 Mar 2019 16:54:22 -0800 (PST)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id k10sm7412446pgp.91.2019.03.03.16.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Mar 2019 16:54:22 -0800 (PST)
From:   RaviChandra Sadineni <ravisadineni@chromium.org>
To:     ravisadineni@chromium.org
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, tbroch@google.com, dnojiri@google.com
Subject: [PATCH V2] cros_ec: Expose sysfile to force battery cut-off on shutdown.
Date:   Sun,  3 Mar 2019 16:54:14 -0800
Message-Id: <20190304005414.218310-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CABXOdTdXcCeqkqcH69dG62mLmurbDOcrhhVGm6BgnBzR-1KETg@mail.gmail.com>
References: <CABXOdTdXcCeqkqcH69dG62mLmurbDOcrhhVGm6BgnBzR-1KETg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On chromebooks, power_manager daemon normally shutsdown(S5) the device
when the battery charge falls below 4% threshold. Chromeos EC then
normally spends an hour in S5 before hibernating. If the battery charge
falls below critical threshold in the mean time, EC does a battery cutoff
instead of hibernating. On some chromebooks, S5 is optimal enough
resulting in EC hibernating without battery cut-off. This results in
battery deep-discharging. This is a bad user experience as battery
has to trickle charge before booting when the A.C is plugged in the next
time.

This patch exposes a sysfs file for an userland daemon to suggest EC if it
has to do a battery cut-off instead of hibernating when the system enters
S5 next time.

Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
---
V2: Use kstrtobool() instead of kstrtou8() and add documentation.

 .../ABI/testing/sysfs-class-chromeos          |  8 ++++
 drivers/platform/chrome/cros_ec_sysfs.c       | 37 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos

diff --git a/Documentation/ABI/testing/sysfs-class-chromeos b/Documentation/ABI/testing/sysfs-class-chromeos
new file mode 100644
index 000000000000..44d3cee6e7ae
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-chromeos
@@ -0,0 +1,8 @@
+What:           /sys/class/chromeos/cros_ec/cutoff_at_shutdown
+Date:           February 2019
+Contact:        Ravi Chandra Sadineni <ravisadineni@chromium.org>
+Description:
+                On writing '[Yy1]' to cutoff_at_shutdown property,
+                kernel sends a host command to EC requesting battery
+                cutoff on next shutdown. If AC is plugged in before
+                next shutdown, EC resets this flag.
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f34a50121064..f5168ce8bfc7 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -322,14 +322,51 @@ static ssize_t kb_wake_angle_store(struct device *dev,
 	return count;
 }
 
+/* Battery cut-off control */
+static ssize_t cutoff_at_shutdown_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct ec_params_battery_cutoff *param;
+	struct cros_ec_command *msg;
+	int ret;
+	struct cros_ec_dev *ec = container_of(
+			dev, struct cros_ec_dev, class_dev);
+	bool cutoff_battery;
+
+	if (kstrtobool(buf, &cutoff_battery))
+		return -EINVAL;
+
+	if (!cutoff_battery)
+		return count;
+
+	msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	param = (struct ec_params_battery_cutoff *)msg->data;
+	msg->command = EC_CMD_BATTERY_CUT_OFF + ec->cmd_offset;
+	msg->version = 1;
+	param->flags = EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN;
+	msg->outsize = sizeof(*param);
+	msg->insize = 0;
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	kfree(msg);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
 /* Module initialization */
 
 static DEVICE_ATTR_RW(reboot);
 static DEVICE_ATTR_RO(version);
 static DEVICE_ATTR_RO(flashinfo);
 static DEVICE_ATTR_RW(kb_wake_angle);
+static DEVICE_ATTR_WO(cutoff_at_shutdown);
 
 static struct attribute *__ec_attrs[] = {
+	&dev_attr_cutoff_battery_at_shutdown.attr,
 	&dev_attr_kb_wake_angle.attr,
 	&dev_attr_reboot.attr,
 	&dev_attr_version.attr,
-- 
2.20.1

