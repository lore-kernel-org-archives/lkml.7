Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03451C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C286921920
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOgv/y0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394507AbfITAlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 20:41:07 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37268 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388479AbfITAlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 20:41:06 -0400
Received: by mail-yw1-f65.google.com with SMTP id u65so1934615ywe.4;
        Thu, 19 Sep 2019 17:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i+tHQQIVQzEbeUZdVQWPUgZcFAD65xbujylPTpUTyNY=;
        b=sOgv/y0MyWza+27Zo0Dc7UqOr37F51AjoqxT36vfivH0a/78d5FrCeqOt+nS4SspGQ
         3gv3nVwJJZSEASyRTQjTMZZ7YCw4yT1TAFdZo9WMGfcfqrrz6KiL/WHlKsaR4t8Ujdda
         q2fGY7110VRgX7Rmysp84DKarNZ5UDYIMGtRcDwzWdDo5emBJsql8w7gZaujFM2cKgsB
         sdSeyxe8KErINM5eKZJcxMhxMxjcoBGA0eC+wFT7iyLAvECgyIJvWw2l3bRdaH1yCagL
         NVG+s6UAa/ov3Ng1Y4XG8TDtSIVz8Cf+SkqGEQzNDXJzunP5/FNWA9bZH1KaTsh2vaIk
         SdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+tHQQIVQzEbeUZdVQWPUgZcFAD65xbujylPTpUTyNY=;
        b=j6dOr1wh0Iid5YGReFjWCEytMlr8+/ViRa0oVQTglox9c/OW8SoGLsRb/AAMbCyNyp
         gLCptxazY20gsgT7hSqbM6iBLarre24qjCQWJxHj3ZwFU4prCxcV5va+zteLc+yn4GqX
         6ZWNFMjc8+qbKjlXGwrMRYqk0mc+wRqu7VqYF43Tfj74z7wiY+xpvZGGJZE4FtQ3ZXad
         +OWRejW6azRFs8a+DhM2GGYeKtzwt4Do8l9BijwBy0MZEftqlKe+Hm96Y/ny+8JoD6l8
         BilNvGyufyIp/0LcmGVRCS9AqEkpasqHVb/r1rRSLM5Qvn8DcJPNvGe1Ysbi2oMBUV/o
         k5oA==
X-Gm-Message-State: APjAAAVSCGfbk5m5FsE/6jlkncJb0jWDpAaFHFKfXUkLAcJqJ41Ca4FL
        xbEFG533X2RKakGbcrYkdQ==
X-Google-Smtp-Source: APXvYqyHFG04J+N3eQ8onFjXKxQ4GNnYQ3DIsL1OatK/Yttll4/63iXV3oDyUeEuNFVe0FdbdEOthQ==
X-Received: by 2002:a81:5c57:: with SMTP id q84mr9802626ywb.88.1568940065549;
        Thu, 19 Sep 2019 17:41:05 -0700 (PDT)
Received: from 960.localdomain ([64.192.53.12])
        by smtp.gmail.com with ESMTPSA id r63sm102802ywg.36.2019.09.19.17.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 17:41:05 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sinan Kaya <okaya@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] platform/x86: huawei-wmi: Add debugfs support
Date:   Thu, 19 Sep 2019 20:39:11 -0400
Message-Id: <20190920003938.21617-7-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920003938.21617-1-ayman.bagabas@gmail.com>
References: <20190920003938.21617-1-ayman.bagabas@gmail.com>
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
 drivers/platform/x86/huawei-wmi.c | 91 +++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 8fc11a296357..c8f41121160c 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
@@ -598,6 +599,94 @@ static void huawei_wmi_fn_lock_exit(struct device *dev)
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
@@ -723,6 +812,7 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 		huawei_wmi_leds_setup(&pdev->dev);
 		huawei_wmi_fn_lock_setup(&pdev->dev);
 		huawei_wmi_battery_setup(&pdev->dev);
+		huawei_wmi_debugfs_setup(&pdev->dev);
 	}
 
 	return 0;
@@ -740,6 +830,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 	}
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+		huawei_wmi_debugfs_exit(&pdev->dev);
 		huawei_wmi_battery_exit(&pdev->dev);
 		huawei_wmi_fn_lock_exit(&pdev->dev);
 	}
-- 
2.21.0

