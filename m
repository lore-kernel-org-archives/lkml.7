Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FD3218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV0q0jwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbfB1Iql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:46:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43279 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731482AbfB1Iqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so20900754wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=o7o5ULP3pPMSLXTLOQrIkwQvE0nX3tt8oivkDqhUbRQ=;
        b=SV0q0jwewm2OdP1ko+4IAbmiKNtR2gJcX2wVnuOdrTtyfnkOxNNsl/3OjxCkNSF8Qy
         E29wAbZhaXCjhucqmSkTFopyjLUJ5PHh0Fs6AMP37djxxEUpL/3q/n+SHM7Zh5pOzDlL
         Tl75bEvSSDuZ3nBUczLLWcAz7fKFLHg4BW64lwX4nLnKO3Ph98qN95YRfawFDX5L5gwr
         LbKa6QxOmqf0PsBQVkUpmSyC55iRa7Gh+mbScQapIRunK1W8x9EE51FkGlODe4T+kusj
         ecOFcMaNzCnEp02HCP0Xw0B0iHy517zGG6eV6DLsU4mePlvWc2eXlD+sVK/BE0fwpftf
         wxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=o7o5ULP3pPMSLXTLOQrIkwQvE0nX3tt8oivkDqhUbRQ=;
        b=oFEIWCKYEgaU8djhR+HBEaEhGQ3t2+l68n77rwhdcS0oPR5YZZAV2V9pmY3Ot2iNUc
         5MBpYytBU/O0IV5L4chcD9IfaSjhCdZQa28eIjjIr67JekMagPYA0gxPY/m6FXBn38tJ
         ov8GThMIKp9J24gaYDmNl0AuX/DqCiYV7YGXCV9GPOmlQAkY4ELPhTRPOBjS+ies7nD0
         ItH3gVS5yajb4nY7za28rModUxeit3c1nLnhNAPiESYojFTS15cKzqo7HxdhGp1Ua7+G
         /fa3DjMnf2nc90WBxaX/Uu2uH2t7WxfVDrH3mUf6j9e7iSakT05YG8EVHeB19QDcNvKt
         qDdA==
X-Gm-Message-State: APjAAAWaVBYs3Rp6OpcLlHzV2ZQqhDtSMa3DEQnedDs9VZu43+izUIs4
        r2KPJYU3BH0BHm0Gv2KI14rF0SGK
X-Google-Smtp-Source: APXvYqwEb9cunKHs4BFdccfBLRDUiCE0mTZAwK+UfteaMQixTxys/HaSRUyTVwt1gANfMFt21NCjDw==
X-Received: by 2002:a5d:6641:: with SMTP id f1mr5457598wrw.279.1551343597521;
        Thu, 28 Feb 2019 00:46:37 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:36 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] habanalabs: disable CPU access on timeouts
Date:   Thu, 28 Feb 2019 10:46:12 +0200
Message-Id: <20190228084624.25288-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a workaround for a bug in the F/W where the response
time for a request from KMD may take more then 100ms. This could cause the
queue between KMD and the F/W to get out of sync.

The WA is to:
1. Increase the timeout of ALL requests to 1s.
2. In case a request isn't answered in time, mark the state as
"cpu_disabled" and prevent sending further requests from KMD to the F/W.
This will eventually lead to a heartbeat failure and hard reset of the
device.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/debugfs.c    | 6 ++++--
 drivers/misc/habanalabs/device.c     | 2 ++
 drivers/misc/habanalabs/goya/goya.c  | 9 +++++++--
 drivers/misc/habanalabs/habanalabs.h | 2 ++
 drivers/misc/habanalabs/hwmon.c      | 2 +-
 drivers/misc/habanalabs/sysfs.c      | 4 ++--
 6 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index f472b572faea..1d2bbcf90f16 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -723,7 +723,7 @@ static ssize_t hl_device_read(struct file *f, char __user *buf,
 		return 0;
 
 	sprintf(tmp_buf,
-		"Valid values are: disable, enable, suspend, resume\n");
+		"Valid values: disable, enable, suspend, resume, cpu_timeout\n");
 	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
 			strlen(tmp_buf) + 1);
 
