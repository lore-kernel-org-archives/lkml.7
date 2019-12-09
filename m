Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C50C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FF2206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byl0tHTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfLIFJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 00:09:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34943 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfLIFJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 00:09:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so6587820pfo.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 21:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XEcja4j0Y7wjAXUdzpkpUFGjQtVSvVgIR5k+TIOO3A=;
        b=Byl0tHTW1y0U1nhXhbir9SOQQUeoUvfSopB4RAvpD3us/55LRl2d2XvYDcEkv2YoQt
         gYDAvtunNSXfWf3T1WsWB6Ufg28MFe0a0BZElON27SPZiDDb/rIlRZnUhTg4zbt+kJDQ
         HPjDy8jXUS8+86QGGTuyo1wDwzYk1YBQ7Tl9kgVXwPDRAQCJdUtpbNnkLvIL4PfkjH0x
         0m7GmwAbyKQKt7b6hJuy/XQKdgI1NWARM4UqHsMzt5JOIM+H/bnIqQTh+RConkfOGNAB
         GScPalGMLvGANYC4pjyrvBkPeSN0YE9+92jDi/ppSRyMy7x5I8NCAa1/IbtJ4+MRhyz/
         BPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XEcja4j0Y7wjAXUdzpkpUFGjQtVSvVgIR5k+TIOO3A=;
        b=PBxx7e0i+bU07zxSj86DNv3mlK5Z3Ezym7rSeXLZMUnwnKKMj6QoVQqC16Y9BWvzZJ
         5qd7mEKAjnNm+xyE0WRe7naKiWM+hcRVtjNWjvErZVi5V1IuZuecJIjCSwa2C393UPFR
         cxZgVAsbn3NPKoqc7TqI9g1jPWIsxLLLJ1CBRfiVQXB8TlQBo7b451bCJ/GdQN14knjR
         bPARliS9T3uySjrboJjm9oM4dbZhhDDd2T5vqzRUg8uTTyseXB2zT3dPFmSxEFmEwJ7t
         Yqpi0dfilv7wceGA5Zq4Rq8GGae5qr5khuBCHyEXxTzrGbvDZR5Su+c/6X0yREbjUzmY
         Y7+A==
X-Gm-Message-State: APjAAAWyPKtCNUUqMag5wsiXU+3jXd7mnd3QtyUIyBES6cDU1tPabfox
        iFY1e9LlE6oeT2t86VNGCW0=
X-Google-Smtp-Source: APXvYqwajQf/Bi8UAd63eQFE7lsxK1wBbKgiKULZAysTm170wg2Z4MW+U4HqpikvYcXF2/agV8Hvcw==
X-Received: by 2002:a62:2a12:: with SMTP id q18mr3738243pfq.203.1575868145350;
        Sun, 08 Dec 2019 21:09:05 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id k15sm25752119pfg.37.2019.12.08.21.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 21:09:04 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] drm/bridge: tc358767: Expose test mode functionality via debugfs
Date:   Sun,  8 Dec 2019 21:08:57 -0800
Message-Id: <20191209050857.31624-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191209050857.31624-1-andrew.smirnov@gmail.com>
References: <20191209050857.31624-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently, the driver code artificially limits test pattern mode to a
single pattern with fixed color selection. It being a kernel module
parameter makes switching "test pattern" <-> "proper output" modes
on-the-fly clunky and outright impossible if the driver is built into
the kernel.

To improve the situation a bit, convert current test pattern code to
use debugfs instead by exposing "TestCtl" register. This way old
"tc_test_pattern=1" functionality can be emulated via:

    echo -n 0x78146302 > tstctl

and switch back to regular mode can be done with:

    echo -n 0x78146300 > tstctl

Note that switching to any of the test patterns, will NOT trigger link
re-establishment whereas switching to normal operation WILL. This is
done so:

a) we can isolate and verify (e)DP link functionality by switching to
   one of the test patters

b) trigger a link re-establishment by switching back to normal mode

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 152 ++++++++++++++++++++++++------
 1 file changed, 125 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 3c252ae0ee6f..12a8829e0ed1 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -17,6 +17,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -221,11 +222,10 @@
 #define COLOR_B			GENMASK(15, 8)
 #define ENI2CFILTER		BIT(4)
 #define COLOR_BAR_MODE		GENMASK(1, 0)
