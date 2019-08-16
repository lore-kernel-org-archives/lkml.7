Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674A8C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 00:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CABB2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 00:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SiGOxa4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfHPAJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 20:09:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46074 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfHPAJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 20:09:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so2135427pfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 17:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QdO+KVP1+sss46fGBNGuzASBMGiLUw4LDdShHVqVS8g=;
        b=SiGOxa4oChRUrJQDP/9WW9hEK3Q7GEDfzQioPwOA4DoanEr7H9XLhn3g4CCzTNjEbR
         QKg7ZhjgONqSMIffm8B2BmBOv+ICZjEv1O+9dICsOZiFfZgsi7r2pt9T/FS9S9tMq+Tf
         4aOvx45ebDQyuYGew9Aw/jjLKO8/yufhC6IuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QdO+KVP1+sss46fGBNGuzASBMGiLUw4LDdShHVqVS8g=;
        b=cOZAd74xJZiWQCB6XxxdDJGLvBi8Ccb5aVeNbHmHdoYqc350y/110urhBrFgxYRPaH
         lWT/GSO676eFNz1mStIDIqT4t0k7VTlCYbNyGIfrhTPq4OqVZEOpX7JbOGfnos8vP5gX
         a65/OBGpOxIBirOEO5G6nN3lnVxbYeDhgdbPNvIQiL5QU4WFzno5IW9JyATynD19jlL8
         hzzPOUjE2CEbB9RUZ0W+of4r7WKp4ovMFO2UDNKqdBusI2vzhW5tjTiLNsYe4QPv0aPR
         UdEQq4nKoGN1yti3am1Xr4oImfKtrZjcctgUSjh4w8w3jytD9jo+iQp9Cigz69MOofKi
         q5gQ==
X-Gm-Message-State: APjAAAW1lrRWMx6A/bVyTwSO4y1eT/QCJgmoqUTklBco6Gadzl6bbm+X
        NLEGH8qwhiuiMz9FDcrrPA4YzA==
X-Google-Smtp-Source: APXvYqybWBOdTqtForqqs5AXfctJmFJuGpFhCmJcKMASp2u0bNvd1fYKk9MUyCUmcumZ7pokMfTldg==
X-Received: by 2002:aa7:97aa:: with SMTP id d10mr8052048pfq.176.1565914196045;
        Thu, 15 Aug 2019 17:09:56 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g2sm4056916pfi.26.2019.08.15.17.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 17:09:55 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 1/3] test_firmware: add support for request_firmware_into_buf
Date:   Thu, 15 Aug 2019 17:09:43 -0700
Message-Id: <20190816000945.29810-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816000945.29810-1-scott.branden@broadcom.com>
References: <20190816000945.29810-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test config into_buf to allow request_firmware_into_buf to be
called instead of request_firmware/request_firmware_direct.  The number
of parameters differ calling request_firmware_into_buf and support
has not been added to test such api in test_firmware until now.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 lib/test_firmware.c | 50 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 6ca97a63b3d6..1aa430228ae6 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/delay.h>
@@ -26,6 +27,7 @@
 
 #define TEST_FIRMWARE_NAME	"test-firmware.bin"
 #define TEST_FIRMWARE_NUM_REQS	4
+#define TEST_FIRMWARE_BUF_SIZE	SZ_1K
 
 static DEFINE_MUTEX(test_fw_mutex);
 static const struct firmware *test_firmware;
@@ -45,6 +47,8 @@ struct test_batched_req {
  * test_config - represents configuration for the test for different triggers
  *
  * @name: the name of the firmware file to look for
+ * @into_buf: when the into_buf is used if this is true
+ *	request_firmware_into_buf() will be used instead.
  * @sync_direct: when the sync trigger is used if this is true
  *	request_firmware_direct() will be used instead.
  * @send_uevent: whether or not to send a uevent for async requests
@@ -83,6 +87,7 @@ struct test_batched_req {
  */
 struct test_config {
 	char *name;
+	bool into_buf;
 	bool sync_direct;
 	bool send_uevent;
 	u8 num_requests;
@@ -176,6 +181,7 @@ static int __test_firmware_config_init(void)
 
 	test_fw_config->num_requests = TEST_FIRMWARE_NUM_REQS;
 	test_fw_config->send_uevent = true;
+	test_fw_config->into_buf = false;
 	test_fw_config->sync_direct = false;
 	test_fw_config->req_firmware = request_firmware;
 	test_fw_config->test_result = 0;
@@ -244,6 +250,9 @@ static ssize_t config_show(struct device *dev,
 			test_fw_config->send_uevent ?
 			"FW_ACTION_HOTPLUG" :
 			"FW_ACTION_NOHOTPLUG");
+	len += scnprintf(buf+len, PAGE_SIZE - len,
+			"into_buf:\t\t%s\n",
+			test_fw_config->into_buf ? "true" : "false");
 	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"sync_direct:\t\t%s\n",
 			test_fw_config->sync_direct ? "true" : "false");
@@ -393,6 +402,23 @@ static ssize_t config_num_requests_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(config_num_requests);
 
+static ssize_t config_into_buf_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	return test_dev_config_update_bool(buf,
+					   count,
+					   &test_fw_config->into_buf);
+}
+
+static ssize_t config_into_buf_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	return test_dev_config_show_bool(buf, test_fw_config->into_buf);
+}
+static DEVICE_ATTR_RW(config_into_buf);
+
 static ssize_t config_sync_direct_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
@@ -522,7 +548,7 @@ static ssize_t trigger_async_request_store(struct device *dev,
 		rc = count;
 	} else {
 		pr_err("failed to async load firmware\n");
-		rc = -ENODEV;
+		rc = -ENOMEM;
 	}
 
 out:
@@ -585,7 +611,26 @@ static int test_fw_run_batch_request(void *data)
 		return -EINVAL;
 	}
 
-	req->rc = test_fw_config->req_firmware(&req->fw, req->name, req->dev);
+	if (test_fw_config->into_buf) {
+		void *test_buf;
+
+		test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
+		if (!test_buf)
+			return -ENOSPC;
+
+		req->rc = request_firmware_into_buf(&req->fw,
+						    req->name,
+						    req->dev,
+						    test_buf,
+						    TEST_FIRMWARE_BUF_SIZE);
+		if (!req->fw)
+			kfree(test_buf);
+	} else {
+		req->rc = test_fw_config->req_firmware(&req->fw,
+						       req->name,
+						       req->dev);
+	}
+
 	if (req->rc) {
 		pr_info("#%u: batched sync load failed: %d\n",
 			req->idx, req->rc);
@@ -849,6 +894,7 @@ static struct attribute *test_dev_attrs[] = {
 	TEST_FW_DEV_ATTR(config),
 	TEST_FW_DEV_ATTR(config_name),
 	TEST_FW_DEV_ATTR(config_num_requests),
+	TEST_FW_DEV_ATTR(config_into_buf),
 	TEST_FW_DEV_ATTR(config_sync_direct),
 	TEST_FW_DEV_ATTR(config_send_uevent),
 	TEST_FW_DEV_ATTR(config_read_fw_idx),
-- 
2.17.1