@@ -751,9 +751,11 @@ static ssize_t hl_device_write(struct file *f, const char __user *buf,
 		hdev->asic_funcs->suspend(hdev);
 	} else if (strncmp("resume", data, strlen("resume")) == 0) {
 		hdev->asic_funcs->resume(hdev);
+	} else if (strncmp("cpu_timeout", data, strlen("cpu_timeout")) == 0) {
+		hdev->device_cpu_disabled = true;
 	} else {
 		dev_err(hdev->dev,
-			"Valid values are: disable, enable, suspend, resume\n");
+			"Valid values: disable, enable, suspend, resume, cpu_timeout\n");
 		count = -EINVAL;
 	}
 
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 120d30a13afb..de46aa6ed154 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -636,6 +636,8 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	/* Finished tear-down, starting to re-initialize */
 
 	if (hard_reset) {
+		hdev->device_cpu_disabled = false;
+
 		/* Allocate the kernel context */
 		hdev->kernel_ctx = kzalloc(sizeof(*hdev->kernel_ctx),
 						GFP_KERNEL);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 7c2edabe20bd..5780041abe32 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3232,6 +3232,11 @@ int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
 	if (hdev->disabled)
 		goto out;
 
+	if (hdev->device_cpu_disabled) {
+		rc = -EIO;
+		goto out;
+	}
+
 	rc = hl_hw_queue_send_cb_no_cmpl(hdev, GOYA_QUEUE_ID_CPU_PQ, len,
 			pkt_dma_addr);
 	if (rc) {
@@ -3245,8 +3250,8 @@ int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
 	hl_hw_queue_inc_ci_kernel(hdev, GOYA_QUEUE_ID_CPU_PQ);
 
 	if (rc == -ETIMEDOUT) {
-		dev_err(hdev->dev,
-			"Timeout while waiting for CPU packet fence\n");
+		dev_err(hdev->dev, "Timeout while waiting for device CPU\n");
+		hdev->device_cpu_disabled = true;
 		goto out;
 	}
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 59b25c6fae00..a7c95e9f9b9a 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1079,6 +1079,7 @@ struct hl_device_reset_work {
  * @dram_default_page_mapping: is DRAM default page mapping enabled.
  * @init_done: is the initialization of the device done.
  * @mmu_enable: is MMU enabled.
+ * @device_cpu_disabled: is the device CPU disabled (due to timeouts)
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -1146,6 +1147,7 @@ struct hl_device {
 	u8				dram_supports_virtual_memory;
 	u8				dram_default_page_mapping;
 	u8				init_done;
+	u8				device_cpu_disabled;
 
 	/* Parameters for bring-up */
 	u8				mmu_enable;
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index 9c359a1dd868..7eec21f9b96e 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -10,7 +10,7 @@
 #include <linux/pci.h>
 #include <linux/hwmon.h>
 
-#define SENSORS_PKT_TIMEOUT		100000	/* 100ms */
+#define SENSORS_PKT_TIMEOUT		1000000	/* 1s */
 #define HWMON_NR_SENSOR_TYPES		(hwmon_pwm + 1)
 
 int hl_build_hwmon_channel_info(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index 6d80e7e0885c..12c782112a8c 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -9,8 +9,8 @@
 
 #include <linux/pci.h>
 
-#define SET_CLK_PKT_TIMEOUT	200000	/* 200ms */
-#define SET_PWR_PKT_TIMEOUT	400000	/* 400ms */
+#define SET_CLK_PKT_TIMEOUT	1000000	/* 1s */
+#define SET_PWR_PKT_TIMEOUT	1000000	/* 1s */
 
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
 {
-- 
2.17.1

