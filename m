Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B16C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5602341C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckmC6bHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfHTXH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:07:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41891 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfHTXG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so85655pfz.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=snb+417mkIMijis5gqdevRgXi5CVEc/HJIJZWNwpKg4=;
        b=ckmC6bHO8Kbn1CHlkCqw7uMa48JTuuzH2nyUAHB1uDRaO0HUittmeTKLjRL0mTNEcy
         lubKDnkDdpPxOQ/Ua9bx/0M77HH0xP0TbZxIGkOdUgKpk3/2VC3U/RlG9jrdMLe3HBPL
         /ufFGRVWEQb41zCT1YnIk41YzfHkCnZ5leAuMjMdjHxzeMAebw6HwxJ49mvpod07sywX
         t7UIxQDlrlNuS/DVY7IjsbG19IzhsJ+dwbzFx41/yrW9F3sOpS9pbHFo5q7ONbgurGj4
         z56oCcreOzy1X0wR/2dZ2ERY0AfVh28rQRfwSsv4IHENeCN7W7hq7UAYt+z50QjE7sEp
         cLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=snb+417mkIMijis5gqdevRgXi5CVEc/HJIJZWNwpKg4=;
        b=ibX8nk8+QP27hwwBpsT76dTS7vK6zLucgZQClRxO+Gu+yUaxZbzE/JdO3RR78XQ7hg
         6a07tATYIWL/Rft2Mu42CiwbpGguHK+3+N8vC1FjaQcACZp+tgt2xigKGq9LekrpxByc
         ZTlyRehTXvYuPKCwjyPfSyzoo0iRXCEEWg1bwSNNdJMOW9uWTWQ8b4dJUppbd5Ysz9cj
         cDvZMMXbq0p3OAh736ribcoynEG2DjgCo9Oup8ejz2thmLCTNJEzq8JCPcTEZR5ow+KS
         VyVB0hUQZAIPZW6xjI0mkFEBfq+IX9mg2lffk3DNUPIKJKWjjRRuswIp1N1eFddr9Q4e
         VKog==
X-Gm-Message-State: APjAAAVWEPBjw0cyu6HJEqT3RrhVt2Y97LjUgEwC6rdf5Fky4xieRjsM
        dwXZT+yVihCv6riwfcwBgtzc6zpXmuQ=
X-Google-Smtp-Source: APXvYqwY4EfPryJEWWvkuEZzRawoYOjYmi1jU1CLX9i5qMq4MfYDgepzGUiPR7bgjFNv9hEGkySf8A==
X-Received: by 2002:a63:3006:: with SMTP id w6mr27037577pgw.440.1566342418741;
        Tue, 20 Aug 2019 16:06:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:58 -0700 (PDT)
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
Subject: [PATCH v5 19/25] drm: kirin: Add register connect helper functions in drm init
Date:   Tue, 20 Aug 2019 23:06:20 +0000
Message-Id: <20190820230626.23253-20-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
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
v5: checkpatch --strict whitespace fixups noticed by Sam
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   |  1 +
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 43 +++++++++++++++++++
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  1 +
 3 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 21c5d457a97d..89bdc0388138 100644
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
index c9faaa848cc6..68de8838da3c 100644
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
+	if (driver_data->register_connects) {
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

