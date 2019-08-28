Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5064BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221C1217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="haoiuUv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfH1HPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:15:45 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:45934 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1HPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:15:45 -0400
Received: by mail-yw1-f74.google.com with SMTP id c129so1249168ywf.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pO6G2tJIWIc79GlfXyD7tYRlgpCJ3Wp5sfmQpLmODHQ=;
        b=haoiuUv6FwAVdeyp7BVc3pDAqvPC/ds02yPDw/Lpq4KFYSLid/2T8oP3DA7sI/XnNp
         bjngcL7mnMQro96+ZwOb1Gt25bxq37G4z/Ow3o6U0dzdJZjKslbNsk+zC9g7Qce0tV0u
         BzgU5+IQ3ZGQGPfxagkcalDyaPCw7MxZ8hC62nXstPdNeOEigWogCgbHn1F5PP0d8gi+
         b+oWiiRZHQW/ZFtAcJrlup+jI6vXsdVAs6VYfOH/lNmSeWyt3ukutR8MA5ibwX/IlN4L
         9woWplT7Z01+fxXDw2GJRh4M3TQcaFmmsCLk5z9SrkRBcCglOyOyo78zPoRN6fq5d04T
         Aaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pO6G2tJIWIc79GlfXyD7tYRlgpCJ3Wp5sfmQpLmODHQ=;
        b=CzHo25kjtMNlfLyN8sZfs/DkXCy1ZsXGN1TGPpYOClsAdEibezWRXieu9O2uj+FAgg
         POkIiKbRngfWXw6FztKwgjKLdjc6VrYOpW5SGEqt2mj4KNjUi/VIR/eqCqHqgRPS0YJI
         Z+0YP6HpUjbdCoGbdeUaptbXfthzDWnMnvoOyjbhJQyUELcUZwXVQ/MCYHqhjeXcTxvo
         Gi2worBLPAHjApU7r+BC+E+e7o/wkYp6duh2RcgulbWNgVzQSgGefNDJqv8WpFwn440M
         3euVQ07G3Iutylqj1rRGmIFBhZDWNn1ArrT8JKSGPjgE/QLVDZR3fUiKylwNe1mQk1c+
         MpDg==
X-Gm-Message-State: APjAAAWHWo2iLZKFZvAbqGetrGHMDQa9rEs8WfbWWtNRc8rM14iJwqnj
        xh9KMYkDfkoFUxeLuFWMROcEcemVOTE=
X-Google-Smtp-Source: APXvYqzctMiFQlYF+UvzuyviUGwwek3BnAXSR8uVLG9IR+PqW/ao+bgQWKhtNMFcd7Hc/sZBH20B8YFhEug=
X-Received: by 2002:a81:a68d:: with SMTP id d135mr2009010ywh.38.1566976544368;
 Wed, 28 Aug 2019 00:15:44 -0700 (PDT)
Date:   Wed, 28 Aug 2019 09:15:36 +0200
In-Reply-To: <20190819112207.57166-1-darekm@google.com>
Message-Id: <20190828071536.56533-1-darekm@google.com>
Mime-Version: 1.0
References: <20190819112207.57166-1-darekm@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v7.2 5/9] drm: tda998x: use cec_notifier_conn_(un)register
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

Changes since v7.1:
	- re-added if (!notifier)..
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
Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 37 ++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 61e042918a7fc..2bc4f50458137 100644
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
@@ -1347,6 +1354,17 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 	if (ret)
 		return ret;
 
+	cec_fill_conn_info_from_drm(&conn_info, connector);
+
+	notifier = cec_notifier_conn_register(priv->cec_glue.parent,
+					      NULL, &conn_info);
+	if (!notifier)
+		return -ENOMEM;
+
+	mutex_lock(&priv->cec_notify_mutex);
+	priv->cec_notify = notifier;
+	mutex_unlock(&priv->cec_notify_mutex);
+
 	drm_connector_attach_encoder(&priv->connector,
 				     priv->bridge.encoder);
 
@@ -1366,6 +1384,11 @@ static void tda998x_bridge_detach(struct drm_bridge *bridge)
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
 
+	mutex_lock(&priv->cec_notify_mutex);
+	cec_notifier_conn_unregister(priv->cec_notify);
+	priv->cec_notify = NULL;
+	mutex_unlock(&priv->cec_notify_mutex);
+
 	drm_connector_cleanup(&priv->connector);
 }
 
@@ -1789,9 +1812,6 @@ static void tda998x_destroy(struct device *dev)
 	cancel_work_sync(&priv->detect_work);
 
 	i2c_unregister_device(priv->cec);
-
-	if (priv->cec_notify)
-		cec_notifier_put(priv->cec_notify);
 }
 
 static int tda998x_create(struct device *dev)
@@ -1812,6 +1832,7 @@ static int tda998x_create(struct device *dev)
 	mutex_init(&priv->mutex);	/* protect the page access */
 	mutex_init(&priv->audio_mutex); /* protect access from audio thread */
 	mutex_init(&priv->edid_mutex);
+	mutex_init(&priv->cec_notify_mutex);
 	INIT_LIST_HEAD(&priv->bridge.list);
 	init_waitqueue_head(&priv->edid_delay_waitq);
 	timer_setup(&priv->edid_delay_timer, tda998x_edid_delay_done, 0);
@@ -1916,12 +1937,6 @@ static int tda998x_create(struct device *dev)
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
2.23.0.187.g17f5b7556c-goog

