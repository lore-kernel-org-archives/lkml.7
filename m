Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ADAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80BD2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfLJKGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:06:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55312 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:06:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id BAD12291780
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec: Match implementation with headers
Date:   Tue, 10 Dec 2019 11:06:45 +0100
Message-Id: <20191210100645.12138-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'cros_ec' core driver is the common interface for the cros_ec
transport drivers to do the shared operations to register, unregister,
suspend and resume. The interface is provided by including the header
'include/linux/platform_data/cros_ec_proto.h', however, instead of have
the implementation of these functions in cros_ec_proto.c, it is in
'cros_ec.c', which is a different kernel module. Apart from being a bad
practice, this can induce confusions allowing the users of the cros_ec
protocol to call these functions.

The register, unregister, suspend and resume functions *should* only be
called by the different transport drivers (i2c, spi, lpc, etc.), so make
this a bit less confusing by moving these functions from the public
in-kernel space to a private include in platform/chrome, and then, the
interface for cros_ec module and for the cros_ec_proto module is clean.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec.c           |  2 ++
 drivers/platform/chrome/cros_ec.h           | 25 +++++++++++++++++++++
 drivers/platform/chrome/cros_ec_i2c.c       |  2 ++
 drivers/platform/chrome/cros_ec_ishtp.c     |  2 ++
 drivers/platform/chrome/cros_ec_lpc.c       |  1 +
 drivers/platform/chrome/cros_ec_rpmsg.c     |  2 ++
 drivers/platform/chrome/cros_ec_spi.c       |  2 ++
 include/linux/platform_data/cros_ec_proto.h | 16 -------------
 8 files changed, 36 insertions(+), 16 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec.h

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 6d6ce86a1408..65c3207d2d90 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -18,6 +18,8 @@
 #include <linux/suspend.h>
 #include <asm/unaligned.h>
 
+#include "cros_ec.h"
+
 #define CROS_EC_DEV_EC_INDEX 0
 #define CROS_EC_DEV_PD_INDEX 1
 
diff --git a/drivers/platform/chrome/cros_ec.h b/drivers/platform/chrome/cros_ec.h
new file mode 100644
index 000000000000..dc80550f5eaa
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ChromeOS Embedded Controller core interface.
+ *
+ * Copyright (C) 2012 Google, Inc
+ */
+
+#ifndef __CROS_EC_H
+#define __CROS_EC_H
+
+/*
+ * The EC is unresponsive for a time after a reboot command.  Add a
+ * simple delay to make sure that the bus stays locked.
+ */
+#define EC_REBOOT_DELAY_MS	50
+
+int cros_ec_register(struct cros_ec_device *ec_dev);
+int cros_ec_unregister(struct cros_ec_device *ec_dev);
+
+int cros_ec_suspend(struct cros_ec_device *ec_dev);
+int cros_ec_resume(struct cros_ec_device *ec_dev);
+
+bool cros_ec_handle_event(struct cros_ec_device *ec_dev);
+
+#endif /* __CROS_EC_H */
diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index 9bd97bc8454b..6119eccd8a18 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -14,6 +14,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include "cros_ec.h"
+
 /**
  * Request format for protocol v3
  * byte 0	0xda (EC_COMMAND_PROTOCOL_3)
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index e5996821d08b..e1fdb491a9a7 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -14,6 +14,8 @@
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/intel-ish-client-if.h>
 
+#include "cros_ec.h"
+
 /*
  * ISH TX/RX ring buffer pool size
  *
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index dccf479c6625..3e8ddd84bc41 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -23,6 +23,7 @@
 #include <linux/printk.h>
 #include <linux/suspend.h>
 
+#include "cros_ec.h"
 #include "cros_ec_lpc_mec.h"
 
 #define DRV_NAME "cros_ec_lpcs"
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index bd068afe43b5..dbc3f5523b83 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -13,6 +13,8 @@
 #include <linux/rpmsg.h>
 #include <linux/slab.h>
 
+#include "cros_ec.h"
+
 #define EC_MSG_TIMEOUT_MS	200
 #define HOST_COMMAND_MARK	1
 #define HOST_EVENT_MARK		2
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index a831bd5a5b2f..46786d2d679a 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -14,6 +14,8 @@
 #include <linux/spi/spi.h>
 #include <uapi/linux/sched/types.h>
 
+#include "cros_ec.h"
+
 /* The header byte, which follows the preamble */
 #define EC_MSG_HEADER			0xec
 
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 119b9951c055..f490e208540a 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -21,12 +21,6 @@
 #define CROS_EC_DEV_SCP_NAME	"cros_scp"
 #define CROS_EC_DEV_TP_NAME	"cros_tp"
 
-/*
- * The EC is unresponsive for a time after a reboot command.  Add a
- * simple delay to make sure that the bus stays locked.
- */
-#define EC_REBOOT_DELAY_MS		50
-
 /*
  * Max bus-specific overhead incurred by request/responses.
  * I2C requires 1 additional byte for requests.
@@ -206,10 +200,6 @@ struct cros_ec_dev {
 
 #define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
 
-int cros_ec_suspend(struct cros_ec_device *ec_dev);
-
-int cros_ec_resume(struct cros_ec_device *ec_dev);
-
 int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 		       struct cros_ec_command *msg);
 
@@ -222,10 +212,6 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg);
 
-int cros_ec_register(struct cros_ec_device *ec_dev);
-
-int cros_ec_unregister(struct cros_ec_device *ec_dev);
-
 int cros_ec_query_all(struct cros_ec_device *ec_dev);
 
 int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
@@ -238,8 +224,6 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
 
 int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
 
-bool cros_ec_handle_event(struct cros_ec_device *ec_dev);
-
 /**
  * cros_ec_get_time_ns() - Return time in ns.
  *
-- 
2.20.1

