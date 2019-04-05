Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7409C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C43D206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JFRy2dUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDEUIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:08:02 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52838 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfDEUH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:07:59 -0400
Received: by mail-it1-f194.google.com with SMTP id x132so1168913itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 13:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmfWyBHBhDJrX6AHyHkQb5t6n1xq5JgoPcjZg1jLsGk=;
        b=JFRy2dUZXjM96CKGrCWAE9zPzmWn3JKhFDWCJOg9QcDTV39dtNoYyUVGg9MyoYhwUA
         UTuZy5R1BueouICIR/Q363eRj04LbmTLQ9mTJr14bt34quNPXRGziV7oj7Vgs6Ua2M9z
         cTSN5oSNQ4275OBUBsgcyiunfbAgrCw2067cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmfWyBHBhDJrX6AHyHkQb5t6n1xq5JgoPcjZg1jLsGk=;
        b=b9R2bkEpeQ3OzZLJCZd7ZyRwoRmJSiBhkcxcBCQ+2D0Qjg+eptqC7VMypfcB91qJtI
         Ruki2Id7GHbTXfoA9NlFUa0wr7uEyDLWA/KzJCqBymR/c0nhMpGrPro4uTZp+TnYWjxz
         lEP6junvdPTLHPgNpB4ux2mQhNp45Irds2S2n+QU7LStWdycYCY4k2HHaobO6SAKqW/n
         fqifKWjnvA3aytxK8d7yfJrUCfeeCd4Y4maBPYIZKC2mqOqUXdPo2ZKegxp6K/kMhU04
         7GG4heWRUTTVpP0qaffjIYLJkXb68hNCXLBqw1FQxbpgaHJ67YOXCHp60DTwqudAXBEX
         lM4w==
X-Gm-Message-State: APjAAAWVm0bEbXZNTSvztu/ndw9RYsQ7QLiYtFVaX6AkmW4YfE7Jw6Y1
        b0euT+8j+6QUMtDNf12KcjtMxQ==
X-Google-Smtp-Source: APXvYqxJpbZtjWSv5AaYMexsyXFsJYFf6Xp0D2ZgjYGCXccgPeE1XGV6SBLFhzk23uD5o6FJXiuLJQ==
X-Received: by 2002:a24:52c5:: with SMTP id d188mr9209672itb.130.1554494878367;
        Fri, 05 Apr 2019 13:07:58 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id v134sm1492748ita.16.2019.04.05.13.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Apr 2019 13:07:57 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, groeck@google.com, dtor@google.com,
        lamzin@google.com, sjg@gchromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH 2/3] platform/chrome: wilco_ec: Add USB PowerShare Policy control
Date:   Fri,  5 Apr 2019 14:07:41 -0600
Message-Id: <20190405200742.107973-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405200742.107973-1-ncrews@chromium.org>
References: <20190405200742.107973-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB PowerShare is a policy which affects charging via the special
USB PowerShare port (marked with a small lightning bolt or battery icon)
when in low power states:
- In S0, the port will always provide power.
- In S0ix, if power_share is enabled, then power will be supplied to
  the port when on AC or if battery is > 50%. Else no power is supplied.
- In S5, if power_share is enabled, then power will be supplied to
  the port when on AC. Else no power is supplied.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/wilco_ec/Makefile |   2 +-
 drivers/platform/chrome/wilco_ec/core.c   |   9 ++
 drivers/platform/chrome/wilco_ec/sysfs.c  | 129 ++++++++++++++++++++++
 include/linux/platform_data/wilco-ec.h    |   3 +
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/chrome/wilco_ec/sysfs.c

diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 063e7fb4ea17..1281dd7737c4 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-wilco_ec-objs				:= core.o mailbox.o
+wilco_ec-objs				:= core.o mailbox.o sysfs.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
 wilco_ec_debugfs-objs			:= debugfs.o
 obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 05e1e2be1c91..abd15d04e57b 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -89,8 +89,16 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		goto unregister_debugfs;
 	}
 
