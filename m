Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E867C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525AF2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RwI3FCTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfEBWyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 18:54:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39347 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:54:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so1854426pfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 15:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l64/bY1LxWfLDdKRyx3HvfnrnrE3pPmc5ecC8BHS8F8=;
        b=RwI3FCTdhPlmT+vMtbOwvhHezJhcz6S3wikgsAnwkzLmQ+9lRGGWZfnNLQ7JOD3f3V
         O618Ee2olbH1vL5uLwrwyxrNnp/TRnW88UEo6BeI7bB6wvtvXpGkZYd/9QPsiyrQWmTc
         S0/rHacmhEwblVNjhViOt5F8O/gOx/K3I45VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l64/bY1LxWfLDdKRyx3HvfnrnrE3pPmc5ecC8BHS8F8=;
        b=GvH5ADHIn0GJk2H2gtNtE6URfK8U3wzuG+ok9vGR/z1pHze4IjUzGocDTpr/ijMjrr
         ZqH91o6gquSkhEkz+4Ksj6nudmgCxAaiwp791f43RlWwWa5ykKXFG5Oqr0DbdIqfyJfJ
         43T0L/FMJN1JMsKS8ERw0nj1f6FUmQRPHDLfjarIJOx7ZAcZ/NQdLrc4qIuhZi2lXDq+
         eMZS+478J1LiXM/JGSXvdpVJDWTBZPAg84yWZONvXWx/M+yjFPz5CQ3EIuQzJdR2RtCt
         TQ4YtScAXS48jTMLRV3hCKPzideRPcUiEhgws5ck3oa2hKY4JiSxzx9I2ScnxvV79b8I
         9VeQ==
X-Gm-Message-State: APjAAAXaD5M4VQi73QXwG+VsKeVY/8RBhou199jxxW7j0kYhoTfyZrBL
        7izFHrz8KnRVsIeUehtF7NFsBQ==
X-Google-Smtp-Source: APXvYqw76PWYSXX61eOhftbcTudFyvpDPm4S/i4gNcHsWTvjZHUKRbeYb0d9ibyOWF51AFQB+grXKg==
X-Received: by 2002:a63:f707:: with SMTP id x7mr6521431pgh.343.1556837665388;
        Thu, 02 May 2019 15:54:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v15sm264736pff.105.2019.05.02.15.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 15:54:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 2/5] drm/bridge/synopsys: dw-hdmi: Add "unwedge" for ddc bus
Date:   Thu,  2 May 2019 15:53:33 -0700
Message-Id: <20190502225336.206885-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190502225336.206885-1-dianders@chromium.org>
References: <20190502225336.206885-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See the PhD thesis in the comments in this patch for details, but to
summarize this adds a hacky "unwedge" feature to the dw_hdmi i2c bus to
workaround what appears to be a hardware errata.  This relies on a
pinctrl entry to help change around muxing to perform the unwedge.

NOTE that the specific TV this was tested on was the "Samsung
UN40HU6950FXZA" and the specific port was the "STB" port.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 116 +++++++++++++++++++---
 1 file changed, 100 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index db761329a1e3..c66587e33813 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -19,6 +19,7 @@
 #include <linux/hdmi.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/regmap.h>
 #include <linux/spinlock.h>
 
@@ -169,6 +170,10 @@ struct dw_hdmi {
 	bool sink_is_hdmi;
 	bool sink_has_audio;
 
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *default_state;
+	struct pinctrl_state *unwedge_state;
+
 	struct mutex mutex;		/* for state below and previous_mode */
 	enum drm_connector_force force;	/* mutex-protected force state */
 	bool disabled;			/* DRM has disabled our bridge */
@@ -247,11 +252,82 @@ static void dw_hdmi_i2c_init(struct dw_hdmi *hdmi)
 		    HDMI_IH_MUTE_I2CM_STAT0);
 }
 
