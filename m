Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A008C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CAC22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zdBI9UDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfHSXD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:03:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45977 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbfHSXD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so2069899pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RlVlGQamgcAhiognZlubIHGBBs3LgzzJ7vr3338hUrk=;
        b=zdBI9UDVng410qTgKzO177OK6M21SecuCMx5uW9MNvjhW524TFUeB9k9c5w0mZVy5U
         zLP0V/VnGsYqFONggfKgNzdVZxAxkd/KeOgKUGNaPZPYUCKaqTjCch9AUcoRpasoh7rW
         fpm7qeGXfif9V3pT/mK1bncOkPBlBjvmNypsIub3KZLHRDum8pO4lkRT0boZsgu+892S
         s3c936HBiT31uDogoYO+7N106UbmGnM+OtLriLAoWGPcUTHkvGKlfKjqSrIgyA0gSgto
         bSyo+rJFJNC8lj1L8HTFRqjL5uQ1IRdqoljPPCI7T57ph2sby0L4ufwZn5YDetRzjeHN
         i5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RlVlGQamgcAhiognZlubIHGBBs3LgzzJ7vr3338hUrk=;
        b=gWtw+LlblKt6dqtqjLmZ20fzMR3i/3c52aVBg70zWSw+vksTMNxGZXch0bZmDWASpE
         WZZVPPBWH4dZ8czuOtE2pT3vXZB1mynrsvvPIjkCp7g8isoLLMlk7eFm0eE5t1GeEz25
         GDQjRWmUcF3vmnQhgf6UFdZH05BuJGMVsCemn0Dt/pMPhMf//Wr6TrqZE4PfA745Wdzc
         RNcfb40JAGG+NzA7+SD18teYZpU42Hf/IIS4KF0ZGLEnfIiyUtA3irbkxHssmGMGQ1hD
         HX9RhmODQtRk+urSh+/NRUjDw65umrBv2QzG5v4iar2REfGCucngzLa2JnriBbQLDSvQ
         WEwA==
X-Gm-Message-State: APjAAAXmrEmuNtpFL3/4WXtUEisFFyASWEXKM18uPy2cqX8l8u6KPy3o
        kPuywT+1/iLDfI5ZXF3O7oS307roYyo=
X-Google-Smtp-Source: APXvYqxgtMpYoYvVT9ZumvlGfO9xbaETlj7Ui2wQmQ0ja3JkQLNInjiOWTTXhPfGdrNZz41LMKTe+w==
X-Received: by 2002:a65:68c9:: with SMTP id k9mr21640940pgt.17.1566255834582;
        Mon, 19 Aug 2019 16:03:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:53 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v4 19/25] drm: kirin: Add register connect helper functions in drm init
Date:   Mon, 19 Aug 2019 23:03:15 +0000
Message-Id: <20190819230321.56480-20-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
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
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
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
index 7db2cf93a245..5f39249fd83e 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -1073,6 +1073,7 @@ static struct drm_driver ade_driver = {
 };
 
 struct kirin_drm_data ade_driver_data = {
+	.register_connects = false,
 	.num_planes = ADE_CH_NUM,
 	.prim_plane = ADE_CH1,
 	.channel_formats = channel_formats,
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index c9faaa848cc6..f92b3f7de5c0 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -98,6 +98,40 @@ static int compare_of(struct device *dev, void *data)
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
@@ -117,8 +151,17 @@ static int kirin_drm_bind(struct device *dev)
 
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

