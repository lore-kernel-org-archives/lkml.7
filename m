Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D027FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A607421479
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2dfquF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfJUFyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:54:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35994 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJUFyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 01:54:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so7705808pfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 22:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qEyxluXdxVFSj/jMNBXEzLvEIlJMi3CeOB42GTMwyU4=;
        b=G2dfquF20cYNkandnFadc9YFIR4tSUekEPQkLaVobFtzSLigA0PNXMQVaVG497DGLf
         n9sjLyv5AMz0+MN4yWAt/CUObonujBNFMQVWueApg41fztWyTFFlOWt17Aw8Qdyu/1BZ
         xvH3F4OEVZ+lDXEnKDf3C9d2KJkC40zqJu95s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qEyxluXdxVFSj/jMNBXEzLvEIlJMi3CeOB42GTMwyU4=;
        b=ZNkFi0HwIIZe6rZibCNTbMosWagUrZBI2Jkv4I93jb2tTTppZfYqFdLsduBkB26SYr
         hntLbZelidW+DYw0IKfnPJE2ZYq3sXDeXepWrhfmywbprbUocahUpMDJ9EH8Di9ES/7f
         olqMxjNqitiG3OqFDy1pU6/RXzUVqdCNCCHe87w+QMO21zkt6Vp2+9AM92lqcvRXMQ5b
         Bing+BQrLwcBgYYPBvZ5no8iovky9m+8sNy3m2L9LsOZny8x9DJ4C8UEQeZsgMOsNXd9
         Qf73/E6siCSUKemSFLi6AJnYPxNTZnfWcEzsNsRX94auP4dPLNANOM+EXyuUYGUONgMs
         E+XA==
X-Gm-Message-State: APjAAAXuwGAvSln2PmsfuQA3OHUkAkOBgqeJR0q28pDiYStiilHvK00b
        eWD5xf6BeZ6riqxUaW9nCEawTA==
X-Google-Smtp-Source: APXvYqx0e8jmp/9286IFC1Pjkblx1JXMirxqxNM6ptnLEnZg0gCpzzJdvzKYquNEiS0zPwZ1w1yrgw==
X-Received: by 2002:a17:90a:24e8:: with SMTP id i95mr27533129pje.12.1571637255942;
        Sun, 20 Oct 2019 22:54:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id q132sm14834284pfq.16.2019.10.20.22.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 22:54:15 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 02/18] mfd: cros_ec: Add sensor_count and make check_features public
Date:   Sun, 20 Oct 2019 22:53:47 -0700
Message-Id: <20191021055403.67849-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021055403.67849-1-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function to return the number of MEMS sensors available in a
ChromeOS Embedded Controller.
It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
registers to find out.

Also, make check_features public as it can be useful for other drivers
to know what the Embedded Controller supports.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v2:
  Fix spelling in commit message.
  Cleanup the case where DUMP command is not supported.
  Move code from mfd to platform/chrome/

 drivers/mfd/cros_ec_dev.c                   |  32 ------
 drivers/platform/chrome/cros_ec_proto.c     | 116 ++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |   5 +
 3 files changed, 121 insertions(+), 32 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 6e6dfd6c18711..a35104e35cb4e 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -112,38 +112,6 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
 	{ .name = "cros-ec-vbc", }
 };
 
-static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
-{
-	struct cros_ec_command *msg;
-	int ret;
-
-	if (ec->features[0] == -1U && ec->features[1] == -1U) {
-		/* features bitmap not read yet */
-		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
-		if (!msg)
-			return -ENOMEM;
-
-		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
-		msg->insize = sizeof(ec->features);
-
-		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-		if (ret < 0) {
-			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
-				 ret, msg->result);
-			memset(ec->features, 0, sizeof(ec->features));
-		} else {
-			memcpy(ec->features, msg->data, sizeof(ec->features));
-		}
-
-		dev_dbg(ec->dev, "EC features %08x %08x\n",
-			ec->features[0], ec->features[1]);
-
-		kfree(msg);
-	}
-
-	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
-}
-
 static void cros_ec_class_release(struct device *dev)
 {
 	kfree(to_cros_ec_dev(dev));
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 7db58771ec77c..2357c717399ad 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -717,3 +717,119 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
 	return host_event;
 }
 EXPORT_SYMBOL(cros_ec_get_host_event);
