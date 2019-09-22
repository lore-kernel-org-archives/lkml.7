Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ED4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846A6206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Www/SClD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbfIVRvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 13:51:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35976 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbfIVRvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 13:51:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so7579631pfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zgK+hVPirfN9H5KHkDj/S/4KoA7AmqlWywx7NCv8Zo=;
        b=Www/SClDmYml8y5bs9EsBchYqqF7LmSenvTIkZpgjVkmujSdj1t0TeJmM+5YIKU87P
         IdjD+DvCfFj3BXBLHSX7jRJ7nECeV/JtWOowXo0wp1xjV2Uxlh7aCn7hlmHcUdFmmCqR
         tqpws8H+SiP2Oa+a/SM6f5FMb//50sDAdXQSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zgK+hVPirfN9H5KHkDj/S/4KoA7AmqlWywx7NCv8Zo=;
        b=ovgOVQ6dxmBrC10+v2zBmlI913QPPRLaVs2lCocll4druKzNa3xIzRI9NKR1k2PRDS
         YyZ5imwHFRK8GrdzARyH2uGVqfeyf6wNDRSxGPhhY4NMXiYZlxMBw9MG+zFjH3pNbQWK
         k0R4GF6RL1QW9p3eb33j9/o0taIiiQeNjgS9tpReAMP3+RCTRBhmTFTJa1b1y6UfGBiE
         bCY1SbP1FnKOxJvsVqTQAZsp4wUV6EOvyTlS3JmxwRoNyJ9MjBrjaWA4u0HMteDCfaEA
         QpPkPRQsm5WOGOOOOSOUsz8FYP1HEjcBFYfoBNdUBNTKSicDihbzX68jS/VJ6UyAZt0P
         AjMg==
X-Gm-Message-State: APjAAAXSe4Vxqj68ajyzwTl9t2WxDO81lYp1IqV1KJn/Nf1TW9pVOxXB
        bkb2nRu6jBbN2wl5aJwq24muyA==
X-Google-Smtp-Source: APXvYqxTclIzIUQ/7AGXk60EER0+9A2qrTaESxBwMR5TDKhSAjMeEEuIWavtHQj9C5Vcr08VFtbtnw==
X-Received: by 2002:a63:285:: with SMTP id 127mr25625535pgc.56.1569174662880;
        Sun, 22 Sep 2019 10:51:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y4sm7557255pjn.19.2019.09.22.10.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 10:51:02 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 01/13] mfd: cros_ec: Add sensor_count and make check_features public
Date:   Sun, 22 Sep 2019 10:50:09 -0700
Message-Id: <20190922175021.53449-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190922175021.53449-1-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
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
to know whant the Embedded Controller supports.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mfd/cros_ec_dev.c   | 61 ++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/cros_ec.h | 17 +++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 6e6dfd6c1871..3be80183ccaa 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -112,7 +112,7 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
 	{ .name = "cros-ec-vbc", }
 };
 
-static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
+int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct cros_ec_command *msg;
 	int ret;
@@ -143,12 +143,71 @@ static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 
 	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
 }
+EXPORT_SYMBOL_GPL(cros_ec_check_features);
 
 static void cros_ec_class_release(struct device *dev)
 {
 	kfree(to_cros_ec_dev(dev));
 }
 
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
+	if (msg == NULL)
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
+		}
+	}
+	return sensor_count;
+}
+EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
+
 static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 {
 	/*
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 61c2875c2a40..578e0bbcafdc 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -32,4 +32,21 @@ struct cros_ec_dev {
 
 #define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
 
+/**
+ * cros_ec_check_features - Test for the presence of EC features
+ *
+ * Call this function to test whether the ChromeOS EC supports a feature.
+ *
+ * @ec_dev: EC device
+ * @msg: One of ec_feature_code values
+ * @return: 1 if supported, 0 if not
+ */
+int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
+
+/*
+ * Return the number of MEMS sensors supported.
+ * Return < 0 in case of error.
+ */
+int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
+
 #endif /* __LINUX_MFD_CROS_EC_H */
-- 
2.23.0.351.gc4317032e6-goog

