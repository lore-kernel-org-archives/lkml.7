Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584DCC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3673F20665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391598AbfFKOFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:05:36 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55721 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389902AbfFKOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:05:01 -0400
Received: from [167.98.27.226] (helo=happy.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hahOT-0003vU-LT; Tue, 11 Jun 2019 15:04:57 +0100
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
Subject: [PATCH v1 06/11] ti948: Reconfigure in the alive check when device returns
Date:   Tue, 11 Jun 2019 15:04:07 +0100
Message-Id: <20190611140412.32151-7-michael.drake@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611140412.32151-1-michael.drake@codethink.co.uk>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the alive check detects a transition to the alive state,
the device configuration is rewritten.

Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Nate Case <ncase@tesla.com>
---
 drivers/gpu/drm/bridge/ti948.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti948.c b/drivers/gpu/drm/bridge/ti948.c
index 86daa3701b91..b5c766711c4b 100644
--- a/drivers/gpu/drm/bridge/ti948.c
+++ b/drivers/gpu/drm/bridge/ti948.c
@@ -132,6 +132,8 @@ struct ti948_reg_val {
  * @reg_names:   Array of regulator names, or NULL.
  * @regs:        Array of regulators, or NULL.
  * @reg_count:   Number of entries in reg_names and regs arrays.
+ * @alive_check: Context for the alive checking work item.
+ * @alive:       Whether the device is alive or not (alive_check).
  */
 struct ti948_ctx {
 	struct i2c_client *i2c;
@@ -141,6 +143,8 @@ struct ti948_ctx {
 	const char **reg_names;
 	struct regulator **regs;
 	size_t reg_count;
+	struct delayed_work alive_check;
+	bool alive;
 };
 
 static bool ti948_readable_reg(struct device *dev, unsigned int reg)
@@ -346,6 +350,8 @@ static int ti948_power_on(struct ti948_ctx *ti948)
 	if (ret != 0)
 		return ret;
 
+	ti948->alive = true;
+
 	msleep(500);
 
 	return 0;
@@ -356,6 +362,8 @@ static int ti948_power_off(struct ti948_ctx *ti948)
 	int i;
 	int ret;
 
+	ti948->alive = false;
+
 	for (i = ti948->reg_count; i > 0; i--) {
 		dev_info(&ti948->i2c->dev, "Disabling %s regulator\n",
 				ti948->reg_names[i - 1]);
@@ -388,8 +396,17 @@ static void ti948_alive_check(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct ti948_ctx *ti948 = delayed_work_to_ti948_ctx(dwork);
+	int ret = ti948_device_check(ti948);
 
-	dev_info(&ti948->i2c->dev, "%s Alive check!\n", __func__);
+	if (ti948->alive == false && ret == 0) {
+		dev_info(&ti948->i2c->dev, "Device has come back to life!\n");
+		ti948_write_config_seq(ti948);
+		ti948->alive = true;
+
+	} else if (ti948->alive == true && ret != 0) {
+		dev_info(&ti948->i2c->dev, "Device has stopped responding\n");
+		ti948->alive = false;
+	}
 
 	/* Reschedule ourself for the next check. */
 	schedule_delayed_work(&ti948->alive_check, TI948_ALIVE_CHECK_DELAY);
-- 
2.20.1