+	ret = wilco_ec_add_sysfs(ec);
+	if (ret < 0) {
+		dev_err(dev, "Failed to create sysfs entries: %d", ret);
+		goto unregister_rtc;
+	}
+
 	return 0;
 
+unregister_rtc:
+	platform_device_unregister(ec->rtc_pdev);
 unregister_debugfs:
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
@@ -102,6 +110,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
 
+	wilco_ec_remove_sysfs(ec);
 	platform_device_unregister(ec->rtc_pdev);
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
new file mode 100644
index 000000000000..ec5211257a58
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ *
+ * Sysfs properties used to modify EC-controlled features on Wilco devices.
+ * The entries will appear under /sys/bus/platform/devices/GOOG000C:00/
+ *
+ * USB PowerShare is a policy which affects charging via the special
+ * USB PowerShare port (marked with a small lightning bolt or battery icon)
+ * when in low power states:
+ * - In S0, the port will always provide power.
+ * - In S0ix, if power_share is enabled, then power will be supplied to
+ *   the port when on AC or if battery is > 50%. Else no power is supplied.
+ * - In S5, if power_share is enabled, then power will be supplied to
+ *   the port when on AC. Else no power is supplied.
+ */
+
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/sysfs.h>
+
+#define CMD_USB_POWER_SHARE 0x39
+
+enum usb_power_share_op {
+	POWER_SHARE_GET = 0,
+	POWER_SHARE_SET = 1,
+};
+
+struct usb_power_share_request {
+	u8 cmd;		/* Always CMD_USB_POWER_SHARE */
+	u8 reserved;
+	u8 op;		/* One of enum usb_power_share_op */
+	u8 val;		/* When setting, either 0 or 1 */
+} __packed;
+
+struct usb_power_share_response {
+	u8 reserved;
+	u8 status;	/* Set by EC to 0 on success, other value on failure */
+	u8 val;		/* When getting, set by EC to either 0 or 1 */
+} __packed;
+
+static int send_usb_power_share(struct wilco_ec_device *ec,
+				struct usb_power_share_request *rq,
+				struct usb_power_share_response *rs)
+{
+	struct wilco_ec_message msg;
+	int ret;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.type = WILCO_EC_MSG_LEGACY;
+	msg.request_data = rq;
+	msg.request_size = sizeof(*rq);
+	msg.response_data = rs;
+	msg.response_size = sizeof(*rs);
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+
+	if (rs->status)
+		return -EIO;
+
+	return 0;
+}
+
+static ssize_t usb_power_share_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	struct usb_power_share_request rq;
+	struct usb_power_share_response rs;
+	int ret;
+
+	rq.cmd = CMD_USB_POWER_SHARE;
+	rq.op = POWER_SHARE_GET;
+
+	ret = send_usb_power_share(ec, &rq, &rs);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", rs.val);
+}
+
+static ssize_t usb_power_share_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	struct usb_power_share_request rq;
+	struct usb_power_share_response rs;
+	int ret;
+	u8 val;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	rq.cmd = CMD_USB_POWER_SHARE;
+	rq.op = POWER_SHARE_SET;
+	rq.val = val;
+
+	ret = send_usb_power_share(ec, &rq, &rs);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(usb_power_share);
+
+static struct attribute *wilco_dev_attrs[] = {
+	&dev_attr_usb_power_share.attr,
+	NULL,
+};
+
+static struct attribute_group wilco_dev_attr_group = {
+	.attrs = wilco_dev_attrs,
+};
+
+int wilco_ec_add_sysfs(struct wilco_ec_device *ec)
+{
+	return sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
+}
+
+void wilco_ec_remove_sysfs(struct wilco_ec_device *ec)
+{
+	sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
+}
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 1ff224793c99..05d011605b85 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -123,4 +123,7 @@ struct wilco_ec_message {
  */
 int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg);
 
+int wilco_ec_add_sysfs(struct wilco_ec_device *ec);
+void wilco_ec_remove_sysfs(struct wilco_ec_device *ec);
+
 #endif /* WILCO_EC_H */
-- 
2.20.1

