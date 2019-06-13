Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FD2C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F94621773
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1AzkrzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393064AbfFMQwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:52:53 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46651 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbfFMDFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:05:05 -0400
Received: by mail-yb1-f193.google.com with SMTP id p8so7189267ybo.13;
        Wed, 12 Jun 2019 20:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avxwadTNE1a71wDomhQ/ZZmaD0txhopJrsKMB0EV4wo=;
        b=E1AzkrzQ5MTzeWt0LWAN5qdswY5GbDun/Q8rZsfTeQ7WY8CGbJ5Xkx3W8elwusUpTE
         OU+IffJv3JmhVhL6MQzVLP8FxTZAIXr/QQyz28jcgIgbxotGSESWKshcUlxORGFyfWrV
         dUXxg8PdAQ1o4QGXhzFN4cvPpRI/u+6nP4w4IEe8ZbDKI2L596x2qzaN/V+rLj/tOyxs
         IQFeXmLTnTGiL7TvFanIyKHCttX4wP5l0Lh7i/AcI9jj1Xjx8/fSWEkuU+fsq5F4koac
         gsrJnDBAQYNR07cXZDFRthxJeiXyekeFfcB9yuwY/7BfmFcwhW/H55MvU8Dpy7+5OBRh
         KlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avxwadTNE1a71wDomhQ/ZZmaD0txhopJrsKMB0EV4wo=;
        b=KOoQPYMyQSqPLsX6JQSSQtGQx3FeD1L84Sw03eC1g5Xmd+FlV/plBwR6a6FH6jIu1W
         WbYpmh6P7iixN5ZQpPiNzQk0ZZudj+npeJHCg8snRP+xQVFWJ3p2FafCVv8UXnYc59YR
         ogJrAoiNxCJd0Oo8CKSe/c5q2EbhoLJ2mApkCyNvThtbrR4qUrNaEQJGz+YOH4h1/ySa
         6r517ZxrYk8mrIrsdxSsCbdGHF08iAN6p9cZUd5kVh/lDgK/OFuWsl3tl1HdZfzj/5/S
         jskj6qmgRK8JbAqrmT8UoCqE0aXHuVLOUTA1jps2IsfrsvHQt/BbNgOw6Y/vvuVJFy9n
         CEFQ==
X-Gm-Message-State: APjAAAVFVfSlvh9b9MjSQDhMPmriAY9zZOPzvkKnR4dCRaguh1Yj6urt
        wgJXM9hOHnikXSFirCGhOBsRc9aJWQ==
X-Google-Smtp-Source: APXvYqzNbq/DIp83v1nhwYJtQdaQss3Kk2KAfqHa2OG+ZxBlzUrkSMVEicDr+fufaPMXukd5YLwPnQ==
X-Received: by 2002:a25:d9cc:: with SMTP id q195mr42965806ybg.390.1560395104284;
        Wed, 12 Jun 2019 20:05:04 -0700 (PDT)
Received: from 960.localdomain ([71.46.56.3])
        by smtp.gmail.com with ESMTPSA id j184sm424831ywf.8.2019.06.12.20.05.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 20:05:03 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v2 8/8] platform/x86: huawei-wmi: add debugfs files support
