Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A02AC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1348820989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfDERdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:33:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35930 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731667AbfDERdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:33:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B414E2822B2
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com,
        Vincent Palatin <vpalatin@chromium.org>
Subject: [PATCH v2 3/4] mfd: cros_ec: instantiate properly CrOS FP MCU device
Date:   Fri,  5 Apr 2019 19:33:23 +0200
Message-Id: <20190405173324.22118-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405173324.22118-1-enric.balletbo@collabora.com>
References: <20190405173324.22118-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Fingerprint MCU as a special of CrOS EC devices. The current FP
MCU uses the same EC SPI protocol v3 as other CrOS EC devices on a SPI
bus.

When a MCU has fingerprint support (aka EC_FEATURE_FINGERPRINT), it is
instantiated as a special CrOS EC device with device name 'cros_fp'. So
regardless of the probing order between the actual cros_ec and cros_fp,
the userspace and other kernel drivers should not confuse them.

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2: None

 drivers/mfd/cros_ec_dev.c   | 10 ++++++++++
 include/linux/mfd/cros_ec.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 1daccd4e05a3..79746e817cdb 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -636,6 +636,16 @@ static int ec_device_probe(struct platform_device *pdev)
 	device_initialize(&ec->class_dev);
 	cdev_init(&ec->cdev, &fops);
 
+	/* Check whether this is actually a Fingerprint MCU rather than an EC */
+	if (cros_ec_check_features(ec, EC_FEATURE_FINGERPRINT)) {
+		dev_info(dev, "CrOS Fingerprint MCU detected.\n");
+		/*
+		 * Help userspace differentiating ECs from FP MCU,
+		 * regardless of the probing order.
+		 */
+		ec_platform->ec_name = CROS_EC_DEV_FP_NAME;
+	}
+
 	/*
 	 * Check whether this is actually an Integrated Sensor Hub (ISH)
 	 * rather than an EC.
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index ce50628aa5e7..b393bd4e4b73 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -23,6 +23,7 @@
 #include <linux/mutex.h>
 
 #define CROS_EC_DEV_NAME	"cros_ec"
+#define CROS_EC_DEV_FP_NAME	"cros_fp"
 #define CROS_EC_DEV_ISH_NAME	"cros_ish"
 #define CROS_EC_DEV_PD_NAME	"cros_pd"
 
-- 
2.20.1

