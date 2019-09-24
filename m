Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB579C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F38E207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCZk+gzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408783AbfIXCtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:49:47 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42008 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408131AbfIXCtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:49:47 -0400
Received: by mail-ua1-f67.google.com with SMTP id r19so67287uap.9;
        Mon, 23 Sep 2019 19:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7PuLm4XsUDXNvaLPQfZjNtATDNXHns4lSD+JB2YvrXg=;
        b=OCZk+gzPhiDrThBb7lyzL04h2RrNSVzZSoi5RjUro9w2YUwBQxGcIbZAVFHEe0KH3J
         m6VpNh3hcdOOFeqVuZ39Lccxgbn5PXpUcGbG/dga+IzCFFerT/sboVV91U8fuv8v5c4w
         Jclj5ju1Qoung282/OQ5AotzFUSNpCTijp+NhVzL3OwoZoTEa4wWkP1PwteSk7fLiIH5
         DCx1C1KCqXh9UcSs5ITJlNkrUgvum97lk5Rbm67YanJePw8gxSP7/wdMBMI6+O4v18H+
         KOLvi59pKaZZc9zWSbhTYKmOE6py5sgJJ1nFQF265aBTRITfAA1U8QQSvbspnJ739VtT
         fubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PuLm4XsUDXNvaLPQfZjNtATDNXHns4lSD+JB2YvrXg=;
        b=jCO3tk1rN792p6YFP72qbNZKqrboq032XPYcVe7RO/knHGjHaVPnY4mth6OQF6J0jU
         pPJjQfcq2w1VXUf8eMCgi94JB1eKD3V59g/Xp+eb/SjwtspgirBIabmhzPv6+hcYweEA
         G609PwPh13Kl3NlRzqgREaTmfGBuXvyrVdjpKgYBPrFP7DUuODTVBEjwZNhEVjXWEKed
         ev3mjym3dBSOu96gAO7HHbendPPvYniWVsMej3Wn8PRjuQGx3bZIARHJ1YiSaa+LfjwO
         WwqajjYFkY369z7RgXFCKopf4OodiKVex1xCS0pmbHbhONjQOoxxW9YPjeUcXXBW2pEh
         tkJg==
X-Gm-Message-State: APjAAAX7B87MKefQP5f6IJTIc/6q35aTn5PUfx7BiH125lWA4vgAtotG
        dDlA+cZS8tclyDE7BoOEUA==
X-Google-Smtp-Source: APXvYqzTvB687KpM3S8YhwWJ+mMNNCef3AyS1H0k+QFA5Y6MhvgYei5A6x54ooZh5Ej+ibWEDJ3PaA==
X-Received: by 2002:ab0:77cc:: with SMTP id y12mr311990uar.110.1569293384050;
        Mon, 23 Sep 2019 19:49:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:901:202:18cc:820:670:dd1:f572])
        by smtp.gmail.com with ESMTPSA id o16sm46547uar.2.2019.09.23.19.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 19:49:43 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] platform/x86: huawei-wmi: Add debugfs support
Date:   Mon, 23 Sep 2019 22:48:11 -0400
Message-Id: <20190924024821.497-7-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924024821.497-1-ayman.bagabas@gmail.com>
References: <20190924024821.497-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs interface that can be used to call the WMI management
interface function if available.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 97 +++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index d550c63fcba7..6720f78c60c2 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
@@ -52,10 +53,16 @@ struct quirk_entry {
 
 static struct quirk_entry *quirks;
 
+struct huawei_wmi_debug {
+	struct dentry *root;
+	u64 arg;
+};
+
 struct huawei_wmi {
 	bool battery_available;
 	bool fn_lock_available;
 
+	struct huawei_wmi_debug debug;
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
 	struct platform_device *pdev;
@@ -592,6 +599,94 @@ static void huawei_wmi_fn_lock_exit(struct device *dev)
 		device_remove_file(dev, &dev_attr_fn_lock_state);
 }
 
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
+			huawei_wmi_debugfs_call_dump(m, huawei, &obj->package.elements[i]);
+			if (i < obj->package.count - 1)
+				seq_puts(m, ",");
+		}
+		seq_puts(m, "]");
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
+	err = huawei_wmi_call(&in, &out);
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
+static void huawei_wmi_debugfs_setup(struct device *dev)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+
+	huawei->debug.root = debugfs_create_dir("huawei-wmi", NULL);
+
+	debugfs_create_x64("arg", 0644, huawei->debug.root,
+		&huawei->debug.arg);
+	debugfs_create_file("call", 0400,
+		huawei->debug.root, huawei, &huawei_wmi_debugfs_call_fops);
+}
+
+static void huawei_wmi_debugfs_exit(struct device *dev)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+
+	debugfs_remove_recursive(huawei->debug.root);
+}
+
 /* Input */
 
 static void huawei_wmi_process_key(struct input_dev *idev, int code)
@@ -717,6 +812,7 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 		huawei_wmi_leds_setup(&pdev->dev);
 		huawei_wmi_fn_lock_setup(&pdev->dev);
 		huawei_wmi_battery_setup(&pdev->dev);
+		huawei_wmi_debugfs_setup(&pdev->dev);
 	}
 
 	return 0;
@@ -734,6 +830,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 	}
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+		huawei_wmi_debugfs_exit(&pdev->dev);
 		huawei_wmi_battery_exit(&pdev->dev);
 		huawei_wmi_fn_lock_exit(&pdev->dev);
 	}
-- 
2.21.0

