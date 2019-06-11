Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE8AC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7605B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391592AbfFKOFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:05:33 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55736 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390003AbfFKOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:05:02 -0400
Received: from [167.98.27.226] (helo=happy.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hahOU-0003vU-5F; Tue, 11 Jun 2019 15:04:58 +0100
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
Subject: [PATCH v1 07/11] ti948: Add sysfs node for alive attribute
Date:   Tue, 11 Jun 2019 15:04:08 +0100
Message-Id: <20190611140412.32151-8-michael.drake@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611140412.32151-1-michael.drake@codethink.co.uk>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This may be used by userspace to determine the state
of the device.

Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Nate Case <ncase@tesla.com>
---
 drivers/gpu/drm/bridge/ti948.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti948.c b/drivers/gpu/drm/bridge/ti948.c
index b5c766711c4b..b624eaeabb43 100644
--- a/drivers/gpu/drm/bridge/ti948.c
+++ b/drivers/gpu/drm/bridge/ti948.c
@@ -412,6 +412,16 @@ static void ti948_alive_check(struct work_struct *work)
 	schedule_delayed_work(&ti948->alive_check, TI948_ALIVE_CHECK_DELAY);
 }
 
+static ssize_t alive_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct ti948_ctx *ti948 = ti948_ctx_from_dev(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", (unsigned int)ti948->alive);
+}
+
+static DEVICE_ATTR_RO(alive);
+
 static int ti948_pm_resume(struct device *dev)
 {
 	struct ti948_ctx *ti948 = ti948_ctx_from_dev(dev);
@@ -614,17 +624,31 @@ static int ti948_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, ti948);
 
+	ret = device_create_file(&client->dev, &dev_attr_alive);
+	if (ret) {
+		dev_err(&client->dev, "Could not create alive attr\n");
+		return ret;
+	}
+
 	ret = ti948_pm_resume(&client->dev);
-	if (ret != 0)
-		return -EPROBE_DEFER;
+	if (ret != 0) {
+		ret = -EPROBE_DEFER;
+		goto error;
+	}
 
 	dev_info(&ti948->i2c->dev, "End probe (addr: %x)\n", ti948->i2c->addr);
 
 	return 0;
+
+error:
+	device_remove_file(&client->dev, &dev_attr_alive);
+	return ret;
 }
 
 static int ti948_remove(struct i2c_client *client)
 {
+	device_remove_file(&client->dev, &dev_attr_alive);
+
 	return ti948_pm_suspend(&client->dev);
 }
 
-- 
2.20.1

