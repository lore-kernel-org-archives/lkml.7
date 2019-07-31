Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29C9C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823FC206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyi/izXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfGaRxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:53:40 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33112 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbfGaRxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:53:35 -0400
Received: by mail-yb1-f195.google.com with SMTP id c202so23393749ybf.0;
        Wed, 31 Jul 2019 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xl+sNzEYPOT1ywDx++7Y8OIBlzLDJkDBqJnWrBIwwq4=;
        b=nyi/izXTpquwaKJYaeTkQLXnq3F/yOfKXje6aOE22OZzp9etnKEXfYR9szqP5gbaQi
         lqE1RzYgcP+Rk2QbA3e/BdPJCdb8hZhwuXEWV5mddcwzLh0D+xd48SHuwlcZH3dXlgBN
         92cS++AAFHW/FoRyq/x02uNJ9jRfpfflwW5D7pSu622/9mtZ8c6gLFfJdviAybK7X1A2
         sCCw2P1YUylJ434vKU1rRDoWv9QIk09fxDEApMqM9IKQ3xTQUVGfovQq1JxeFzzB3d1F
         GTGGx1/Io/rwCN2uLGEt29IIyP5t1qU/fdM7HLP1rrieg1Eq8N8EFLwQO2SrjXCpasub
         PjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xl+sNzEYPOT1ywDx++7Y8OIBlzLDJkDBqJnWrBIwwq4=;
        b=BV8Ae+I2L0AWSNyggJPSfN3nG3w2ugFJrSZQlJgDV83DtTIDNiMZNE0ieLn6mvJVxe
         zhEFaADB3N2b26WM7SjpyeiKcKVWzxMEf5uXkJFvQ+mjrOfl4GA2vWN7lvhcmvwXOaC+
         QqlWMNxVSo1jc/l1ctcDwIiwCvmx/evmrqzBLrOy8HOOd+HZV+CcBAAYMrb3el+uxHKb
         b9d2m9MUgc4cSvJGi0DHFhWYoMGKinKOtGZDxDrqJShzdq+VzdMSac13wK+/wpbPs+DB
         FI4YxgfCPEZ7J/7vYBP5wx6ptvTJmHeS8lSksSOJXk8+OgPT/MAspMIHeYqXdYVNlaf2
         MNAg==
X-Gm-Message-State: APjAAAUPJ8DpZBwNJx9vSe0+gp8JWDpUGpGtV9ICsbgKbTbO9JVGvhzi
        sN4LFO5h8dJ4u2sOHOlsEXYbtsI=
X-Google-Smtp-Source: APXvYqy8z/OlVkd240XLgbZteZYyKIP+RYC2cR0fhSo0jIhO0cRURLPFWIoNWpPjD0VnzRnKenYtCw==
X-Received: by 2002:a25:1806:: with SMTP id 6mr28052653yby.415.1564595613804;
        Wed, 31 Jul 2019 10:53:33 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id w193sm10517294ywa.72.2019.07.31.10.53.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:53:33 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [RFC 9/9] platform/x86: huawei-wmi: Add debugfs support
Date:   Wed, 31 Jul 2019 13:52:55 -0400
Message-Id: <20190731175255.25676-10-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731175255.25676-1-ayman.bagabas@gmail.com>
References: <20190731175255.25676-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs interface that can be used to call the WMI management
interface function.

The WMI interface takes a 64 bit integer and returns 256-260 bytes
buffer. This debugfs interface creates two files, one stores a 64 bit
int and the other calls the WMI interface and dumps out the returned
buffer.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 98 +++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index f7041fb71026..bdca8bd76c8c 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
@@ -45,7 +46,13 @@ struct quirk_entry {
 
 static struct quirk_entry *quirks;
 
+struct huawei_wmi_debug {
+	struct dentry *root;
+	u64 arg;
+};
+
 struct huawei_wmi_priv {
+	struct huawei_wmi_debug debug;
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
 	struct mutex battery_lock;
@@ -456,6 +463,94 @@ static struct attribute *huawei_wmi_attrs[] = {
 
 ATTRIBUTE_GROUPS(huawei_wmi);
 
+/* debugfs */
+
+static void huawei_wmi_debugfs_call_dump(struct seq_file *m, void *data,
+		union acpi_object *obj)
+{
+	struct huawei_wmi_priv *priv = m->private;
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
+		seq_puts(m, "{");
+		for (i = 0; i < obj->buffer.length; i++) {
+			seq_printf(m, "0x%02x", obj->buffer.pointer[i]);
+			if (i < obj->buffer.length - 1)
+				seq_puts(m, ",");
+		}
+		seq_puts(m, "}");
+		break;
+	case ACPI_TYPE_PACKAGE:
+		seq_puts(m, "[");
+		for (i = 0; i < obj->package.count; i++) {
+			huawei_wmi_debugfs_call_dump(m, priv, &obj->package.elements[i]);
+			if (i < obj->package.count - 1)
+				seq_puts(m, ",");
+		}
+		seq_puts(m, "]");
+		break;
+	default:
+		dev_err(&priv->pdev->dev, "Unexpected obj type, got %d\n", obj->type);
+		return;
+	}
+}
+
+static int huawei_wmi_debugfs_call_show(struct seq_file *m, void *data)
+{
+	struct huawei_wmi_priv *priv = m->private;
+	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer in;
+	union acpi_object *obj;
+	int err;
+
+	in.length = sizeof(u64);
+	in.pointer = &priv->debug.arg;
+
+	err = huawei_wmi_call(&priv->pdev->dev, &in, &out);
+	if (err)
+		return err;
+
+	obj = out.pointer;
+	if (!obj) {
+		err = -EIO;
+		goto fail_debugfs_call;
+	}
+
+	huawei_wmi_debugfs_call_dump(m, priv, obj);
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
+	struct huawei_wmi_priv *priv = dev_get_drvdata(dev);
+
+	debugfs_remove_recursive(priv->debug.root);
+}
+
+static void huawei_wmi_debugfs_setup(struct device *dev)
+{
+	struct huawei_wmi_priv *priv = dev_get_drvdata(dev);
+
+	priv->debug.root = debugfs_create_dir("huawei-wmi", NULL);
+
+	debugfs_create_x64("arg", 0644, priv->debug.root,
+		&priv->debug.arg);
+	debugfs_create_file("call", 0400,
+		priv->debug.root, priv, &huawei_wmi_debugfs_call_fops);
+}
+
 /* Input */
 
 static void huawei_wmi_process_key(struct input_dev *idev, int code)
@@ -589,6 +684,8 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Failed to create sysfs interface\n");
 			return err;
 		}
+
+		huawei_wmi_debugfs_setup(&pdev->dev);
 	}
 
 	return 0;
@@ -603,6 +700,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 		wmi_remove_notify_handler(HWMI_EVENT_GUID);
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+		huawei_wmi_debugfs_exit(&pdev->dev);
 		sysfs_remove_groups(&pdev->dev.kobj, huawei_wmi_groups);
 	}
 
-- 
2.20.1