+#define COLOR_BAR_MODE_NORMAL	0
 #define COLOR_BAR_MODE_BARS	2
-#define PLL_DBG			0x0a04
 
-static bool tc_test_pattern;
-module_param_named(test, tc_test_pattern, bool, 0644);
+#define PLL_DBG			0x0a04
 
 struct tc_edp_link {
 	struct drm_dp_link	base;
@@ -263,6 +263,9 @@ struct tc_data {
 
 	/* HPD pin number (0 or 1) or -ENODEV */
 	int			hpd_pin;
+
+	struct mutex		tstctl_lock;
+	bool			enabled;
 };
 
 static inline struct tc_data *aux_to_tc(struct drm_dp_aux *a)
@@ -791,16 +794,6 @@ static int tc_set_video_mode(struct tc_data *tc,
 	if (ret)
 		return ret;
 
-	/* Test pattern settings */
-	ret = regmap_write(tc->regmap, TSTCTL,
-			   FIELD_PREP(COLOR_R, 120) |
-			   FIELD_PREP(COLOR_G, 20) |
-			   FIELD_PREP(COLOR_B, 99) |
-			   ENI2CFILTER |
-			   FIELD_PREP(COLOR_BAR_MODE, COLOR_BAR_MODE_BARS));
-	if (ret)
-		return ret;
-
 	/* DP Main Stream Attributes */
 	vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
 	ret = regmap_write(tc->regmap, DP0_VIDSYNCDELAY,
@@ -1152,14 +1145,6 @@ static int tc_stream_enable(struct tc_data *tc)
 
 	dev_dbg(tc->dev, "enable video stream\n");
 
-	/* PXL PLL setup */
-	if (tc_test_pattern) {
-		ret = tc_pxl_pll_en(tc, clk_get_rate(tc->refclk),
-				    1000 * tc->mode.clock);
-		if (ret)
-			return ret;
-	}
-
 	ret = tc_set_video_mode(tc, &tc->mode);
 	if (ret)
 		return ret;
@@ -1188,12 +1173,8 @@ static int tc_stream_enable(struct tc_data *tc)
 	if (ret)
 		return ret;
 	/* Set input interface */
-	value = DP0_AUDSRC_NO_INPUT;
-	if (tc_test_pattern)
-		value |= DP0_VIDSRC_COLOR_BAR;
-	else
-		value |= DP0_VIDSRC_DPI_RX;
-	ret = regmap_write(tc->regmap, SYSCTRL, value);
+	ret = regmap_write(tc->regmap, SYSCTRL,
+			   DP0_AUDSRC_NO_INPUT | DP0_VIDSRC_DPI_RX);
 	if (ret)
 		return ret;
 
@@ -1252,8 +1233,13 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 {
 	struct tc_data *tc = bridge_to_tc(bridge);
 
+	mutex_lock(&tc->tstctl_lock);
+
 	if (!__tc_bridge_enable(tc))
 		drm_panel_enable(tc->panel);
+
+	tc->enabled = true;
+	mutex_unlock(&tc->tstctl_lock);
 }
 
 static int __tc_bridge_disable(struct tc_data *tc)
@@ -1275,8 +1261,13 @@ static void tc_bridge_disable(struct drm_bridge *bridge)
 {
 	struct tc_data *tc = bridge_to_tc(bridge);
 
+	mutex_lock(&tc->tstctl_lock);
+
 	drm_panel_disable(tc->panel);
 	__tc_bridge_disable(tc);
+
+	tc->enabled = false;
+	mutex_unlock(&tc->tstctl_lock);
 }
 
 static void tc_bridge_post_disable(struct drm_bridge *bridge)
@@ -1388,6 +1379,99 @@ static enum drm_connector_status tc_connector_detect(struct drm_connector *conne
 		return connector_status_disconnected;
 }
 
+static int tc_tstctl_set(void *data, u64 val)
+{
+	struct tc_data *tc = data;
+	int ret;
+
+	mutex_lock(&tc->tstctl_lock);
+
+	if (!tc->enabled) {
+		dev_err(tc->dev, "bridge needs to be enabled first\n");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (FIELD_GET(COLOR_BAR_MODE, val) == COLOR_BAR_MODE_NORMAL) {
+		ret = regmap_write(tc->regmap, SYSCTRL, DP0_VIDSRC_DPI_RX);
+		if (ret) {
+			dev_err(tc->dev,
+				"failed to select dpi video stream\n");
+			goto unlock;
+		}
+
+		ret = regmap_write(tc->regmap, TSTCTL, val | ENI2CFILTER);
+		if (ret) {
+			dev_err(tc->dev, "failed to set TSTCTL\n");
+			goto unlock;
+		}
+
+		ret = tc_pxl_pll_dis(tc);
+		if (ret) {
+			dev_err(tc->dev, "failed to disable PLL\n");
+			goto unlock;
+		}
+
+		/*
+		 * Re-establish DP link
+		 */
+		ret = __tc_bridge_disable(tc);
+		if (ret)
+			goto unlock;
+
+		ret = __tc_bridge_enable(tc);
+		if (ret)
+			goto unlock;
+	} else {
+		ret = tc_pxl_pll_en(tc, clk_get_rate(tc->refclk),
+				    1000 * tc->mode.clock);
+		if (ret) {
+			dev_err(tc->dev, "failed to enable PLL\n");
+			goto unlock;
+		}
+
+		ret = regmap_write(tc->regmap, TSTCTL, val | ENI2CFILTER);
+		if (ret) {
+			dev_err(tc->dev, "failed to set TSTCTL\n");
+			goto unlock;
+		}
+
+		ret = regmap_write(tc->regmap, SYSCTRL, DP0_VIDSRC_COLOR_BAR);
+		if (ret) {
+			dev_err(tc->dev, "failed to set SYSCTRL\n");
+			goto unlock;
+		}
+	}
+
+unlock:
+	mutex_unlock(&tc->tstctl_lock);
+	return ret;
+}
+/*
+ * "tstctl" attribute has the following format:
+ *
+ *     RR_GG_BB_0_P
+ *
+ * "RR" is red, "GG" is green and "BB" is blue color components (byte
+ * each) used for various test patterns controlled by this register.
+ *
+ * "P" represents test pattern of the bridge. Valid values are:
+ *
+ *    "0" - normal operation
+ *    "1" - solid color test pattern
+ *    "2" - color bar test pattern
+ *    "3" - "checkers" test pattern
+ *
+ * This way old "tc_test_pattern=1" functionality can be emulated via:
+ *
+ *     echo -n 0x78146302 > tstctl
+ *
+ * and switch back to regular mode can be done with:
+ *
+ *     echo -n 0 > tstctl
+ */
+DEFINE_SIMPLE_ATTRIBUTE(tc_tstctl_fops, NULL, tc_tstctl_set, "%llu\n");
+
 static const struct drm_connector_funcs tc_connector_funcs = {
 	.detect = tc_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
@@ -1530,9 +1614,15 @@ static irqreturn_t tc_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void tc_remove_debugfs(void *data)
+{
+	debugfs_remove_recursive(data);
+}
+
 static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
+	struct dentry *debugfs;
 	struct tc_data *tc;
 	int ret;
 
@@ -1541,6 +1631,7 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -ENOMEM;
 
 	tc->dev = dev;
+	mutex_init(&tc->tstctl_lock);
 
 	/* port@2 is the output port */
 	ret = drm_of_find_panel_or_bridge(dev->of_node, 2, 0, &tc->panel, NULL);
@@ -1671,6 +1762,13 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	i2c_set_clientdata(client, tc);
 
+	debugfs = debugfs_create_dir(dev_name(dev), NULL);
+	if (!IS_ERR(debugfs)) {
+		debugfs_create_file_unsafe("tstctl", 0200, debugfs, tc,
+					   &tc_tstctl_fops);
+		devm_add_action_or_reset(dev, tc_remove_debugfs, debugfs);
+	}
+
 	return 0;
 }
 
-- 
2.21.0