+
+/**
+ * cros_ec_check_features - Test for the presence of EC features
+ *
+ * Call this function to test whether the ChromeOS EC supports a feature.
+ *
+ * @ec_dev: EC device: does not have to be connected directly to the AP,
+ *          can be daisy chained through another device.
+ * @feature: One of ec_feature_code bit.
+ * @return: 1 if supported, 0 if not
+ */
+int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
+{
+	struct cros_ec_command *msg;
+	int ret;
+
+	if (ec->features[0] == -1U && ec->features[1] == -1U) {
+		/* features bitmap not read yet */
+		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
+		if (!msg)
+			return -ENOMEM;
+
+		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
+		msg->insize = sizeof(ec->features);
+
+		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+		if (ret < 0) {
+			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
+				 ret, msg->result);
+			memset(ec->features, 0, sizeof(ec->features));
+		} else {
+			memcpy(ec->features, msg->data, sizeof(ec->features));
+		}
+
+		dev_dbg(ec->dev, "EC features %08x %08x\n",
+			ec->features[0], ec->features[1]);
+
+		kfree(msg);
+	}
+
+	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
+}
+EXPORT_SYMBOL_GPL(cros_ec_check_features);
+
+/**
+ * Return the number of MEMS sensors supported.
+ *
+ * @ec_dev: EC device: does not have to be connected directly to the AP,
+ *          can be daisy chained through another device.
+ * Return < 0 in case of error.
+ */
+int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
+{
+	/*
+	 * Issue a command to get the number of sensor reported.
+	 * If not supported, check for legacy mode.
+	 */
+	int ret, sensor_count;
+	struct ec_params_motion_sense *params;
+	struct ec_response_motion_sense *resp;
+	struct cros_ec_command *msg;
+	struct cros_ec_device *ec_dev = ec->ec_dev;
+	u8 status;
+
+	msg = kzalloc(sizeof(struct cros_ec_command) +
+			max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->version = 1;
+	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
+	msg->outsize = sizeof(*params);
+	msg->insize = sizeof(*resp);
+
+	params = (struct ec_params_motion_sense *)msg->data;
+	params->cmd = MOTIONSENSE_CMD_DUMP;
+
+	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	if (ret < 0) {
+		sensor_count = ret;
+	} else if (msg->result != EC_RES_SUCCESS) {
+		sensor_count = -EPROTO;
+	} else {
+		resp = (struct ec_response_motion_sense *)msg->data;
+		sensor_count = resp->dump.sensor_count;
+	}
+	kfree(msg);
+
+	/*
+	 * Check legacy mode: Let's find out if sensors are accessible
+	 * via LPC interface.
+	 */
+	if (sensor_count == -EPROTO &&
+	    ec->cmd_offset == 0 &&
+	    ec_dev->cmd_readmem) {
+		ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS,
+				1, &status);
+		if ((ret >= 0) &&
+		    (status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
+			/*
+			 * We have 2 sensors, one in the lid, one in the base.
+			 */
+			sensor_count = 2;
+		} else {
+			/*
+			 * EC uses LPC interface and no sensors are presented.
+			 */
+			sensor_count = 0;
+		}
+	} else if (sensor_count == -EPROTO) {
+		/* EC responded, but does not understand DUMP command. */
+		sensor_count = 0;
+	}
+	return sensor_count;
+}
+EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 0d4e4aaed37af..f3de0662135d5 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
+#include <linux/mfd/cros_ec.h>
 #include <linux/platform_data/cros_ec_commands.h>
 
 #define CROS_EC_DEV_NAME	"cros_ec"
@@ -213,4 +214,8 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
 
 u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 
+int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
+
+int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
+
 #endif /* __LINUX_CROS_EC_PROTO_H */
-- 
2.23.0.866.gb869b98d4c-goog