+static bool dw_hdmi_i2c_unwedge(struct dw_hdmi *hdmi)
+{
+	/* If no unwedge state then give up */
+	if (IS_ERR(hdmi->unwedge_state))
+		return false;
+
+	dev_info(hdmi->dev, "Attempting to unwedge stuck i2c bus\n");
+
+	/*
+	 * This is a huge hack to workaround a problem where the dw_hdmi i2c
+	 * bus could sometimes get wedged.  Once wedged there doesn't appear
+	 * to be any way to unwedge it (including the HDMI_I2CM_SOFTRSTZ)
+	 * other than pulsing the SDA line.
+	 *
+	 * We appear to be able to pulse the SDA line (in the eyes of dw_hdmi)
+	 * by:
+	 * 1. Remux the pin as a GPIO output, driven low.
+	 * 2. Wait a little while.  1 ms seems to work, but we'll do 10.
+	 * 3. Immediately jump to remux the pin as dw_hdmi i2c again.
+	 *
+	 * At the moment of remuxing, the line will still be low due to its
+	 * recent stint as an output, but then it will be pulled high by the
+	 * (presumed) external pullup.  dw_hdmi seems to see this as a rising
+	 * edge and that seems to get it out of its jam.
+	 *
+	 * This wedging was only ever seen on one TV, and only on one of
+	 * its HDMI ports.  It happened when the TV was powered on while the
+	 * device was plugged in.  A scope trace shows the TV bringing both SDA
+	 * and SCL low, then bringing them both back up at roughly the same
+	 * time.  Presumably this confuses dw_hdmi because it saw activity but
+	 * no real STOP (maybe it thinks there's another master on the bus?).
+	 * Giving it a clean rising edge of SDA while SCL is already high
+	 * presumably makes dw_hdmi see a STOP which seems to bring dw_hdmi out
+	 * of its stupor.
+	 *
+	 * Note that after coming back alive, transfers seem to immediately
+	 * resume, so if we unwedge due to a timeout we should wait a little
+	 * longer for our transfer to finish, since it might have just started
+	 * now.
+	 */
+	pinctrl_select_state(hdmi->pinctrl, hdmi->unwedge_state);
+	msleep(10);
+	pinctrl_select_state(hdmi->pinctrl, hdmi->default_state);
+
+	return true;
+}
+
+static int dw_hdmi_i2c_wait(struct dw_hdmi *hdmi)
+{
+	struct dw_hdmi_i2c *i2c = hdmi->i2c;
+	int stat;
+
+	stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
+	if (!stat) {
+		/* If we can't unwedge, return timeout */
+		if (!dw_hdmi_i2c_unwedge(hdmi))
+			return -EAGAIN;
+
+		/* We tried to unwedge; give it another chance */
+		stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
+		if (!stat)
+			return -EAGAIN;
+	}
+
+	/* Check for error condition on the bus */
+	if (i2c->stat & HDMI_IH_I2CM_STAT0_ERROR)
+		return -EIO;
+
+	return 0;
+}
+
 static int dw_hdmi_i2c_read(struct dw_hdmi *hdmi,
 			    unsigned char *buf, unsigned int length)
 {
 	struct dw_hdmi_i2c *i2c = hdmi->i2c;
-	int stat;
+	int ret;
 
 	if (!i2c->is_regaddr) {
 		dev_dbg(hdmi->dev, "set read register address to 0\n");
@@ -270,13 +346,9 @@ static int dw_hdmi_i2c_read(struct dw_hdmi *hdmi,
 			hdmi_writeb(hdmi, HDMI_I2CM_OPERATION_READ,
 				    HDMI_I2CM_OPERATION);
 
-		stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
-		if (!stat)
-			return -EAGAIN;
-
-		/* Check for error condition on the bus */
-		if (i2c->stat & HDMI_IH_I2CM_STAT0_ERROR)
-			return -EIO;
+		ret = dw_hdmi_i2c_wait(hdmi);
+		if (ret)
+			return ret;
 
 		*buf++ = hdmi_readb(hdmi, HDMI_I2CM_DATAI);
 	}
@@ -289,7 +361,7 @@ static int dw_hdmi_i2c_write(struct dw_hdmi *hdmi,
 			     unsigned char *buf, unsigned int length)
 {
 	struct dw_hdmi_i2c *i2c = hdmi->i2c;
-	int stat;
+	int ret;
 
 	if (!i2c->is_regaddr) {
 		/* Use the first write byte as register address */
@@ -307,13 +379,9 @@ static int dw_hdmi_i2c_write(struct dw_hdmi *hdmi,
 		hdmi_writeb(hdmi, HDMI_I2CM_OPERATION_WRITE,
 			    HDMI_I2CM_OPERATION);
 
-		stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
-		if (!stat)
-			return -EAGAIN;
-
-		/* Check for error condition on the bus */
-		if (i2c->stat & HDMI_IH_I2CM_STAT0_ERROR)
-			return -EIO;
+		ret = dw_hdmi_i2c_wait(hdmi);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -2606,6 +2674,22 @@ __dw_hdmi_probe(struct platform_device *pdev,
 
 	/* If DDC bus is not specified, try to register HDMI I2C bus */
 	if (!hdmi->ddc) {
+		/* Look for (optional) stuff related to unwedging */
+		hdmi->pinctrl = devm_pinctrl_get(dev);
+		if (!IS_ERR(hdmi->pinctrl)) {
+			hdmi->unwedge_state =
+				pinctrl_lookup_state(hdmi->pinctrl, "unwedge");
+			hdmi->default_state =
+				pinctrl_lookup_state(hdmi->pinctrl, "default");
+
+			if (IS_ERR(hdmi->default_state) &&
+			    !IS_ERR(hdmi->unwedge_state)) {
+				dev_warn(dev,
+					 "Unwedge requires default pinctrl\n");
+				hdmi->unwedge_state = ERR_PTR(-ENODEV);
+			}
+		}
+
 		hdmi->ddc = dw_hdmi_i2c_adapter(hdmi);
 		if (IS_ERR(hdmi->ddc))
 			hdmi->ddc = NULL;
-- 
2.21.0.1020.gf2820cf01a-goog

