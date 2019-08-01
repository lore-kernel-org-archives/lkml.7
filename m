Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAB3C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDE1218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5VbWHzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfHADpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33862 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbfHADpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so31518079plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zuYtIfU+UT/PNXXXBYUFuMDBxtjn9glQQrqM7vGxjYE=;
        b=a5VbWHzEBLlu3fIz+fCVmCe94QAY4LsuQSJPED6ssrg/nwTK/5Mt/n4elQQgHSmiar
         Oet4P6qsMMOv9o+cf6wahhatHdyJDKzPhGlfGyZa9qy9qm4g4E2RyvLb7IKMC8Ax5Cs0
         FB7IrETlv2TW5rn7rxJt3xsY/T0g7K245ivpcEvRzhPvtmY7N6shhLGFQhBAWPS/PdX0
         iWPQLutk2shT0xcDZUWDf4PeMGQ76Sv2gbz0zylYt4LDmeUSTgkgO+WUBe/+IJZuL3SZ
         c3gJKLsURrOdoIppdcUQ8XQwk9Mg1mNaK7DoJfxUxWdQdecQ9UhzKQcgRneFo5biIsye
         Olpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zuYtIfU+UT/PNXXXBYUFuMDBxtjn9glQQrqM7vGxjYE=;
        b=tvkMVtHVdK2CTZRcsSCeG9QLmMyrYeCayaWccDf3HkqDnRaajTOLroRegzHoBsnUo+
         7xN4cZD8cJjh6UT2eaJ/WjkRnMa+ZwweNzb1ohdfLm7nVN8C1nW9oVdipD2R1hmN+62r
         nNmhJej/07l18zI0AHAc5fZLmtEXMqPwBy0tixhEMocD1VxxVC0H/isJnFtV9zjrC467
         i/8r5NVRCsijt13WnhA+uCy8NSxjB2TVEcy07LgJUSzkwldjkR2RgO4tiMiqhoOWGGgd
         AezuXz7Slfv7SJZfCqAv8wPgVHLWGDSm94DowMYyH89wI8nKz8KOapc8lV8njv7yEMGW
         cepw==
X-Gm-Message-State: APjAAAW5HQ441sfQAtKGpGpYpnvFJLfuxxri0lUmKLezBk2dEoET/1DR
        8a7hYCbPUdAh5u2pSRmIR5ChqVyzFZY=
X-Google-Smtp-Source: APXvYqwB4SrO/uHgu51bOWy2W68HjOxGfBkUOryPOB8eQxWuCtrE3RRTyK8dT+4vf/lBmWbGaodg1w==
X-Received: by 2002:a17:902:6b02:: with SMTP id o2mr69099475plk.99.1564631116882;
        Wed, 31 Jul 2019 20:45:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:16 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 20/26] drm: kirin: Add register connect helper functions in drm init
Date:   Thu,  1 Aug 2019 03:44:33 +0000
Message-Id: <20190801034439.98227-21-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch adds a flag to the
device specific driver data so that we can conditionally
register the connectors at init.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   |  1 +
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 43 +++++++++++++++++++
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  1 +
 3 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 0bc2e538913b..66434c0cce6e 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -1076,6 +1076,7 @@ static struct drm_driver ade_driver = {
 };
 
 struct kirin_drm_data ade_driver_data = {
+	.register_connects = false,
 	.num_planes = ADE_CH_NUM,
 	.prim_plane = ADE_CH1,
 	.channel_formats = channel_formats,
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 296661ba300f..1c9658e9565e 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -97,6 +97,40 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
+static int kirin_drm_connectors_register(struct drm_device *dev)
+{
+	struct drm_connector *connector;
+	struct drm_connector *failed_connector;
+	struct drm_connector_list_iter conn_iter;
+	int ret;
+
+	mutex_lock(&dev->mode_config.mutex);
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		ret = drm_connector_register(connector);
+		if (ret) {
+			failed_connector = connector;
+			goto err;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+	mutex_unlock(&dev->mode_config.mutex);
+
+	return 0;
+
+err:
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (failed_connector == connector)
+			break;
+		drm_connector_unregister(connector);
+	}
+	drm_connector_list_iter_end(&conn_iter);
+	mutex_unlock(&dev->mode_config.mutex);
+
+	return ret;
+}
+
 static int kirin_drm_bind(struct device *dev)
 {
 	struct drm_device *drm_dev;
@@ -116,8 +150,17 @@ static int kirin_drm_bind(struct device *dev)
 
 	drm_fbdev_generic_setup(drm_dev, 32);
 
+	/* connectors should be registered after drm device register */
+	if (driver_data->register_connects == true) {
+		ret = kirin_drm_connectors_register(drm_dev);
+		if (ret)
+			goto err_drm_dev_unregister;
+	}
+
 	return 0;
 
+err_drm_dev_unregister:
+	drm_dev_unregister(drm_dev);
 err_kms_cleanup:
 	kirin_drm_kms_cleanup(drm_dev);
 err_drm_dev_put:
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index fdbfc4a90f22..95f56c9960d5 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -39,6 +39,7 @@ struct kirin_drm_data {
 	u32 channel_formats_cnt;
 	int config_max_width;
 	int config_max_height;
+	bool register_connects;
 	u32 num_planes;
 	u32 prim_plane;
 
-- 
2.17.1

