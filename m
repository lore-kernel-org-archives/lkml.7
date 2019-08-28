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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A60C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A6822CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orHgb6Wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfH1Mec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:34:32 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:51152 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfH1Meb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:34:31 -0400
Received: by mail-pl1-f202.google.com with SMTP id d6so1438117pls.17
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vcuZObDAkuOCYj07oMJ5+M0lBgd8VRWu9mS0Y/zVm2k=;
        b=orHgb6WxVOPpUQJa7AV7skwXHJoj7ocP5kbLV3bLs837s1hC3QLb5tR2JczMVPW8Z5
         uV9YsqEHcfE4mP7hOHLq9QTTMoJQS/GxKK2cuSPnXGDhduO+i756QzEQgQ+KYtSyPiWz
         NJuT+GlrOJYsWOonDsfgp6VQrx/raQxEaw9bqEbI5NkwjBLlxBeftAFx0+D/Wb8WfdYA
         MNPPGYAYRPqxVhgu1ZdqMO6rMBX83rtuT9fVQYgVZSIKCDLmSOgWNvzhyE+4gCEwTMKb
         pdsSBkDd0BIzRLHHo7yGUBQj7koY7mhJFpWQa6hebtnWfvvPBoroDjTmrTgtYJNakCrL
         BgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vcuZObDAkuOCYj07oMJ5+M0lBgd8VRWu9mS0Y/zVm2k=;
        b=umWYay9s5ZU8OBMmPq385+npZM3Cw/rtNa7Les/KvWnTzbbszjkS+7XAmIl6UCpAxp
         mVkuDZHIbwRGQxV/RmdpJX+iY9XXJgKGgL7DuwbkSoCMXVbKgPn8A9x1G695/7fZQhra
         pqSENJlZxXVKSuDDSo3JSMr+OfhP0IUiNIyE9113jX13XQsng4FynYSIQy7kr/hxtzFI
         pW4hv1u73vTRYd2wWvZ3I69SiUVUOZENK4V46zWy4EPdB8rXWqSWnWutJbn84ve5EXVE
         jqw0GPYwEBF341HHzEyLwaIBtoMDbcPHT7Nha/PjY9Y6OWBcaKIp57QuXwh8REjzFJ4V
         Ct3A==
X-Gm-Message-State: APjAAAVtO9kc310lg8rb2MILMng0NmoV/B9fuzNWKbAbFdlLtRSritux
        Vo0zP5MDSXQgmXzmabXgUxeombI+Zrc=
X-Google-Smtp-Source: APXvYqyOkm6XgZveoTQaYc4eySICPXxgwPwfdul/8FC+b3wW2pkjrEXEhwTmCgbY9Bk5HzW3EkMZpZeNt4I=
X-Received: by 2002:a63:124a:: with SMTP id 10mr3234116pgs.254.1566995670700;
 Wed, 28 Aug 2019 05:34:30 -0700 (PDT)
Date:   Wed, 28 Aug 2019 14:34:15 +0200
In-Reply-To: <6bbfb6f8-15c2-9ad2-8857-898f4c6435a3@samsung.com>
Message-Id: <20190828123415.139441-1-darekm@google.com>
Mime-Version: 1.0
References: <6bbfb6f8-15c2-9ad2-8857-898f4c6435a3@samsung.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v7.1 9/9] drm: exynos: exynos_hdmi: use cec_notifier_conn_(un)register
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        s.nawrocki@samsung.com, hverkuil-cisco@xs4all.nl
Cc:     Dariusz Marcinkiewicz <darekm@google.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new cec_notifier_conn_(un)register() functions to
(un)register the notifier for the HDMI connector, and fill in
the cec_connector_info.

Changes since v7:
	- err_runtime_disable -> err_rpm_disable
Changes since v2:
	- removed unnecessary call to invalidate phys address before
	deregistering the notifier,
	- use cec_notifier_phys_addr_invalidate instead of setting
	invalid address on a notifier.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 31 ++++++++++++++++------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index bc1565f1822ab..799f2db13efe2 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -852,6 +852,10 @@ static enum drm_connector_status hdmi_detect(struct drm_connector *connector,
 
 static void hdmi_connector_destroy(struct drm_connector *connector)
 {
+	struct hdmi_context *hdata = connector_to_hdmi(connector);
+
+	cec_notifier_conn_unregister(hdata->notifier);
+
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 }
@@ -935,6 +939,7 @@ static int hdmi_create_connector(struct drm_encoder *encoder)
 {
 	struct hdmi_context *hdata = encoder_to_hdmi(encoder);
 	struct drm_connector *connector = &hdata->connector;
+	struct cec_connector_info conn_info;
 	int ret;
 
 	connector->interlace_allowed = true;
@@ -957,6 +962,15 @@ static int hdmi_create_connector(struct drm_encoder *encoder)
 			DRM_DEV_ERROR(hdata->dev, "Failed to attach bridge\n");
 	}
 
+	cec_fill_conn_info_from_drm(&conn_info, connector);
+
+	hdata->notifier = cec_notifier_conn_register(hdata->dev, NULL,
+						     &conn_info);
+	if (hdata->notifier == NULL) {
+		ret = -ENOMEM;
+		DRM_DEV_ERROR(hdata->dev, "Failed to allocate CEC notifier\n");
+	}
+
 	return ret;
 }
 
@@ -1528,8 +1542,8 @@ static void hdmi_disable(struct drm_encoder *encoder)
 		 */
 		mutex_unlock(&hdata->mutex);
 		cancel_delayed_work(&hdata->hotplug_work);
-		cec_notifier_set_phys_addr(hdata->notifier,
-					   CEC_PHYS_ADDR_INVALID);
+		if (hdata->notifier)
+			cec_notifier_phys_addr_invalidate(hdata->notifier);
 		return;
 	}
 
@@ -2006,12 +2020,6 @@ static int hdmi_probe(struct platform_device *pdev)
 		}
 	}
 
-	hdata->notifier = cec_notifier_get(&pdev->dev);
-	if (hdata->notifier == NULL) {
-		ret = -ENOMEM;
-		goto err_hdmiphy;
-	}
-
 	pm_runtime_enable(dev);
 
 	audio_infoframe = &hdata->audio.infoframe;
@@ -2023,7 +2031,7 @@ static int hdmi_probe(struct platform_device *pdev)
 
 	ret = hdmi_register_audio_device(hdata);
 	if (ret)
-		goto err_notifier_put;
+		goto err_rpm_disable;
 
 	ret = component_add(&pdev->dev, &hdmi_component_ops);
 	if (ret)
@@ -2034,8 +2042,7 @@ static int hdmi_probe(struct platform_device *pdev)
 err_unregister_audio:
 	platform_device_unregister(hdata->audio.pdev);
 
-err_notifier_put:
-	cec_notifier_put(hdata->notifier);
+err_rpm_disable:
 	pm_runtime_disable(dev);
 
 err_hdmiphy:
@@ -2054,12 +2061,10 @@ static int hdmi_remove(struct platform_device *pdev)
 	struct hdmi_context *hdata = platform_get_drvdata(pdev);
 
 	cancel_delayed_work_sync(&hdata->hotplug_work);
-	cec_notifier_set_phys_addr(hdata->notifier, CEC_PHYS_ADDR_INVALID);
 
 	component_del(&pdev->dev, &hdmi_component_ops);
 	platform_device_unregister(hdata->audio.pdev);
 
-	cec_notifier_put(hdata->notifier);
 	pm_runtime_disable(&pdev->dev);
 
 	if (!IS_ERR(hdata->reg_hdmi_en))
-- 
2.23.0.187.g17f5b7556c-goog