Date:   Wed, 12 Jun 2019 23:04:15 -0400
Message-Id: <20190613030416.25807-10-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613030416.25807-1-ayman.bagabas@gmail.com>
References: <20190613030416.25807-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A debugfs interface that creates two attributes `arg` and `call` to set
an argument to be called by the WMI device and show the results
returned. This argument is a 64 bit long which complies the properties
of the HWMI interface.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 117 ++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index cc6745ff1bad..a74ddd9adb47 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
@@ -46,8 +47,14 @@ struct quirk_entry {
 
 static struct quirk_entry *quirks;
 
+struct huawei_wmi_debug {
+	struct dentry *root;
+	u64 arg;
+};
+
 struct huawei_wmi {
 	struct led_classdev cdev;
+	struct huawei_wmi_debug debug;
 	struct input_dev *idev[2];
 	struct mutex wmi_lock;
 	struct mutex battery_lock;
@@ -463,6 +470,110 @@ static struct attribute *huawei_wmi_attrs[] = {
 
 ATTRIBUTE_GROUPS(huawei_wmi);
 
+/* debugfs */
+
+static void huawei_wmi_debugfs_call_dump(struct seq_file *m, void *data,
+		union acpi_object *obj)
+{
+	struct huawei_wmi *huawei = m->private;
+	int i;
+
+	switch (obj->type) {
+	case ACPI_TYPE_INTEGER:
+		seq_printf(m, "0x%llx", obj->integer.value);
+		break;
+	case ACPI_TYPE_STRING:
+		seq_printf(m, "\"%*s\"", obj->string.length, obj->string.pointer);
+		break;
+	case ACPI_TYPE_BUFFER:
+		seq_printf(m, "{");
+		for (i = 0; i < obj->buffer.length; i++) {
+			seq_printf(m, "0x%02x", obj->buffer.pointer[i]);
+			if (i < obj->buffer.length - 1)
+				seq_printf(m, ",");
+		}
+		seq_printf(m, "}");
+		break;
+	case ACPI_TYPE_PACKAGE:
+		seq_printf(m, "[");
+		for (i = 0; i < obj->package.count; i++) {
+			huawei_wmi_debugfs_call_dump(m, huawei, &obj->package.elements[i]);
+			if (i < obj->package.count - 1)
+				seq_printf(m, ",");
+		}
+		seq_printf(m, "]");
+		break;
+	default:
+		dev_err(&huawei->pdev->dev, "Unexpected obj type, got %d\n", obj->type);
+		return;
+	}
+}
+
+static int huawei_wmi_debugfs_call_show(struct seq_file *m, void *data)
+{
+	struct huawei_wmi *huawei = m->private;
+	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer in;
+	union acpi_object *obj;
+	int err;
+
+	in.length = sizeof(u64);
+	in.pointer = &huawei->debug.arg;
+
+	err = huawei_wmi_call(&huawei->pdev->dev, &in, &out);
+	if (err)
+		return err;
+
+	obj = out.pointer;
+	if (!obj) {
+		err = -EIO;
+		goto fail_debugfs_call;
+	}
+
+	huawei_wmi_debugfs_call_dump(m, huawei, obj);
+
+fail_debugfs_call:
+	kfree(out.pointer);
+	return err;
+}
+
+DEFINE_SHOW_ATTRIBUTE(huawei_wmi_debugfs_call);
+
+static void huawei_wmi_debugfs_exit(struct device *dev)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+
+	debugfs_remove_recursive(huawei->debug.root);
+}
+
+static int huawei_wmi_debugfs_init(struct device *dev)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+	struct dentry *dent;
+
+	huawei->debug.root = debugfs_create_dir("huawei-wmi", NULL);
+	if (!huawei->debug.root) {
+		dev_err(dev, "Failed to create debugfs directory\n");
+		goto fail_debugfs;
+	}
+
+	dent = debugfs_create_x64("arg", S_IRUGO | S_IWUSR, huawei->debug.root,
+			&huawei->debug.arg);
+	if (!dent)
+		goto fail_debugfs;
+
+	dent = debugfs_create_file("call", S_IFREG | S_IRUSR,
+			huawei->debug.root, huawei, &huawei_wmi_debugfs_call_fops);
+	if (!dent)
+		goto fail_debugfs;
+
+	return 0;
+
+fail_debugfs:
+	huawei_wmi_debugfs_exit(dev);
+	return -ENOMEM;
+}
+
 /* Input */
 
 static void huawei_wmi_process_key(struct input_dev *idev, int code)
@@ -597,7 +708,12 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 		err = huawei_wmi_leds_setup(&pdev->dev);
 		if (err)
 			dev_err(&pdev->dev, "Failed to setup leds\n");
+
+		err = huawei_wmi_debugfs_init(&pdev->dev);
+		if (err)
+			dev_err(&pdev->dev, "Failed to setup debugfs\n");
 	}
+
 	return 0;
 }
 
@@ -610,6 +726,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 		wmi_remove_notify_handler(HWMI_EVENT_GUID);
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+		huawei_wmi_debugfs_exit(&pdev->dev);
 		sysfs_remove_group(&pdev->dev.kobj, &huawei_wmi_group);
 	}
 
-- 
2.20.1

