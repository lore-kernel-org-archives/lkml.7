Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E421AC04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55A62087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ze8Tkxqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfEPOAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:00:45 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:56452 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbfEPOAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:00:45 -0400
Received: by mail-yb1-f201.google.com with SMTP id d10so2825288ybn.23
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0W2BzNydBRd7QhaGcoJcvGTU7rmnrCYSV56xvl6bzSI=;
        b=Ze8Tkxqk0wx23S6A7duvigoJPnTj7PRU02KReczZHeQEeF4mhN+1JFLjXiyvLc2uOo
         K0L+nHK5dIoAKUezZbvHDmZnHd+p6BSfo3sxFUUDRPLhx7bGncD/pjOwb6QUbv3cOkrz
         6XAnncWcjHlIqBY2nP9hXLzj6HRzvCXZ1rqLPMOOiILRHvPR31uRLrrzVKF1z2TIyd11
         hZxLUK3tJaLFX5RY0W09ISXDy3pMLKE/YAfHuFt+uSHeEadW1GSRIWNTjmuAUFgtg1Cr
         XqKADFQcLIDucjHgE9sQapJlUwjh8H94yZ47pbLaCYqCr7ovB9TM7TxNCAKRcY46qx47
         hBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0W2BzNydBRd7QhaGcoJcvGTU7rmnrCYSV56xvl6bzSI=;
        b=P2YUj0F2RnV+br7kM0Z/fx9YAl/cQpzE3//Uvh7+Rqf4cYmbZOtwlEBxpD6VRIDR8C
         MaGUjzBCPtOiiEOj3nvWIMZY/OvD2FZg9+xT/f78GYGojQ+R8rmvl2Ii92bEb9mh/pJD
         pYlls88pxdmcIvngOt7VxTM7SppX9qnEUygYlo0QAz7CtwGwltRk3LjDXtq/sqvZ87kV
         Vv7zNjL6eQrZzHUn5H3ZucMOyhzeG6Xay8OMl8QSLaaF+M2HQxpqmkzUANN6BNDmrXsq
         DHRQB15HzrV366mACJDaIBaSb1Tqc45d/yWoZzXObARrPm2pol4WbnJr7Sbi7fycZUBy
         O/BA==
X-Gm-Message-State: APjAAAXKCxZHUg5N7FyT/7Npmyfb35CYafVvX/QR0SSCKn2oNRUaKxki
        HgBGMj+kqkJlC/3RPTfHlP5R7iQbyDQ=
X-Google-Smtp-Source: APXvYqylyCuEAoh/IO80hPvL85QhJypPrPpWyzFZNNCr4o4QOYuBtPRskXjvQaK6dQzj824TNXBcM630WdM=
X-Received: by 2002:a81:2717:: with SMTP id n23mr25197449ywn.511.1558015244107;
 Thu, 16 May 2019 07:00:44 -0700 (PDT)
Date:   Thu, 16 May 2019 16:00:20 +0200
In-Reply-To: <20190516140020.200105-1-darekm@google.com>
Message-Id: <20190516140020.200105-3-darekm@google.com>
Mime-Version: 1.0
References: <20190516140020.200105-1-darekm@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v5 3/3] drm/i2c: tda9950: pass HDMI connector info to CEC adapter
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     linux-media@vger.kernel.org, hans.verkuil@cisco.com,
        hverkuil@xs4all.nl
Cc:     linux-kernel@vger.kernel.org,
        Dariusz Marcinkiewicz <darekm@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With that change tda998x provides a connector info to the CEC
adapter. In order to be able to that it delays creation of
respective CEC device until the DRM connector is initialized.

Requires testing.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
---
 drivers/gpu/drm/i2c/tda9950.c         |  7 ++++-
 drivers/gpu/drm/i2c/tda998x_drv.c     | 41 +++++++++++++--------------
 include/linux/platform_data/tda9950.h |  2 ++
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/i2c/tda9950.c
index b944dd9df85e1..2778a0015cc31 100644
--- a/drivers/gpu/drm/i2c/tda9950.c
+++ b/drivers/gpu/drm/i2c/tda9950.c
@@ -382,6 +382,7 @@ static int tda9950_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct tda9950_glue *glue = client->dev.platform_data;
+	struct cec_connector_info conn_info;
 	struct device *dev = &client->dev;
 	struct tda9950_priv *priv;
 	unsigned long irqflags;
