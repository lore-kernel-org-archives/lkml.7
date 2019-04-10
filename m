Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AA7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B52120830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fL7HVB0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDJWw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:52:26 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53156 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDJWwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:52:25 -0400
Received: by mail-it1-f194.google.com with SMTP id x132so6410576itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kSjvsz7rcNJvakr5Appy2GAx7PQBiF7p07INXI3ou9w=;
        b=fL7HVB0DY4mbxwJYwVkhIMWg2p3usPmVKcieL9uXstJpM3wnTotLAEbzKh5FHML7wo
         tNpM1Wg5H/3+QIiL40gDWeNzDMRSdWODNWoCrUL1Kmhmo2TDnsDRjPuWSVFY4Wm/iiqa
         OJfZWEerE8cuNhniBpaHOVwiFzdObccqbkEs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kSjvsz7rcNJvakr5Appy2GAx7PQBiF7p07INXI3ou9w=;
        b=F7EfeSYDKODnlZYEkXDoKnzqNUixEp/Eey7X2YROETwZvn/sapl7aBXfovcTwSnZNI
         HbldJ5IwMTw/HZg7RVQS3ujgJONBzL0RkgjKuhZALN9JlMjqxqQVJL2KPqtVhHQTCYpu
         ZkAVAb/S3Uq2drYY4+4AoOCUwAZFVbjK7Tf8yAYCR2kJTGNPpGxeVOXxXEuPO+tR3Ss1
         Y9dCDfYi0nmxdvGoqNkAYJiudEXvAK4w+cV475Ehajv7n7rKduSsE9HM0HFdATUJJTZc
         7+efJwBK80x6tuekWG8HHf9/ZGXD4/cLJPgrdKilUy6sRrb7baj5ecQAUJj5WtFK93Dp
         AiEw==
X-Gm-Message-State: APjAAAWhdHBzXGbmVILYnvK9RbqoQSlghA3aVtK8N9awVxiVUHdGQKAl
        b5Yhdps1dgcn59QrnycrguyGyg==
X-Google-Smtp-Source: APXvYqzij0mALHSjffewdE32SVi8bgOUkF1jsofBXwYKiU137td81l81Oqj7+DNg++yMU0L7nOExDQ==
X-Received: by 2002:a24:684b:: with SMTP id v72mr5570407itb.101.1554936744380;
        Wed, 10 Apr 2019 15:52:24 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id f126sm1594873ita.31.2019.04.10.15.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 15:52:23 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, groeck@google.com, dtor@google.com,
        sjg@chromium.org, bartfab@chromium.org, lamzin@google.com,
        jchwong@google.com, Nick Crews <ncrews@chromium.org>
Subject: [PATCH v2 1/2] platform/chrome: wilco_ec: Add Boot on AC support
Date:   Wed, 10 Apr 2019 16:52:10 -0600
Message-Id: <20190410225211.125025-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boot on AC is a policy which makes the device boot from S5 when AC
power is connected. This is useful for users who want to run their
device headless or with a dock.

v2 changes:
- Move documentation to Documentation/ABI/testing/sysfs-platform-wilco-ec

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 .../ABI/testing/sysfs-platform-wilco-ec       | 11 +++
 drivers/platform/chrome/wilco_ec/Makefile     |  2 +-
 drivers/platform/chrome/wilco_ec/core.c       |  9 +++
 drivers/platform/chrome/wilco_ec/sysfs.c      | 77 +++++++++++++++++++
 include/linux/platform_data/wilco-ec.h        |  3 +
 5 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-wilco-ec
 create mode 100644 drivers/platform/chrome/wilco_ec/sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Documentation/ABI/testing/sysfs-platform-wilco-ec
new file mode 100644
index 000000000000..e074c203cd32
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
@@ -0,0 +1,11 @@
+What:		/sys/bus/platform/devices/GOOG000C\:00/boot_on_ac
+Date:		April 2019
+KernelVersion:	5.2
+Description:
+		Boot on AC is a policy which makes the device boot from S5
+		when AC power is connected. This is useful for users who
+		want to run their device headless or with a dock.
+
+		Input should be parseable by kstrtou8() to 0 or 1.
+		Output will be either "0\n" or "1\n".
+
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
index 000000000000..d1dbd4d2e6db
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ *
+ * Sysfs properties to view and modify EC-controlled features on Wilco devices.
+ * The entries will appear under /sys/bus/platform/devices/GOOG000C:00/
+ *
+ * See Documentation/ABI/testing/sysfs-platform-wilco-ec for more information.
+ */
+
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/sysfs.h>
+
+#define CMD_KB_CMOS			0x7C
+#define SUB_CMD_KB_CMOS_AUTO_ON		0x03
+
+struct boot_on_ac_request {
+	u8 cmd;			/* Always CMD_KB_CMOS */
+	u8 reserved1;
+	u8 sub_cmd;		/* Always SUB_CMD_KB_CMOS_AUTO_ON */
+	u8 reserved3to5[3];
+	u8 val;			/* Either 0 or 1*/
+	u8 reserved7;
+} __packed;
+
+static ssize_t boot_on_ac_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	struct boot_on_ac_request rq;
+	struct wilco_ec_message msg;
+	int ret;
+	u8 val;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.cmd = CMD_KB_CMOS;
+	rq.sub_cmd = SUB_CMD_KB_CMOS_AUTO_ON;
+	rq.val = val;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.type = WILCO_EC_MSG_LEGACY;
+	msg.request_data = &rq;
+	msg.request_size = sizeof(rq);
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(boot_on_ac);
+
+static struct attribute *wilco_dev_attrs[] = {
+	&dev_attr_boot_on_ac.attr,
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

