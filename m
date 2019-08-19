Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408D5C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EC120851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8VhKBhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfHSLWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:22:15 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:48635 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfHSLWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:22:15 -0400
Received: by mail-vk1-f202.google.com with SMTP id l3so1583498vkb.15
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H/qRm0Yv2WT0Tluo2TlSkwY77ERd+Um9aUJHvVBJ2fw=;
        b=u8VhKBhlHqKqYfg6lM/w3mVeWIY44O6IfRohtApAdl6OBvYKXlsy/wbP7e8vHYSWQQ
         yma1g+6vdVH1md0h+yIF+OMBGA9IbdbueZIBr6ouEOBUffhpzRsu4MAFtRmxG955NxCA
         kd/bGoC9QEU428qzg/v2PLXz/dTyj8x2wDon6pAvNYYZw5Bsw/tHqSr9yZ+NrSMm2lTj
         1JvdxkhOn2/pw1K2HpsfUFXJwuwai6Sd5nqLtlOGbcTYDWe4ByY7qxAsWccomN1mH+zq
         WZMaVbiN25Po4vSVWMkKM7krlNvkDI53kcIpl+93+ivMXgapu3fiv91ZT43uLCeZpjWg
         OYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H/qRm0Yv2WT0Tluo2TlSkwY77ERd+Um9aUJHvVBJ2fw=;
        b=J2k2BMnRC6ZshXnrcvfWJsoCAI6eJb89x5+ZfEdzU/elFzXPpjscIXlk0ph+Q/J/iU
         +RvDbzKdkNdSGaOURfBD9ADFifWyDgPe7aGNB6I10FE/3lNoqYEYJIouSLcShlFGiJ5w
         s6y5N5YSiEVGXc89A0fY1Y+XeOcS/94dvGBV/ZhiGQUQRDGamD6NAXVc1UYZ+vLjvZvE
         YGlAn3c5J0H9uwyfNG/o4KVC9rA63HGpAF+KNKnpfFBW5vfT8iX2hzoSGG0L/pLaCBvz
         3fJJh8vhQWu5PAExstG5f+7at7U9CGEWJLEa0w6W6CMFYFXoEowiSXOvJALRO3SawDLg
         abTA==
X-Gm-Message-State: APjAAAXTJeBdQVk+WCBGzZzXrru6Brc5zeNMAPMR7LhH9nxt18W+NDNC
        SCpnSw3TSMtD8zNqsMq/irzdADXmj04=
X-Google-Smtp-Source: APXvYqxqRO5dF/oI9Clv70/0w+1bLnMh3sTTb9xj5rcbM6BRl2dQUEvm3JnRSUNaVlSTo5mHkCdghtvcaNw=
X-Received: by 2002:ab0:7c3:: with SMTP id d3mr13166295uaf.131.1566213733887;
 Mon, 19 Aug 2019 04:22:13 -0700 (PDT)
Date:   Mon, 19 Aug 2019 13:22:06 +0200
In-Reply-To: <20190814104520.6001-6-darekm@google.com>
Message-Id: <20190819112207.57166-1-darekm@google.com>
Mime-Version: 1.0
References: <20190814104520.6001-6-darekm@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v7.1 5/9] drm: tda998x: use cec_notifier_conn_(un)register
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     Dariusz Marcinkiewicz <darekm@google.com>,
        Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new cec_notifier_conn_(un)register() functions to
(un)register the notifier for the HDMI connector, and fill
in the cec_connector_info.

Changes since v7:
	- typo fix
Changes since v6:
        - move cec_notifier_conn_unregister to tda998x_bridge_detach,
	- add a mutex protecting accesses to a CEC notifier.
Changes since v2:
	- cec_notifier_phys_addr_invalidate where appropriate,
	- don't check for NULL notifier before calling
	cec_notifier_conn_unregister.
Changes since v1:
	Add memory barrier to make sure that the notifier
	becomes visible to the irq thread once it is
	fully constructed.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 36 +++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 61e042918a7fc..c6e922cd3c0b5 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -82,6 +82,8 @@ struct tda998x_priv {
 	u8 audio_port_enable[AUDIO_ROUTE_NUM];
 	struct tda9950_glue cec_glue;
 	struct gpio_desc *calib;
+
+	struct mutex cec_notify_mutex;
 	struct cec_notifier *cec_notify;
 };
 
@@ -805,8 +807,11 @@ static irqreturn_t tda998x_irq_thread(int irq, void *data)
 				tda998x_edid_delay_start(priv);
 			} else {
 				schedule_work(&priv->detect_work);
-				cec_notifier_set_phys_addr(priv->cec_notify,
-						   CEC_PHYS_ADDR_INVALID);
+
+				mutex_lock(&priv->cec_notify_mutex);
+				cec_notifier_phys_addr_invalidate(
+						priv->cec_notify);
+				mutex_unlock(&priv->cec_notify_mutex);
 			}
 
 			handled = true;
@@ -1331,6 +1336,8 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 				  struct drm_device *drm)
 {
 	struct drm_connector *connector = &priv->connector;
+	struct cec_connector_info conn_info;
+	struct cec_notifier *notifier;
 	int ret;
 
 	connector->interlace_allowed = 1;
@@ -1347,6 +1354,16 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 	if (ret)
 		return ret;
 
+	cec_fill_conn_info_from_drm(&conn_info, connector);
+
+	notifier = cec_notifier_conn_register(priv->cec_glue.parent,
+					      NULL, &conn_info);
+		return -ENOMEM;
+
+	mutex_lock(&priv->cec_notify_mutex);
+	priv->cec_notify = notifier;
+	mutex_unlock(&priv->cec_notify_mutex);
+
 	drm_connector_attach_encoder(&priv->connector,
 				     priv->bridge.encoder);
 
@@ -1366,6 +1383,11 @@ static void tda998x_bridge_detach(struct drm_bridge *bridge)
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
 
+	mutex_lock(&priv->cec_notify_mutex);
+	cec_notifier_conn_unregister(priv->cec_notify);
+	priv->cec_notify = NULL;
+	mutex_unlock(&priv->cec_notify_mutex);
+
 	drm_connector_cleanup(&priv->connector);
 }
 
@@ -1789,9 +1811,6 @@ static void tda998x_destroy(struct device *dev)
 	cancel_work_sync(&priv->detect_work);
 
 	i2c_unregister_device(priv->cec);
-
-	if (priv->cec_notify)
-		cec_notifier_put(priv->cec_notify);
 }
 
 static int tda998x_create(struct device *dev)
@@ -1812,6 +1831,7 @@ static int tda998x_create(struct device *dev)
 	mutex_init(&priv->mutex);	/* protect the page access */
 	mutex_init(&priv->audio_mutex); /* protect access from audio thread */
 	mutex_init(&priv->edid_mutex);
+	mutex_init(&priv->cec_notify_mutex);
 	INIT_LIST_HEAD(&priv->bridge.list);
 	init_waitqueue_head(&priv->edid_delay_waitq);
 	timer_setup(&priv->edid_delay_timer, tda998x_edid_delay_done, 0);
@@ -1916,12 +1936,6 @@ static int tda998x_create(struct device *dev)
 		cec_write(priv, REG_CEC_RXSHPDINTENA, CEC_RXSHPDLEV_HPD);
 	}
 
-	priv->cec_notify = cec_notifier_get(dev);
-	if (!priv->cec_notify) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-
 	priv->cec_glue.parent = dev;
 	priv->cec_glue.data = priv;
 	priv->cec_glue.init = tda998x_cec_hook_init;
-- 
2.23.0.rc1.153.gdeed80330f-goog

