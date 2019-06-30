Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D2FC5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC63F208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLwQij/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfF3Fl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 01:41:58 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37688 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfF3Fly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 01:41:54 -0400
Received: by mail-vs1-f67.google.com with SMTP id v6so6753958vsq.4;
        Sat, 29 Jun 2019 22:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xl+sNzEYPOT1ywDx++7Y8OIBlzLDJkDBqJnWrBIwwq4=;
        b=VLwQij/5g9C/PdlQUUixCzBA5oWa+mF0QzRFXvolDQhd9b4fzUbA8S+K+WPbVOfw6A
         zPieR4mcq6SHGGfSytiUfpULKdXk5xxHcpZ0EiCqjEms5bSrkaXVPEogz1oJLrLm03ov
         TLI0hI8cKII+OrLcXnH+++wzyeyZ+Wsmbim64fPJ+25pmlcV0TiyHx9HkTozFafgnmPq
         5Bn/QK1Ug75bzYSzqjGLzi7DNd8pdbS27nykQEsEqSeRxb0pOFmYxTfoybHuxwTB6wev
         C9+AhVZLwc29xbiKEK2FurTzqtqP9G7N6KNu5ipbHVuZDMy+BERUlSzDjpod1di/OVCq
         8F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xl+sNzEYPOT1ywDx++7Y8OIBlzLDJkDBqJnWrBIwwq4=;
        b=SVrq3dWFQyNxku2NfZOQgBO76PfzAwDAUMBy6RjhNCaxtI6QL6r3WM/1/zq/M4C7Pq
         WNjm3OW32a++XK+fjJMEqPWlwcSAl8ygtn2C5B05iRamVCb5xNEqK7LL9C5DycxSyDc+
         T5BslyY4yroFenqoCAZ2HY3l22DuibNbyPRzri5XKXo59eItpT+03m15nogbarT+Gv54
         DHlD6+KQ4eBVD1+HTI4Bpg0ATfl2du41qZENBPcDqYh/S2NW2Sim0zUA+S4qVyOwe8s4
         3GlWkOfVCESDDbo688GWiKcrMKcu1p5qItDSYsrkFnEpM7yYB6g2T5CNRSndIi2SGn/r
         EOlA==
X-Gm-Message-State: APjAAAWK7RM11AST5QbLPVbMR9K23j4YC95jOrerDmkmqqFBNYUkU0i2
        Ud7owMXv9ZK8EIIcgovDnA==
X-Google-Smtp-Source: APXvYqw+m1w37rCVm7BL+BsPXDgUeQT2G6vzl51WTL+AHq47lrmWTcVqc3ZqcC626cPZXpqToacBWA==
X-Received: by 2002:a67:d993:: with SMTP id u19mr3419960vsj.0.1561873313257;
        Sat, 29 Jun 2019 22:41:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:37bd:d695:3a39:ceb9])
        by smtp.gmail.com with ESMTPSA id r136sm1926676vke.46.2019.06.29.22.41.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 22:41:52 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [RFC 9/9] platform/x86: huawei-wmi: Add debugfs support
Date:   Sun, 30 Jun 2019 01:41:08 -0400
Message-Id: <20190630054108.19205-10-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630054108.19205-1-ayman.bagabas@gmail.com>
References: <20190630054108.19205-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
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

