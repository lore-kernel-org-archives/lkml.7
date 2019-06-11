Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93298C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0CA20665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390018AbfFKOFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:05:00 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55679 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387704AbfFKOFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:05:00 -0400
Received: from [167.98.27.226] (helo=happy.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hahOT-0003vU-5W; Tue, 11 Jun 2019 15:04:57 +0100
From:   Michael Drake <michael.drake@codethink.co.uk>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Drake <michael.drake@codethink.co.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
Subject: [PATCH v1 05/11] ti948: Add alive check function using schedule_delayed_work()
Date:   Tue, 11 Jun 2019 15:04:06 +0100
Message-Id: <20190611140412.32151-6-michael.drake@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611140412.32151-1-michael.drake@codethink.co.uk>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simply runs the function once every 5 seconds, while the
device is supposed to be active.  The alive check function is
currently simply a stub, that logs it has been called, and
re-inserts itself into the work queue.

Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Nate Case <ncase@tesla.com>
---
 drivers/gpu/drm/bridge/ti948.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti948.c b/drivers/gpu/drm/bridge/ti948.c
index 9cb37215f049..86daa3701b91 100644
--- a/drivers/gpu/drm/bridge/ti948.c
+++ b/drivers/gpu/drm/bridge/ti948.c
@@ -16,6 +16,7 @@
 
 #include <linux/regulator/consumer.h>
 #include <linux/of_device.h>
+#include <linux/workqueue.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
@@ -25,6 +26,9 @@
 /* Number of times to try checking for device on bringup. */
 #define TI948_DEVICE_ID_TRIES 10
 
+/* Alive check every 5 seconds. */
+#define TI948_ALIVE_CHECK_DELAY (5 * HZ)
+
 /**
  * enum ti948_reg - TI948 registers.
  *
@@ -374,9 +378,27 @@ static inline struct ti948_ctx *ti948_ctx_from_dev(struct device *dev)
 	return i2c_get_clientdata(client);
 }
 
+static inline struct ti948_ctx *delayed_work_to_ti948_ctx(
+		struct delayed_work *dwork)
+{
+	return container_of(dwork, struct ti948_ctx, alive_check);
+}
+
+static void ti948_alive_check(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct ti948_ctx *ti948 = delayed_work_to_ti948_ctx(dwork);
+
+	dev_info(&ti948->i2c->dev, "%s Alive check!\n", __func__);
+
+	/* Reschedule ourself for the next check. */
+	schedule_delayed_work(&ti948->alive_check, TI948_ALIVE_CHECK_DELAY);
+}
+
 static int ti948_pm_resume(struct device *dev)
 {
 	struct ti948_ctx *ti948 = ti948_ctx_from_dev(dev);
+	bool scheduled;
 	int ret;
 
 	if (ti948 == NULL)
@@ -386,7 +408,18 @@ static int ti948_pm_resume(struct device *dev)
 	if (ret != 0)
 		return ret;
 
-	return ti948_write_config_seq(ti948);
+	ret = ti948_write_config_seq(ti948);
+	if (ret != 0)
+		return ret;
+
+	INIT_DELAYED_WORK(&ti948->alive_check, ti948_alive_check);
+
+	scheduled = schedule_delayed_work(
+			&ti948->alive_check, TI948_ALIVE_CHECK_DELAY);
+	if (!scheduled)
+		dev_warn(&ti948->i2c->dev, "Alive check already scheduled\n");
+
+	return 0;
 }
 
 static int ti948_pm_suspend(struct device *dev)
@@ -396,6 +429,8 @@ static int ti948_pm_suspend(struct device *dev)
 	if (ti948 == NULL)
 		return 0;
 
+	cancel_delayed_work_sync(&ti948->alive_check);
+
 	return ti948_power_off(ti948);
 }
 
-- 
2.20.1