@@ -422,10 +423,14 @@ static int tda9950_probe(struct i2c_client *client,
 	if (glue && glue->parent)
 		priv->hdmi = glue->parent;
 
+	memset(&conn_info, 0, sizeof(conn_info));
+	if (glue)
+		cec_fill_connector_info(&conn_info, glue->connector);
+
 	priv->adap = cec_allocate_adapter(&tda9950_cec_ops, priv, "tda9950",
 					  CEC_CAP_DEFAULTS,
 					  CEC_MAX_LOG_ADDRS,
-					  NULL);
+					  &conn_info);
 	if (IS_ERR(priv->adap))
 		return PTR_ERR(priv->adap);
 
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 7f34601bb5155..ef2aa3134b387 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1253,6 +1253,7 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 				  struct drm_device *drm)
 {
 	struct drm_connector *connector = &priv->connector;
+	struct i2c_board_info cec_info;
 	int ret;
 
 	connector->interlace_allowed = 1;
@@ -1269,6 +1270,24 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 	if (ret)
 		return ret;
 
+	/*
+	 * Some TDA998x are actually two I2C devices merged onto one piece
+	 * of silicon: TDA9989 and TDA19989 combine the HDMI transmitter
+	 * with a slightly modified TDA9950 CEC device.  The CEC device
+	 * is at the TDA9950 address, with the address pins strapped across
+	 * to the TDA998x address pins.  Hence, it always has the same
+	 * offset.
+	 */
+	memset(&cec_info, 0, sizeof(cec_info));
+	strlcpy(cec_info.type, "tda9950", sizeof(cec_info.type));
+	cec_info.addr = priv->cec_addr;
+	cec_info.platform_data = &priv->cec_glue;
+	cec_info.irq = priv->hdmi->irq;
+
+	priv->cec = i2c_new_device(priv->hdmi->adapter, &cec_info);
+	if (!priv->cec)
+		return -ENODEV;
+
 	drm_connector_attach_encoder(&priv->connector,
 				     priv->bridge.encoder);
 
@@ -1658,7 +1677,6 @@ static int tda998x_create(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct device_node *np = client->dev.of_node;
-	struct i2c_board_info cec_info;
 	struct tda998x_priv *priv;
 	u32 video;
 	int rev_lo, rev_hi, ret;
@@ -1783,32 +1801,13 @@ static int tda998x_create(struct device *dev)
 	}
 
 	priv->cec_glue.parent = dev;
+	priv->cec_glue.connector = &priv->connector;
 	priv->cec_glue.data = priv;
 	priv->cec_glue.init = tda998x_cec_hook_init;
 	priv->cec_glue.exit = tda998x_cec_hook_exit;
 	priv->cec_glue.open = tda998x_cec_hook_open;
 	priv->cec_glue.release = tda998x_cec_hook_release;
 
-	/*
-	 * Some TDA998x are actually two I2C devices merged onto one piece
-	 * of silicon: TDA9989 and TDA19989 combine the HDMI transmitter
-	 * with a slightly modified TDA9950 CEC device.  The CEC device
-	 * is at the TDA9950 address, with the address pins strapped across
-	 * to the TDA998x address pins.  Hence, it always has the same
-	 * offset.
-	 */
-	memset(&cec_info, 0, sizeof(cec_info));
-	strlcpy(cec_info.type, "tda9950", sizeof(cec_info.type));
-	cec_info.addr = priv->cec_addr;
-	cec_info.platform_data = &priv->cec_glue;
-	cec_info.irq = client->irq;
-
-	priv->cec = i2c_new_device(client->adapter, &cec_info);
-	if (!priv->cec) {
-		ret = -ENODEV;
-		goto fail;
-	}
-
 	/* enable EDID read irq: */
 	reg_set(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
 
diff --git a/include/linux/platform_data/tda9950.h b/include/linux/platform_data/tda9950.h
index c65efd461102e..7e6893bad03a2 100644
--- a/include/linux/platform_data/tda9950.h
+++ b/include/linux/platform_data/tda9950.h
@@ -2,10 +2,12 @@
 #define LINUX_PLATFORM_DATA_TDA9950_H
 
 struct device;
+struct drm_connector;
 
 struct tda9950_glue {
 	struct device *parent;
 	unsigned long irq_flags;
+	const struct drm_connector *connector;
 	void *data;
 	int (*init)(void *);
 	void (*exit)(void *);
-- 
2.18.1

