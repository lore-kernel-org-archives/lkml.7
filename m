Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52718C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F34214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7+xZW9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfHNKqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:46:05 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:33972 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfHNKqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:46:03 -0400
Received: by mail-qt1-f202.google.com with SMTP id i1so3775926qtm.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 03:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oqxTqOJ6wCf7PGIZgAVYYI7HoO4jjy5hivlKoMqmAi8=;
        b=O7+xZW9bVaxSWLElxmDAgFZSh2+lPWcqmgSViEd8bkRDj0bp4mgJ3aKj3/JJReW7M6
         8W8L4XAfcY2PE/zXAxS2HQ6+seXxNiEQ0uDRM6mocKWiWwTtUN74Dpf+YJXhJ0Xz0xW8
         UpsEzUith0hcInJf/ShGRE4oqG8QWIdbiNAUjVFAk3TyU9U6m62E3fwx83wmmjGudsno
         0DmGq9PspzDOZFKaK+30voK1ou3xLzWx4HKHvwIngGUSEmmkZ67xQNLD/ex+PxU25Lr9
         w30JZzYLpxT5+gh/lXRWhqew3KtFUSydGxrEtLswNpHpEQv8o5DRYcyEEXqaHHr4lSOf
         c6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oqxTqOJ6wCf7PGIZgAVYYI7HoO4jjy5hivlKoMqmAi8=;
        b=rZXWhQa6/qIVoL8dVQ1xduJuJaRkR4MPfut8rwvo/d3xYwD1/fTQAk4uLITW0jIBj6
         CIiKoosBE3TuBvnsC2wLDe0Q7C48ompBzB6h1fF+O5xAQwhyJ3lc65CKIn6m3eUh/GZb
         U+3mwAo1JlYNuCTCzbM/MeRJiYqfoWJycXveHoGRROZVwIvS0nT6E9s7lj7DDmzLygbY
         8Po0W9bCwqYIe5qhX4noYlUFcB9VqO1OQ8m1MZEF+xxy0JJZDSVV3EropG9gIntYWRME
         hzmvyo+/KxHcLeVZ7J8bYl9USroHV9BuBtIG8P3LYHhtTquDLDzAbhULcT+9BmTwOMFP
         kLvg==
X-Gm-Message-State: APjAAAUTSc1SmL8rOPgC90lM0NKuZ3B5P3CBD10FUuTnnL+wDPR+zOH2
        b75PN8gTSKDPtHTfTzkMH9UoERF4ImA=
X-Google-Smtp-Source: APXvYqxndkg4Q+ED4/lezsuSHat0LDTAfINlPw7TAr+Ihx0C8cuCGXv8RYvMevn8UpDiFGyUQnXhsJKUyCk=
X-Received: by 2002:ae9:efc6:: with SMTP id d189mr36226585qkg.323.1565779561325;
 Wed, 14 Aug 2019 03:46:01 -0700 (PDT)
Date:   Wed, 14 Aug 2019 12:45:03 +0200
In-Reply-To: <20190814104520.6001-1-darekm@google.com>
Message-Id: <20190814104520.6001-6-darekm@google.com>
Mime-Version: 1.0
References: <20190814104520.6001-1-darekm@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v7 5/9] drm: tda998x: use cec_notifier_conn_(un)register
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
index 61e042918a7fc..643480415473f 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -82,6 +82,8 @@ struct tda998x_priv {
 	u8 audio_port_enable[AUDIO_ROUTE_NUM];
 	struct tda9950_glue cec_glue;
 	struct gpio_desc *calib;
+
+	struct mutex cec_notifiy_mutex;
 	struct cec_notifier *cec_notify;
 };
 
@@ -805,8 +807,11 @@ static irqreturn_t tda998x_irq_thread(int irq, void *data)
 				tda998x_edid_delay_start(priv);
 			} else {
 				schedule_work(&priv->detect_work);
-				cec_notifier_set_phys_addr(priv->cec_notify,
-						   CEC_PHYS_ADDR_INVALID);
+
+				mutex_lock(&priv->cec_notifiy_mutex);
+				cec_notifier_phys_addr_invalidate(
+						priv->cec_notify);
+				mutex_unlock(&priv->cec_notifiy_mutex);
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
+	mutex_lock(&priv->cec_notifiy_mutex);
+	priv->cec_notify = notifier;
+	mutex_unlock(&priv->cec_notifiy_mutex);
+
 	drm_connector_attach_encoder(&priv->connector,
 				     priv->bridge.encoder);
 
@@ -1366,6 +1383,11 @@ static void tda998x_bridge_detach(struct drm_bridge *bridge)
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
 
+	mutex_lock(&priv->cec_notifiy_mutex);
+	cec_notifier_conn_unregister(priv->cec_notify);
+	priv->cec_notify = NULL;
+	mutex_unlock(&priv->cec_notifiy_mutex);
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
+	mutex_init(&priv->cec_notifiy_mutex);
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

