Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02E5C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B65C218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7nqhQ4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfDWXWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:22:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43542 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfDWXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so8244354plp.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LzxumMzcEtq/SNQTqskpd8l6h66SMPqIvO/SUnJJpKM=;
        b=K7nqhQ4oUzp+oLLua5HKg230xAqYILqx/7xXmGUjCnyj9D5AAhdGD+GNp3T8DMLrzl
         ph04wV1JpRAB90Sbx4IYwihZte0cxfMdYvm9Fisf8m/gOj92AuoBWwzExFK+5os+EUfk
         p3NXmrbKmHB5VMw6K6aAALPCKQjV4jvoyRGw0l/Tu1sujuXX3UeHto5WaeKkrQ/dbR6I
         aUuqqVWvIlTUKuONfHdYSFKflXOtOUYxkoJXY2vNpMiZVPSoLKHZajYF5AciTpQuNXmK
         Zps1LUzTEICkOweLOfLhBidUtU0IsK0kjPaH3ath5NrX6sGAmsAJG/ptOpFWrZi50I08
         0mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LzxumMzcEtq/SNQTqskpd8l6h66SMPqIvO/SUnJJpKM=;
        b=itwDiXuTOpHfA1AxmThtbutJOVqCKCVfR2p3vPiBbFDqNVikHA8MUSvjIyu+xuIkcZ
         q+MaxfF9iGZVEb6yI/USddqkxj0yI8IasLSBgXaDIsmcjdr2X/mt3J2qzIWr4ONjJcvf
         hFkNruyD7SvQW8dPQ36XUvLvFf9FCOpQpFKMcpU3olq4NE+FmJgQ8xUvlBI1lvIRYiPb
         p3tiocHxvSvcxyCGId0nOBBHSftw/IoqnC8utRkZddWVFF/LRMFhmQfbniZ+uXGrcE0W
         jyTvRmxCT/tL1DywOKd7hh4RPN2mWrM2yVq/DDQ+expdKNYT7ZmXwi7/OIE/VA2YGGGG
         wJhQ==
X-Gm-Message-State: APjAAAWpnemM6TmptFYCBH9+3Y74Q6RPbteMAU/uR4lsdbucZuQzr5Bv
        ckPi/6wResvRUIMnPUJ7l0wvRUj74tE=
X-Google-Smtp-Source: APXvYqzCahw17URM7uPDNgnjEJPFq7bbhmKrHgotw8tL24qZ6Ookm3NHOl1b3VFuO++uU1km6VLpmg==
X-Received: by 2002:a17:902:7085:: with SMTP id z5mr18996294plk.78.1556061687689;
        Tue, 23 Apr 2019 16:21:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:26 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 19/25] drm: kirin: Add register connect helper functions in drm init
Date:   Tue, 23 Apr 2019 16:20:50 -0700
Message-Id: <1556061656-1733-20-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch adds a flag to the
device specific driver data so that we can conditionally
register the connectors at init.

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c |  1 +
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 43 +++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  1 +
 3 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index bdd1b00..fcc01c2 100644
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
index c987b4e..5ee90d7 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -99,6 +99,40 @@ static int compare_of(struct device *dev, void *data)
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
@@ -118,8 +152,17 @@ static int kirin_drm_bind(struct device *dev)
 
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
index 61fb0da..8818ccf 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -43,6 +43,7 @@ struct kirin_drm_data {
 	u32 channel_formats_cnt;
 	int config_max_width;
 	int config_max_height;
+	bool register_connects;
 	u32 num_planes;
 	u32 prim_plane;
 
-- 
2.7.4

